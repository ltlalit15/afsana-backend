import db from '../config/db.js';




export const getCounselorById = async(id) => {
    const [results] = await db.query('SELECT full_name FROM users WHERE counselor_id = ?', [id]);
    return results
};