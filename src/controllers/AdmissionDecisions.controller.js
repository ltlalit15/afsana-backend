import db from '../config/db.js';
import dotenv from 'dotenv';
import { studentNameById } from '../models/student.model.js';
import { universityNameById } from '../models/universities.model.js';
dotenv.config();
 
// CREATE
export const createAdmissionDecision = async (req, res) => {
    const { user_id, 	student_id, university_id, status, decision_date } = req.body;
 
    try {

    if (!student_id || !university_id) {
      return res.status(400).json({ message: 'student_id and university_id are required' });
    }

      const [result] = await db.query(
        `INSERT INTO admission_decisions (user_id, student_id, university_id, status, decision_date)
         VALUES (?, ?, ?, ?, ?)`,
        [user_id, student_id, university_id, status || 'Pending', decision_date]
      );
 
      res.status(201).json({ message: 'Admission decision added successfully', id: result.insertId });
    } catch (err) {
      console.error('Create Admission Decision error:', err);
      res.status(500).json({ message: 'Internal server error', error: err.message });
    }
  };
 
 
  // UPDATE
export const updateAdmissionDecision = async (req, res) => {
    const { id } = req.params;
    const { user_id, student_id, university_id, status, decision_date } = req.body;
 
    try {
      const [result] = await db.query(
        `UPDATE admission_decisions
         SET user_id = ?, student_id = ?, university_id = ?, status = ?, decision_date = ?
         WHERE id = ?`,
        [user_id, student_id, university_id, status, decision_date, id]
      );
 
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Admission decision not found' });
      }
 
      res.json({ message: 'Admission decision updated successfully' });
    } catch (err) {
      console.error('Update Admission Decision error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
 
 
  export const getAllAdmissionDecisions = async (req, res) => {
    try {
      const [results] = await db.query('SELECT * FROM admission_decisions');
      if (results.length === 0) {
        return res.status(404).json({ message: 'No admission decisions found' });
      }
  
      const data = await Promise.all(
        results.map(async (admissionDecision) => {
          let studentName = "Unknown";
          let universityName = "Unknown";
  
          if (admissionDecision.student_id) {
            const studentRows = await studentNameById(admissionDecision.student_id);
            if (studentRows.length > 0) {
              studentName = studentRows[0].full_name;
            }
          }
          
           console.log("admissionDecision",admissionDecision);
          if (admissionDecision.university_id) {
           
            const universityRows = await universityNameById(admissionDecision.university_id);
            if (universityRows.length > 0) {
              universityName = universityRows[0].name;
             
            }
          }
  
          return {
            ...admissionDecision,
            student_name: studentName,
            university_name: universityName,
          };
        })
      );
  
      res.status(200).json({
        message: 'Admission decisions fetched successfully',
        data: data,
      });
    } catch (err) {
      console.error('Get All Admission Decisions error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
  

 
 
  export const getAdmissionDecisionById = async (req, res) => {
    const { id } = req.params;
    try {
      const [results] = await db.query('SELECT * FROM admission_decisions WHERE id = ?', [id]);
  
      if (results.length === 0) {
        return res.status(404).json({ message: 'Admission decision not found' });
      }
  
      const decision = results[0];
      let studentName = 'Unknown';
      let universityName = 'Unknown';
  
      if (decision.student_id) {
        const studentRows = await studentNameById(decision.student_id);
        if (studentRows.length > 0) {
          studentName = studentRows[0].full_name;
        }
      }
  
      if (decision.university_id) {
        const universityRows = await universityNameById(decision.university_id);
        if (universityRows.length > 0) {
          universityName = universityRows[0].name;
        }
      }
  
      res.status(200).json({
        ...decision,
        student: studentName,
        university: universityName,
      });
    } catch (err) {
      console.error('Get Admission Decision error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
  
 
 
  export const updateAdmissionStatus = async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;
 
    if (!status) {
      return res.status(400).json({ message: 'Status is required' });
    }
 
    try {
      const [result] = await db.query(
        `UPDATE admission_decisions SET status = ? WHERE id = ?`,
        [status, id]
      );
 
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Admission decision not found' });
      }
 
      res.status(200).json({ message: 'Status updated successfully' });
    } catch (err) {
      console.error('Update Admission Status error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };

  export const deleteAdmissionDecision = async (req, res) => {
    const { id } = req.params;

    try {
      const [result] = await db.query('DELETE FROM admission_decisions WHERE id = ?', [id]);

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Admission decision not found' });
      }

      res.status(200).json({ message: 'Admission decision deleted successfully' });
    } catch (err) {
      console.error('Delete Admission Decision error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };