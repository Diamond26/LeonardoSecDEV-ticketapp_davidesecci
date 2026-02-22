const express = require('express'), router = express.Router(), bcrypt = require('bcryptjs'), jwt = require('jsonwebtoken'), { v4: uuidv4 } = require('uuid'), db = require('../config/database'), { authenticateToken } = require('../middleware/auth'), rateLimit = require('express-rate-limit');
const loginLimiter = rateLimit({ windowMs: 15 * 60 * 1000, max: 5, message: { error: 'Troppi tentativi di login riprova tra 15 minuti.' }, standardHeaders: true, legacyHeaders: false });
const refreshLimiter = rateLimit({ windowMs: 15 * 60 * 1000, max: 10, message: { error: 'Troppi tentativi di refresh riprova più tardi.' } });

router.post('/register', authenticateToken, async (req, res) => {
    try {
        const { username, password, user_type } = req.body;
        if (req.user.user_type_code !== 'ADMIN') return res.status(403).json({ error: 'Non autorizzato' });
        if (!username || !password || !user_type) return res.status(400).json({ error: 'Username, password e tipo utente sono obbligatori' });
        if (username.length < 3 || username.length > 50) return res.status(400).json({ error: 'Username deve essere tra 3 e 50 caratteri' });
        if (password.length < 6) return res.status(400).json({ error: 'Password deve essere almeno 6 caratteri' });
        if (!['USER', 'ADMIN'].includes(user_type)) return res.status(400).json({ error: 'Tipo utente non valido' });

        // Check if user exists using SP
        const [existingUsers] = await db.query('CALL sp_get_user_by_username(?)', [username]);
        if (existingUsers[0].length > 0) return res.status(400).json({ error: 'Username già esistente' });

        const password_hash = await bcrypt.hash(password, 10);

        // Register user using SP
        const [result] = await db.query('CALL register_user(?, ?, ?)', [username, password_hash, user_type]);

        // SP returns result set with user_id
        res.status(201).json({ message: 'Utente registrato con successo', user_id: result[0][0].user_id });
    } catch (error) {
        console.error("Register error:", error);
        res.status(500).json({ error: 'Errore durante la registrazione' });
    }
});

router.post('/login', loginLimiter, async (req, res) => {
    try {
        const { username, password } = req.body;
        if (!username || !password) return res.status(400).json({ error: 'Credenziali non valide' });

        // Get user using SP
        const [usersResult] = await db.query('CALL sp_get_user_by_username(?)', [username]);
        const users = usersResult[0];

        if (users.length === 0) return res.status(401).json({ error: 'Credenziali non valide' });
        const user = users[0];
        if (!user.is_active) return res.status(401).json({ error: 'Credenziali non valide' });
        const passwordMatch = await bcrypt.compare(password, user.password_hash);
        if (!passwordMatch) return res.status(401).json({ error: 'Credenziali non valide' });

        const accessToken = jwt.sign({ id: user.id, username: user.username, user_type_code: user.user_type_code }, process.env.JWT_SECRET, { expiresIn: process.env.JWT_ACCESS_EXPIRATION });
        const jti = uuidv4(), refreshToken = jwt.sign({ id: user.id, jti }, process.env.JWT_SECRET, { expiresIn: process.env.JWT_REFRESH_EXPIRATION });
        const tokenHash = await bcrypt.hash(refreshToken, 10), expiresAt = new Date();
        expiresAt.setDate(expiresAt.getDate() + 7);

        // Insert JWT using SP
        await db.query('CALL login_jwt(?, ?, ?, ?)', [user.id, jti, tokenHash, expiresAt]);

        res.json({ accessToken, refreshToken, user: { id: user.id, username: user.username, user_type: user.user_type_code } });
    } catch (error) {
        console.error("Login error:", error);
        res.status(500).json({ error: 'Errore durante il login' });
    }
});

router.post('/refresh', refreshLimiter, async (req, res) => {
    try {
        const { refreshToken } = req.body;
        if (!refreshToken) return res.status(401).json({ error: 'Refresh token mancante' });
        let decoded;
        try { decoded = jwt.verify(refreshToken, process.env.JWT_SECRET); }
        catch (error) { return res.status(403).json({ error: 'Refresh token non valido' }); }

        // Get token info using SP
        const [tokensResult] = await db.query('CALL refresh_jwt(?)', [decoded.jti]);
        const tokens = tokensResult[0];

        if (tokens.length === 0) return res.status(403).json({ error: 'Refresh token non valido o revocato' });
        const tokenData = tokens[0], tokenMatch = await bcrypt.compare(refreshToken, tokenData.token_hash);
        if (!tokenMatch) return res.status(403).json({ error: 'Refresh token non valido' });

        const newAccessToken = jwt.sign({ id: tokenData.user_id, username: tokenData.username, user_type_code: tokenData.user_type_code }, process.env.JWT_SECRET, { expiresIn: process.env.JWT_ACCESS_EXPIRATION });
        res.json({ accessToken: newAccessToken });
    } catch (error) {
        console.error("Refresh error:", error);
        res.status(500).json({ error: 'Errore durante il refresh del token' });
    }
});

router.post('/logout', authenticateToken, async (req, res) => {
    try {
        const { refreshToken } = req.body;
        if (!refreshToken) return res.status(400).json({ error: 'Refresh token mancante' });
        const decoded = jwt.decode(refreshToken);
        if (!decoded || !decoded.jti) return res.status(400).json({ error: 'Token non valido' });

        // Logout using SP
        await db.query('CALL logout_jwt(?, ?)', [decoded.jti, req.user.id]);

        res.json({ message: 'Logout effettuato con successo' });
    } catch (error) {
        console.error("Logout error:", error);
        res.status(500).json({ error: 'Errore durante il logout' });
    }
});

router.get('/me', authenticateToken, async (req, res) => {
    try {
        // Get me using SP
        const [usersResult] = await db.query('CALL get_me(?)', [req.user.id]);
        const users = usersResult[0];

        if (users.length === 0) return res.status(404).json({ error: 'Utente non trovato' });
        res.json(users[0]);
    } catch (error) {
        console.error("Me error:", error);
        res.status(500).json({ error: 'Errore durante il recupero delle informazioni utente' });
    }
});

module.exports = router;
