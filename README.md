# SecureCorp — Ticketing System

Sistema di ticketing web sviluppato come progetto individuale nell'ambito del corso LeonardoSecDEV.  
Architettura client-server con frontend SPA in HTML/CSS/JavaScript, backend REST in Node.js/Express e database MySQL.

---

## Tecnologie utilizzate

| Categoria | Tecnologie |
|---|---|
| Runtime | Node.js |
| Framework | Express |
| Database | MySQL (`mysql2`) |
| Autenticazione | JWT (`jsonwebtoken`), bcryptjs |
| Real-time | Socket.io |
| Sicurezza | Helmet, CORS, express-rate-limit |
| Utility | dotenv, uuid |
| Dev | nodemon |
| Frontend | HTML, CSS, JavaScript (AJAX) |

---

## Funzionalità implementate

**Utente standard**
- Autenticazione tramite JWT (access token 15 min + refresh token 7 giorni)
- Visualizzazione dei propri ticket
- Creazione di nuovi ticket
- Modifica ticket in stato `OPEN`
- Notifiche in tempo reale via Socket.io

**Amministratore**
- Visualizzazione di tutti i ticket
- Gestione del ciclo di vita: `OPEN` → `IN_PROGRESS` → `CLOSED`
- Creazione, modifica, cambio password ed eliminazione utenti

---

## Sicurezza

- Password hashate con **bcryptjs**
- Query SQL parametrizzate (prevenzione SQL injection)
- Sanitizzazione output tramite `textContent` (prevenzione XSS)
- Rate limiting su endpoint di login e refresh
- HTTP security headers via **Helmet**
- Configurazione CORS
- Controllo ruoli `user` / `admin` su ogni route protetta

---

## Struttura del progetto

```
ticketapp/
├── config/           # Connessione al database
├── middleware/       # Autenticazione JWT, controllo ruoli
├── routes/           # Endpoint API (auth, tickets, users)
├── utils/            # Funzioni di utilità
├── public/           # Frontend statico (HTML, CSS, JS)
├── app.js            # Entry point, configurazione Express
├── auth.js           # Logica autenticazione
├── database.sql      # Schema e dati iniziali del database
└── setup-users.js    # Script di inizializzazione utenti
```

---

## API

### Autenticazione

| Metodo | Endpoint | Accesso |
|---|---|---|
| `POST` | `/api/auth/login` | Pubblico |
| `POST` | `/api/auth/refresh` | Pubblico |
| `POST` | `/api/auth/logout` | Autenticato |
| `POST` | `/api/auth/register` | Solo admin |

### Ticket

| Metodo | Endpoint | Accesso |
|---|---|---|
| `GET` | `/api/tickets` | Autenticato |
| `GET` | `/api/tickets/:id` | Autenticato |
| `POST` | `/api/tickets` | Autenticato |
| `PATCH` | `/api/tickets/:id` | Proprietario (stato `OPEN`) |
| `PATCH` | `/api/tickets/:id/status` | Solo admin |
| `GET` | `/api/tickets/meta/types` | Autenticato |

Header richiesto per tutte le route protette:
```
Authorization: Bearer <accessToken>
```

---

## Avvio in locale

### Prerequisiti

- Node.js ≥ 18
- MySQL ≥ 8

### Installazione

```bash
# Clona il repository
git clone https://github.com/Diamond26/LeonardoSecDEV-ticketapp_davidesecci.git
cd LeonardoSecDEV-ticketapp_davidesecci

# Installa le dipendenze
npm install

# Inizializza il database
mysql -u root -p < database.sql

# Crea il file di configurazione
cp .env.example .env
# Modifica .env con le tue credenziali

# Avvia il server
npm run dev     # sviluppo (auto-reload)
npm start       # produzione
```

Il server sarà disponibile su `http://localhost:3000`.

### Variabili d'ambiente (.env)

```env
DB_HOST=localhost
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_NAME=securecorp
DB_PORT=3306

JWT_SECRET=your-secret-key
JWT_ACCESS_EXPIRATION=15m
JWT_REFRESH_EXPIRATION=7d

PORT=3000
NODE_ENV=development
```

> In produzione: sostituire `JWT_SECRET` con una stringa casuale sicura, usare credenziali MySQL dedicate e abilitare HTTPS.

---

## Credenziali di test

| Ruolo | Username | Password |
|---|---|---|
| Admin | `admin` | `admin` |
| Utente | `utente` | `utente` |

---

## Licenza

Tutti i diritti riservati © Davide Secci.
