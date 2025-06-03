import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import helmet from 'helmet';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
dotenv.config();

const app = express();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
// Middlewares
app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT','PATCH', 'DELETE'],
  }
   ));
app.use(helmet());
app.use(morgan('dev'));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use('/public', express.static(path.join(__dirname, '..', 'public')));
app.use('/uploads', express.static(path.join(__dirname, '..','uploads')));


// Routes
import { responsePage } from './utils/testingPage.js';
import authRoutes from './routers/auth.routes.js';
import inquiryRoutes from './routers/inquiry.route.js';
import followUproute from './routers/follow_ups.router.js';
import leadRoutes from './routers/lead.router.js';
import taskRoutes from './routers/task.routes.js';
import counselor from './routers/counselor.route.js';
import admissiondecision from './routers/admissiondecisions.route.js';
import universityRoutes from './routers/university.route.js';
import invoices from './routers/invoicesRouter.js';
import permissionRoute from './routers/permission.route.js';
import Remainder from './routers/remainderRouter.js';
import paymentRoute from './routers/payment.route.js';
import branchRoutes from './routers/branch.routes.js';
import universityAplyRoutes from './routers/universityApply.routes.js';
import dashboardRoutes from './routers/dashboard.routes.js';
import chatRoutes from './routers/chat.routes.js';
import reportAnaliticsroutes from './routers/reportAnalitics.route.js';
import studentInvoiceRouter from "./routers/studentInvoiceRouter.js"

app.get('/', (_, res) =>{ res.send(responsePage)});
app.use('/api/auth', authRoutes);
app.use('/api', inquiryRoutes);
app.use('/api',followUproute);
app.use('/api',leadRoutes);
app.use('/api', taskRoutes);
app.use('/api', counselor);
app.use('/api', admissiondecision);
app.use('/api', universityRoutes);
app.use('/api', invoices);
app.use('/api',permissionRoute);
app.use('/api', Remainder);
app.use('/api', paymentRoute);
app.use('/api',branchRoutes);
app.use('/api',universityAplyRoutes);
app.use('/api',dashboardRoutes);
app.use('/api', chatRoutes);
app.use('/api',reportAnaliticsroutes);
app.use('/api',studentInvoiceRouter);
export default app;


