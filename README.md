# 🔐 SecureCorp – Ticketing System

Sistema di ticketing web **One-Page (SPA style)** con autenticazione JWT, gestione ruoli utente/admin e API REST.  
Frontend in HTML/CSS/JavaScript, backend in **Node.js (Express)** con database **MySQL**.

---

## 🚀 Avvio rapido

### 1. Installa le dipendenze

```bash
npm install
```

### 2. Inizializza il database

```bash
mysql -u root -p < database.sql
```

### 3. Crea il file `.env`

Vedi la sezione [Configurazione](#-configurazione-env) qui sotto.

### 4. Avvia il server

```bash
# Produzione
npm start

# Sviluppo (con auto-reload)
npm run dev
```

Apri il browser su: **http://localhost:3000**

---

## ⚙️ Configurazione (.env)

```env
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
```

> ⚠️ In produzione: cambia `JWT_SECRET`, le credenziali MySQL e usa **HTTPS**.

---

## 🧪 Credenziali di test

| Ruolo | Username | Password | Pagina |
|-------|----------|----------|--------|
| Admin | `admin` | `admin` | `/template/admin.html` |
| Utente | `utente` | `utente` | `/template/dashboard.html` |

---

## 📡 API

### Autenticazione

| Metodo | Endpoint | Accesso |
|--------|----------|---------|
| `POST` | `/api/auth/login` | Pubblico |
| `POST` | `/api/auth/refresh` | Pubblico |
| `POST` | `/api/auth/logout` | Autenticato |
| `POST` | `/api/auth/register` | Solo admin |

### Ticket

| Metodo | Endpoint | Accesso |
|--------|----------|---------|
| `GET` | `/api/tickets` | Autenticato |
| `GET` | `/api/tickets/:id` | Autenticato |
| `POST` | `/api/tickets` | Autenticato |
| `PATCH` | `/api/tickets/:id` | Proprietario (stato `OPEN`) |
| `PATCH` | `/api/tickets/:id/status` | Solo admin |
| `GET` | `/api/tickets/meta/types` | Autenticato |

**Header richiesto per tutte le rotte protette:**

```
Authorization: Bearer <accessToken>
```

---

## 👤 Funzionalità Utente Standard

- Login / Logout
- Visualizzazione dei propri ticket
- Creazione di nuovi ticket
- Modifica ticket (solo se in stato `OPEN`)
- Notifiche in tempo reale via Socket.io

---

## 🛡️ Funzionalità Amministratore

- Visualizzazione di tutti i ticket
- Cambio stato ticket (`OPEN` → `IN_PROGRESS` → `CLOSED`)
- Gestione utenti:
  - Creazione
  - Modifica
  - Cambio password
  - Eliminazione (non se stesso)

---

## 🔒 Sicurezza

- Autenticazione JWT (access token 15m + refresh token 7d)
- Password hashate con **bcryptjs**
- Query SQL parametrizzate (prevenzione SQL injection)
- Prevenzione XSS tramite `textContent`
- Rate limiting su login e refresh
- **Helmet** (HTTP security headers) e **CORS**
- Controllo ruoli `user` / `admin` su ogni route

---

## 🛠️ Troubleshooting

| Problema | Soluzione |
|----------|-----------|
| MySQL non parte | Avvia il servizio MySQL |
| `Access denied` MySQL | Controlla le credenziali nel `.env` |
| `Cannot find module` | Esegui `npm install` |
| Token non valido | Verifica `JWT_SECRET` nel `.env` |
| Accesso admin negato | Effettua il login come admin |

---

## 📦 Tecnologie usate

| Categoria | Tecnologie |
|-----------|-----------|
| Runtime | Node.js |
| Framework | Express |
| Database | MySQL (`mysql2`) |
| Autenticazione | JWT (`jsonwebtoken`), bcryptjs |
| Real-time | Socket.io |
| Sicurezza | Helmet, CORS, express-rate-limit |
| Utility | dotenv, uuid |
| Dev | nodemon |
| Frontend | HTML, CSS, JavaScript (AJAX) |
