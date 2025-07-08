import admin from 'firebase-admin';
import dotenv from 'dotenv';
dotenv.config();

// 🔐 Decode base64
const base64 = process.env.FIREBASE_SERVICE_ACCOUNT_BASE64;

if (!base64) {
  throw new Error("Firebase config not found in .env");
}

const serviceAccount = JSON.parse(
  Buffer.from(base64, 'base64').toString('utf-8')
);

// ✅ Initialize Firebase Admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

export default admin;
