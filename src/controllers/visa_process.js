// POST /api/visa-process/create
import db from '../config/db.js';
import { studentNameById } from '../models/student.model.js';
import { universityNameById } from '../models/universities.model.js';
import cloudinary from "cloudinary";
import fs from 'fs';

cloudinary.config({
    cloud_name: 'dkqcqrrbp',
    api_key: '418838712271323',
    api_secret: 'p12EKWICdyHWx8LcihuWYqIruWQ'
});

export const createVisaProcess = async (req, res) => {
    const data = req.body;

    const requiredFields = [
        'full_name', 'email', 'phone', 'date_of_birth',
        'passport_no', 'applied_program', 'intake',
        'assigned_counselor', 'registration_date', 'source'
    ];

    for (let field of requiredFields) {
        if (!data[field]) {
            return res.status(400).json({ message: `${field} is required.` });
        }
    }
    try {
        const [result] = await db.query('INSERT INTO visa_process SET ?', data);
        res.status(201).json({ message: 'Visa process started', id: result.insertId , 
            ...data
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ message: 'Failed to create record', error: error.message });
    }
};

export const updateVisaProcess = async (req, res) => {
    const id = req.params.id;
    const updates = req.body;

    try {
        const [result] = await db.query('UPDATE visa_process SET ? WHERE id = ?', [updates, id]);
        res.status(200).json({ message: 'Visa process updated', affectedRows: result.affectedRows });
    } catch (error) {
        console.error('Update error:', error);
        res.status(500).json({ message: 'Update failed', error: error.message });
    }
};



// GET /api/visa-process
export const GetVisaProcess = async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM visa_process ORDER BY created_at DESC');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching visa applications:', error);
        res.status(500).json({ message: 'Error retrieving visa applications', error: error.message });
    }
};


// GET /api/visa-process/:id
export const getVisaApplicationById = async (req, res) => {
    const id = req.params.id;
    try {
        const [rows] = await db.query('SELECT * FROM visa_process WHERE id = ?', [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: 'Visa application not found' });
        }
        res.status(200).json(rows[0]);
    } catch (error) {
        console.error('Error fetching visa application by ID:', error);
        res.status(500).json({ message: 'Error retrieving visa application', error: error.message });
    }
};


// DELETE /api/visa-process/:id
export const deleteVisaApplication = async (req, res) => {
    const id = req.params.id;
    try {
        const [result] = await db.query('DELETE FROM visa_process WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Visa application not found or already deleted' });
        }
        res.status(200).json({ message: 'Visa application deleted successfully' });
    } catch (error) {
        console.error('Error deleting visa application:', error);
        res.status(500).json({ message: 'Error deleting visa application', error: error.message });
    }
};

