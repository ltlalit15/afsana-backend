import mysql from 'mysql2';
import dotenv from 'dotenv';
dotenv.config();

// Create MySQL connection pool with your details
const pool = mysql.createPool({
  host: "maglev.proxy.rlwy.net",  // Updated host
  user: "root",                   // Your database username
  password: "HAEtdjQHMHeKsWfCkURaWJkHPmqoFfxD",  // Your database password
  database: "railway",            // Your database name
  port: 21971,                    // Updated port
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Get a connection and handle connection success/error
pool.getConnection((err, connection) => {
  if (err) {
    console.error('❌ MySQL connection failed:', err.message);
  } else {
    console.log('✅ MySQL connected successfully!');
    connection.release(); // Release the connection back to the pool
  }
});

// Use .promise() to work with async/await
const db = pool.promise();

// Export the db object for use in other parts of the app
export default db;
