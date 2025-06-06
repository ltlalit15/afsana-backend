import mysql from 'mysql2';
import dotenv from 'dotenv';
dotenv.config();

const pool = mysql.createPool({
  host: 'switchback.proxy.rlwy.net',    // Updated host
  user: 'root',                         // Your database user
  password: 'PnsJerAIpWJjumuDSoGtHgwQGqYUDuhu', // Your database password
  database: 'railway',                  // Your database name
  port: 38975,                          // Updated port
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Test the connection
pool.getConnection((err, connection) => {
  if (err) {
    console.error('❌ MySQL connection failed:', err.message);
  } else {
    console.log('✅ MySQL connected successfully!');
    connection.release();
  }
});

// Use .promise() here to enable promise-based API
const db = pool.promise();

export default db;
