import express from 'express';
import { createInquiry, deleteInquiry, getAllInquiries, getInquiryById, updateInquiry, assignInquiry } from '../controllers/inquiry.controller.js';
// import { authenticate } from '../middlewares/auth.middleware.js';
const router = express.Router();
router.post('/inquiries', createInquiry);
router.get('/inquiries/:id', getInquiryById);
router.put('/inquiries/:id', updateInquiry);
router.delete('/inquiries/:id', deleteInquiry); 
router.get('/inquiries', getAllInquiries);

router.post('/assign-inquiry', assignInquiry); // ✅ Add this line



export default router;
