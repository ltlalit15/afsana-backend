
import express from 'express';
import { createVisaProcess, updateVisaProcess, GetVisaProcess, getVisaApplicationById, deleteVisaApplication ,getVisaProcessByStudentId } from '../controllers/visa_process.js';
import { upload } from '../middlewares/upload.js';
import { getAllAdmissionDecisions } from '../controllers/AdmissionDecisions.controller.js';

const router = express.Router();
router.post('/createVisaProcess/', createVisaProcess);
router.put('/createVisaProcess/:id',updateVisaProcess);
router.get('/VisaProcess',GetVisaProcess);
router.get('/VisaProcess/:id',getVisaApplicationById);
router.delete('/VisaProcess/:id',deleteVisaApplication);


router.get('/getVisaProcessByStudentId/VisaProcess/:student_id', getVisaProcessByStudentId);




export default router;
