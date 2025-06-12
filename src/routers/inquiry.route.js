import express from 'express';
import { createInquiry, deleteInquiry, getAllInquiries, getInquiryById, updateInquiry, assignInquiry, getCounselorWisePerformance ,  getAllConvertedLeads , getAllleadsstatus } from '../controllers/inquiry.controller.js';
// import { authenticate } from '../middlewares/auth.middleware.js';
const router = express.Router();
router.post('/inquiries', createInquiry);
router.get('/inquiries/:id', getInquiryById);
router.put('/inquiries/:id', updateInquiry);
router.delete('/inquiries/:id', deleteInquiry); 
router.get('/inquiries', getAllInquiries);
router.get('/AllConvertedLeadsinquiries', getAllConvertedLeads);
router.post('/assign-inquiry', assignInquiry); // ✅ Add this line
router.get('/counselor-performance', getCounselorWisePerformance); // ✅ Add this linegetAllleadsstatus
router.get('/getAllleadsstatus', getAllleadsstatus); // ✅ Add this linegetAllleadsstatus

export default router;
