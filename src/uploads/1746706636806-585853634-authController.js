import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { createUser, findUserByEmail, updateUser } from "../Models/userModel.js";
import { sendVerificationEmail, sendTwoStepVerificationEmail } from "../Utils/emailService.js";
import { generateOTP } from "../Utils/otpService.js";

const accessTokenOption = {
  httpOnly: true,
  secure: true,
  sameSite: "Strict",
  maxAge: 60 * 60 * 1000,
}

const refreshTokenOption = {
  httpOnly: true,
  secure: true,
  sameSite: "Strict",
  maxAge: 7 * 24 * 60 * 60 * 1000,
}
const genarateAccessToken = async (user) =>{
    const token = jwt.sign({id: user.id, email: user.email, role: user.role}, process.env.JWT_SECRET, {expiresIn: '1h'})
    return token;
}

const genarateRefreshToken = async (user) =>{
  const token = jwt.sign({id: user.id}, process.env.JWT_REFRESH_SECRET, {expiresIn : '7d'})
  await updateUser(user.id, {refresh_token : token});
  return token ;
}

export const register = async (req, res) => {
  try {
    const { name, email, password } = req.body;
    
    if (!name || !email || !password) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    const existingUser = await findUserByEmail(email);
    if (existingUser) {
      return res.status(409).json({ message: 'User already exists' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await createUser({ name, email, password: hashedPassword });

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1d' });

    await sendVerificationEmail(email, token);

    return res.status(201).json({ message: 'User registered. Check email for verification.' });
  } catch (error) {
    console.error('Error registering user:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
};

export const googlelogin = async (req,res) =>{
  try {
    const user = req.user;
    if (!user) {
      return res.status(400).json({ message: "User not found in request" });
    }
     const accessToken = await genarateAccessToken(user);
     const refreshToken = await genarateRefreshToken(user);
     const redirectPath = user.role === "admin" ? "/admin/dashboard" : "/user/dashboard";
     res
     .cookie("accessToken",accessToken, accessTokenOption)
     .cookie("refreshToken",refreshToken,refreshTokenOption)
     .redirect(redirectPath);

  } catch (error) {
    console.log(`something want worng in google with login : ${error}`);
    return res.status(500).json({ message: 'Internal server error' });
  }
}


// export const login = async (req, res) => {
//   try {
//     const { email, password } = req.body;

//     if (!email || !password) {
//       return res.status(400).json({ message: 'All fields are required' });
//     }
//     const user = await findUserByEmail(email);
//     if (!user) {
//       return res.status(404).json({ message: 'User not found' });
//     }

 
//     const isMatch = await bcrypt.compare(password, user.password);
//     if (!isMatch) {
//       return res.status(401).json({ message: 'Invalid credentials' });
//     }


//     const otp = generateOtp();
//     await updateUser(user.id, { twoFactorCode: otp, twoFactorCodeExpiry: Date.now() + 5 * 60 * 1000 }); // 5 minutes expiry

//     console.log(`OTP for ${email}: ${otp}`); 

//     await sendEmail(email, 'Your OTP Code', `Your OTP is: ${otp}`);

//     res.status(200).json({ message: 'OTP sent to email' });
//   } catch (error) {
//     console.error('Login Error:', error);
//     res.status(500).json({ message: 'Internal server error' });
//   }
// };

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    const user = await findUserByEmail(email);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    const otp = generateOTP();
    await updateUser(user.id, { twoFactorCode: otp, twoFactorCodeExpiry: Date.now() + 5 * 60 * 1000 });

    await sendTwoStepVerificationEmail(email, otp);

    return res.status(200).json({ message: 'OTP sent to email' });
  } catch (error) {
    console.error('Login error:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
};

export const verifyEmail = async (req, res) => {
  const { token } = req.query;
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    await updateUser(decoded.id, { isVerified: true });
    res.json({ message: "Email verified" });
  } catch (err) {
    res.status(400).json({ message: "Invalid token" });
  }
};


  export const verifyOTP = async (req, res) => {
    try {
      const { email, otp } = req.body;
      const user = await findUserByEmail(email);
  
      if (!user || user.twoFactorCode !== otp || Date.now() > user.twoFactorCodeExpiry) {
        return res.status(400).json({ message: 'Invalid or expired OTP' });
      }
  
      await updateUser(user.id, { twoFactorCode: null, twoFactorCodeExpiry: null });
  
      const token = jwt.sign({ id: user.id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '1d' });
  
      res.cookie('token', token, { httpOnly: true }).json({ message: '2FA successful', token });
    } catch (error) {
      console.error('Error verifying OTP:', error);
      return res.status(500).json({ message: 'Internal server error' });
    }
  };
  
