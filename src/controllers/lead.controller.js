import db from '../config/db.js';
import dotenv from 'dotenv';
import { getCounselorById } from '../models/counselor.model.js';
dotenv.config();

export const createLead = async (req, res) => {
    const {
        name, email, phone, counselor, follow_up_date,
        source, status, preferred_countries, notes, user_id
      } = req.body;
      console.log("req.body",req.body); 
    
     try {
        if( !name || !email || !phone || !counselor || !follow_up_date || !source || !status || !preferred_countries || !notes || !user_id){
            return res.status(400).json({message: 'all fields are required'});
        }
        const query = `
    INSERT INTO leads 
    ( name, email, phone, counselor, follow_up_date,
        source, status, preferred_countries, notes, user_id)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

  const result = await db.query(query, [
    name, email, phone, counselor, follow_up_date,
        source, status, preferred_countries, notes, user_id
  ])
  if (result.affectedRows === 0) {
    return res.status(404).json({ message: "Follow-up not found" });
  }
        return res.status(200).json({message: 'lead created successfully', id: result.insertId});
     } catch (error) {
        console.log(`internal server error : ${error}`);
        res.status(500).json({message: 'internal server error'});
     }
}


export const getLeads = async (req, res) => {
    try {
        const query = 'SELECT * FROM leads';
        const [result] = await db.query(query);
        if (result.length === 0) {
          return res.status(404).json({ message: "Follow-ups not found" });
        }
        const data = await Promise.all(
          result.map(async (lead) => {
            const counselorID = lead.counselor;
            const counselor_name = await getCounselorById(counselorID);
            console.log("counselor_name", counselor_name);
            return {
              ...lead,
              counselor_name : counselor_name[0]?.full_name
            };
          })
        );

        return res.status(200).json(data);
      } catch (error) {
        console.log(`internal server error : ${error}`);
        res.status(500).json({message: 'internal server error'});
      }
}

export const getLeadById = async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM leads WHERE id = ?', [id]);

    if (rows.length === 0) {
      return res.status(404).json({ message: "Follow-up not found" });
    }

    const data = await Promise.all(
      rows.map(async (lead) => {
        const counselorID = lead.counselor;
        const counselor_name = await getCounselorById(counselorID);
        return {
          ...lead,
          counselor_name: counselor_name[0]?.full_name || 'Unknown'
        };
      })
    );

    return res.status(200).json(data[0]); // Only one lead, so return data[0]
  } catch (error) {
    console.log(`internal server error : ${error}`);
    res.status(500).json({ message: 'internal server error' });
  }
};



export const updateLead = async (req, res) => {
    const { id } = req.params;
    const {
        name, email, phone, counselor, follow_up_date,
        source, status, preferred_countries, notes, user_id
      } = req.body;
    try {
        const query = `
        UPDATE leads
        SET name = ?, email = ?, phone = ?, counselor = ?, follow_up_date = ?,
        source = ?, status = ?, preferred_countries = ?, notes = ?, user_id = ?
        WHERE id = ?`;
        const result = await db.query(query, [
            name, email, phone, counselor, follow_up_date,
            source, status, preferred_countries, notes, user_id, id
        ]);
        if (result.affectedRows === 0) {
          return res.status(404).json({ message: "Follow-up not found" });
        }
        return res.status(200).json({message: 'lead updated successfully'});
      } catch (error) {
        console.log(`internal server error : ${error}`);
        res.status(500).json({message: 'internal server error'});
      }
}

export const deleteLead = async (req, res) => {
    const { id } = req.params;
    try {
        const query = 'DELETE FROM leads WHERE id = ?';
        const result = await db.query(query, [id]);
        if (result.affectedRows === 0) {
          return res.status(404).json({ message: "Follow-up not found" });
        }
        return res.status(200).json({message: 'lead deleted successfully'});
      } catch (error) {
        console.log(`internal server error : ${error}`);
        res.status(500).json({message: 'internal server error'});
      }
}

export const getLeadByCounselorId = async (req, res) => {
  const { id } = req.params;
  try {
    const query = 'SELECT * FROM leads WHERE counselor = ?';
    const [result] = await db.query(query, [id]);
    if (result.length === 0) {
      return res.status(404).json({ message: "Follow-ups not found" });
    }
    const data = await Promise.all(
      result.map(async (lead) => {
        const counselorID = lead.counselor;
        const counselor_name = await getCounselorById(counselorID);
        return {
          ...lead,
          counselor_name: counselor_name[0]?.full_name || 'Unknown'
        };
      })
    );

    return res.status(200).json(data);
  } catch (error) {
    console.log(`internal server error : ${error}`);
    res.status(500).json({ message: 'internal server error' });
  }
};
