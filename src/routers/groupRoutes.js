import express from 'express';
import {
  createGroup,
  getGroupMessages,
  getMyGroups
} from '../controllers/groupController.js';

const router = express.Router();

router.post('/creategroup', createGroup);
router.get('/messagesgroup/:groupId', getGroupMessages);
router.get('/my-groups/:userId', getMyGroups);

export default router;
