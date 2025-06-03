-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2025 at 09:56 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `afsana_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `admission_decisions`
--

CREATE TABLE `admission_decisions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `university_id` int(10) NOT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `decision_date` date NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admission_decisions`
--

INSERT INTO `admission_decisions` (`id`, `user_id`, `student_id`, `university_id`, `status`, `decision_date`, `created_at`) VALUES
(1, 1, 14, 12, 'accepted', '2025-05-22', '2025-05-05 19:04:59'),
(2, 1, 12, 11, 'accepted', '2025-05-30', '2025-05-05 19:10:26'),
(3, 1, 19, 11, 'accepted', '2025-05-21', '2025-05-06 12:06:47');

-- --------------------------------------------------------

--
-- Table structure for table `counselors`
--

CREATE TABLE `counselors` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `university_id` int(10) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `counselors`
--

INSERT INTO `counselors` (`id`, `user_id`, `phone`, `university_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '+1234567890', 12, 'active', '2025-05-05 18:45:31', '2025-05-06 12:03:33'),
(2, 1, '+1234567890', 12, 'active', '2025-05-05 19:09:11', '2025-05-05 19:36:24'),
(3, 555, '776767677', 11, 'active', '2025-05-05 19:24:57', '2025-05-05 19:36:32'),
(7, 1, '123456', 11, 'active', '2025-05-06 11:32:56', '2025-05-06 11:32:56'),
(8, 4555, '07302161400', 12, 'active', '2025-05-06 11:45:19', '2025-05-06 11:45:19'),
(9, 1, '07302161400', 11, 'inactive', '2025-05-06 11:49:32', '2025-05-06 11:49:32'),
(10, 1, '07302161400', 11, 'inactive', '2025-05-06 11:57:20', '2025-05-06 11:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `follow_ups`
--

CREATE TABLE `follow_ups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `follow_up_date` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `urgency_level` varchar(255) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `follow_ups`
--

INSERT INTO `follow_ups` (`id`, `name`, `title`, `follow_up_date`, `status`, `urgency_level`, `department`, `created_at`, `user_id`) VALUES
(2, 'Afsana Begum', 'Schedule Intro Call', '2025-05-02', 'New', 'WhatsApp', 'Admissions', '2025-05-02 12:31:49', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `inquiry_type` varchar(100) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `branch` varchar(100) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `course_name` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `date_of_inquiry` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `present_address` text DEFAULT NULL,
  `education_background` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`education_background`)),
  `english_proficiency` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`english_proficiency`)),
  `company_name` varchar(255) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `job_duration` varchar(50) DEFAULT NULL,
  `preferred_countries` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`preferred_countries`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`id`, `user_id`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `city`, `date_of_inquiry`, `address`, `present_address`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `created_at`, `updated_at`) VALUES
(8, 1, 'workVisa', 'Website', 'dhaka', 'ankit', '07302161400', 'ankit@gmail.com', 'Maths', 'India', 'indore', '2025-05-29', 'Indore', 'Gopal gram', '[\"SSC\",\"HSC\"]', '[\"Writing\",\"Reading\"]', 'kiaan', 'sdsd', 'sdsdsd', '[\"Germany\",\"Canada\"]', '2025-05-02 13:27:07', '2025-05-02 13:27:07'),
(9, 1, 'touristVisa', 'Facebook', 'sylhet', 'krishna', '07302161400', 'kiaan@gmail.com', 'Maths', 'India', 'indore', '2025-05-26', 'Indore', 'Gopal gram', '[\"SSC\",\"HSC\"]', '[\"Reading\",\"Writing\"]', 'kiaan', 'sdsd', 'sdsdsd', '[\"Germany\",\"Canada\"]', '2025-05-05 07:55:56', '2025-05-05 07:55:56'),
(10, 1, 'touristVisa', 'Facebook', 'sylhet', 'krishna', '07302161400', 'kiaan@gmail.com', 'Maths', 'India', 'indore', '2025-05-26', 'Indore', 'Gopal gram', '[\"SSC\",\"HSC\"]', '[\"Reading\",\"Writing\"]', 'kiaan', 'sdsd', 'sdsdsd', '[\"Germany\",\"Canada\"]', '2025-05-05 07:56:29', '2025-05-05 07:56:29');

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `counselor` int(100) DEFAULT NULL,
  `follow_up_date` date DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `preferred_countries` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `name`, `email`, `phone`, `counselor`, `follow_up_date`, `source`, `status`, `preferred_countries`, `notes`, `user_id`, `created_at`, `updated_at`) VALUES
(3, 'John Smith', 'john.smith@example.com', '+1 234 567 8900', 0, '2024-02-28', 'Website', 'In Progress', 'USA, Canada', 'Interested in premium package', 0, '2025-05-02 13:53:29', '2025-05-02 13:53:29'),
(4, 'John Smith', 'john.smith@example.com', '+1 234 567 8900', 0, '2024-02-28', 'Website', 'In Progress', 'USA, Canada', 'Interested in premium package', 1, '2025-05-02 14:00:56', '2025-05-02 14:00:56'),
(5, 'John Smith1', 'john.smith@example.com', '+1 234 567 8900', 2, '2025-05-14', 'Website', 'In Progress', 'USA, Canada', 'Interested in premium package', 1, '2025-05-03 06:50:40', '2025-05-05 12:38:13'),
(7, 'krishna', 'kiaan@gmail.com', '07302161400', 2, '2025-05-29', 'Phone Call', 'Completed', 'India', 'ddfsdsdsdsds', 1, '2025-05-05 06:51:50', '2025-05-05 06:51:50');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `father_name` varchar(100) DEFAULT NULL,
  `admission_no` varchar(50) DEFAULT NULL,
  `id_no` varchar(50) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `university_id` int(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `category` varchar(250) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `photo` longtext DEFAULT NULL,
  `documents` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `father_name`, `admission_no`, `id_no`, `mobile_number`, `university_id`, `date_of_birth`, `gender`, `category`, `address`, `photo`, `documents`, `created_at`, `updated_at`) VALUES
(1, 1, 'Robert Doe', 'AD12345', 'ID987654', '1234567890', 12, '2000-08-15', 'Male', 'General', '123 Elm Street, Springfield', 'https://example.com/photo.jpg', 'https://example.com/documents.pdf', '2025-05-05 11:21:01', '2025-05-05 19:14:28'),
(3, 1, 'Robert Doe', 'AD1345', 'ID987654', '123467890', 12, '2000-08-15', 'Male', 'General', '123 Elm Street, Springfield', '', '', '2025-05-05 11:56:33', '2025-05-05 19:15:31'),
(13, 1, 'tony joy', 'AD1112345', 'ID987654', '1234567899', 0, '2000-08-15', 'Male', 'student', '123 Elm Street, Springfield', '/uploads/1746445132817-957018474-1745493083074-332042393 (2).jfif', '/uploads/1746445132819-583334267-afsana_project (1).sql', '2025-05-05 17:08:52', '2025-05-05 17:08:52'),
(14, 1, 'Rajendra', '232345', '121', '234632466', 12, '2007-02-06', 'Female', 'General', 'Indore', '/uploads/1746449073083-179013660-demoHealthCareSoftware.png', '/uploads/1746449073089-934723888-demoHealthCareSoftware.png', '2025-05-05 18:14:33', '2025-05-05 19:15:41'),
(15, 1, 'Bhai', 'sdyho22', '3552', '45346373', 0, '2025-05-06', 'Female', 'General', 't53y h bjh', '', '', '2025-05-05 18:53:06', '2025-05-05 18:53:42'),
(16, 1, 'Dada', '346457', '677', '7657', 0, '2025-05-01', 'Male', 'ST', 'uirik myik iimu ki ', '/uploads/1746451865569-788735657-demoHealthCareSoftware.png', '/uploads/1746451865591-173475626-demoHealthCareSoftware.png', '2025-05-05 19:01:05', '2025-05-05 19:01:05'),
(18, 1, 'tony joy', 'AD114412345', 'ID987654', '1234567899', 2, '2000-08-15', 'Male', 'student', '123 Elm Street, Springfield', '/uploads/1746452254453-165037244-1745493083074-332042393 (2).jfif', '/uploads/1746452254453-338595373-afsana_project (1).sql', '2025-05-05 19:07:34', '2025-05-05 19:07:34'),
(19, 1, 'Mr Saha 2', '678679', '970', '89789790', 11, '2025-05-02', 'Female', 'ST', 'jtukyuk', '', '', '2025-05-05 19:20:27', '2025-05-05 19:22:22');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `due_date` date NOT NULL,
  `counselor_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `priority` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `related_to` varchar(100) NOT NULL,
  `related_item` varchar(255) DEFAULT NULL,
  `assigned_to` varchar(100) NOT NULL,
  `assigned_date` date NOT NULL,
  `finishing_date` date NOT NULL,
  `attachment` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `user_id`, `due_date`, `counselor_id`, `student_id`, `description`, `priority`, `status`, `related_to`, `related_item`, `assigned_to`, `assigned_date`, `finishing_date`, `attachment`, `created_at`, `updated_at`) VALUES
(4, 'fn', 0, '2025-05-07', 2, 0, 'njkn', 'Low', 'Pending', 'Application', 'n ', 'nj', '2025-05-23', '2025-05-08', 'C:\\fakepath\\qr_banner (7).png', '2025-05-03 15:32:10', '2025-05-03 15:32:10'),
(5, 'fn', 0, '2025-05-08', 2, 0, 'njkn k,', 'Low', 'completed', 'Application', 'n m, ,', 'nj', '2025-05-22', '2025-05-15', 'C:\\fakepath\\qr_banner (8).png', '2025-05-03 15:58:22', '2025-05-03 15:58:22');

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo_url` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `programs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`programs`)),
  `highlights` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`highlights`)),
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`id`, `user_id`, `name`, `logo_url`, `location`, `programs`, `highlights`, `contact_phone`, `contact_email`, `created_at`, `updated_at`) VALUES
(11, 1, 'Sage', '', 'indore', '[\"fdfdf\"]', '[\"dfdfdf\"]', '07302161400', 'krishnarajputkiaan@gmail.com', '2025-05-05 16:23:48', '2025-05-05 16:23:48'),
(12, 1, 'Gyan Sagar ', '/uploads/1746442628489-144683235-smart-life-academy-logo.jpg', 'indore', '[\"fedfdfdf\"]', '[\"hfhfhfh\"]', '07302161400', 'krishnarajputkiaan@gmail.com', '2025-05-05 16:27:08', '2025-05-05 17:26:56');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `student_id` int(11) DEFAULT NULL,
  `counselor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`, `full_name`, `user_id`, `created_at`, `updated_at`, `student_id`, `counselor_id`) VALUES
(1, 'admin@example.com', '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'admin', 'Alice Admin', NULL, '2025-05-02 09:21:38', '2025-05-02 09:21:38', NULL, NULL),
(2, 'student@example.com', '$2b$10$rDDUtU.bb69iJqv2/2ECSeGLzDhs2zzjpwuqZdA5WDb07NokwzjCm', 'student', 'billy bucher', NULL, '2025-05-02 10:06:04', '2025-05-02 10:06:04', NULL, NULL),
(3, 'johndoe@example.com', '$2b$10$ldB4GfqaWHIsHsSkEZpaseQ0ZdUpOIPgDX4PRA6ynXk5SDQeHtZa.', 'student', 'John Doe', 1, '2025-05-03 10:52:35', '2025-05-03 10:52:35', NULL, NULL),
(4, 'johnoe@example.com', '$2b$10$PDJ7fQ2XzZoM38kuCCZpK.ph/kodyJr.UZPwih5PIrBohj0KBx2T2', 'student', 'John Doe', 1, '2025-05-05 05:41:39', '2025-05-05 05:41:39', NULL, NULL),
(5, 'johoe@example.com', '$2b$10$v8POiy9mTAqgA4R.UsPFCeR/cPd4ZGBmEYIDy.//OOMCA6ssHMhd.', 'student', 'John Doe', 1, '2025-05-05 05:50:01', '2025-05-05 05:50:01', NULL, NULL),
(6, 'jooe@example.com', '$2b$10$.TbVBoLhgOcNS/1lFgl0/.wBcZxdJJVgLJ4ZXYVg18yXG7he89k4m', 'student', 'John Doe', 1, '2025-05-05 05:51:01', '2025-05-05 05:51:01', NULL, NULL),
(14, 'rony@gmail.com', '$2b$10$tFhADy9tEs7TpVYklmp5kumO2DQ2Hv65ZrM8OWNpiqtfcVZpBbb/K', 'student', 'rony joy', 1, '2025-05-05 11:38:52', '2025-05-05 11:38:52', 13, NULL),
(15, 'ritika.sharma@example.com', '$2b$10$sr5xFwTs/tw6fT00GS3k.OQCtkJemFvtuo5hp4QClGNF9EWsrOZHy', 'counselor', 'Ritika Sharma', 101, '2025-05-05 12:31:14', '2025-05-05 12:31:14', NULL, 0),
(16, 'ritik.sharma@example.com', '$2b$10$mHS1C8UUGQpJeVHyO5Ixl.C7zmWi2ye..rUyoBVpqkxppA/DgNtxa', 'counselor', 'Ritika Sharma', 101, '2025-05-05 12:40:27', '2025-05-05 12:40:27', NULL, 0),
(17, 'aashi@xyz.com', '$2b$10$aOvK2iFlJOdkrrKae5kfNO3UdjgStY7GZOkASzMOfjr26r5HHl1XW', 'student', 'Aashi', 1, '2025-05-05 12:44:33', '2025-05-05 12:44:33', 14, NULL),
(18, 'john.doe@example.com', '$2b$10$uv/TyRx.CmHtwaIyqBCE7.n.YFmbcBpZXehFXqvpW.CJA5RTcfDEm', 'counselor', 'John Doe123', 1, '2025-05-05 13:15:31', '2025-05-06 06:33:33', NULL, 1),
(19, 'sam@xyz.com', '$2b$10$LGZDZGvlTMj5OtTNZiSsfuAuWtP811.AL4f0YGW1LEkV.y3ECd4yO', 'student', 'Sam', 1, '2025-05-05 13:23:06', '2025-05-05 13:23:06', 15, NULL),
(20, 'rohit@abc.com', '$2b$10$e76rY4tEDoK41DDv7tut/u2IIUCgBP2JmT5oXCGECI9vQMJtLwiSq', 'student', 'Rohit', 1, '2025-05-05 13:31:05', '2025-05-05 13:31:05', 16, NULL),
(21, 'rodfsdfny@gmail.com', '$2b$10$F284J3...oe83Bok6Rp41eu4te0apnFmBqLJFplJEmi39CMJ9nZd2', 'student', 'rony joy', 1, '2025-05-05 13:37:34', '2025-05-05 13:37:34', 18, NULL),
(22, 'john.dofde@example.com', '$2b$10$NBgj9OGbgZEJI3u8ZedQk.QW/abQ95J77F8Raauaq0217VclKsvTi', 'counselor', 'John Doe', 1, '2025-05-05 13:39:11', '2025-05-05 13:39:11', NULL, 2),
(23, 'radha@abc.com', '$2b$10$hMuNoTNW32fwnuG7UxxUAeI7lTHfKo4yZpZ4hZp0hc5lg2mamm8NO', 'student', 'Radha', 1, '2025-05-05 13:50:27', '2025-05-05 13:50:27', 19, NULL),
(24, 'counsolor@gmail.com', '$2b$10$AbHTGhrI13WUO7sdgZYM.e1rA5XdJM294oE9PVeVocnF8GsHWItIm', 'counselor', 'pagar', 555, '2025-05-05 13:54:57', '2025-05-05 13:54:57', NULL, 3),
(25, 'sohan@gmail.com', '$2b$10$mTeLlgcLzkNgjw2UqxkHyeQij4JiQJPUeaz6ZYHiwLFqDNgtmp6fi', 'counselor', 'sohan', 888, '2025-05-05 13:56:47', '2025-05-05 13:56:47', NULL, 4),
(26, 'ankit@gmail.com', '$2b$10$GpJuJPLgnU1nmTzLD2g5RedVcIj79MHvMUflmGtOYNu/gzPb/IPJm', 'counselor', 'ankit', 7788, '2025-05-05 14:08:32', '2025-05-05 14:08:32', NULL, 5),
(27, 'admin@gmai.com', '$2b$10$S9.t8G8mNvjFNPPXiJJsLusokXClG7vYQuXkesBpWbDeKCGdDPf0K', 'counselor', 'ggfd', 1, '2025-05-05 14:13:06', '2025-05-05 14:13:06', NULL, 6),
(28, 'rohan@gmail.com', '$2b$10$Ozm/VWBEN.Q1Fy.h4zptyOpkCMGWKZuA7d/6k105WISNOMWMRLtKW', 'counselor', 'rohan', 1, '2025-05-06 06:02:56', '2025-05-06 06:02:56', NULL, 7),
(29, 'kiaan@gmail.com', '$2b$10$7HRCib817/Cm/EPRLPqBdOppArw.FGfibHOKb2FQtLmQPyX9AlRby', 'counselor', 'krishna', 4555, '2025-05-06 06:15:19', '2025-05-06 06:15:19', NULL, 8),
(30, 'rajput@gmail.com', '$2b$10$E8a9lqUumkQpOCrkaEiKhuusWl4w6mBr9iADEuAbNYK6ZNfeqGT6O', 'counselor', 'krishna123', 1, '2025-05-06 06:19:32', '2025-05-06 06:19:32', NULL, 9),
(31, 'kr@gmail.com', '$2b$10$LA3dZVjOzoOe0j3ouzJDOOl5FbatD4P4f/ZIXu78V.U679m6XT0N6', 'counselor', 'krishna', 1, '2025-05-06 06:27:20', '2025-05-06 06:27:20', NULL, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admission_decisions`
--
ALTER TABLE `admission_decisions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `counselors`
--
ALTER TABLE `counselors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `follow_ups`
--
ALTER TABLE `follow_ups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admission_no` (`admission_no`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admission_decisions`
--
ALTER TABLE `admission_decisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `follow_ups`
--
ALTER TABLE `follow_ups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
