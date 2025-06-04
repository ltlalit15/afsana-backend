import db from '../config/db.js';
import dotenv from 'dotenv';
import { studentNameById } from '../models/student.model.js';
import { getCounselorById } from './Counselor.controller.js';
dotenv.config();

// CREATE Reminder
export const createReminder = async (req, res) => {
  const { task_id } = req.body;
  console.log("req.body", req.body);

  try {
    if (!task_id) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    const query = `
      INSERT INTO remainder (task_id)
      VALUES (?)`;

    const [result] = await db.query(query, [task_id]);

    if (result.affectedRows === 0) {
      return res.status(500).json({ message: "Failed to create reminder" });
    }

    return res.status(200).json({ message: 'Reminder created successfully', id: result.insertId });
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: error.message });
  }
};

export const getReminders = async (req, res) => {
  try {
    const [reminders] = await db.query('SELECT * FROM remainder');

    if (reminders.length === 0) {
      return res.status(404).json({ message: "No reminders found" });
    }

    const remindersWithTasks = await Promise.all(
      reminders.map(async (reminder) => {
        let task = {};
        let studentName = 'Unknown';
        let counselorName = 'Unknown';

        try {
          const [taskResult] = await db.query('SELECT * FROM tasks WHERE id = ?', [reminder.task_id]);
          task = taskResult[0];

          if (task) {
            const { student_id, counselor_id } = task;

            // Fetch Student and Counselor names concurrently
            const [studentData, counselorData] = await Promise.all([
              studentNameById(student_id).catch(() => []),
              getCounselorById(counselor_id).catch(() => [])
            ]);

            studentName = studentData[0]?.full_name || 'Unknown';
            counselorName = counselorData[0]?.full_name || 'Unknown';
          }
        } catch (err) {
          console.error(`Error processing task ID ${reminder.task_id}: ${err.message}`);
        }

        return {
          id: reminder.id,
          task_id: task?.id || reminder.task_id,
          title: task?.title || 'Unknown',
          user_id: task?.user_id || null,
          due_date: task?.due_date || null,
          counselor_id: task?.counselor_id || null,
          student_id: task?.student_id || null,
          description: task?.description || null,
          priority: task?.priority || null,
          status: task?.status || null,
          related_to: task?.related_to || null,
          related_item: task?.related_item || null,
          assigned_to: task?.assigned_to || null,
          assigned_date: task?.assigned_date || null,
          finishing_date: task?.finishing_date || null,
          attachment: task?.attachment || null,
          created_at: task?.created_at || null,
          updated_at: task?.updated_at || null,
          notes: task?.notes || null,
          image: task?.image || null,
          student_name: studentName,
          counselor_name: counselorName,
        };
      })
    );

    return res.status(200).json(remindersWithTasks);

  } catch (error) {
    console.error(`Internal server error: ${error.message}`);
    res.status(500).json({ message: 'Internal server error', error: error.message });
  }
};

// GET Reminder by ID
export const getReminderById = async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM remainder WHERE id = ?', [id]);

    if (rows.length === 0) {
      return res.status(404).json({ message: "Reminder not found" });
    }

    return res.status(200).json(rows[0]);
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// UPDATE Reminder
export const updateReminder = async (req, res) => {
  const { id } = req.params;
  const { task_id } = req.body;

  try {
    const query = `
      UPDATE remainder
      SET task_id = ?, 
      WHERE id = ?`;

    const [result] = await db.query(query, [task_id, id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Reminder not found" });
    }

    return res.status(200).json({ message: 'Reminder updated successfully' });
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// DELETE Reminder
export const deleteReminder = async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM remainder WHERE id = ?', [id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Reminder not found" });
    }

    return res.status(200).json({ message: 'Reminder deleted successfully' });
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: 'Internal server error' });
  }
};
