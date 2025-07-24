import db from '../config/db.js';




export const createGroup = async (req, res) => {
    const { group_name, user_ids, created_by } = req.body;
    const [result] = await db.query("INSERT INTO groups (group_name, userIds, created_by) VALUES (?, ?, ?)", [group_name, created_by, user_ids]);
    res.json({ success: true, result });
};

export const userDetails = async (req, res) => {
    const { userId } = req.query;

    try {
        const [userRows] = await db.query(
            "SELECT id, full_name, email FROM users WHERE role IN ('admin', 'counselor')"
        );
        const [groupRows] = await db.query(
            "SELECT id, group_name FROM groups WHERE FIND_IN_SET(?, user_ids)",
            [userId]
        );

        if (userRows.length === 0 && groupRows.length === 0) {
            return res.status(404).json({ message: 'No users or groups found' });
        }

        // Add type to each item for identification
        const usersWithType = userRows.map(user => ({
            type: 'user',
            ...user
        }));

        const groupsWithType = groupRows.map(group => ({
            type: 'group',
            ...group
        }));

        // Merge into one array
        const combinedData = [...usersWithType, ...groupsWithType];

        res.json({ data: combinedData });

    } catch (error) {
        console.error("Error fetching user/group details:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

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
