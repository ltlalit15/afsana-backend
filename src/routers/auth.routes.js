import express from 'express';
import { upload } from '../middlewares/upload.js';
import {createStudent, register, login, StudentAssignToCounselor, getAllStudents, getStudentById, deleteStudent, changeNewPassword, updateUser, getuserById, getAllByRoles, getStudentsByCounselorId, signupWithGoogle , sendOtpToEmail, verifyOtp, createStudentWithGoogle
, updateStudent, validateToken, getAssignedStudents, editStudent} from '../controllers/auth.controller.js';
// import { authenticate } from '../middlewares/auth.middleware.js';
const router = express.Router();
router.post('/register', register);
router.post('/login', login);
router.get('/getUser/:id',getuserById)
router.post('/changePassword/:id',changeNewPassword);
router.post('/createStudent', createStudent);
router.post('/check-google-details', signupWithGoogle);
router.post("/send-otp", sendOtpToEmail);
router.post("/verify-otp", verifyOtp);
router.patch('/StudentAssignToCounselor', StudentAssignToCounselor);
router.get('/students/by-counselor/:counselorId', getStudentsByCounselorId);
// router.get('/getStudentById/:id',authenticate, getStudentById);
router.get('/getStudentById/:id', getStudentById);
router.get('/getAllStudents',getAllStudents);
router.put('/updateStudent/:id', updateStudent);
router.put('/updateUser/:id', upload.fields([
  { name: 'photo', maxCount: 1 },
  { name: 'documents', maxCount: 1 }
]), updateUser);
router.delete('/deleteStudent/:id', deleteStudent);
router.get("/getusersByRole/:role",getAllByRoles)
router.post('/student/google-signup', createStudentWithGoogle);
router.get('/getAssignedStudents/:counselor_id', getAssignedStudents);
router.post('/register', register);
router.post('/login', login);
router.post('/validate-token', validateToken); // 👈 Add this route
router.put('/students/:id', editStudent);
export default router;
