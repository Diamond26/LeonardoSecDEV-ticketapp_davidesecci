const express = require('express');
const router = express.Router();
const db = require('../config/database');
const { authenticateToken } = require('../middleware/auth');

/**
 * GET /api/notifications
 * Get all notifications for the authenticated user
 */
router.get('/', authenticateToken, async (req, res) => {
    try {
        const userId = req.user.id;

        // Get notifications for this user, ordered by most recent first
        // Limit to 50 most recent notifications
        // Get notifications for this user using SP
        // Limit to 50 most recent notifications
        const [notifications] = await db.query(
            'CALL sp_get_user_notifications(?, 50)',
            [userId]
        );

        // SP returns results in the first array element
        res.json(notifications[0]);
    } catch (error) {
        console.error('Error fetching notifications:', error);
        res.status(500).json({ error: 'Errore nel recupero delle notifiche' });
    }
});

/**
 * GET /api/notifications/unread-count
 * Get count of unread notifications
 */
router.get('/unread-count', authenticateToken, async (req, res) => {
    try {
        const userId = req.user.id;

        const [result] = await db.query(
            'CALL sp_count_unread_notifications(?)',
            [userId]
        );

        res.json({ count: result[0][0].unread_count });
    } catch (error) {
        console.error('Error counting unread notifications:', error);
        res.status(500).json({ error: 'Errore nel conteggio delle notifiche' });
    }
});

/**
 * PATCH /api/notifications/:id/read
 * Mark a specific notification as read
 */
router.patch('/:id/read', authenticateToken, async (req, res) => {
    try {
        const notificationId = req.params.id;
        const userId = req.user.id;

        // Update only if the notification belongs to this user
        // Mark notification as read using SP
        await db.query(
            'CALL sp_mark_notification_read(?, ?)',
            [notificationId, userId]
        );

        // Note: SP doesn't easily return affectedRows without extra logic, 
        // but for this UI purpose we can assume success if no error thrown
        res.json({ success: true });
    } catch (error) {
        console.error('Error marking notification as read:', error);
        res.status(500).json({ error: 'Errore nell\'aggiornamento della notifica' });
    }
});

/**
 * PATCH /api/notifications/read-all
 * Mark all notifications as read for the authenticated user
 */
router.patch('/read-all', authenticateToken, async (req, res) => {
    try {
        const userId = req.user.id;

        await db.query(
            'CALL sp_mark_all_notifications_read(?)',
            [userId]
        );

        res.json({ success: true });
    } catch (error) {
        console.error('Error marking all notifications as read:', error);
        res.status(500).json({ error: 'Errore nell\'aggiornamento delle notifiche' });
    }
});

/**
 * DELETE /api/notifications/:id
 * Delete a specific notification
 */
router.delete('/:id', authenticateToken, async (req, res) => {
    try {
        const notificationId = req.params.id;
        const userId = req.user.id;

        // Delete only if the notification belongs to this user
        // Delete notification using SP
        await db.query(
            'CALL sp_delete_notification(?, ?)',
            [notificationId, userId]
        );

        // Assuming success if no error
        res.json({ success: true });
    } catch (error) {
        console.error('Error deleting notification:', error);
        res.status(500).json({ error: 'Errore nell\'eliminazione della notifica' });
    }
});

module.exports = router;
