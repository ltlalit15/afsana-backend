-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2025 at 08:33 AM
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
-- Database: `rehan`
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
(11, 1, 20, 12, 'accepted', '2025-05-15', '2025-05-09 06:42:22'),
(14, 1, 28, 12, 'rejected', '2025-05-22', '2025-05-12 13:39:01');

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
(1, 1, '+1234567890', 12, 'active', '2025-05-05 18:45:31', '2025-05-06 12:03:33'),
(2, 1, '+1234567890', 12, 'active', '2025-05-05 19:09:11', '2025-05-05 19:36:24'),
(7, 1, '123456', 11, 'active', '2025-05-06 11:32:56', '2025-05-06 11:32:56'),
(8, 4555, '07302161400', 12, 'active', '2025-05-06 11:45:19', '2025-05-06 11:45:19'),
(12, 1, '325677888675', 12, 'active', '2025-05-08 06:53:23', '2025-05-12 05:53:57'),
(13, 1, '01757587455', 12, 'active', '2025-05-10 02:59:35', '2025-05-10 02:59:35'),
(14, 1, '+880 1886-144256', 20, 'active', '2025-05-11 06:03:13', '2025-05-11 06:03:13'),
(16, 1, '9876543', 12, 'active', '2025-05-12 11:30:47', '2025-05-12 13:44:59'),
(17, 1, '12345567', 23, 'active', '2025-05-22 00:56:00', '2025-05-22 00:56:00');

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

--
-- Dumping data for table `follow_ups`
--

INSERT INTO `follow_ups` (`id`, `name`, `title`, `follow_up_date`, `status`, `urgency_level`, `department`, `created_at`, `user_id`) VALUES
(10, 'demo', 'demo', '2025-05-09', 'New', 'Email', 'Developer', '2025-05-12 08:07:46', 1),
(11, 'demo', 'for testing', '2025-05-30', 'In Progress', 'Email', '1eerere', '2025-05-22 07:51:53', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `id` int(11) NOT NULL,
  `counselor_id` int(11) DEFAULT NULL,
  `inquiry_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `branch` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0',
  `is_view` varchar(255) NOT NULL DEFAULT '0',
  `lead_status` varchar(255) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_of_inquiry` date DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `present_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `education_background` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `english_proficiency` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job_duration` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `preferred_countries` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `assignment_description` text NOT NULL
) ;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`id`, `counselor_id`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `status`, `is_view`, `lead_status`, `payment_status`, `city`, `date_of_inquiry`, `address`, `present_address`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `created_at`, `updated_at`, `assignment_description`) VALUES
(23, 16, 'studentVisa', 'Whatsapp', 'dhaka', 'md miah', '01757587455', 'jubeddeutschland@gmail.com', 'mba', 'Bangladesh', '1', '0', 'Dropped', 'paid', 'Hobiganj', '2025-05-10', 'Takbaz khany, Adarsha Bazar', '3 ESQ', '[\"Bachelor\"]', '[\"Writing\"]', 'Studyfirstinfo', 'no', 'no', '[\"Germany\"]', '2025-05-09 18:33:34', '2025-06-06 11:13:00', ''),
(26, 2, 'studentVisa', 'Facebook', 'Dhaka', 'demo demo', '867677665', 'demo@gmail.com', 'Maths', 'India', '0', '1', '', '', 'Inodre', '2025-05-14', 'Bhopal', '123 Street, NY', '[\"Masters\"]', '[\"Speaking\"]', 'demo', 'frontend', '5', '[\"USA\"]', '2025-05-12 08:07:06', '2025-06-06 08:22:40', ''),
(30, 16, 'studentVisa', 'Facebook', 'Dhaka', 'raju', '07302161400', 'raju@gmail.com', 'Maths', 'India', '0', '1', 'Converted', '', 'indore', '2025-06-10', 'Indore', 'Gopal gram', '[\"SSC\",\"HSC\"]', '[\"Reading\"]', 'kiaan', 'sdsd', '40 minutes', '[\"Germany\"]', '2025-06-05 12:11:55', '2025-06-06 11:17:50', ''),
(31, 16, 'touristVisa', 'Facebook', 'Dhaka', 'muskan', '67676767', 'muskan@gmail.com', 'Maths', 'India', '1', '1', '', 'paid', 'indore', '2025-06-17', 'Indore', 'Gopal gram', '[\"SSC\",\"HSC\"]', '[\"Reading\",\"Writing\"]', 'kiaan', 'sdsd', '120-minut', '[\"Germany\"]', '2025-06-05 12:31:09', '2025-06-06 09:37:04', '');

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

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `name`, `email`, `phone`, `counselor`, `follow_up_date`, `source`, `status`, `preferred_countries`, `notes`, `user_id`, `created_at`, `updated_at`) VALUES
(20, 'Jhon Doe', 'john@example.com', '9876543210', 2, '2025-05-10', 'Website', 'New', 'United States', 'demo', 1, '2025-05-12 04:09:29', '2025-06-04 13:23:28'),
(21, 'demo demo', 'demo11@gmail.com', '867677665', 1, '2025-05-16', 'Office Visit', 'Converted', 'India', 'demo', 1, '2025-05-12 04:09:52', '2025-06-04 13:23:23'),
(22, 'student01', 'jubimax1993@gmail.com', '12345678', 14, '2025-05-22', 'Phone Call', 'Contected', 'Portugal', 'please talk to him ', 1, '2025-05-21 17:39:24', '2025-06-04 13:22:27'),
(23, 'demo', 'demo@gmail.com', 'demo', 14, '2025-05-28', 'Office Visit', 'New', 'India', 'for testing', 1, '2025-05-22 07:52:42', '2025-06-04 13:23:07'),
(24, 'krishna', 'kiaan@gmail.com', '07302161400', 8, '2025-05-14', 'Office Visit', 'Completed', 'India', 'for testing', 1, '2025-05-23 01:07:44', '2025-05-23 01:07:44'),
(25, 'demo', 'kiaan@gmail.com', '07302161400', 16, '2025-05-21', 'Office Visit', 'New', 'India', 'goooo', 1, '2025-05-23 01:22:38', '2025-06-04 13:23:33');

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

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `chatId`, `sender_id`, `receiver_id`, `message`, `timestamp`, `status`) VALUES
(184, '1_51', 51, 1, 'hii', '2025-05-22 13:25:18', 'delivered'),
(185, '1_51', 51, 1, 'how are you', '2025-05-22 13:26:07', 'delivered'),
(186, '1_51', 1, 51, 'i am fine', '2025-05-22 13:26:16', 'delivered'),
(187, '1_51', 51, 1, 'hii admin', '2025-05-23 10:01:22', 'delivered'),
(188, '1_51', 51, 1, 'hello admin', '2025-05-23 10:12:06', 'delivered'),
(189, '1_51', 1, 51, 'hello student', '2025-05-23 10:12:28', 'delivered'),
(190, '1_51', 51, 1, 'hey admin', '2025-05-23 10:25:10', 'delivered'),
(191, '1_51', 1, 51, 'hey', '2025-05-23 10:25:32', 'delivered'),
(192, '1_51', 51, 1, 'hii', '2025-05-23 10:29:53', 'delivered'),
(193, '1_51', 1, 51, 'hii student', '2025-05-23 10:30:11', 'delivered');

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
  `file` text DEFAULT NULL,
  `assistant` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `branch`, `name`, `whatsapp`, `email`, `group_name`, `university`, `university_other`, `country`, `country_other`, `payment_method`, `payment_method_other`, `payment_type`, `payment_type_other`, `file`, `assistant`, `note`, `created_at`, `updated_at`) VALUES
(29, 8, '35', '545454545645', 'krishnarajputkiaan@gmail.com', 'dhaka', 22, NULL, 'Netherlands', NULL, 'Bank Transfer', NULL, 'Application Fee', NULL, '/uploads/1749119515706-425744752-Invoice_undefined_1749119088040.pdf', 'krishna', 'this payment', '2025-06-05 10:31:55', '2025-06-05 10:31:55');

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
(1, 'student', 'Dashboard', 1, 1, 1, 0, 1, '2025-05-06 07:18:14', '2025-05-21 17:54:26'),
(2, 'student', 'Student Details', 1, 1, 1, 0, 1, '2025-05-06 07:19:05', '2025-05-21 17:54:27'),
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
(16, 'counselor', 'Course & University', 1, 1, 1, 0, 1, '2025-05-06 07:30:59', '2025-05-21 17:54:08');

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
(13, 58, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `studentapplicationprocess`
--

CREATE TABLE `studentapplicationprocess` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
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
  `flight_booking_confirmed` tinyint(1) DEFAULT NULL,
  `online_enrollment_completed` tinyint(1) DEFAULT NULL,
  `accommodation_confirmation` tinyint(1) DEFAULT NULL,
  `arrival_country` varchar(255) DEFAULT NULL,
  `university_id` int(11) NOT NULL,
  `Application_stage` tinyint(1) DEFAULT NULL,
  `Interview` tinyint(1) DEFAULT NULL,
  `Visa_process` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `studentapplicationprocess`
--

INSERT INTO `studentapplicationprocess` (`id`, `student_id`, `registration_fee_payment`, `registration_date`, `application_submission_date`, `application_fee_payment`, `fee_confirmation_document`, `university_interview_date`, `university_interview_outcome`, `conditional_offer_letter`, `invoice_with_conditional_offer`, `tuition_fee_transfer_proof`, `final_university_offer_letter`, `offer_letter_service_charge_paid`, `university_offer_letter_received`, `appendix_form_completed`, `passport_copy_prepared`, `email_sent_for_documentation`, `appointment_date`, `financial_support_declaration`, `final_offer_letter`, `proof_of_relationship`, `english_language_proof`, `visa_interview_date`, `residence_permit_form`, `proof_of_income`, `airplane_ticket_booking`, `police_clearance_certificate`, `europass_cv`, `birth_certificate`, `bank_statement`, `accommodation_proof`, `motivation_letter`, `previous_studies_certificates`, `travel_insurance`, `european_photo`, `health_insurance`, `visa_decision`, `visa_service_charge_paid`, `flight_booking_confirmed`, `online_enrollment_completed`, `accommodation_confirmation`, `arrival_country`, `university_id`, `Application_stage`, `Interview`, `Visa_process`, `status`) VALUES
(44, 35, 'Paid', '2025-05-23', '2025-05-23', 'Paid', '/uploads/1747901696596-166403185-Profile (1).png', '2025-05-23', 'Accepted', '/uploads/1747904926081-845585830-vedic-maths-lesson1 (3).pdf', '/uploads/1747904926081-174898966-vedic-maths-lesson1 (2).pdf', '/uploads/1747904926081-519375138-Phonics Assessment.pdf', '/uploads/1747904969109-742039206-Create_New_Payment_Form.pdf', 'Paid', '2025-05-23', '/uploads/1747905419340-777807865-Create_New_Payment_Form.pdf', '/uploads/1747905419341-88135770-Create_New_Payment_Form.pdf', '2025-05-23', '2025-05-23', '/uploads/1747905419341-339449230-Create_New_Payment_Form.pdf', '/uploads/1747905419418-747487545-SAMA Paper Pattern 2025.pdf', '/uploads/1747905420333-385419434-SAMA Paper Pattern 2025.pdf', '/uploads/1747905420498-773092520-worksheet (1).pdf', '2025-05-23', '/uploads/1747905420498-978648468-Create_New_Payment_Form.pdf', '/uploads/1747905420498-316009931-Create_New_Payment_Form.pdf', '/uploads/1747905420498-460501060-worksheet.pdf', '/uploads/1747905420499-916418649-Courses.pdf', '/uploads/1747905420515-366294713-Create_New_Payment_Form.pdf', '/uploads/1747905420515-802744803-Screenshot 2025-05-16 123950.png', '/uploads/1747905420677-477131489-Create_New_Payment_Form.pdf', '/uploads/1747905420516-347004507-1000048151 (1).jpg', '/uploads/1747905420534-236084063-1000048151.jpg', '/uploads/1747905420549-854200571-1000048151 (1).jpg', '/uploads/1747905420663-36291472-Courses.pdf', '/uploads/1747905420674-740318472-smart-life-academy-logo.jpg', '/uploads/1747905420673-756894716-BODY-1249021@1x (2).png', 'Approved', 'Pending', 1, 1, 1, 'india', 17, 1, 1, 1, 0),
(45, 35, 'Paid', '2025-05-14', '2025-05-15', 'Paid', '/uploads/1747995016613-499990235-Rituu.exp.pdf', '2025-05-24', 'Accepted', '/uploads/1747995106034-758753662-Rituu.exp.pdf', '/uploads/1747995106531-248863519-Rituu.exp.pdf', '/uploads/1747995106697-921297203-Rituu.exp.pdf', '/uploads/1747995106711-758695494-Rituu.exp.pdf', 'Paid', '2025-05-28', 'null', '/uploads/1747995106862-974163510-WhatsApp Image 2025-05-22 at 4.40.56 PM.jpeg', '2025-05-24', '2025-05-24', '/uploads/1747995107062-703775830-Rituu.exp.pdf', 'null', 'null', 'null', NULL, 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 0, 0, 0, 'null', 12, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `father_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `admission_no` varchar(255) NOT NULL,
  `id_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `father_name`, `admission_no`, `id_no`, `mobile_number`, `university_id`, `date_of_birth`, `gender`, `category`, `address`, `photo`, `documents`, `created_at`, `updated_at`) VALUES
(35, 1, 'newfather01', '', '01', '01111111', 24, '1999-02-03', 'Male', 'General', 'Rua Serpa Pinto 7  3 ESQ', '/uploads/1747876147274-16562491-aaa.png', '/uploads/1747876147368-706505454-Bank Statement ( Md.Rajyan).pdf', '2025-05-22 01:09:08', '2025-05-22 01:09:08'),
(36, 54, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-04 16:43:22', '2025-06-04 16:43:22'),
(37, 0, '', '', '', '', 0, '0000-00-00', '', '', '', '', '', '2025-06-04 17:05:39', '2025-06-04 17:05:39'),
(46, 0, '', '', '', '', 0, '0000-00-00', '', '', '', '', '', '2025-06-05 17:56:37', '2025-06-05 17:56:37'),
(47, 0, '', '', '', '', 0, '0000-00-00', '', '', '', '', '', '2025-06-05 17:58:58', '2025-06-05 17:58:58');

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

--
-- Dumping data for table `student_fees`
--

INSERT INTO `student_fees` (`id`, `student_name`, `description`, `amount`, `status`, `fee_date`) VALUES
(1, 'Ariana Smith', 'Monthly tuition fee for May', '1200', 'Paid', '2025-05-01');

-- --------------------------------------------------------

--
-- Table structure for table `student_fees_by_counselor`
--

CREATE TABLE `student_fees_by_counselor` (
  `id` int(11) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `is_view` varchar(255) NOT NULL DEFAULT '0',
  `lesd_status` varchar(255) NOT NULL,
  `fee_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_fees_by_counselor`
--

INSERT INTO `student_fees_by_counselor` (`id`, `student_name`, `description`, `amount`, `status`, `is_view`, `lesd_status`, `fee_date`, `created_at`, `updated_at`) VALUES
(1, 'demo', 'sdsdsd', 100.00, 'Unpaid', '', '', '2025-06-19', '2025-06-05 08:06:58', '2025-06-06 07:15:04'),
(2, 'muskan', 'dfdfdfdf', 200.00, '', '', '', '2025-06-19', '2025-06-06 06:55:16', '2025-06-06 06:55:16'),
(3, 'md miah', 'testing data', 220.00, NULL, '0', '', '2025-06-23', '2025-06-06 07:14:17', '2025-06-06 11:12:49'),
(4, 'md miah', 'dfdfdf', 44.88, NULL, '0', '', '2025-06-20', '2025-06-06 08:24:48', '2025-06-06 08:24:48'),
(5, 'John Doe', 'Tuition Fee for June', 15000.00, 'Paid', '0', '', '2025-06-06', '2025-06-06 09:26:39', '2025-06-06 09:26:39'),
(6, 'muskan', 'demo data', 4360.00, NULL, '0', '', '2025-06-12', '2025-06-06 09:31:36', '2025-06-06 09:31:36'),
(7, 'muskan', 'demo', 408.00, NULL, '0', '', '2025-06-26', '2025-06-06 09:37:04', '2025-06-06 09:37:04'),
(9, 'Rahul Sharma', 'First installment fee', 15000.00, 'Pending', '0', '', '2025-06-06', '2025-06-06 11:04:06', '2025-06-06 11:04:34'),
(10, 'raju', '6656565', 204.00, NULL, '0', '', '2025-06-25', '2025-06-06 11:07:43', '2025-06-06 11:07:43'),
(11, 'raju', 'demo data', 330.00, NULL, '0', '', '2025-06-13', '2025-06-06 11:17:50', '2025-06-06 11:17:50');

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
(1, '300', '300', '600', 'sddzxz', '35', '2025-06-26', '2025-06-05 10:14:46', '2025-06-05 10:18:33'),
(2, '300', '30', '330', 'adsdsdsds', '', '2025-06-12', '2025-06-05 10:17:24', '2025-06-05 10:17:24'),
(3, '309', '6.18', '315.18', 'dgddgdgd', '', '2025-06-16', '2025-06-05 10:24:47', '2025-06-05 10:24:47'),
(4, '3002', '90.06', '3092.06', 'fdfdfdfd', '35', '2025-06-24', '2025-06-05 10:33:05', '2025-06-05 10:33:05');

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

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `user_id`, `due_date`, `counselor_id`, `student_id`, `description`, `priority`, `status`, `related_to`, `related_item`, `assigned_to`, `assigned_date`, `finishing_date`, `attachment`, `created_at`, `updated_at`, `notes`, `image`) VALUES
(58, 'student record', NULL, '2025-05-23', 16, 35, 'demo', 'High', 'pending', 'Visa', 'demo', 'demo', '2025-05-23', '2025-05-23', 'C:\\fakepath\\letter-sounds_alphabet.png', '2025-05-22 10:30:59', '2025-05-22 13:29:57', '', '/uploads/1747920595918-151279316-9812ae0f978da1e830bcca33dac5ec7e2ff9f404.jpg'),
(59, 'demo', NULL, '2025-05-26', 16, 35, 'ffgfgfgf', 'Medium', 'Completed', 'Application', 'fgfgf', 'fgfgf', '2025-06-05', '2025-05-27', 'C:\\fakepath\\WhatsApp Image 2025-05-23 at 2.54.15 PM.jpeg', '2025-05-23 10:14:09', '2025-05-23 10:14:09', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `logo_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `programs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `highlights` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`id`, `user_id`, `name`, `logo_url`, `location`, `programs`, `highlights`, `contact_phone`, `contact_email`, `created_at`, `updated_at`) VALUES
(12, 1, 'Gyan Sagar ', '/uploads/1746442628489-144683235-smart-life-academy-logo.jpg', 'indore', '[\"fedfdfdf\"]', '[\"hfhfhfh\"]', '07302161400', 'krishnarajputkiaan@gmail.com', '2025-05-05 16:27:08', '2025-05-05 17:26:56'),
(17, 1, 'Delhi University', '/uploads/1746539482209-958921538-logo.jpg', 'Delhi, India', '[\"Arts, Commerce, Science\",\"Business, AI, Computer Science\"]', '[\"Largest public university in India\",\"Japan\'s top-ranked university\"]', '46546656', 'info@u-tokyo.ac.jp', '2025-05-06 13:51:21', '2025-05-06 13:51:21'),
(18, 1, 'Oxford, United Kingdom', '/uploads/1746771567018-650254915-pngtree-graduation-season-doctor-hat-globe-school-green-plant-vector-image_2300931-removebg-preview.png', '49, indore mp', '[\"Humanities, Law, Philosophy\",\"Engineering, Data Science, Medicine\"]', '[\"One of the oldest universities in the world\",\"Ranked consistently in global top 5 universities\"]', '📞 0044 1865 270000', 'info@oxgmail.com', '2025-05-09 06:19:27', '2025-05-09 06:19:27'),
(20, 1, 'Budapest Metropolitan University ', '/uploads/1746943295541-971691652-budapest-metropolitan-university-budapest-hungary.jpg', 'budapest', NULL, NULL, '+880 9613-752752', 'info@stuyfirstinfo.com', '2025-05-11 06:01:35', '2025-05-11 06:01:35'),
(21, 1, 'Gyor University', '/uploads/1747120642271-143442955-wC4KFGDB_400x400[1].jpg', 'University in Győr, Hungary', NULL, NULL, '+36 96 503 400', 'lukacs.eszter@sze.hu', '2025-05-13 07:17:22', '2025-05-13 07:17:22'),
(22, 1, 'Wekerle Business School', '/uploads/1747120858055-752979428-160561_52315698_1218299558323083_4847638838631202816_n[1].png', 'Budapest, Jázmin u. 10, 1083 Hungary', NULL, NULL, '+36 1 50 174 50', 'international@wsuf.hu', '2025-05-13 07:20:58', '2025-05-13 07:20:58'),
(23, 1, 'University of Debrecen', '/uploads/1747121291692-486528945-images[1]', 'Debrecen, Egyetem tér 1, 4032 Hungary', NULL, NULL, '30,418 (2011)', 'info@edu.unideb.hu', '2025-05-13 07:28:11', '2025-05-13 07:28:11'),
(24, 1, 'Pecs University Hungary', '/uploads/1747121716692-886939212-images[1]', 'Pécs, 48-as tér 1, 7622 Hungary', NULL, NULL, '+36 72 501 599', 'international@pte.hu', '2025-05-13 07:35:16', '2025-05-13 07:35:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `student_id` int(11) DEFAULT NULL,
  `counselor_id` int(11) DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`, `full_name`, `user_id`, `created_at`, `updated_at`, `student_id`, `counselor_id`, `address`, `phone`) VALUES
(1, 'admin@example.com', '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'admin', 'Alice Admin', NULL, '2025-05-02 03:51:38', '2025-05-08 07:07:59', NULL, NULL, '160/13 west esten manchester, USA', '7865065089'),
(18, 'john.doe@example.com', '$2b$10$uv/TyRx.CmHtwaIyqBCE7.n.YFmbcBpZXehFXqvpW.CJA5RTcfDEm', 'counselor', 'John Doe123', 1, '2025-05-05 07:45:31', '2025-05-06 01:03:33', NULL, 1, NULL, NULL),
(22, 'john.dofde@example.com', '$2b$10$NBgj9OGbgZEJI3u8ZedQk.QW/abQ95J77F8Raauaq0217VclKsvTi', 'counselor', 'John Doe', 1, '2025-05-05 08:09:11', '2025-05-05 08:09:11', NULL, 2, NULL, NULL),
(25, 'sohan@gmail.com', '$2b$10$mTeLlgcLzkNgjw2UqxkHyeQij4JiQJPUeaz6ZYHiwLFqDNgtmp6fi', 'counselor', 'sohan', 888, '2025-05-05 08:26:47', '2025-05-05 08:26:47', NULL, 4, NULL, NULL),
(26, 'ankit@gmail.com', '$2b$10$GpJuJPLgnU1nmTzLD2g5RedVcIj79MHvMUflmGtOYNu/gzPb/IPJm', 'counselor', 'ankit', 7788, '2025-05-05 08:38:32', '2025-05-05 08:38:32', NULL, 5, NULL, NULL),
(27, 'admin@gmai.com', '$2b$10$S9.t8G8mNvjFNPPXiJJsLusokXClG7vYQuXkesBpWbDeKCGdDPf0K', 'counselor', 'ggfd', 1, '2025-05-05 08:43:06', '2025-05-05 08:43:06', NULL, 6, NULL, NULL),
(28, 'rohan@gmail.com', '$2b$10$Ozm/VWBEN.Q1Fy.h4zptyOpkCMGWKZuA7d/6k105WISNOMWMRLtKW', 'counselor', 'rohan', 1, '2025-05-06 00:32:56', '2025-05-06 00:32:56', NULL, 7, NULL, NULL),
(29, 'kiaan@gmail.com', '$2b$10$lF7o5hf6jbBUEq1D3yJHj.sHBlKjfDsP8blsrS1DxAhUFLUflix9a', 'counselor', 'krishna', 4555, '2025-05-06 00:45:19', '2025-05-07 07:26:18', NULL, 8, NULL, NULL),
(35, 'pooja@example.com', '$2b$10$8rXEadO0bo0dkTNWZGGtjeVAe6sdDkSSXGJzCk/LLHFBGXpaQYN4S', 'counselor', 'Pooja', 1, '2025-05-08 01:23:23', '2025-05-12 00:25:48', NULL, 12, NULL, NULL),
(37, 'jubed@example.com', '$2b$10$jVaeLn8YeedDVTQPNpT6.OHHJrgTiEWqYDiVYLDwoydgkj5jmOVte', 'counselor', 'jubed', 1, '2025-05-09 21:29:35', '2025-05-09 21:29:35', NULL, 13, NULL, NULL),
(41, 'kaniz@studyfirstinfo.com', '$2b$10$qm9EPxJcWAf/X0QJDvWDxekLcSKwL0IYWHFG3FVF3WAMAgGoN2Qoi', 'counselor', 'kaniz', 1, '2025-05-11 00:33:13', '2025-05-11 00:33:13', NULL, 14, NULL, NULL),
(45, 'Counselor@example.com', '$2b$10$Myi4DXoecZWXfct60wq64eP8pGG/KzIylRNpb7kghh0tIDMMPBgsi', 'counselor', 'Counselor', 1, '2025-05-12 06:00:47', '2025-05-12 06:00:47', NULL, 16, NULL, NULL),
(50, 'sumi@gmail.com', '$2b$10$Ey/rWb7Mah7wn6LjTDqUMem72fin4vcK5CllnbmOJIXKVVyAdNyeC', 'counselor', 'sumi', 1, '2025-05-21 19:26:00', '2025-05-21 19:26:00', NULL, 17, NULL, NULL),
(51, 'newstudent01@gmail.com', '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'student', 'newstudent 01', 1, '2025-05-21 19:39:08', '2025-05-22 02:42:33', 35, NULL, NULL, NULL),
(52, 'vishal@example.com', '$2b$10$ruvrwn0M.uads0MsNdCkHedf4YBOT65v5pXw2vT2X2Z1uibAkmtHW', 'student', 'vishal ', NULL, '2025-06-04 06:31:15', '2025-06-04 06:31:15', NULL, NULL, NULL, NULL),
(53, 'vishaltest@example.com', '$2b$10$KMlOcmkmwSevhVMnIlXI/ubxe6tyuH3pGosONc5cEojdWqLKmXbom', 'student', 'vishal ', NULL, '2025-06-04 06:32:14', '2025-06-04 06:32:14', NULL, NULL, NULL, NULL),
(54, 'rehan@gmail.com', '$2b$10$FhVw.KpA8lSSLOviVT6C0.FTZLrYv.xiIYU8Kw4aKHK3PlKiOo6tS', 'student', 'rehana', NULL, '2025-06-04 11:13:22', '2025-06-04 11:13:22', NULL, NULL, NULL, NULL),
(55, 'naresh', '$2b$10$lDltW35zrCarUub4QC0NieaVIok5QsSw98JeS2Yt.cy6IO/BvSu3a', 'student', 'naresh yadav', 0, '2025-06-04 11:35:39', '2025-06-04 11:35:39', 37, NULL, NULL, NULL),
(56, 'shiv@gmail.com', '$2b$10$qfYptGwYvBqODN4DnwdstePvgW2OsDz7RtogIQl3bnn5FqfPZXsnq', 'student', 'shiv', 0, '2025-06-05 12:26:37', '2025-06-05 12:26:37', 46, NULL, NULL, NULL),
(57, 'muskan@gmail.com', '$2a$12$5C.1lZWEjJ.6vyHpkVLdt.qb.8SqH8UgVl1DEVIoh7yB0M2/Rcr4G', 'student', 'muskan', 0, '2025-06-05 12:28:58', '2025-06-06 10:00:42', 47, NULL, NULL, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `follow_ups`
--
ALTER TABLE `follow_ups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `remainder`
--
ALTER TABLE `remainder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `studentapplicationprocess`
--
ALTER TABLE `studentapplicationprocess`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `student_fees`
--
ALTER TABLE `student_fees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_fees_by_counselor`
--
ALTER TABLE `student_fees_by_counselor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `student_invoice`
--
ALTER TABLE `student_invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
