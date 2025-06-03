import express from 'express';
import { upload } from '../middlewares/upload.js';
import { createPayment, getPaymentByEmail, getPayments,deletePayment ,getPaymentsByid} from '../controllers/payment.controller.js';
const router = express.Router();


router.post("/payments", upload.single("file"), createPayment);
router.get('/payments',getPayments);
router.get('/payments/:email',getPaymentByEmail) ;
router.get('/paymentsbyid/:student_id',getPaymentsByid) ;
router.delete('/payments/:id',deletePayment) ;
export default router;