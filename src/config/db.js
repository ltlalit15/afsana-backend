//  live db
import mysql from 'mysql2';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Create a MySQL connection pool
const pool = mysql.createPool({
  host: "shortline.proxy.rlwy.net",               // ✅ New host
  user: "root",                                    // ✅ Username from CLI
  password: "LIknVKtgQGhauuQPrUiLuhTaXminChaS",    // ✅ Password from CLI
  database: "railway",                             // ✅ Database name
  port: 51412,                                     // ✅ New port
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







 
