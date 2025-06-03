-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2025 at 01:04 PM
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
  `user_id` int(11) DEFAULT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `university` varchar(255) DEFAULT NULL,
  `status` enum('Accepted','Rejected','Waitlisted') DEFAULT NULL,
  `decision_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admission_decisions`
--

INSERT INTO `admission_decisions` (`id`, `user_id`, `student_name`, `university`, `status`, `decision_date`, `created_at`) VALUES
(1, 101, 'Alice Johnson', 'MIT', 'Rejected', '2025-05-03', '2025-05-03 09:28:45'),
(5, 101, 'sonu', 'hghgh', 'Rejected', '2025-05-23', '2025-05-03 10:15:25');

-- --------------------------------------------------------

--
-- Table structure for table `counselors`
--

CREATE TABLE `counselors` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `university` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `counselors`
--

INSERT INTO `counselors` (`id`, `user_id`, `name`, `email`, `phone`, `university`, `status`) VALUES
(2, 12, 'counsellor2', 'counsellor1@example.com', '12334445778', 'abuni', 'Active');

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
(2, 1, 'studentVisa', 'Whatsapp', 'dhaka', 'krishna', '07302161400', 'krishnarajputkiaan@gmail.com', 'Business Administration', 'India', 'indore', '2025-05-13', 'Indore', 'Gopal gram', '[\"HSC\"]', '[\"Writing\"]', 'kiaan', 'sdsd', 'sdsdsd', '[\"Canada\"]', '2025-05-02 11:33:33', '2025-05-02 11:33:33'),
(8, 1, 'workVisa', 'Website', 'dhaka', 'ankit', '07302161400', 'ankit@gmail.com', 'Maths', 'India', 'indore', '2025-05-29', 'Indore', 'Gopal gram', '[\"SSC\",\"HSC\"]', '[\"Writing\",\"Reading\"]', 'kiaan', 'sdsd', 'sdsdsd', '[\"Germany\",\"Canada\"]', '2025-05-02 13:27:07', '2025-05-02 13:27:07');

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
(5, 'John Smith', 'john.smith@example.com', '+1 234 567 8900', 1, '2024-02-28', 'Website', 'In Progress', 'USA, Canada', 'Interested in premium package', 1, '2025-05-03 06:50:40', '2025-05-03 06:50:40');

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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`, `full_name`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'admin@example.com', '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'admin', 'Alice Admin', NULL, '2025-05-02 09:21:38', '2025-05-02 09:21:38'),
(2, 'student@example.com', '$2b$10$rDDUtU.bb69iJqv2/2ECSeGLzDhs2zzjpwuqZdA5WDb07NokwzjCm', 'student', 'billy bucher', NULL, '2025-05-02 10:06:04', '2025-05-02 10:06:04');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `follow_ups`
--
ALTER TABLE `follow_ups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
