-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2025 at 10:17 AM
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
-- Database: `afsanacrm`
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
(7, 1, '123456', 11, 'active', '2025-05-06 11:32:56', '2025-05-06 11:32:56'),
(8, 1, '07302161400', 12, 'active', '2025-05-06 11:45:19', '2025-06-12 18:16:42'),
(12, 1, '325677888675', 12, 'active', '2025-05-08 06:53:23', '2025-05-12 05:53:57'),
(13, 1, '01757587455', 12, 'active', '2025-05-10 02:59:35', '2025-05-10 02:59:35'),
(14, 1, '+880 1886-144256', 20, 'active', '2025-05-11 06:03:13', '2025-05-11 06:03:13'),
(16, 1, '9876543', 12, 'active', '2025-05-12 11:30:47', '2025-05-12 13:44:59'),
(17, 1, '12345567', 23, 'active', '2025-05-22 00:56:00', '2025-05-22 00:56:00'),
(18, 1, '123', 23, 'active', '2025-06-10 16:33:12', '2025-06-10 16:33:12');

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
(11, 'demo', 'for testing', '2025-05-30', 'In Progress', 'Email', '1eerere', '2025-05-22 07:51:53', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `id` int(11) NOT NULL,
  `counselor_id` int(11) DEFAULT NULL,
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
  `new_leads` varchar(255) NOT NULL DEFAULT 'new'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`id`, `counselor_id`, `inquiry_type`, `source`, `branch`, `full_name`, `phone_number`, `email`, `course_name`, `country`, `status`, `is_view`, `lead_status`, `payment_status`, `city`, `date_of_birth`, `gender`, `medium`, `study_level`, `study_field`, `intake`, `budget`, `consent`, `highest_level`, `ssc`, `hsc`, `bachelor`, `university`, `test_type`, `overall_score`, `reading_score`, `writing_score`, `speaking_score`, `listening_score`, `date_of_inquiry`, `address`, `present_address`, `additionalNotes`, `study_gap`, `visa_refused`, `refusal_reason`, `education_background`, `english_proficiency`, `company_name`, `job_title`, `job_duration`, `preferred_countries`, `eligibility_status`, `created_at`, `updated_at`, `assignment_description`, `follow_up_date`, `notes`, `new_leads`) VALUES
(31, 16, 'touristVisa', 'Facebook', 'Dhaka', 'muskan', '67676767', 'muskan@gmail.com', 'Maths', 'India', '1', '0', 'Converted to Lead', 'paid', 'indore', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-17', 'Indore', 'Gopal gram', NULL, NULL, NULL, NULL, '[\"SSC\",\"HSC\"]', '[\"Reading\",\"Writing\"]', 'kiaan', 'sdsd', '120-minut', '[\"Germany\"]', '3', '2025-06-05 18:01:09', '2025-06-16 11:47:32', '0', '2025-06-10', 'demo', 'Registered'),
(33, 16, 'touristVisa', 'Facebook', 'Dhaka', 'krishna', '07302161400', 'krishnarajputkiaan@gmail.com', 'Maths', 'India', '1', '0', 'Converted to Lead', '0', 'indore', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-10', 'Indore', 'Gopal gram', NULL, NULL, NULL, NULL, '[\"SSC\"]', '[\"Reading\"]', 'kiaan', 'sdsd', 'sdsdsd', '[\"Germany\"]', '3', '2025-06-07 18:29:48', '2025-06-16 14:05:56', '0', '2025-06-10', 'demo', 'Registered'),
(34, 1, 'touristVisa', 'Facebook', 'Sylhet', 'newstudent01', '7878787', 'newstudent01@gmail.com', 'Maths', 'India', '0', '0', 'Not Interested', 'paid', 'indore', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-10', 'Indore', 'Gopal gram', NULL, NULL, NULL, NULL, '[\"SSC\"]', '[\"Reading\"]', 'kiaan', 'sdsd', 'sdsdsd', '[\"Germany\"]', '1', '2025-06-17 18:31:14', '2025-06-17 05:19:25', '0', '2025-07-03', NULL, '0'),
(37, 1, 'visit_visa', 'youtube', 'Dhaka', 'demo demo', '7865065089', 'test@gmail.com', 'de', 'usa', '0', '0', 'In Review', '0', 'indore', '2025-06-23', 'male', 'english', 'diploma', 'de', 'february', NULL, 1, 'ssc', NULL, NULL, NULL, 'dfd', 'ielts', '4', '4', '4', '4', '4', '2025-06-12', 'usa', 'usa', NULL, 'ha', 'yes', 'ha', '[{\"level\":\"ssc\",\"gpa\":\"34\",\"year\":\"34343\"}]', NULL, 'demo', 'demo', '6', '[\"Lithuania\",\"Hungary\"]', '2', '2025-06-12 15:09:20', '2025-06-16 10:00:06', '0', '2025-07-02', 'dd', '0'),
(42, 1, 'student_visa', 'facebook', 'Dhaka', 'Sandip Dodiya', '07302161400', 'krishnarajputkiaan@gmail.com', 'deo', 'India', '0', '0', '0', '0', 'Ujjain', '2025-06-25', 'male', 'english', 'diploma', 'demo', NULL, '5000', 1, 'ssc', NULL, NULL, NULL, 'govt', 'ielts', '6', '6', '6', '6', '6', '2025-06-13', 'Gopal gram - chirola,Chirola,Ujjain Madhya Pradesh - 456313', 'Gopal gram', NULL, 'yes', 'yes', 'demo', '[]', NULL, 'demo', 'demo', 'jan-2020', '[\"Hungary\",\"Lithuania\",\"Latvia\",\"UK\"]', '0', '2025-06-16 13:49:15', '2025-06-17 05:19:01', '0', NULL, NULL, '0'),
(44, 1, 'german_course', 'facebook', 'Dhaka', 'krishna', '07302161400', 'krishnarajputkiaan@gmail.com', 'deo', 'UK', '0', '0', 'In Review', '0', 'indore', '2025-06-17', 'male', 'bangla', 'diploma', 'demo', 'february', '5000', 1, 'ssc', NULL, NULL, NULL, 'govt', 'ielts', '7.6', '7.7', '77', '7.7', '7.7', '2025-06-16', 'Indore', 'Gopal gram', NULL, 'demo', 'yes', '', '[{\"level\":\"ssc\",\"gpa\":\"44\",\"year\":\"2025\"}]', NULL, 'kiaan', 'demo', 'jan-2020', '[\"Hungary\",\"UK\",\"Canada\"]', '0', '2025-05-16 07:55:05', '2025-06-17 05:39:09', '0', NULL, NULL, 'new'),
(46, 1, 'work_visa', 'referral', 'Dhaka', 'kunal', '76768787878', 'kunal@gmail.com', 'deo', 'UK', '0', '0', '0', '0', 'indore', '2025-06-03', 'male', 'bangla', 'diploma', 'demo', 'february', '5000', 1, 'hsc', NULL, NULL, NULL, 'govt', 'duolingo', '7.6', '7.7', '77', '7.7', '7.7', NULL, 'Indore', 'Gopal gram', NULL, 'demo', 'yes', 'demo', '[{\"level\":\"hsc\",\"gpa\":\"55\",\"year\":\"2025\"}]', '[]', 'kiaan', 'Sales', 'jan-2020', '[\"Hungary\",\"UK\",\"Cyprus\"]', '0', '2025-06-17 05:55:15', '2025-06-17 05:55:15', '0', NULL, NULL, 'new');

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

--
-- Dumping data for table `inquiry_images`
--

INSERT INTO `inquiry_images` (`id`, `inquiry_id`, `image`, `created_at`) VALUES
(1, 33, 0x255044462d312e340a25938c8b9e205265706f72744c61622047656e6572617465642050444620646f63756d656e7420687474703a2f2f7777772e7265706f72746c61622e636f6d0a312030206f626a0a3c3c0a2f4631203220302052202f4632203320302052202f46332034203020520a3e3e0a656e646f626a0a322030206f626a0a3c3c0a2f42617365466f6e74202f48656c766574696361202f456e636f64696e67202f57696e416e7369456e636f64696e67202f4e616d65202f4631202f53756274797065202f5479706531202f54797065202f466f6e740a3e3e0a656e646f626a0a332030206f626a0a3c3c0a2f42617365466f6e74202f48656c7665746963612d426f6c64202f456e636f64696e67202f57696e416e7369456e636f64696e67202f4e616d65202f4632202f53756274797065202f5479706531202f54797065202f466f6e740a3e3e0a656e646f626a0a342030206f626a0a3c3c0a2f42617365466f6e74202f5a61706644696e6762617473202f4e616d65202f4633202f53756274797065202f5479706531202f54797065202f466f6e740a3e3e0a656e646f626a0a352030206f626a0a3c3c0a2f436f6e74656e7473203920302052202f4d65646961426f78205b20302030203539352e32373536203834312e38383938205d202f506172656e74203820302052202f5265736f7572636573203c3c0a2f466f6e74203120302052202f50726f63536574205b202f504446202f54657874202f496d61676542202f496d61676543202f496d61676549205d0a3e3e202f526f746174652030202f5472616e73203c3c0a0a3e3e200a20202f54797065202f506167650a3e3e0a656e646f626a0a362030206f626a0a3c3c0a2f506167654d6f6465202f5573654e6f6e65202f5061676573203820302052202f54797065202f436174616c6f670a3e3e0a656e646f626a0a372030206f626a0a3c3c0a2f417574686f7220285c28616e6f6e796d6f75735c2929202f4372656174696f6e446174652028443a32303235303631303037353030352b30302730302729202f43726561746f7220285c28756e7370656369666965645c2929202f4b6579776f726473202829202f4d6f64446174652028443a32303235303631303037353030352b30302730302729202f50726f647563657220285265706f72744c616220504446204c696272617279202d207777772e7265706f72746c61622e636f6d29200a20202f5375626a65637420285c28756e7370656369666965645c2929202f5469746c6520285c28616e6f6e796d6f75735c2929202f54726170706564202f46616c73650a3e3e0a656e646f626a0a382030206f626a0a3c3c0a2f436f756e742031202f4b696473205b203520302052205d202f54797065202f50616765730a3e3e0a656e646f626a0a392030206f626a0a3c3c0a2f46696c746572205b202f415343494938354465636f6465202f466c6174654465636f6465205d202f4c656e67746820313035340a3e3e0a73747265616d0a4761743d2a3d5c6d643b263a56732f286f5e44752c2543393871565c40335768412d65655d3566585326415f27233033453349736f3f52453d50284c366b44304f63245c456d63485f6a5b5f25346669254f364b3b257572376a3a5e35626e572b6858573f2c4f3529483072725b4266665e6c653851445a356e4033436667376763544a285e284c5132742440522d4a40274f746922432c314473696f25432c4b2772424b704425706e3329722368504e3c564d5423214c3d6844752f322b375154684a62225c4f442e5a436f4038546c69614f73583039242c476e3c334d33263f475e3f623c2c58663738704852562a40453f64434f7059235a213f664f415450732b2b22334141655f45606d5e3f60403040695c2767266e6c446d433e282c525b2d52226e5a3f6954253568374829596d3c5f2c6f636f6d46635a564f2a4651236866276224665a5235527261643f3d3e676e71316e4e70292e542d2e49312832612c61692b316b6e262b3c353c373c403f36243b574527584c28585c472a5b74563e50442463435e3866484133443937372c285c28625d27605928594a6921334c365470402738742447226635375132383d26235b567066263b3a4e5268586524652d6642704855753d465562554e4a72263832422a6f6a5a4323504468545f6a324140312821655b3e243e3a652c6c3326664a6c3c2c2249585255323c7566716f633f544341493e7333216f4c3a3e694a5d2f58465b6b4a58227575264526574d5c4e2c3d4a5c4b535e6254484865725159645269672b2d214d4534306b63435f693562723e593e524d37522c5c5f4861497437526e69686d54336a516a313b505c29445d25724f40495d533e3d71724e6f3b2f55472f395a40365726566d5f232a40715c743859462b3f4c6140756a336568445e67472a2e2e5d3e2f4a3c61355f42286128222f585a42702d4a5b582275503e553b374229674a617450333142703c2857613f55212c32723b35324073486c2a2a706f4b713b6c422f56583a644f6b22662e254d306455226a66234339396734646f43714b5d695d444249325e605442625861372325375d5c552d723b2a294e562d415f32544b66363c54593430536a24322a2a72256b253a2d4268533b214043363e4829216e3a63676627243b46656c3469454e50404e70425a4534314c69585d4471325e406a544b5f573937602d4f5641215f75502d2826674235675c4c555273376f736f482745472835286b5732436e726249322b6e2b39303567536f6e296c54562d754633264575523a576340703255506e633258323d65572a3d3270245f546a6559404451254e406d325b5a2d686824686b48572b3a625e65756663685d2375606554723a382423493d6929626e65413e3e443a5340433667233f522f506a234365252b4e35377040654a2d323a70704b462336513a2e48214d2d6d57644a7e3e656e6473747265616d0a656e646f626a0a787265660a302031300a303030303030303030302036353533352066200a30303030303030303733203030303030206e200a30303030303030313234203030303030206e200a30303030303030323331203030303030206e200a30303030303030333433203030303030206e200a30303030303030343236203030303030206e200a30303030303030363239203030303030206e200a30303030303030363937203030303030206e200a30303030303030393830203030303030206e200a30303030303031303339203030303030206e200a747261696c65720a3c3c0a2f4944200a5b3c36343634313234636538343861623737366531313566623364373435323134393e3c36343634313234636538343861623737366531313566623364373435323134393e5d0a25205265706f72744c61622067656e6572617465642050444620646f63756d656e74202d2d206469676573742028687474703a2f2f7777772e7265706f72746c61622e636f6d290a0a2f496e666f2037203020520a2f526f6f742036203020520a2f53697a652031300a3e3e0a7374617274787265660a323138340a2525454f460a, '2025-06-10 10:32:18');

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
(21, 'demo demo', 'demo11@gmail.com', '867677665', 1, '2025-05-16', 'Office Visit', 'Converted', 'India', 'demo', 1, '2025-05-12 04:09:52', '2025-06-04 13:23:23'),
(22, 'student01', 'jubimax1993@gmail.com', '12345678', 14, '2025-05-22', 'Phone Call', 'Contected', 'Portugal', 'please talk to him ', 1, '2025-05-21 17:39:24', '2025-06-04 13:22:27');

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
(193, '1_51', 1, 51, 'hii student', '2025-05-23 10:30:11', 'delivered'),
(194, '1_61', 61, 1, 'hello', '2025-06-10 12:05:28', 'delivered'),
(195, '45_61', 61, 45, 'hekloo', '2025-06-10 12:07:40', 'delivered'),
(196, '45_61', 61, 45, 'gfgfg', '2025-06-10 12:07:50', 'delivered');

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
(29, 8, '35', '545454545645', 'krishnarajputkiaan@gmail.com', 'dhaka', 22, NULL, 'Netherlands', NULL, 'Bank Transfer', NULL, 'Application Fee', NULL, '/uploads/1749119515706-425744752-Invoice_undefined_1749119088040.pdf', 'krishna', 'this payment', '2025-06-05 10:31:55', '2025-06-05 10:31:55'),
(30, 8, '35', '545454545645', 'krishnarajputkiaan@gmail.com', 'dhaka', 22, NULL, 'Canada', NULL, 'Cash', NULL, 'Bank Statement', NULL, '/uploads/1749296817331-159560553-Invoice_29.pdf', 'krishna', 'this payment', '2025-06-07 11:46:57', '2025-06-07 11:46:57'),
(31, 8, '51', '545454545645', 'ritika@gmail.com', 'hok', 21, NULL, 'Canada', NULL, 'Cash', NULL, 'Bank Statement', NULL, '/uploads/1749556829822-105333927-school-tuition-invoice.png', 'krishna', 'this payment', '2025-06-10 12:00:29', '2025-06-10 12:00:29');

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
(45, 35, 'Paid', '2025-05-14', '2025-05-15', 'Paid', '/uploads/1747995016613-499990235-Rituu.exp.pdf', '2025-05-24', 'Accepted', '/uploads/1747995106034-758753662-Rituu.exp.pdf', '/uploads/1747995106531-248863519-Rituu.exp.pdf', '/uploads/1747995106697-921297203-Rituu.exp.pdf', '/uploads/1747995106711-758695494-Rituu.exp.pdf', 'Paid', '2025-05-28', 'null', '/uploads/1747995106862-974163510-WhatsApp Image 2025-05-22 at 4.40.56 PM.jpeg', '2025-05-24', '2025-05-24', '/uploads/1747995107062-703775830-Rituu.exp.pdf', 'null', 'null', 'null', NULL, 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 0, 0, 0, 'null', 12, 1, 1, 0, 0),
(47, 0, 'Paid', '2025-06-12', '2025-06-11', 'Paid', '/uploads/1749558132093-91623538-Invoice_ritika_1749556870618.pdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 12, 1, 0, 0, 0);

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
  `full_name` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `father_name`, `admission_no`, `id_no`, `mobile_number`, `university_id`, `date_of_birth`, `gender`, `category`, `address`, `full_name`, `role`, `photo`, `documents`, `created_at`, `updated_at`) VALUES
(35, 1, 'newfather01', '', '01', '01111111', 24, '1999-02-03', 'Male', 'General', 'Rua Serpa Pinto 7  3 ESQ', '', '', '/uploads/1747876147274-16562491-aaa.png', '/uploads/1747876147368-706505454-Bank Statement ( Md.Rajyan).pdf', '2025-05-22 01:09:08', '2025-05-22 01:09:08'),
(36, 54, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, '2025-06-04 16:43:22', '2025-06-04 16:43:22'),
(47, 0, '', '', '', '', 0, '0000-00-00', '', '', '', '', '', '', '', '2025-06-05 17:58:58', '2025-06-05 17:58:58'),
(49, 59, 'demo', '123', '01', '07302161', 23, '2025-06-28', 'Male', 'ST', 'Indore\r\nGopal gram', 'virat', 'student', '/uploads/1749297395642-930506709-WhatsApp Image 2025-05-29 at 1.51.37 PM.jpeg', '/uploads/1749297395721-618431-Invoice_29.pdf', '2025-06-07 17:26:35', '2025-06-07 17:26:35'),
(51, 61, 'demo', '3234', '06', '6676767776', 22, '2025-06-26', 'Male', 'SC', 'Gopal gram - chirola,Chirola,Ujjain Madhya Pradesh - 456313\r\nGopal gram', 'ritika', 'student', '', '', '2025-06-10 16:31:21', '2025-06-10 16:31:21');

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
(1, 'demo', 'sdsdsd', 100.00, '2025-06-19', 0, 0, '2025-06-05 08:06:58', '2025-06-06 07:15:04'),
(2, 'muskan', 'dfdfdfdf', 200.00, '2025-06-19', 0, 0, '2025-06-06 06:55:16', '2025-06-06 06:55:16'),
(3, 'md miah', 'testing data', 220.00, '2025-06-23', 0, 0, '2025-06-06 07:14:17', '2025-06-06 11:12:49'),
(4, 'md miah', 'dfdfdf', 44.88, '2025-06-20', 0, 0, '2025-06-06 08:24:48', '2025-06-06 08:24:48'),
(5, 'John Doe', 'Tuition Fee for June', 15000.00, '2025-06-06', 0, 0, '2025-06-06 09:26:39', '2025-06-06 09:26:39'),
(6, 'muskan', 'demo data', 4360.00, '2025-06-12', 0, 0, '2025-06-06 09:31:36', '2025-06-06 09:31:36'),
(7, 'muskan', 'demo', 408.00, '2025-06-26', 0, 0, '2025-06-06 09:37:04', '2025-06-06 09:37:04'),
(9, 'Rahul Sharma', 'First installment fee', 15000.00, '2025-06-06', 33, 0, '2025-06-06 11:04:06', '2025-06-10 07:24:07'),
(10, 'raju', '6656565', 204.00, '2025-06-25', 0, 0, '2025-06-06 11:07:43', '2025-06-06 11:07:43'),
(11, 'John Doe', 'Tuition fee for the semester', 5000.00, '2025-06-07', 32, 0, '2025-06-07 10:20:46', '2025-06-07 10:20:46'),
(12, 'John Doe', 'Tuition fee for the semester', 5000.00, '2025-06-07', 31, 0, '2025-06-07 10:21:26', '2025-06-07 10:21:26'),
(13, 'John Doe', 'Tuition fee for the semester', 5000.00, '2025-06-07', 31, 0, '2025-06-07 10:28:12', '2025-06-07 10:28:12'),
(14, 'John Doe', 'demo', 330.00, '2025-06-20', 32, 0, '2025-06-07 10:29:39', '2025-06-07 10:29:39'),
(15, 'John Doe', 'Tuition fee for the semester', 5000.00, '2025-06-07', 31, 1, '2025-06-07 10:32:11', '2025-06-07 10:32:11'),
(16, 'raju', 'dwen9', 3990.00, '2025-06-20', 30, 30, '2025-06-07 10:54:25', '2025-06-07 10:54:25'),
(17, 'md miah', 'dwen9', 3990.00, '2025-06-20', 23, 23, '2025-06-07 10:54:36', '2025-06-07 10:54:36'),
(18, 'newstudent01', '6565656', 4080.00, '2025-06-12', 34, 34, '2025-06-07 13:02:52', '2025-06-07 13:02:52'),
(19, 'John Doe', 'Tuition fee for the semester', 5000.00, '2025-06-07', 34, 11, '2025-06-07 13:08:34', '2025-06-07 13:08:34'),
(20, 'muskan', 'demo', 510.00, '2025-06-20', 31, 31, '2025-06-10 06:51:24', '2025-06-10 06:51:24'),
(21, 'raju', 'demo', 2040.00, '2025-06-12', 30, 30, '2025-06-10 11:41:53', '2025-06-10 11:41:53'),
(22, 'goutam', 'demo', 3300.00, '2025-06-20', 35, 35, '2025-06-10 11:55:42', '2025-06-10 11:55:42');

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
(4, '3002', '90.06', '3092.06', 'fdfdfdfd', '35', '2025-06-24', '2025-06-05 10:33:05', '2025-06-05 10:33:05'),
(5, '2000', '200', '2200', 'demo', '35', '2025-07-01', '2025-06-10 11:04:55', '2025-06-10 11:04:55'),
(6, '3000', '300', '3300', 'demo', '51', '2025-06-26', '2025-06-10 12:01:09', '2025-06-10 12:01:09');

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
  `name` varchar(255) NOT NULL,
  `logo_url` text DEFAULT NULL,
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
  `user_id` int(11) NOT NULL,
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
(1, 'admin@example.com', '$2b$10$Y7wBTtZ9ig6Al98AV1GgtufvpjESYUFYtykw.3ELgN/O4ZFg3sz1S', 'admin', 'Alice Admin', 0, '2025-05-02 03:51:38', '2025-05-08 07:07:59', NULL, NULL, '160/13 west esten manchester, USA', '7865065089'),
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
(52, 'vishal@example.com', '$2b$10$ruvrwn0M.uads0MsNdCkHedf4YBOT65v5pXw2vT2X2Z1uibAkmtHW', 'student', 'vishal ', 0, '2025-06-04 06:31:15', '2025-06-04 06:31:15', NULL, NULL, NULL, NULL),
(53, 'vishaltest@example.com', '$2b$10$KMlOcmkmwSevhVMnIlXI/ubxe6tyuH3pGosONc5cEojdWqLKmXbom', 'student', 'vishal ', 0, '2025-06-04 06:32:14', '2025-06-04 06:32:14', NULL, NULL, NULL, NULL),
(54, 'rehan@gmail.com', '$2b$10$FhVw.KpA8lSSLOviVT6C0.FTZLrYv.xiIYU8Kw4aKHK3PlKiOo6tS', 'student', 'rehana', 0, '2025-06-04 11:13:22', '2025-06-04 11:13:22', NULL, NULL, NULL, NULL),
(57, 'muskan@gmail.com', '$2a$12$5C.1lZWEjJ.6vyHpkVLdt.qb.8SqH8UgVl1DEVIoh7yB0M2/Rcr4G', 'student', 'muskan', 0, '2025-06-05 12:28:58', '2025-06-06 10:00:42', 47, NULL, NULL, NULL),
(59, 'virat@gmail.com', '$2b$10$gD9.vy5R85k.G9Uoz4Qv5e7x0.W4.NEQCmwsvT3jpfitpTEzUgLF2', 'student', 'virat', 0, '2025-06-07 11:56:35', '2025-06-07 11:56:35', 49, NULL, NULL, NULL),
(61, 'ritika@gmail.com', '$2b$10$3ZA.G8pRa5KeIvODzTtMu.NhuJ5tyBG047josh86vFbu.dqQCp50.', 'student', 'ritika', 0, '2025-06-10 11:01:21', '2025-06-10 11:01:21', 51, NULL, NULL, NULL),
(62, 'syam@gmail.com', '$2b$10$Tj.a19kNzW0EtBUAZzk5n./VUDSdeKrllASI40ht22fsXi/vQYnb6', 'counselor', 'syam', 1, '2025-06-10 11:03:12', '2025-06-10 11:03:12', NULL, 18, NULL, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `follow_ups`
--
ALTER TABLE `follow_ups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `student_fees`
--
ALTER TABLE `student_fees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_fees_by_counselor`
--
ALTER TABLE `student_fees_by_counselor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `student_invoice`
--
ALTER TABLE `student_invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

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
