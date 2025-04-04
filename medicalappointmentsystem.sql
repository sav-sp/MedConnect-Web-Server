-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2025 at 08:09 PM
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
-- Database: `medicalappointmentsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `appointment_status` enum('scheduled','cancelled','completed') NOT NULL DEFAULT 'scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `patient_id`, `doctor_id`, `appointment_date`, `appointment_time`, `appointment_status`) VALUES
(1, 1, 1, '2025-04-05', '15:17:00', 'scheduled'),
(2, 1, 1, '2025-04-09', '15:34:00', 'scheduled'),
(3, 1, 1, '2025-04-22', '14:56:00', 'scheduled'),
(4, 2, 3, '2025-04-07', '13:34:00', 'scheduled'),
(5, 3, 3, '2025-04-14', '17:55:00', 'scheduled');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL,
  `specialization` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctor_id`, `name`, `email`, `password`, `specialization`) VALUES
(1, 'patrick look', 'henriettayeboah@gmail.com', '$2y$10$vyGdfG6CwKe0gpyA6L2rBua79HBAgljHmXlfWnXRgu6DYoUhWVCyS', ''),
(3, 'maria moon', 'mariamoon@gmail.com', '$2y$10$MnWLCXk2ja8D6f8n2mZ8ueD7cGCSvRBbqqA5StFtHBTLIUICZZBnq', ''),
(4, 'jose parez', 'joseparez@gmail.com', '$2y$10$Cj41Pkzu7UhvXarKIP0deemidgBFde5AIKXN7tRLXDQCmXX1U83hO', '');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `name`, `email`, `password`) VALUES
(1, 'Henrietta Yeboah', 'hertyyeb169@gmail.com', '$2y$10$la43mi3lTzLnGFp/o6/5KugGdw.j7HVlSB7g8C.wP5CCGmCc091dG'),
(2, 'jairo', 'jairobrown@gmail.com', '$2y$10$Egz.3S0o/MtlLaSLM.vLrO93z6B6Ag7GeQXv/h.fFhuGqE5T86HOu'),
(3, 'john doe', 'jondoe@gmail.com', '$2y$10$e5DrQjyi3XkcyvtE/QBoIe8gbsXoBkzde92.nl5VwUuWYUkVt53fO');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD UNIQUE KEY `unique_appointment` (`doctor_id`,`appointment_date`,`appointment_time`),
  ADD KEY `patient_ID_idx` (`patient_id`),
  ADD KEY `doctor_id_idx` (`doctor_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
