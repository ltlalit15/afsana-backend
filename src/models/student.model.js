import db from '../config/db.js';

export const studentNameById = async (id) => {
    const [result] = await db.query('SELECT full_name FROM users WHERE student_id = ?', [id]);
    return result;
  };