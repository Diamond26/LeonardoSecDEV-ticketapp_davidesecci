/**
 * Socket Manager - Helper functions for sending notifications via Socket.IO
 */

const db = require('../config/database');

let io = null;

/**
 * Initialize socket manager with io instance
 * @param {Server} ioInstance - Socket.IO server instance
 */
const initialize = (ioInstance) => {
    io = ioInstance;
};

/**
 * Send notification to a specific user
 * @param {number} userId - User ID to send notification to
 * @param {object} notification - Notification object
 */
const notifyUser = async (userId, notification) => {
    if (!io) {
        return;
    }

    try {
        // Save notification to database using Stored Procedure
        const [result] = await db.query(
            'CALL sp_add_notification(?, ?, ?, ?, ?)',
            [userId, notification.type || 'info', notification.title || '', notification.message, notification.ticketId || null]
        );

        const notificationId = result[0][0].notification_id;

        const notificationData = {
            id: notificationId,
            timestamp: new Date().toISOString(),
            read: false,
            ...notification
        };

        // Send via Socket.IO
        io.to(`user_${userId}`).emit('notification', notificationData);
    } catch (error) {
    }
};

/**
 * Send notification to all admins
 * @param {object} notification - Notification object
 */
const notifyAdmins = async (notification) => {
    if (!io) {
        return;
    }

    try {
        // Get all admin users
        const [result] = await db.query('CALL sp_get_admin_users()');
        const admins = result[0];

        // Save notification for each admin using SP
        for (const admin of admins) {
            await db.query(
                'CALL sp_add_notification(?, ?, ?, ?, ?)',
                [admin.id, notification.type || 'info', notification.title || '', notification.message, notification.ticketId || null]
            );
        }

        const notificationData = {
            id: Date.now(), // Admin broadcast uses temp ID for socket event, real IDs are in DB per admin
            timestamp: new Date().toISOString(),
            read: false,
            ...notification
        };

        // Send via Socket.IO to all admins
        io.to('admins').emit('notification', notificationData);
    } catch (error) {
    }
};

/**
 * Send notification to ticket participants (creator and admins)
 * @param {number} ticketId - Ticket ID
 * @param {number} creatorId - Ticket creator user ID
 * @param {object} notification - Notification object
 */
const notifyTicketParticipants = (ticketId, creatorId, notification) => {
    if (!io) {
        return;
    }

    const notificationData = {
        id: Date.now(),
        timestamp: new Date().toISOString(),
        read: false,
        ticketId,
        ...notification
    };

    // Notify ticket creator
    notifyUser(creatorId, notificationData);

    // Notify all admins
    notifyAdmins(notificationData);
};

/**
 * Emit ticket update event to refresh ticket lists
 * @param {string} room - Room to emit to ('admins' or 'user_X')
 */
const emitTicketUpdate = (room) => {
    if (!io) {
        return;
    }

    io.to(room).emit('ticket_updated');
};

module.exports = {
    initialize,
    notifyUser,
    notifyAdmins,
    notifyTicketParticipants,
    emitTicketUpdate
};
