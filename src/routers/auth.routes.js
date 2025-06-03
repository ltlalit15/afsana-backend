import express from 'express';
import { upload } from '../middlewares/upload.js';
import { register, login, createStudent, getAllStudents, getStudentById, deleteStudent, changeNewPassword, updateUser, getuserById, getAllByRoles } from '../controllers/auth.controller.js';
import { authenticate } from '../middlewares/auth.middleware.js';

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.get('/getUser/:id',getuserById)
router.post('/changePassword/:id',changeNewPassword);
router.post('/createStudent',authenticate, upload.fields([
    { name: 'photo', maxCount: 1 },
    { name: 'documents', maxCount: 1 }
  ]), createStudent);
router.get('/getAllStudents',getAllStudents);
router.get('/getStudentById/:id',authenticate, getStudentById);
router.put('/updateUser/:id', upload.fields([
  { name: 'photo', maxCount: 1 },
  { name: 'documents', maxCount: 1 }
]), updateUser);
router.delete('/deleteStudent/:id', deleteStudent);
router.get("/getusersByRole/:role",getAllByRoles)
export default router;