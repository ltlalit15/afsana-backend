import db from '../config/db.js';
import dotenv from 'dotenv';
dotenv.config();

export const createInquiry = async (req, res) => {
  const { 
    counselor_id, inquiry_type, source, branch, full_name, phone_number, email, 
    course_name, country, city,  date_of_birth, gender , medium,  study_level, study_field,
    intake, budget, consent, highest_level, ssc, hsc ,bachelor ,university , test_type,  overall_score, reading_score, writing_score, speaking_score, listening_score, date_of_inquiry, address, present_address, additionalNotes, 
    study_gap, visa_refused, refusal_reason, education_background, english_proficiency, company_name, job_title,
    job_duration, preferred_countries  
  } = req.body;
  console.log("req.body ", req.body);
  try {
    // if (!inquiry_type || !source || !branch || !full_name || !phone_number || !email ||
    //   !course_name || !country || !city || !date_of_inquiry || !address || !present_address ||
    //   !education_background  || !company_name || !job_title ||
    //   !job_duration || !preferred_countries
    // ) {
    //   return res.status(400).json({ message: "All fields are required." });
    // }

    // Handle 'undefined' and undefined counselor_id
    const formattedCounselorId = (counselor_id === "undefined" || counselor_id === undefined) ? null : counselor_id;

    const [result] = await db.query(
      `INSERT INTO inquiries 
        (counselor_id, inquiry_type, source, branch, full_name, phone_number, email, 
         course_name, country, city, date_of_birth, gender, medium, study_level, study_field,
    intake, budget, consent,  highest_level, ssc, hsc ,bachelor ,university , test_type, overall_score, reading_score, writing_score, speaking_score, listening_score,   date_of_inquiry, address, present_address, additionalNotes ,
        study_gap, visa_refused, refusal_reason, education_background, english_proficiency, company_name, job_title, 
         job_duration, preferred_countries, lead_status,payment_status, assignment_description)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0, 0);`,
      [
        formattedCounselorId, inquiry_type, source, branch, full_name, phone_number, email,
        course_name, country, city, date_of_birth, gender, medium , study_level, study_field,
    intake, budget, consent,  highest_level, ssc, hsc ,bachelor ,university, test_type, overall_score, reading_score, writing_score, speaking_score, listening_score,  date_of_inquiry, address, present_address, additionalNotes, study_gap, visa_refused, refusal_reason,
        JSON.stringify(education_background), JSON.stringify(english_proficiency),
        company_name, job_title, job_duration,  JSON.stringify(preferred_countries)
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

// controllers/inquiry.controller.js
// Update Inquiry and Assign Counselor
// export const assignInquiry = async (req, res) => {
//   const { inquiry_id, counselor_id } = req.body;
//   if (!inquiry_id || !counselor_id) {
//     return res.status(400).json({ message: 'inquiry_id and counselor_id are required' });
//   }
//   try {
//     const [result] = await db.query(
//       `UPDATE inquiries SET counselor_id = ? WHERE id = ?`,
//       [counselor_id, inquiry_id]
//     );
//     if (result.affectedRows === 0) {
//       return res.status(404).json({ message: 'Inquiry not found' });
//     }
//     res.status(200).json({ message: 'Inquiry assigned successfully' });
//   } catch (error) {
//     console.error('Error assigning inquiry:', error);
//     res.status(500).json({ message: 'Internal server error' });
//   }
// };


export const assignInquiry = async (req, res) => {
  const { inquiry_id, counselor_id } = req.body;
  if (!inquiry_id || !counselor_id) {
    return res.status(400).json({ message: 'inquiry_id and counselor_id are required' });
  }
  try {
    const [result] = await db.query(
      `UPDATE inquiries SET counselor_id = ?, status = 1 WHERE id = ?`,
      [counselor_id, inquiry_id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Inquiry not found' });
    }
    res.status(200).json({ message: 'Inquiry assigned successfully and status updated to 1' });
  } catch (error) {
    console.error('Error assigning inquiry:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};


export const getAllConvertedLeads = async (req, res) => {
  try {
    const query = "SELECT * FROM inquiries WHERE lead_status = 'Converted to Lead'";
    const [result] = await db.query(query);
    if (result.length === 0) {
      return res.status(404).json({ message: 'No converted leads found' });
    }
    res.status(200).json(result);
  } catch (error) {
    console.error("Error fetching converted leads:", error);
    res.status(500).json({ message: 'Server error', error });
  }
};





























export const getAllleadsstatus = async (req, res) => {
  try {
    const query = "SELECT * FROM inquiries WHERE lead_status != '0'";
    //  const query = `
    //   SELECT 
    //     inquiries.*, 
    //     users.full_name AS counselor_name
    //   FROM inquiries
    //   LEFT JOIN counselors ON inquiries.counselor_id = counselors.id
    //   LEFT JOIN users ON users.counselor_id = counselors.id
    //   WHERE inquiries.lead_status != '0'
    // `;
    const [result] = await db.query(query);
    if (result.length === 0) {
      return res.status(404).json({ message: 'No leads found (excluding status 0)' });
    }
    res.status(200).json(result);
  } catch (error) {
    console.error("Error fetching leads:", error);
    res.status(500).json({ message: 'Server error', error });
  }
};


export const getCounselorWisePerformance = async (req, res) => {
  try {
    const [data] = await db.query(`
      SELECT 
        counselor_id,
        COUNT(*) AS total_leads,
        SUM(lead_status = 'Converted') AS converted_leads,
        MAX(status) AS status
      FROM inquiries
      GROUP BY counselor_id
    `);

    // Optional: Map counselor_id to actual counselor names if needed
    const formatted = data.map((row) => ({
      counselor_id: row.counselor_id,
      counselor_name: `Counselor ${row.counselor_id}`, // replace with JOIN if names exist
      total_leads: row.total_leads,
      converted_leads: row.converted_leads,
      status: row.status === 1 ? 'Active' : 'Inactive',
    }));

    res.status(200).json(formatted);
  } catch (error) {
    console.error('Error fetching counselor performance:', error);
    res.status(500).json({ message: 'Server error', error });
  }
};


  
