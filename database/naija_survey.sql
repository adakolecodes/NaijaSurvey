-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 02, 2026 at 05:15 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `naija_survey`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_type` enum('client','surveyor') COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `password`, `user_type`, `status`, `created_at`) VALUES
(1, 'johndoe@example.com', '$2y$10$PvbFsv6ByeA2XAaXXSW2ce6mrwJrKJ/SQ6f6ytz4noY9B2HV9qVQq', 'surveyor', 'active', '2026-01-28 15:29:10'),
(2, 'janedoe@example.com', '$2y$10$a66TJxz3bqFUsxZ.QuizROc1lemMVyns1GhO9dN0TF0SkVuQ0d.L6', 'client', 'active', '2026-01-29 07:47:19');

-- --------------------------------------------------------

--
-- Table structure for table `clients_profile`
--

DROP TABLE IF EXISTS `clients_profile`;
CREATE TABLE IF NOT EXISTS `clients_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `surname` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `other_names` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `whatsapp_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `lga` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `profile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_document` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `verification_status` enum('pending','verified','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `verified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_client_user` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients_profile`
--

INSERT INTO `clients_profile` (`id`, `account_id`, `first_name`, `surname`, `other_names`, `phone_number`, `whatsapp_number`, `bio`, `state`, `lga`, `address`, `profile_image`, `id_type`, `id_document`, `verification_status`, `verified_at`, `created_at`, `updated_at`) VALUES
(1, 2, 'Jane', 'Doe', 'Jee', '09012345678', '09012345678', 'I am a client', 'Benue', 'APA', 'Just APA', 'profile_image697b0c2a465d3_1769671722.jpg', 'voters_card', 'id_697b0c2a4696a_1769671722.pdf', 'pending', '2026-01-29 08:28:42', '2026-01-29 08:28:42', '2026-01-29 08:31:23');

-- --------------------------------------------------------

--
-- Table structure for table `deliverables`
--

DROP TABLE IF EXISTS `deliverables`;
CREATE TABLE IF NOT EXISTS `deliverables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `request_to_client_id` int DEFAULT NULL,
  `request_to_surveyor_id` int DEFAULT NULL,
  `client_profile_id` int NOT NULL,
  `surveyor_profile_id` int NOT NULL,
  `coordinates` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `note_to_client` text COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_deliverables_request_client` (`request_to_client_id`),
  KEY `fk_deliverables_request_surveyor` (`request_to_surveyor_id`),
  KEY `fk_deliverables_surveyor` (`surveyor_profile_id`),
  KEY `fk_deliverables_client` (`client_profile_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_profile_id` int NOT NULL,
  `job_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `proposed_budget` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `job_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_lga` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_status` enum('available','taken','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'available',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_jobs_client` (`client_profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `client_profile_id`, `job_title`, `job_description`, `proposed_budget`, `job_state`, `job_lga`, `job_address`, `job_status`, `created_at`) VALUES
(1, 1, 'Boundary Survey for Residential Plot', 'Boundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential PlotBoundary Survey for Residential Plot', '90000', 'Benue', 'Otukpo', 'GRA', 'available', '2026-01-29 08:48:20'),
(2, 1, 'Topographic Survey for Construction', 'Topographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for ConstructionTopographic Survey for Construction', '100000', 'Benue', 'Makurdi', 'GRA', 'available', '2026-01-29 08:51:33');

-- --------------------------------------------------------

--
-- Table structure for table `request_to_clients`
--

DROP TABLE IF EXISTS `request_to_clients`;
CREATE TABLE IF NOT EXISTS `request_to_clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `surveyor_profile_id` int NOT NULL,
  `client_profile_id` int NOT NULL,
  `request_status` enum('pending','accepted','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_rtc_job` (`job_id`),
  KEY `fk_rtc_surveyor` (`surveyor_profile_id`),
  KEY `fk_rtc_client` (`client_profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request_to_clients`
--

INSERT INTO `request_to_clients` (`id`, `job_id`, `surveyor_profile_id`, `client_profile_id`, `request_status`, `created_at`) VALUES
(1, 1, 1, 1, 'pending', '2026-01-29 08:28:45'),
(2, 2, 1, 1, 'pending', '2026-01-29 08:50:13');

-- --------------------------------------------------------

--
-- Table structure for table `request_to_surveyors`
--

DROP TABLE IF EXISTS `request_to_surveyors`;
CREATE TABLE IF NOT EXISTS `request_to_surveyors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_profile_id` int NOT NULL,
  `surveyor_profile_id` int NOT NULL,
  `service_category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `project_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `project_lga` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `project_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estimated_budget` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `project_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `request_status` enum('pending','accepted','rejected','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_rts_client` (`client_profile_id`),
  KEY `fk_rts_surveyor` (`surveyor_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `surveyors_profile`
--

DROP TABLE IF EXISTS `surveyors_profile`;
CREATE TABLE IF NOT EXISTS `surveyors_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `surname` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `other_names` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `whatsapp_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `years_of_experience` int NOT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lga` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `profile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_document` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `surcon_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `verification_status` enum('pending','verified','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `verified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_surveyor_user` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surveyors_profile`
--

INSERT INTO `surveyors_profile` (`id`, `account_id`, `first_name`, `surname`, `other_names`, `phone_number`, `whatsapp_number`, `years_of_experience`, `bio`, `state`, `lga`, `address`, `profile_image`, `id_type`, `id_document`, `surcon_number`, `verification_status`, `verified_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'John', 'Doe', 'Deed', '09123456789', '09123456789', 2, 'I am a surveyor', 'Benue', 'Otukpo', 'GRA', 'profile_697a272ee0fd8_1769613102.png', 'id_card', 'id_697a2476efc73_1769612406.pdf', '212356BN6QW', 'verified', '2026-01-28 16:00:06', '2026-01-28 16:00:06', '2026-01-29 09:44:34');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clients_profile`
--
ALTER TABLE `clients_profile`
  ADD CONSTRAINT `fk_client_user` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `deliverables`
--
ALTER TABLE `deliverables`
  ADD CONSTRAINT `fk_deliverables_client` FOREIGN KEY (`client_profile_id`) REFERENCES `clients_profile` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_deliverables_request_client` FOREIGN KEY (`request_to_client_id`) REFERENCES `request_to_clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_deliverables_request_surveyor` FOREIGN KEY (`request_to_surveyor_id`) REFERENCES `request_to_surveyors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_deliverables_surveyor` FOREIGN KEY (`surveyor_profile_id`) REFERENCES `surveyors_profile` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `fk_jobs_client` FOREIGN KEY (`client_profile_id`) REFERENCES `clients_profile` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `request_to_clients`
--
ALTER TABLE `request_to_clients`
  ADD CONSTRAINT `fk_rtc_client` FOREIGN KEY (`client_profile_id`) REFERENCES `clients_profile` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rtc_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rtc_surveyor` FOREIGN KEY (`surveyor_profile_id`) REFERENCES `surveyors_profile` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `request_to_surveyors`
--
ALTER TABLE `request_to_surveyors`
  ADD CONSTRAINT `fk_rts_client` FOREIGN KEY (`client_profile_id`) REFERENCES `clients_profile` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rts_surveyor` FOREIGN KEY (`surveyor_profile_id`) REFERENCES `surveyors_profile` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `surveyors_profile`
--
ALTER TABLE `surveyors_profile`
  ADD CONSTRAINT `fk_surveyor_user` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
