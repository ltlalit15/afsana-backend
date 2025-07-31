import db from '../config/db.js';

export const handleSocketConnection = (io) => {
    io.on('connection', (socket) => {
        console.log('🟢 Socket connected:', socket.id);

        socket.on('send_message', async ({ group_id, receiver_id, message, sender_id, type }) => {
            console.log(`send_message received: group_id=${group_id}, receiver_id=${receiver_id}, message=${message}, sender_id=${sender_id}, type=${type}`);
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
            console.log(`get_messages received: sender_id=${sender_id}, receiver_id=${receiver_id}, group_id=${group_id}`);
            try {
                let messages = [];

                if (group_id) {
                    const [rows] = await db.query(
                        `SELECT 
  c.*, 
  u.full_name AS sender_name
FROM chats c
LEFT JOIN users u ON c.sender_id = u.id
WHERE c.group_id = ?
ORDER BY c.created_at ASC
`,
                        [group_id]
                    );
                    messages = rows;
                } else if (sender_id && receiver_id) {
                    const [rows] = await db.query(
                        `SELECT 
  c.*, 
  s.full_name AS sender_name, 
  IFNULL(r.full_name, CONCAT('User-', c.receiver_id)) AS receiver_name
FROM chats c
LEFT JOIN users s ON c.sender_id = s.id
LEFT JOIN users r ON c.receiver_id = r.id
WHERE ((c.sender_id = ? AND c.receiver_id = ?) 
    OR (c.sender_id = ? AND c.receiver_id = ?))
  AND c.group_id IS NULL
ORDER BY c.created_at ASC;

`,
                        [sender_id, receiver_id, receiver_id, sender_id]
                    );
                    messages = rows;
                    console.log(`Messages for private chat between ${sender_id} and ${receiver_id}:`, messages);
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
