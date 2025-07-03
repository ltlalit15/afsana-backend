

import express from 'express';
import { createVisaProcess, updateVisaProcess, GetVisaProcess, getVisaApplicationById, deleteVisaApplication } from '../controllers/visa_process.js';
import { upload } from '../middlewares/upload.js';

const router = express.Router();
router.post('/createVisaProcess/', createVisaProcess);
router.put('/updateVisaProcess/:id',updateVisaProcess);
router.get('/VisaProcess',GetVisaProcess);
router.get('/VisaProcess/:id',getVisaApplicationById);
router.delete('/VisaProcess/:id',deleteVisaApplication);

export default router;
