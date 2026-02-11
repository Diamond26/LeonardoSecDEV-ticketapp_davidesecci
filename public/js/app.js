// app.js - Main Application Logic

console.log('app.js loaded');

// Check authentication
if (!auth.isAuthenticated()) {
    console.log('User not authenticated, redirecting to login');
    window.location.href = '/login.html';
}

console.log('User authenticated:', auth.getUser());

// Update navbar with user info
const navUsername = document.getElementById('navUsername');
const navRole = document.getElementById('navRole');
if (navUsername) navUsername.textContent = auth.getUser().username;
if (navRole) navRole.textContent = auth.isAdmin() ? 'Amministratore' : 'Utente';

// Logout handler
const logoutBtn = document.getElementById('logoutBtn');
if (logoutBtn) {
    logoutBtn.addEventListener('click', () => {
        auth.logout();
    });
}

// ==================== TEMPLATES ====================

const templates = {
    // DASHBOARD UTENTE
    dashboard: () => `
        <div class="container">
            <div class="header">
                <h1>I Miei Ticket</h1>
                <a href="#" data-route="new-ticket" class="btn btn-success">+ Nuovo Ticket</a>
            </div>
            <div id="ticketsContainer" class="loading">Caricamento ticket...</div>
        </div>
    `,

    // ADMIN DASHBOARD (Con Filtri e Ricerca)
    admin: () => `
        <div class="container">
            <div class="header">
                <h1>Dashboard Amministratore</h1>
                <div class="header-actions">
                    <a href="#" data-route="users" class="btn btn-info">Gestione Utenti</a>
                    <button class="btn btn-success" id="newUserBtn">+ Nuovo Utente</button>
                </div>
            </div>

            <div class="card" style="margin-bottom: 30px; padding: 20px; background: linear-gradient(135deg, #000 0%, #0a0a0a 100%); border: 1px solid #333;">
                <div style="display: flex; gap: 15px; flex-wrap: wrap; align-items: flex-end;">
                    <div class="form-group" style="margin: 0; flex: 1; min-width: 200px;">
                        <label for="filterSearch" style="font-size: 12px;">Cerca (Titolo o Utente)</label>
                        <input type="text" id="filterSearch" placeholder="Es: problema accesso..." style="padding: 10px;">
                    </div>
                    <div class="form-group" style="margin: 0; min-width: 150px;">
                        <label for="filterStatus" style="font-size: 12px;">Stato</label>
                        <select id="filterStatus" style="padding: 10px;">
                            <option value="">Tutti</option>
                            <option value="OPEN">Aperto</option>
                            <option value="IN_PROGRESS">In Lavorazione</option>
                            <option value="CLOSED">Chiuso</option>
                        </select>
                    </div>
                    <div class="form-group" style="margin: 0; min-width: 150px;">
                        <label for="filterType" style="font-size: 12px;">Tipo</label>
                        <select id="filterType" style="padding: 10px;">
                            <option value="">Tutti</option>
                            <option value="BUG">Bug</option>
                            <option value="SUPPORT">Supporto</option>
                            <option value="ACCESS">Accesso</option>
                        </select>
                    </div>
                    <button class="btn btn-primary" id="applyFiltersBtn" style="height: 44px; margin-bottom: 2px;">Filtra</button>
                    <button class="btn btn-secondary" id="resetFiltersBtn" style="height: 44px; margin-bottom: 2px;">Reset</button>
                </div>
            </div>

            <div id="errorMessage" class="error-message"></div>
            <div id="successMessage" class="success-message"></div>

            <div class="stats">
                <div class="stat-card">
                    <div class="stat-value" id="totalTickets">0</div>
                    <div class="stat-label">Ticket Totali</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="openTickets">0</div>
                    <div class="stat-label">Aperti</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="inProgressTickets">0</div>
                    <div class="stat-label">In Lavorazione</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="closedTickets">0</div>
                    <div class="stat-label">Chiusi</div>
                </div>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Titolo</th>
                            <th class="type-header">Tipo</th>
                            <th>Creatore</th>
                            <th>Status</th>
                            <th>Data</th>
                            <th class="actions-header">Azioni</th>
                        </tr>
                    </thead>
                    <tbody id="ticketsTable">
                        <tr><td colspan="7" class="loading">Caricamento ticket...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="newUserModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Registra Nuovo Utente</h2><button class="close-modal" onclick="closeNewUserModal()">×</button></div>
                <div id="modalError" class="error-message"></div>
                <div id="modalSuccess" class="success-message"></div>
                <form id="newUserForm">
                    <div class="form-group"><div class="input-wrapper"><label>Username *</label><input type="text" id="newUsername" required></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Password *</label><input type="password" id="newPassword" required></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Tipo Utente *</label><select id="userType"><option value="USER">Utente</option><option value="ADMIN">Amministratore</option></select></div></div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Crea Utente</button>
                </form>
            </div>
        </div>
        <div id="statusModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Modifica Status Ticket</h2><button class="close-modal" onclick="closeStatusModal()">×</button></div>
                <div id="statusModalError" class="error-message"></div>
                <form id="statusForm">
                    <div class="form-group"><div class="input-wrapper"><label>Nuovo Status *</label><select id="ticketStatus"><option value="OPEN">Aperto</option><option value="IN_PROGRESS">In Lavorazione</option><option value="CLOSED">Chiuso</option></select></div></div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Aggiorna Status</button>
                </form>
            </div>
        </div>
    `,

    // NUOVO TICKET
    newTicket: () => `
        <div class="container">
            <div class="card">
                <h1>Nuovo Ticket</h1>
                <div id="errorMessage" class="error-message"></div>
                <div id="successMessage" class="success-message"></div>
                <form id="ticketForm">
                    <div class="form-group"><div class="input-wrapper"><label>Tipo di Ticket *</label><select id="ticketType" required><option value="">Seleziona un tipo...</option></select></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Titolo *</label><input type="text" id="title" required maxlength="120"><div class="char-counter"><span id="titleCounter">0</span> / 120</div></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Descrizione *</label><textarea id="description" required maxlength="2000"></textarea><div class="char-counter"><span id="descCounter">0</span> / 2000</div></div></div>
                    <div class="form-actions"><button type="submit" class="btn btn-primary" id="submitBtn">✓ Crea Ticket</button><a href="#" data-route="${auth.isAdmin() ? 'admin' : 'dashboard'}" class="btn btn-secondary">✕ Annulla</a></div>
                </form>
            </div>
        </div>
    `,

    // DETTAGLIO TICKET (Con Messaggi)
    ticketDetail: (params) => `
        <div class="container">
            <div id="errorMessage" class="error-message"></div>
            <div id="successMessage" class="success-message"></div>
            <div id="ticketContent" class="loading">Caricamento ticket...</div>
            
            <div id="messagesSection" style="display:none; margin-top: 30px; animation: fadeInUp 0.6s ease-out;">
                <h3 style="color: #d4af37; margin-bottom: 20px; border-bottom: 1px solid #333; padding-bottom: 10px;">Comunicazioni</h3>
                <div id="messagesList"></div>
                
                ${auth.isAdmin() ? `
                <div class="card" style="margin-top: 20px; background: #000;">
                    <h4 style="color: #d4af37; margin-bottom: 15px;">Rispondi al ticket</h4>
                    <form id="replyForm">
                        <div class="form-group">
                            <textarea id="replyMessage" placeholder="Scrivi una risposta per l'utente..." style="min-height: 100px; background: #1a1a1a; color: white; border: 1px solid #333; padding: 10px; width: 100%;" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Invia Risposta</button>
                    </form>
                </div>
                ` : ''}
            </div>
        </div>
    `,

    // UTENTI (Gestione Completa Ripristinata)
    users: () => `
        <div class="container">
            <div class="header">
                <h1>Gestione Utenti</h1>
                <button class="btn btn-success" id="newUserBtn">+ Nuovo Utente</button>
            </div>
            <div id="errorMessage" class="error-message"></div>
            <div id="successMessage" class="success-message"></div>
            <div class="stats">
                <div class="stat-card"><div class="stat-value" id="totalUsers">0</div><div class="stat-label">Utenti Totali</div></div>
                <div class="stat-card"><div class="stat-value" id="adminCount">0</div><div class="stat-label">Amministratori</div></div>
                <div class="stat-card"><div class="stat-value" id="userCount">0</div><div class="stat-label">Utenti Standard</div></div>
                <div class="stat-card"><div class="stat-value" id="activeCount">0</div><div class="stat-label">Utenti Attivi</div></div>
            </div>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th class="type-header">Tipo</th>
                            <th>Status</th>
                            <th>Creato</th>
                            <th class="actions-header">Azioni</th>
                        </tr>
                    </thead>
                    <tbody id="usersTable">
                        <tr><td colspan="6" class="loading">Caricamento utenti...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="newUserModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Nuovo Utente</h2><button class="close-modal" onclick="closeNewUserModal()">×</button></div>
                <div id="modalError" class="error-message"></div>
                <form id="newUserForm">
                    <div class="form-group"><div class="input-wrapper"><label>Username *</label><input type="text" id="newUsername" required></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Password *</label><input type="password" id="newPassword" required></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Tipo *</label><select id="userType"><option value="USER">Utente</option><option value="ADMIN">Admin</option></select></div></div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Crea Utente</button>
                </form>
            </div>
        </div>
        <div id="editModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Modifica Utente</h2><button class="close-modal" onclick="closeEditModal()">×</button></div>
                <div id="editError" class="error-message"></div>
                <form id="editForm">
                    <div class="form-group"><div class="input-wrapper"><label>Username</label><input type="text" id="editUsername"></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Tipo</label><select id="editType"><option value="USER">Utente</option><option value="ADMIN">Admin</option></select></div></div>
                    <div class="form-group"><div class="input-wrapper"><label>Status</label><select id="editActive"><option value="1">Attivo</option><option value="0">Inattivo</option></select></div></div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Salva Modifiche</button>
                </form>
            </div>
        </div>
        <div id="passwordModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Cambia Password</h2><button class="close-modal" onclick="closePasswordModal()">×</button></div>
                <div id="passwordError" class="error-message"></div>
                <form id="passwordForm">
                    <div class="form-group"><div class="input-wrapper"><label>Nuova Password *</label><input type="password" id="newPasswordInput" required></div></div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Cambia Password</button>
                </form>
            </div>
        </div>
    `
};

// ==================== UTILITY FUNCTIONS ====================

const showError = (m) => { const el = document.getElementById('errorMessage'); if(el){ el.textContent=m; el.style.display='block'; window.scrollTo(0,0); }};
const showSuccess = (m) => { const el = document.getElementById('successMessage'); if(el){ el.textContent=m; el.style.display='block'; window.scrollTo(0,0); }};
const hideMessages = () => { ['errorMessage','successMessage'].forEach(id=>{ const el=document.getElementById(id); if(el)el.style.display='none'; }); };
const formatDate = (d) => new Date(d).toLocaleDateString('it-IT', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' });
const animateCount = (el, value) => { const duration=800; const start=0; const startTime=performance.now(); const step=(now)=>{ const progress=Math.min((now-startTime)/duration,1); el.textContent=Math.round(value*progress); if(progress<1)requestAnimationFrame(step);}; requestAnimationFrame(step); };

// ==================== API FUNCTIONS ====================

async function apiRequest(url, options = {}) {
    const defaultOptions = { headers: { 'Authorization': `Bearer ${auth.getToken()}`, 'Content-Type': 'application/json', ...options.headers } };
    const response = await fetch(url, { ...options, ...defaultOptions });
    if (response.status === 401 || response.status === 403) {
        if (await auth.refresh()) {
            defaultOptions.headers.Authorization = `Bearer ${auth.getToken()}`;
            return await fetch(url, { ...options, ...defaultOptions });
        } else { window.location.href = '/login.html'; throw new Error('Auth failed'); }
    }
    return response;
}

// ==================== DASHBOARD FUNCTIONS ====================

async function loadDashboardTickets() {
    try {
        const response = await apiRequest('/api/tickets');
        const tickets = await response.json();
        const container = document.getElementById('ticketsContainer');
        if (tickets.length === 0) {
            container.innerHTML = `<div class="empty-state"><div class="empty-state-icon">📋</div><h2>Nessun ticket</h2><p>Crea il primo ticket</p><a href="#" data-route="new-ticket" class="btn btn-primary">+ Crea Ticket</a></div>`;
        } else {
            container.innerHTML = ''; container.className = 'tickets-grid';
            tickets.forEach(t => container.appendChild(createTicketCard(t)));
        }
    } catch (e) { document.getElementById('ticketsContainer').textContent = '⚠️ Errore caricamento'; }
}

function createTicketCard(ticket) {
    const card = document.createElement('div'); card.className = 'ticket-card';
    card.onclick = () => router.navigate('ticket-detail', { id: ticket.id });
    card.innerHTML = `
        <div class="ticket-header"><div class="ticket-title">${ticket.title}</div><span class="ticket-status status-${ticket.status}">${ticket.status_desc}</span></div>
        <div class="ticket-description">${ticket.description}</div>
        <div class="ticket-meta"><span class="ticket-type">${ticket.ticket_type_desc}</span><span class="ticket-date">🕒 ${formatDate(ticket.created_at)}</span></div>
    `;
    return card;
}

// ==================== ADMIN FUNCTIONS (Con Filtri) ====================

let adminCurrentTicketId = null;

async function loadAdminTickets() {
    try {
        const search = document.getElementById('filterSearch')?.value || '';
        const status = document.getElementById('filterStatus')?.value || '';
        const type = document.getElementById('filterType')?.value || '';
        
        const params = new URLSearchParams();
        if(search) params.append('search', search);
        if(status) params.append('status', status);
        if(type) params.append('type', type);

        const response = await apiRequest(`/api/tickets?${params.toString()}`);
        const tickets = await response.json();

        // Stats (aggiornate solo se non filtro)
        if(!search && !status && !type) {
            document.getElementById('totalTickets').textContent = tickets.length;
            document.getElementById('openTickets').textContent = tickets.filter(x => x.status === 'OPEN').length;
            document.getElementById('inProgressTickets').textContent = tickets.filter(x => x.status === 'IN_PROGRESS').length;
            document.getElementById('closedTickets').textContent = tickets.filter(x => x.status === 'CLOSED').length;
        }

        renderAdminTicketsTable(tickets);

        // Listeners Filtri
        const filterBtn = document.getElementById('applyFiltersBtn');
        if(filterBtn && !filterBtn.dataset.bound) {
            filterBtn.dataset.bound = true;
            filterBtn.addEventListener('click', loadAdminTickets);
            document.getElementById('resetFiltersBtn').addEventListener('click', () => {
                document.getElementById('filterSearch').value = '';
                document.getElementById('filterStatus').value = '';
                document.getElementById('filterType').value = '';
                loadAdminTickets();
            });
        }
    } catch (e) { console.error(e); showError('Errore caricamento ticket'); }
}

function renderAdminTicketsTable(tickets) {
    const tbody = document.getElementById('ticketsTable'); tbody.innerHTML = '';
    if (tickets.length === 0) { tbody.innerHTML = '<tr><td colspan="7" class="empty-state">Nessun ticket trovato</td></tr>'; return; }
    tickets.forEach(t => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td style="color:#d4af37;font-weight:600">#${t.id}</td>
            <td style="font-weight:600;max-width:300px">${t.title}</td>
            <td class="type-cell"><span class="ticket-type">${t.ticket_type_desc}</span></td>
            <td>${t.creator}</td>
            <td><span class="ticket-status status-${t.status}">${t.status_desc}</span></td>
            <td style="white-space:nowrap">${formatDate(t.created_at)}</td>
            <td class="actions-cell">
                <div class="actions-group">
                    <button class="btn btn-primary btn-sm" onclick="router.navigate('ticket-detail', { id: ${t.id} })">Vedi</button>
                    <button class="btn btn-warning btn-sm" onclick="openStatusModal(${t.id}, '${t.status}')">Status</button>
                </div>
            </td>
        `;
        tbody.appendChild(tr);
    });
}

// Helpers Modali Admin
window.openStatusModal = (id, currentStatus) => {
    adminCurrentTicketId = id;
    document.getElementById('ticketStatus').value = currentStatus;
    document.getElementById('statusModal').classList.add('active');
    document.getElementById('statusModalError').style.display = 'none';
};
window.closeStatusModal = () => document.getElementById('statusModal').classList.remove('active');
window.closeNewUserModal = () => document.getElementById('newUserModal').classList.remove('active');

async function setupAdminHandlers() {
    document.getElementById('newUserBtn')?.addEventListener('click', () => { document.getElementById('newUserModal').classList.add('active'); });
    
    // Handler status form
    document.getElementById('statusForm')?.addEventListener('submit', async (e) => {
        e.preventDefault();
        try {
            const res = await apiRequest(`/api/tickets/${adminCurrentTicketId}/status`, { method: 'PATCH', body: JSON.stringify({ status: document.getElementById('ticketStatus').value }) });
            if(res.ok) { closeStatusModal(); loadAdminTickets(); }
        } catch(e) { document.getElementById('statusModalError').textContent='Errore update'; document.getElementById('statusModalError').style.display='block'; }
    });
    
    // User form handler (condiviso)
    setupUsersHandlers();
}

// ==================== TICKET DETAIL FUNCTIONS (Con Messaggi) ====================

async function loadTicketDetail(params) {
    if (!params.id) return router.navigate('dashboard');
    try {
        const response = await apiRequest(`/api/tickets/${params.id}`);
        if (!response.ok) return showError('Errore caricamento ticket');
        const ticket = await response.json();
        renderTicketDetail(ticket);
    } catch (e) { showError('Errore connessione'); }
}

function renderTicketDetail(ticket) {
    const container = document.getElementById('ticketContent');
    container.innerHTML = ''; container.classList.remove('loading');

    const card = document.createElement('div'); card.className = 'card';
    card.innerHTML = `
        <div class="ticket-header">
            <div class="ticket-title"><div class="title-row"><h1>${ticket.title}</h1><span class="ticket-status status-${ticket.status}">${ticket.status_desc}</span></div>
            <div class="info-grid">
                <div class="info-item"><div class="info-label">Creatore</div><div class="info-value">${ticket.creator}</div></div>
                <div class="info-item"><div class="info-label">Tipo</div><div class="info-value">${ticket.ticket_type_desc}</div></div>
                <div class="info-item"><div class="info-label">Data</div><div class="info-value">${formatDate(ticket.created_at)}</div></div>
            </div></div>
        </div>
        <div class="section-title">Descrizione</div><div class="ticket-description">${ticket.description}</div>
    `;
    
    if (ticket.user_id === auth.getUser().id && ticket.status === 'OPEN') {
        const btnDiv = document.createElement('div'); btnDiv.className = 'action-buttons';
        btnDiv.innerHTML = `<button class="btn btn-primary" onclick="document.getElementById('editForm').style.display='block'">Modifica Ticket</button>`;
        card.appendChild(btnDiv);
    }
    container.appendChild(card);

    const editDiv = document.createElement('div'); editDiv.className = 'card edit-form'; editDiv.id = 'editForm';
    editDiv.innerHTML = `<div class="section-title">Modifica</div><form id="updateForm"><div class="form-group"><label>Titolo</label><input id="editTitle" value="${ticket.title}"></div><div class="form-group"><label>Descrizione</label><textarea id="editDesc">${ticket.description}</textarea></div><div class="form-actions"><button type="submit" class="btn btn-primary">Salva</button><button type="button" class="btn btn-secondary" onclick="this.closest('.edit-form').style.display='none'">Annulla</button></div></form>`;
    container.appendChild(editDiv);
    
    document.getElementById('updateForm')?.addEventListener('submit', async (e) => {
        e.preventDefault();
        try {
            await apiRequest(`/api/tickets/${ticket.id}`, { method: 'PATCH', body: JSON.stringify({ title: document.getElementById('editTitle').value, description: document.getElementById('editDesc').value }) });
            loadTicketDetail({id: ticket.id});
        } catch(e){ showError('Errore update'); }
    });

    // MESSAGGI
    const msgSection = document.getElementById('messagesSection');
    const msgList = document.getElementById('messagesList');
    if(msgSection) {
        msgSection.style.display = 'block';
        msgList.innerHTML = '';
        if(ticket.messages && ticket.messages.length > 0) {
            ticket.messages.forEach(m => {
                const isAdminMsg = m.sender_role === 'ADMIN';
                const div = document.createElement('div');
                div.style.cssText = `background: ${isAdminMsg ? 'rgba(212,175,55,0.1)' : 'rgba(255,255,255,0.05)'}; padding: 15px; border-radius: 8px; margin-bottom: 15px; border-left: 4px solid ${isAdminMsg ? '#d4af37' : '#666'};`;
                div.innerHTML = `<div style="display:flex;justify-content:space-between;font-size:12px;color:#888;margin-bottom:5px;"><span>${m.sender} (${isAdminMsg ? 'Admin' : 'Utente'})</span><span>${formatDate(m.created_at)}</span></div><div style="color:#ddd;">${m.message.replace(/\n/g, '<br>')}</div>`;
                msgList.appendChild(div);
            });
        } else {
            msgList.innerHTML = '<p style="color:#666;font-style:italic">Nessuna risposta.</p>';
        }

        const replyForm = document.getElementById('replyForm');
        if(replyForm) {
            const newForm = replyForm.cloneNode(true);
            replyForm.parentNode.replaceChild(newForm, replyForm);
            newForm.addEventListener('submit', async (e) => {
                e.preventDefault();
                const msg = document.getElementById('replyMessage').value;
                try {
                    const res = await apiRequest(`/api/tickets/${ticket.id}/messages`, { method: 'POST', body: JSON.stringify({ message: msg }) });
                    if(res.ok) loadTicketDetail({id: ticket.id});
                } catch(e) { showError('Errore invio messaggio'); }
            });
        }
    }
}

// ==================== USER MANAGEMENT FUNCTIONS (Ripristinate) ====================

let currentUserId = null;
let usersStatsAnimated = false;

async function loadUsers() {
    try {
        const response = await apiRequest('/api/auth/users');
        if (response.status === 401 || response.status === 403) { window.location.href = '/login.html'; return; }

        const users = await response.json();
        const totalUsers = users.length;
        const adminCount = users.filter(x => x.user_type === 'ADMIN').length;
        const userCount = users.filter(x => x.user_type === 'USER').length;
        const activeCount = users.filter(x => x.is_active).length;

        if (!usersStatsAnimated) {
            animateCount(document.getElementById('totalUsers'), totalUsers);
            animateCount(document.getElementById('adminCount'), adminCount);
            animateCount(document.getElementById('userCount'), userCount);
            animateCount(document.getElementById('activeCount'), activeCount);
            usersStatsAnimated = true;
        } else {
            document.getElementById('totalUsers').textContent = totalUsers;
            document.getElementById('adminCount').textContent = adminCount;
            document.getElementById('userCount').textContent = userCount;
            document.getElementById('activeCount').textContent = activeCount;
        }
        renderUsersTable(users);
        setupUsersHandlers();
    } catch (error) { console.error(error); showError('Errore caricamento utenti'); }
}

function renderUsersTable(users) {
    const tbody = document.getElementById('usersTable');
    tbody.innerHTML = '';
    users.forEach(u => {
        const tr = document.createElement('tr');
        
        // Costruzione Righe
        const tdId = document.createElement('td'); tdId.textContent = '#' + u.id; tdId.style.color = '#d4af37';
        const tdUser = document.createElement('td'); tdUser.textContent = u.username;
        const tdType = document.createElement('td'); tdType.className = 'type-cell'; tdType.innerHTML = `<span class="user-badge badge-${u.user_type.toLowerCase()}">${u.user_type}</span>`;
        const tdStatus = document.createElement('td'); tdStatus.innerHTML = `<span class="status-badge status-${u.is_active ? 'active' : 'inactive'}">${u.is_active ? 'Attivo' : 'Inattivo'}</span>`;
        const tdDate = document.createElement('td'); tdDate.textContent = formatDate(u.created_at);

        // --- AZIONI RIPRISTINATE ---
        const tdActions = document.createElement('td'); tdActions.className = 'actions-cell';
        const actionsGroup = document.createElement('div'); actionsGroup.className = 'actions-group';

        const editBtn = document.createElement('button'); editBtn.className = 'btn btn-primary btn-sm'; editBtn.textContent = 'Modifica';
        editBtn.onclick = () => {
            currentUserId = u.id;
            document.getElementById('editUsername').value = u.username;
            document.getElementById('editType').value = u.user_type;
            document.getElementById('editActive').value = u.is_active ? '1' : '0';
            document.getElementById('editModal').classList.add('active');
            document.getElementById('editError').style.display = 'none';
        };

        const pwBtn = document.createElement('button'); pwBtn.className = 'btn btn-warning btn-sm'; pwBtn.textContent = 'Password';
        pwBtn.onclick = () => {
            currentUserId = u.id;
            document.getElementById('newPasswordInput').value = '';
            document.getElementById('passwordModal').classList.add('active');
            document.getElementById('passwordError').style.display = 'none';
        };

        const delBtn = document.createElement('button'); delBtn.className = 'btn btn-danger btn-sm'; delBtn.textContent = 'Elimina';
        delBtn.onclick = async () => {
            if (!confirm(`Eliminare ${u.username}?`)) return;
            try {
                const res = await apiRequest(`/api/auth/users/${u.id}`, { method: 'DELETE' });
                if (res.ok) { showSuccess('Utente eliminato'); loadUsers(); }
            } catch (e) { showError('Errore eliminazione'); }
        };
        if (u.id === auth.getUser().id) delBtn.disabled = true;

        actionsGroup.append(editBtn, pwBtn, delBtn);
        tdActions.appendChild(actionsGroup);

        tr.append(tdId, tdUser, tdType, tdStatus, tdDate, tdActions);
        tbody.appendChild(tr);
    });
}

// Helpers Modali User
window.closeEditModal = () => document.getElementById('editModal').classList.remove('active');
window.closePasswordModal = () => document.getElementById('passwordModal').classList.remove('active');

function setupUsersHandlers() {
    // Nuovo Utente
    const newUserBtn = document.getElementById('newUserBtn');
    if(newUserBtn && !newUserBtn.dataset.bound) {
        newUserBtn.dataset.bound = true;
        newUserBtn.addEventListener('click', () => { document.getElementById('newUserModal').classList.add('active'); });
    }

    const newUserForm = document.getElementById('newUserForm');
    if(newUserForm && !newUserForm.dataset.bound) {
        newUserForm.dataset.bound = true;
        newUserForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const body = { username: document.getElementById('newUsername').value, password: document.getElementById('newPassword').value, user_type: document.getElementById('userType').value };
            try {
                const res = await apiRequest('/api/auth/register', { method: 'POST', body: JSON.stringify(body) });
                if(res.ok) { showSuccess('Utente creato'); closeNewUserModal(); loadUsers(); }
            } catch(e) { document.getElementById('modalError').textContent='Errore'; document.getElementById('modalError').style.display='block'; }
        });
    }

    // Edit Form
    const editForm = document.getElementById('editForm');
    if(editForm && !editForm.dataset.bound) {
        editForm.dataset.bound = true;
        editForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const body = { username: document.getElementById('editUsername').value, user_type: document.getElementById('editType').value, is_active: document.getElementById('editActive').value === '1' };
            try {
                const res = await apiRequest(`/api/auth/users/${currentUserId}`, { method: 'PATCH', body: JSON.stringify(body) });
                if(res.ok) { showSuccess('Aggiornato'); closeEditModal(); loadUsers(); }
            } catch(e) { showError('Errore update'); }
        });
    }
    
    // Password Form
    const pwForm = document.getElementById('passwordForm');
    if(pwForm && !pwForm.dataset.bound) {
        pwForm.dataset.bound = true;
        pwForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            try {
                const res = await apiRequest(`/api/auth/users/${currentUserId}/password`, { method: 'PATCH', body: JSON.stringify({ new_password: document.getElementById('newPasswordInput').value }) });
                if(res.ok) { showSuccess('Password cambiata'); closePasswordModal(); }
            } catch(e) { showError('Errore cambio password'); }
        });
    }
}

// ==================== NEW TICKET LOGIC ====================
async function loadNewTicketLogic() {
    try {
        const res = await apiRequest('/api/tickets/meta/types');
        const types = await res.json();
        const sel = document.getElementById('ticketType');
        types.forEach(t => { const o=document.createElement('option'); o.value=t.code; o.textContent=t.description; sel.appendChild(o); });
    } catch(e){}

    document.getElementById('ticketForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        try {
            const body = { ticket_type: document.getElementById('ticketType').value, title: document.getElementById('title').value, description: document.getElementById('description').value };
            const res = await apiRequest('/api/tickets', { method: 'POST', body: JSON.stringify(body) });
            if(res.ok) router.navigate(auth.isAdmin()?'admin':'dashboard');
        } catch(e) { showError('Errore creazione'); }
    });
}

// ==================== ROUTER INIT ====================

document.addEventListener('DOMContentLoaded', () => {
    const content = document.getElementById('app-content');
    router.init(content);

    router.register('dashboard', { path: '/dashboard', showNavbar: true, template: templates.dashboard, onLoad: loadDashboardTickets });
    router.register('admin', { path: '/admin', showNavbar: true, requiresAdmin: true, template: templates.admin, onLoad: async () => { await loadAdminTickets(); setupAdminHandlers(); } });
    router.register('new-ticket', { path: '/new-ticket', showNavbar: true, template: templates.newTicket, onLoad: loadNewTicketLogic });
    router.register('ticket-detail', { path: '/ticket-detail', showNavbar: true, template: templates.ticketDetail, onLoad: loadTicketDetail });
    router.register('users', { path: '/users', showNavbar: true, requiresAdmin: true, template: templates.users, onLoad: loadUsers });

    router.navigate(auth.isAdmin() ? 'admin' : 'dashboard');
});