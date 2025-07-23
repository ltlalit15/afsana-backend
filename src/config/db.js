
import mysql from 'mysql2';
import dotenv from 'dotenv';

dotenv.config();

const pool = mysql.createPool({
  host: "mainline.proxy.rlwy.net",              // ✅ Host from CLI
  user: "root",                                  // ✅ Username
  password: "SfLMnUpFplpRsaldlWJvpAxQAHlugpxa",  // ✅ Password from CLI
  database: "railway",                           // ✅ Database name
  port: 22094,                                   // ✅ Port from CLI
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

pool.getConnection((err, connection) => {
  if (err) {
    console.error('❌ MySQL connection failed:', err.message);
  } else {
    console.log('✅ MySQL connected successfully!');
    connection.release(); 
  }
});

const db = pool.promise();

export default db;


// import mysql from 'mysql2';
// import dotenv from 'dotenv';

// // Load environment variables
// dotenv.config();

// // Create a MySQL connection pool
// const pool = mysql.createPool({
//   host: "localhost",                // ✅ Updated Host
//   user: "root",                                  // ✅ Username
//   password: "",  // ✅ Updated Password
//   database: "finaltestiingafsana",                           // ✅ DB Name
//   port: 3306,                                   // ✅ Updated Port
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








 







 
  
