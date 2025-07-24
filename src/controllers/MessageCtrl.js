import db from '../config/db.js';

export const handleSocketConnection = (io) => {
    io.on('connection', (socket) => {
        console.log('🟢 Socket connected:', socket.id);

        socket.on('send_message', async ({ group_id, receiver_id, message, sender_id, type }) => {
            try {
                const [result] = await db.query(
                    `INSERT INTO chats (group_id, message, sender_id, type, receiver_id) VALUES (?, ?, ?, ?, ?)`,
                    [group_id, message, sender_id, type, receiver_id]
                );

                if (result.affectedRows > 0) {
                    const [savedMessage] = await db.query(`SELECT * FROM chats WHERE id = ?`, [result.insertId]);
                    io.emit('new_message', savedMessage[0]); // 🔄 You can also use socket.to(room).emit if using rooms
                } else {
                    socket.emit('message_error', { error: 'Failed to send message' });
                }
            } catch (err) {
                console.error('send_message error:', err);
                socket.emit('message_error', { error: 'Message failed', details: err.message });
            }
        });

        socket.on('get_messages', async ({ sender_id, receiver_id, group_id }) => {
            try {
                let messages = [];

                if (group_id) {
                    const [rows] = await db.query(
                        `SELECT * FROM chats WHERE group_id = ? ORDER BY created_at ASC`,
                        [group_id]
                    );
                    messages = rows;
                } else if (sender_id && receiver_id) {
                    const [rows] = await db.query(
                        `SELECT * FROM chats 
         WHERE ((sender_id = ? AND receiver_id = ?) 
             OR (sender_id = ? AND receiver_id = ?)) 
           AND group_id IS NULL 
         ORDER BY created_at ASC`,
                        [sender_id, receiver_id, receiver_id, sender_id]
                    );
                    messages = rows;
                } else {
                    return socket.emit('message_error', { error: "Invalid query parameters" });
                }

                socket.emit('messages', messages);
            } catch (err) {
                console.error('get_messages error:', err);
                socket.emit('message_error', { error: "Failed to fetch messages", details: err.message });
            }
        });


        socket.on('disconnect', () => {
            console.log('🔴 Socket disconnected:', socket.id);
        });
    });
};
