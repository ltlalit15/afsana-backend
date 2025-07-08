import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import db from '../config/db.js';
import dotenv from 'dotenv';
import { getCounselorById } from '../models/counselor.model.js';
import { universityNameById } from '../models/universities.model.js';
dotenv.config();
import nodemailer from "nodemailer";

import admin from '../config/firebase.js';




export const register = async (req, res) => {
  const { email, password, full_name, role } = req.body;

  if (!email || !password || !full_name || !role) {
    return res.status(400).json({ message: 'All fields are required' });
  }
  try {
    // Check if user already exists
    const [existing] = await db.query('SELECT id FROM users WHERE email = ?', [email]);
    if (existing.length > 0) {
      return res.status(409).json({ message: 'User already exists' });
    }

    const hashed = await bcrypt.hash(password, 10);

    const userdata = await db.query(
      'INSERT INTO users (email, password, full_name, role) VALUES (?, ?, ?, ?)',
      [email, hashed, full_name, role]
    );
    console.log("userdata : ", userdata);
    const userId = userdata[0].insertId;
    await db.query(
      'INSERT INTO students (user_id) VALUES (?)',
      [userId]
    );
    res.status(201).json({ message: 'User registered successfully' });
  } catch (err) {
    console.error('Registration error:', err);
    res.status(500).json({ message: 'Internal server error', err, errmsg: err.message });
  }
};

export const login = async (req, res) => {
  const { email, password } = req.body;
  console.log(req.body);


  if (!email || !password) {
    return res.status(400).json({ message: 'Email and password are required' });
  }

  try {
    const [results] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    console.log("match password : ", results);
    if (results.length === 0) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    const user = results[0];
    const match = await bcrypt.compare(password, user.password);
    const token = jwt.sign({ id: user.id, role: user.role }, "dfsdfdsfdsg34345464543sdffdg#%$", { expiresIn: '12h' });


    if (!match) {
      return res.status(401).json({ message: 'password credentials not match!' });
    }

    let permission = [];
    if (user.role === 'student' || user.role === 'counselor') {
      const [rows] = await db.query('SELECT * FROM permissions WHERE role_name = ?', [user.role]);
      permission = rows;
    }
    let maindetails = [];
    if (user.role == 'student') {
      const [details] = await db.query('SELECT * FROM students WHERE id = ?', [user.student_id]);
      maindetails = details;

      return res.json({
        token,
        user: {
          // phone : maindetails[0].phone,
          id: user.id,
          email: user.email,
          full_name: user.full_name,
          role: user.role,
          student_id: user.student_id,
          // father_name : maindetails[0].father_name,
          // admission_no : maindetails[0].admission_no, 
          // id_no : maindetails[0].id_no,
          // phone : maindetails[0].mobile_number,
          // university_id : maindetails[0].university_id,
          // date_of_birth : maindetails[0].date_of_birth,
          // gender : maindetails[0].gender,
          // category : maindetails[0].category,
          // address : maindetails[0].address,
          // photo : maindetails[0].photo ? `${req.protocol}://${req.get('host')}${maindetails[0].photo}` : null,
          // documents : maindetails[0].documents,
          // created_at : maindetails[0].created_at
        },
        permissions: permission
      });

    }
    if (user.role == 'counselor') {
      const [details] = await db.query('SELECT * FROM counselors WHERE id = ?', [user.counselor_id]);
      maindetails = details;
      console.log("maindetails[0]?.university_id : ", maindetails[0]?.university_id);
      const data = await universityNameById(maindetails[0]?.university_id);
      console.log("data : ", data);
      return res.json({
        token,
        user: {
          phone: maindetails[0].phone,
          status: maindetails[0].status,
          university_name: data[0].name,
          id: user.id,
          email: user.email,
          full_name: user.full_name,
          role: user.role,
          counselor_id: user.counselor_id,
        },
        permissions: permission
      });
    }
    res.json({
      token,
      user: {
        id: user.id,
        email: user.email,
        full_name: user.full_name,
        role: user.role,
        address: user.address,
        phone: user.phone
      },
      permissions: permission
    });
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).json({ message: 'Internal server error', err, errmsg: err.message });
  }
};


export const checkPermission = (permissionName, action) => {
  return async (req, res, next) => {
    try {
      const userId = req.user.id; // Make sure req.user is set from JWT

      // Validate input
      if (!permissionName || !action) {
        return res.status(400).json({ message: "Permission check configuration error" });
      }

      // Fetch permissions for the user
      const [permissions] = await db.query(`
        SELECT p.* FROM user_permissions up
        JOIN permission p ON p.permission_name = up.permission_name
        WHERE up.user_id = ?
      `, [userId]);

      // Check if required permission exists and action (view/add/edit/delete) is allowed
      const hasPermission = permissions.some(p => 
        p.permission_name === permissionName && p[`${action}_permission`] === 1
      );

      if (!hasPermission) {
        return res.status(403).json({ message: "Access Denied: No Permission" });
      }

      // Permission granted
      next();

    } catch (error) {
      console.error("Permission check failed:", error);
      return res.status(500).json({ message: "Internal Server Error" });
    }
  };
};


export const getuserById = async (req, res) => {
  const { id } = req.params;
  console.log("id : ", id);

  try {
    const [results] = await db.query('SELECT * FROM users WHERE id = ?', [id]);

    if (results.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    const user = results[0];

    if (user.role === 'student') {
      const [studentDetails] = await db.query('SELECT * FROM students WHERE id = ?', [user.student_id]);

      if (studentDetails.length === 0) {
        return res.status(404).json({ message: 'Student not found' });
      }
      const student = studentDetails[0];
      return res.json({
        user: {
          id: user.id,
          email: user.email,
          full_name: user.full_name,
          role: user.role,
          student_id: user.student_id,
          father_name: student.father_name,
          admission_no: student.admission_no,
          id_no: student.id_no,
          phone: student.mobile_number,
          university_id: student.university_id,
          date_of_birth: student.date_of_birth,
          gender: student.gender,
          category: student.category,
          address: student.address,
          photo: student.photo ? `${req.protocol}://${req.get('host')}${student.photo}` : null,
          documents: student.documents,
          created_at: student.created_at
        }
      });
    }

    if (user.role === 'counselor') {
      const [counselorDetails] = await db.query('SELECT * FROM counselors WHERE id = ?', [user.counselor_id]);

      if (counselorDetails.length === 0) {
        return res.status(404).json({ message: 'Counselor not found' });
      }

      const counselor = counselorDetails[0];

      let universityName = null;
      if (counselor.university_id) {
        try {
          const universityData = await universityNameById(counselor.university_id);
          universityName = universityData.length ? universityData[0].name : null;
        } catch (err) {
          console.error('Error fetching university name:', err);
        }
      }

      return res.json({
        user: {
          id: user.id,
          email: user.email,
          full_name: user.full_name,
          role: user.role,
          counselor_id: user.counselor_id,
          phone: counselor.phone,
          status: counselor.status,
          university_name: universityName
        }
      });
    }

    // General User (e.g., Admin)
    return res.json({
      user: {
        id: user.id,
        email: user.email,
        full_name: user.full_name,
        role: user.role,
        address: user.address,
        phone: user.phone
      }
    });

  } catch (err) {
    console.error('Error in getuserById:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
};




// export const createStudent = async (req, res) => {
//   console.log("req.body:", req.body);
//   console.log("req.files:", req.files);
//   try {
//     const {
//       father_name,
//       admission_no,
//       id_no,
//       mobile_number,
//       university_id,
//       date_of_birth,
//       gender,
//       category,
//       address,
//       full_name,
//       password,
//       email
//     } = req.body;
//     // ✅ Check for required fields
//     if (!full_name || !email || !password) {
//       return res.status(400).json({ message: 'full_name, email, and password are required' });
//     }
//     const role = 'student';
//     // ✅ Handle optional file uploads
//     const photo = req.files?.photo?.[0]
//       ? `/uploads/${req.files.photo[0].filename}`
//       : '';
//     const documents = req.files?.documents?.[0]
//       ? `/uploads/${req.files.documents[0].filename}`
//       : '';
//     // ✅ Email uniqueness check
//     const [existing] = await db.query('SELECT id FROM users WHERE email = ?', [email]);
//     if (existing.length > 0) {
//       return res.status(409).json({ message: 'User already exists' });
//     }
//     // ✅ Password hashing
//     const hashed = await bcrypt.hash(password, 10);
//     // ✅ Handle optional fields with null values for optional fields
//     const parsedUniversityId =
//       university_id && !isNaN(university_id) ? Number(university_id) : null;
//     // ✅ Insert into users table first (since user_id is created there)
//     const [userResult] = await db.query(
//       'INSERT INTO users (email, password, full_name, user_id, role) VALUES (?, ?, ?, ?, ?)',
//       [email, hashed, full_name,0, role]
//     );
//     const userId = userResult.insertId;
//     // ✅ Insert into students table with the `user_id` created in the `users` table
//     const [studentResult] = await db.query(
//       `INSERT INTO students 
//         (user_id, father_name, admission_no, id_no, mobile_number, university_id, date_of_birth, gender, category, address, full_name, role, photo, documents) 
//         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
//       [
//         userId,
//         father_name || '',
//         admission_no || '',
//         id_no || '',
//         mobile_number || '',
//         parsedUniversityId,
//         date_of_birth || null,
//         gender || '',
//         category || '',
//         address || '',
//         full_name,
//         role,
//         photo,
//         documents
//       ]
//     );
//     const studentId = studentResult.insertId;
//     // ✅ After inserting the student, update `users` table with the `student_id`
//     await db.query('UPDATE users SET student_id = ? WHERE id = ?', [studentId, userId]);

//     res.status(201).json({ message: 'Student created successfully' });

//   } catch (error) {
//     console.error('Error creating student:', error);
//     res.status(500).json({ message: 'Internal server error', error });
//   }
// };




// export const signupWithGoogle = async (req, res) => {
//   const { email, googleSignIn } = req.body;
//   console.log(req.body);

//   try {
//     if (!email) {
//       return res.status(400).json({
//         status: "false",
//         message: "Email  are required",
//         data: []
//       });
//     }

//     // Step 1: Check if user already exists
//     const [existingUser] = await db.execute('SELECT * FROM users WHERE email = ?', [email]);

//     let user;

//     if (existingUser.length > 0) {
//       // ✅ User exists — login
//       user = existingUser[0];

//       // Optional: update googleSignIn flag if not already true
//       if (!user.googleSignIn && googleSignIn) {
//         await db.execute('UPDATE users SET googleSignIn = ? WHERE email = ?', [true, email]);
//         user.googleSignIn = true;
//       }

//     } else {
//       // ✅ User doesn't exist — create new user
//       const [insertResult] = await db.execute(
//         'INSERT INTO users (email, googleSignIn) VALUES (?, ?)',
//         [email, googleSignIn || true]
//       );

//       const userId = insertResult.insertId;

//       const [newUser] = await db.execute(
//         'SELECT id,  email, password, googleSignIn FROM users WHERE id = ?',
//         [userId]
//       );

//       user = newUser[0];
//     }

//     // Step 2: Generate JWT Token
//     const token = jwt.sign(
//       { id: user.id, email: user.email },
//       process.env.JWT_SECRET,
//       { expiresIn: '1h' }
//     );

//     // Step 3: Return success response
//     return res.status(200).json({
//       status: "true",
//       message: existingUser.length > 0
//         ? "Google login successful"
//         : "Google signup successful",
//       data: {
//         ...user,
//         token
//       }
//     });

//   } catch (error) {
//     console.error("Google Sign-Up Error:", error);
//     return res.status(500).json({
//       status: "false",
//       message: "Server error",
//       error: error.message
//     });
//   }
// };






const OTPStore = new Map(); // temporary (in-memory); use Redis or DB in production

export const sendOtpToEmail = async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ status: "false", message: "Email is required" });
  }

  try {
    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    OTPStore.set(email, otp); // store OTP temporarily

    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: process.env.MAIL_USER,
        pass: process.env.MAIL_PASS
      }
    });

    await transporter.sendMail({
      from: `"Your App" <${process.env.MAIL_USER}>`,
      to: email,
      subject: "Signup OTP Verification",
      html: `<h3>Your OTP is: <b>${otp}</b></h3><p>Valid for 10 minutes.</p>`
    });

    return res.status(200).json({ status: "true", message: "OTP sent to email" });

  } catch (error) {
    console.error("Send OTP Error:", error);
    return res.status(500).json({ status: "false", message: "Failed to send OTP", error: error.message });
  }
};

export const verifyOtp = async (req, res) => {
  const { email, otp } = req.body;

  if (!email || !otp) {
    return res.status(400).json({ status: "false", message: "Email and OTP required" });
  }

  const storedOtp = OTPStore.get(email);
  if (storedOtp === otp) {
    OTPStore.delete(email);
    return res.status(200).json({ status: "true", message: "OTP verified" });
  } else {
    return res.status(400).json({ status: "false", message: "Invalid or expired OTP" });
  }
};

export const signupWithGoogle = async (req, res) => {
  const { email, googleSignIn } = req.body;
  console.log(req.body);

  try {
    if (!email) {
      return res.status(400).json({
        status: "false",
        message: "Email is required",
        data: []
      });
    }

    const [existingUser] = await db.execute('SELECT * FROM users WHERE email = ?', [email]);

    let user;

    if (existingUser.length > 0) {
      user = existingUser[0];
      if (!user.googleSignIn && googleSignIn) {
        await db.execute('UPDATE users SET googleSignIn = ? WHERE email = ?', [true, email]);
        user.googleSignIn = true;
      }
    } else {
      const [insertResult] = await db.execute(
        'INSERT INTO users (email, googleSignIn) VALUES (?, ?)',
        [email, googleSignIn || true]
      );

      const userId = insertResult.insertId;

      const [newUser] = await db.execute(
        'SELECT id, email, password, googleSignIn FROM users WHERE id = ?',
        [userId]
      );

      user = newUser[0];
    }

    const token = jwt.sign(
      { id: user.id, email: user.email },
      "dfsdfdsfdsg34345464543sdffdg#%$",
      { expiresIn: '1h' }
    );

    return res.status(200).json({
      status: "true",
      message: existingUser.length > 0
        ? "Google login successful"
        : "Google signup successful",
      data: {
        ...user,
        token
      }
    });

  } catch (error) {
    console.error("Google Sign-Up Error:", error);
    return res.status(500).json({
      status: "false",
      message: "Server error",
      error: error.message
    });
  }
};







export const createStudentWithGoogle = async (req, res) => {
  try {
    const { token } = req.body;

    if (!token) {
      return res.status(400).json({ message: "Google token is required" });
    }

    // 🔍 Step 1: Verify Google token
    const decodedToken = await admin.auth().verifyIdToken(token);
    const googleUser = await admin.auth().getUser(decodedToken.uid);
    const email = googleUser.email;
    const full_name = googleUser.displayName || "";
    const role = "student";

    // 🔍 Step 2: Check if user already exists
    const [existing] = await db.query("SELECT * FROM users WHERE email = ?", [email]);

    if (existing.length > 0) {
      const token = jwt.sign(
        { id: existing[0].id, email: existing[0].email, role: existing[0].role },
        process.env.JWT_SECRET,
        { expiresIn: "7d" }
      );

      return res.status(200).json({
        message: "User already registered. Please log in.",
        user: existing[0],
        token,
        status: "existing",
      });
    }

    // 🧩 Step 3: Insert into users table
    const [userResult] = await db.query(
      "INSERT INTO users (email, full_name, role, user_id) VALUES (?, ?, ?, ?)",
      [email, full_name, role, 0]
    );
    const userId = userResult.insertId;

    // 🧩 Step 4: Insert into students table
    const [studentResult] = await db.query(
      `INSERT INTO students 
        (user_id, full_name, role) 
        VALUES (?, ?, ?)`,
      [userId, full_name, role]
    );
    const studentId = studentResult.insertId;

    // 🧩 Step 5: Update users table with student_id
    await db.query("UPDATE users SET student_id = ? WHERE id = ?", [studentId, userId]);

    // 🧩 Step 6: Generate JWT
    const jwtToken = jwt.sign(
      { id: userId, email, role },
      export const signupWithGoogle = async (req, res) => {
  const { email, googleSignIn } = req.body;
  console.log(req.body);

  try {
    if (!email) {
      return res.status(400).json({
        status: "false",
        message: "Email is required",
        data: []
      });
    }

    const [existingUser] = await db.execute('SELECT * FROM users WHERE email = ?', [email]);

    let user;

    if (existingUser.length > 0) {
      user = existingUser[0];
      if (!user.googleSignIn && googleSignIn) {
        await db.execute('UPDATE users SET googleSignIn = ? WHERE email = ?', [true, email]);
        user.googleSignIn = true;
      }
    } else {
      const [insertResult] = await db.execute(
        'INSERT INTO users (email, googleSignIn) VALUES (?, ?)',
        [email, googleSignIn || true]
      );

      const userId = insertResult.insertId;

      const [newUser] = await db.execute(
        'SELECT id, email, password, googleSignIn FROM users WHERE id = ?',
        [userId]
      );

      user = newUser[0];
    }

    const token = jwt.sign(
      { id: user.id, email: user.email },
      "dfsdfdsfdsg34345464543sdffdg#%$",
      { expiresIn: '1h' }
    );

    return res.status(200).json({
      status: "true",
      message: existingUser.length > 0
        ? "Google login successful"
        : "Google signup successful",
      data: {
        ...user,
        token
      }
    });

  } catch (error) {
    console.error("Google Sign-Up Error:", error);
    return res.status(500).json({
      status: "false",
      message: "Server error",
      error: error.message
    });
  }
};
,
      { expiresIn: "7d" }
    );

    // ✅ Done


res.status(201).json({
  message: "Student registered via Google Sign-In",
  user: {
    id: userId,
    student_id: studentId, // 👈 Add this line
    email,
    full_name,
    role
  },
  token: jwtToken,
  status: "registered",
});



  } catch (error) {
    console.error("Google Sign-Up Error:", error);
    res.status(500).json({ message: "Internal server error", error: error.message });
  }
};





export const StudentAssignToCounselor = async (req, res) => {
  try {
    const { student_id, counselor_id, follow_up, notes } = req.body;

    // Validate required field
    if (!student_id) {
      return res.status(400).json({ message: "'student_id' is required" });
    }

    // Build dynamic update parts
    const updates = [];
    const values = [];

    if (counselor_id !== undefined) {
      updates.push("counselor_id = ?");
      values.push(counselor_id);
    }

    if (follow_up !== undefined) {
      updates.push("follow_up = ?");
      values.push(follow_up);
    }

    if (notes !== undefined) {
      updates.push("notes = ?");
      values.push(notes);
    }

    if (updates.length === 0) {
      return res.status(400).json({ message: "No fields provided to update" });
    }

    // Always update updated_at
    updates.push("updated_at = NOW()");

    // Final SQL query
    const sql = `UPDATE students SET ${updates.join(", ")} WHERE id = ?`;
    values.push(student_id);

    // Execute update
    const [result] = await db.query(sql, values);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Student ID not found" });
    }

    // Optionally return updated data
    const [updatedStudent] = await db.query("SELECT * FROM students WHERE id = ?", [student_id]);

    res.status(200).json({
      message: "Student updated successfully",
      data: updatedStudent[0],
    });

  } catch (error) {
    console.error("Error updating student:", error);
    res.status(500).json({
      message: "Update failed",
      error: error.message,
    });
  }
};


export const getStudentsByCounselorId = async (req, res) => {
  const { counselorId } = req.params;

  try {
    const [students] = await db.query(
      `SELECT
        s.*,
        u.email,
        u.full_name AS user_full_name,
        u.role AS user_role,
        uni.name AS university_name
      FROM students s
      JOIN users u ON s.id = u.student_id
      LEFT JOIN universities uni ON s.university_id = uni.id
      WHERE s.counselor_id = ?`,
      [counselorId]
    );

    res.status(200).json(students);
  } catch (error) {
    console.error("Error fetching students by counselor ID:", error);
    res.status(500).json({ message: "Internal server error", error });
  }
};







export const getAllStudents = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT
        s.*,
        u.email,
        u.full_name,
        u.role,
        uni.name AS university_name
      FROM students s
      JOIN users u
        ON s.id = u.student_id
      LEFT JOIN universities uni
        ON s.university_id = uni.id
    `);
    const parsedRows = rows.map(row => ({
      ...row,
      photo: row.photo
        ? `${req.protocol}://${req.get("host")}${row.photo}`
        : null,
      documents: row.documents
        ? `${req.protocol}://${req.get("host")}${row.documents}`
        : null,
    }));
    res.status(200).json(parsedRows);
  } catch (error) {
    console.error('Error fetching students:', error);
    res.status(500).json({ message: 'Internal server error', error });
  }
};



export const getStudentById = async (req, res) => {
  const { id } = req.params;

  try {
    const [student] = await db.query(`
        SELECT 
          s.*, 
          u.email, u.full_name, u.role 
        FROM students s 
        JOIN users u ON s.id = u.student_id
        WHERE s.id = ?
      `, [id]);

    if (student.length === 0) {
      return res.status(404).json({ message: 'Student not found' });
    }

    const parsedRows = student.map((row) => ({
      ...row,
      photo: row.photo ? `${req.protocol}://${req.get("host")}${row.photo}` : null,
      documents: row.documents ? `${req.protocol}://${req.get("host")}${row.documents}` : null,
    }));

    res.status(200).json(parsedRows[0]);
  } catch (error) {
    console.error('Error fetching student:', error);
    res.status(500).json({ message: 'Internal server error', error });
  }
};

export const updateUser = async (req, res) => {
  const { id } = req.params;
  console.log("req.body : ", req.body);
  console.log("req.files : ", req.files);

  const {
    user_id,
    father_name,
    admission_no,
    id_no,
    university_id,
    date_of_birth,
    gender,
    category,
    address,
    full_name,
    phone,
    status,
    email
  } = req.body;

  const photo = req.files?.photo?.[0] ? `/uploads/${req.files.photo[0].filename}` : null;
  const documents = req.files?.documents?.[0] ? `/uploads/${req.files.documents[0].filename}` : null;
 
  try {
    const [data ] = await db.query('SELECT * FROM users WHERE id = ?', [id]);
    if (data.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    const { student_id, counselor_id, role } = data[0];
    let updateUserQuery;
    let updateUserParams;
    if (role === 'admin') {
      updateUserQuery = `UPDATE users SET email = COALESCE(?, email), full_name = COALESCE(?, full_name), address = COALESCE(?, address), phone = COALESCE(?, phone) WHERE id = ?`;
      updateUserParams = [email, full_name, address, phone, id];
    } else {
      updateUserQuery = `UPDATE users SET email = COALESCE(?, email), full_name = COALESCE(?, full_name) WHERE id = ?`;
      updateUserParams = [email, full_name, id];
    }


    if (student_id) {
      const [studentResult] = await db.query(
        `UPDATE students SET 
          admission_no = COALESCE(?, admission_no),
          user_id = COALESCE(?, user_id),
          father_name = COALESCE(?, father_name),
          id_no = COALESCE(?, id_no),
          mobile_number = COALESCE(?, mobile_number),
          university_id = COALESCE(?, university_id),
          date_of_birth = COALESCE(?, date_of_birth),
          gender = COALESCE(?, gender),
          category = COALESCE(?, category),
          address = COALESCE(?, address),
          photo = COALESCE(?, photo),
          documents = COALESCE(?, documents)
        WHERE id = ?`,
        [
          admission_no,
          user_id,
          father_name,
          id_no,
          phone,
          university_id,
          date_of_birth,
          gender,
          category,
          address,
          photo,
          documents,
          student_id
        ]
      );

      if (studentResult.affectedRows === 0) {
        return res.status(404).json({ message: 'Student not found' });
      }
    }

    if (counselor_id) {
      const [counselorResult] = await db.query(
        `UPDATE counselors SET 
          user_id = COALESCE(?, user_id),
          phone = COALESCE(?, phone),
          university_id = COALESCE(?, university_id),
          status = COALESCE(?, status)
        WHERE id = ?`,
        [user_id, phone, university_id, status, counselor_id]
      );

      if (counselorResult.affectedRows === 0) {
        return res.status(404).json({ message: 'Counselor not found' });
      }
    }

    await db.query(updateUserQuery, updateUserParams);

    res.status(200).json({ message: 'User information updated successfully.' });
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(500).json({ message: 'Internal server error', error });
  }
};

export const deleteStudent = async (req, res) => {
  const { id } = req.params;

  try {
    // Check associated user
    const [user] = await db.query('SELECT id FROM users WHERE student_id = ?', [id]);
    if (!user.length) {
      return res.status(404).json({ message: 'Associated user not found' });
    }
    const user_id = user[0].id;

    // Delete related data
    await db.query('DELETE FROM messages WHERE sender_id = ? OR receiver_id = ?', [user_id, user_id]);
    const [studentResult] = await db.query('DELETE FROM students WHERE id = ?', [id]);

    if (studentResult.affectedRows === 0) {
      return res.status(404).json({ message: 'Student not found' });
    }

    await db.query('DELETE FROM users WHERE id = ?', [user_id]);
    await db.query('DELETE FROM tasks WHERE student_id = ?', [id]);

    res.status(200).json({ message: 'Student and related data deleted successfully' });

  } catch (error) {
    console.error('Error deleting student:', error);
    res.status(500).json({ message: 'Internal server error', error });
  }
};

export const changeNewPassword = async (req, res) => {
  const { id } = req.params; // Get from token
  const { password, newPassword } = req.body;

  if (!password || !newPassword) {
    return res.status(400).json({ message: 'Both old and new passwords are required' });
  }
  try {
    const [user] = await db.query('SELECT * FROM users WHERE id = ?', [id]);

    if (user.length === 0 || !(await bcrypt.compare(password, user[0].password))) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }
    const hashed = await bcrypt.hash(newPassword, 10);
    await db.query('UPDATE users SET password = ? WHERE id = ?', [hashed, id]);
    res.status(200).json({ message: 'Password changed successfully' });
  } catch (error) {
    console.error('Error changing password:', error);
    res.status(500).json({ message: 'Internal server error', error });
  }
};

export const getAllByRoles = async (req, res) => {
  const { role } = req.params;
  try {
    let query;
    let params;
    switch (role) {
      case 'admin':
        query = 'SELECT full_name, role, address, phone FROM users WHERE role = ?';
        params = [role];
        break;
      case 'counselor':
        query = 'SELECT full_name, role, counselor_id , id FROM users WHERE role = ?';
        params = [role];
        break;
      case 'student':
        query = 'SELECT full_name, role, student_id, id FROM users WHERE role = ?';
        params = [role];
        break;
      default:
        return res.status(400).json({ message: 'Invalid role' });
    }
    const [users] = await db.query(query, params);
    res.status(200).json(users);
  } catch (error) {
    console.error('Error fetching users by role:', error);
    res.status(500).json({ message: 'Internal server error', error });
  }
}




