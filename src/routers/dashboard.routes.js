import express from 'express';
import { getDashboardData, getDashboardDataAdmin, getDashboardDataUniversity ,getDashboardInfo} from '../controllers/dashboard.controller.js';
const router = express.Router();

router.get ('/dashboard/:counselor_id',getDashboardData)
router.get ('/dashboard', getDashboardDataAdmin);
router.get ('/dashboardinfo', getDashboardInfo);
router.get ('/dashboardApplyUniveristy/:university_id/:studentId', getDashboardDataUniversity)
export default router;