import express from 'express';
import { createApply, deleteApply, getAllApplications, getAllApplicationsById, getAplicationBYStudentID, getApplicationByStudentAndUniversity, updateApply, updateStatus, assignCounselor , getApplicationsByCounselor } from '../controllers/universityApply.controller.js';
import { upload } from '../middlewares/upload.js';
const router = express.Router();

// router.post('/application', upload.fields([
//     { name: 'fee_confirmation_document' },
//     { name: 'conditional_offer_letter' },
//     { name: 'invoice_with_conditional_offer' },
//     { name: 'tuition_fee_transfer_proof' },
//     { name: 'final_university_offer_letter' },
//     { name: 'appendix_form_completed' },
//     { name: 'passport_copy_prepared' },
//     { name: 'financial_support_declaration' },
//     { name: 'final_offer_letter' },
//     { name: 'proof_of_relationship' },
//     { name: 'english_language_proof' },
//     { name: 'residence_permit_form' },
//     { name: 'proof_of_income' },
//     { name: 'airplane_ticket_booking' },
//     { name: 'police_clearance_certificate' },
//     { name: 'europass_cv' },
//     { name: 'birth_certificate' },
//     { name: 'bank_statement' },
//     { name: 'accommodation_proof' },
//     { name: 'motivation_letter' },
//     { name: 'previous_studies_certificates' },
//     { name: 'travel_insurance' },
//     { name: 'european_photo' },
//     { name: 'health_insurance' }
// ]), createApply);


router.post('/application', createApply);
router.patch('/assignCounselorapllication', assignCounselor);

router.get('/applications/counselor/:counselor_id', getApplicationsByCounselor);




router.get('/application',getAllApplications);
router.get('/application/:id', getAllApplicationsById);
router.get('/studentApplication/:studentId',getAplicationBYStudentID);
router.get('/application/:studentId/:universityId', getApplicationByStudentAndUniversity);
// router.put('/application/:id', upload.fields([
//     { name: 'fee_confirmation_document' },
//     { name: 'conditional_offer_letter' },
//     { name: 'invoice_with_conditional_offer' },
//     { name: 'tuition_fee_transfer_proof' },
//     { name: 'final_university_offer_letter' },
//     { name: 'appendix_form_completed' },
//     { name: 'passport_copy_prepared' },
//     { name: 'financial_support_declaration' },
//     { name: 'final_offer_letter' },
//     { name: 'proof_of_relationship' },
//     { name: 'english_language_proof' },
//     { name: 'residence_permit_form' },
//     { name: 'proof_of_income' },
//     { name: 'airplane_ticket_booking' },
//     { name: 'police_clearance_certificate' },
//     { name: 'europass_cv' },
//     { name: 'birth_certificate' },
//     { name: 'bank_statement' },
//     { name: 'accommodation_proof' },
//     { name: 'motivation_letter' },
//     { name: 'previous_studies_certificates' },
//     { name: 'travel_insurance' },
//     { name: 'european_photo' },
//     { name: 'health_insurance' }
//   ]), updateApply);


router.put('/application/:id', updateApply);
  router.delete('/application/:id', deleteApply);
  router.patch('/application/:id', updateStatus);
export default router;
