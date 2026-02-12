const express = require('express');
const router = express.Router();
const db = require('../config/database');
const { authenticateToken, isAdmin } = require('../middleware/auth');
const { logActivityFromRequest } = require('../utils/auditLogger');
const { notifyAdmins, notifyUser, emitTicketUpdate } = require('../utils/socketManager');

const validateTicketInput = (title, description) =>
  !title || !description ? 'Titolo e descrizione sono obbligatori' :
    title.length > 120 ? 'Il titolo non può superare 120 caratteri' :
      description.length > 2000 ? 'La descrizione non può superare 2000 caratteri' : null;

router.post('/', authenticateToken, async (req, res) => {
  try {
    const { title, description, ticket_type } = req.body;
    const validationError = validateTicketInput(title, description);

    if (validationError) return res.status(400).json({ error: validationError });
    if (!ticket_type) return res.status(400).json({ error: 'Tipo ticket è obbligatorio' });

    // Create ticket using Stored Procedure
    const [result] = await db.query(
      'CALL sp_create_ticket(?, ?, ?, ?, @ticketId)',
      [req.user.id, ticket_type, title, description]
    );
    const [selectResult] = await db.query('SELECT @ticketId as ticketId');
    const ticketId = selectResult[0].ticketId;

    if (!ticketId) {
      return res.status(400).json({ error: 'Tipo ticket non valido o errore durante la creazione' });
    }

    await logActivityFromRequest(req, {
      userId: req.user.id,
      action: 'TICKET_CREATED',
      entityType: 'TICKET',
      entityId: ticketId,
      description: `Ticket creato: "${title}"`,
      metadata: { title, ticket_type, creator: req.user.username }
    });

    // Send notification to admins
    notifyAdmins({
      type: 'new_ticket',
      message: `Nuovo ticket creato da ${req.user.username}`,
      title: title,
      ticketId: ticketId,
      creator: req.user.username
    });

    // Emit update event to refresh admin ticket list
    emitTicketUpdate('admins');

    res.status(201).json({ message: 'Ticket creato con successo', ticket_id: ticketId });
  } catch (error) {
    console.error('Errore creazione ticket:', error);
    res.status(500).json({ error: 'Errore durante la creazione del ticket' });
  }
});

router.get('/', authenticateToken, async (req, res) => {
  try {
    const isAdminUser = req.user.user_type_code === 'ADMIN';
    const { search, status, type } = req.query;

    // Get tickets using Stored Procedure
    const [tickets] = await db.query(
      'CALL sp_get_tickets(?, ?, ?, ?, ?)',
      [req.user.id, search || null, status || null, type || null, isAdminUser]
    );
    res.json(tickets[0]);
  } catch (error) {
    console.error('Errore recupero tickets:', error);
    res.status(500).json({ error: 'Errore durante il recupero dei ticket' });
  }
});

router.get('/:id', authenticateToken, async (req, res) => {
  try {
    const ticketId = parseInt(req.params.id);
    if (isNaN(ticketId)) return res.status(400).json({ error: 'ID ticket non valido' });

    // Get ticket details using Stored Procedure
    const [accessCheckResults] = await db.query('CALL sp_check_ticket_access(?)', [ticketId]);
    const tickets = accessCheckResults[0];

    if (tickets.length === 0) return res.status(404).json({ error: 'Ticket non trovato' });
    const ticket = tickets[0];

    if (req.user.user_type_code !== 'ADMIN' && ticket.user_id !== req.user.id) {
      return res.status(403).json({ error: 'Non autorizzato ad accedere a questo ticket' });
    }

    const [messageResults] = await db.query('CALL sp_get_ticket_messages(?)', [ticketId]);
    const messages = messageResults[0];

    ticket.messages = messages;
    res.json(ticket);
  } catch (error) {
    console.error('Errore recupero ticket:', error);
    res.status(500).json({ error: 'Errore durante il recupero del ticket' });
  }
});

router.patch('/:id', authenticateToken, async (req, res) => {
  try {
    const ticketId = parseInt(req.params.id);
    const { title, description } = req.body;
    const validationError = validateTicketInput(title, description);

    if (isNaN(ticketId)) return res.status(400).json({ error: 'ID ticket non valido' });
    if (validationError) return res.status(400).json({ error: validationError });

    const [accessCheckResults] = await db.query('CALL sp_check_ticket_access(?)', [ticketId]);
    const tickets = accessCheckResults[0];
    if (tickets.length === 0) return res.status(404).json({ error: 'Ticket non trovato' });

    const ticket = tickets[0];
    if (ticket.user_id !== req.user.id) return res.status(403).json({ error: 'Non autorizzato a modificare questo ticket' });
    if (ticket.status !== 'OPEN') return res.status(400).json({ error: 'Puoi modificare solo ticket aperti' });

    await db.query('UPDATE ticket SET title = ?, description = ? WHERE id = ?', [title, description, ticketId]);

    await logActivityFromRequest(req, {
      userId: req.user.id,
      action: 'TICKET_UPDATED',
      entityType: 'TICKET',
      entityId: ticketId,
      description: `Ticket modificato: "${title}"`,
      metadata: { old_title: ticket.title, new_title: title, updated_by: req.user.username }
    });

    res.json({ message: 'Ticket aggiornato con successo' });
  } catch (error) {
    console.error('Errore aggiornamento ticket:', error);
    res.status(500).json({ error: 'Errore durante l\'aggiornamento del ticket' });
  }
});

router.patch('/:id/status', authenticateToken, isAdmin, async (req, res) => {
  try {
    const ticketId = parseInt(req.params.id);
    const { status } = req.body;

    if (isNaN(ticketId)) return res.status(400).json({ error: 'ID ticket non valido' });
    if (!status) return res.status(400).json({ error: 'Status è obbligatorio' });
    if (!['OPEN', 'IN_PROGRESS', 'CLOSED'].includes(status)) return res.status(400).json({ error: 'Status non valido' });

    const [accessCheckResults] = await db.query('CALL sp_check_ticket_access(?)', [ticketId]);
    const tickets = accessCheckResults[0];
    // Rename status to current_status to match expected logic below
    if (tickets.length > 0) tickets[0].current_status = tickets[0].status;
    if (tickets.length === 0) return res.status(404).json({ error: 'Ticket non trovato' });

    const ticket = tickets[0];
    const oldStatus = ticket.current_status;

    // Update status using Stored Procedure
    await db.query('CALL sp_update_ticket_status(?, ?)', [ticketId, status]);

    /* Previous logic for reference:
    const [statuses] = await db.query('SELECT id FROM ticket_status WHERE code = ?', [status]);
    await db.query('UPDATE ticket SET ticket_status_id = ? WHERE id = ?', [statuses[0].id, ticketId]);
    */

    await logActivityFromRequest(req, {
      userId: req.user.id,
      action: 'TICKET_STATUS_CHANGED',
      entityType: 'TICKET',
      entityId: ticketId,
      description: `Status ticket modificato: "${ticket.title}" (${oldStatus} → ${status})`,
      metadata: { ticket_id: ticketId, old_status: oldStatus, new_status: status, changed_by: req.user.username }
    });

    // Get status description for notification
    // Status description is handled in UI or could be fetched via SP, keeping simple for now
    const statusDescription = status;

    // Send notification to ticket creator
    notifyUser(ticket.user_id, {
      type: 'status_changed',
      message: `Lo status del tuo ticket "${ticket.title}" è stato modificato`,
      title: ticket.title,
      ticketId: ticketId,
      oldStatus: oldStatus,
      newStatus: status,
      newStatusDescription: statusDescription
    });

    // Emit update event to refresh ticket lists
    emitTicketUpdate(`user_${ticket.user_id}`);
    emitTicketUpdate('admins');

    res.json({ message: 'Status aggiornato con successo' });
  } catch (error) {
    console.error('Errore aggiornamento status:', error);
    res.status(500).json({ error: 'Errore durante l\'aggiornamento dello status' });
  }
});

router.get('/:id/messages', authenticateToken, async (req, res) => {
  try {
    const ticketId = parseInt(req.params.id);
    if (isNaN(ticketId)) return res.status(400).json({ error: 'ID ticket non valido' });

    // Check if user has access to this ticket
    const [accessCheckResults] = await db.query('CALL sp_check_ticket_access(?)', [ticketId]);
    const tickets = accessCheckResults[0];
    if (tickets.length === 0) return res.status(404).json({ error: 'Ticket non trovato' });

    const ticket = tickets[0];
    if (req.user.user_type_code !== 'ADMIN' && ticket.user_id !== req.user.id) {
      return res.status(403).json({ error: 'Non autorizzato ad accedere a questo ticket' });
    }

    // Load messages using Stored Procedure
    const [messageResults] = await db.query('CALL sp_get_ticket_messages(?)', [ticketId]);
    const messages = messageResults[0]; // SP returns results in the first array element

    res.json(messages);
  } catch (error) {
    console.error('Errore recupero messaggi:', error);
    res.status(500).json({ error: 'Errore durante il recupero dei messaggi' });
  }
});

router.post('/:id/messages', authenticateToken, isAdmin, async (req, res) => {
  try {
    const ticketId = parseInt(req.params.id);
    const { message } = req.body;

    if (isNaN(ticketId)) return res.status(400).json({ error: 'ID ticket non valido' });
    if (!message || !message.trim()) return res.status(400).json({ error: 'Il messaggio non può essere vuoto' });

    const [accessCheckResults] = await db.query('CALL sp_check_ticket_access(?)', [ticketId]);
    const tickets = accessCheckResults[0];
    if (tickets.length === 0) return res.status(404).json({ error: 'Ticket non trovato' });

    const ticket = tickets[0];

    // Add message using Stored Procedure
    await db.query('CALL sp_add_ticket_message(?, ?, ?)', [ticketId, req.user.id, message]);

    await logActivityFromRequest(req, {
      userId: req.user.id,
      action: 'TICKET_MESSAGE_ADDED',
      entityType: 'TICKET',
      entityId: ticketId,
      description: `Risposta aggiunta al ticket: "${ticket.title}"`,
      metadata: { ticket_id: ticketId, sender: req.user.username, message_preview: message.substring(0, 50) }
    });

    // Send notification to ticket creator (if not the sender)
    if (ticket.user_id !== req.user.id) {
      notifyUser(ticket.user_id, {
        type: 'new_message',
        message: `Nuova risposta al tuo ticket "${ticket.title}"`,
        title: ticket.title,
        ticketId: ticketId,
        sender: req.user.username,
        messagePreview: message.substring(0, 100)
      });
    }

    res.status(201).json({ message: 'Risposta inviata con successo' });
  } catch (error) {
    console.error('Errore invio messaggio:', error);
    res.status(500).json({ error: 'Errore durante l\'invio del messaggio' });
  }
});

router.get('/meta/types', authenticateToken, async (req, res) => {
  try { const [results] = await db.query('CALL sp_get_ticket_types()'); res.json(results[0]); } catch (error) { res.status(500).json({ error: 'Errore' }); }
});
router.get('/meta/statuses', authenticateToken, isAdmin, async (req, res) => {
  try { const [results] = await db.query('CALL sp_get_ticket_statuses()'); res.json(results[0]); } catch (error) { res.status(500).json({ error: 'Errore' }); }
});

module.exports = router;