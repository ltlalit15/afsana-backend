import express from 'express';
import {
  createGroup,
  getGroupMessages,
  getMyGroups,
  userDetails,
  getAssignedStudents,
  getAssignedcounselor
} from '../controllers/groupController.js';

const router = express.Router();

router.post('/creategroup', createGroup);
router.get('/messagesgroup/:groupId', getGroupMessages);
router.get('/my-groups/:userId', getMyGroups);
router.get('/userdetails', userDetails);
router.get('/getAssignedStudents', getAssignedStudents);
router.get('/getAssignedcounselor', getAssignedcounselor);

export default router;
