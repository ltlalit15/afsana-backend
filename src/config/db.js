// //  live db
// import mysql from 'mysql2';
// import dotenv from 'dotenv';

// // Load environment variables
// dotenv.config();

// // Create a MySQL connection pool
// const pool = mysql.createPool({
//   host: "gondola.proxy.rlwy.net",      // Host from your connection string
//   user: "root",                       // User from your connection string
//   password: "CmfdcqUWwOUlmpqvuXnDaTSNPfnEiTQW",  // Password from your connection string
//   database: "railway",                // Database name from your connection string
//   port: 49525,                        // Port from your connection string (use a number here)
//   waitForConnections: true,
//   connectionLimit: 10,
//   queueLimit: 0
// });

// // Test connection to the database
// pool.getConnection((err, connection) => {
//   if (err) {
//     console.error('❌ MySQL connection failed:', err.message);
//   } else {
//     console.log('✅ MySQL connected successfully!');
//     connection.release(); // Release the connection back to the pool
//   }
// });

// // Use promise API for working with queries
// const db = pool.promise();

// // Export the pool for use elsewhere
// export default db;




//  live db
import mysql from 'mysql2';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Create a MySQL connection pool
const pool = mysql.createPool({
  host: "turntable.proxy.rlwy.net",          // ✅ same as in CLI
  user: "root",                               // ✅ same as in CLI
  password: "DDgbsFmfBnTxkujTeOpqDDixBLceSRiY", // ✅ password from CLI
  database: "railway",                        // ✅ database name from CLI
  port: 18439,                                // ✅ port from CLI
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Test connection to the database
pool.getConnection((err, connection) => {
  if (err) {
    console.error('❌ MySQL connection failed:', err.message);
  } else {
    console.log('✅ Local MySQL connected successfully!');
    connection.release(); // Release the connection back to the pool
  }
});

// Use promise API for working with queries
const db = pool.promise();

// Export the pool for use elsewhere
export default db;




 
