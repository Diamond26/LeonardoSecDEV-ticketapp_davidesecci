const express = require('express'), path = require('path'), helmet = require('helmet'), cors = require('cors');
const http = require('http');
const { Server } = require('socket.io');
const jwt = require('jsonwebtoken');
const socketManager = require('./utils/socketManager');
const authRoutes = require('./routes/auth'), ticketRoutes = require('./routes/tickets'), adminRoutes = require('./routes/admin'), notificationRoutes = require('./routes/notifications');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Create HTTP server
const server = http.createServer(app);

// Configure Socket.IO with CORS
const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

// Initialize socket manager
socketManager.initialize(io);

// Socket.IO authentication middleware
io.use((socket, next) => {
    const token = socket.handshake.auth.token;

    if (!token) {
        return next(new Error('Authentication error: Token missing'));
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
            return next(new Error('Authentication error: Invalid token'));
        }

        // Attach user info to socket
        socket.user = decoded;
        next();
    });
});

// Store connected users (userId -> socketId mapping)
const connectedUsers = new Map();

// Socket.IO connection handling
io.on('connection', (socket) => {

    // Store user connection
    connectedUsers.set(socket.user.id, socket.id);

    // Join user-specific room
    const userRoom = `user_${socket.user.id}`;
    socket.join(userRoom);

    // Join admin room if user is admin
    if (socket.user.user_type_code === 'ADMIN') { // Assuming user_type_code is used for isAdmin check
        socket.join('admins');
    }

    // Chat: Join ticket room
    socket.on('join-ticket-room', (data) => {
        const { ticketId } = data;
        const roomName = `ticket-${ticketId}`;

        socket.join(roomName);

        // Notify room that user joined
        socket.to(roomName).emit('user-joined', {
            userId: socket.user.id,
            username: socket.user.username,
            ticketId
        });
    });

    // Chat: Leave ticket room
    socket.on('leave-ticket-room', (data) => {
        const { ticketId } = data;
        const roomName = `ticket-${ticketId}`;

        socket.leave(roomName);
    });

    // Chat: Send message
    socket.on('send-message', async (data) => {
        const { ticketId, message } = data;
        const roomName = `ticket-${ticketId}`;
        const db = require('./config/database'); // Moved inside to avoid circular dependency if db also requires socketManager

        try {
            // Save message to database using Stored Procedure
            const [result] = await db.query(
                'CALL sp_add_ticket_message(?, ?, ?)',
                [ticketId, socket.user.id, message]
            );

            // SP returns the ID in the first result set
            const insertId = result[0][0].message_id;

            const messageData = {
                id: result.insertId,
                ticket_id: ticketId,
                user_id: socket.user.id,
                username: socket.user.username,
                message: message,
                created_at: new Date().toISOString(),
                isAdmin: socket.user.user_type_code === 'ADMIN' // Assuming isAdmin is derived from user_type_code
            };

            // Broadcast to all users in the room (including sender)
            io.to(roomName).emit('new-message', messageData);
        } catch (error) {
            socket.emit('message-error', { error: 'Failed to send message' });
        }
    });

    socket.on('disconnect', () => {
        connectedUsers.delete(socket.user.id);
    });
});

// Export io instance for use in routes
app.set('io', io);

// Express middleware
app.use(helmet({ contentSecurityPolicy: false }));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/tickets', ticketRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/notifications', notificationRoutes);

// Catch-all route
app.get('*', (req, res) => res.sendFile(path.join(__dirname, 'public', 'login.html')));

// Error handling
app.use((err, req, res, next) => {
    res.status(500).json({ error: 'Errore interno del server' });
});

// Start server
server.listen(PORT, () => console.log(`Server in esecuzione su http://localhost:${PORT}`));
