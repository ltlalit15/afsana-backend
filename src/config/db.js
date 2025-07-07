//  live db
import mysql from 'mysql2';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Create a MySQL connection pool
const pool = mysql.createPool({
  host: "nozomi.proxy.rlwy.net",             // ✅ host from CLI
  user: "root",                               // ✅ user from CLI
  password: "gjHTOWGUmuSbMHZPthEEQDFdNAjTakLn", // ✅ password from CLI
  database: "railway",                        // ✅ database name from CLI
  port: 44601,                                // ✅ port from CLI
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







 
