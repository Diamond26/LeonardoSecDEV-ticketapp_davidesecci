# 🔐 SecureCorp – Ticketing System

Sistema di ticketing web con autenticazione JWT, ruoli utente/admin e API REST.
Frontend in HTML/CSS/JavaScript, backend in Node.js (Express) con database MySQL.

---

## Avvio rapido

1. Installa le dipendenze:
npm install

2. Inizializza il database:
mysql -u root -p < db_setup.sql

3. Crea il file .env (vedi sezione sotto)

4. Avvia il server:
npm start

Apri il browser su:
http://localhost:3000

---

## Configurazione (.env)

DB_HOST=localhost  
DB_USER=securecorp_user  
DB_PASSWORD=SecurePassword123!  
DB_NAME=securecorp  
DB_PORT=3306  

JWT_SECRET=change-this-in-production  
JWT_ACCESS_EXPIRATION=15m  
JWT_REFRESH_EXPIRATION=7d  

PORT=3000  
NODE_ENV=development  

In produzione è necessario cambiare JWT_SECRET, le credenziali MySQL e usare HTTPS.

---

## Credenziali di test

Admin  
username: admin  
password: admin  
pagina: /admin.html  

Utente  
username: utente  
password: utente  
pagina: /dashboard.html  

---

## API

Autenticazione:
POST /api/auth/login  
POST /api/auth/refresh  
POST /api/auth/logout  
POST /api/auth/register (solo admin)  

Ticket:
GET /api/tickets  
GET /api/tickets/:id  
POST /api/tickets  
PATCH /api/tickets/:id (solo proprietario se OPEN)  
PATCH /api/tickets/:id/status (solo admin)  
GET /api/tickets/meta/types  

Header richiesto:
Authorization: Bearer <accessToken>

---

## Funzionalità Utente Standard

- Login
- Visualizzazione dei propri ticket
- Creazione ticket
- Modifica ticket solo se stato OPEN
- Logout

---

## Funzionalità Amministratore

- Visualizza tutti i ticket
- Cambia stato ticket (OPEN, IN_PROGRESS, CLOSED)
- Gestione utenti:
  - creazione
  - modifica
  - cambio password
  - eliminazione (non se stesso)

---

## Sicurezza

- Autenticazione JWT (access token + refresh token)
- Password hashate con bcrypt
- Query SQL parametrizzate
- Prevenzione XSS tramite textContent
- Rate limiting su login e refresh
- Helmet e CORS
- Controllo ruoli user/admin

---

## Troubleshooting

MySQL non parte → avvia il servizio MySQL  
Access denied MySQL → controlla credenziali nel .env  
Cannot find module → esegui npm install  
Token non valido → verifica JWT_SECRET  
Accesso admin negato → login come admin  

---

## Tecnologie usate

Node.js  
Express  
MySQL  
JWT  
bcrypt  
dotenv  
helmet  
cors  
express-rate-limit  


