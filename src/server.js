import dotenv from 'dotenv';
dotenv.config();

import app from './app.js';
import { createServer } from 'http';
import { Server } from 'socket.io';

import { handleSocketConnection } from './controllers/MessageCtrl.js';

const PORT = process.env.PORT || 5000;

const server = createServer(app);

const io = new Server(server, {
  cors: {
    origin: [
      "https://apply.studyfirstinfo.com",
      "http://localhost:5173",
      "https://afsana-crm-project.netlify.app"
    ],
    methods: ["GET", "POST"],
    credentials: true
  }
});

handleSocketConnection(io);

server.listen(PORT, () => {
  console.log(`🚀 Server running at http://localhost:${PORT}`);
});
