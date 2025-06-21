import mysql from 'mysql2';
import dotenv from 'dotenv';
// Load environment variables
dotenv.config();
// Create a MySQL connection pool
const pool = mysql.createPool({
  host: "localhost",      // Host from your connection string
  user: "root",                       // User from your connection string
  password: "",  // Password from your connection string
  database: "afsanacrm",                // Database name from your connection string
  port: 3306,                        // Port from your connection string (use a number here)
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


// live db

// import mysql from 'mysql2';
// import dotenv from 'dotenv';

// // Load environment variables
// dotenv.config();

// // Create a MySQL connection pool
// const pool = mysql.createPool({
//   host: "ballast.proxy.rlwy.net",      // Host from your connection string
//   user: "root",                       // User from your connection string
//   password: "EXoOaiRxZJeDNexzzwUDrndcVXXbZUxS",  // Password from your connection string
//   database: "railway",                // Database name from your connection string
//   port: 36624,                        // Port from your connection string (use a number here)
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





 
