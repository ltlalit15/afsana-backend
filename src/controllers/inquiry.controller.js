import db from '../config/db.js';
import dotenv from 'dotenv';
dotenv.config();


export const createInquiry = async (req, res) => {
  const { 
    counselor_id, inquiry_type, source, branch, full_name, phone_number, email, 
    course_name, country, city, date_of_inquiry, address, present_address, 
    education_background, english_proficiency, company_name, job_title, 
    job_duration, preferred_countries 
  } = req.body;

  console.log("req.body ", req.body);

  try {
    if (!inquiry_type || !source || !branch || !full_name || !phone_number || !email ||
      !course_name || !country || !city || !date_of_inquiry || !address || !present_address ||
      !education_background || !english_proficiency || !company_name || !job_title ||
      !job_duration || !preferred_countries
    ) {
      return res.status(400).json({ message: "All fields are required." });
    }

    // Handle 'undefined' and undefined counselor_id
    const formattedCounselorId = (counselor_id === "undefined" || counselor_id === undefined) ? null : counselor_id;

    const [result] = await db.query(
      `INSERT INTO inquiries 
        (counselor_id, inquiry_type, source, branch, full_name, phone_number, email, 
         course_name, country, city, date_of_inquiry, address, present_address, 
         education_background, english_proficiency, company_name, job_title, 
         job_duration, preferred_countries)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);`,
      [
        formattedCounselorId, inquiry_type, source, branch, full_name, phone_number, email,
        course_name, country, city, date_of_inquiry, address, present_address,
        JSON.stringify(education_background), JSON.stringify(english_proficiency),
        company_name, job_title, job_duration, JSON.stringify(preferred_countries)
      ]
    );

    res.status(201).json({ message: 'Inquiry created successfully', inquiryId: result.insertId });
  } catch (err) {
    console.error('Create Inquiry error:', err);
    res.status(500).json({ message: 'Internal server error', error: err.message });
  }
};

export const getInquiryById = async (req, res) => {
    const { id } = req.params;
  
    try {
      const [results] = await db.query('SELECT * FROM inquiries WHERE id = ?', [id]);
  
      if (results.length === 0) {
        return res.status(404).json({ message: 'Inquiry not found' });
      }
  
      // Parse JSON fields
      const inquiry = {
        ...results[0],
        education_background: JSON.parse(results[0].education_background),
        english_proficiency: JSON.parse(results[0].english_proficiency),
        preferred_countries: JSON.parse(results[0].preferred_countries),
      };
  
      res.json(inquiry);
    } catch (err) {
      console.error('Get Inquiry error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
};

export const updateInquiry = async (req, res) => {
    const { id } = req.params;
    const { 
      counselor_id, inquiry_type, source, branch, full_name, phone_number, email, 
      course_name, country, city, date_of_inquiry, address, present_address, 
      education_background, english_proficiency, company_name, job_title, 
      job_duration, preferred_countries 
    } = req.body;
  
    try {
      const [result] = await db.query(
        `UPDATE inquiries 
        SET counselor_id = ?, inquiry_type = ?, source = ?, branch = ?, full_name = ?, 
            phone_number = ?, email = ?, course_name = ?, country = ?, city = ?, 
            date_of_inquiry = ?, address = ?, present_address = ?, 
            education_background = ?, english_proficiency = ?, 
            company_name = ?, job_title = ?, job_duration = ?, 
            preferred_countries = ?, updated_at = CURRENT_TIMESTAMP 
        WHERE id = ?`,
        [
          counselor_id, inquiry_type, source, branch, full_name, phone_number, email, 
          course_name, country, city, date_of_inquiry, address, present_address, 
          JSON.stringify(education_background), JSON.stringify(english_proficiency), 
          company_name, job_title, job_duration, JSON.stringify(preferred_countries), 
          id
        ]
      );
  
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Inquiry not found' });
      }
  
      res.json({ message: 'Inquiry updated successfully' });
    } catch (err) {
      console.error('Update Inquiry error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
};

export const deleteInquiry = async (req, res) => {
    const { id } = req.params;

    try {
      const [result] = await db.query('DELETE FROM inquiries WHERE id = ?', [id]);

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Inquiry not found' });
      }

      res.json({ message: 'Inquiry deleted successfully' });
    } catch (err) {
      console.error('Delete Inquiry error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };

export const getAllInquiries = async (req, res) => {
    try {
      const [results] = await db.query('SELECT * FROM inquiries');

      // Parse JSON fields for each inquiry
      const inquiries = results.map(inquiry => ({
        ...inquiry,
        education_background: JSON.parse(inquiry.education_background),
        english_proficiency: JSON.parse(inquiry.english_proficiency),
        preferred_countries: JSON.parse(inquiry.preferred_countries),
      }));

      res.json(inquiries);
    } catch (err) {
      console.error('Get All Inquiries error:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  };

  
  
