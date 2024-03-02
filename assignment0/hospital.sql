-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 13, 2024 at 09:05 AM
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
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `companydetails`
-- (See below for the actual view)
--
CREATE TABLE `companydetails` (
`name` varchar(255)
,`company_phone` varchar(20)
,`drug_Trade_name` varchar(100)
,`date` date
,`qty` int(11)
,`formula` text
,`pharmacy_name` varchar(100)
,`price` decimal(10,2)
,`address` text
,`pharmacy_phone` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `contracts_with`
--

CREATE TABLE `contracts_with` (
  `pharmacy_name` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `text` text DEFAULT NULL,
  `supervisor_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contracts_with`
--

INSERT INTO `contracts_with` (`pharmacy_name`, `company_name`, `start_date`, `end_date`, `text`, `supervisor_name`) VALUES
('CityDrugs', 'BioHeal', '2023-01-01', '2024-01-01', 'Contract for exclusive supply', 'John Doe'),
('HerbalHealth', 'GothicPharm', '2023-02-01', '2024-02-01', 'Contract for distribution', 'Jane Smith'),
('MediShop', 'heal123', '2023-03-01', '2024-03-01', 'Annual supply contract', 'Michael Johnson'),
('PharmaCare', 'HealThyself', '2023-04-01', '2024-04-01', 'Contract for new product line', 'Natalie White'),
('WellnessPharma', 'HMM', '2023-05-01', '2024-05-01', 'Long-term partnership agreement', 'Oliver Brown');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `ssn` varchar(255) NOT NULL,
  `doctor_name` varchar(255) DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `Years_exp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`ssn`, `doctor_name`, `specialization`, `Years_exp`) VALUES
('111-22-3333', 'Dr. Smith', 'Cardiology', 15),
('222-33-4444', 'Dr. Johnson', 'Pediatrics', 20),
('333-44-5555', 'Dr. Lee', 'General Medicine', 10),
('3456', 'matilda', 'Hoeoon', 12),
('444-55-6666', 'Dr. Martinez', 'Oncology', 12),
('555-66-7777', 'Dr. Davis', 'Neurology', 18),
('555666777', 'Jonathon Levison', 'Surgery', 12);

-- --------------------------------------------------------

--
-- Stand-in structure for view `doctordetails`
-- (See below for the actual view)
--
CREATE TABLE `doctordetails` (
`ssn` varchar(255)
,`doctor_name` varchar(255)
,`specialization` varchar(255)
,`Years_exp` int(11)
,`name` varchar(255)
,`address` text
,`Age` int(11)
,`drug_Trade_name` varchar(100)
,`company_name` varchar(100)
,`date` date
,`qty` int(11)
,`formula` text
,`pharmacy_name` varchar(100)
,`price` decimal(10,2)
,`PharmacyAddress` text
,`PharmacyPhoneNumber` varchar(20)
,`CompanyPhoneNumber` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `drug`
--

CREATE TABLE `drug` (
  `Trade_name` varchar(255) NOT NULL,
  `formula` text DEFAULT NULL,
  `Company_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `drug`
--

INSERT INTO `drug` (`Trade_name`, `formula`, `Company_name`) VALUES
('AntibioX', 'C22H24N2O8', 'MediSynth'),
('CoughNoMore', 'C18H21NO3', 'HealThyself'),
('FeverDown', 'C8H9NO2', 'BioHeal'),
('HerbalHeal', 'H2O HerbMix', 'NaturalCures'),
('PainAway', 'C20H25N3O', 'GothicPharm');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `ssn` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Pri_physician_ssn` varchar(255) NOT NULL DEFAULT 'NOT NULL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`ssn`, `name`, `address`, `Age`, `Pri_physician_ssn`) VALUES
('123', 'Himanshu Singhal', 'IIT Guwahati', 20, '444-55-6666'),
('3467796875', 'Prakhar Punj', 'IIT Guwahati ', 20, '3456'),
('444-55-6666', 'Charlie Martinez', '202 Pine St, Sometown', 28, '555-66-7777'),
('555-66-7777', 'Bob Lee', '101 Oak Rd, Othercity', 35, '444-55-6666'),
('59842', 'Fiona Gallagher', '143 M.Road Indiana', 24, '555666777'),
('666-77-8888', 'Alice Johnson', '789 Elm St, Anycity', 40, '333-44-5555'),
('68686061', 'James Bond', '234 Bakersville', 45, '555666777'),
('777-88-9999', 'Jane Smith', '456 Maple Ave, Othertown', 25, '222-33-4444'),
('85543', 'Karan Kumawat', 'h1 bakers street london', 20, '333-44-5555'),
('87563431', 'Jesus', 'h1 bakers street london', 23, '111-22-3333'),
('888-99-0000', 'John Doe', '123 Main St, Anytown', 30, '111-22-3333');

-- --------------------------------------------------------

--
-- Stand-in structure for view `patientdetails`
-- (See below for the actual view)
--
CREATE TABLE `patientdetails` (
`id` int(11)
,`SSN` varchar(255)
,`Name` varchar(255)
,`Address` text
,`Age` int(11)
,`PhysicianName` varchar(255)
,`Years_exp` int(11)
,`specialization` varchar(255)
,`DrugName` varchar(255)
,`Company_name` varchar(255)
,`date` date
,`qty` int(11)
,`price` decimal(10,2)
,`PharmacyName` varchar(255)
,`PharmacyAddress` text
,`PharmacyPhone` varchar(20)
,`CompanyPhone` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `pharmaceutical_company`
--

CREATE TABLE `pharmaceutical_company` (
  `name` varchar(255) NOT NULL,
  `Phone_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pharmaceutical_company`
--

INSERT INTO `pharmaceutical_company` (`name`, `Phone_number`) VALUES
('BioHeal', '456-123-7890'),
('GothicPharm', '123-456-7890'),
('heal123', '123'),
('HealThyself', '098-765-4321'),
('HMM', '77733339921'),
('huh', '353456473'),
('MediSynth', '321-654-9870'),
('mmmm', '777333399211'),
('NaturalCures', '789-012-3456');

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `Phone_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`name`, `address`, `Phone_number`) VALUES
('CityDrugs', '789 Pill Blvd, Pharma City', '800-345-6789'),
('HerbalHealth', '202 Plant Rd, Natural City', '800-567-8901'),
('MediShop', '101 Cure St, Remedy Town', '800-456-7890'),
('PharmaCare', '123 Health Rd, Wellness City', '800-123-4567'),
('WellnessPharma', '456 Care Ave, Health Town', '800-234-5678');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pharmacydetails`
-- (See below for the actual view)
--
CREATE TABLE `pharmacydetails` (
`name` varchar(255)
,`address` text
,`Phone_number` varchar(20)
,`drug_Trade_name` varchar(100)
,`company_name` varchar(100)
,`price` decimal(10,2)
,`formula` text
,`start_date` date
,`end_date` date
,`text` text
,`supervisor_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `prescribes`
--

CREATE TABLE `prescribes` (
  `patient_ssn` varchar(20) NOT NULL,
  `doctor_ssn` varchar(20) NOT NULL,
  `drug_Trade_name` varchar(100) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `date` date DEFAULT NULL,
  `qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescribes`
--

INSERT INTO `prescribes` (`patient_ssn`, `doctor_ssn`, `drug_Trade_name`, `company_name`, `date`, `qty`) VALUES
('123', '444-55-6666', 'HerbalHeal', 'NaturalCures', '2024-02-09', 1),
('3467796875', '3456', 'FeverDown', 'BioHeal', '2024-02-11', 7),
('444-55-6666', '555-66-7777', 'HerbalHeal', 'NaturalCures', '2024-05-01', 2),
('555-66-7777', '444-55-6666', 'AntibioX', 'MediSynth', '2024-04-01', 3),
('666-77-8888', '333-44-5555', 'FeverDown', 'BioHeal', '2024-03-01', 1),
('68686061', '555666777', 'CoughNoMore', 'HealThyself', '2024-02-10', 3),
('777-88-9999', '222-33-4444', 'CoughNoMore', 'HealThyself', '2024-02-01', 1),
('888-99-0000', '111-22-3333', 'PainAway', 'GothicPharm', '2024-01-01', 2);

-- --------------------------------------------------------

--
-- Table structure for table `sells`
--

CREATE TABLE `sells` (
  `pharmacy_name` varchar(100) NOT NULL,
  `drug_Trade_name` varchar(100) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sells`
--

INSERT INTO `sells` (`pharmacy_name`, `drug_Trade_name`, `company_name`, `price`) VALUES
('CityDrugs', 'AntibioX', 'MediSynth', 199.99),
('HerbalHealth', 'HerbalHeal', 'NaturalCures', 149.99),
('MediShop', 'CoughNoMore', 'HealThyself', 99.99),
('PharmaCare', 'FeverDown', 'BioHeal', 249.99),
('WellnessPharma', 'PainAway', 'GothicPharm', 299.99);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `role` enum('doctor','patient','company','admin','pharmacy') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `name`, `role`) VALUES
(8, 'kk', '$2y$10$xHmaFL5pHz3QtlVQzjvqq.3BXYfBNb78K.o7.7s.tpJMmqhqoxa2G', 'Karan Kumawat', 'patient'),
(12, 'himanshu-skid19', '$2y$10$WhNY0NzC/LhY32wCMy5MneEytu3X0Lz4HtZsNUVmFvAqlu5WhAFO2', 'Himanshu Singhal', 'patient'),
(14, 'jl123', '$2y$10$qpkqFiDd.13DTAXzAMHP5emft104/yzIYg0AVChyU2VWjdFwIdkri', 'Jonathon Levison', 'doctor'),
(18, 'jim123', '$2y$10$5ncplwkRb1jlfN87K8yUlOrtQd7i1bPNZL9CHYvKU6HtXK2zHejCG', 'Jimmy McGrill', 'company'),
(19, 'daisy123', '$2y$10$cztUPCHCDsPoWGchN0w9EepXvqhMztrBZm5WZnXffpqU9ed98aB/u', 'CityDrugs', 'pharmacy'),
(20, 'kim123', '$2y$10$oL/gSPX8/UwgvLK5A1Q9Lu28vFKQ.U2XekIvFkXYMnuFH3RY7IHiq', 'BioHeal', 'company'),
(21, 'heal123', '$2y$10$YK6JaBDgPQH97Nf1lY.CeO3pg31ovO2v2qdZsD4UHk9X4CqosGi62', 'HealThyself', 'company'),
(22, 'h.singhal', '$2y$10$RXfCs1Pga1/V.kUkwmNOX.vQ9UoyZVo0AL0uW/fLi3hW4UWjW9sLu', 'Himanshu Singhal', 'admin'),
(23, 'pp123', '$2y$10$w3/cup2/nxba8iZgiDuFouZqPu7/ta0TbaTHFRkwGhVhq2A3FClVe', 'Prakhar Punj', 'patient'),
(26, 'kkk123', '$2y$10$HzZ8WMfmsKYqSE0on1kd1..OQINqzRty7BwucJoeyORAUOjrr/L2q', 'Jimmy McGrill', 'doctor');

-- --------------------------------------------------------

--
-- Structure for view `companydetails`
--
DROP TABLE IF EXISTS `companydetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `companydetails`  AS SELECT `p`.`name` AS `name`, `p`.`Phone_number` AS `company_phone`, `pr`.`drug_Trade_name` AS `drug_Trade_name`, `pr`.`date` AS `date`, `pr`.`qty` AS `qty`, `d`.`formula` AS `formula`, `s`.`pharmacy_name` AS `pharmacy_name`, `s`.`price` AS `price`, `pa`.`address` AS `address`, `pa`.`Phone_number` AS `pharmacy_phone` FROM ((((`pharmaceutical_company` `p` join `prescribes` `pr` on(`p`.`name` = `pr`.`company_name`)) join `drug` `d` on(`pr`.`drug_Trade_name` = `d`.`Trade_name`)) join `sells` `s` on(`d`.`Trade_name` = `s`.`drug_Trade_name` and `d`.`Company_name` = `s`.`company_name`)) join `pharmacy` `pa` on(`s`.`pharmacy_name` = `pa`.`name`)) ;

-- --------------------------------------------------------

--
-- Structure for view `doctordetails`
--
DROP TABLE IF EXISTS `doctordetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctordetails`  AS SELECT `d`.`ssn` AS `ssn`, `d`.`doctor_name` AS `doctor_name`, `d`.`specialization` AS `specialization`, `d`.`Years_exp` AS `Years_exp`, `p`.`name` AS `name`, `p`.`address` AS `address`, `p`.`Age` AS `Age`, `pr`.`drug_Trade_name` AS `drug_Trade_name`, `pr`.`company_name` AS `company_name`, `pr`.`date` AS `date`, `pr`.`qty` AS `qty`, `dr`.`formula` AS `formula`, `s`.`pharmacy_name` AS `pharmacy_name`, `s`.`price` AS `price`, `pa`.`address` AS `PharmacyAddress`, `pa`.`Phone_number` AS `PharmacyPhoneNumber`, `c`.`Phone_number` AS `CompanyPhoneNumber` FROM ((((((`doctor` `d` join `patient` `p` on(`p`.`Pri_physician_ssn` = `d`.`ssn`)) join `prescribes` `pr` on(`d`.`ssn` = `pr`.`doctor_ssn`)) join `drug` `dr` on(`pr`.`drug_Trade_name` = `dr`.`Trade_name`)) join `sells` `s` on(`dr`.`Trade_name` = `s`.`drug_Trade_name` and `dr`.`Company_name` = `s`.`company_name`)) join `pharmacy` `pa` on(`s`.`pharmacy_name` = `pa`.`name`)) join `pharmaceutical_company` `c` on(`dr`.`Company_name` = `c`.`name`)) ;

-- --------------------------------------------------------

--
-- Structure for view `patientdetails`
--
DROP TABLE IF EXISTS `patientdetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patientdetails`  AS SELECT `u`.`id` AS `id`, `p`.`ssn` AS `SSN`, `p`.`name` AS `Name`, `p`.`address` AS `Address`, `p`.`Age` AS `Age`, `ph`.`doctor_name` AS `PhysicianName`, `ph`.`Years_exp` AS `Years_exp`, `ph`.`specialization` AS `specialization`, `d`.`Trade_name` AS `DrugName`, `d`.`Company_name` AS `Company_name`, `pr`.`date` AS `date`, `pr`.`qty` AS `qty`, `s`.`price` AS `price`, `pa`.`name` AS `PharmacyName`, `pa`.`address` AS `PharmacyAddress`, `pa`.`Phone_number` AS `PharmacyPhone`, `c`.`Phone_number` AS `CompanyPhone` FROM (((((((`patient` `p` join `users` `u` on(`p`.`name` = `u`.`name`)) join `doctor` `ph` on(`p`.`Pri_physician_ssn` = `ph`.`ssn`)) join `prescribes` `pr` on(`p`.`ssn` = `pr`.`patient_ssn`)) join `drug` `d` on(`pr`.`drug_Trade_name` = `d`.`Trade_name`)) join `sells` `s` on(`d`.`Trade_name` = `s`.`drug_Trade_name` and `d`.`Company_name` = `s`.`company_name`)) join `pharmacy` `pa` on(`s`.`pharmacy_name` = `pa`.`name`)) join `pharmaceutical_company` `c` on(`d`.`Company_name` = `c`.`name`)) ;

-- --------------------------------------------------------

--
-- Structure for view `pharmacydetails`
--
DROP TABLE IF EXISTS `pharmacydetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pharmacydetails`  AS SELECT `ph`.`name` AS `name`, `ph`.`address` AS `address`, `ph`.`Phone_number` AS `Phone_number`, `s`.`drug_Trade_name` AS `drug_Trade_name`, `s`.`company_name` AS `company_name`, `s`.`price` AS `price`, `d`.`formula` AS `formula`, `cw`.`start_date` AS `start_date`, `cw`.`end_date` AS `end_date`, `cw`.`text` AS `text`, `cw`.`supervisor_name` AS `supervisor_name` FROM (((`pharmacy` `ph` join `sells` `s` on(`ph`.`name` = `s`.`pharmacy_name`)) join `drug` `d` on(`s`.`drug_Trade_name` = `d`.`Trade_name`)) join `contracts_with` `cw` on(`cw`.`pharmacy_name` = `ph`.`name`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contracts_with`
--
ALTER TABLE `contracts_with`
  ADD PRIMARY KEY (`pharmacy_name`,`company_name`),
  ADD KEY `company_name` (`company_name`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`ssn`);

--
-- Indexes for table `drug`
--
ALTER TABLE `drug`
  ADD PRIMARY KEY (`Trade_name`,`Company_name`),
  ADD KEY `Company_name` (`Company_name`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`ssn`),
  ADD KEY `Pri_physician_ssn` (`Pri_physician_ssn`);

--
-- Indexes for table `pharmaceutical_company`
--
ALTER TABLE `pharmaceutical_company`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `prescribes`
--
ALTER TABLE `prescribes`
  ADD PRIMARY KEY (`patient_ssn`,`doctor_ssn`,`drug_Trade_name`,`company_name`),
  ADD KEY `doctor_ssn` (`doctor_ssn`),
  ADD KEY `drug_Trade_name` (`drug_Trade_name`,`company_name`);

--
-- Indexes for table `sells`
--
ALTER TABLE `sells`
  ADD PRIMARY KEY (`pharmacy_name`,`drug_Trade_name`,`company_name`),
  ADD KEY `drug_Trade_name` (`drug_Trade_name`,`company_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD KEY `role` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contracts_with`
--
ALTER TABLE `contracts_with`
  ADD CONSTRAINT `contracts_with_ibfk_1` FOREIGN KEY (`pharmacy_name`) REFERENCES `pharmacy` (`name`),
  ADD CONSTRAINT `contracts_with_ibfk_2` FOREIGN KEY (`company_name`) REFERENCES `pharmaceutical_company` (`name`);

--
-- Constraints for table `drug`
--
ALTER TABLE `drug`
  ADD CONSTRAINT `drug_ibfk_1` FOREIGN KEY (`Company_name`) REFERENCES `pharmaceutical_company` (`name`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`Pri_physician_ssn`) REFERENCES `doctor` (`ssn`);

--
-- Constraints for table `prescribes`
--
ALTER TABLE `prescribes`
  ADD CONSTRAINT `prescribes_ibfk_1` FOREIGN KEY (`patient_ssn`) REFERENCES `patient` (`ssn`),
  ADD CONSTRAINT `prescribes_ibfk_2` FOREIGN KEY (`doctor_ssn`) REFERENCES `doctor` (`ssn`),
  ADD CONSTRAINT `prescribes_ibfk_3` FOREIGN KEY (`drug_Trade_name`,`company_name`) REFERENCES `drug` (`Trade_name`, `Company_name`);

--
-- Constraints for table `sells`
--
ALTER TABLE `sells`
  ADD CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`pharmacy_name`) REFERENCES `pharmacy` (`name`),
  ADD CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`drug_Trade_name`,`company_name`) REFERENCES `drug` (`Trade_name`, `Company_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
