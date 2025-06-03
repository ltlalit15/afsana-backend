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


// live 

// import mysql from 'mysql2';
// import dotenv from 'dotenv';
// dotenv.config();

// const pool = mysql.createPool({
//   host:"localhost",
//   user: "root",
//   password: "",
//   database:"afsana_project",
//   port:3306,
//   waitForConnections: true,
//   connectionLimit: 10,
//   queueLimit: 0
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



// live database

import mysql from 'mysql2';
import dotenv from 'dotenv';
dotenv.config();

const pool = mysql.createPool({
  host:process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database:process.env.DB_NAME,
  port:process.env.DB_PORT,
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
// Use .promise() here
const db = pool.promise();


export default db;