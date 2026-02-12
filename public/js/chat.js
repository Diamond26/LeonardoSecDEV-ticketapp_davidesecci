/**
 * ChatManager - Handles real-time chat functionality for ticket conversations
 */
class ChatManager {
    constructor() {
        this.socket = null;
        this.currentTicketId = null;
        this.messages = [];
        this.onMessageCallback = null;
    }

    /**
     * Initialize chat for a specific ticket
     * @param {number} ticketId - Ticket ID
     * @param {string} token - JWT token
     * @param {function} onMessage - Callback for new messages
     */
    async initialize(ticketId, token, onMessage) {
        this.currentTicketId = ticketId;
        this.onMessageCallback = onMessage;

        // Use existing Socket.IO connection from notificationManager
        if (window.notificationManager && window.notificationManager.socket) {
            this.socket = window.notificationManager.socket;
        } else {
            return;
        }

        // Setup listeners
        this.setupSocketListeners();

        // If socket is already connected, join room and load history
        if (this.socket.connected) {
            this.joinRoom();
            await this.loadMessageHistory(token);
        } else {
            // Wait for connection
            this.socket.once('connect', async () => {
                this.joinRoom();
                await this.loadMessageHistory(token);
            });
        }
    }

    setupSocketListeners() {
        // Listen for new messages
        this.socket.on('new-message', (messageData) => {
            this.handleNewMessage(messageData);
        });

        // Listen for user joined events
        this.socket.on('user-joined', (data) => {
        });

        // Listen for message errors
        this.socket.on('message-error', (error) => {
            alert('Failed to send message. Please try again.');
        });
    }

    joinRoom() {
        // Join ticket room
        this.socket.emit('join-ticket-room', { ticketId: this.currentTicketId });
    }

    /**
     * Load message history from API
     * @param {string} token - JWT token
     */
    async loadMessageHistory(token) {
        try {
            const response = await fetch(`/api/tickets/${this.currentTicketId}/messages`, {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to load messages');
            }

            const messages = await response.json();
            this.messages = messages;

            // Render all messages
            if (this.onMessageCallback) {
                messages.forEach(msg => this.onMessageCallback(msg));
            }

            // Scroll to bottom
            this.scrollToBottom();
        } catch (error) {
        }
    }

    /**
     * Handle new message received via Socket.IO
     * @param {object} messageData - Message data
     */
    handleNewMessage(messageData) {
        // Only process if it's for the current ticket
        if (messageData.ticket_id !== this.currentTicketId) {
            return;
        }

        // Add to messages array
        this.messages.push(messageData);

        // Call callback to render message
        if (this.onMessageCallback) {
            this.onMessageCallback(messageData);
        }

        // Scroll to bottom
        this.scrollToBottom();
    }

    /**
     * Send a message
     * @param {string} message - Message text
     */
    sendMessage(message) {
        if (!message || !message.trim()) {
            return;
        }

        if (!this.socket || !this.currentTicketId) {
            return;
        }

        // Emit message via Socket.IO
        this.socket.emit('send-message', {
            ticketId: this.currentTicketId,
            message: message.trim()
        });
    }

    /**
     * Scroll chat to bottom
     */
    scrollToBottom() {
        setTimeout(() => {
            const chatMessages = document.getElementById('chatMessages');
            if (chatMessages) {
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }
        }, 100);
    }

    /**
     * Leave current ticket room
     */
    leave() {
        if (this.socket && this.currentTicketId) {
            this.socket.emit('leave-ticket-room', { ticketId: this.currentTicketId });
            this.socket.off('new-message');
            this.socket.off('user-joined');
            this.socket.off('message-error');
        }

        this.currentTicketId = null;
        this.messages = [];
        this.onMessageCallback = null;
    }

    /**
     * Format timestamp for display
     * @param {string} timestamp - ISO timestamp
     * @returns {string} Formatted time
     */
    formatTime(timestamp) {
        const date = new Date(timestamp);
        const now = new Date();
        const diff = now - date;
        const minutes = Math.floor(diff / 60000);

        if (minutes < 1) return 'Adesso';
        if (minutes < 60) return `${minutes} min fa`;

        const hours = Math.floor(minutes / 60);
        if (hours < 24) return `${hours} ore fa`;

        return date.toLocaleDateString('it-IT', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    }
}

// Create global instance
const chatManager = new ChatManager();
