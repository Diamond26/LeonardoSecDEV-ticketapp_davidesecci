/**
 * Notification System - Socket.IO client for real-time notifications
 */

class NotificationManager {
    constructor() {
        this.socket = null;
        this.notifications = [];
        this.unreadCount = 0;
        this.onNotificationCallback = null;
    }

    /**
     * Initialize Socket.IO connection with authentication
     * @param {string} token - JWT access token
     */
    connect(token) {
        if (!token) {
            return;
        }

        // Connect to Socket.IO server with authentication
        this.socket = io({
            auth: {
                token: token
            }
        });

        // Connection event handlers
        this.socket.on('connect', () => {
        });

        this.socket.on('connect_error', (error) => {
        });

        this.socket.on('disconnect', (reason) => {
        });

        // Notification event handler
        this.socket.on('notification', (notification) => {
            this.handleNotification(notification);
        });

        // Ticket update event handler
        this.socket.on('ticket_updated', () => {
            // Trigger refresh of ticket list if callback is set
            if (window.loadTickets && typeof window.loadTickets === 'function') {
                window.loadTickets();
            }
        });
    }

    /**
     * Load historical notifications from server
     * @param {string} token - JWT access token
     */
    async loadNotifications(token) {
        try {
            const response = await fetch('/api/notifications', {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to load notifications');
            }

            const notifications = await response.json();

            // Store notifications
            this.notifications = notifications;
            this.unreadCount = notifications.filter(n => !n.is_read).length;

            // Update UI
            this.updateBadge();
            this.renderNotifications();
        } catch (error) {
        }
    }

    /**
     * Mark a notification as read
     * @param {number} notificationId - Notification ID
     * @param {string} token - JWT access token
     */
    async markAsRead(notificationId, token) {
        try {
            const response = await fetch(`/api/notifications/${notificationId}/read`, {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to mark notification as read');
            }

            // Update local notification state
            const notification = this.notifications.find(n => n.id === notificationId);
            if (notification && !notification.is_read) {
                notification.is_read = true;
                this.unreadCount = Math.max(0, this.unreadCount - 1);
                this.updateBadge();
                this.renderNotifications();
            }
        } catch (error) {
        }
    }

    /**
     * Handle incoming notification
     * @param {object} notification - Notification data
     */
    handleNotification(notification) {
        // Add to notifications array
        this.notifications.unshift(notification);

        // Keep only last 50 notifications
        if (this.notifications.length > 50) {
            this.notifications = this.notifications.slice(0, 50);
        }

        // Update unread count
        this.unreadCount++;
        this.updateBadge();

        // Show toast notification
        this.showToast(notification);

        // Call custom callback if set
        if (this.onNotificationCallback) {
            this.onNotificationCallback(notification);
        }

        // Update dropdown if open
        this.updateNotificationDropdown();
    }

    /**
     * Update notification badge
     */
    updateBadge() {
        const badge = document.getElementById('notificationBadge');
        if (badge) {
            badge.textContent = this.unreadCount;
            badge.style.display = this.unreadCount > 0 ? 'flex' : 'none';
        }
    }

    /**
     * Show toast notification
     * @param {object} notification - Notification data
     */
    showToast(notification) {
        // Create toast element
        const toast = document.createElement('div');
        toast.className = 'notification-toast';
        toast.innerHTML = `
      <div class="toast-icon">${this.getNotificationIcon(notification.type)}</div>
      <div class="toast-content">
        <div class="toast-message">${notification.message}</div>
        ${notification.title ? `<div class="toast-title">${notification.title}</div>` : ''}
      </div>
    `;

        // Add click handler to navigate to ticket
        if (notification.ticketId && typeof router !== 'undefined') {
            toast.style.cursor = 'pointer';
            toast.onclick = () => {
                router.navigate('ticket-detail', { id: notification.ticketId });
                toast.remove();
            };
        }

        // Add to page
        let toastContainer = document.getElementById('toastContainer');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'toastContainer';
            toastContainer.className = 'toast-container';
            document.body.appendChild(toastContainer);
        }
        toastContainer.appendChild(toast);

        // Animate in
        setTimeout(() => toast.classList.add('show'), 10);

        // Auto remove after 5 seconds
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 5000);
    }

    /**
     * Get icon for notification type
     * @param {string} type - Notification type
     * @returns {string} Icon emoji
     */
    getNotificationIcon(type) {
        const icons = {
            'new_ticket': '🎫',
            'status_changed': '🔄',
            'new_message': '💬',
            'default': '🔔'
        };
        return icons[type] || icons.default;
    }

    /**
     * Toggle notification dropdown
     */
    toggleDropdown() {
        const dropdown = document.getElementById('notificationDropdown');
        if (dropdown) {
            dropdown.classList.toggle('active');

            if (dropdown.classList.contains('active')) {
                this.renderNotifications();
            }
        }
    }

    /**
     * Render notifications in dropdown
     */
    renderNotifications() {
        const dropdown = document.getElementById('notificationDropdown');
        const list = dropdown?.querySelector('.notification-list');
        if (!list) return;

        if (this.notifications.length === 0) {
            list.innerHTML = '<div class="notification-empty">Nessuna notifica</div>';
            return;
        }

        list.innerHTML = this.notifications.slice(0, 10).map(n => `
      <div class="notification-item ${n.is_read || n.read ? 'read' : 'unread'}">
        <div class="notification-icon">${this.getNotificationIcon(n.type)}</div>
        <div class="notification-content" onclick="notificationManager.openNotification(${n.id}, ${n.ticketId || n.ticket_id})">
          <div class="notification-message">${n.message}</div>
          <div class="notification-time">${this.formatTime(n.created_at || n.timestamp)}</div>
        </div>
        <button class="notification-delete" onclick="event.stopPropagation(); notificationManager.deleteNotification(${n.id})" title="Elimina notifica">
          ✕
        </button>
      </div>
    `).join('');
    }

    /**
     * Update dropdown UI if it's currently open
     */
    updateNotificationDropdown() {
        const dropdown = document.getElementById('notificationDropdown');
        if (dropdown && dropdown.classList.contains('active')) {
            // Re-render the list to show new notifications
            this.renderNotificationsList();
        }
    }

    /**
     * Open notification (navigate to ticket)
     * @param {number} notificationId - Notification ID
     * @param {number} ticketId - Ticket ID
     */
    async openNotification(notificationId, ticketId) {
        if (ticketId && typeof router !== 'undefined') {
            // Mark notification as read
            if (notificationId) {
                await this.markAsRead(notificationId, auth.getToken());
            }

            // Close dropdown
            const dropdown = document.getElementById('notificationDropdown');
            if (dropdown) {
                dropdown.classList.remove('active');
            }

            // Navigate to ticket detail using SPA router
            router.navigate('ticket-detail', { id: ticketId });
        }
    }

    /**
     * Mark all notifications as read
     */
    async markAllAsRead() {
        try {
            const token = auth.getToken();
            const response = await fetch('/api/notifications/read-all', {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to mark all notifications as read');
            }

            // Update local state
            this.notifications.forEach(n => {
                n.is_read = true;
                n.read = true;
            });
            this.unreadCount = 0;
            this.updateBadge();
            this.renderNotifications();
        } catch (error) {
        }
    }

    /**
     * Delete a notification
     * @param {number} notificationId - Notification ID to delete
     */
    async deleteNotification(notificationId) {
        try {
            const token = auth.getToken();
            const response = await fetch(`/api/notifications/${notificationId}`, {
                method: 'DELETE',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to delete notification');
            }

            // Remove from local state
            const notification = this.notifications.find(n => n.id === notificationId);
            this.notifications = this.notifications.filter(n => n.id !== notificationId);

            // Update unread count if it was unread
            if (notification && !notification.is_read && !notification.read) {
                this.unreadCount = Math.max(0, this.unreadCount - 1);
            }

            this.updateBadge();
            this.renderNotifications();
        } catch (error) {
        }
    }

    /**
     * Format timestamp
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

        const days = Math.floor(hours / 24);
        if (days < 7) return `${days} giorni fa`;

        return date.toLocaleDateString('it-IT');
    }

    /**
     * Disconnect from Socket.IO
     */
    disconnect() {
        if (this.socket) {
            this.socket.disconnect();
        }
    }
}

// Create global instance
const notificationManager = new NotificationManager();
window.notificationManager = notificationManager;

// Close dropdown when clicking outside
document.addEventListener('click', (e) => {
    const dropdown = document.getElementById('notificationDropdown');
    const bell = document.getElementById('notificationBell');

    if (dropdown && bell &&
        !dropdown.contains(e.target) &&
        !bell.contains(e.target)) {
        dropdown.classList.remove('active');
    }
});
