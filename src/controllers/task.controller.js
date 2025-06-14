// controllers/taskController.js
import db from '../config/db.js';
import { getCounselorById } from '../models/counselor.model.js';
import { studentNameById } from '../models/student.model.js';

// CREATE
export const createTask = async (req, res) => {
  try {
    const {
      title, user_id, due_date, counselor_id, student_id,
      description, priority, status, related_to, related_item,
      assigned_to, assigned_date, finishing_date, attachment
    } = req.body;
    if(!title || !user_id || !due_date || !counselor_id || !student_id || !description || !priority || !status || !related_to || !related_item || !assigned_to || !assigned_date || !finishing_date ){
        return res.status(400).json({message: 'all fields are required'});
    }

    const [result] = await db.query(
      `INSERT INTO tasks (title, due_date, counselor_id, student_id,
        description, priority, status, related_to, related_item,
        assigned_to, assigned_date, finishing_date, attachment)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        title, due_date, counselor_id, student_id,
        description, priority, status, related_to, related_item,
        assigned_to, assigned_date, finishing_date, attachment
      ]
    );

    res.status(201).json({ message: 'Task created successfully', taskId: result.insertId });
  } catch (err) {
    console.error('Create Task Error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};

export const getTaskByCounselorID = async (req,res) =>{
  try {
    const {counselor_id} = req.params;
    if(!counselor_id){
      return res.status(400).json({message: 'counselor_id is required'});
    }
    const [tasks] = await db.query('SELECT * FROM tasks WHERE counselor_id = ?', [counselor_id]);
    if (tasks.length === 0) return res.status(404).json({ message: 'No tasks found' });
    const data = await Promise.all(
      tasks.map(async (task) => {
        
        const studentID = task.student_id;
        const counselorID = task.counselor_id;
        const counselor_name = await getCounselorById(counselorID);
        const student_name = await studentNameById(studentID);
        
        return {
          ...task,
          image: task.image ? `${req.protocol}://${req.get('host')}${task.image}` : null,
          counselor_name: counselor_name[0]?.full_name || 'Unknown'
          ,student_name: student_name[0]?.full_name || 'Unknown'
        };
      })
    );

    if (data.length === 0) return res.status(404).json({ message: 'No tasks found' });
    res.status(200).json(data);
  } catch (error) {
    console.error('Get Tasks Error:', error);
    res.status(500).json({ message: 'Internal server error',error });
  }
}

export const getTaskByStudentID = async (req, res) =>{
  try {
    const {student_id} = req.params;
    if(!student_id){
      return res.status(400).json({message: 'student_id is required'});
    }
    const [tasks] = await db.query('SELECT * FROM tasks WHERE student_id = ?', [student_id]);
    if (tasks.length === 0) return res.status(404).json({ message: 'No tasks found' });
    const data = await Promise.all(
      tasks.map(async (task) => {
        
        const studentID = task.student_id;
        const counselorID = task.counselor_id;
        const counselor_name = await getCounselorById(counselorID);
        const student_name = await studentNameById(studentID);
        
        return {
          ...task,
          image: task.image ? `${req.protocol}://${req.get('host')}${task.image}` : null,
          counselor_name: counselor_name[0]?.full_name || 'Unknown'
          ,student_name: student_name[0]?.full_name || 'Unknown'
        };
      })
    );

    if (data.length === 0) return res.status(404).json({ message: 'No tasks found' });
    res.status(200).json(data);
  } catch (error) {
    console.error('Get Tasks Error:', error);
    res.status(500).json({ message: 'Internal server error', error });
  }
}

// READ ALL
export const getAllTasks = async (req, res) => {
  try {
    const [tasks] = await db.query('SELECT * FROM tasks');
    if (tasks.length === 0) return res.status(404).json({ message: 'No tasks found' });
    const data = await Promise.all(
      tasks.map(async (task) => {
        
        const studentID = task.student_id;
        const counselorID = task.counselor_id;
        const counselor_name = await getCounselorById(counselorID);
        const student_name = await studentNameById(studentID);
       
        return {
          ...task,
          image: task.image ? `${req.protocol}://${req.get('host')}${task.image}` : null,
          counselor_name: counselor_name[0]?.full_name || 'Unknown'
          ,student_name: student_name[0]?.full_name || 'Unknown'
        };
      })
    );
    res.status(200).json(data);
  } catch (err) {
    console.error('Get Tasks Error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// READ ONE
export const getTaskById = async (req, res) => {
  const { id } = req.params;
  try {
    const [task] = await db.query('SELECT * FROM tasks WHERE id = ?', [id]);
    if (task.length === 0) return res.status(404).json({ message: 'Task not found' });
    const data = await Promise.all(
      task.map(async (task) => {
        
        const studentID = task.student_id;
        const counselorID = task.counselor_id;
        const counselor_name = await getCounselorById(counselorID);
        const student_name = await studentNameById(studentID);
        
        return {
          ...task,
          image: task.image ? `${req.protocol}://${req.get('host')}${task.image}` : null,
          counselor_name: counselor_name[0]?.full_name || 'Unknown'
          ,student_name: student_name[0]?.full_name || 'Unknown'
        };
      })
    );
    res.status(200).json(data);
  } catch (err) {
    console.error('Get Task Error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// UPDATE
export const updateTask = async (req, res) => {
  const { id } = req.params;
  const {
    title, user_id, due_date, counselor_id, student_id,
    description, priority, status, related_to, related_item,
    assigned_to, assigned_date, finishing_date, attachment
  } = req.body;

  try {
    const [result] = await db.execute(
      `UPDATE tasks SET title=?, user_id=?, due_date=?, counselor_id=?, student_id=?,
       description=?, priority=?, status=?, related_to=?, related_item=?,
       assigned_to=?, assigned_date=?, finishing_date=?, attachment=?
       WHERE id=?`,
      [
        title, user_id, due_date, counselor_id, student_id,
        description, priority, status, related_to, related_item,
        assigned_to, assigned_date, finishing_date, attachment, id
      ]
    );

    if (result.affectedRows === 0) return res.status(404).json({ message: 'Task not found' });
    res.status(200).json({ message: 'Task updated successfully' });
  } catch (err) {
    console.error('Update Task Error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// DELETE
export const deleteTask = async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.execute('DELETE FROM tasks WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Task not found' });
    res.status(200).json({ message: 'Task deleted successfully' });
  } catch (err) {
    console.error('Delete Task Error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};

export const updateTaskNotesAndStatus = async (req, res) => {
  const { id } = req.params;
  const { notes, status } = req.body;
  const logoFile = req.file;

    const logo_url = logoFile
      ? `/uploads/${logoFile.filename}`
      : '';
  try {
   
    let query = `UPDATE tasks SET `;
    const values = [];

    if (notes !== undefined) {
      query += `notes = ?, `;
      values.push(notes);
    }

    if (status !== undefined) {
      query += `status = ?, `;
      values.push(status);
    }
    if (logo_url !== undefined && logo_url !== '') {
      query += `image = ?, `;
      values.push(logo_url);
    }

    
    query = query.slice(0, -2) + ` WHERE id = ?`;
    values.push(id);

    const [result] = await db.execute(query, values);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Task not found' });
    }

    res.status(200).json({ message: 'Task updated successfully' });

  } catch (err) {
    console.error('Update Task Error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};

export const reminder_task = async (req, res) => {
  try {
    const reminderWindow = 2;

    // Get the current date
    const currentDate = new Date();
    const endDate = new Date();
    endDate.setDate(currentDate.getDate() + reminderWindow);

    const query = `
      SELECT * FROM tasks 
      WHERE status = 'pending' 
      AND (due_date <= ? OR due_date BETWEEN ? AND ?)
    `;

    const values = [
      endDate.toISOString().split('T')[0], 
      currentDate.toISOString().split('T')[0], 
      endDate.toISOString().split('T')[0]
    ];

    const [tasks] = await db.query(query, values);

    if (tasks.length === 0) {
      return res.status(404).json({ message: "No reminder tasks found" });
    }
    const data = await Promise.all(
      tasks.map(async (task) => {
      
        const studentID = task.student_id;
        const counselorID = task.counselor_id;
        const counselor_name = await getCounselorById(counselorID);
        const student_name = await studentNameById(studentID);
        return {
          ...task,
          image: task.image ? `${req.protocol}://${req.get('host')}${task.image}` : null,
          counselor_name: counselor_name[0]?.full_name || 'Unknown'
          ,student_name: student_name[0]?.full_name || 'Unknown'
        };
      })
    );
    res.status(200).json(data);
  } catch (error) {
    console.error("Reminder Task Error:", error);
    res.status(500).json({ message: "Internal server error" });
  }
};






