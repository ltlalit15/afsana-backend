

import express from 'express';
import {
    createStudentFeeBYcounselor,
    getStudentFeesYcounselor,
    getStudentFeeByIdYcounselor,
    updateStudentFeeYcounselor,
    deleteStudentFeeYcounselor,
    getStudentFeesByUser
  
} from '../controllers/counselorInvoice.controller.js';
const router = express.Router();
router.post('/createStudentFeeBYcounselors', createStudentFeeBYcounselor);
router.get('/getStudentFeesYcounselor', getStudentFeesYcounselor);
router.get('/getStudentFeeByIdYcounselor/:id', getStudentFeeByIdYcounselor);
router.put('/updateStudentFeeYcounselo/:id', updateStudentFeeYcounselor);
router.delete('/deleteStudentFeeYcounselor/:id', deleteStudentFeeYcounselor);
router.get('/getStudentFeesByUser/:user_id', getStudentFeesByUser);

export default router;
