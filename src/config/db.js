//  live db
import mysql from 'mysql2';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Create a MySQL connection pool
const pool = mysql.createPool({
  host: "trolley.proxy.rlwy.net",                // ✅ Host as per CLI
  user: "root",                                   // ✅ Username
  password: "lkVqcqRxHqXWajECAoiyQOCQGOFsUEiY",   // ✅ Password
  database: "railway",                            // ✅ DB Name
  port: 15025,                                    // ✅ Port as per CLI
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});


// Test connection to the database
pool.getConnection((err, connection) => {
  if (err) {
    console.error('❌ MySQL connection failed:', err.message);
  } else {
    console.log('✅ MySQL connected successfully!');
    connection.release(); // Release the connection back to the pool
  }
});

// Use promise API for working with queries
const db = pool.promise();

// Export the pool for use elsewhere
export default db;








 
