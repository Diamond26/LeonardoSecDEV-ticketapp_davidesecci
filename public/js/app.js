console.log('app.js loaded');

// Check authentication
if (!auth.isAuthenticated()) {
    window.location.href = '/login.html';
}

// Update navbar with user info
const navUsername = document.getElementById('navUsername');
const navRole = document.getElementById('navRole');
if (navUsername) navUsername.textContent = auth.getUser().username;
if (navRole) navRole.textContent = auth.isAdmin() ? 'ADMIN' : 'USER';

const logoutBtn = document.getElementById('logoutBtn');
if (logoutBtn) logoutBtn.addEventListener('click', () => auth.logout());

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

    // ADMIN DASHBOARD
    admin: () => `
        <div class="container">
            <div class="header">
                <h1>Dashboard Amministratore</h1>
                <div class="header-actions">
                    <a href="#" data-route="users" class="btn btn-info">Gestione Utenti</a>
                    <button class="btn btn-success" id="newUserBtn">+ Nuovo Utente</button>
                </div>
            </div>

            <div class="card" style="margin-bottom: 2rem;">
                <div style="display: flex; gap: 15px; flex-wrap: wrap; align-items: flex-end;">
                    <div class="form-group" style="margin: 0; flex: 1; min-width: 200px;">
                        <label for="filterSearch">Cerca (Titolo o Utente)</label>
                        <input type="text" id="filterSearch" placeholder="Es: problema accesso...">
                    </div>
                    <div class="form-group" style="margin: 0; min-width: 150px;">
                        <label for="filterStatus">Stato</label>
                        <select id="filterStatus">
                            <option value="">Tutti</option>
                            <option value="OPEN">Aperto</option>
                            <option value="IN_PROGRESS">In Lavorazione</option>
                            <option value="CLOSED">Chiuso</option>
                        </select>
                    </div>
                    <div class="form-group" style="margin: 0; min-width: 150px;">
                        <label for="filterType">Tipo</label>
                        <select id="filterType">
                            <option value="">Tutti</option>
                            <option value="BUG">Bug</option>
                            <option value="SUPPORT">Supporto</option>
                            <option value="ACCESS">Accesso</option>
                        </select>
                    </div>
                    <button class="btn btn-primary" id="applyFiltersBtn">Filtra</button>
                    <button class="btn btn-secondary" id="resetFiltersBtn">Reset</button>
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
                            <th>Tipo</th>
                            <th>Creatore</th>
                            <th>Status</th>
                            <th>Data</th>
                            <th style="text-align:center">Azioni</th>
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
                    <div class="form-group"><label>Username *</label><input type="text" id="newUsername" required></div>
                    <div class="form-group"><label>Password *</label><input type="password" id="newPassword" required></div>
                    <div class="form-group"><label>Tipo Utente *</label><select id="userType"><option value="USER">Utente</option><option value="ADMIN">Amministratore</option></select></div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Crea Utente</button>
                </form>
            </div>
        </div>

        <div id="statusModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Modifica Status Ticket</h2><button class="close-modal" onclick="closeStatusModal()">×</button></div>
                <div id="statusModalError" class="error-message"></div>
                <form id="statusForm">
                    <div class="form-group"><label>Nuovo Status *</label><select id="ticketStatus"><option value="OPEN">Aperto</option><option value="IN_PROGRESS">In Lavorazione</option><option value="CLOSED">Chiuso</option></select></div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Aggiorna Status</button>
                </form>
            </div>
        </div>
    `,

    // NUOVO TICKET
    newTicket: () => `
        <div class="container">
            <div class="card">
                <div class="header"><h1>Nuovo Ticket</h1></div>
                <div id="errorMessage" class="error-message"></div>
                <div id="successMessage" class="success-message"></div>
                <form id="ticketForm">
                    <div class="form-group"><label>Tipo di Ticket *</label><select id="ticketType" required><option value="">Seleziona un tipo...</option></select></div>
                    <div class="form-group"><label>Titolo *</label><input type="text" id="title" required maxlength="120"></div>
                    <div class="form-group"><label>Descrizione *</label><textarea id="description" required maxlength="2000" rows="5"></textarea></div>
                    <div style="display:flex; gap:10px; margin-top:20px;">
                        <button type="submit" class="btn btn-primary" id="submitBtn">✓ Crea Ticket</button>
                        <a href="#" data-route="${auth.isAdmin() ? 'admin' : 'dashboard'}" class="btn btn-secondary">Annulla</a>
                    </div>
                </form>
            </div>
        </div>
    `,

    // DETTAGLIO TICKET
    ticketDetail: (params) => `
        <div class="container">
            <div id="errorMessage" class="error-message"></div>
            <div id="successMessage" class="success-message"></div>
            <div id="ticketContent" class="loading">Caricamento ticket...</div>
            
            <div id="messagesSection" style="display:none; margin-top: 2rem;">
                <h3 style="color: var(--text-main); margin-bottom: 1.5rem; display:flex; align-items:center; gap:10px;">
                    💬 Comunicazioni
                </h3>
                <div id="messagesList"></div>
                
                ${auth.isAdmin() ? `
                <div class="card" style="margin-top: 1.5rem; border-color: var(--primary-start);">
                    <h4 style="margin-bottom: 1rem;">Rispondi al ticket</h4>
                    <form id="replyForm">
                        <div class="form-group">
                            <textarea id="replyMessage" placeholder="Scrivi una risposta per l'utente..." style="min-height: 100px;" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Invia Risposta</button>
                    </form>
                </div>
                ` : ''}
            </div>
        </div>
    `,

    // GESTIONE UTENTI
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
                            <th style="text-align:center">Tipo</th>
                            <th>Status</th>
                            <th>Creato</th>
                            <th style="text-align:center">Azioni</th>
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
                    <div class="form-group"><label>Username *</label><input type="text" id="newUsername" required></div>
                    <div class="form-group"><label>Password *</label><input type="password" id="newPassword" required></div>
                    <div class="form-group"><label>Tipo *</label><select id="userType"><option value="USER">Utente</option><option value="ADMIN">Admin</option></select></div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Crea Utente</button>
                </form>
            </div>
        </div>
        <div id="editModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Modifica Utente</h2><button class="close-modal" onclick="closeEditModal()">×</button></div>
                <div id="editError" class="error-message"></div>
                <form id="editForm">
                    <div class="form-group"><label>Username</label><input type="text" id="editUsername"></div>
                    <div class="form-group"><label>Tipo</label><select id="editType"><option value="USER">Utente</option><option value="ADMIN">Admin</option></select></div>
                    <div class="form-group"><label>Status</label><select id="editActive"><option value="1">Attivo</option><option value="0">Inattivo</option></select></div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Salva Modifiche</button>
                </form>
            </div>
        </div>
        <div id="passwordModal" class="modal">
            <div class="modal-content">
                <div class="modal-header"><h2>Cambia Password</h2><button class="close-modal" onclick="closePasswordModal()">×</button></div>
                <div id="passwordError" class="error-message"></div>
                <form id="passwordForm">
                    <div class="form-group"><label>Nuova Password *</label><input type="password" id="newPasswordInput" required></div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Cambia Password</button>
                </form>
            </div>
        </div>
    `
};

// ==================== UTILITY & API ====================

const showError = (m) => { const el = document.getElementById('errorMessage'); if(el){ el.textContent=m; el.style.display='block'; window.scrollTo(0,0); }};
const showSuccess = (m) => { const el = document.getElementById('successMessage'); if(el){ el.textContent=m; el.style.display='block'; window.scrollTo(0,0); }};
const hideMessages = () => { ['errorMessage','successMessage'].forEach(id=>{ const el=document.getElementById(id); if(el)el.style.display='none'; }); };
const formatDate = (d) => new Date(d).toLocaleDateString('it-IT', { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' });

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

// ==================== GLOBAL HANDLERS (Admin & Users) ====================
function attachCommonHandlers() {
    // 1. Nuovo Utente
    const newUserBtn = document.getElementById('newUserBtn');
    if(newUserBtn && !newUserBtn.dataset.bound) {
        newUserBtn.dataset.bound = true;
        newUserBtn.onclick = () => document.getElementById('newUserModal').classList.add('active');
    }

    const newUserForm = document.getElementById('newUserForm');
    if(newUserForm && !newUserForm.dataset.bound) {
        newUserForm.dataset.bound = true;
        newUserForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            try {
                await apiRequest('/api/auth/register', { method: 'POST', body: JSON.stringify({ 
                    username: document.getElementById('newUsername').value, 
                    password: document.getElementById('newPassword').value, 
                    user_type: document.getElementById('userType').value 
                })});
                closeNewUserModal(); 
                if(document.getElementById('usersTable')) loadUsers(); 
                else showSuccess('Utente creato con successo');
            } catch(e) { 
                const errEl = document.getElementById('modalError');
                if(errEl) { errEl.textContent='Errore durante la creazione'; errEl.style.display='block'; }
            }
        });
    }

    // 2. Status Ticket
    const statusForm = document.getElementById('statusForm');
    if(statusForm && !statusForm.dataset.bound) {
        statusForm.dataset.bound = true;
        statusForm.addEventListener('submit', async (e) => {
            e.preventDefault(); 
            try {
                await apiRequest(`/api/tickets/${adminCurrentTicketId}/status`, { method: 'PATCH', body: JSON.stringify({ status: document.getElementById('ticketStatus').value }) });
                closeStatusModal(); 
                loadAdminTickets();
            } catch(e) { 
                const errEl = document.getElementById('statusModalError');
                if(errEl) { errEl.textContent='Errore aggiornamento status'; errEl.style.display='block'; }
            }
        });
    }

    // 3. Edit e Password
    const editForm = document.getElementById('editForm');
    if(editForm && !editForm.dataset.bound) {
        editForm.dataset.bound = true;
        editForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            try {
                await apiRequest(`/api/auth/users/${currentUserId}`, { method: 'PATCH', body: JSON.stringify({ 
                    username: document.getElementById('editUsername').value, 
                    user_type: document.getElementById('editType').value, 
                    is_active: document.getElementById('editActive').value === '1' 
                })});
                closeEditModal(); loadUsers();
            } catch(e) { showError('Errore aggiornamento'); }
        });
    }

    const passwordForm = document.getElementById('passwordForm');
    if(passwordForm && !passwordForm.dataset.bound) {
        passwordForm.dataset.bound = true;
        passwordForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            try {
                await apiRequest(`/api/auth/users/${currentUserId}/password`, { method: 'PATCH', body: JSON.stringify({ new_password: document.getElementById('newPasswordInput').value })});
                closePasswordModal(); showSuccess('Password cambiata');
            } catch(e) { 
                const errEl = document.getElementById('passwordError');
                if(errEl) { errEl.textContent='Errore cambio password'; errEl.style.display='block'; }
            }
        });
    }
}

// ==================== LOGIC: DASHBOARD ====================

async function loadDashboardTickets() {
    try {
        const response = await apiRequest('/api/tickets');
        const tickets = await response.json();
        const container = document.getElementById('ticketsContainer');
        if (tickets.length === 0) {
            container.innerHTML = `<div class="card" style="text-align:center; padding:3rem;"><div style="font-size:3rem; margin-bottom:1rem;">📋</div><h2>Nessun ticket</h2><p style="color:var(--text-muted)">Non hai ancora creato nessun ticket.</p><br><a href="#" data-route="new-ticket" class="btn btn-primary">Crea il tuo primo ticket</a></div>`;
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
        <div style="padding: 1.5rem; display:flex; flex-direction:column; height:100%;">
            <div class="ticket-header">
                <span class="ticket-type">${ticket.ticket_type_desc}</span>
                <span class="ticket-status status-${ticket.status}">${ticket.status_desc}</span>
            </div>
            <div class="ticket-title">${ticket.title}</div>
            <div class="ticket-desc">${ticket.description}</div>
            <div class="ticket-meta">
                <span>#${ticket.id}</span>
                <span>${formatDate(ticket.created_at)}</span>
            </div>
        </div>
    `;
    return card;
}

// ==================== LOGIC: ADMIN ====================

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

        if(!search && !status && !type) {
            document.getElementById('totalTickets').textContent = tickets.length;
            document.getElementById('openTickets').textContent = tickets.filter(x => x.status === 'OPEN').length;
            document.getElementById('inProgressTickets').textContent = tickets.filter(x => x.status === 'IN_PROGRESS').length;
            document.getElementById('closedTickets').textContent = tickets.filter(x => x.status === 'CLOSED').length;
        }
        renderAdminTicketsTable(tickets);
        setupAdminFilters();
        attachCommonHandlers(); 

    } catch (e) { console.error(e); showError('Errore caricamento ticket'); }
}

function renderAdminTicketsTable(tickets) {
    const tbody = document.getElementById('ticketsTable'); tbody.innerHTML = '';
    if (tickets.length === 0) { tbody.innerHTML = '<tr><td colspan="7" style="text-align:center; padding:2rem; color:var(--text-muted)">Nessun ticket trovato</td></tr>'; return; }
    tickets.forEach(t => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td style="color:var(--primary-start); font-weight:600">#${t.id}</td>
            <td style="font-weight:600; max-width:250px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${t.title}</td>
            <td><span class="ticket-type">${t.ticket_type_desc}</span></td>
            <td>${t.creator}</td>
            <td><span class="ticket-status status-${t.status}">${t.status_desc}</span></td>
            <td style="white-space:nowrap; font-size:0.8rem;">${formatDate(t.created_at)}</td>
            <td>
                <div class="actions-wrapper">
                    <button class="btn btn-primary btn-sm" onclick="router.navigate('ticket-detail', { id: ${t.id} })">Vedi</button>
                    <button class="btn btn-secondary btn-sm" onclick="openStatusModal(${t.id}, '${t.status}')">Status</button>
                </div>
            </td>
        `;
        tbody.appendChild(tr);
    });
}

function setupAdminFilters() {
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
}

// ==================== LOGIC: TICKET DETAIL ====================

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
            <div>
                <span class="ticket-type" style="margin-right:10px;">${ticket.ticket_type_desc}</span>
                <span class="ticket-status status-${ticket.status}">${ticket.status_desc}</span>
            </div>
            <div style="font-size:0.85rem; color:var(--text-muted);">${formatDate(ticket.created_at)}</div>
        </div>
        <h1 style="margin-bottom:1rem; font-size:1.8rem;">${ticket.title}</h1>
        <div style="background:rgba(0,0,0,0.2); padding:1.5rem; border-radius:8px; border:1px solid var(--glass-border); margin-bottom:1.5rem;">
            <div style="font-size:0.8rem; text-transform:uppercase; color:var(--text-muted); margin-bottom:0.5rem;">Descrizione</div>
            <div style="line-height:1.7;">${ticket.description}</div>
        </div>
        <div style="display:flex; justify-content:space-between; align-items:center;">
            <div style="font-size:0.9rem;">Creato da: <strong>${ticket.creator}</strong></div>
            ${(ticket.user_id === auth.getUser().id && ticket.status === 'OPEN') ? 
                `<button class="btn btn-primary" onclick="document.getElementById('editForm').style.display='block'">Modifica Ticket</button>` : ''}
        </div>
    `;
    
    container.appendChild(card);

    // Edit Form Block
    const editDiv = document.createElement('div'); editDiv.className = 'card edit-form'; editDiv.id = 'editForm'; editDiv.style.display = 'none'; editDiv.style.marginTop = '20px';
    editDiv.innerHTML = `
        <div class="header"><h3>Modifica Ticket</h3></div>
        <form id="updateForm">
            <div class="form-group"><label>Titolo</label><input id="editTitle" value="${ticket.title}"></div>
            <div class="form-group"><label>Descrizione</label><textarea id="editDesc" rows="5">${ticket.description}</textarea></div>
            <div style="display:flex; gap:10px;">
                <button type="submit" class="btn btn-primary">Salva Modifiche</button>
                <button type="button" class="btn btn-secondary" onclick="this.closest('.edit-form').style.display='none'">Annulla</button>
            </div>
        </form>`;
    container.appendChild(editDiv);
    
    document.getElementById('updateForm')?.addEventListener('submit', async (e) => {
        e.preventDefault();
        try {
            await apiRequest(`/api/tickets/${ticket.id}`, { method: 'PATCH', body: JSON.stringify({ title: document.getElementById('editTitle').value, description: document.getElementById('editDesc').value }) });
            loadTicketDetail({id: ticket.id});
        } catch(e){ showError('Errore aggiornamento'); }
    });

    // Messages
    const msgSection = document.getElementById('messagesSection');
    const msgList = document.getElementById('messagesList');
    if(msgSection) {
        msgSection.style.display = 'block';
        msgList.innerHTML = '';
        if(ticket.messages && ticket.messages.length > 0) {
            ticket.messages.forEach(m => {
                const isAdminMsg = m.sender_role === 'ADMIN';
                const div = document.createElement('div');
                div.className = `msg-bubble ${isAdminMsg ? 'msg-admin' : 'msg-user'}`;
                div.innerHTML = `
                    <div style="display:flex; justify-content:space-between; font-size:0.75rem; color:var(--text-muted); margin-bottom:0.5rem; border-bottom:1px solid var(--glass-border); padding-bottom:0.5rem;">
                        <span style="font-weight:700; color:${isAdminMsg ? '#818cf8' : '#fff'}">${m.sender} ${isAdminMsg ? '(Staff)' : ''}</span>
                        <span>${formatDate(m.created_at)}</span>
                    </div>
                    <div>${m.message.replace(/\n/g, '<br>')}</div>
                `;
                msgList.appendChild(div);
            });
        } else {
            msgList.innerHTML = '<p style="color:var(--text-muted); font-style:italic; padding:1rem; text-align:center; background:var(--glass-bg); border-radius:8px;">Nessuna risposta presente.</p>';
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

// ==================== LOGIC: USERS ====================

async function loadUsers() {
    try {
        const response = await apiRequest('/api/auth/users');
        const users = await response.json();
        
        // Stats
        document.getElementById('totalUsers').textContent = users.length;
        document.getElementById('adminCount').textContent = users.filter(x => x.user_type === 'ADMIN').length;
        document.getElementById('userCount').textContent = users.filter(x => x.user_type === 'USER').length;
        document.getElementById('activeCount').textContent = users.filter(x => x.is_active).length;

        const tbody = document.getElementById('usersTable');
        tbody.innerHTML = '';
        users.forEach(u => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td style="color:var(--primary-start)">#${u.id}</td>
                <td style="font-weight:600">${u.username}</td>
                <td style="text-align:center"><span class="user-badge badge-${u.user_type.toLowerCase()}">${u.user_type}</span></td>
                <td><span class="status-badge status-${u.is_active ? 'active' : 'inactive'}">${u.is_active ? 'Attivo' : 'Inattivo'}</span></td>
                <td>${formatDate(u.created_at)}</td>
                <td>
                    <div class="actions-wrapper">
                        <button class="btn btn-primary btn-sm" onclick="editUser(${u.id}, '${u.username}', '${u.user_type}', ${u.is_active})">Modifica</button>
                        <button class="btn btn-secondary btn-sm" onclick="changePwd(${u.id})">Password</button>
                        ${u.id !== auth.getUser().id ? `<button class="btn btn-danger btn-sm" onclick="deleteUser(${u.id})">X</button>` : ''}
                    </div>
                </td>
            `;
            tbody.appendChild(tr);
        });
        
        attachCommonHandlers(); 

    } catch (error) { console.error(error); showError('Errore caricamento utenti'); }
}

// User Helpers (Global scope for onclick)
let currentUserId = null;
window.editUser = (id, user, type, active) => {
    currentUserId = id;
    document.getElementById('editUsername').value = user;
    document.getElementById('editType').value = type;
    document.getElementById('editActive').value = active ? '1' : '0';
    document.getElementById('editModal').classList.add('active');
};
window.changePwd = (id) => { currentUserId = id; document.getElementById('passwordModal').classList.add('active'); };
window.deleteUser = async (id) => {
    if (!confirm(`Eliminare utente?`)) return;
    try { await apiRequest(`/api/auth/users/${id}`, { method: 'DELETE' }); loadUsers(); } catch (e) { showError('Errore'); }
};
window.closeEditModal = () => document.getElementById('editModal').classList.remove('active');
window.closePasswordModal = () => document.getElementById('passwordModal').classList.remove('active');
window.closeNewUserModal = () => document.getElementById('newUserModal').classList.remove('active');
window.openStatusModal = (id, status) => { adminCurrentTicketId = id; document.getElementById('ticketStatus').value = status; document.getElementById('statusModal').classList.add('active'); };
window.closeStatusModal = () => document.getElementById('statusModal').classList.remove('active');

// ==================== NEW TICKET LOGIC ====================
async function loadNewTicketLogic() {
    try {
        const res = await apiRequest('/api/tickets/meta/types');
        const types = await res.json();
        const sel = document.getElementById('ticketType');
        types.forEach(t => { const o=document.createElement('option'); o.value=t.code; o.textContent=t.description; sel.appendChild(o); });
    } catch(e){}

    document.getElementById('ticketForm')?.addEventListener('submit', async (e) => {
        e.preventDefault();
        try {
            const body = { ticket_type: document.getElementById('ticketType').value, title: document.getElementById('title').value, description: document.getElementById('description').value };
            const res = await apiRequest('/api/tickets', { method: 'POST', body: JSON.stringify(body) });
            if(res.ok) router.navigate(auth.isAdmin()?'admin':'dashboard');
        } catch(e) { showError('Errore creazione'); }
    });
}

// ==================== INIT ====================

document.addEventListener('DOMContentLoaded', () => {
    const content = document.getElementById('app-content');
    router.init(content);

    router.register('dashboard', { path: '/dashboard', showNavbar: true, template: templates.dashboard, onLoad: loadDashboardTickets });
    router.register('admin', { path: '/admin', showNavbar: true, requiresAdmin: true, template: templates.admin, onLoad: async () => { await loadAdminTickets(); } });
    router.register('new-ticket', { path: '/new-ticket', showNavbar: true, template: templates.newTicket, onLoad: loadNewTicketLogic });
    router.register('ticket-detail', { path: '/ticket-detail', showNavbar: true, template: templates.ticketDetail, onLoad: loadTicketDetail });
    router.register('users', { path: '/users', showNavbar: true, requiresAdmin: true, template: templates.users, onLoad: loadUsers });

    router.navigate(auth.isAdmin() ? 'admin' : 'dashboard');
});