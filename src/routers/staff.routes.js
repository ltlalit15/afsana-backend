import express from 'express';
import { createStaff , getAllStaff, deleteStaff, updateStaff } from '../controllers/staff.controller.js';

const router = express.Router();
router.post('/createStaff', createStaff);
router.get('/getAllStaff', getAllStaff);
router.delete('/deleteStaff/:id', deleteStaff);   
router.put('/updateStaff/:id', updateStaff);   
export default router;  
