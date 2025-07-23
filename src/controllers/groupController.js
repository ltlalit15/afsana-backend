import db from '../config/db.js';


export const createGroup = async (req, res) => {
  const { name, userIds, created_by } = req.body;
  // Step 1: Jo create kar raha hai uska role check karo
  const [user] = await db.query("SELECT role FROM users WHERE id = ?", [created_by]);
  // Step 2: Agar student hai to mana karo
  if (!['admin', 'counselor'].includes(user[0]?.role)) {
    return res.status(403).json({ message: 'Not allowed' });
  }
  // Step 3: Group create karo
  const [result] = await db.query("INSERT INTO group_chats (name, created_by) VALUES (?, ?)", [name, created_by]);
  const groupId = result.insertId;
  // Step 4: Members add karo (admin ho ya member)
  const memberValues = userIds.map(uid => [groupId, uid, uid === created_by ? 'admin' : 'member']);
  await db.query("INSERT INTO group_members (group_id, user_id, role) VALUES ?", [memberValues]);
  res.json({ success: true, groupId });
};


export const getGroupMessages = async (req, res) => {
  const { groupId } = req.params;
  const query = `
    SELECT m.*, u.full_name 
    FROM messages m 
    JOIN users u ON u.id = m.sender_id 
    WHERE m.group_id = ? 
    ORDER BY m.timestamp ASC
  `;
  const [rows] = await db.query(query, [groupId]);
  res.json({ messages: rows });
};

export const getMyGroups = async (req, res) => {
  const { userId } = req.params;
  const query = `
    SELECT g.id, g.name, g.created_at 
    FROM group_chats g 
    JOIN group_members m ON g.id = m.group_id 
    WHERE m.user_id = ?
  `;
  const [groups] = await db.query(query, [userId]);
  res.json({ groups });
};
