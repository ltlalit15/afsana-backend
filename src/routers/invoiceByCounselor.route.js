

import express from 'express';
import {
    createStudentFeeBYcounselor,
    getStudentFeesYcounselor,
    getStudentFeeByIdYcounselor,
    updateStudentFeeYcounselor,
    deleteStudentFeeYcounselor,
  
} from '../controllers/counselorInvoice.controller.js';
const router = express.Router();
router.post('/createStudentFeeBYcounselors', createStudentFeeBYcounselor);
router.get('/getStudentFeesYcounselor', getStudentFeesYcounselor);
router.get('/getStudentFeeByIdYcounselor/:id', getStudentFeeByIdYcounselor);
router.put('/updateStudentFeeYcounselo/:id', updateStudentFeeYcounselor);
router.delete('/deleteStudentFeeYcounselor/:id', deleteStudentFeeYcounselor);

export default router;
