import db from '../config/db.js';


export const createUniversity = async (req, res) => {
  try {
    const {
      user_id,
      name,
      location,
      programs,
      highlights,
      contact_phone,
      contact_email,
    } = req.body;

    // Extract uploaded logo file
    const logoFile = req.file;
    console.log("logofile : ",logoFile);
    const logo_url = logoFile
      ? `/uploads/${logoFile.filename}`
      : '';

    // Validate required fields
    if (!user_id || !name) {
      return res.status(400).json({ message: 'user_id and name are required' });
    }

    // Store university in DB
    const [result] = await db.query(
      `INSERT INTO universities 
       (user_id, name, logo_url, location, programs, highlights, contact_phone, contact_email) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        user_id,
        name,
        logo_url,
        location,
        JSON.stringify(programs),
        JSON.stringify(highlights),
        contact_phone,
        contact_email,
      ]
    );

    res.status(201).json({ message: 'University created successfully', universityId: result.insertId });
  } catch (error) {
    console.error('Error creating university:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};


  export const getAllUniversities = async (req, res) => {
    try {
      const [rows] = await db.query('SELECT * FROM universities');
  
      const parsedRows = rows.map((row) => ({
        ...row,
        logo_url: row.logo_url ? `${req.protocol}://${req.get('host')}${row.logo_url}` : null,
        programs: JSON.parse(row.programs || '[]'),
        highlights: JSON.parse(row.highlights || '[]'),
      }));
  
      res.status(200).json(parsedRows);
    } catch (error) {
      console.error('Error fetching universities:', error);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
  

  export const getUniversityById = async (req, res) => {
    try {
      const { id } = req.params;
      const [rows] = await db.query('SELECT * FROM universities WHERE id = ?', [id]);
  
      if (rows.length === 0) {
        return res.status(404).json({ message: 'University not found' });
      }
  
      const parsedRows = rows.map((row) => ({
        ...row,
        logo_url: row.logo_url ? `${req.protocol}://${req.get('host')}$/api{row.logo_url}` : null,
        programs: JSON.parse(row.programs || '[]'),
        highlights: JSON.parse(row.highlights || '[]'),
      }));
  
      res.status(200).json(parsedRows[0]);
    } catch (error) {
      console.error('Error fetching university:', error);
      res.status(500).json({ message: 'Internal server error' });
    }
  };
  

 export const updateUniversity = async (req, res) => {
    try {
      const { id } = req.params;
      const {
        user_id,
        name,
        logo_url,
        location,
        programs,
        highlights,
        contact_phone,
        contact_email,
      } = req.body;
  
      const [result] = await db.query(
        `UPDATE universities SET 
        user_id = ?, 
        name = ?, 
        logo_url = ?, 
        location = ?, 
        programs = ?, 
        highlights = ?, 
        contact_phone = ?, 
        contact_email = ?, 
        updated_at = CURRENT_TIMESTAMP 
        WHERE id = ?`,
        [
          user_id,
          name,
          logo_url,
          location,
          JSON.stringify(programs),
          JSON.stringify(highlights),
          contact_phone,
          contact_email,
          id,
        ]
      );
  
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'University not found' });
      }
  
      res.status(200).json({ message: 'University updated successfully' });
    } catch (error) {
      console.error('Error updating university:', error);
      res.status(500).json({ message: 'Internal server error' });
    }
  };


  export const deleteUniversity = async (req, res) => {
    try {
      const { id } = req.params;
      const [result] = await db.query('DELETE FROM universities WHERE id = ?', [id]);
  
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'University not found' });
      }
  
      res.status(200).json({ message: 'University deleted successfully' });
    } catch (error) {
      console.error('Error deleting university:', error);
      res.status(500).json({ message: 'Internal server error' });
    }
  };