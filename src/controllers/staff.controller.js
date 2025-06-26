import db from '../config/db.js';
import bcrypt from 'bcrypt';
import dotenv from 'dotenv';

dotenv.config();


   export const createStaff = async (req, res) => {
    console.log("req.body : ", req.body);

    const {
      user_id,
      full_name,
      email,
      phone,
      password,
      role,
      status
    } = req.body;
  
    try {
     
      if (!full_name || !email || !phone || !password || !role) {
        return res.status(400).json({ message: 'All required fields must be filled' });
      }
  
     
      const [existing] = await db.query('SELECT id FROM users WHERE email = ?', [email]);
      if (existing.length > 0) {
        return res.status(409).json({ message: 'Staff already exists' });
      }
      const hashed = await bcrypt.hash(password, 10);
      const [counselorResult] = await db.query(
        `INSERT INTO staff (user_id,  phone, status)
         VALUES (?, ?, ?)`,
        [user_id, phone, status]
      );
  
      if (!counselorResult.affectedRows) {
        return res.status(400).json({ message: 'Staff not added properly' });
      }
  
      const staffID = counselorResult.insertId;
  
    
      const [userResult] = await db.query(
        'INSERT INTO users (email, password, full_name, role, user_id, staff_id) VALUES (?, ?, ?, ?, ?, ?)',
        [email, hashed, full_name, role, user_id, staffID]
      );
  
      if (!userResult.insertId) {
        return res.status(400).json({ message: 'Staff creation failed' });
      }
  
      res.status(201).json({ message: 'Staff created successfully' });
  
    } catch (err) {
      console.error('Create Staff error:', err);
      res.status(500).json({ message: 'Internal server error', error: err.message });
    }
  };
  


    export const getStaffById = async (req, res) => {
    const { id } = req.params;
  
    try {
      const [rows] = await db.query(
        `
        SELECT 
          c.*, 
          u.email, u.full_name, u.role 
        FROM staff c 
        JOIN users u ON c.id = u.staff_id
        WHERE c.id = ?
        `,
        [id]
      );
    if (rows.length === 0) {
      return res.status(404).json({ message: 'No staff found' });
    }
    res.status(200).json(rows);
    } catch (err) {
      console.error('Get staff error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
  
  export const updateStaff = async (req, res) => {
    const { id } = req.params;
    const {
      user_id,
      full_name,
      email,
      phone,
      status
    } = req.body;
    try {
      const [result] = await db.query(
        `UPDATE staff  
         SET user_id = ?,  phone = ?,  status = ?
         WHERE id = ?`,
        [user_id,  phone, status, id]
      );
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'staff not found' });
      }
      const [userResult] = await db.query(
        `UPDATE users
         SET full_name = ?, email = ?
         WHERE staff_id = ?`,
        [full_name, email, id]
      );

      res.json({ message: 'staff updated successfully' });
    } catch (err) {
      console.error('Update staff error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
export const deleteStaff = async (req, res) => {
  const { id } = req.params;
  try {
    // First, delete from users table where staff_id = id
    const [userResult] = await db.query('DELETE FROM users WHERE staff_id = ?', [id]);

    // Then, delete the staff record
    const [result] = await db.query('DELETE FROM staff WHERE id = ?', [id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Staff not found' });
    }

    res.json({ message: 'Staff deleted successfully' });
  } catch (err) {
    console.error('Delete staff error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};

 

export const getAllStaff = async (_, res) => {
  try {
    const [rows] = await db.query(
      `
      SELECT 
        s.*, 
        u.email, 
        u.full_name, 
        u.role 
      FROM staff s 
      JOIN users u ON s.id = u.staff_id
      `
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: 'No staff found' });
    }

    res.status(200).json(rows);
  } catch (err) {
    console.error('Get All Staff error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};
   
  

