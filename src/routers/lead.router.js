import express from 'express';
import { createLead, deleteLead, getLeadByCounselorId, getLeadById, getLeads, updateLead } from '../controllers/lead.controller.js';
const router = express.Router();

router.post('/lead',createLead);
router.get('/lead', getLeads);
router.get('/lead/:id', getLeadById);
router.get('/lead/counselor/:id', getLeadByCounselorId);
router.put('/lead/:id', updateLead);
router.delete('/lead/:id', deleteLead);
export default router;