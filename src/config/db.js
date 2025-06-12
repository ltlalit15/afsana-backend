import mysql from 'mysql2';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Create a MySQL connection pool
const pool = mysql.createPool({
  host: "maglev.proxy.rlwy.net",      // Host from your connection string
  user: "root",                       // User from your connection string
  password: "roGbIXVnUBEACLkQGXFLeQRZoIhRSUnR",  // Password from your connection string
  database: "railway",                // Database name from your connection string
  port: 37706,                        // Port from your connection string (use a number here)
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



//import mysql from 'mysql2';
// import dotenv from 'dotenv';
// dotenv.config();
// const pool = mysql.createPool({
//   host: 'hopper.proxy.rlwy.net',         // Updated host from CLI
//   user: 'root',                             // Same as CLI
//   password: 'BHOxQQqKzSpdiuGqXjleyvTllOGsFghr', // Updated password from CLI
//   database: 'railway',                      // Same as CLI
//   port: 22178,                              // Updated port from CLI
//   waitForConnections: true,
//   connectionLimit: 10,
//   queueLimit: 0
// });

// // Test the connection
// pool.getConnection((err, connection) => {
//   if (err) {
//     console.error('❌ MySQL connection failed:', err.message);
//   } else {
//     console.log('✅ MySQL connected successfully!');
//     connection.release();
//   }
// });
// const db = pool.promise();
// export default db;



// import mysql from 'mysql2';
// import dotenv from 'dotenv';
// dotenv.config();

// const pool = mysql.createPool({
//   host: process.env.DB_HOST,
//   user: process.env.DB_USER,
//   password: process.env.DB_PASS,
//   database: process.env.DB_NAME,
// });

// pool.getConnection((err, connection) => {
//   if (err) {
//     console.error('❌ MySQL connection failed:', err.message);
//   } else {
//     console.log('✅ MySQL connected successfully!');
//     connection.release();
//   }
// });
// // Use .promise() here
// const db = pool.promise();
// export default db;
