-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 22, 2025 at 05:30 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `finaltestiingafsana`
--

-- --------------------------------------------------------

--
-- Table structure for table `admission_decisions`
--

CREATE TABLE `admission_decisions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Pending',
  `decision_date` date NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admission_decisions`
--

INSERT INTO `admission_decisions` (`id`, `user_id`, `student_id`, `university_id`, `status`, `decision_date`, `created_at`) VALUES
(19, 1, 78, 21, 'accepted', '2025-07-24', '2025-07-21 13:42:49');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `branch_name` varchar(255) NOT NULL,
  `branch_address` text NOT NULL,
  `branch_phone` varchar(20) NOT NULL,
  `branch_email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branch_name`, `branch_address`, `branch_phone`, `branch_email`, `created_at`, `updated_at`) VALUES
(8, 'Dhaka', 'Indore', '07302161400', 'dhaka@gmail.com', '2025-05-08 03:59:27', '2025-05-10 04:50:59'),
(23, 'Sylhet', 'Sylhet@gmail.com', '123456768', 'Sylhet@gmail.com', '2025-05-10 02:20:40', '2025-05-10 02:20:40');

-- --------------------------------------------------------

--
-- Table structure for table `counselors`
--

CREATE TABLE `counselors` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `counselors`
--

INSERT INTO `counselors` (`id`, `user_id`, `phone`, `university_id`, `status`, `created_at`, `updated_at`) VALUES
(20, 1, '567567676', 20, 'active', '2025-07-12 13:21:10', '2025-07-12 13:21:10'),
(21, 1, '04545454555', 20, 'active', '2025-07-12 14:39:53', '2025-07-12 14:39:53'),
(23, 1, '136547878978', 24, 'active', '2025-07-16 11:26:55', '2025-07-16 11:26:55'),
(24, 1, '07302161400', 23, 'active', '2025-07-16 11:59:03', '2025-07-16 11:59:03'),
(25, 1, '12345678+95', 21, 'active', '2025-07-21 16:10:10', '2025-07-21 16:10:10');

-- --------------------------------------------------------

--
-- Table structure for table `follow_ups`
--

CREATE TABLE `follow_ups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `follow_up_date` date NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `urgency_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `follow_upsnew`
--

CREATE TABLE `follow_upsnew` (
  `id` int(11) NOT NULL,
  `user_id` int(255) DEFAULT NULL,
  `counselor_id` int(255) DEFAULT NULL,
  `inquiry_id` int(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `follow_up_date` date NOT NULL,
  `urgency_level` varchar(255) NOT NULL,
  `department` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `follow_upsnew`
--

INSERT INTO `follow_upsnew` (`id`, `user_id`, `counselor_id`, `inquiry_id`, `name`, `title`, `description`, `status`, `follow_up_date`, `urgency_level`, `department`, `created_at`) VALUES
(1, 1, 23, 62, 'Follow-up for Visa', 'Visa Document Submission', 'Student needs to submit I-20 and passport.', 'Pending', '2025-07-20', 'High', 'Visa Department', '2025-07-17 08:19:34');

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `id` int(11) NOT NULL,
  `counselor_id` int(11) DEFAULT NULL,
  `notification_status` varchar(255) NOT NULL DEFAULT '0',
  `inquiry_type` varchar(100) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `branch` varchar(100) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `course_name` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0',
  `is_view` varchar(255) NOT NULL DEFAULT '0',
  `lead_status` varchar(255) NOT NULL DEFAULT '0',
  `payment_status` varchar(255) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `medium` varchar(255) DEFAULT NULL,
  `study_level` varchar(50) DEFAULT NULL,
  `study_field` varchar(100) DEFAULT NULL,
  `intake` varchar(50) DEFAULT NULL,
  `budget` varchar(100) DEFAULT NULL,
  `consent` tinyint(1) DEFAULT 0,
  `highest_level` varchar(255) DEFAULT NULL,
  `ssc` varchar(255) DEFAULT NULL,
  `hsc` varchar(255) DEFAULT NULL,
  `bachelor` varchar(255) DEFAULT NULL,
  `university` varchar(255) DEFAULT NULL,
  `test_type` varchar(255) DEFAULT NULL,
  `overall_score` varchar(255) DEFAULT NULL,
  `reading_score` varchar(255) DEFAULT NULL,
  `writing_score` varchar(255) DEFAULT NULL,
  `speaking_score` varchar(255) DEFAULT NULL,
  `listening_score` varchar(255) DEFAULT NULL,
  `date_of_inquiry` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `present_address` text DEFAULT NULL,
  `additionalNotes` varchar(255) DEFAULT NULL,
  `study_gap` varchar(255) DEFAULT NULL,
  `visa_refused` varchar(255) DEFAULT NULL,
  `refusal_reason` varchar(255) DEFAULT NULL,
  `education_background` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `english_proficiency` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `job_duration` varchar(50) DEFAULT NULL,
  `preferred_countries` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `eligibility_status` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `assignment_description` text NOT NULL,
  `follow_up_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `new_leads` varchar(255) NOT NULL DEFAULT 'new',
  `passport` text DEFAULT NULL,
  `certificates` text DEFAULT NULL,
  `ielts` text DEFAULT NULL,
  `sop` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`id`, `counselor_id`, `notification_status`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `status`, `is_view`, `lead_status`, `payment_status`, `city`, `date_of_birth`, `gender`, `medium`, `study_level`, `study_field`, `intake`, `budget`, `consent`, `highest_level`, `ssc`, `hsc`, `bachelor`, `university`, `test_type`, `overall_score`, `reading_score`, `writing_score`, `speaking_score`, `listening_score`, `date_of_inquiry`, `address`, `present_address`, `additionalNotes`, `study_gap`, `visa_refused`, `refusal_reason`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `eligibility_status`, `created_at`, `updated_at`, `assignment_description`, `follow_up_date`, `notes`, `new_leads`, `passport`, `certificates`, `ielts`, `sop`) VALUES
(61, 24, '0', 'work_visa', 'youtube', 'Dhaka', 'cvbvxc', '123654789', 'admin@example.com', 'fdsfdsf', 'UK', '1', '0', 'Converted to Lead', '0', 'ffdgdfgh', '2025-07-16', 'female', 'english', 'phd', 'dfdfd', 'september', 'cvcxvcx', 1, 'hsc', NULL, NULL, NULL, 'cvcxvxzcv', 'toefl', '54', '65', '60', '70', '52', NULL, 'dfdsf', 'dfdsfdsf', NULL, 'cvdscvdsf', 'yes', 'dfdfdf', '[]', '[]', 'dfdsfdd', 'dfd', 'ddasf', '[\"UK\"]', '0', '2025-07-15 08:24:47', '2025-07-21 10:08:25', '0', '2025-07-17', 'sefs', 'Registered', NULL, NULL, NULL, NULL),
(62, 23, '0', 'work_visa', 'youtube', 'Dhaka', 'krishna', '07302161400', 'krishnarajputkiaan@gmail.com', 'deo', 'Latvia', '1', '1', 'Converted to Lead', 'select', 'indore', '2025-07-16', 'male', 'english', 'diploma', 'demo', 'february', '5000', 1, 'hsc', NULL, NULL, NULL, 'govt', 'ielts', '77', '77', '6', '7.7', '6', '2025-07-15', 'Indore', 'Gopal gram', NULL, 'ghgf', 'yes', 'demo', '[]', NULL, 'bfghgf', 'hgh', 'jan-2020', '[\"Latvia\"]', '0', '2025-07-15 09:18:21', '2025-07-21 12:28:27', '0', '2025-07-18', 'gdfg', 'Registered', NULL, NULL, NULL, NULL),
(63, NULL, '0', 'visit_visa', 'facebook', 'Dhaka', 'ritika', '123433322', 'krishnarajputkiaan@gmail.com', 'deo', 'Hungary', '0', '0', 'Converted to Lead', '0', 'indore', '2025-07-16', 'male', 'english', 'bachelor', 'demo', 'february', '5000', 1, 'ssc', NULL, NULL, NULL, 'hghgh', 'ielts', '77', '77', '77', '777', '77', '2025-07-17', 'Indore', 'Gopal gram', NULL, 'ertet', 'yes', 'demoeufhe', '[{\"level\":\"ssc\",\"gpa\":\"45\",\"year\":\"2025\"}]', NULL, 'demo', 'sdsd', 'jan-2020', '[\"Hungary\",\"UK\"]', '0', '2025-07-17 06:03:29', '2025-07-21 10:04:18', '0', NULL, NULL, 'new', NULL, NULL, NULL, NULL),
(64, 1, '0', 'work_visa', 'youtube', 'Sylhet', 'Sandip Dodiya', '07302161400', 'krishnarajput213123kiaan@gmail.com', 'deo', 'Lithuania', '0', '0', 'Not Interested', '0', 'Ujjain', '2025-07-22', 'male', 'bangla', 'diploma', 'demo', 'february', '500', 1, 'bachelor', NULL, NULL, NULL, 'govt', 'toefl', '7.6', '77', '77', '7.7', '7.7', NULL, 'Gopal gram - chirola,Chirola,Ujjain Madhya Pradesh - 456313', 'Gopal gram', NULL, 'gfhh', 'yes', 'demo', '[]', '[]', 'kiaan', 'sales', 'jan-2020', '[\"UK\"]', '0', '2025-07-21 08:14:35', '2025-07-21 10:04:25', '0', NULL, NULL, 'new', NULL, NULL, NULL, NULL),
(65, 1, '0', 'visit_visa', 'youtube', 'Sylhet', 'ghg', '07302161400cv', 'krishnarajputkiaan@gmail.com', 'deo', 'Germany', '0', '0', 'Not Eligible', '0', 'Ujjain', '2025-07-08', 'female', 'english', 'diploma', 'demo', 'february', '2353', 1, 'ssc', NULL, NULL, NULL, 'hghgh', 'toefl', '77', '77', '77', '23', '77', NULL, 'Gopal gram - chirola,Chirola,Ujjain Madhya Pradesh - 456313', 'Gopal gram', NULL, 'vcvxcvcvdfdfsdjgkt', 'yes', 'ghfgh', '[{\"level\":\"ssc\",\"gpa\":\"cv\",\"year\":\"cxcvcv\"}]', '[]', 'demo ', 'demo', 'jan-2020', '[\"Hungary\",\"UK\"]', '0', '2025-07-21 08:19:25', '2025-07-21 10:04:37', '0', NULL, NULL, 'new', NULL, NULL, NULL, NULL),
(66, 1, '0', 'visit_visa', 'facebook', 'Dhaka', 'krishna', '07302161400', 'krishnarajput4554kiaan@gmail.com', 'uuii', 'UK', '0', '0', '0', '0', 'indore', '2025-07-17', 'male', 'bangla', 'diploma', 'demo', 'february', '500', 1, 'ssc', NULL, NULL, NULL, 'rgpv', 'ielts', '55', '44', '65', '998', '78', NULL, 'Indore', 'Gopal gram', NULL, 'gfdg', 'yes', 'gffg', '[{\"level\":\"ssc\",\"gpa\":\"56\",\"year\":\"2020\"}]', '[]', 'demo ', 'hgh', 'jan-2020', '[\"UK\"]', '0', '2025-07-21 08:21:52', '2025-07-21 08:21:52', '0', NULL, NULL, 'new', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inquiry_images`
--

CREATE TABLE `inquiry_images` (
  `id` int(11) NOT NULL,
  `inquiry_id` int(11) DEFAULT NULL,
  `image` longblob DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `counselor` int(11) DEFAULT NULL,
  `follow_up_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `preferred_countries` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `chatId` varchar(100) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('sent','delivered') NOT NULL DEFAULT 'sent'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `branch` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  `university` int(11) DEFAULT NULL,
  `university_other` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `country_other` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `payment_method_other` varchar(255) DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `payment_type_other` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL DEFAULT 'unpaid',
  `file` text DEFAULT NULL,
  `assistant` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `branch`, `name`, `whatsapp`, `email`, `group_name`, `university`, `university_other`, `country`, `country_other`, `payment_method`, `payment_method_other`, `payment_type`, `payment_type_other`, `payment_status`, `file`, `assistant`, `note`, `created_at`, `updated_at`) VALUES
(32, 23, '64', '345353553454', 'pankit1205@gmail.com', 'demo', 18, NULL, 'Lithuania', NULL, 'Cash', NULL, 'Bank Statement', NULL, 'paid', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752316816/e7n8rh04ukmgyynxs45p.jpg', 'demo', 'demo', '2025-07-12 10:40:17', '2025-07-12 10:52:52'),
(33, 8, '65', '9874563214', 'same@gmal.com', 'dsadad', 18, NULL, 'Australia', NULL, 'Cash', NULL, 'Bank Statement', NULL, 'paid', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752489216/vf8gzn5kb4zkdcafsjbm.jpg', 'sdsdsdasd', 'dfdfdf', '2025-07-14 10:33:37', '2025-07-14 10:41:17'),
(36, 23, '70', '132465977', 'jhon@gmail.com', 'rghgh', 21, NULL, 'UK', NULL, 'Cash', NULL, 'Application Fee', NULL, 'unpaid', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752663990/cnsekt28vvrwycvqgsmf.jpg', 'yiuyiyui', 'uiuyiuii', '2025-07-16 11:06:31', '2025-07-16 11:06:31');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `view_permission` tinyint(1) DEFAULT 0,
  `add_permission` tinyint(1) DEFAULT 0,
  `edit_permission` tinyint(1) DEFAULT 0,
  `delete_permission` tinyint(1) DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `role_name`, `permission_name`, `view_permission`, `add_permission`, `edit_permission`, `delete_permission`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'student', 'Dashboard', 1, 1, 1, 1, 1, '2025-05-06 07:18:14', '2025-07-14 10:27:20'),
(2, 'student', 'Student Details', 1, 1, 1, 1, 1, '2025-05-06 07:19:05', '2025-07-21 12:50:48'),
(3, 'student', 'Student Programs', 1, 1, 1, 0, 1, '2025-05-06 07:19:47', '2025-05-21 17:54:32'),
(4, 'student', 'Communication', 1, 1, 1, 0, 1, '2025-05-06 07:20:33', '2025-05-21 17:54:32'),
(5, 'student', 'Application Management', 1, 1, 1, 0, 1, '2025-05-06 07:21:28', '2025-05-21 17:54:33'),
(6, 'student', 'Task Management', 1, 1, 1, 0, 1, '2025-05-06 07:22:00', '2025-05-21 17:54:29'),
(7, 'student', 'Payments & Invoices', 1, 1, 1, 0, 1, '2025-05-06 07:22:24', '2025-05-21 17:54:30'),
(8, 'student', 'Course & University', 1, 1, 1, 0, 1, '2025-05-06 07:25:56', '2025-05-21 17:54:31'),
(9, 'counselor', 'Dashboard', 1, 1, 1, 0, 1, '2025-05-06 07:28:46', '2025-05-21 17:54:03'),
(10, 'counselor', 'Inquiry', 1, 1, 1, 0, 1, '2025-05-06 07:29:04', '2025-05-21 17:54:04'),
(11, 'counselor', 'Lead', 1, 1, 1, 0, 1, '2025-05-06 07:29:24', '2025-05-21 17:54:05'),
(12, 'counselor', 'Status', 1, 1, 1, 0, 1, '2025-05-06 07:29:47', '2025-05-21 17:54:05'),
(13, 'counselor', 'Task', 1, 1, 1, 0, 1, '2025-05-06 07:29:59', '2025-05-21 17:54:09'),
(14, 'counselor', 'Student Details', 1, 1, 1, 0, 1, '2025-05-06 07:30:20', '2025-05-21 17:54:07'),
(15, 'counselor', 'Communication', 1, 1, 1, 0, 1, '2025-05-06 07:30:34', '2025-05-21 17:54:08'),
(16, 'counselor', 'Course & University', 1, 1, 1, 0, 1, '2025-05-06 07:30:59', '2025-05-21 17:54:08'),
(17, 'staff', 'Inquiry', 1, 1, 1, 1, 1, '2025-05-06 01:48:14', '2025-05-21 12:24:26'),
(18, 'staff', 'Lead', 1, 1, 1, 1, 1, '2025-05-06 01:49:05', '2025-05-21 12:24:27'),
(19, 'staff', 'Inquiry', 1, 1, 0, 0, 74, '2025-07-05 08:16:30', '2025-07-05 08:16:30'),
(20, 'staff', 'Lead', 1, 1, 1, 0, 74, '2025-07-05 08:16:30', '2025-07-05 08:16:30'),
(21, 'staff', 'Inquiry', 1, 0, 0, 0, 75, '2025-07-07 07:50:05', '2025-07-07 07:50:05'),
(22, 'staff', 'Payments & Invoice', 1, 0, 0, 0, 75, '2025-07-07 07:50:05', '2025-07-07 07:50:05'),
(23, 'staff', 'Lead', 0, 1, 0, 0, 75, '2025-07-07 07:50:05', '2025-07-07 07:50:05'),
(24, 'staff', 'Inquiry', 1, 0, 0, 0, 76, '2025-07-07 08:09:31', '2025-07-07 08:09:31'),
(25, 'staff', 'Payments & Invoice', 0, 0, 1, 0, 76, '2025-07-07 08:09:31', '2025-07-07 08:09:31'),
(26, 'staff', 'Lead', 1, 0, 0, 0, 76, '2025-07-07 08:09:31', '2025-07-07 08:09:31'),
(27, 'staff', 'Inquiry', 1, 0, 0, 0, 77, '2025-07-07 08:24:03', '2025-07-07 08:24:03'),
(28, 'staff', 'Lead', 1, 0, 0, 0, 77, '2025-07-07 08:24:03', '2025-07-07 08:24:03'),
(29, 'staff', 'Payments & Invoice', 1, 0, 0, 0, 77, '2025-07-07 08:24:03', '2025-07-07 08:24:03'),
(30, 'staff', 'Inquiry', 1, 1, 1, 1, 98, '2025-07-12 10:24:46', '2025-07-12 10:24:46'),
(31, 'staff', 'Payments & Invoice', 0, 0, 0, 0, 98, '2025-07-12 10:24:46', '2025-07-12 10:24:46'),
(32, 'staff', 'Lead', 0, 0, 0, 0, 98, '2025-07-12 10:24:46', '2025-07-12 10:24:46'),
(33, 'staff', 'Inquiry', 0, 0, 0, 0, 99, '2025-07-12 10:27:00', '2025-07-12 10:27:00'),
(34, 'staff', 'Lead', 0, 0, 0, 0, 99, '2025-07-12 10:27:00', '2025-07-12 10:27:00'),
(35, 'staff', 'Payments & Invoice', 1, 1, 1, 1, 99, '2025-07-12 10:27:00', '2025-07-12 10:27:00'),
(36, 'staff', 'Inquiry', 1, 1, 1, 1, 109, '2025-07-16 11:52:50', '2025-07-16 11:52:50'),
(37, 'staff', 'Lead', 1, 1, 1, 1, 109, '2025-07-16 11:52:50', '2025-07-16 11:52:50'),
(38, 'staff', 'Payments & Invoice', 1, 1, 1, 1, 109, '2025-07-16 11:52:50', '2025-07-16 11:52:50');

-- --------------------------------------------------------

--
-- Table structure for table `remainder`
--

CREATE TABLE `remainder` (
  `id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `remainder`
--

INSERT INTO `remainder` (`id`, `task_id`, `date`) VALUES
(15, 72, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(255) NOT NULL,
  `user_id` int(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `user_id`, `status`, `phone`, `created_at`, `updated_at`) VALUES
(14, 1, 'active', '7894561230', '2025-07-16 17:22:50', '2025-07-16 17:22:50');

-- --------------------------------------------------------

--
-- Table structure for table `studentapplicationprocess`
--

CREATE TABLE `studentapplicationprocess` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `counselor_id` int(11) DEFAULT NULL,
  `follow_up` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `registration_fee_payment` varchar(255) DEFAULT NULL,
  `registration_date` text DEFAULT NULL,
  `application_submission_date` text DEFAULT NULL,
  `application_fee_payment` varchar(255) DEFAULT NULL,
  `fee_confirmation_document` text DEFAULT NULL,
  `university_interview_date` text DEFAULT NULL,
  `university_interview_outcome` varchar(255) DEFAULT NULL,
  `conditional_offer_letter` text DEFAULT NULL,
  `invoice_with_conditional_offer` text DEFAULT NULL,
  `tuition_fee_transfer_proof` text DEFAULT NULL,
  `final_university_offer_letter` text DEFAULT NULL,
  `offer_letter_service_charge_paid` varchar(255) DEFAULT NULL,
  `university_offer_letter_received` text DEFAULT NULL,
  `appendix_form_completed` longtext DEFAULT NULL,
  `passport_copy_prepared` longtext DEFAULT NULL,
  `email_sent_for_documentation` text DEFAULT NULL,
  `appointment_date` text DEFAULT NULL,
  `financial_support_declaration` text DEFAULT NULL,
  `final_offer_letter` text DEFAULT NULL,
  `proof_of_relationship` text DEFAULT NULL,
  `english_language_proof` text DEFAULT NULL,
  `visa_interview_date` text DEFAULT NULL,
  `residence_permit_form` text DEFAULT NULL,
  `proof_of_income` text DEFAULT NULL,
  `airplane_ticket_booking` text DEFAULT NULL,
  `police_clearance_certificate` text DEFAULT NULL,
  `europass_cv` text DEFAULT NULL,
  `birth_certificate` text DEFAULT NULL,
  `bank_statement` text DEFAULT NULL,
  `accommodation_proof` text DEFAULT NULL,
  `motivation_letter` text DEFAULT NULL,
  `previous_studies_certificates` text DEFAULT NULL,
  `travel_insurance` text DEFAULT NULL,
  `european_photo` text DEFAULT NULL,
  `health_insurance` text DEFAULT NULL,
  `visa_decision` varchar(255) DEFAULT NULL,
  `visa_service_charge_paid` varchar(255) DEFAULT NULL,
  `flight_booking_confirmed` varchar(255) DEFAULT NULL,
  `online_enrollment_completed` varchar(255) DEFAULT NULL,
  `accommodation_confirmation` varchar(255) DEFAULT NULL,
  `arrival_country` varchar(255) DEFAULT NULL,
  `university_id` int(11) NOT NULL,
  `Application_stage` varchar(255) DEFAULT NULL,
  `Interview` varchar(255) DEFAULT NULL,
  `Visa_process` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `studentapplicationprocess`
--

INSERT INTO `studentapplicationprocess` (`id`, `student_id`, `counselor_id`, `follow_up`, `notes`, `registration_fee_payment`, `registration_date`, `application_submission_date`, `application_fee_payment`, `fee_confirmation_document`, `university_interview_date`, `university_interview_outcome`, `conditional_offer_letter`, `invoice_with_conditional_offer`, `tuition_fee_transfer_proof`, `final_university_offer_letter`, `offer_letter_service_charge_paid`, `university_offer_letter_received`, `appendix_form_completed`, `passport_copy_prepared`, `email_sent_for_documentation`, `appointment_date`, `financial_support_declaration`, `final_offer_letter`, `proof_of_relationship`, `english_language_proof`, `visa_interview_date`, `residence_permit_form`, `proof_of_income`, `airplane_ticket_booking`, `police_clearance_certificate`, `europass_cv`, `birth_certificate`, `bank_statement`, `accommodation_proof`, `motivation_letter`, `previous_studies_certificates`, `travel_insurance`, `european_photo`, `health_insurance`, `visa_decision`, `visa_service_charge_paid`, `flight_booking_confirmed`, `online_enrollment_completed`, `accommodation_confirmation`, `arrival_country`, `university_id`, `Application_stage`, `Interview`, `Visa_process`, `status`, `created_at`) VALUES
(86, 78, 23, '2025-07-21', 'sS', 'Paid', '2025-07-24', '2025-07-17', 'Paid', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753099883/alvuzs8fqag6pi0v49zs.jpg', '2025-07-31', 'Foundation', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097069/zbrb5te1opwqefetwvsq.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097071/s6dtzg7l4w1msogdzkbc.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097073/t34dvwy7xi3oep7eyxr1.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097076/ocurfom7klqreuvsx4mk.jpg', 'Paid', '2025-07-24', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097078/ppqmwnwzjia5edguxpkc.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097080/cucnwmthtdcslcpguzg5.jpg', '2025-07-17', '2025-07-31', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097082/bqikcabyl4eqtt9gq59i.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097085/dtdswtdtn6nd9jfhqrzg.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097087/u0ivehhrszsulrrvb3tk.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097089/tfisqvszpxu9vtk34o2e.jpg', '2025-07-25', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097091/jat6er8kel1n3djrkjkf.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097094/ypa8mws5ld3f52m6q6jn.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097096/o1bkngp1ptjswoo0gp11.jpg', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'Approved', 'Pending', '1', '0', '0', 'India', 61, '1', '1', '1', 0, '2025-07-21 10:12:47'),
(88, 78, 23, '2025-07-18', 'dad', 'Pending', '2025-07-21', '2025-07-21', 'Pending', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753093192/dm4mwsvvath1wsphsoeg.png', '2025-07-10', 'Accepted', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097474/oxr54droanixz1c5ai0z.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097477/yfjojunvwafcwxgbdh7e.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097479/r3v5tmy4kwuygovrwdfz.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097481/d2armj0j35wfenmtiwpg.jpg', 'Pending', '2025-07-22', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097742/gre1y7oinxbbbzcsswte.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097745/tkpaqyyyzbloh91esu1a.jpg', '2025-07-21', '2025-07-21', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097747/ixdrcyht5ckrasyt87bt.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097750/czuxqkdtcntik0zmw6dy.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097752/eeb2xddo1vl8af8ibksm.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097754/yieikfwyjmsirup8tpzj.jpg', '2025-07-21', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097757/bpkvienyobnqkou4dopa.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097759/troaokrlxsnggyimary9.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097762/hzk9du3yo3cxhnitfhtn.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097764/g63tzvfa9q3sypl3pfyv.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097766/bhps4nbnm4riixnrfxij.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097769/pkxxx2jc32ayjo1scqw6.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097787/fypqilcsyvkbiycrgywx.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097771/i1uzfn3h30xregbuukrw.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097774/e7ap3qt1yyzpgc2mvl5c.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097776/yzvtmpypxy2hlifsw7hi.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097779/x28opivpdglqhxpvegp3.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097784/qmv8s6diye0wya2hncqb.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753097781/cbfsstrwktklnpucyedp.jpg', 'Appeal', 'Paid', '1', '1', '1', 'India', 24, '1', '1', '1', 1, '2025-07-21 10:19:53'),
(89, 78, 25, '2025-07-24', 'www', 'Paid', '2025-07-21', '2025-07-21', 'Pending', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753093225/xx550fmq3uaf86azo7mw.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, 23, '1', '0', '0', 0, '2025-07-21 10:20:25'),
(90, 78, NULL, NULL, NULL, 'Paid', '2025-07-24', '2025-07-31', 'Pending', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753099997/bv6kzbzgd3wmjpfsvtez.jpg', NULL, 'null', 'null', 'null', 'null', 'null', 'null', NULL, 'null', 'null', 'null', NULL, 'null', 'null', 'null', 'null', NULL, 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '0', '0', '0', 'null', 22, '1', '1', '1', 0, '2025-07-21 11:52:49'),
(91, 78, NULL, NULL, NULL, 'null', NULL, NULL, 'null', 'null', NULL, 'null', 'null', 'null', 'null', 'null', 'null', NULL, 'null', 'null', 'null', NULL, 'null', 'null', 'null', 'null', NULL, 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '0', '0', '0', 'null', 21, '1', '1', '1', 0, '2025-07-21 12:12:45');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `father_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `identifying_name` varchar(255) NOT NULL,
  `mother_name` varchar(255) NOT NULL,
  `mobile_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `counselor_id` int(11) DEFAULT NULL,
  `follow_up` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `applicant_name` varchar(100) DEFAULT NULL,
  `applicant_phone` varchar(20) DEFAULT NULL,
  `applicant_email` varchar(100) DEFAULT NULL,
  `applicant_tin_no` varchar(50) DEFAULT NULL,
  `applicant_present_address` text DEFAULT NULL,
  `applicant_marital_status` varchar(20) DEFAULT NULL,
  `applicant_spouse_occupation` varchar(100) DEFAULT NULL,
  `applicant_spouse_monthly_income` decimal(10,2) DEFAULT NULL,
  `applicant_number_of_children` int(11) DEFAULT NULL,
  `applicant_sponsor_name` varchar(100) DEFAULT NULL,
  `academic_info` text DEFAULT NULL,
  `english_proficiency` text DEFAULT NULL,
  `job_professional` text DEFAULT NULL,
  `refused_countries` text DEFAULT NULL,
  `travel_history` text DEFAULT NULL,
  `passport_1_no` varchar(50) DEFAULT NULL,
  `passport_1_expiry` date DEFAULT NULL,
  `passport_2_no` varchar(50) DEFAULT NULL,
  `passport_2_expiry` date DEFAULT NULL,
  `passport_3_no` varchar(50) DEFAULT NULL,
  `passport_3_expiry` date DEFAULT NULL,
  `business_name_license` text DEFAULT NULL,
  `business_monthly_income` decimal(10,2) DEFAULT NULL,
  `business_current_balance` decimal(10,2) DEFAULT NULL,
  `personal_savings` text DEFAULT NULL,
  `business_income_details` text DEFAULT NULL,
  `tax_returns_tin` text DEFAULT NULL,
  `sponsor_email` varchar(100) DEFAULT NULL,
  `sponsor_relationship` varchar(50) DEFAULT NULL,
  `sponsor_occupation` varchar(100) DEFAULT NULL,
  `sponsor_job_position_company` text DEFAULT NULL,
  `sponsor_employment_duration` varchar(100) DEFAULT NULL,
  `sponsor_status` varchar(50) DEFAULT NULL,
  `sponsor_bin` varchar(100) DEFAULT NULL,
  `sponsor_tax_docs` tinyint(1) DEFAULT NULL,
  `sponsor_address` text DEFAULT NULL,
  `sponsor_phone` varchar(20) DEFAULT NULL,
  `sponsor_business_name_type` text DEFAULT NULL,
  `sponsor_income_monthly` decimal(10,2) DEFAULT NULL,
  `sponsor_income_yearly` decimal(10,2) DEFAULT NULL,
  `sponsor_license_no` varchar(50) DEFAULT NULL,
  `sponsor_income_mode` varchar(20) DEFAULT NULL,
  `sponsor_bank_details` text DEFAULT NULL,
  `visa_refusal_explanation` text DEFAULT NULL,
  `name_age_mismatch` text DEFAULT NULL,
  `study_gap_explanation` text DEFAULT NULL,
  `deportation_details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `father_name`, `identifying_name`, `mother_name`, `mobile_number`, `university_id`, `date_of_birth`, `gender`, `category`, `address`, `full_name`, `role`, `photo`, `documents`, `created_at`, `updated_at`, `counselor_id`, `follow_up`, `notes`, `applicant_name`, `applicant_phone`, `applicant_email`, `applicant_tin_no`, `applicant_present_address`, `applicant_marital_status`, `applicant_spouse_occupation`, `applicant_spouse_monthly_income`, `applicant_number_of_children`, `applicant_sponsor_name`, `academic_info`, `english_proficiency`, `job_professional`, `refused_countries`, `travel_history`, `passport_1_no`, `passport_1_expiry`, `passport_2_no`, `passport_2_expiry`, `passport_3_no`, `passport_3_expiry`, `business_name_license`, `business_monthly_income`, `business_current_balance`, `personal_savings`, `business_income_details`, `tax_returns_tin`, `sponsor_email`, `sponsor_relationship`, `sponsor_occupation`, `sponsor_job_position_company`, `sponsor_employment_duration`, `sponsor_status`, `sponsor_bin`, `sponsor_tax_docs`, `sponsor_address`, `sponsor_phone`, `sponsor_business_name_type`, `sponsor_income_monthly`, `sponsor_income_yearly`, `sponsor_license_no`, `sponsor_income_mode`, `sponsor_bank_details`, `visa_refusal_explanation`, `name_age_mismatch`, `study_gap_explanation`, `deportation_details`) VALUES
(73, 112, 'jamde', 'krishna 10 jan 2005', 'surekha', '07302161400', 22, '2025-07-18', 'Male', 'SC', 'Indore\r\nGopal gram', 'krishna12454', 'student', '', '', '2025-07-18 11:50:57', '2025-07-21 15:45:46', 23, '2025-07-22', 'dfdsfdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 113, 'demo', 'om Jul-19 Deb', 'fdfd', '07302161400', 23, '2025-07-19', 'Male', 'ST', 'Indore\r\nGopal gram', 'om', 'student', '', '', '2025-07-18 12:05:27', '2025-07-22 20:06:47', 23, '2025-07-19', 'hjn', 'Alex Doe', '9876543210', 'alex@example.com', 'TIN123456', '123 Main Street, Delhi', 'Single', '', 0.00, 0, 'David Doe', '[\"12th Grade - 85%\",\"IELTS - 7.0 Band\",\"BSc Computer Science\"]', '[\"IELTS\",\"TOEFL\"]', '[\"Intern at TechSoft\",\"Part-time Tutor\"]', 'None', 'Visited UAE in 2022', 'P12345678', '2029-05-15', '', NULL, '', NULL, '', 0.00, 0.00, '₹1,50,000 in savings account', '', 'TIN123456', 'david@example.com', 'Father', 'Businessman', 'Owner at Doe Exports', '15 years', 'Active', 'BIN98765', 1, '456 Business Street, Mumbai', '9898989898', 'Exports & Logistics', 150000.00, 1800000.00, 'LIC12345', 'Bank Transfer', 'ICICI Bank, A/C: 1234567890', '', '', 'Took 1 year for job experience', ''),
(76, 115, 'badode', 'krishna_20250719', 'dfdsf', '9874563210', 22, '2025-07-19', 'Male', 'ST', 'Gopal gram - chirola,Chirola,Ujjain Madhya Pradesh - 456313\r\nGopal gram', 'krishna', 'student', '', '', '2025-07-18 16:10:21', '2025-07-18 16:12:39', 23, '2025-07-19', 'hjhghg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 116, 'fgfhf', 'krishna_20250720', '120', '136547878978', 21, '2025-07-20', 'Male', 'SC', 'dfdffd', 'krishna', 'student', '', '', '2025-07-19 11:33:33', '2025-07-19 11:33:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 117, 'badode', 'arun Jun-21 Deb', 'ritika', '09174248186', 21, '2008-06-20', 'Male', 'General', 'Makan no. 115 Nishaniya mal\r\nHarsud', 'arun', 'student', '', '', '2025-07-21 12:02:43', '2025-07-21 16:55:47', 23, '2025-07-23', 'sdfsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_fees`
--

CREATE TABLE `student_fees` (
  `id` int(11) NOT NULL,
  `student_name` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `amount` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `fee_date` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_fees_by_counselor`
--

CREATE TABLE `student_fees_by_counselor` (
  `id` int(11) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `fee_date` date NOT NULL,
  `inquiry_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_fees_by_counselor`
--

INSERT INTO `student_fees_by_counselor` (`id`, `student_name`, `description`, `amount`, `fee_date`, `inquiry_id`, `user_id`, `created_at`, `updated_at`) VALUES
(23, 'krishna', 'reewrt', 457.00, '2025-07-17', 62, 62, '2025-07-18 06:46:35', '2025-07-18 06:46:35');

-- --------------------------------------------------------

--
-- Table structure for table `student_invoice`
--

CREATE TABLE `student_invoice` (
  `id` int(11) NOT NULL,
  `payment_amount` varchar(255) NOT NULL,
  `tax` varchar(255) NOT NULL,
  `total` varchar(255) NOT NULL,
  `additional_notes` text DEFAULT NULL,
  `student_id` varchar(255) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_invoice`
--

INSERT INTO `student_invoice` (`id`, `payment_amount`, `tax`, `total`, `additional_notes`, `student_id`, `payment_date`, `created_at`, `updated_at`) VALUES
(7, '99', '7.92', '106.92', 'demo', '64', '2025-07-14', '2025-07-12 10:43:19', '2025-07-12 10:43:19'),
(8, '100', '8', '108', 'jhjk', '65', '2025-07-15', '2025-07-14 10:38:30', '2025-07-14 10:38:30'),
(9, '34', '0.34', '34.34', 'dfdfdfsf', '70', '2025-07-17', '2025-07-16 11:01:08', '2025-07-16 11:01:08');

-- --------------------------------------------------------

--
-- Table structure for table `student_invoice_by_counselor`
--

CREATE TABLE `student_invoice_by_counselor` (
  `id` int(11) NOT NULL,
  `payment_amount` varchar(255) NOT NULL,
  `tax` varchar(255) NOT NULL,
  `total` varchar(255) NOT NULL,
  `additional_notes` text DEFAULT NULL,
  `student_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `due_date` date NOT NULL,
  `counselor_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `priority` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `notification_status` varchar(255) NOT NULL DEFAULT '0',
  `related_to` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `related_item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assigned_to` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `assigned_date` date NOT NULL,
  `finishing_date` date NOT NULL,
  `attachment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testing`
--

CREATE TABLE `testing` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo_url` varchar(500) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `programs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `highlights` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`id`, `user_id`, `name`, `logo_url`, `location`, `programs`, `highlights`, `contact_phone`, `contact_email`, `created_at`, `updated_at`) VALUES
(21, 1, 'Gyor University', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752572658/h0hpumurclsddpxeulhv.jpg', 'University in Győr, Hungary', '[\" BSc in Vehicle Engineering\",\"MSc in Supply Chain Management\"]', '[\"Strong industry partnerships with Audi, Bosch, and IBM\",\"Offers 50+ English-taught programs with a focus on innovation and research\"]', '+36 96 503 400', 'lukacs.eszter@sze.hu', '2025-05-13 07:17:22', '2025-07-16 13:14:24'),
(22, 1, 'Wekerle Business School', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1750412758/oueinvkhnholy4woa71y.jpg', 'Budapest, Jázmin u. 10, 1083 Hungary', '[\"BSc in Business Administration and Management\",\"BSc in International Business Economics\"]', '[\" Affordable tuition with strong focus on practical business skills\",\" Located in central Budapest with excellent international student support\"]', '+36 1 50 174 50', 'international@wsuf.hu', '2025-05-13 07:20:58', '2025-07-16 13:12:59'),
(23, 1, 'University of Debrecen', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1750412997/qqbmab3ox9eqjqknnbr5.png', 'Debrecen, Egyetem tér 1, 4032 Hungary', '[\"MD in Medicine (English program)\",\"BSc in Computer Science Engineering\"]', '[\" One of the oldest and largest universities in Hungary with 30,000+ students\",\" Offers a wide range of English-taught programs with international accreditation\"]', '30,418 (2011)', 'info@edu.unideb.hu', '2025-05-13 07:28:11', '2025-07-16 13:16:09'),
(24, 1, 'Pecs University Hungary', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752574777/sviu079lxwwglxzvxsss.png', 'Pécs, 48-as tér 1, 7622 Hungary', '[\"MD in General Medicine\",\"BA in International Relations\",\"BSc in Business Administration and Management\"]', '[\"One of Hungary’s oldest universities with over 650 years of academic tradition\",\"More than 70 English-taught programs and a vibrant international student community\"]', '+36 72 501 599', 'international@pte.hu', '2025-05-13 07:35:16', '2025-07-16 13:18:50'),
(61, 1, 'asdf', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753092647/oxwvouyvy1wb3jguoo8w.jpg', 'Indore ', '[\"asd\"]', '[\"asdas\"]', '09174248186', 'arunbadode08@gmail.com', '2025-07-21 15:40:48', '2025-07-21 15:40:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `googleSignIn` text DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `student_id` int(11) DEFAULT NULL,
  `counselor_id` int(11) DEFAULT NULL,
  `staff_id` int(255) DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `googleSignIn`, `password`, `role`, `full_name`, `user_id`, `created_at`, `student_id`, `counselor_id`, `staff_id`, `address`, `phone`) VALUES
(1, 'admin@example.com', NULL, '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'admin', 'Alice Admin123', 0, '2025-07-22 15:17:53', NULL, NULL, NULL, 'Sector 21, New Delhi', '9876543210'),
(93, 'counselor@gmail.com', NULL, '$2b$10$i./Erz7TfpILR7UJxIoVAO55iHw8ytVkZFtpzAnoCkp.H28Py0Cy2', 'counselor', 'counselor', 1, '2025-07-22 15:17:57', NULL, 20, NULL, NULL, NULL),
(104, 'vishal@gmail.com', NULL, '$2b$10$ynPqX58fy0RJW/Mb2lNs8Ofq6A7z9G78QzU5Cd9NzNtf/oYAXIc6q', 'counselor', 'vishal counselor', 1, '2025-07-22 15:18:01', NULL, 23, NULL, NULL, NULL),
(106, 'krishna@gmail.com', NULL, '$2b$10$Y0N/gvwV7iy.am0vgNSA9.WhevKY1E25vRcpjGu1hyOdrobLLrbcu', 'counselor', 'krishna', 1, '2025-07-22 15:18:04', NULL, 24, NULL, NULL, NULL),
(109, 'staff@gmail.com', NULL, '$2b$10$plOkdtyfMIcnG4kJcKyW7Oa6LnS4dyp1cSMAldTfxleGTjT/crCrG', 'staff', 'staff', 1, '2025-07-22 15:18:08', NULL, NULL, 14, NULL, NULL),
(111, 'krishnarajputkiaan@gmail.com', NULL, '$2b$10$I6hhUDO4T0VUy.Jb4ycGtOhZn1EQHvk4gxTSn/1ihIaj2BHWHU7Fi', 'student', 'krishna', 0, '2025-07-18 06:18:52', NULL, NULL, NULL, NULL, NULL),
(112, 'krishna12@gmail.com', NULL, '$2b$10$H3PM8/aKXP.jJ2eURHDWqu/vslPGJhkKhhSD5Jx6ZFMeRGihHiGEW', 'student', 'krishna12454', 0, '2025-07-18 06:22:03', 73, NULL, NULL, NULL, NULL),
(113, 'om@gmail.com', NULL, '$2b$10$n2SlPkcDEhk3KA43mr/gqe0s1cmmxK4QG3FupBZH7B7kYu/NIWtau', 'student', 'om', 0, '2025-07-18 06:35:27', 74, NULL, NULL, NULL, NULL),
(115, 'krishna123@gmail.com', NULL, '$2b$10$qeWQs7dEU0ZPmBpYiws0we4tGcZY1XF4Zve1mzYChwKDoe0a6rJD6', 'student', 'krishna', 0, '2025-07-18 10:40:21', 76, NULL, NULL, NULL, NULL),
(116, 'test34@gmail.com', NULL, '$2b$10$RE8ef1BbC9M/bnDNcmeI/OkWdYdWjQo1r0eIkAbVUqqtwF65udGwy', 'student', 'krishna', 0, '2025-07-19 06:03:33', 77, NULL, NULL, NULL, NULL),
(117, 'arunbadode08@gmail.com', NULL, '$2b$10$FI1bnf.fldtaM1k5sNkbpO8rZvl0pNPpJTlVZu/D8lZDALjLQk6RO', 'student', 'arun', 0, '2025-07-21 06:32:43', 78, NULL, NULL, NULL, NULL),
(118, 'rehan@example.com', NULL, '$2b$10$oRV9Xu5jSJKDenS1yAYn3OTP60HoEQ.sNK310vtVlH.D1QYJIozCC', 'counselor', 'rehan', 1, '2025-07-21 10:40:10', NULL, 25, NULL, NULL, NULL),
(119, 'processors@example.com', NULL, '$2a$12$YQGo6gnVRdhlv01PpV0C1.hzS73ntMVDuyKfPPbAjHzYHDmegyHSm', 'processors', 'processors', 0, '2025-07-22 15:01:05', NULL, NULL, NULL, 'Sector 21, New Delhi', '1234567898');

-- --------------------------------------------------------

--
-- Table structure for table `visa_process`
--

CREATE TABLE `visa_process` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `passport_no` varchar(50) DEFAULT NULL,
  `applied_program` varchar(100) DEFAULT NULL,
  `intake` varchar(50) DEFAULT NULL,
  `assigned_counselor` varchar(100) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `passport_doc` varchar(255) DEFAULT NULL,
  `photo_doc` varchar(255) DEFAULT NULL,
  `ssc_doc` varchar(255) DEFAULT NULL,
  `hsc_doc` varchar(255) DEFAULT NULL,
  `bachelor_doc` varchar(255) DEFAULT NULL,
  `ielts_doc` varchar(255) DEFAULT NULL,
  `cv_doc` varchar(255) DEFAULT NULL,
  `sop_doc` varchar(255) DEFAULT NULL,
  `medical_doc` varchar(255) DEFAULT NULL,
  `other_doc` varchar(255) DEFAULT NULL,
  `doc_status` enum('Uploaded','Missing','Verified') DEFAULT NULL,
  `university_name` varchar(100) DEFAULT NULL,
  `program_name` varchar(100) DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `submission_method` varchar(100) DEFAULT NULL,
  `application_proof` varchar(255) DEFAULT NULL,
  `application_id` varchar(100) DEFAULT NULL,
  `application_status` varchar(100) DEFAULT NULL,
  `fee_amount` decimal(10,2) DEFAULT NULL,
  `fee_method` varchar(50) DEFAULT NULL,
  `fee_date` date DEFAULT NULL,
  `fee_proof` varchar(255) DEFAULT NULL,
  `fee_status` varchar(50) DEFAULT NULL,
  `interview_date` datetime DEFAULT NULL,
  `interview_platform` varchar(50) DEFAULT NULL,
  `interview_status` varchar(50) DEFAULT NULL,
  `interviewer_name` varchar(100) DEFAULT NULL,
  `interview_recording` varchar(255) DEFAULT NULL,
  `interview_result` enum('Accepted','Waitlisted','Rejected') DEFAULT NULL,
  `interview_feedback` text DEFAULT NULL,
  `interview_summary` text DEFAULT NULL,
  `interview_result_date` date DEFAULT NULL,
  `conditional_offer_upload` varchar(255) DEFAULT NULL,
  `conditional_offer_date` date DEFAULT NULL,
  `conditional_conditions` text DEFAULT NULL,
  `conditional_offer_status` varchar(50) DEFAULT NULL,
  `tuition_fee_amount` decimal(10,2) DEFAULT NULL,
  `tuition_fee_date` date DEFAULT NULL,
  `tuition_fee_proof` varchar(255) DEFAULT NULL,
  `tuition_fee_status` varchar(50) DEFAULT NULL,
  `tuition_comments` text DEFAULT NULL,
  `main_offer_upload` varchar(255) DEFAULT NULL,
  `main_offer_date` date DEFAULT NULL,
  `main_offer_status` varchar(50) DEFAULT NULL,
  `motivation_letter` varchar(255) DEFAULT NULL,
  `europass_cv` varchar(255) DEFAULT NULL,
  `bank_statement` varchar(255) DEFAULT NULL,
  `birth_certificate` varchar(255) DEFAULT NULL,
  `tax_proof` varchar(255) DEFAULT NULL,
  `business_docs` varchar(255) DEFAULT NULL,
  `ca_certificate` varchar(255) DEFAULT NULL,
  `health_insurance` varchar(255) DEFAULT NULL,
  `residence_form` varchar(255) DEFAULT NULL,
  `flight_booking` varchar(255) DEFAULT NULL,
  `police_clearance` varchar(255) DEFAULT NULL,
  `family_certificate` varchar(255) DEFAULT NULL,
  `application_form` varchar(255) DEFAULT NULL,
  `appointment_location` varchar(100) DEFAULT NULL,
  `appointment_datetime` datetime DEFAULT NULL,
  `appointment_letter` varchar(255) DEFAULT NULL,
  `appointment_status` varchar(50) DEFAULT NULL,
  `embassy_result_date` date DEFAULT NULL,
  `embassy_feedback` text DEFAULT NULL,
  `embassy_result` varchar(50) DEFAULT NULL,
  `embassy_notes` text DEFAULT NULL,
  `embassy_summary` text DEFAULT NULL,
  `visa_status` enum('Approved','Rejected','Pending') DEFAULT NULL,
  `decision_date` date DEFAULT NULL,
  `visa_sticker_upload` varchar(255) DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `appeal_status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visa_process`
--

INSERT INTO `visa_process` (`id`, `student_id`, `full_name`, `email`, `phone`, `date_of_birth`, `passport_no`, `applied_program`, `intake`, `assigned_counselor`, `registration_date`, `source`, `passport_doc`, `photo_doc`, `ssc_doc`, `hsc_doc`, `bachelor_doc`, `ielts_doc`, `cv_doc`, `sop_doc`, `medical_doc`, `other_doc`, `doc_status`, `university_name`, `program_name`, `submission_date`, `submission_method`, `application_proof`, `application_id`, `application_status`, `fee_amount`, `fee_method`, `fee_date`, `fee_proof`, `fee_status`, `interview_date`, `interview_platform`, `interview_status`, `interviewer_name`, `interview_recording`, `interview_result`, `interview_feedback`, `interview_summary`, `interview_result_date`, `conditional_offer_upload`, `conditional_offer_date`, `conditional_conditions`, `conditional_offer_status`, `tuition_fee_amount`, `tuition_fee_date`, `tuition_fee_proof`, `tuition_fee_status`, `tuition_comments`, `main_offer_upload`, `main_offer_date`, `main_offer_status`, `motivation_letter`, `europass_cv`, `bank_statement`, `birth_certificate`, `tax_proof`, `business_docs`, `ca_certificate`, `health_insurance`, `residence_form`, `flight_booking`, `police_clearance`, `family_certificate`, `application_form`, `appointment_location`, `appointment_datetime`, `appointment_letter`, `appointment_status`, `embassy_result_date`, `embassy_feedback`, `embassy_result`, `embassy_notes`, `embassy_summary`, `visa_status`, `decision_date`, `visa_sticker_upload`, `rejection_reason`, `appeal_status`, `created_at`) VALUES
(11, 70, 'jhon', 'jhon@gmail.com', '7896541230', '2025-07-16', '20', 'klklkl', 'kl;kl;ltyut', 'ioiuo', '2025-07-13', 'opoipiop', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664224/sysizzh5shgylds3crvw.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664226/ibu5prnbtsl2y3o3qxwt.png', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664228/oflltmi3fjrgebdcfaaz.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664229/n7vrxakj2aawfpgdtqjt.png', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664231/qaof1i79ccbb5vmjdw3e.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664233/qxgpmjrq3s1numjlnwtg.png', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664235/r36w32u6d23zxricspzv.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664237/istoodqsmmi8gdn0dtnq.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664239/orwzca5nghxuaftdcm0s.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664241/pzaobifwdlbmbxm4njn1.jpg', NULL, 'ghjhjghj', 'hjhgjhj', '2025-07-06', 'online', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664713/splymb5xvndjmemski7w.jpg', '454', 'Pending', 41.00, 'Cash', '2025-07-15', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752664793/chsym7mo44arnjuwnj1k.jpg', 'Paid', '2025-07-17 11:27:00', 'coom', 'Scheduled', '5656', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752665393/tspoz1vzhb5puxmvira9.jpg', 'Accepted', 'dsd', 'dsdsds', '2025-07-29', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752666248/egslqwhx2ds3zdhwwt4q.jpg', '2025-07-24', 'sdds', 'Pending', 43545.00, '2025-07-18', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1752666249/ckdu9eboy61tuayudcke.jpg', 'Pending', 'dfdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-15 13:09:31'),
(12, 78, 'arun', 'arunbadode08@gmail.com', '09174248186', '2008-06-19', 'dwd', 'sfsf', 'sefs', 'sfs', '2025-07-13', 'sfs', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100444/oq04hhj3grrnalovobnx.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100446/rsdxqkqbkd5almqxdjk6.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100448/fhv2a2afprhosepfytv6.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100450/fhpezmzvbzi4mgzsfa1n.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100453/omvoam9whbydt8yyfkq9.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100455/fxdsdbjnwukodeiwhjgl.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100457/jcrltmsjulef2smj8amd.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100460/kcde2q7ifulkikulmx7p.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100462/xpd4imuvra2shsagev5x.jpg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100464/mnkmz5fd5gsnpoonq7bs.jpg', NULL, 'sS', 's', '2025-07-11', 's', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100771/ymjmzlwo2jyqbkdupfgt.jpg', 'as', 'Submitted', 34.00, 'Online', '2025-07-13', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753100854/kdmqswiatflmzipgetkr.jpg', 'Partial', '2025-07-21 03:32:00', 'f6tgh', 'Completed', 'erge', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753101254/qb2sjqs87pddfuiipfwt.jpg', '2025-07-19', 'drgdgg', 'Received', 5252.00, '2025-07-19', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753101257/iuvo1px8jhsgadpttpde.jpg', 'Paid', 'sedgsgsdg', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753101260/zbenhfekrhb4eosn9meg.jpg', '2025-07-30', 'Pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'dwdw', '2025-08-01 12:41:00', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753101391/lf8xbsvr8is6otujdh06.jpg', 'Scheduled', '2025-07-16', 'adad', 'Rejected', 'ada', 'ada', 'Rejected', '2025-07-21', 'https://res.cloudinary.com/dkqcqrrbp/image/upload/v1753101473/wlda3gdqohuoxoaw7can.jpg', 'qweqwe', 'Approved', '2025-07-20 03:20:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admission_decisions`
--
ALTER TABLE `admission_decisions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
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
-- Indexes for table `follow_upsnew`
--
ALTER TABLE `follow_upsnew`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inquiry_images`
--
ALTER TABLE `inquiry_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `remainder`
--
ALTER TABLE `remainder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentapplicationprocess`
--
ALTER TABLE `studentapplicationprocess`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_fees`
--
ALTER TABLE `student_fees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_fees_by_counselor`
--
ALTER TABLE `student_fees_by_counselor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_invoice`
--
ALTER TABLE `student_invoice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testing`
--
ALTER TABLE `testing`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visa_process`
--
ALTER TABLE `visa_process`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admission_decisions`
--
ALTER TABLE `admission_decisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `follow_ups`
--
ALTER TABLE `follow_ups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `follow_upsnew`
--
ALTER TABLE `follow_upsnew`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `inquiry_images`
--
ALTER TABLE `inquiry_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `remainder`
--
ALTER TABLE `remainder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `studentapplicationprocess`
--
ALTER TABLE `studentapplicationprocess`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `student_fees`
--
ALTER TABLE `student_fees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_fees_by_counselor`
--
ALTER TABLE `student_fees_by_counselor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `student_invoice`
--
ALTER TABLE `student_invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `testing`
--
ALTER TABLE `testing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `visa_process`
--
ALTER TABLE `visa_process`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
