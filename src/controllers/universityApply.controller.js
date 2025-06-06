import db from '../config/db.js';
import { studentNameById } from '../models/student.model.js';
import { universityNameById } from '../models/universities.model.js';

export const createAply = async (req, res) => {
    const data = req.body;
    const files = req.files;
  
    console.log("Files received:", files);
  
    // List of date fields
    const dateFields = [
      "registration_date",
      "application_submission_date",
      "university_interview_date",
      "university_offer_letter_received",
      "appointment_date",
      "visa_interview_date",
      "final_offer_letter"
    ];
  
    // Map file paths to fields
    for (const key in files) {
      if (files[key] && files[key][0]) {
        data[key] = `/uploads/${files[key][0].filename}`;
      }
    }
  
    // Convert empty strings to NULL for date fields and other fields
    Object.keys(data).forEach((key) => {
      if (data[key] === '') {
        data[key] = null;
      }
  
      // If the field is a date field, validate the format
      if (dateFields.includes(key) && data[key]) {
        const dateValue = new Date(data[key]);
        if (isNaN(dateValue.getTime())) {
          data[key] = null;  // Invalid date, set to NULL
        }
      }
    });
  
    try {
      const query = `INSERT INTO StudentApplicationProcess SET ?`;
      const [result] = await db.query(query, data);
  
      res.status(201).json({ message: 'Record created successfully', id: result.insertId });
    } catch (error) {
      console.error('Error creating record:', error);
      res.status(500).json({ message: 'Error creating record', error: error.message });
    }
  };
  
  export const getAllApplications = async (req, res) => {
    try {
        const query = `SELECT * FROM StudentApplicationProcess`;
        const [applications] = await db.query(query);

        if (applications.length === 0) {
            return res.status(404).json({ message: 'No applications found' });
        }

        const baseUrl = `${req.protocol}://${req.get('host')}`;

        // Fields to update with base URL
        const fileFields = [
            'fee_confirmation_document',
            'conditional_offer_letter',
            'invoice_with_conditional_offer',
            'tuition_fee_transfer_proof',
            'final_university_offer_letter',
            'passport_copy_prepared',
            'financial_support_declaration',
            'final_offer_letter',
            'proof_of_relationship',
            'english_language_proof',
            'residence_permit_form',
            'proof_of_income',
            'airplane_ticket_booking',
            'police_clearance_certificate',
            'europass_cv',
            'birth_certificate',
            'bank_statement',
            'accommodation_proof',
            'motivation_letter',
            'previous_studies_certificates',
            'travel_insurance',
            'european_photo',
            'health_insurance'
        ];

        // Transform data
        const data = await Promise.all(
            applications.map(async (app) => {
                let studentName = '';
                let universityName = '';
                try {
                    const studentResult = await studentNameById(app.student_id);
                    const universityResult = await universityNameById(app.university_id); 
                    studentName = studentResult[0]?.full_name || '';
                    universityName = universityResult[0]?.name || '';
                } catch (err) {
                    console.error(`Error fetching student name for ID ${app.student_id}:`, err);
                }

                // Update file paths with base URL
                fileFields.forEach((field) => {
                    if (app[field] !== null ) {
                        app[field] = `${baseUrl}${app[field]}`;
                    } else {
                        app[field] = null; // Ensure the field is explicitly set to null
                    }
                });

                return {
                    ...app,
                    student_name: studentName,
                    university_name: universityName
                };
            })
        );

        res.status(200).json(data);
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ message: 'Error fetching data', error: error.message });
    }
};

export const getAllApplicationsById = async (req, res) => {
    const { id } = req.params;

    if (!id) {
        return res.status(400).json({ message: 'Application ID is required' });
    }

    try {
        const query = `SELECT * FROM StudentApplicationProcess WHERE id = ?`;
        const [applications] = await db.query(query, [id]);

        if (applications.length === 0) {
            return res.status(404).json({ message: 'No applications found for the given ID' });
        }

        const baseUrl = `${req.protocol}://${req.get('host')}`;

        const fileFields = [
            'fee_confirmation_document',
            'conditional_offer_letter',
            'invoice_with_conditional_offer',
            'tuition_fee_transfer_proof',
            'final_university_offer_letter',
            'passport_copy_prepared',
            'financial_support_declaration',
            'final_offer_letter',
            'proof_of_relationship',
            'english_language_proof',
            'residence_permit_form',
            'proof_of_income',
            'airplane_ticket_booking',
            'police_clearance_certificate',
            'europass_cv',
            'birth_certificate',
            'bank_statement',
            'accommodation_proof',
            'motivation_letter',
            'previous_studies_certificates',
            'travel_insurance',
            'european_photo',
            'health_insurance'
        ];

        const data = await Promise.all(
            applications.map(async (app) => {
                let studentName = '';
                let universityName = '';

                try {
                    const studentResult = await studentNameById(app.student_id);
                    const universityResult = await universityNameById(app.university_id);

                    studentName = studentResult[0]?.full_name || '';
                    universityName = universityResult[0]?.name || '';
                } catch (err) {
                    console.error(`Error fetching related data for ID ${id}:`, err);
                }

                // Update file paths with base URL
                fileFields.forEach((field) => {
                    if (app[field]) {
                        app[field] = `${baseUrl}${app[field]}`;
                    }
                });

                return {
                    ...app,
                    student_name: studentName,
                    university_name: universityName
                };
            })
        );

        res.status(200).json(data[0]); // Return the first (and only) record
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ message: 'Error fetching data', error: error.message });
    }
};

export const getAplicationBYStudentID = async (req, res) => {
    console.log("req ", req.params);
    const studentId = req.params.studentId;
    try {
        const query = `SELECT * FROM StudentApplicationProcess WHERE student_id = ?`;
        const [applications] = await db.query(query, [studentId]);

        if (applications.length === 0) {
            return res.status(404).json({ message: 'No applications found for the given student ID' });
        }

        const baseUrl = `${req.protocol}://${req.get('host')}`;

        // Fields to update with base URL
        const fileFields = [
            'fee_confirmation_document',
            'conditional_offer_letter',
            'invoice_with_conditional_offer',
            'tuition_fee_transfer_proof',
            'final_university_offer_letter',
            'passport_copy_prepared',
            'financial_support_declaration',
            'final_offer_letter',
            'proof_of_relationship',
            'english_language_proof',
            'residence_permit_form',
            'proof_of_income',
            'airplane_ticket_booking',
            'police_clearance_certificate',
            'europass_cv',
            'birth_certificate',
            'bank_statement',
            'accommodation_proof',
            'motivation_letter',
            'previous_studies_certificates',
            'travel_insurance',
            'european_photo',
            'health_insurance'
        ];

        // Transform data
        const data = await Promise.all(
            applications.map(async (app) => {
                let studentName = '';
                let universityName = '';
                try {
                    const studentResult = await studentNameById(app.student_id);
                    const universityResult = await universityNameById(app.university_id); 
                    studentName = studentResult[0]?.full_name || '';
                    universityName = universityResult[0]?.name || '';
                } catch (err) {
                    console.error(`Error fetching student name for ID ${app.student_id}:`, err);
                }

                // Update file paths with base URL
                fileFields.forEach((field) => {
                    if (app[field]) {
                        app[field] = `${baseUrl}${app[field]}`;
                    }
                });

                return {
                    ...app,
                    student_name: studentName,
                    university_name: universityName
                };
            })
        );

        res.status(200).json(data);
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ message: 'Error fetching data', error: error.message });
    }
};

export const getApplicationByStudentAndUniversity = async (req, res) => {
    const { studentId, universityId } = req.params;

    try {
        const query = `SELECT * FROM StudentApplicationProcess WHERE student_id = ? AND university_id = ?`;
        const [applications] = await db.query(query, [studentId, universityId]);

        if (applications.length === 0) {
            return res.status(404).json({ status: false, message: 'No applications found for the given student and university ID' });
        }

        // const baseUrl = `${req.protocol}://${req.get('host')}`;

        // Fields to update with base URL
        const fileFields = [
            'fee_confirmation_document',
            'conditional_offer_letter',
            'invoice_with_conditional_offer',
            'tuition_fee_transfer_proof',
            'final_university_offer_letter',
            'passport_copy_prepared',
            'financial_support_declaration',
            'final_offer_letter',
            'proof_of_relationship',
            'english_language_proof',
            'residence_permit_form',
            'proof_of_income',
            'airplane_ticket_booking',
            'police_clearance_certificate',
            'europass_cv',
            'birth_certificate',
            'bank_statement',
            'accommodation_proof',
            'motivation_letter',
            'previous_studies_certificates',
            'travel_insurance',
            'european_photo',
            'health_insurance'
        ];

        // Transform data
        const data = await Promise.all(
            applications.map(async (app) => {
                let studentName = '';
                let universityName = '';

                try {
                    const studentResult = await studentNameById(app.student_id);
                    const universityResult = await universityNameById(app.university_id);

                    studentName = studentResult[0]?.full_name || '';
                    universityName = universityResult[0]?.name || '';
                } catch (err) {
                    console.error(`Error fetching student/university name for student_id ${app.student_id} and university_id ${app.university_id}:`, err);
                }

                // Update file paths with base URL
                fileFields.forEach((field) => {
                    if (app[field]) {
                        app[field] = `${app[field]}`;
                    }
                });

                return {
                    ...app,
                    student_name: studentName,
                    university_name: universityName
                };
            })
        );

        res.status(200).json({status: true, data});
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ message: 'Error fetching data', error: error.message });
    }
};

export const updateAply = async (req, res) => {
    const { id } = req.params;
    const data = req.body;
    const files = req.files;
  
    console.log("Files received for update:", files);
  
    // List of date fields
    const dateFields = [
      "registration_date",
      "application_submission_date",
      "university_interview_date",
      "university_offer_letter_received",
      "appointment_date",
      "visa_interview_date",
     
    ];
  
    // Map file paths to fields
    for (const key in files) {
      if (files[key] && files[key][0]) {
        data[key] = `/uploads/${files[key][0].filename}`;
      }
    }
  
    // Convert empty strings to NULL and validate date fields
    Object.keys(data).forEach((key) => {
      if (data[key] === '') {
        data[key] = null;
      }
  
      // Validate date fields
      if (dateFields.includes(key) && data[key]) {
        const dateValue = new Date(data[key]);
        if (isNaN(dateValue.getTime())) {
          data[key] = null;  // Invalid date, set to NULL
        }
      }
    });
  
    try {
      const fieldsToUpdate = Object.keys(data).map((key) => `${key} = ?`).join(', ');
      const values = Object.values(data);
  
      const query = `UPDATE StudentApplicationProcess SET ${fieldsToUpdate} WHERE id = ?`;
      values.push(id);
  
      const [result] = await db.query(query, values);
  
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Record not found or no changes made' });
      }
  
      res.status(200).json({ message: 'Record updated successfully' });
    } catch (error) {
      console.error('Error updating record:', error);
      res.status(500).json({ message: 'Error updating record', error: error.message });
    }
  };

export const deleteAply = async (req, res) => {
    const { id } = req.params;
   console.log("req.partam :",id);
    try {
        const query = `DELETE FROM StudentApplicationProcess WHERE id = ?`;
        const [result] = await db.query(query, [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Record not found' });
        }

        res.status(200).json({ message: 'Record deleted successfully' });
    } catch (error) {
        console.error('Error deleting record:', error);
        res.status(500).json({ message: 'Error deleting record', error: error.message });
    }
};

export const updateStatus = async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;

    try {
        const query = `UPDATE StudentApplicationProcess SET status = ? WHERE id = ?`;
        const [result] = await db.query(query, [status, id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Record not found' });
        }

        res.status(200).json({ message: 'Record updated successfully' });
    } catch (error) {
        console.error('Error updating record:', error);
        res.status(500).json({ message: 'Error updating record', error: error.message });
    }
};

