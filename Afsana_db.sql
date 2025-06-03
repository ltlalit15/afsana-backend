/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `admission_decisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `student_id` int NOT NULL,
  `university_id` int NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'Pending',
  `decision_date` date NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `branches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(255) NOT NULL,
  `branch_address` text NOT NULL,
  `branch_phone` varchar(20) NOT NULL,
  `branch_email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `counselors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `university_id` int DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `follow_ups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `follow_up_date` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `urgency_level` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `department` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `inquiries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `counselor_id` int DEFAULT NULL,
  `inquiry_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `branch` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `course_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_of_inquiry` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `present_address` text COLLATE utf8mb4_general_ci,
  `education_background` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `english_proficiency` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `company_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job_title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `job_duration` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `preferred_countries` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `inquiries_chk_1` CHECK (json_valid(`education_background`)),
  CONSTRAINT `inquiries_chk_2` CHECK (json_valid(`english_proficiency`)),
  CONSTRAINT `inquiries_chk_3` CHECK (json_valid(`preferred_countries`))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `leads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `counselor` int DEFAULT NULL,
  `follow_up_date` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `preferred_countries` text COLLATE utf8mb4_general_ci,
  `notes` text COLLATE utf8mb4_general_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chatId` varchar(100) NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `message` text NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('sent','delivered') NOT NULL DEFAULT 'sent',
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `whatsapp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  `university` int DEFAULT NULL,
  `university_other` varchar(255) DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_other` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_method_other` varchar(255) DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_type_other` varchar(255) DEFAULT NULL,
  `file` text,
  `assistant` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `view_permission` tinyint(1) DEFAULT '0',
  `add_permission` tinyint(1) DEFAULT '0',
  `edit_permission` tinyint(1) DEFAULT '0',
  `delete_permission` tinyint(1) DEFAULT '0',
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `remainder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `student_fees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_name` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `amount` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `fee_date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `StudentApplicationProcess` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `registration_fee_payment` varchar(255) DEFAULT NULL,
  `registration_date` text,
  `application_submission_date` text,
  `application_fee_payment` varchar(255) DEFAULT NULL,
  `fee_confirmation_document` text,
  `university_interview_date` text,
  `university_interview_outcome` varchar(255) DEFAULT NULL,
  `conditional_offer_letter` text,
  `invoice_with_conditional_offer` text,
  `tuition_fee_transfer_proof` text,
  `final_university_offer_letter` text,
  `offer_letter_service_charge_paid` varchar(255) DEFAULT NULL,
  `university_offer_letter_received` text,
  `appendix_form_completed` longtext,
  `passport_copy_prepared` longtext,
  `email_sent_for_documentation` text,
  `appointment_date` text,
  `financial_support_declaration` text,
  `final_offer_letter` text,
  `proof_of_relationship` text,
  `english_language_proof` text,
  `visa_interview_date` text,
  `residence_permit_form` text,
  `proof_of_income` text,
  `airplane_ticket_booking` text,
  `police_clearance_certificate` text,
  `europass_cv` text,
  `birth_certificate` text,
  `bank_statement` text,
  `accommodation_proof` text,
  `motivation_letter` text,
  `previous_studies_certificates` text,
  `travel_insurance` text,
  `european_photo` text,
  `health_insurance` text,
  `visa_decision` varchar(255) DEFAULT NULL,
  `visa_service_charge_paid` varchar(255) DEFAULT NULL,
  `flight_booking_confirmed` tinyint(1) DEFAULT NULL,
  `online_enrollment_completed` tinyint(1) DEFAULT NULL,
  `accommodation_confirmation` tinyint(1) DEFAULT NULL,
  `arrival_country` varchar(255) DEFAULT NULL,
  `university_id` int NOT NULL,
  `Application_stage` tinyint(1) DEFAULT NULL,
  `Interview` tinyint(1) DEFAULT NULL,
  `Visa_process` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `father_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `admission_no` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_no` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `university_id` int DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `photo` longtext COLLATE utf8mb4_general_ci,
  `documents` longtext COLLATE utf8mb4_general_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admission_no` (`admission_no`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `due_date` date NOT NULL,
  `counselor_id` int NOT NULL,
  `student_id` int NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `priority` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `related_to` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `related_item` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `assigned_to` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `assigned_date` date NOT NULL,
  `finishing_date` date NOT NULL,
  `attachment` longtext COLLATE utf8mb4_general_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` text COLLATE utf8mb4_general_ci,
  `image` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `universities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `logo_url` text COLLATE utf8mb4_general_ci,
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `programs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `highlights` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `contact_phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `universities_chk_1` CHECK (json_valid(`programs`)),
  CONSTRAINT `universities_chk_2` CHECK (json_valid(`highlights`))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `student_id` int DEFAULT NULL,
  `counselor_id` int DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `admission_decisions` (`id`, `user_id`, `student_id`, `university_id`, `status`, `decision_date`, `created_at`) VALUES
(11, 1, 20, 12, 'accepted', '2025-05-15', '2025-05-09 06:42:22');
INSERT INTO `admission_decisions` (`id`, `user_id`, `student_id`, `university_id`, `status`, `decision_date`, `created_at`) VALUES
(14, 1, 28, 12, 'rejected', '2025-05-22', '2025-05-12 13:39:01');


INSERT INTO `branches` (`id`, `branch_name`, `branch_address`, `branch_phone`, `branch_email`, `created_at`, `updated_at`) VALUES
(8, 'Dhaka', 'Indore', '07302161400', 'dhaka@gmail.com', '2025-05-08 09:29:27', '2025-05-10 10:20:59');
INSERT INTO `branches` (`id`, `branch_name`, `branch_address`, `branch_phone`, `branch_email`, `created_at`, `updated_at`) VALUES
(23, 'Sylhet', 'Sylhet@gmail.com', '123456768', 'Sylhet@gmail.com', '2025-05-10 07:50:40', '2025-05-10 07:50:40');


INSERT INTO `counselors` (`id`, `user_id`, `phone`, `university_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '+1234567890', 12, 'active', '2025-05-05 18:45:31', '2025-05-06 12:03:33');
INSERT INTO `counselors` (`id`, `user_id`, `phone`, `university_id`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, '+1234567890', 12, 'active', '2025-05-05 19:09:11', '2025-05-05 19:36:24');
INSERT INTO `counselors` (`id`, `user_id`, `phone`, `university_id`, `status`, `created_at`, `updated_at`) VALUES
(7, 1, '123456', 11, 'active', '2025-05-06 11:32:56', '2025-05-06 11:32:56');
INSERT INTO `counselors` (`id`, `user_id`, `phone`, `university_id`, `status`, `created_at`, `updated_at`) VALUES
(8, 4555, '07302161400', 12, 'active', '2025-05-06 11:45:19', '2025-05-06 11:45:19'),
(12, 1, '325677888675', 12, 'active', '2025-05-08 06:53:23', '2025-05-12 05:53:57'),
(13, 1, '01757587455', 12, 'active', '2025-05-10 02:59:35', '2025-05-10 02:59:35'),
(14, 1, '+880 1886-144256', 20, 'active', '2025-05-11 06:03:13', '2025-05-11 06:03:13'),
(16, 1, '9876543', 12, 'active', '2025-05-12 11:30:47', '2025-05-12 13:44:59'),
(17, 1, '12345567', 23, 'active', '2025-05-22 00:56:00', '2025-05-22 00:56:00');

INSERT INTO `follow_ups` (`id`, `name`, `title`, `follow_up_date`, `status`, `urgency_level`, `department`, `created_at`, `user_id`) VALUES
(10, 'demo', 'demo', '2025-05-09', 'New', 'Email', 'Developer', '2025-05-12 13:37:46', 1);
INSERT INTO `follow_ups` (`id`, `name`, `title`, `follow_up_date`, `status`, `urgency_level`, `department`, `created_at`, `user_id`) VALUES
(11, 'demo', 'for testing', '2025-05-30', 'In Progress', 'Email', '1eerere', '2025-05-22 13:21:53', 1);


INSERT INTO `inquiries` (`id`, `counselor_id`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `city`, `date_of_inquiry`, `address`, `present_address`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `created_at`, `updated_at`) VALUES
(23, 1, 'studentVisa', 'Whatsapp', 'dhaka', 'md miah', '01757587455', 'jubeddeutschland@gmail.com', 'mba', 'Bangladesh', 'Hobiganj', '2025-05-10', 'Takbaz khany, Adarsha Bazar', '3 ESQ', '[\"Bachelor\"]', '[\"Writing\"]', 'Studyfirstinfo', 'no', 'no', '[\"Germany\"]', '2025-05-10 00:03:34', '2025-05-10 00:03:34');
INSERT INTO `inquiries` (`id`, `counselor_id`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `city`, `date_of_inquiry`, `address`, `present_address`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `created_at`, `updated_at`) VALUES
(25, 45, 'studentVisa', 'Facebook', 'Sylhet', 'demo ', '867677665', 'demo@gmail.com', 'Math', 'India', 'Inodre', '2025-05-13', 'Bhopal', '123 Street, NY', '[\"HSC\"]', '[\"Writing\"]', 'demo', 'frontend', '5', '[\"UK\"]', '2025-05-12 11:37:00', '2025-05-12 11:37:00');
INSERT INTO `inquiries` (`id`, `counselor_id`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `city`, `date_of_inquiry`, `address`, `present_address`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `created_at`, `updated_at`) VALUES
(26, 1, 'studentVisa', 'Facebook', 'Dhaka', 'demo demo', '867677665', 'demo@gmail.com', 'Maths', 'India', 'Inodre', '2025-05-14', 'Bhopal', '123 Street, NY', '[\"Masters\"]', '[\"Speaking\"]', 'demo', 'frontend', '5', '[\"USA\"]', '2025-05-12 13:37:06', '2025-05-12 13:37:06');
INSERT INTO `inquiries` (`id`, `counselor_id`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `city`, `date_of_inquiry`, `address`, `present_address`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `created_at`, `updated_at`) VALUES
(27, NULL, 'studentVisa', 'Facebook', 'dhaka', 'Arham jayan miah ', '0111111111', 'arhamjayan@gmail.com', 'Business ', 'Bangladesh ', 'Sylhet ', '2025-05-18', 'Habiganj', 'Dubai ', '[\"Bachelor\"]', '[]', 'Study first info ', 'No ', 'No ', '[\"Germany\"]', '2025-05-18 22:03:30', '2025-05-18 22:03:30'),
(28, 45, 'studentVisa', 'Facebook', 'Dhaka', 'krishna', '76767676', 'krishnarajputkiaan@gmail.com', 'Maths', 'India', 'indore', '2025-05-12', 'Indore', 'Gopal gram', '[\"HSC\"]', '[\"Writing\"]', 'kiaan', 'sdsd', '40 minutes', '[\"Canada\",\"UK\"]', '2025-05-22 13:21:18', '2025-05-22 13:21:18'),
(29, NULL, 'studentVisa', 'Facebook', 'dhaka', 'krishna', '07302161400', 'krishnarajputkiaan@gmail.com', 'Maths', 'India', 'indore', '2025-05-11', 'Indore', 'Gopal gram', '[\"SSC\",\"HSC\"]', '[\"Reading\",\"Writing\"]', 'kiaan', 'sdsd', '40 minutes', '[\"Germany\"]', '2025-05-22 14:03:44', '2025-05-22 14:03:44');

INSERT INTO `leads` (`id`, `name`, `email`, `phone`, `counselor`, `follow_up_date`, `source`, `status`, `preferred_countries`, `notes`, `user_id`, `created_at`, `updated_at`) VALUES
(20, 'Jhon Doe', 'john@example.com', '9876543210', 2, '2025-05-10', 'Website', 'In Progress', 'United States', 'demo', 1, '2025-05-12 09:39:29', '2025-05-12 09:39:29');
INSERT INTO `leads` (`id`, `name`, `email`, `phone`, `counselor`, `follow_up_date`, `source`, `status`, `preferred_countries`, `notes`, `user_id`, `created_at`, `updated_at`) VALUES
(21, 'demo demo', 'demo11@gmail.com', '867677665', 1, '2025-05-16', 'Office Visit', 'In Progress', 'India', 'demo', 1, '2025-05-12 09:39:52', '2025-05-12 09:39:52');
INSERT INTO `leads` (`id`, `name`, `email`, `phone`, `counselor`, `follow_up_date`, `source`, `status`, `preferred_countries`, `notes`, `user_id`, `created_at`, `updated_at`) VALUES
(22, 'student01', 'jubimax1993@gmail.com', '12345678', 14, '2025-05-22', 'Phone Call', 'In Progress', 'Portugal', 'please talk to him ', 1, '2025-05-21 23:09:24', '2025-05-21 23:09:24');
INSERT INTO `leads` (`id`, `name`, `email`, `phone`, `counselor`, `follow_up_date`, `source`, `status`, `preferred_countries`, `notes`, `user_id`, `created_at`, `updated_at`) VALUES
(23, 'demo', 'demo@gmail.com', 'demo', 14, '2025-05-28', 'Office Visit', 'Completed', 'India', 'for testing', 1, '2025-05-22 13:22:42', '2025-05-22 13:22:42'),
(24, 'krishna', 'kiaan@gmail.com', '07302161400', 8, '2025-05-14', 'Office Visit', 'Completed', 'India', 'for testing', 1, '2025-05-23 06:37:44', '2025-05-23 06:37:44'),
(25, 'demo', 'kiaan@gmail.com', '07302161400', 16, '2025-05-21', 'Office Visit', 'In Progress', 'India', 'goooo', 1, '2025-05-23 06:52:38', '2025-05-23 06:52:38');

INSERT INTO `messages` (`id`, `chatId`, `sender_id`, `receiver_id`, `message`, `timestamp`, `status`) VALUES
(184, '1_51', 51, 1, 'hii', '2025-05-22 13:25:18', 'delivered');
INSERT INTO `messages` (`id`, `chatId`, `sender_id`, `receiver_id`, `message`, `timestamp`, `status`) VALUES
(185, '1_51', 51, 1, 'how are you', '2025-05-22 13:26:07', 'delivered');
INSERT INTO `messages` (`id`, `chatId`, `sender_id`, `receiver_id`, `message`, `timestamp`, `status`) VALUES
(186, '1_51', 1, 51, 'i am fine', '2025-05-22 13:26:16', 'delivered');
INSERT INTO `messages` (`id`, `chatId`, `sender_id`, `receiver_id`, `message`, `timestamp`, `status`) VALUES
(187, '1_51', 51, 1, 'hii admin', '2025-05-23 10:01:22', 'delivered'),
(188, '1_51', 51, 1, 'hello admin', '2025-05-23 10:12:06', 'delivered'),
(189, '1_51', 1, 51, 'hello student', '2025-05-23 10:12:28', 'delivered'),
(190, '1_51', 51, 1, 'hey admin', '2025-05-23 10:25:10', 'delivered'),
(191, '1_51', 1, 51, 'hey', '2025-05-23 10:25:32', 'delivered'),
(192, '1_51', 51, 1, 'hii', '2025-05-23 10:29:53', 'delivered'),
(193, '1_51', 1, 51, 'hii student', '2025-05-23 10:30:11', 'delivered');

INSERT INTO `payments` (`id`, `branch`, `name`, `whatsapp`, `email`, `group_name`, `university`, `university_other`, `country`, `country_other`, `payment_method`, `payment_method_other`, `payment_type`, `payment_type_other`, `file`, `assistant`, `note`, `created_at`, `updated_at`) VALUES
(21, 8, 'demo demo', '7676767676', 'demo@gmail.com', 'hii', 12, NULL, 'Germany', NULL, 'Bkash', NULL, 'File Opening Charge', NULL, '/uploads/1747057344919-450349722-CRM_Student_Portal_Problem_Report.pdf', 'demo demo', 'demo', '2025-05-12 13:42:24', '2025-05-12 13:42:24');
INSERT INTO `payments` (`id`, `branch`, `name`, `whatsapp`, `email`, `group_name`, `university`, `university_other`, `country`, `country_other`, `payment_method`, `payment_method_other`, `payment_type`, `payment_type_other`, `file`, `assistant`, `note`, `created_at`, `updated_at`) VALUES
(22, 8, 'student03', '0135545665775', 'student03@gmail.com', 'rahimwbs(JF)', 20, NULL, 'Hungary', NULL, 'Cash', NULL, 'File Opening Charge', NULL, '/uploads/1747100119892-549170061-WhatsApp Image 2025-05-10 at 14.48.00 (1).jpeg', 'jannat', 'paid the fee ', '2025-05-13 01:35:20', '2025-05-13 01:35:20');
INSERT INTO `payments` (`id`, `branch`, `name`, `whatsapp`, `email`, `group_name`, `university`, `university_other`, `country`, `country_other`, `payment_method`, `payment_method_other`, `payment_type`, `payment_type_other`, `file`, `assistant`, `note`, `created_at`, `updated_at`) VALUES
(23, 8, 'student03', '0135545665775', 'student03@gmail.com	', 'rahimwbs(JF)', 20, NULL, 'Hungary', NULL, 'Bank Transfer', NULL, 'Application Fee', NULL, '/uploads/1747103774629-212027513-facebook error.png', 'Jahanara Begum', 'paid the fee ', '2025-05-13 02:36:14', '2025-05-13 02:36:14');
INSERT INTO `payments` (`id`, `branch`, `name`, `whatsapp`, `email`, `group_name`, `university`, `university_other`, `country`, `country_other`, `payment_method`, `payment_method_other`, `payment_type`, `payment_type_other`, `file`, `assistant`, `note`, `created_at`, `updated_at`) VALUES
(24, 8, 'lucky', '545454545645', 'lucky@example.com', 'dhaka', 17, NULL, 'Malta', NULL, 'Bank Transfer', NULL, 'After Visa', NULL, '/uploads/1747118702614-645906162-DOC-20250414-WA0010.xlsx', 'krishna', 'this payment', '2025-05-13 06:45:02', '2025-05-13 06:45:02'),
(26, 23, 'John 11 Doe', '7676767676', 'john@example.com', 'hii', 18, NULL, 'Canada', NULL, 'Bkash', NULL, 'File Opening Charge', NULL, '/uploads/1747130323624-531598092-image2.png', 'Jhon Doe', 'test', '2025-05-13 09:58:43', '2025-05-13 09:58:43'),
(27, 23, 'Md Jubed Miah', '0135545665775', 'jubimax1993@gmail.com', 'rahimwbs(JF)', 24, NULL, 'Hungary', NULL, 'Cash', NULL, 'Bank Statement', NULL, '/uploads/1747409786483-85918539-WhatsApp Image 2025-05-13 at 12.56.36.jpeg', 'jamuna', 'paid', '2025-05-16 15:36:26', '2025-05-16 15:36:26'),
(28, 23, 'krishna', '545454545645', 'newstudent01@gmail.com', 'g', 17, NULL, 'Netherlands', NULL, 'Cash', NULL, 'Bank Statement', NULL, '/uploads/1747922701033-283623109-1000048151 (1).jpg', 'krishna', '2332323', '2025-05-22 14:05:01', '2025-05-22 14:05:01');

INSERT INTO `permissions` (`id`, `role_name`, `permission_name`, `view_permission`, `add_permission`, `edit_permission`, `delete_permission`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'student', 'Dashboard', 1, 1, 1, 0, 1, '2025-05-06 12:48:14', '2025-05-21 23:24:26');
INSERT INTO `permissions` (`id`, `role_name`, `permission_name`, `view_permission`, `add_permission`, `edit_permission`, `delete_permission`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 'student', 'Student Details', 1, 1, 1, 0, 1, '2025-05-06 12:49:05', '2025-05-21 23:24:27');
INSERT INTO `permissions` (`id`, `role_name`, `permission_name`, `view_permission`, `add_permission`, `edit_permission`, `delete_permission`, `user_id`, `created_at`, `updated_at`) VALUES
(3, 'student', 'Student Programs', 1, 1, 1, 0, 1, '2025-05-06 12:49:47', '2025-05-21 23:24:32');
INSERT INTO `permissions` (`id`, `role_name`, `permission_name`, `view_permission`, `add_permission`, `edit_permission`, `delete_permission`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 'student', 'Communication', 1, 1, 1, 0, 1, '2025-05-06 12:50:33', '2025-05-21 23:24:32'),
(5, 'student', 'Application Management', 1, 1, 1, 0, 1, '2025-05-06 12:51:28', '2025-05-21 23:24:33'),
(6, 'student', 'Task Management', 1, 1, 1, 0, 1, '2025-05-06 12:52:00', '2025-05-21 23:24:29'),
(7, 'student', 'Payments & Invoices', 1, 1, 1, 0, 1, '2025-05-06 12:52:24', '2025-05-21 23:24:30'),
(8, 'student', 'Course & University', 1, 1, 1, 0, 1, '2025-05-06 12:55:56', '2025-05-21 23:24:31'),
(9, 'counselor', 'Dashboard', 1, 1, 1, 0, 1, '2025-05-06 12:58:46', '2025-05-21 23:24:03'),
(10, 'counselor', 'Inquiry', 1, 1, 1, 0, 1, '2025-05-06 12:59:04', '2025-05-21 23:24:04'),
(11, 'counselor', 'Lead', 1, 1, 1, 0, 1, '2025-05-06 12:59:24', '2025-05-21 23:24:05'),
(12, 'counselor', 'Status', 1, 1, 1, 0, 1, '2025-05-06 12:59:47', '2025-05-21 23:24:05'),
(13, 'counselor', 'Task', 1, 1, 1, 0, 1, '2025-05-06 12:59:59', '2025-05-21 23:24:09'),
(14, 'counselor', 'Student Details', 1, 1, 1, 0, 1, '2025-05-06 13:00:20', '2025-05-21 23:24:07'),
(15, 'counselor', 'Communication', 1, 1, 1, 0, 1, '2025-05-06 13:00:34', '2025-05-21 23:24:08'),
(16, 'counselor', 'Course & University', 1, 1, 1, 0, 1, '2025-05-06 13:00:59', '2025-05-21 23:24:08');

INSERT INTO `remainder` (`id`, `task_id`, `date`) VALUES
(13, 58, NULL);


INSERT INTO `student_fees` (`id`, `student_name`, `description`, `amount`, `status`, `fee_date`) VALUES
(1, 'Ariana Smith', 'Monthly tuition fee for May', '1200', 'paid', '2025-05-01');


INSERT INTO `StudentApplicationProcess` (`id`, `student_id`, `registration_fee_payment`, `registration_date`, `application_submission_date`, `application_fee_payment`, `fee_confirmation_document`, `university_interview_date`, `university_interview_outcome`, `conditional_offer_letter`, `invoice_with_conditional_offer`, `tuition_fee_transfer_proof`, `final_university_offer_letter`, `offer_letter_service_charge_paid`, `university_offer_letter_received`, `appendix_form_completed`, `passport_copy_prepared`, `email_sent_for_documentation`, `appointment_date`, `financial_support_declaration`, `final_offer_letter`, `proof_of_relationship`, `english_language_proof`, `visa_interview_date`, `residence_permit_form`, `proof_of_income`, `airplane_ticket_booking`, `police_clearance_certificate`, `europass_cv`, `birth_certificate`, `bank_statement`, `accommodation_proof`, `motivation_letter`, `previous_studies_certificates`, `travel_insurance`, `european_photo`, `health_insurance`, `visa_decision`, `visa_service_charge_paid`, `flight_booking_confirmed`, `online_enrollment_completed`, `accommodation_confirmation`, `arrival_country`, `university_id`, `Application_stage`, `Interview`, `Visa_process`, `status`) VALUES
(44, 35, 'Paid', '2025-05-23', '2025-05-23', 'Paid', '/uploads/1747901696596-166403185-Profile (1).png', '2025-05-23', 'Accepted', '/uploads/1747904926081-845585830-vedic-maths-lesson1 (3).pdf', '/uploads/1747904926081-174898966-vedic-maths-lesson1 (2).pdf', '/uploads/1747904926081-519375138-Phonics Assessment.pdf', '/uploads/1747904969109-742039206-Create_New_Payment_Form.pdf', 'Paid', '2025-05-23', '/uploads/1747905419340-777807865-Create_New_Payment_Form.pdf', '/uploads/1747905419341-88135770-Create_New_Payment_Form.pdf', '2025-05-23', '2025-05-23', '/uploads/1747905419341-339449230-Create_New_Payment_Form.pdf', '/uploads/1747905419418-747487545-SAMA Paper Pattern 2025.pdf', '/uploads/1747905420333-385419434-SAMA Paper Pattern 2025.pdf', '/uploads/1747905420498-773092520-worksheet (1).pdf', '2025-05-23', '/uploads/1747905420498-978648468-Create_New_Payment_Form.pdf', '/uploads/1747905420498-316009931-Create_New_Payment_Form.pdf', '/uploads/1747905420498-460501060-worksheet.pdf', '/uploads/1747905420499-916418649-Courses.pdf', '/uploads/1747905420515-366294713-Create_New_Payment_Form.pdf', '/uploads/1747905420515-802744803-Screenshot 2025-05-16 123950.png', '/uploads/1747905420677-477131489-Create_New_Payment_Form.pdf', '/uploads/1747905420516-347004507-1000048151 (1).jpg', '/uploads/1747905420534-236084063-1000048151.jpg', '/uploads/1747905420549-854200571-1000048151 (1).jpg', '/uploads/1747905420663-36291472-Courses.pdf', '/uploads/1747905420674-740318472-smart-life-academy-logo.jpg', '/uploads/1747905420673-756894716-BODY-1249021@1x (2).png', 'Approved', 'Pending', 1, 1, 1, 'india', 17, 1, 1, 1, 0);
INSERT INTO `StudentApplicationProcess` (`id`, `student_id`, `registration_fee_payment`, `registration_date`, `application_submission_date`, `application_fee_payment`, `fee_confirmation_document`, `university_interview_date`, `university_interview_outcome`, `conditional_offer_letter`, `invoice_with_conditional_offer`, `tuition_fee_transfer_proof`, `final_university_offer_letter`, `offer_letter_service_charge_paid`, `university_offer_letter_received`, `appendix_form_completed`, `passport_copy_prepared`, `email_sent_for_documentation`, `appointment_date`, `financial_support_declaration`, `final_offer_letter`, `proof_of_relationship`, `english_language_proof`, `visa_interview_date`, `residence_permit_form`, `proof_of_income`, `airplane_ticket_booking`, `police_clearance_certificate`, `europass_cv`, `birth_certificate`, `bank_statement`, `accommodation_proof`, `motivation_letter`, `previous_studies_certificates`, `travel_insurance`, `european_photo`, `health_insurance`, `visa_decision`, `visa_service_charge_paid`, `flight_booking_confirmed`, `online_enrollment_completed`, `accommodation_confirmation`, `arrival_country`, `university_id`, `Application_stage`, `Interview`, `Visa_process`, `status`) VALUES
(45, 35, 'Paid', '2025-05-14', '2025-05-15', 'Paid', '/uploads/1747995016613-499990235-Rituu.exp.pdf', '2025-05-24', 'Accepted', '/uploads/1747995106034-758753662-Rituu.exp.pdf', '/uploads/1747995106531-248863519-Rituu.exp.pdf', '/uploads/1747995106697-921297203-Rituu.exp.pdf', '/uploads/1747995106711-758695494-Rituu.exp.pdf', 'Paid', '2025-05-28', 'null', '/uploads/1747995106862-974163510-WhatsApp Image 2025-05-22 at 4.40.56 PM.jpeg', '2025-05-24', '2025-05-24', '/uploads/1747995107062-703775830-Rituu.exp.pdf', 'null', 'null', 'null', NULL, 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 0, 0, 0, 'null', 12, 1, 1, 0, 0);


INSERT INTO `students` (`id`, `user_id`, `father_name`, `admission_no`, `id_no`, `mobile_number`, `university_id`, `date_of_birth`, `gender`, `category`, `address`, `photo`, `documents`, `created_at`, `updated_at`) VALUES
(35, 1, 'newfather01', '91002', '01', '01111111', 24, '1999-02-03', 'Male', 'General', 'Rua Serpa Pinto 7  3 ESQ', '/uploads/1747876147274-16562491-aaa.png', '/uploads/1747876147368-706505454-Bank Statement ( Md.Rajyan).pdf', '2025-05-22 01:09:08', '2025-05-22 01:09:08');


INSERT INTO `tasks` (`id`, `title`, `user_id`, `due_date`, `counselor_id`, `student_id`, `description`, `priority`, `status`, `related_to`, `related_item`, `assigned_to`, `assigned_date`, `finishing_date`, `attachment`, `created_at`, `updated_at`, `notes`, `image`) VALUES
(58, 'student record', NULL, '2025-05-23', 16, 35, 'demo', 'High', 'pending', 'Visa', 'demo', 'demo', '2025-05-23', '2025-05-23', 'C:\\fakepath\\letter-sounds_alphabet.png', '2025-05-22 10:30:59', '2025-05-22 13:29:57', '', '/uploads/1747920595918-151279316-9812ae0f978da1e830bcca33dac5ec7e2ff9f404.jpg');
INSERT INTO `tasks` (`id`, `title`, `user_id`, `due_date`, `counselor_id`, `student_id`, `description`, `priority`, `status`, `related_to`, `related_item`, `assigned_to`, `assigned_date`, `finishing_date`, `attachment`, `created_at`, `updated_at`, `notes`, `image`) VALUES
(59, 'demo', NULL, '2025-05-26', 16, 35, 'ffgfgfgf', 'Medium', 'Completed', 'Application', 'fgfgf', 'fgfgf', '2025-06-05', '2025-05-27', 'C:\\fakepath\\WhatsApp Image 2025-05-23 at 2.54.15 PM.jpeg', '2025-05-23 10:14:09', '2025-05-23 10:14:09', NULL, NULL);


INSERT INTO `universities` (`id`, `user_id`, `name`, `logo_url`, `location`, `programs`, `highlights`, `contact_phone`, `contact_email`, `created_at`, `updated_at`) VALUES
(12, 1, 'Gyan Sagar ', '/uploads/1746442628489-144683235-smart-life-academy-logo.jpg', 'indore', '[\"fedfdfdf\"]', '[\"hfhfhfh\"]', '07302161400', 'krishnarajputkiaan@gmail.com', '2025-05-05 16:27:08', '2025-05-05 17:26:56');
INSERT INTO `universities` (`id`, `user_id`, `name`, `logo_url`, `location`, `programs`, `highlights`, `contact_phone`, `contact_email`, `created_at`, `updated_at`) VALUES
(17, 1, 'Delhi University', '/uploads/1746539482209-958921538-logo.jpg', 'Delhi, India', '[\"Arts, Commerce, Science\",\"Business, AI, Computer Science\"]', '[\"Largest public university in India\",\"Japan\'s top-ranked university\"]', '46546656', 'info@u-tokyo.ac.jp', '2025-05-06 13:51:21', '2025-05-06 13:51:21');
INSERT INTO `universities` (`id`, `user_id`, `name`, `logo_url`, `location`, `programs`, `highlights`, `contact_phone`, `contact_email`, `created_at`, `updated_at`) VALUES
(18, 1, 'Oxford, United Kingdom', '/uploads/1746771567018-650254915-pngtree-graduation-season-doctor-hat-globe-school-green-plant-vector-image_2300931-removebg-preview.png', '49, indore mp', '[\"Humanities, Law, Philosophy\",\"Engineering, Data Science, Medicine\"]', '[\"One of the oldest universities in the world\",\"Ranked consistently in global top 5 universities\"]', '📞 0044 1865 270000', 'info@oxgmail.com', '2025-05-09 06:19:27', '2025-05-09 06:19:27');
INSERT INTO `universities` (`id`, `user_id`, `name`, `logo_url`, `location`, `programs`, `highlights`, `contact_phone`, `contact_email`, `created_at`, `updated_at`) VALUES
(20, 1, 'Budapest Metropolitan University ', '/uploads/1746943295541-971691652-budapest-metropolitan-university-budapest-hungary.jpg', 'budapest', NULL, NULL, '+880 9613-752752', 'info@stuyfirstinfo.com', '2025-05-11 06:01:35', '2025-05-11 06:01:35'),
(21, 1, 'Gyor University', '/uploads/1747120642271-143442955-wC4KFGDB_400x400[1].jpg', 'University in Győr, Hungary', NULL, NULL, '+36 96 503 400', 'lukacs.eszter@sze.hu', '2025-05-13 07:17:22', '2025-05-13 07:17:22'),
(22, 1, 'Wekerle Business School', '/uploads/1747120858055-752979428-160561_52315698_1218299558323083_4847638838631202816_n[1].png', 'Budapest, Jázmin u. 10, 1083 Hungary', NULL, NULL, '+36 1 50 174 50', 'international@wsuf.hu', '2025-05-13 07:20:58', '2025-05-13 07:20:58'),
(23, 1, 'University of Debrecen', '/uploads/1747121291692-486528945-images[1]', 'Debrecen, Egyetem tér 1, 4032 Hungary', NULL, NULL, '30,418 (2011)', 'info@edu.unideb.hu', '2025-05-13 07:28:11', '2025-05-13 07:28:11'),
(24, 1, 'Pecs University Hungary', '/uploads/1747121716692-886939212-images[1]', 'Pécs, 48-as tér 1, 7622 Hungary', NULL, NULL, '+36 72 501 599', 'international@pte.hu', '2025-05-13 07:35:16', '2025-05-13 07:35:16');

INSERT INTO `users` (`id`, `email`, `password`, `role`, `full_name`, `user_id`, `created_at`, `updated_at`, `student_id`, `counselor_id`, `address`, `phone`) VALUES
(1, 'admin@example.com', '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'admin', 'Alice Admin', NULL, '2025-05-02 09:21:38', '2025-05-08 12:37:59', NULL, NULL, '160/13 west esten manchester, USA', '7865065089');
INSERT INTO `users` (`id`, `email`, `password`, `role`, `full_name`, `user_id`, `created_at`, `updated_at`, `student_id`, `counselor_id`, `address`, `phone`) VALUES
(18, 'john.doe@example.com', '$2b$10$uv/TyRx.CmHtwaIyqBCE7.n.YFmbcBpZXehFXqvpW.CJA5RTcfDEm', 'counselor', 'John Doe123', 1, '2025-05-05 13:15:31', '2025-05-06 06:33:33', NULL, 1, NULL, NULL);
INSERT INTO `users` (`id`, `email`, `password`, `role`, `full_name`, `user_id`, `created_at`, `updated_at`, `student_id`, `counselor_id`, `address`, `phone`) VALUES
(22, 'john.dofde@example.com', '$2b$10$NBgj9OGbgZEJI3u8ZedQk.QW/abQ95J77F8Raauaq0217VclKsvTi', 'counselor', 'John Doe', 1, '2025-05-05 13:39:11', '2025-05-05 13:39:11', NULL, 2, NULL, NULL);
INSERT INTO `users` (`id`, `email`, `password`, `role`, `full_name`, `user_id`, `created_at`, `updated_at`, `student_id`, `counselor_id`, `address`, `phone`) VALUES
(25, 'sohan@gmail.com', '$2b$10$mTeLlgcLzkNgjw2UqxkHyeQij4JiQJPUeaz6ZYHiwLFqDNgtmp6fi', 'counselor', 'sohan', 888, '2025-05-05 13:56:47', '2025-05-05 13:56:47', NULL, 4, NULL, NULL),
(26, 'ankit@gmail.com', '$2b$10$GpJuJPLgnU1nmTzLD2g5RedVcIj79MHvMUflmGtOYNu/gzPb/IPJm', 'counselor', 'ankit', 7788, '2025-05-05 14:08:32', '2025-05-05 14:08:32', NULL, 5, NULL, NULL),
(27, 'admin@gmai.com', '$2b$10$S9.t8G8mNvjFNPPXiJJsLusokXClG7vYQuXkesBpWbDeKCGdDPf0K', 'counselor', 'ggfd', 1, '2025-05-05 14:13:06', '2025-05-05 14:13:06', NULL, 6, NULL, NULL),
(28, 'rohan@gmail.com', '$2b$10$Ozm/VWBEN.Q1Fy.h4zptyOpkCMGWKZuA7d/6k105WISNOMWMRLtKW', 'counselor', 'rohan', 1, '2025-05-06 06:02:56', '2025-05-06 06:02:56', NULL, 7, NULL, NULL),
(29, 'kiaan@gmail.com', '$2b$10$lF7o5hf6jbBUEq1D3yJHj.sHBlKjfDsP8blsrS1DxAhUFLUflix9a', 'counselor', 'krishna', 4555, '2025-05-06 06:15:19', '2025-05-07 12:56:18', NULL, 8, NULL, NULL),
(35, 'pooja@example.com', '$2b$10$8rXEadO0bo0dkTNWZGGtjeVAe6sdDkSSXGJzCk/LLHFBGXpaQYN4S', 'counselor', 'Pooja', 1, '2025-05-08 06:53:23', '2025-05-12 05:55:48', NULL, 12, NULL, NULL),
(37, 'jubed@example.com', '$2b$10$jVaeLn8YeedDVTQPNpT6.OHHJrgTiEWqYDiVYLDwoydgkj5jmOVte', 'counselor', 'jubed', 1, '2025-05-10 02:59:35', '2025-05-10 02:59:35', NULL, 13, NULL, NULL),
(41, 'kaniz@studyfirstinfo.com', '$2b$10$qm9EPxJcWAf/X0QJDvWDxekLcSKwL0IYWHFG3FVF3WAMAgGoN2Qoi', 'counselor', 'kaniz', 1, '2025-05-11 06:03:13', '2025-05-11 06:03:13', NULL, 14, NULL, NULL),
(45, 'Counselor@example.com', '$2b$10$Myi4DXoecZWXfct60wq64eP8pGG/KzIylRNpb7kghh0tIDMMPBgsi', 'counselor', 'Counselor', 1, '2025-05-12 11:30:47', '2025-05-12 11:30:47', NULL, 16, NULL, NULL),
(50, 'sumi@gmail.com', '$2b$10$Ey/rWb7Mah7wn6LjTDqUMem72fin4vcK5CllnbmOJIXKVVyAdNyeC', 'counselor', 'sumi', 1, '2025-05-22 00:56:00', '2025-05-22 00:56:00', NULL, 17, NULL, NULL),
(51, 'newstudent01@gmail.com', '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'student', 'newstudent 01', 1, '2025-05-22 01:09:08', '2025-05-22 08:12:33', 35, NULL, NULL, NULL);


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;