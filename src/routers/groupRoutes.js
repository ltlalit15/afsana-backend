import express from 'express';
import {
  createGroup,
  getGroupMessages,
  getMyGroups,
  userDetails
} from '../controllers/groupController.js';

const router = express.Router();

router.post('/creategroup', createGroup);
router.get('/messagesgroup/:groupId', getGroupMessages);
router.get('/my-groups/:userId', getMyGroups);
router.get('/userdetails', userDetails);

export default router;
