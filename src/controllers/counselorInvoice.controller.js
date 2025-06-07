import db from '../config/db.js';
import dotenv from 'dotenv';
dotenv.config();

// CREATE Fee Record
// export const createStudentFeeBYcounselor = async (req, res) => { 
//   const { student_name, description, amount, status, fee_date ,tax,  } = req.body;
//   console.log("req.body", req.body);

//   try {
//     // if (!student_name || !description || !amount || !status || !fee_date) {
//     //   return res.status(400).json({ message: 'All fields are required' });
//     // }

//     const query = `
//       INSERT INTO student_fees_by_counselor (student_name, description, amount, status, fee_date)
//       VALUES (?, ?, ?, ?, ?)`;

//     const result = await db.query(query, [student_name, description, amount, status, fee_date]);

//     if (result.affectedRows === 0) {
//       return res.status(500).json({ message: "Failed to create fee record" });
//     }

//     return res.status(200).json({ message: 'Student fee record created successfully', id: result.insertId });
//   } catch (error) {
//     console.log(`Internal server error: ${error}`);
//     res.status(500).json(error.message);
//   }
// };

export const createStudentFeeBYcounselor = async (req, res) => { 
  const { student_name, description, amount, fee_date, inquiry_id, user_id } = req.body;

  console.log("req.body", req.body);

  try {
    // Insert fee record
    const query = `
     INSERT INTO student_fees_by_counselor (student_name, description, amount, fee_date, inquiry_id, user_id)
VALUES (?, ?, ?, ?, ?, ?)

    `;
    const [result] = await db.query(query, [student_name, description, amount, fee_date, inquiry_id, user_id]);

    if (result.affectedRows === 0) {
      return res.status(500).json({ message: "Failed to create fee record" });
    }

    // Update is_view status in inquiries table
    const updateViewQuery = `
      UPDATE inquiries SET is_view = 1, updated_at = NOW() WHERE id = ?
    `;
    const [viewResult] = await db.query(updateViewQuery, [inquiry_id]);

    if (viewResult.affectedRows === 0) {
      return res.status(404).json({ message: 'Fee created but inquiry not found for view update' });
    }

    return res.status(200).json({ 
      message: 'Student fee record created and is_view updated successfully', 
      id: result.insertId 
    });

  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: error.message });
  }
};

// GET All Fee Records
export const getStudentFeesYcounselor = async (req, res) => {
  try {
    const query = 'SELECT * FROM student_fees_by_counselor';
    const [result] = await db.query(query);

    if (result.length === 0) {
      return res.status(404).json({ message: "No student fees found" });
    }

    return res.status(200).json(result);
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// GET Fee by ID
export const getStudentFeeByIdYcounselor = async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM student_fees_by_counselor WHERE id = ?', [id]);
    if (rows.length === 0) {
      return res.status(404).json({ message: "Fee record not found" });
    }
    return res.status(200).json(rows[0]);
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: 'Internal server error' });
  }
}; 

// UPDATE Fee Record
export const updateStudentFeeYcounselor = async (req, res) => {
  const { id } = req.params;
  const { student_name, description, amount, status, fee_date } = req.body;
  try {
    const query = `
      UPDATE student_fees_by_counselor
      SET student_name = ?, description = ?, amount = ?, status = ?, fee_date = ?
      WHERE id = ?`;
    const result = await db.query(query, [
      student_name, description, amount, status, fee_date, id
    ]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Fee record not found" });
    }
    return res.status(200).json({ message: 'Student fee record updated successfully' });
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// DELETE Fee Record
export const deleteStudentFeeYcounselor = async (req, res) => {
  const { id } = req.params;
  try {
    const query = 'DELETE FROM student_fees_by_counselor WHERE id = ?';
    const result = await db.query(query, [id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Fee record not found" });
    }

    return res.status(200).json({ message: 'Student fee record deleted successfully' });
  } catch (error) {
    console.log(`Internal server error: ${error}`);
    res.status(500).json({ message: 'Internal server error' });
  }
};


export const getStudentFeesByUser = async (req, res) => {
  const { user_id } = req.params;

  try {
    // Query to get the student fees by user_id
    const query = `
      SELECT * FROM student_fees_by_counselor WHERE user_id = ?
    `;

    const [result] = await db.query(query, [user_id]);

    // If no records found
    if (result.length === 0) {
      return res.status(404).json({ message: 'No fee records found for this user.' });
    }

    // Return the result
    return res.status(200).json({
      message: 'Student fee records fetched successfully',
      data: result
    });
    
  } catch (error) {
    console.error('Error fetching student fees:', error);
    return res.status(500).json({ message: 'Internal server error', error: error.message });
  }
};

// // UPDATE status by ID
// export const updateFeeStatus = async (req, res) => {
//   const { id, status } = req.body;

//   if (!id || !status) {
//     return res.status(400).json({ message: 'id and status are required' });
//   }

//   try {
//     const [result] = await db.query(
//       `UPDATE student_fees_by_counselor SET status = ? WHERE id = ?`,
//       [status, id]
//     );

//     if (result.affectedRows === 0) {
//       return res.status(404).json({ message: 'Fee record not found' });
//     }

//     res.json({ message: 'Status updated successfully' });
//   } catch (error) {
//     console.error('Error updating status:', error);
//     res.status(500).json({ message: 'Internal server error' });
//   }
// };


// // UPDATE lesd_status by ID
// export const updateLesdStatus = async (req, res) => {
//   const { id, lesd_status } = req.body;

//   if (!id || !lesd_status) {
//     return res.status(400).json({ message: 'id and lesd_status are required' });
//   }

//   try {
//     const [result] = await db.query(
//       `UPDATE student_fees_by_counselor SET lesd_status = ?, updated_at = NOW() WHERE id = ?`,
//       [lesd_status, id]
//     );

//     if (result.affectedRows === 0) {
//       return res.status(404).json({ message: 'Fee record not found' });
//     }

//     res.json({ message: 'Lesd status updated successfully' });
//   } catch (error) {
//     console.error('Error updating lesd_status:', error);
//     res.status(500).json({ message: 'Internal server error' });
//   }
// };
