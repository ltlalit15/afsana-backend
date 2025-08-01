import db from '../config/db.js';

export const handleSocketConnection = (io) => {
    io.on('connection', (socket) => {
        console.log('🟢 Socket connected:', socket.id);

        // ✅ Step 1: User joins their private room (ID based)
        socket.on('join', (userId) => {
            socket.join(String(userId));
            console.log(`✅ User joined room: ${userId}`);
        });

        // ✅ Step 2: Send Message Handler
        socket.on('send_message', async ({ group_id, receiver_id, message, sender_id, type }) => {
            console.log(`📨 send_message → sender: ${sender_id}, receiver: ${receiver_id}, group: ${group_id}, message: ${message}`);

            try {
                const [result] = await db.query(
                    `INSERT INTO chats (group_id, message, sender_id, type, receiver_id) VALUES (?, ?, ?, ?, ?)`,
                    [group_id, message, sender_id, type, receiver_id]
                );

                if (result.affectedRows > 0) {
                    const [savedMessage] = await db.query(`SELECT * FROM chats WHERE id = ?`, [result.insertId]);
                    const messageData = savedMessage[0];

                    // ✅ Send to sender and receiver rooms only
                    if (group_id) {
                        io.to(String(group_id)).emit('new_message', messageData); // group room
                    } else {
                        io.to(String(sender_id)).emit('new_message', messageData);
                        io.to(String(receiver_id)).emit('new_message', messageData);
                    }
                } else {
                    socket.emit('message_error', { error: 'Failed to send message' });
                }
            } catch (err) {
                console.error('❌ send_message error:', err);
                socket.emit('message_error', { error: 'Message failed', details: err.message });
            }
        });

        // ✅ Step 3: Get Messages
        socket.on('get_messages', async ({ sender_id, receiver_id, group_id }) => {
            console.log(`📥 get_messages → sender: ${sender_id}, receiver: ${receiver_id}, group: ${group_id}`);
            try {
                let messages = [];

                if (group_id) {
                    const [rows] = await db.query(`
                        SELECT 
                            c.*, 
                            u.full_name AS sender_name
                        FROM chats c
                        LEFT JOIN users u ON c.sender_id = u.id
                        WHERE c.group_id = ?
                        ORDER BY c.created_at ASC
                    `, [group_id]);

                    messages = rows;
                } else if (sender_id && receiver_id) {
                    const [rows] = await db.query(`
                        SELECT 
                            c.*, 
                            s.full_name AS sender_name, 
                            IFNULL(r.full_name, CONCAT('User-', c.receiver_id)) AS receiver_name
                        FROM chats c
                        LEFT JOIN users s ON c.sender_id = s.id
                        LEFT JOIN users r ON c.receiver_id = r.id
                        WHERE (
                            (c.sender_id = ? AND c.receiver_id = ?) OR 
                            (c.sender_id = ? AND c.receiver_id = ?)
                        )
                        AND c.group_id IS NULL
                        ORDER BY c.created_at ASC
                    `, [sender_id, receiver_id, receiver_id, sender_id]);

                    messages = rows;
                } else {
                    return socket.emit('message_error', { error: "Invalid query parameters" });
                }

                socket.emit('messages', messages);
            } catch (err) {
                console.error('❌ get_messages error:', err);
                socket.emit('message_error', { error: "Failed to fetch messages", details: err.message });
            }
        });

        // ✅ Disconnect
        socket.on('disconnect', () => {
            console.log('🔴 Socket disconnected:', socket.id);
        });
    });
};
