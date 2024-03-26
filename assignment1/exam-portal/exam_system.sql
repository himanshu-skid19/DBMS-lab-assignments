-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2024 at 02:09 PM
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
-- Database: `exam_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `dates`
--

CREATE TABLE `dates` (
  `did` varchar(25) NOT NULL,
  `Venue` varchar(255) DEFAULT NULL,
  `Timeslot` varchar(255) NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dates`
--

INSERT INTO `dates` (`did`, `Venue`, `Timeslot`, `Date`) VALUES
('D001', 'Central Library', '09:00-11:00', '2024-03-10'),
('D002', 'West Hall', '12:00-14:00', '2024-03-11'),
('D003', 'East Auditorium', '15:00-17:00', '2024-03-12'),
('D004', 'North Building Room 105', '09:00-11:00', '2024-03-13'),
('D005', 'South Complex Lab 210', '12:00-14:00', '2024-03-14'),
('D006', 'Central Library', '15:00-17:00', '2024-03-15'),
('D007', 'West Hall', '09:00-11:00', '2024-03-16'),
('D008', 'East Auditorium', '12:00-14:00', '2024-03-17'),
('D009', 'North Building Room 105', '15:00-17:00', '2024-03-18'),
('D010', 'South Complex Lab 210', '09:00-11:00', '2024-03-19'),
('D011', 'Core 5', '09:00 - 11:00', '2024-03-27'),
('D012', 'Core 5', '09:00-11:00', '2024-03-28'),
('D012', 'Core 4', '09:00-11:00', '2024-03-30');

-- --------------------------------------------------------

--
-- Table structure for table `evaluators`
--

CREATE TABLE `evaluators` (
  `evid` varchar(500) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `Phone` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluators`
--

INSERT INTO `evaluators` (`evid`, `name`, `Phone`) VALUES
('26534742', 'Himanshu', '8800182654'),
('3465136356', 'Bojack', '23652345');

-- --------------------------------------------------------

--
-- Stand-in structure for view `evaluator_details`
-- (See below for the actual view)
--
CREATE TABLE `evaluator_details` (
`id` int(11)
,`email` varchar(100)
,`password_hash` varchar(255)
,`name` varchar(100)
,`role` enum('student','evaluator','admin')
,`evid` varchar(500)
,`Phone` varchar(25)
);

-- --------------------------------------------------------

--
-- Table structure for table `exam`
--

CREATE TABLE `exam` (
  `eid` varchar(11) NOT NULL,
  `ename` varchar(255) DEFAULT NULL,
  `fees` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam`
--

INSERT INTO `exam` (`eid`, `ename`, `fees`) VALUES
('E001', 'Mathematics 101', 50),
('E002', 'Physics 201', 60),
('E003', 'Chemistry 301', 55),
('E004', 'Biology 401', 70),
('E006', 'World History 202', 50),
('E007', 'Computer Science 101', 65);

-- --------------------------------------------------------

--
-- Table structure for table `exam_choices`
--

CREATE TABLE `exam_choices` (
  `sid` varchar(25) NOT NULL,
  `did` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_choices`
--

INSERT INTO `exam_choices` (`sid`, `did`) VALUES
('123417', 'D002'),
('123417', 'D003'),
('123417', 'D004'),
('123417', 'D007'),
('123417', 'D008'),
('123417', 'D010'),
('132467980', 'D003'),
('1438561', 'D001'),
('1438561', 'D007'),
('1438561', 'D008'),
('1438561', 'D010'),
('220150019', 'D003'),
('23467453254', 'D004'),
('34664', 'D003'),
('354247698', 'D003'),
('r', 'D008');

-- --------------------------------------------------------

--
-- Table structure for table `exam_schedule`
--

CREATE TABLE `exam_schedule` (
  `eid` varchar(11) NOT NULL,
  `did` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_schedule`
--

INSERT INTO `exam_schedule` (`eid`, `did`) VALUES
('E001', 'D003'),
('E002', 'D007'),
('E003', 'D002'),
('E004', 'D010'),
('E006', 'D008'),
('E007', 'D004');

-- --------------------------------------------------------

--
-- Stand-in structure for view `exam_schedule_view`
-- (See below for the actual view)
--
CREATE TABLE `exam_schedule_view` (
`eid` varchar(11)
,`ename` varchar(255)
,`fees` int(11)
,`did` varchar(25)
,`Venue` varchar(255)
,`Timeslot` varchar(255)
,`Date` date
);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `qid` varchar(25) NOT NULL,
  `qcontent` text NOT NULL,
  `qoptions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`qoptions`)),
  `correct_option_id` int(11) DEFAULT NULL,
  `difficulty` enum('1','2','3','4','5') NOT NULL,
  `eid` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`qid`, `qcontent`, `qoptions`, `correct_option_id`, `difficulty`, `eid`) VALUES
('B001', 'What is the basic unit of life?', '[{\"id\": 1, \"text\": \"Atom\"}, \r\n   {\"id\": 2, \"text\": \"Cell\"}, \r\n   {\"id\": 3, \"text\": \"Molecule\"}, \r\n   {\"id\": 4, \"text\": \"Organism\"}]', 2, '1', 'E004'),
('B002', 'Which part of the plant is responsible for photosynthesis?', '[{\"id\": 1, \"text\": \"Root\"}, \r\n   {\"id\": 2, \"text\": \"Stem\"}, \r\n   {\"id\": 3, \"text\": \"Leaf\"}, \r\n   {\"id\": 4, \"text\": \"Flower\"}]', 3, '1', 'E004'),
('B003', 'What is the process by which cells divide to form new cells?', '[{\"id\": 1, \"text\": \"Osmosis\"}, \r\n   {\"id\": 2, \"text\": \"Photosynthesis\"}, \r\n   {\"id\": 3, \"text\": \"Cell division\"}, \r\n   {\"id\": 4, \"text\": \"Fermentation\"}]', 3, '1', 'E004'),
('B004', 'Which molecule carries genetic information?', '[{\"id\": 1, \"text\": \"Protein\"}, \r\n   {\"id\": 2, \"text\": \"Carbohydrate\"}, \r\n   {\"id\": 3, \"text\": \"Lipid\"}, \r\n   {\"id\": 4, \"text\": \"DNA\"}]', 4, '1', 'E004'),
('B005', 'What is the term for an organism\'s ability to maintain stable internal conditions?', '[{\"id\": 1, \"text\": \"Metabolism\"}, \r\n   {\"id\": 2, \"text\": \"Homeostasis\"}, \r\n   {\"id\": 3, \"text\": \"Osmoregulation\"}, \r\n   {\"id\": 4, \"text\": \"Thermoregulation\"}]', 2, '1', 'E004'),
('B006', 'Which kingdom includes multicellular photosynthetic organisms?', '[{\"id\": 1, \"text\": \"Animalia\"}, \r\n   {\"id\": 2, \"text\": \"Fungi\"}, \r\n   {\"id\": 3, \"text\": \"Plantae\"}, \r\n   {\"id\": 4, \"text\": \"Protista\"}]', 3, '1', 'E004'),
('B007', 'What type of biomolecule are enzymes?', '[{\"id\": 1, \"text\": \"Nucleic acids\"}, \r\n   {\"id\": 2, \"text\": \"Proteins\"}, \r\n   {\"id\": 3, \"text\": \"Carbohydrates\"}, \r\n   {\"id\": 4, \"text\": \"Lipids\"}]', 2, '1', 'E004'),
('B008', 'Which system in the human body is responsible for transporting blood throughout the body?', '[{\"id\": 1, \"text\": \"Digestive system\"}, \r\n   {\"id\": 2, \"text\": \"Circulatory system\"}, \r\n   {\"id\": 3, \"text\": \"Nervous system\"}, \r\n   {\"id\": 4, \"text\": \"Endocrine system\"}]', 2, '1', 'E004'),
('B009', 'What are the building blocks of proteins?', '[{\"id\": 1, \"text\": \"Nucleotides\"}, \r\n   {\"id\": 2, \"text\": \"Amino acids\"}, \r\n   {\"id\": 3, \"text\": \"Fatty acids\"}, \r\n   {\"id\": 4, \"text\": \"Monosaccharides\"}]', 2, '1', 'E004'),
('B010', 'Which organelle is known as the \"powerhouse of the cell\"?', '[{\"id\": 1, \"text\": \"Nucleus\"}, \r\n   {\"id\": 2, \"text\": \"Mitochondrion\"}, \r\n   {\"id\": 3, \"text\": \"Chloroplast\"}, \r\n   {\"id\": 4, \"text\": \"Endoplasmic reticulum\"}]', 2, '1', 'E004'),
('B011', 'Which process describes the movement of water across a semipermeable membrane from an area of low solute concentration to an area of high solute concentration?', '[{\"id\": 1, \"text\": \"Diffusion\"}, \r\n   {\"id\": 2, \"text\": \"Osmosis\"}, \r\n   {\"id\": 3, \"text\": \"Active transport\"}, \r\n   {\"id\": 4, \"text\": \"Filtration\"}]', 2, '2', 'E004'),
('B012', 'In genetics, what is the term for the physical appearance or expression of a trait?', '[{\"id\": 1, \"text\": \"Genotype\"}, \r\n   {\"id\": 2, \"text\": \"Phenotype\"}, \r\n   {\"id\": 3, \"text\": \"Allele\"}, \r\n   {\"id\": 4, \"text\": \"Dominance\"}]', 2, '2', 'E004'),
('B013', 'What is the name of the process by which plants convert carbon dioxide and water into glucose and oxygen, using sunlight as energy?', '[{\"id\": 1, \"text\": \"Cellular respiration\"}, \r\n   {\"id\": 2, \"text\": \"Photosynthesis\"}, \r\n   {\"id\": 3, \"text\": \"Fermentation\"}, \r\n   {\"id\": 4, \"text\": \"Transpiration\"}]', 2, '2', 'E004'),
('B014', 'Which cellular organelle is responsible for packaging and distributing proteins and lipids?', '[{\"id\": 1, \"text\": \"Golgi apparatus\"}, \r\n   {\"id\": 2, \"text\": \"Mitochondria\"}, \r\n   {\"id\": 3, \"text\": \"Ribosome\"}, \r\n   {\"id\": 4, \"text\": \"Nucleus\"}]', 1, '2', 'E004'),
('B015', 'What type of cells lack a nucleus and other membrane-bound organelles?', '[{\"id\": 1, \"text\": \"Eukaryotic cells\"}, \r\n   {\"id\": 2, \"text\": \"Prokaryotic cells\"}, \r\n   {\"id\": 3, \"text\": \"Animal cells\"}, \r\n   {\"id\": 4, \"text\": \"Plant cells\"}]', 2, '2', 'E004'),
('B016', 'Which of the following is not a lipid?', '[{\"id\": 1, \"text\": \"Steroid\"}, \r\n   {\"id\": 2, \"text\": \"Triglyceride\"}, \r\n   {\"id\": 3, \"text\": \"Phospholipid\"}, \r\n   {\"id\": 4, \"text\": \"Glycogen\"}]', 4, '2', 'E004'),
('B017', 'What is the main function of the lymphatic system?', '[{\"id\": 1, \"text\": \"To process nutrients from food\"}, \r\n   {\"id\": 2, \"text\": \"To transport blood and oxygen to the cells\"}, \r\n   {\"id\": 3, \"text\": \"To fight infections and maintain fluid balance\"}, \r\n   {\"id\": 4, \"text\": \"To control body temperature\"}]', 3, '2', 'E004'),
('B018', 'Which hormone is primarily responsible for the regulation of blood sugar levels?', '[{\"id\": 1, \"text\": \"Adrenaline\"}, \r\n   {\"id\": 2, \"text\": \"Insulin\"}, \r\n   {\"id\": 3, \"text\": \"Testosterone\"}, \r\n   {\"id\": 4, \"text\": \"Estrogen\"}]', 2, '2', 'E004'),
('B019', 'What term describes the variety of different species within a given area?', '[{\"id\": 1, \"text\": \"Genetic diversity\"}, \r\n   {\"id\": 2, \"text\": \"Species richness\"}, \r\n   {\"id\": 3, \"text\": \"Ecosystem diversity\"}, \r\n   {\"id\": 4, \"text\": \"Biodiversity\"}]', 4, '2', 'E004'),
('B021', 'Which process is responsible for the exchange of gases in the lungs?', '[{\"id\": 1, \"text\": \"Osmosis\"}, \r\n   {\"id\": 2, \"text\": \"Diffusion\"}, \r\n   {\"id\": 3, \"text\": \"Active transport\"}, \r\n   {\"id\": 4, \"text\": \"Filtration\"}]', 2, '3', 'E004'),
('B022', 'In which phase of mitosis do the chromosomes align at the cell’s equatorial plate?', '[{\"id\": 1, \"text\": \"Prophase\"}, \r\n   {\"id\": 2, \"text\": \"Metaphase\"}, \r\n   {\"id\": 3, \"text\": \"Anaphase\"}, \r\n   {\"id\": 4, \"text\": \"Telophase\"}]', 2, '3', 'E004'),
('B023', 'What is the term used to describe the movement of water up against gravity in plants?', '[{\"id\": 1, \"text\": \"Transpiration\"}, \r\n   {\"id\": 2, \"text\": \"Osmosis\"}, \r\n   {\"id\": 3, \"text\": \"Capillary action\"}, \r\n   {\"id\": 4, \"text\": \"Diffusion\"}]', 3, '3', 'E004'),
('B024', 'Which of the following best describes a codon?', '[{\"id\": 1, \"text\": \"A sequence of three nucleotides in tRNA\"}, \r\n   {\"id\": 2, \"text\": \"A sequence of three nucleotides in mRNA that codes for an amino acid\"}, \r\n   {\"id\": 3, \"text\": \"A sequence of three amino acids in a protein\"}, \r\n   {\"id\": 4, \"text\": \"A sequence of three nucleotides in DNA that does not code for an amino acid\"}]', 2, '3', 'E004'),
('B025', 'Which enzyme is responsible for unwinding the DNA double helix during DNA replication?', '[{\"id\": 1, \"text\": \"DNA polymerase\"}, \r\n   {\"id\": 2, \"text\": \"Helicase\"}, \r\n   {\"id\": 3, \"text\": \"Ligase\"}, \r\n   {\"id\": 4, \"text\": \"RNA polymerase\"}]', 2, '3', 'E004'),
('B026', 'What term describes the close and long-term biological interaction between two different biological organisms?', '[{\"id\": 1, \"text\": \"Commensalism\"}, \r\n   {\"id\": 2, \"text\": \"Mutualism\"}, \r\n   {\"id\": 3, \"text\": \"Symbiosis\"}, \r\n   {\"id\": 4, \"text\": \"Parasitism\"}]', 3, '3', 'E004'),
('B027', 'Which part of the brain is primarily responsible for regulating heart rate and breathing?', '[{\"id\": 1, \"text\": \"Cerebrum\"}, \r\n   {\"id\": 2, \"text\": \"Cerebellum\"}, \r\n   {\"id\": 3, \"text\": \"Medulla oblongata\"}, \r\n   {\"id\": 4, \"text\": \"Hypothalamus\"}]', 3, '3', 'E004'),
('B028', 'What is the primary function of the Calvin cycle in photosynthesis?', '[{\"id\": 1, \"text\": \"To produce ATP\"}, \r\n   {\"id\": 2, \"text\": \"To split water molecules\"}, \r\n   {\"id\": 3, \"text\": \"To convert CO2 into glucose\"}, \r\n   {\"id\": 4, \"text\": \"To capture light energy\"}]', 3, '3', 'E004'),
('B029', 'Which of the following is not a component of the cell theory?', '[{\"id\": 1, \"text\": \"All living things are composed of cells\"}, \r\n   {\"id\": 2, \"text\": \"The cell is the basic unit of life\"}, \r\n   {\"id\": 3, \"text\": \"All cells arise from pre-existing cells\"}, \r\n   {\"id\": 4, \"text\": \"Cells can arise spontaneously under the right conditions\"}]', 4, '3', 'E004'),
('B031', 'Which process in eukaryotic cells is responsible for the generation of ribosomal RNA?', '[{\"id\": 1, \"text\": \"Transcription in the nucleus\"}, \r\n   {\"id\": 2, \"text\": \"Translation in the cytoplasm\"}, \r\n   {\"id\": 3, \"text\": \"Replication in the nucleus\"}, \r\n   {\"id\": 4, \"text\": \"Transcription in the nucleolus\"}]', 4, '4', 'E004'),
('B032', 'In the context of molecular genetics, what role does the enzyme topoisomerase play during DNA replication?', '[{\"id\": 1, \"text\": \"It adds nucleotides to the growing DNA strand\"}, \r\n   {\"id\": 2, \"text\": \"It unwinds the double helix\"}, \r\n   {\"id\": 3, \"text\": \"It relieves the tension in the DNA strand by breaking, twisting, and rejoining the DNA strands\"}, \r\n   {\"id\": 4, \"text\": \"It seals the nicks in the sugar-phosphate backbone\"}]', 3, '4', 'E004'),
('B033', 'What is the name given to the model that describes the structure of the plasma membrane as a mosaic of components, including phospholipids, cholesterol, proteins, and carbohydrates?', '[{\"id\": 1, \"text\": \"Fluid mosaic model\"}, \r\n   {\"id\": 2, \"text\": \"Rigid layer model\"}, \r\n   {\"id\": 3, \"text\": \"Dynamic equilibrium model\"}, \r\n   {\"id\": 4, \"text\": \"Solid state model\"}]', 1, '4', 'E004'),
('B034', 'Which of the following best describes the function of microtubules in cellular processes?', '[{\"id\": 1, \"text\": \"They act as tracks for the movement of organelles within the cell\"}, \r\n   {\"id\": 2, \"text\": \"They synthesize proteins\"}, \r\n   {\"id\": 3, \"text\": \"They replicate DNA\"}, \r\n   {\"id\": 4, \"text\": \"They produce ATP\"}]', 1, '4', 'E004'),
('B035', 'In the lac operon of E. coli, what does the presence of lactose in the environment cause?', '[{\"id\": 1, \"text\": \"It binds to the repressor protein, allowing transcription of the lac genes\"}, \r\n   {\"id\": 2, \"text\": \"It increases the degradation of the mRNA coding for the lac genes\"}, \r\n   {\"id\": 3, \"text\": \"It binds directly to the DNA, enhancing the binding of RNA polymerase to the promoter\"}, \r\n   {\"id\": 4, \"text\": \"It acts as a corepressor, facilitating the binding of the repressor to the operator\"}]', 1, '4', 'E004'),
('B036', 'What mechanism do desert plants (such as cacti) use to minimize water loss?', '[{\"id\": 1, \"text\": \"Transpiration\"}, \r\n   {\"id\": 2, \"text\": \"CAM photosynthesis\"}, \r\n   {\"id\": 3, \"text\": \"C4 photosynthesis\"}, \r\n   {\"id\": 4, \"text\": \"Guttation\"}]', 2, '4', 'E004'),
('B037', 'Which principle explains the conservation of energy in a biological system, particularly in energy transfer within and between organisms?', '[{\"id\": 1, \"text\": \"Law of Segregation\"}, \r\n   {\"id\": 2, \"text\": \"Law of Independent Assortment\"}, \r\n   {\"id\": 3, \"text\": \"First Law of Thermodynamics\"}, \r\n   {\"id\": 4, \"text\": \"Second Law of Thermodynamics\"}]', 3, '4', 'E004'),
('B039', 'Which concept explains the phenomenon where a gene at one locus alters the phenotypic expression of a gene at a second locus?', '[{\"id\": 1, \"text\": \"Polygenic inheritance\"}, \r\n   {\"id\": 2, \"text\": \"Epistasis\"}, \r\n   {\"id\": 3, \"text\": \"Pleiotropy\"}, \r\n   {\"id\": 4, \"text\": \"Codominance\"}]', 2, '5', 'E004'),
('B040', 'What is the name of the process by which a cell engulfs a solid particle to form an internal compartment known as a phagosome?', '[{\"id\": 1, \"text\": \"Pinocytosis\"}, \r\n   {\"id\": 2, \"text\": \"Exocytosis\"}, \r\n   {\"id\": 3, \"text\": \"Phagocytosis\"}, \r\n   {\"id\": 4, \"text\": \"Receptor-mediated endocytosis\"}]', 3, '5', 'E004'),
('B041', 'In the study of genetics, what term is used to describe a situation where the phenotype of the heterozygote differs from the phenotypes of both homozygotes?', '[{\"id\": 1, \"text\": \"Incomplete dominance\"}, \r\n   {\"id\": 2, \"text\": \"Co-dominance\"}, \r\n   {\"id\": 3, \"text\": \"Complete dominance\"}, \r\n   {\"id\": 4, \"text\": \"Sex-linked inheritance\"}]', 1, '5', 'E004'),
('B042', 'Which biological process is responsible for the introduction of variation within the gene pool of a population, providing a mechanism for natural selection to increase or decrease frequency of alleles?', '[{\"id\": 1, \"text\": \"Mutation\"}, \r\n   {\"id\": 2, \"text\": \"Genetic drift\"}, \r\n   {\"id\": 3, \"text\": \"Gene flow\"}, \r\n   {\"id\": 4, \"text\": \"Recombination\"}]', 4, '5', 'E004'),
('B043', 'What is the primary mechanism by which prokaryotic cells can acquire new genetic material from their environment, contributing to genetic diversity?', '[{\"id\": 1, \"text\": \"Binary fission\"}, \r\n   {\"id\": 2, \"text\": \"Transformation\"}, \r\n   {\"id\": 3, \"text\": \"Transduction\"}, \r\n   {\"id\": 4, \"text\": \"Conjugation\"}]', 2, '5', 'E004'),
('B044', 'In molecular biology, what is the role of the enzyme reverse transcriptase?', '[{\"id\": 1, \"text\": \"It synthesizes DNA from an RNA template\"}, \r\n   {\"id\": 2, \"text\": \"It replicates DNA\"}, \r\n   {\"id\": 3, \"text\": \"It degrades RNA molecules\"}, \r\n   {\"id\": 4, \"text\": \"It synthesizes RNA from a DNA template\"}]', 1, '5', 'E004'),
('B045', 'What term describes the study of the distribution and determinants of health-related states or events in specified populations, and the application of this study to control health problems?', '[{\"id\": 1, \"text\": \"Genomics\"}, \r\n   {\"id\": 2, \"text\": \"Proteomics\"}, \r\n   {\"id\": 3, \"text\": \"Epidemiology\"}, \r\n   {\"id\": 4, \"text\": \"Ecology\"}]', 3, '5', 'E004'),
('B046', 'Which structure within the vascular plant stem is responsible for the transport of water and nutrients from the roots to the leaves?', '[{\"id\": 1, \"text\": \"Phloem\"}, \r\n   {\"id\": 2, \"text\": \"Xylem\"}, \r\n   {\"id\": 3, \"text\": \"Cortex\"}, \r\n   {\"id\": 4, \"text\": \"Epidermis\"}]', 2, '5', 'E004'),
('C001', 'What is the atomic number of Oxygen?', '[{\"id\": 1, \"text\": \"8\"}, \r\n   {\"id\": 2, \"text\": \"16\"}, \r\n   {\"id\": 3, \"text\": \"2\"}, \r\n   {\"id\": 4, \"text\": \"6\"}]', 1, '1', 'E003'),
('C002', 'Which of the following is a Noble Gas?', '[{\"id\": 1, \"text\": \"Nitrogen\"}, \r\n   {\"id\": 2, \"text\": \"Oxygen\"}, \r\n   {\"id\": 3, \"text\": \"Argon\"}, \r\n   {\"id\": 4, \"text\": \"Hydrogen\"}]', 3, '1', 'E003'),
('C003', 'What type of bond is formed by the sharing of electrons between atoms?', '[{\"id\": 1, \"text\": \"Ionic bond\"}, \r\n   {\"id\": 2, \"text\": \"Covalent bond\"}, \r\n   {\"id\": 3, \"text\": \"Metallic bond\"}, \r\n   {\"id\": 4, \"text\": \"Hydrogen bond\"}]', 2, '1', 'E003'),
('C004', 'What is the pH of a neutral solution at 25°C?', '[{\"id\": 1, \"text\": \"7\"}, \r\n   {\"id\": 2, \"text\": \"0\"}, \r\n   {\"id\": 3, \"text\": \"14\"}, \r\n   {\"id\": 4, \"text\": \"1\"}]', 1, '1', 'E003'),
('C005', 'Which element is known as the \"king of chemicals\" for its extensive use in chemical industry?', '[{\"id\": 1, \"text\": \"Oxygen\"}, \r\n   {\"id\": 2, \"text\": \"Hydrogen\"}, \r\n   {\"id\": 3, \"text\": \"Sulfur\"}, \r\n   {\"id\": 4, \"text\": \"Chlorine\"}]', 4, '2', 'E003'),
('C006', 'What is the main product of the reaction between an acid and a base?', '[{\"id\": 1, \"text\": \"Salt\"}, \r\n   {\"id\": 2, \"text\": \"Water\"}, \r\n   {\"id\": 3, \"text\": \"Both A and B\"}, \r\n   {\"id\": 4, \"text\": \"Hydrogen gas\"}]', 3, '2', 'E003'),
('C007', 'Which of the following is not a characteristic of chemical changes?', '[{\"id\": 1, \"text\": \"Formation of a precipitate\"}, \r\n   {\"id\": 2, \"text\": \"Change in temperature\"}, \r\n   {\"id\": 3, \"text\": \"Change in state of matter\"}, \r\n   {\"id\": 4, \"text\": \"Release or absorption of energy\"}]', 3, '2', 'E003'),
('C008', 'What principle states that in a chemical reaction, matter is neither created nor destroyed?', '[{\"id\": 1, \"text\": \"Principle of conservation of mass\"}, \r\n   {\"id\": 2, \"text\": \"Dalton\'s atomic theory\"}, \r\n   {\"id\": 3, \"text\": \"Avogadro\'s law\"}, \r\n   {\"id\": 4, \"text\": \"Principle of conservation of energy\"}]', 1, '1', 'E003'),
('C009', 'In organic chemistry, what is the term used for compounds containing only carbon and hydrogen?', '[{\"id\": 1, \"text\": \"Alcohols\"}, \r\n   {\"id\": 2, \"text\": \"Carboxylic acids\"}, \r\n   {\"id\": 3, \"text\": \"Hydrocarbons\"}, \r\n   {\"id\": 4, \"text\": \"Esters\"}]', 3, '1', 'E003'),
('C011', 'Which of the following elements has the highest electronegativity?', '[{\"id\": 1, \"text\": \"Sodium\"}, \r\n   {\"id\": 2, \"text\": \"Chlorine\"}, \r\n   {\"id\": 3, \"text\": \"Fluorine\"}, \r\n   {\"id\": 4, \"text\": \"Oxygen\"}]', 3, '2', 'E003'),
('C012', 'What is the primary factor that determines the state of matter?', '[{\"id\": 1, \"text\": \"Atomic mass\"}, \r\n   {\"id\": 2, \"text\": \"Temperature\"}, \r\n   {\"id\": 3, \"text\": \"Electronegativity\"}, \r\n   {\"id\": 4, \"text\": \"Ionization energy\"}]', 2, '2', 'E003'),
('C013', 'In the context of solutions, what does \"solute\" refer to?', '[{\"id\": 1, \"text\": \"The substance in which the solute is dissolved\"}, \r\n   {\"id\": 2, \"text\": \"The substance that is dissolved in the solvent\"}, \r\n   {\"id\": 3, \"text\": \"A solution that cannot dissolve more solute\"}, \r\n   {\"id\": 4, \"text\": \"The process of dissolving a solute in a solvent\"}]', 2, '2', 'E003'),
('C014', 'Which law states that the volume of a gas at constant temperature varies inversely with the pressure?', '[{\"id\": 1, \"text\": \"Charles\'s Law\"}, \r\n   {\"id\": 2, \"text\": \"Boyle\'s Law\"}, \r\n   {\"id\": 3, \"text\": \"Gay-Lussac\'s Law\"}, \r\n   {\"id\": 4, \"text\": \"Avogadro\'s Law\"}]', 2, '2', 'E003'),
('C015', 'What type of chemical reaction involves the exchange of ions between two compounds?', '[{\"id\": 1, \"text\": \"Combustion reaction\"}, \r\n   {\"id\": 2, \"text\": \"Synthesis reaction\"}, \r\n   {\"id\": 3, \"text\": \"Decomposition reaction\"}, \r\n   {\"id\": 4, \"text\": \"Double displacement reaction\"}]', 4, '3', 'E003'),
('C016', 'What is the molarity of a solution containing 40 grams of NaOH in 2 liters of water? (Molecular weight of NaOH = 40 g/mol)', '[{\"id\": 1, \"text\": \"0.5 M\"}, \r\n   {\"id\": 2, \"text\": \"1.0 M\"}, \r\n   {\"id\": 3, \"text\": \"2.0 M\"}, \r\n   {\"id\": 4, \"text\": \"0.25 M\"}]', 1, '3', 'E003'),
('C017', 'Which of the following is not a characteristic of oxidation reactions?', '[{\"id\": 1, \"text\": \"Loss of electrons\"}, \r\n   {\"id\": 2, \"text\": \"Gain of electrons\"}, \r\n   {\"id\": 3, \"text\": \"Increase in oxidation state\"}, \r\n   {\"id\": 4, \"text\": \"Release of energy\"}]', 2, '2', 'E003'),
('C018', 'What is the common name for the compound H2O2?', '[{\"id\": 1, \"text\": \"Water\"}, \r\n   {\"id\": 2, \"text\": \"Hydrogen peroxide\"}, \r\n   {\"id\": 3, \"text\": \"Hydrochloric acid\"}, \r\n   {\"id\": 4, \"text\": \"Hydroxide\"}]', 2, '2', 'E003'),
('C019', 'In chemistry, what is the term used for a liquid that can dissolve other substances?', '[{\"id\": 1, \"text\": \"Solvent\"}, \r\n   {\"id\": 2, \"text\": \"Solute\"}, \r\n   {\"id\": 3, \"text\": \"Solution\"}, \r\n   {\"id\": 4, \"text\": \"Suspension\"}]', 1, '2', 'E003'),
('C021', 'Which process describes the spontaneous emission of particles from an unstable nucleus?', '[{\"id\": 1, \"text\": \"Fission\"}, \r\n   {\"id\": 2, \"text\": \"Fusion\"}, \r\n   {\"id\": 3, \"text\": \"Radioactivity\"}, \r\n   {\"id\": 4, \"text\": \"Decomposition\"}]', 3, '4', 'E003'),
('C022', 'What is the name of the law that states the total pressure of a mixture of gases is equal to the sum of the pressures of all the gases in the mixture?', '[{\"id\": 1, \"text\": \"Dalton\'s law of partial pressures\"}, \r\n   {\"id\": 2, \"text\": \"Boyle\'s law\"}, \r\n   {\"id\": 3, \"text\": \"Charles\'s law\"}, \r\n   {\"id\": 4, \"text\": \"Avogadro\'s law\"}]', 1, '4', 'E003'),
('C023', 'Which of the following elements has the highest electronegativity?', '[{\"id\": 1, \"text\": \"Fluorine\"}, \r\n   {\"id\": 2, \"text\": \"Oxygen\"}, \r\n   {\"id\": 3, \"text\": \"Nitrogen\"}, \r\n   {\"id\": 4, \"text\": \"Chlorine\"}]', 1, '4', 'E003'),
('C024', 'In organic chemistry, what type of reaction involves the exchange of parts between two reactants to give two new products?', '[{\"id\": 1, \"text\": \"Addition reaction\"}, \r\n   {\"id\": 2, \"text\": \"Substitution reaction\"}, \r\n   {\"id\": 3, \"text\": \"Elimination reaction\"}, \r\n   {\"id\": 4, \"text\": \"Metathesis reaction\"}]', 4, '4', 'E003'),
('C025', 'What term is used to describe the 3D arrangement of atoms within a molecule that is formed by rotation around a single bond?', '[{\"id\": 1, \"text\": \"Conformation\"}, \r\n   {\"id\": 2, \"text\": \"Configuration\"}, \r\n   {\"id\": 3, \"text\": \"Isomerization\"}, \r\n   {\"id\": 4, \"text\": \"Stereochemistry\"}]', 1, '4', 'E003'),
('C026', 'Which of the following is a characteristic feature of a catalyst?', '[{\"id\": 1, \"text\": \"It is consumed in the reaction\"}, \r\n   {\"id\": 2, \"text\": \"It increases the reaction rate without being consumed\"}, \r\n   {\"id\": 3, \"text\": \"It is always a solid\"}, \r\n   {\"id\": 4, \"text\": \"It decreases the reaction rate\"}]', 2, '4', 'E003'),
('C027', 'What is the principle behind chromatography?', '[{\"id\": 1, \"text\": \"Separation based on boiling points\"}, \r\n   {\"id\": 2, \"text\": \"Separation based on molecular size\"}, \r\n   {\"id\": 3, \"text\": \"Separation based on solubility and adsorption\"}, \r\n   {\"id\": 4, \"text\": \"Separation based on electrical charge\"}]', 3, '4', 'E003'),
('C028', 'Which law relates the rate of a chemical reaction to the concentration of the reactants?', '[{\"id\": 1, \"text\": \"Law of mass action\"}, \r\n   {\"id\": 2, \"text\": \"Rate law\"}, \r\n   {\"id\": 3, \"text\": \"Henry\'s law\"}, \r\n   {\"id\": 4, \"text\": \"Dalton\'s law\"}]', 2, '4', 'E003'),
('C029', 'What is the term for a solid that is formed and precipitated out of a liquid solution?', '[{\"id\": 1, \"text\": \"Solute\"}, \r\n   {\"id\": 2, \"text\": \"Solvent\"}, \r\n   {\"id\": 3, \"text\": \"Precipitate\"}, \r\n   {\"id\": 4, \"text\": \"Supersaturated solution\"}]', 3, '4', 'E003'),
('C030', 'Which of the following molecules is an example of a chelating agent?', '[{\"id\": 1, \"text\": \"Sodium chloride\"}, \r\n   {\"id\": 2, \"text\": \"Ethylene diamine tetraacetic acid (EDTA)\"}, \r\n   {\"id\": 3, \"text\": \"Methane\"}, \r\n   {\"id\": 4, \"text\": \"Water\"}]', 2, '4', 'E003'),
('C031', 'What is the name of the effect observed when the direction of spin of electrons in atoms or molecules is affected by an external magnetic field?', '[{\"id\": 1, \"text\": \"Zeeman Effect\"}, \r\n   {\"id\": 2, \"text\": \"Stark Effect\"}, \r\n   {\"id\": 3, \"text\": \"Photoelectric Effect\"}, \r\n   {\"id\": 4, \"text\": \"Compton Effect\"}]', 1, '4', 'E003'),
('C032', 'Which term describes the ability of a substance to absorb moisture from the air?', '[{\"id\": 1, \"text\": \"Hygroscopy\"}, \r\n   {\"id\": 2, \"text\": \"Efflorescence\"}, \r\n   {\"id\": 3, \"text\": \"Deliquescence\"}, \r\n   {\"id\": 4, \"text\": \"Desiccation\"}]', 3, '4', 'E003'),
('C033', 'In organometallic chemistry, what term refers to the cyclic coordination of two or more atoms to a metal atom?', '[{\"id\": 1, \"text\": \"Chelation\"}, \r\n   {\"id\": 2, \"text\": \"Coordination\"}, \r\n   {\"id\": 3, \"text\": \"Complexation\"}, \r\n   {\"id\": 4, \"text\": \"Hapticity\"}]', 4, '4', 'E003'),
('C034', 'What type of isomerism is due to the restriction of rotation around a bond, as seen in certain alkenes and aromatic compounds?', '[{\"id\": 1, \"text\": \"Geometric isomerism\"}, \r\n   {\"id\": 2, \"text\": \"Optical isomerism\"}, \r\n   {\"id\": 3, \"text\": \"Linkage isomerism\"}, \r\n   {\"id\": 4, \"text\": \"Coordination isomerism\"}]', 1, '4', 'E003'),
('C035', 'Which compound is used as a primary standard in volumetric analysis due to its high purity and stability?', '[{\"id\": 1, \"text\": \"Sodium chloride\"}, \r\n   {\"id\": 2, \"text\": \"Potassium permanganate\"}, \r\n   {\"id\": 3, \"text\": \"Sodium carbonate\"}, \r\n   {\"id\": 4, \"text\": \"Hydrochloric acid\"}]', 3, '4', 'E003'),
('C036', 'What phenomenon explains the splitting of a spectral line into several components in the presence of a static magnetic field?', '[{\"id\": 1, \"text\": \"Hyperfine splitting\"}, \r\n   {\"id\": 2, \"text\": \"Spin-orbit coupling\"}, \r\n   {\"id\": 3, \"text\": \"Magnetic resonance\"}, \r\n   {\"id\": 4, \"text\": \"Zeeman Effect\"}]', 4, '4', 'E003'),
('C037', 'Which of the following is not a type of crystalline solid?', '[{\"id\": 1, \"text\": \"Ionic solid\"}, \r\n   {\"id\": 2, \"text\": \"Metallic solid\"}, \r\n   {\"id\": 3, \"text\": \"Covalent network solid\"}, \r\n   {\"id\": 4, \"text\": \"Amorphous solid\"}]', 4, '4', 'E003'),
('C038', 'What is the term for the scattering of light by particles in a colloid or else particles in a very fine suspension?', '[{\"id\": 1, \"text\": \"Reflection\"}, \r\n   {\"id\": 2, \"text\": \"Refraction\"}, \r\n   {\"id\": 3, \"text\": \"Tyndall effect\"}, \r\n   {\"id\": 4, \"text\": \"Diffraction\"}]', 3, '4', 'E003'),
('C041', 'What is the phenomenon where electrons are shared between more than two atoms, often seen in metal clusters?', '[{\"id\": 1, \"text\": \"Delocalized covalent bonding\"}, \r\n   {\"id\": 2, \"text\": \"Hybridization\"}, \r\n   {\"id\": 3, \"text\": \"Dative bonding\"}, \r\n   {\"id\": 4, \"text\": \"Electron sea model\"}]', 1, '5', 'E003'),
('C042', 'In quantum chemistry, what term describes the mathematical functions used to describe the spatial orientation and energy of electrons?', '[{\"id\": 1, \"text\": \"Orbitals\"}, \r\n   {\"id\": 2, \"text\": \"Quantum numbers\"}, \r\n   {\"id\": 3, \"text\": \"Electron configurations\"}, \r\n   {\"id\": 4, \"text\": \"Wave functions\"}]', 4, '5', 'E003'),
('C043', 'Which principle explains the impossibility of simultaneously determining both the position and velocity of an electron?', '[{\"id\": 1, \"text\": \"Pauli exclusion principle\"}, \r\n   {\"id\": 2, \"text\": \"Heisenberg uncertainty principle\"}, \r\n   {\"id\": 3, \"text\": \"Aufbau principle\"}, \r\n   {\"id\": 4, \"text\": \"Hund\'s rule\"}]', 2, '5', 'E003'),
('C044', 'What is the term for the arrangement of atoms in a crystal lattice that can result in different physical properties despite having the same chemical composition?', '[{\"id\": 1, \"text\": \"Isotropy\"}, \r\n   {\"id\": 2, \"text\": \"Polymorphism\"}, \r\n   {\"id\": 3, \"text\": \"Allotropy\"}, \r\n   {\"id\": 4, \"text\": \"Anisotropy\"}]', 2, '5', 'E003'),
('C045', 'Which of the following reactions is an example of a pericyclic reaction?', '[{\"id\": 1, \"text\": \"Diels-Alder reaction\"}, \r\n   {\"id\": 2, \"text\": \"Sn2 reaction\"}, \r\n   {\"id\": 3, \"text\": \"Esterification\"}, \r\n   {\"id\": 4, \"text\": \"Friedel-Crafts alkylation\"}]', 1, '5', 'E003'),
('C046', 'In stereochemistry, what term refers to the stereoisomers that are not mirror images of each other?', '[{\"id\": 1, \"text\": \"Enantiomers\"}, \r\n   {\"id\": 2, \"text\": \"Diastereomers\"}, \r\n   {\"id\": 3, \"text\": \"Anomers\"}, \r\n   {\"id\": 4, \"text\": \"Epimers\"}]', 2, '5', 'E003'),
('C047', 'What is the name of the rule used to predict the feasibility of a thermodynamic process or reaction, involving both enthalpy and entropy changes?', '[{\"id\": 1, \"text\": \"Le Chatelier\'s principle\"}, \r\n   {\"id\": 2, \"text\": \"Gibbs free energy rule\"}, \r\n   {\"id\": 3, \"text\": \"Hess\'s law\"}, \r\n   {\"id\": 4, \"text\": \"Arrhenius equation\"}]', 2, '5', 'E003'),
('C048', 'Which concept in chemical kinetics provides a deeper understanding of the rate at which reactions approach equilibrium?', '[{\"id\": 1, \"text\": \"Collision theory\"}, \r\n   {\"id\": 2, \"text\": \"Transition state theory\"}, \r\n   {\"id\": 3, \"text\": \"Rate law\"}, \r\n   {\"id\": 4, \"text\": \"Arrhenius equation\"}]', 2, '5', 'E003'),
('CS001', 'What does CPU stand for in the context of computing?', '[{\"id\": 1, \"text\": \"Central Processing Unit\"}, \r\n   {\"id\": 2, \"text\": \"Computer Personal Unit\"}, \r\n   {\"id\": 3, \"text\": \"Central Performance Unit\"}, \r\n   {\"id\": 4, \"text\": \"Computer Processing Unit\"}]', 1, '1', 'E007'),
('CS002', 'Which of the following is a markup language used to create web pages?', '[{\"id\": 1, \"text\": \"HTML\"}, \r\n   {\"id\": 2, \"text\": \"C++\"}, \r\n   {\"id\": 3, \"text\": \"Python\"}, \r\n   {\"id\": 4, \"text\": \"Java\"}]', 1, '1', 'E007'),
('CS003', 'What is the primary function of an operating system?', '[{\"id\": 1, \"text\": \"To manage the computer\'s hardware and software resources\"}, \r\n   {\"id\": 2, \"text\": \"To create software applications\"}, \r\n   {\"id\": 3, \"text\": \"To protect the computer against viruses\"}, \r\n   {\"id\": 4, \"text\": \"To process user input\"}]', 1, '1', 'E007'),
('CS004', 'Which device is used as a primary input device for a computer?', '[{\"id\": 1, \"text\": \"Monitor\"}, \r\n   {\"id\": 2, \"text\": \"Keyboard\"}, \r\n   {\"id\": 3, \"text\": \"Mouse\"}, \r\n   {\"id\": 4, \"text\": \"Printer\"}]', 2, '1', 'E007'),
('CS005', 'What does RAM stand for?', '[{\"id\": 1, \"text\": \"Read Access Memory\"}, \r\n   {\"id\": 2, \"text\": \"Random Access Memory\"}, \r\n   {\"id\": 3, \"text\": \"Run Access Memory\"}, \r\n   {\"id\": 4, \"text\": \"Random Allocation Memory\"}]', 2, '1', 'E007'),
('CS006', 'Which of the following is a widely used operating system?', '[{\"id\": 1, \"text\": \"Google\"}, \r\n   {\"id\": 2, \"text\": \"Windows\"}, \r\n   {\"id\": 3, \"text\": \"Firefox\"}, \r\n   {\"id\": 4, \"text\": \"Safari\"}]', 2, '1', 'E007'),
('CS007', 'In computer science, what is an algorithm?', '[{\"id\": 1, \"text\": \"A problem in a computer system\"}, \r\n   {\"id\": 2, \"text\": \"A list of computer hardware\"}, \r\n   {\"id\": 3, \"text\": \"A set of instructions for solving a problem or completing a process\"}, \r\n   {\"id\": 4, \"text\": \"A type of computer software\"}]', 3, '1', 'E007'),
('CS008', 'Which term refers to the physical components of a computer?', '[{\"id\": 1, \"text\": \"Software\"}, \r\n   {\"id\": 2, \"text\": \"Hardware\"}, \r\n   {\"id\": 3, \"text\": \"Firmware\"}, \r\n   {\"id\": 4, \"text\": \"Middleware\"}]', 2, '1', 'E007'),
('CS009', 'Which data structure uses a FIFO (First In, First Out) method?', '[{\"id\": 1, \"text\": \"Array\"}, \r\n   {\"id\": 2, \"text\": \"Stack\"}, \r\n   {\"id\": 3, \"text\": \"Queue\"}, \r\n   {\"id\": 4, \"text\": \"Linked List\"}]', 3, '2', 'E007'),
('CS010', 'What is the purpose of a primary key in a database?', '[{\"id\": 1, \"text\": \"To unlock the database\"}, \r\n   {\"id\": 2, \"text\": \"To identify a column as a sort order\"}, \r\n   {\"id\": 3, \"text\": \"To uniquely identify a record in a table\"}, \r\n   {\"id\": 4, \"text\": \"To secure the database with encryption\"}]', 3, '2', 'E007'),
('CS011', 'In object-oriented programming, what is encapsulation?', '[{\"id\": 1, \"text\": \"The process of converting one type of object into another\"}, \r\n   {\"id\": 2, \"text\": \"The practice of keeping fields within a class private, then providing access to them via public methods\"}, \r\n   {\"id\": 3, \"text\": \"A concept where a class inherits the properties of another class\"}, \r\n   {\"id\": 4, \"text\": \"A technique for defining multiple methods with the same name but different parameters\"}]', 2, '2', 'E007'),
('CS012', 'Which protocol is primarily used for sending email?', '[{\"id\": 1, \"text\": \"HTTP\"}, \r\n   {\"id\": 2, \"text\": \"SMTP\"}, \r\n   {\"id\": 3, \"text\": \"FTP\"}, \r\n   {\"id\": 4, \"text\": \"TCP\"}]', 2, '2', 'E007'),
('CS013', 'What does the term \"polymorphism\" refer to in object-oriented programming?', '[{\"id\": 1, \"text\": \"The ability of different classes to respond to the same message in different ways\"}, \r\n   {\"id\": 2, \"text\": \"A class that can be used to create multiple objects of different types\"}, \r\n   {\"id\": 3, \"text\": \"A single function or method that works in different ways based on the object it is called on\"}, \r\n   {\"id\": 4, \"text\": \"The concept of designing classes to share behaviors\"}]', 1, '2', 'E007'),
('CS014', 'What is a recursive function in programming?', '[{\"id\": 1, \"text\": \"A function that calls itself\"}, \r\n   {\"id\": 2, \"text\": \"A function that loops through data\"}, \r\n   {\"id\": 3, \"text\": \"A function used to directly manipulate hardware\"}, \r\n   {\"id\": 4, \"text\": \"A function that can only be called once\"}]', 1, '2', 'E007'),
('CS015', 'Which of these is not a valid IPv4 address?', '[{\"id\": 1, \"text\": \"192.168.1.1\"}, \r\n   {\"id\": 2, \"text\": \"256.100.50.25\"}, \r\n   {\"id\": 3, \"text\": \"10.0.0.1\"}, \r\n   {\"id\": 4, \"text\": \"172.16.254.1\"}]', 2, '2', 'E007'),
('CS016', 'In software development, what is \"Agile\" methodology?', '[{\"id\": 1, \"text\": \"A type of software that adjusts to the user\'s needs automatically\"}, \r\n   {\"id\": 2, \"text\": \"A programming language that is easy to learn\"}, \r\n   {\"id\": 3, \"text\": \"A set of practices for software development where requirements and solutions evolve through the collaborative effort of self-organizing and cross-functional teams\"}, \r\n   {\"id\": 4, \"text\": \"A hardware design philosophy that emphasizes speed and flexibility\"}]', 3, '2', 'E007'),
('CS017', 'What is the Big O notation used to describe?', '[{\"id\": 1, \"text\": \"The maximum size of an input for an algorithm\"}, \r\n   {\"id\": 2, \"text\": \"The minimum time required for an algorithm to complete\"}, \r\n   {\"id\": 3, \"text\": \"The performance or complexity of an algorithm in terms of time and space\"}, \r\n   {\"id\": 4, \"text\": \"The user interface complexity\"}]', 3, '3', 'E007'),
('CS018', 'In computer networking, what is a subnet mask used for?', '[{\"id\": 1, \"text\": \"To identify the network interface card\"}, \r\n   {\"id\": 2, \"text\": \"To encrypt data packets\"}, \r\n   {\"id\": 3, \"text\": \"To divide an IP address into network and host addresses\"}, \r\n   {\"id\": 4, \"text\": \"To mask the IP address of a subnet from other subnets\"}]', 3, '3', 'E007'),
('CS019', 'Which sorting algorithm is considered the fastest in terms of average-case complexity?', '[{\"id\": 1, \"text\": \"Bubble Sort\"}, \r\n   {\"id\": 2, \"text\": \"Insertion Sort\"}, \r\n   {\"id\": 3, \"text\": \"Quick Sort\"}, \r\n   {\"id\": 4, \"text\": \"Merge Sort\"}]', 3, '3', 'E007'),
('CS020', 'What does SSL/TLS provide for data transmission over the Internet?', '[{\"id\": 1, \"text\": \"Compression\"}, \r\n   {\"id\": 2, \"text\": \"Encryption\"}, \r\n   {\"id\": 3, \"text\": \"Speed\"}, \r\n   {\"id\": 4, \"text\": \"Routing\"}]', 2, '3', 'E007'),
('CS021', 'In the context of databases, what is ACID a shorthand for?', '[{\"id\": 1, \"text\": \"Atomicity, Consistency, Isolation, Durability\"}, \r\n   {\"id\": 2, \"text\": \"Accuracy, Completeness, Integrity, Durability\"}, \r\n   {\"id\": 3, \"text\": \"Atomicity, Completeness, Isolation, Dependability\"}, \r\n   {\"id\": 4, \"text\": \"Accuracy, Consistency, Isolation, Dependability\"}]', 1, '3', 'E007'),
('CS022', 'Which data structure is primarily used to implement a recursive algorithm?', '[{\"id\": 1, \"text\": \"Queue\"}, \r\n   {\"id\": 2, \"text\": \"Stack\"}, \r\n   {\"id\": 3, \"text\": \"Array\"}, \r\n   {\"id\": 4, \"text\": \"Linked List\"}]', 2, '3', 'E007'),
('CS023', 'What principle does the REST architectural style emphasize for distributed systems?', '[{\"id\": 1, \"text\": \"Stateful operations\"}, \r\n   {\"id\": 2, \"text\": \"Stateless communication\"}, \r\n   {\"id\": 3, \"text\": \"Protocol dependence\"}, \r\n   {\"id\": 4, \"text\": \"Complex interface design\"}]', 2, '3', 'E007'),
('CS024', 'In software engineering, what does the term \"refactoring\" primarily refer to?', '[{\"id\": 1, \"text\": \"The process of changing a software system in such a way that it does not alter the external behavior of the code yet improves its internal structure\"}, \r\n   {\"id\": 2, \"text\": \"Expanding the functionality of a software system\"}, \r\n   {\"id\": 3, \"text\": \"Reducing the size of the codebase\"}, \r\n   {\"id\": 4, \"text\": \"Converting the software to run on different platforms\"}]', 1, '3', 'E007'),
('CS025', 'Which algorithmic technique is best suited for solving problems with optimal substructure and overlapping subproblems?', '[{\"id\": 1, \"text\": \"Divide and Conquer\"}, \r\n   {\"id\": 2, \"text\": \"Dynamic Programming\"}, \r\n   {\"id\": 3, \"text\": \"Greedy Method\"}, \r\n   {\"id\": 4, \"text\": \"Backtracking\"}]', 2, '4', 'E007'),
('CS026', 'In the context of database systems, what does the term \"sharding\" refer to?', '[{\"id\": 1, \"text\": \"Encrypting database contents for security\"}, \r\n   {\"id\": 2, \"text\": \"Distributing portions of a database across multiple servers\"}, \r\n   {\"id\": 3, \"text\": \"Fragmenting a database to improve performance\"}, \r\n   {\"id\": 4, \"text\": \"Creating a backup of the database\"}]', 2, '4', 'E007'),
('CS027', 'What is a Bloom filter primarily used for in computer science?', '[{\"id\": 1, \"text\": \"Data compression\"}, \r\n   {\"id\": 2, \"text\": \"Error detection in network transmission\"}, \r\n   {\"id\": 3, \"text\": \"Probabilistic data structure for membership query\"}, \r\n   {\"id\": 4, \"text\": \"Encrypting data for secure transmission\"}]', 3, '4', 'E007'),
('CS028', 'Which of these is not a characteristic feature of microservices architecture?', '[{\"id\": 1, \"text\": \"Highly decentralized\"}, \r\n   {\"id\": 2, \"text\": \"Uses a shared database for all services\"}, \r\n   {\"id\": 3, \"text\": \"Built around business capabilities\"}, \r\n   {\"id\": 4, \"text\": \"Independently deployable services\"}]', 2, '4', 'E007'),
('CS029', 'In machine learning, what is \"overfitting\"?', '[{\"id\": 1, \"text\": \"When a model is too simple to capture the underlying pattern\"}, \r\n   {\"id\": 2, \"text\": \"When a model performs well on training data but poorly on unseen data\"}, \r\n   {\"id\": 3, \"text\": \"When too much data is used for training the model\"}, \r\n   {\"id\": 4, \"text\": \"When the model is trained for an insufficient amount of time\"}]', 2, '4', 'E007'),
('CS030', 'Which concept in distributed systems refers to the challenge of achieving consistency across multiple nodes while still ensuring availability and partition tolerance?', '[{\"id\": 1, \"text\": \"CAP theorem\"}, \r\n   {\"id\": 2, \"text\": \"ACID properties\"}, \r\n   {\"id\": 3, \"text\": \"BASE theorem\"}, \r\n   {\"id\": 4, \"text\": \"Raft consensus algorithm\"}]', 1, '4', 'E007'),
('CS031', 'What is the main advantage of using a graph database over a relational database?', '[{\"id\": 1, \"text\": \"Faster read and write speeds for all types of data\"}, \r\n   {\"id\": 2, \"text\": \"More efficient storage of large volumes of data\"}, \r\n   {\"id\": 3, \"text\": \"Better performance for interconnected data and complex queries\"}, \r\n   {\"id\": 4, \"text\": \"Simpler syntax and structure for database queries\"}]', 3, '4', 'E007'),
('CS032', 'In the field of cryptography, what does \"nonce\" stand for?', '[{\"id\": 1, \"text\": \"Number Once\"}, \r\n   {\"id\": 2, \"text\": \"New Coin\"}, \r\n   {\"id\": 3, \"text\": \"Number used ONCE\"}, \r\n   {\"id\": 4, \"text\": \"No ONCE\"}]', 3, '4', 'E007'),
('CS033', 'What principle underlies the functioning of quantum computers?', '[{\"id\": 1, \"text\": \"Binary superposition\"}, \r\n   {\"id\": 2, \"text\": \"Quantum entanglement\"}, \r\n   {\"id\": 3, \"text\": \"Electron pairing\"}, \r\n   {\"id\": 4, \"text\": \"Both A and B are correct\"}]', 4, '5', 'E007'),
('CS034', 'In computational complexity theory, what class does the problem of determining whether a given Boolean formula is satisfiable belong to?', '[{\"id\": 1, \"text\": \"P\"}, \r\n   {\"id\": 2, \"text\": \"NP\"}, \r\n   {\"id\": 3, \"text\": \"NP-Complete\"}, \r\n   {\"id\": 4, \"text\": \"NP-Hard\"}]', 3, '5', 'E007'),
('CS035', 'Which hashing algorithm is considered secure for cryptographic purposes as of my last update?', '[{\"id\": 1, \"text\": \"MD5\"}, \r\n   {\"id\": 2, \"text\": \"SHA-256\"}, \r\n   {\"id\": 3, \"text\": \"SHA-1\"}, \r\n   {\"id\": 4, \"text\": \"RSA\"}]', 2, '5', 'E007'),
('CS036', 'In the field of artificial intelligence, what does the \"No Free Lunch\" theorem state?', '[{\"id\": 1, \"text\": \"There\'s always an optimal algorithm for each problem\"}, \r\n   {\"id\": 2, \"text\": \"Machine learning models require data to learn\"}, \r\n   {\"id\": 3, \"text\": \"No single algorithm works best for every problem\"}, \r\n   {\"id\": 4, \"text\": \"AI will eventually surpass human intelligence\"}]', 3, '5', 'E007'),
('CS037', 'What is the primary challenge in implementing distributed consensus in a blockchain system?', '[{\"id\": 1, \"text\": \"Ensuring all transactions are encrypted\"}, \r\n   {\"id\": 2, \"text\": \"Achieving agreement on a single data value among distributed processes or systems\"}, \r\n   {\"id\": 3, \"text\": \"Maintaining a centralized ledger for all transactions\"}, \r\n   {\"id\": 4, \"text\": \"Limiting the transaction throughput to save bandwidth\"}]', 2, '5', 'E007'),
('CS038', 'Which algorithm forms the foundation of Google\'s original PageRank?', '[{\"id\": 1, \"text\": \"Eigenvector centrality\"}, \r\n   {\"id\": 2, \"text\": \"Depth-first search\"}, \r\n   {\"id\": 3, \"text\": \"Random walk\"}, \r\n   {\"id\": 4, \"text\": \"Link analysis\"}]', 1, '5', 'E007'),
('CS039', 'In the context of machine learning, what distinguishes a generative model from a discriminative model?', '[{\"id\": 1, \"text\": \"Generative models can generate new data instances\"}, \r\n   {\"id\": 2, \"text\": \"Discriminative models can only classify data\"}, \r\n   {\"id\": 3, \"text\": \"Generative models do not require labeled data\"}, \r\n   {\"id\": 4, \"text\": \"Both A and B are correct\"}]', 4, '5', 'E007'),
('CS040', 'What is the concept of \"side-channel attacks\" in cybersecurity?', '[{\"id\": 1, \"text\": \"Attacks based on information gained from the implementation of a computer system\"}, \r\n   {\"id\": 2, \"text\": \"Hacking through social engineering methods\"}, \r\n   {\"id\": 3, \"text\": \"Exploiting vulnerabilities in software applications\"}, \r\n   {\"id\": 4, \"text\": \"Attacks that require physical access to the computer\"}]', 1, '5', 'E007'),
('H001', 'Who was the first President of the United States?', '[{\"id\": 1, \"text\": \"George Washington\"}, {\"id\": 2, \"text\": \"Thomas Jefferson\"}, {\"id\": 3, \"text\": \"Abraham Lincoln\"}, {\"id\": 4, \"text\": \"John Adams\"}]', 1, '1', 'E006'),
('H002', 'In which year did the Roman Empire fall?', '[{\"id\": 1, \"text\": \"476 AD\"}, {\"id\": 2, \"text\": \"1453 AD\"}, {\"id\": 3, \"text\": \"306 AD\"}, {\"id\": 4, \"text\": \"410 AD\"}]', 1, '2', 'E006'),
('H003', 'What was the main cause of World War I?', '[{\"id\": 1, \"text\": \"Assassination of Archduke Franz Ferdinand\"}, {\"id\": 2, \"text\": \"The rise of nationalism\"}, {\"id\": 3, \"text\": \"Economic competition\"}, {\"id\": 4, \"text\": \"Colonial disputes\"}]', 1, '2', 'E006'),
('H004', 'Which civilization is known for its pyramids?', '[{\"id\": 1, \"text\": \"Egyptian\"}, {\"id\": 2, \"text\": \"Mayan\"}, {\"id\": 3, \"text\": \"Aztec\"}, {\"id\": 4, \"text\": \"Incan\"}]', 1, '1', 'E006'),
('H005', 'Who painted the Mona Lisa?', '[{\"id\": 1, \"text\": \"Leonardo da Vinci\"}, {\"id\": 2, \"text\": \"Michelangelo\"}, {\"id\": 3, \"text\": \"Raphael\"}, {\"id\": 4, \"text\": \"Vincent van Gogh\"}]', 1, '1', 'E006'),
('H006', 'What was the primary language of the Roman Empire?', '[{\"id\": 1, \"text\": \"Latin\"}, {\"id\": 2, \"text\": \"Greek\"}, {\"id\": 3, \"text\": \"Aramaic\"}, {\"id\": 4, \"text\": \"Italian\"}]', 1, '1', 'E006'),
('H007', 'Which event marked the beginning of the French Revolution?', '[{\"id\": 1, \"text\": \"Storming of the Bastille\"}, {\"id\": 2, \"text\": \"Execution of Louis XVI\"}, {\"id\": 3, \"text\": \"The Estates-General Meeting\"}, {\"id\": 4, \"text\": \"The Reign of Terror\"}]', 1, '2', 'E006'),
('H008', 'Who was the first female Prime Minister of the United Kingdom?', '[{\"id\": 1, \"text\": \"Margaret Thatcher\"}, {\"id\": 2, \"text\": \"Theresa May\"}, {\"id\": 3, \"text\": \"Indira Gandhi\"}, {\"id\": 4, \"text\": \"Angela Merkel\"}]', 1, '1', 'E006'),
('H009', 'What was the main reason for the fall of the Soviet Union?', '[{\"id\": 1, \"text\": \"Economic issues\"}, {\"id\": 2, \"text\": \"Military defeat\"}, {\"id\": 3, \"text\": \"Nuclear accident\"}, {\"id\": 4, \"text\": \"Foreign invasion\"}]', 1, '3', 'E006'),
('H010', 'Which empire was known as the \"Land of the Rising Sun\"?', '[{\"id\": 1, \"text\": \"Japanese Empire\"}, {\"id\": 2, \"text\": \"Ottoman Empire\"}, {\"id\": 3, \"text\": \"British Empire\"}, {\"id\": 4, \"text\": \"Roman Empire\"}]', 1, '2', 'E006'),
('H011', 'During which period did the Renaissance begin?', '[{\"id\": 1, \"text\": \"14th century\"}, {\"id\": 2, \"text\": \"16th century\"}, {\"id\": 3, \"text\": \"18th century\"}, {\"id\": 4, \"text\": \"20th century\"}]', 1, '3', 'E006'),
('H012', 'What was the primary cause of the Black Death in Europe?', '[{\"id\": 1, \"text\": \"Bubonic plague\"}, {\"id\": 2, \"text\": \"Smallpox\"}, {\"id\": 3, \"text\": \"Influenza\"}, {\"id\": 4, \"text\": \"Cholera\"}]', 1, '2', 'E006'),
('H013', 'Which country was the first to grant women the right to vote?', '[{\"id\": 1, \"text\": \"New Zealand\"}, {\"id\": 2, \"text\": \"United States\"}, {\"id\": 3, \"text\": \"Sweden\"}, {\"id\": 4, \"text\": \"France\"}]', 1, '3', 'E006'),
('H014', 'Who discovered the Americas in 1492?', '[{\"id\": 1, \"text\": \"Christopher Columbus\"}, {\"id\": 2, \"text\": \"Marco Polo\"}, {\"id\": 3, \"text\": \"Vasco da Gama\"}, {\"id\": 4, \"text\": \"Leif Erikson\"}]', 1, '1', 'E006'),
('H015', 'Which conflict is known as the Great War?', '[{\"id\": 1, \"text\": \"World War I\"}, {\"id\": 2, \"text\": \"World War II\"}, {\"id\": 3, \"text\": \"The Napoleonic Wars\"}, {\"id\": 4, \"text\": \"The Seven Years War\"}]', 1, '1', 'E006'),
('H016', 'What was the main purpose of the Silk Road?', '[{\"id\": 1, \"text\": \"Trade between Europe and Asia\"}, {\"id\": 2, \"text\": \"Religious pilgrimages\"}, {\"id\": 3, \"text\": \"Military campaigns\"}, {\"id\": 4, \"text\": \"Scientific exploration\"}]', 1, '2', 'E006'),
('H017', 'Who was the Russian leader during the Cuban Missile Crisis?', '[{\"id\": 1, \"text\": \"Nikita Khrushchev\"}, {\"id\": 2, \"text\": \"Joseph Stalin\"}, {\"id\": 3, \"text\": \"Vladimir Lenin\"}, {\"id\": 4, \"text\": \"Leonid Brezhnev\"}]', 1, '2', 'E006'),
('H018', 'Which empire was ruled by the Sultans?', '[{\"id\": 1, \"text\": \"Ottoman Empire\"}, {\"id\": 2, \"text\": \"Mughal Empire\"}, {\"id\": 3, \"text\": \"Roman Empire\"}, {\"id\": 4, \"text\": \"Persian Empire\"}]', 1, '2', 'E006'),
('H019', 'What was the Treaty of Versailles?', '[{\"id\": 1, \"text\": \"The treaty that ended World War I\"}, {\"id\": 2, \"text\": \"The treaty that started World War II\"}, {\"id\": 3, \"text\": \"The agreement to begin the League of Nations\"}, {\"id\": 4, \"text\": \"The pact that divided Africa among European powers\"}]', 1, '2', 'E006'),
('H020', 'In which century did the Industrial Revolution begin?', '[{\"id\": 1, \"text\": \"18th century\"}, {\"id\": 2, \"text\": \"19th century\"}, {\"id\": 3, \"text\": \"17th century\"}, {\"id\": 4, \"text\": \"16th century\"}]', 1, '3', 'E006'),
('H021', 'What invention is credited to Johannes Gutenberg?', '[{\"id\": 1, \"text\": \"The printing press\"}, {\"id\": 2, \"text\": \"The compass\"}, {\"id\": 3, \"text\": \"The telescope\"}, {\"id\": 4, \"text\": \"The steam engine\"}]', 1, '3', 'E006'),
('H022', 'Which battle marked the end of Napoleon Bonaparte\'s rule?', '[{\"id\": 1, \"text\": \"The Battle of Waterloo\"}, {\"id\": 2, \"text\": \"The Battle of Trafalgar\"}, {\"id\": 3, \"text\": \"The Battle of Austerlitz\"}, {\"id\": 4, \"text\": \"The Battle of Borodino\"}]', 1, '3', 'E006'),
('H023', 'What was the primary reason for the construction of the Great Wall of China?', '[{\"id\": 1, \"text\": \"To protect against invasions\"}, {\"id\": 2, \"text\": \"To mark the boundary of the empire\"}, {\"id\": 3, \"text\": \"For the purpose of trade\"}, {\"id\": 4, \"text\": \"As a symbol of power\"}]', 1, '3', 'E006'),
('H024', 'Who was the first woman to fly solo across the Atlantic Ocean?', '[{\"id\": 1, \"text\": \"Amelia Earhart\"}, {\"id\": 2, \"text\": \"Valentina Tereshkova\"}, {\"id\": 3, \"text\": \"Sally Ride\"}, {\"id\": 4, \"text\": \"Harriet Quimby\"}]', 1, '3', 'E006'),
('H025', 'In which century did the Ottoman Empire fall?', '[{\"id\": 1, \"text\": \"20th century\"}, {\"id\": 2, \"text\": \"19th century\"}, {\"id\": 3, \"text\": \"18th century\"}, {\"id\": 4, \"text\": \"17th century\"}]', 1, '3', 'E006'),
('H026', 'What was the main resource sought by Europeans in their early explorations of Africa?', '[{\"id\": 1, \"text\": \"Gold\"}, {\"id\": 2, \"text\": \"Spices\"}, {\"id\": 3, \"text\": \"Silk\"}, {\"id\": 4, \"text\": \"Tea\"}]', 1, '3', 'E006');
INSERT INTO `questions` (`qid`, `qcontent`, `qoptions`, `correct_option_id`, `difficulty`, `eid`) VALUES
('H027', 'Which country launched the first satellite into space?', '[{\"id\": 1, \"text\": \"The Soviet Union\"}, {\"id\": 2, \"text\": \"The United States\"}, {\"id\": 3, \"text\": \"Germany\"}, {\"id\": 4, \"text\": \"China\"}]', 1, '3', 'E006'),
('H028', 'Who was the longest-reigning British monarch?', '[{\"id\": 1, \"text\": \"Queen Elizabeth II\"}, {\"id\": 2, \"text\": \"Queen Victoria\"}, {\"id\": 3, \"text\": \"King George III\"}, {\"id\": 4, \"text\": \"King Henry VIII\"}]', 1, '3', 'E006'),
('H029', 'The Treaty of Tordesillas, signed in 1494, divided the newly discovered lands outside Europe between which two countries?', '[{\"id\": 1, \"text\": \"Spain and Portugal\"}, {\"id\": 2, \"text\": \"France and England\"}, {\"id\": 3, \"text\": \"Spain and France\"}, {\"id\": 4, \"text\": \"Portugal and England\"}]', 1, '4', 'E006'),
('H030', 'Which philosopher is known as the father of Western philosophy?', '[{\"id\": 1, \"text\": \"Socrates\"}, {\"id\": 2, \"text\": \"Plato\"}, {\"id\": 3, \"text\": \"Aristotle\"}, {\"id\": 4, \"text\": \"Descartes\"}]', 1, '4', 'E006'),
('H031', 'What event began on July 14, 1789, in France?', '[{\"id\": 1, \"text\": \"The Storming of the Bastille\"}, {\"id\": 2, \"text\": \"The signing of the Declaration of the Rights of Man and of the Citizen\"}, {\"id\": 3, \"text\": \"The coronation of Napoleon Bonaparte\"}, {\"id\": 4, \"text\": \"The execution of Louis XVI\"}]', 1, '4', 'E006'),
('H032', 'Who was known as the \"Sun King\"?', '[{\"id\": 1, \"text\": \"Louis XIV of France\"}, {\"id\": 2, \"text\": \"Charles II of Spain\"}, {\"id\": 3, \"text\": \"Henry VIII of England\"}, {\"id\": 4, \"text\": \"Frederick the Great of Prussia\"}]', 1, '4', 'E006'),
('H033', 'What was the primary objective of the Crusades?', '[{\"id\": 1, \"text\": \"To capture the Holy Land from Muslim control\"}, {\"id\": 2, \"text\": \"To stop the spread of Islam into Europe\"}, {\"id\": 3, \"text\": \"To unite the Christian denominations\"}, {\"id\": 4, \"text\": \"To find the Holy Grail\"}]', 1, '4', 'E006'),
('H034', 'Which civilization is credited with inventing the concept of democracy?', '[{\"id\": 1, \"text\": \"Ancient Greece\"}, {\"id\": 2, \"text\": \"Roman Republic\"}, {\"id\": 3, \"text\": \"Ancient Egypt\"}, {\"id\": 4, \"text\": \"Mesopotamia\"}]', 1, '4', 'E006'),
('H035', 'In what year did the Berlin Wall fall, leading to German reunification?', '[{\"id\": 1, \"text\": \"1989\"}, {\"id\": 2, \"text\": \"1991\"}, {\"id\": 3, \"text\": \"1987\"}, {\"id\": 4, \"text\": \"1990\"}]', 1, '4', 'E006'),
('H036', 'Which empire was defeated in the Battle of Saratoga?', '[{\"id\": 1, \"text\": \"The British Empire\"}, {\"id\": 2, \"text\": \"The French Empire\"}, {\"id\": 3, \"text\": \"The Spanish Empire\"}, {\"id\": 4, \"text\": \"The Ottoman Empire\"}]', 1, '4', 'E006'),
('H037', 'What was the primary purpose of the Magna Carta, signed in 1215?', '[{\"id\": 1, \"text\": \"To limit the power of the English monarchy\"}, {\"id\": 2, \"text\": \"To establish the principle of trial by jury\"}, {\"id\": 3, \"text\": \"To declare independence from France\"}, {\"id\": 4, \"text\": \"To introduce the concept of taxation without representation\"}]', 1, '4', 'E006'),
('H038', 'Who was the first emperor of unified China?', '[{\"id\": 1, \"text\": \"Qin Shi Huang\"}, {\"id\": 2, \"text\": \"Genghis Khan\"}, {\"id\": 3, \"text\": \"Emperor Wu of Han\"}, {\"id\": 4, \"text\": \"Kublai Khan\"}]', 1, '4', 'E006'),
('H039', 'Which ancient civilization is known for its hieroglyphic writing system?', '[{\"id\": 1, \"text\": \"Ancient Egypt\"}, {\"id\": 2, \"text\": \"Sumerians\"}, {\"id\": 3, \"text\": \"Indus Valley\"}, {\"id\": 4, \"text\": \"Mayans\"}]', 1, '4', 'E006'),
('H040', 'The concept of zero as a number was first introduced by which civilization?', '[{\"id\": 1, \"text\": \"The Maya\"}, {\"id\": 2, \"text\": \"Ancient India\"}, {\"id\": 3, \"text\": \"Ancient Greece\"}, {\"id\": 4, \"text\": \"Ancient China\"}]', 2, '5', 'E006'),
('P001', 'What is Newton\'s first law of motion?', '[{\"id\": 1, \"text\": \"Objects in motion stay in motion unless acted upon by an external force\"}, \r\n   {\"id\": 2, \"text\": \"Force equals mass times acceleration\"}, \r\n   {\"id\": 3, \"text\": \"For every action, there is an equal and opposite reaction\"}, \r\n   {\"id\": 4, \"text\": \"Energy cannot be created or destroyed\"}]', 1, '2', 'E002'),
('P002', 'What does the term \"velocity\" refer to?', '[{\"id\": 1, \"text\": \"The speed of an object in a given direction\"}, \r\n   {\"id\": 2, \"text\": \"The rate of change of acceleration\"}, \r\n   {\"id\": 3, \"text\": \"A type of force that acts on objects\"}, \r\n   {\"id\": 4, \"text\": \"The potential energy stored in an object\"}]', 1, '1', 'E002'),
('P003', 'Which principle explains why airplanes fly?', '[{\"id\": 1, \"text\": \"Pascal\'s principle\"}, \r\n   {\"id\": 2, \"text\": \"Bernoulli\'s principle\"}, \r\n   {\"id\": 3, \"text\": \"Newton\'s third law of motion\"}, \r\n   {\"id\": 4, \"text\": \"Hooke\'s law\"}]', 2, '3', 'E002'),
('P004', 'What is the unit of electrical resistance?', '[{\"id\": 1, \"text\": \"Coulomb\"}, \r\n   {\"id\": 2, \"text\": \"Ohm\"}, \r\n   {\"id\": 3, \"text\": \"Watt\"}, \r\n   {\"id\": 4, \"text\": \"Ampere\"}]', 2, '1', 'E002'),
('P005', 'What phenomenon demonstrates the wave-particle duality of light?', '[{\"id\": 1, \"text\": \"Refraction\"}, \r\n   {\"id\": 2, \"text\": \"Photoelectric effect\"}, \r\n   {\"id\": 3, \"text\": \"Doppler effect\"}, \r\n   {\"id\": 4, \"text\": \"Polarization\"}]', 2, '3', 'E002'),
('P006', 'In the context of thermodynamics, what does \"entropy\" measure?', '[{\"id\": 1, \"text\": \"Temperature\"}, \r\n   {\"id\": 2, \"text\": \"Pressure\"}, \r\n   {\"id\": 3, \"text\": \"Volume\"}, \r\n   {\"id\": 4, \"text\": \"Disorder\"}]', 4, '2', 'E002'),
('P007', 'Which law describes the behavior of ideal gases?', '[{\"id\": 1, \"text\": \"Ohm\'s law\"}, \r\n   {\"id\": 2, \"text\": \"Boyle\'s law\"}, \r\n   {\"id\": 3, \"text\": \"Charles\'s law\"}, \r\n   {\"id\": 4, \"text\": \"The ideal gas law\"}]', 4, '2', 'E002'),
('P008', 'What is the SI unit of force?', '[{\"id\": 1, \"text\": \"Newton\"}, \r\n   {\"id\": 2, \"text\": \"Joule\"}, \r\n   {\"id\": 3, \"text\": \"Pascal\"}, \r\n   {\"id\": 4, \"text\": \"Watt\"}]', 1, '1', 'E002'),
('P009', 'What does \"quantum mechanics\" study?', '[{\"id\": 1, \"text\": \"The behavior of macroscopic objects\"}, \r\n   {\"id\": 2, \"text\": \"The motion of planets and stars\"}, \r\n   {\"id\": 3, \"text\": \"The behavior of particles at the atomic and subatomic levels\"}, \r\n   {\"id\": 4, \"text\": \"The properties of light as a wave\"}]', 3, '3', 'E002'),
('P010', 'What is the principle behind hydraulic lifts?', '[{\"id\": 1, \"text\": \"Newton\'s first law of motion\"}, \r\n   {\"id\": 2, \"text\": \"Bernoulli\'s principle\"}, \r\n   {\"id\": 3, \"text\": \"Pascal\'s principle\"}, \r\n   {\"id\": 4, \"text\": \"Archimedes\' principle\"}]', 3, '2', 'E002'),
('P012', 'Which of the following is a scalar quantity?', '[{\"id\": 1, \"text\": \"Force\"}, \r\n   {\"id\": 2, \"text\": \"Volume\"}, \r\n   {\"id\": 3, \"text\": \"Velocity\"}, \r\n   {\"id\": 4, \"text\": \"Acceleration\"}]', 2, '1', 'E002'),
('P013', 'What is the main difference between blue and red light?', '[{\"id\": 1, \"text\": \"Speed\"}, \r\n   {\"id\": 2, \"text\": \"Wavelength\"}, \r\n   {\"id\": 3, \"text\": \"Brightness\"}, \r\n   {\"id\": 4, \"text\": \"Energy\"}]', 2, '1', 'E002'),
('P014', 'Which force is responsible for the orbiting of planets around the sun?', '[{\"id\": 1, \"text\": \"Magnetic force\"}, \r\n   {\"id\": 2, \"text\": \"Gravitational force\"}, \r\n   {\"id\": 3, \"text\": \"Nuclear force\"}, \r\n   {\"id\": 4, \"text\": \"Frictional force\"}]', 2, '1', 'E002'),
('P015', 'What type of lens is used to correct nearsightedness?', '[{\"id\": 1, \"text\": \"Convex lens\"}, \r\n   {\"id\": 2, \"text\": \"Concave lens\"}, \r\n   {\"id\": 3, \"text\": \"Cylindrical lens\"}, \r\n   {\"id\": 4, \"text\": \"Bifocal lens\"}]', 2, '1', 'E002'),
('P016', 'In an electrical circuit, what does a capacitor do?', '[{\"id\": 1, \"text\": \"Stores electrical energy in an electric field\"}, \r\n   {\"id\": 2, \"text\": \"Converts electrical energy into mechanical work\"}, \r\n   {\"id\": 3, \"text\": \"Measures the electrical potential difference between two points\"}, \r\n   {\"id\": 4, \"text\": \"Resists the flow of electrical current\"}]', 1, '2', 'E002'),
('P017', 'What phenomenon causes the sky to appear blue?', '[{\"id\": 1, \"text\": \"Diffraction\"}, \r\n   {\"id\": 2, \"text\": \"Refraction\"}, \r\n   {\"id\": 3, \"text\": \"Reflection\"}, \r\n   {\"id\": 4, \"text\": \"Rayleigh scattering\"}]', 4, '2', 'E002'),
('P018', 'What is the equivalent resistance of two 2 ohm resistors in parallel?', '[{\"id\": 1, \"text\": \"1 ohm\"}, \r\n   {\"id\": 2, \"text\": \"2 ohms\"}, \r\n   {\"id\": 3, \"text\": \"4 ohms\"}, \r\n   {\"id\": 4, \"text\": \"1/2 ohm\"}]', 1, '2', 'E002'),
('P019', 'Which of the following is not a fundamental force in physics?', '[{\"id\": 1, \"text\": \"Electromagnetic force\"}, \r\n   {\"id\": 2, \"text\": \"Strong nuclear force\"}, \r\n   {\"id\": 3, \"text\": \"Weak nuclear force\"}, \r\n   {\"id\": 4, \"text\": \"Frictional force\"}]', 4, '1', 'E002'),
('P020', 'What is the main source of energy for the Earth\'s climate system?', '[{\"id\": 1, \"text\": \"The Earth\'s core\"}, \r\n   {\"id\": 2, \"text\": \"The Sun\"}, \r\n   {\"id\": 3, \"text\": \"Geothermal energy\"}, \r\n   {\"id\": 4, \"text\": \"The Moon\"}]', 2, '1', 'E002'),
('P022', 'What experiment provided the first evidence of quarks within protons?', '[{\"id\": 1, \"text\": \"Gold foil experiment\"}, \r\n   {\"id\": 2, \"text\": \"Double-slit experiment\"}, \r\n   {\"id\": 3, \"text\": \"Deep inelastic scattering\"}, \r\n   {\"id\": 4, \"text\": \"Cathode ray tube experiment\"}]', 3, '4', 'E002'),
('P023', 'Which concept in quantum mechanics suggests that particles can be in multiple states at once until observed?', '[{\"id\": 1, \"text\": \"Heisenberg\'s uncertainty principle\"}, \r\n   {\"id\": 2, \"text\": \"Schrodinger\'s cat\"}, \r\n   {\"id\": 3, \"text\": \"Planck\'s constant\"}, \r\n   {\"id\": 4, \"text\": \"Quantum entanglement\"}]', 2, '4', 'E002'),
('P024', 'In string theory, what is the primary constituent of fundamental particles?', '[{\"id\": 1, \"text\": \"Quarks\"}, \r\n   {\"id\": 2, \"text\": \"Strings\"}, \r\n   {\"id\": 3, \"text\": \"Leptons\"}, \r\n   {\"id\": 4, \"text\": \"Bosons\"}]', 2, '5', 'E002'),
('P025', 'What principle explains the phenomenon where particles have no well-defined properties until measured?', '[{\"id\": 1, \"text\": \"Principle of relativity\"}, \r\n   {\"id\": 2, \"text\": \"Quantum superposition\"}, \r\n   {\"id\": 3, \"text\": \"Newton\'s law of universal gravitation\"}, \r\n   {\"id\": 4, \"text\": \"Conservation of energy\"}]', 2, '4', 'E002'),
('P026', 'Which of the following is a key feature of quantum entanglement?', '[{\"id\": 1, \"text\": \"Particles remain independent of each other\'s state\"}, \r\n   {\"id\": 2, \"text\": \"Particles interact at speeds faster than light\"}, \r\n   {\"id\": 3, \"text\": \"The state of one particle instantly affects the state of another, regardless of distance\"}, \r\n   {\"id\": 4, \"text\": \"Particles can only be observed in pairs\"}]', 3, '5', 'E002'),
('P027', 'In cosmology, what does the term \"dark energy\" refer to?', '[{\"id\": 1, \"text\": \"A form of energy that absorbs light\"}, \r\n   {\"id\": 2, \"text\": \"The energy associated with black holes\"}, \r\n   {\"id\": 3, \"text\": \"A hypothetical form of energy that is proposed to drive the accelerated expansion of the universe\"}, \r\n   {\"id\": 4, \"text\": \"The energy emitted by stars that is not visible to the human eye\"}]', 3, '4', 'E002'),
('P028', 'What does the \"many-worlds interpretation\" of quantum mechanics propose?', '[{\"id\": 1, \"text\": \"There is only one universe, and all quantum events are predetermined\"}, \r\n   {\"id\": 2, \"text\": \"Quantum events cause the universe to split into multiple, parallel versions of itself\"}, \r\n   {\"id\": 3, \"text\": \"The universe cycles through infinite births and deaths\"}, \r\n   {\"id\": 4, \"text\": \"Conscious observation determines the outcome of quantum events\"}]', 2, '5', 'E002'),
('P029', 'Which theory attempts to unify quantum mechanics and general relativity?', '[{\"id\": 1, \"text\": \"Classical mechanics\"}, \r\n   {\"id\": 2, \"text\": \"Theory of everything\"}, \r\n   {\"id\": 3, \"text\": \"Special relativity\"}, \r\n   {\"id\": 4, \"text\": \"Chaos theory\"}]', 2, '5', 'E002'),
('P031', 'What is the name given to the theoretical boundary around a black hole beyond which no light or other radiation can escape?', '[{\"id\": 1, \"text\": \"Event horizon\"}, \r\n   {\"id\": 2, \"text\": \"Singularity\"}, \r\n   {\"id\": 3, \"text\": \"Accretion disk\"}, \r\n   {\"id\": 4, \"text\": \"Photon sphere\"}]', 1, '4', 'E002'),
('P032', 'In the context of special relativity, what does E=mc^2 explain?', '[{\"id\": 1, \"text\": \"The equivalence of energy and mass\"}, \r\n   {\"id\": 2, \"text\": \"The conservation of momentum\"}, \r\n   {\"id\": 3, \"text\": \"The speed of light in a vacuum\"}, \r\n   {\"id\": 4, \"text\": \"The dilation of time with velocity\"}]', 1, '4', 'E002'),
('P033', 'Which particle is postulated by the Higgs mechanism to impart mass to other particles?', '[{\"id\": 1, \"text\": \"Gluon\"}, \r\n   {\"id\": 2, \"text\": \"Quark\"}, \r\n   {\"id\": 3, \"text\": \"Higgs boson\"}, \r\n   {\"id\": 4, \"text\": \"Neutrino\"}]', 3, '5', 'E002'),
('P034', 'What is the primary evidence for the Big Bang theory?', '[{\"id\": 1, \"text\": \"Galactic redshift\"}, \r\n   {\"id\": 2, \"text\": \"Cosmic microwave background radiation\"}, \r\n   {\"id\": 3, \"text\": \"Presence of dark matter\"}, \r\n   {\"id\": 4, \"text\": \"Black holes\"}]', 2, '4', 'E002'),
('P035', 'What principle is demonstrated by the double-slit experiment in quantum mechanics?', '[{\"id\": 1, \"text\": \"Uncertainty principle\"}, \r\n   {\"id\": 2, \"text\": \"Superposition\"}, \r\n   {\"id\": 3, \"text\": \"Entanglement\"}, \r\n   {\"id\": 4, \"text\": \"Complementarity\"}]', 2, '4', 'E002'),
('P036', 'Which of the following describes the concept of \"spooky action at a distance\" in quantum physics?', '[{\"id\": 1, \"text\": \"Quantum tunneling\"}, \r\n   {\"id\": 2, \"text\": \"Quantum entanglement\"}, \r\n   {\"id\": 3, \"text\": \"Heisenberg uncertainty principle\"}, \r\n   {\"id\": 4, \"text\": \"Schrodinger\'s cat scenario\"}]', 2, '5', 'E002'),
('P037', 'What is the primary function of a particle accelerator?', '[{\"id\": 1, \"text\": \"To generate electrical power\"}, \r\n   {\"id\": 2, \"text\": \"To observe the effects of high magnetic fields\"}, \r\n   {\"id\": 3, \"text\": \"To collide particles at high speeds to observe the results\"}, \r\n   {\"id\": 4, \"text\": \"To detect radio waves from space\"}]', 3, '4', 'E002'),
('P038', 'In physics, what is a \"virtual particle\"?', '[{\"id\": 1, \"text\": \"A particle that exists only under certain conditions\"}, \r\n   {\"id\": 2, \"text\": \"A hypothetical particle that cannot interact with matter\"}, \r\n   {\"id\": 3, \"text\": \"A particle that exists temporarily due to quantum fluctuations\"}, \r\n   {\"id\": 4, \"text\": \"A particle with no mass or charge\"}]', 3, '5', 'E002'),
('P039', 'Which concept in physics explains the acceleration of the universe\'s expansion?', '[{\"id\": 1, \"text\": \"Dark matter\"}, \r\n   {\"id\": 2, \"text\": \"Dark energy\"}, \r\n   {\"id\": 3, \"text\": \"Antimatter\"}, \r\n   {\"id\": 4, \"text\": \"Neutrino oscillations\"}]', 2, '5', 'E002'),
('Q001', 'What is the value of π to 2 decimal places?', '[{\"id\": 1, \"text\": \"3.14\"}, {\"id\": 2, \"text\": \"3.15\"}, {\"id\": 3, \"text\": \"3.16\"}, {\"id\": 4, \"text\": \"3.17\"}]', 1, '2', 'E001'),
('Q002', 'Solve for x: 2x + 3 = 7', '[{\"id\": 1, \"text\": \"1\"}, {\"id\": 2, \"text\": \"2\"}, {\"id\": 3, \"text\": \"3\"}, {\"id\": 4, \"text\": \"4\"}]', 2, '1', 'E001'),
('Q003', 'What is the derivative of x^2?', '[{\"id\": 1, \"text\": \"x\"}, {\"id\": 2, \"text\": \"2x\"}, {\"id\": 3, \"text\": \"3x^2\"}, {\"id\": 4, \"text\": \"2\"}]', 2, '3', 'E001'),
('Q004', 'If the area of a circle is 154 cm², what is the radius? (Use π = 3.14)', '[{\"id\": 1, \"text\": \"7 cm\"}, {\"id\": 2, \"text\": \"14 cm\"}, {\"id\": 3, \"text\": \"21 cm\"}, {\"id\": 4, \"text\": \"28 cm\"}]', 1, '3', 'E001'),
('Q005', 'What is the sum of the interior angles of a triangle?', '[{\"id\": 1, \"text\": \"180 degrees\"}, {\"id\": 2, \"text\": \"360 degrees\"}, {\"id\": 3, \"text\": \"90 degrees\"}, {\"id\": 4, \"text\": \"270 degrees\"}]', 1, '1', 'E001'),
('Q006', 'What is the solution to the equation 3x - 5 = 10?', '[{\"id\": 1, \"text\": \"3\"}, {\"id\": 2, \"text\": \"4\"}, {\"id\": 3, \"text\": \"5\"}, {\"id\": 4, \"text\": \"6\"}]', 3, '1', 'E001'),
('Q007', 'How many sides does a hexagon have?', '[{\"id\": 1, \"text\": \"5\"}, {\"id\": 2, \"text\": \"6\"}, {\"id\": 3, \"text\": \"7\"}, {\"id\": 4, \"text\": \"8\"}]', 2, '1', 'E001'),
('Q008', 'What is the value of the square root of 144?', '[{\"id\": 1, \"text\": \"12\"}, {\"id\": 2, \"text\": \"14\"}, {\"id\": 3, \"text\": \"16\"}, {\"id\": 4, \"text\": \"18\"}]', 1, '1', 'E001'),
('Q009', 'What is the common difference in the arithmetic sequence 4, 7, 10, 13, ...?', '[{\"id\": 1, \"text\": \"2\"}, {\"id\": 2, \"text\": \"3\"}, {\"id\": 3, \"text\": \"4\"}, {\"id\": 4, \"text\": \"5\"}]', 2, '2', 'E001'),
('Q010', 'What is the equation of a line with a slope of 2 and y-intercept of -3?', '[{\"id\": 1, \"text\": \"y = 2x - 3\"}, {\"id\": 2, \"text\": \"y = 2x + 3\"}, {\"id\": 3, \"text\": \"y = -2x - 3\"}, {\"id\": 4, \"text\": \"y = -2x + 3\"}]', 1, '2', 'E001'),
('Q011', 'What is the volume of a cube with side length of 3 cm?', '[{\"id\": 1, \"text\": \"9 cm³\"}, {\"id\": 2, \"text\": \"27 cm³\"}, {\"id\": 3, \"text\": \"81 cm³\"}, {\"id\": 4, \"text\": \"243 cm³\"}]', 2, '1', 'E001'),
('Q012', 'What is the inverse function of f(x) = 2x + 3?', '[{\"id\": 1, \"text\": \"f^-1(x) = (x - 3)/2\"}, {\"id\": 2, \"text\": \"f^-1(x) = 2x - 3\"}, {\"id\": 3, \"text\": \"f^-1(x) = (x + 3)/2\"}, {\"id\": 4, \"text\": \"f^-1(x) = (2x + 3)\"}]', 1, '3', 'E001'),
('Q013', 'What is the result of integrating the function f(x) = 3x^2?', '[{\"id\": 1, \"text\": \"x^3 + C\"}, {\"id\": 2, \"text\": \"x^3/3 + C\"}, {\"id\": 3, \"text\": \"x^3 - C\"}, {\"id\": 4, \"text\": \"3x + C\"}]', 1, '3', 'E001'),
('Q014', 'If f(x) = x^2 and g(x) = x + 2, what is (fog)(x)?', '[{\"id\": 1, \"text\": \"(x + 2)^2\"}, {\"id\": 2, \"text\": \"x^2 + 2\"}, {\"id\": 3, \"text\": \"x^2 + 4x + 4\"}, {\"id\": 4, \"text\": \"(x^2) + 2\"}]', 1, '2', 'E001'),
('Q015', 'What is the area of a circle with a diameter of 8 cm? (Use π = 3.14)', '[{\"id\": 1, \"text\": \"50.24 cm²\"}, {\"id\": 2, \"text\": \"100.48 cm²\"}, {\"id\": 3, \"text\": \"200.96 cm²\"}, {\"id\": 4, \"text\": \"25.12 cm²\"}]', 1, '2', 'E001'),
('Q016', 'Simplify: (x^2 * x^3)', '[{\"id\": 1, \"text\": \"x^5\"}, {\"id\": 2, \"text\": \"x^6\"}, {\"id\": 3, \"text\": \"2x^5\"}, {\"id\": 4, \"text\": \"5x\"}]', 1, '1', 'E001'),
('Q017', 'Find the slope of the line passing through the points (2,5) and (4,9)', '[{\"id\": 1, \"text\": \"2\"}, {\"id\": 2, \"text\": \"1\"}, {\"id\": 3, \"text\": \"4\"}, {\"id\": 4, \"text\": \"3\"}]', 1, '2', 'E001'),
('Q018', 'What is the prime factorization of 60?', '[{\"id\": 1, \"text\": \"2^2 * 3 * 5\"}, {\"id\": 2, \"text\": \"2 * 3^2 * 5\"}, {\"id\": 3, \"text\": \"2^2 * 3^2\"}, {\"id\": 4, \"text\": \"3 * 5 * 4\"}]', 1, '2', 'E001'),
('Q019', 'What is the least common multiple (LCM) of 8 and 12?', '[{\"id\": 1, \"text\": \"24\"}, {\"id\": 2, \"text\": \"36\"}, {\"id\": 3, \"text\": \"48\"}, {\"id\": 4, \"text\": \"60\"}]', 1, '2', 'E001'),
('Q020', 'Calculate the determinant of the matrix [[1, 2], [3, 4]]', '[{\"id\": 1, \"text\": \"-2\"}, {\"id\": 2, \"text\": \"2\"}, {\"id\": 3, \"text\": \"-4\"}, {\"id\": 4, \"text\": \"4\"}]', 1, '3', 'E001'),
('Q021', 'What is the range of the function f(x) = 2x + 3?', '[{\"id\": 1, \"text\": \"All real numbers\"}, {\"id\": 2, \"text\": \"All positive real numbers\"}, {\"id\": 3, \"text\": \"x > 3\"}, {\"id\": 4, \"text\": \"x < 3\"}]', 1, '2', 'E001'),
('Q022', 'Find the midpoint of the line segment connecting the points (1,2) and (3,4)', '[{\"id\": 1, \"text\": \"(2, 3)\"}, {\"id\": 2, \"text\": \"(1.5, 2.5)\"}, {\"id\": 3, \"text\": \"(2.5, 3.5)\"}, {\"id\": 4, \"text\": \"(3, 4)\"}]', 3, '2', 'E001'),
('Q023', 'What is the sum of the first 100 positive integers?', '[{\"id\": 1, \"text\": \"5050\"}, {\"id\": 2, \"text\": \"5000\"}, {\"id\": 3, \"text\": \"5150\"}, {\"id\": 4, \"text\": \"5250\"}]', 1, '1', 'E001'),
('Q024', 'Solve for x in the equation: log(x) = 2', '[{\"id\": 1, \"text\": \"100\"}, {\"id\": 2, \"text\": \"10\"}, {\"id\": 3, \"text\": \"1\"}, {\"id\": 4, \"text\": \"0\"}]', 1, '3', 'E001'),
('Q025', 'What is the area of a rectangle with length 8 cm and width 4 cm?', '[{\"id\": 1, \"text\": \"32 cm²\"}, {\"id\": 2, \"text\": \"24 cm²\"}, {\"id\": 3, \"text\": \"16 cm²\"}, {\"id\": 4, \"text\": \"12 cm²\"}]', 1, '1', 'E001'),
('Q026', 'What is the integral of cos(x)?', '[{\"id\": 1, \"text\": \"sin(x) + C\"}, {\"id\": 2, \"text\": \"-cos(x) + C\"}, {\"id\": 3, \"text\": \"sec(x) + C\"}, {\"id\": 4, \"text\": \"-sin(x) + C\"}]', 1, '4', 'E001'),
('Q027', 'If f(x) = e^x, what is f\'(x)?', '[{\"id\": 1, \"text\": \"e^x\"}, {\"id\": 2, \"text\": \"x*e^x\"}, {\"id\": 3, \"text\": \"e^(x+1)\"}, {\"id\": 4, \"text\": \"e^(x-1)\"}]', 1, '4', 'E001'),
('Q028', 'Calculate the sum of an infinite geometric series with a1 = 8 and r = 1/3.', '[{\"id\": 1, \"text\": \"12\"}, {\"id\": 2, \"text\": \"24\"}, {\"id\": 3, \"text\": \"10\"}, {\"id\": 4, \"text\": \"14\"}]', 1, '5', 'E001'),
('Q029', 'What is the angle sum of a pentagon?', '[{\"id\": 1, \"text\": \"540 degrees\"}, {\"id\": 2, \"text\": \"360 degrees\"}, {\"id\": 3, \"text\": \"720 degrees\"}, {\"id\": 4, \"text\": \"180 degrees\"}]', 1, '4', 'E001'),
('Q030', 'What is the equation of a circle with center (3,-4) and radius 5?', '[{\"id\": 1, \"text\": \"(x-3)^2 + (y+4)^2 = 25\"}, {\"id\": 2, \"text\": \"(x+3)^2 + (y-4)^2 = 25\"}, {\"id\": 3, \"text\": \"(x-3)^2 + (y+4)^2 = 5\"}, {\"id\": 4, \"text\": \"(x+3)^2 + (y-4)^2 = 5\"}]', 1, '4', 'E001'),
('Q031', 'Solve for y in the system of equations: 2x + 3y = 6 and 4x - y = 9', '[{\"id\": 1, \"text\": \"1\"}, {\"id\": 2, \"text\": \"2\"}, {\"id\": 3, \"text\": \"-1\"}, {\"id\": 4, \"text\": \"-2\"}]', 3, '4', 'E001'),
('Q032', 'What is the asymptote of the function f(x) = 1/(x-2)?', '[{\"id\": 1, \"text\": \"x = 2\"}, {\"id\": 2, \"text\": \"y = 2\"}, {\"id\": 3, \"text\": \"x = -2\"}, {\"id\": 4, \"text\": \"y = -2\"}]', 1, '4', 'E001'),
('Q033', 'What is the standard form of the equation of a parabola that opens upwards and has vertex at (0, 0)?', '[{\"id\": 1, \"text\": \"y = ax^2\"}, {\"id\": 2, \"text\": \"y = a(x - h)^2 + k\"}, {\"id\": 3, \"text\": \"x = ay^2\"}, {\"id\": 4, \"text\": \"x = a(y - k)^2 + h\"}]', 1, '4', 'E001'),
('Q034', 'For a triangle with sides of length a, b, and c, what is the Law of Cosines?', '[{\"id\": 1, \"text\": \"c^2 = a^2 + b^2 - 2ab*cos(C)\"}, {\"id\": 2, \"text\": \"c^2 = a^2 + b^2 + 2ab*cos(C)\"}, {\"id\": 3, \"text\": \"a^2 = b^2 + c^2 - 2bc*cos(A)\"}, {\"id\": 4, \"text\": \"a^2 = b^2 + c^2 + 2bc*cos(A)\"}]', 1, '5', 'E001'),
('Q035', 'What is the determinant of a 3x3 matrix [[a, b, c], [d, e, f], [g, h, i]]?', '[{\"id\": 1, \"text\": \"aei + bfg + cdh - ceg - bdi - afh\"}, {\"id\": 2, \"text\": \"aei - bfg + cdh + ceg - bdi + afh\"}, {\"id\": 3, \"text\": \"aef + bdi + cgh - cef - bdi - agh\"}, {\"id\": 4, \"text\": \"aei + bfg + cdh + ceg + bdi + afh\"}]', 1, '5', 'E001'),
('Q036', 'What is the convergence criteria for a series Σan to be absolutely convergent?', '[{\"id\": 1, \"text\": \"If Σ|an| converges, then Σan is absolutely convergent.\"}, {\"id\": 2, \"text\": \"If Σan converges, then Σ|an| is absolutely convergent.\"}, {\"id\": 3, \"text\": \"If Σan diverges, then Σ|an| is conditionally convergent.\"}, {\"id\": 4, \"text\": \"If Σ|an| diverges, then Σan is absolutely convergent.\"}]', 1, '5', 'E001'),
('Q037', 'What is the formula for the nth term of a geometric sequence?', '[{\"id\": 1, \"text\": \"an = a1 * r^(n-1)\"}, {\"id\": 2, \"text\": \"an = a1 + (n-1)d\"}, {\"id\": 3, \"text\": \"an = a1/n\"}, {\"id\": 4, \"text\": \"an = a1^n\"}]', 1, '4', 'E001'),
('Q038', 'What is the radius of convergence for the power series Σ(an(x-a)^n) from n=0 to infinity?', '[{\"id\": 1, \"text\": \"1/R = lim(n->∞) |an/an+1|\"}, {\"id\": 2, \"text\": \"R = lim(n->∞) |an/an+1|\"}, {\"id\": 3, \"text\": \"R = lim(n->∞) sqrt|an|\"}, {\"id\": 4, \"text\": \"R = lim(n->∞) |an|^1/n\"}]', 2, '5', 'E001'),
('Q039', 'What is the volume of a sphere with radius 4 cm? (Use π = 3.14)', '[{\"id\": 1, \"text\": \"268.08 cm³\"}, {\"id\": 2, \"text\": \"201.06 cm³\"}, {\"id\": 3, \"text\": \"134.04 cm³\"}, {\"id\": 4, \"text\": \"67.02 cm³\"}]', 1, '4', 'E001'),
('Q040', 'Find the area under the curve y = x^2 from x = 0 to x = 3.', '[{\"id\": 1, \"text\": \"9\"}, {\"id\": 2, \"text\": \"18\"}, {\"id\": 3, \"text\": \"27\"}, {\"id\": 4, \"text\": \"36\"}]', 3, '5', 'E001');

-- --------------------------------------------------------

--
-- Table structure for table `savedanswers`
--

CREATE TABLE `savedanswers` (
  `id` int(11) NOT NULL,
  `eid` varchar(255) NOT NULL,
  `sid` varchar(255) NOT NULL,
  `did` varchar(255) NOT NULL,
  `qid` varchar(255) NOT NULL,
  `response` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `savedanswers`
--

INSERT INTO `savedanswers` (`id`, `eid`, `sid`, `did`, `qid`, `response`) VALUES
(1, 'E001', '123417', 'D003', 'Q004', '{\"qid\":\"Q004\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":2462,\"difficulty\":\"3\"}'),
(2, 'E001', '123417', 'D003', 'Q014', '{\"qid\":\"Q014\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":1922,\"difficulty\":\"2\"}'),
(3, 'E001', '123417', 'D003', 'Q005', '{\"qid\":\"Q005\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":2262,\"difficulty\":\"1\"}'),
(4, 'E001', '123417', 'D003', 'Q022', '{\"qid\":\"Q022\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":8969,\"difficulty\":\"2\"}'),
(5, 'E001', '123417', 'D003', 'Q002', '{\"qid\":\"Q002\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":4625,\"difficulty\":\"1\"}'),
(6, 'E001', '123417', 'D003', 'Q018', '{\"qid\":\"Q018\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":2712,\"difficulty\":\"2\"}'),
(7, 'E001', '123417', 'D003', 'Q012', '{\"qid\":\"Q012\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":2553,\"difficulty\":\"3\"}'),
(8, 'E001', '123417', 'D003', 'Q032', '{\"qid\":\"Q032\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":2396,\"difficulty\":\"4\"}'),
(9, 'E001', '123417', 'D003', 'Q020', '{\"qid\":\"Q020\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":2590,\"difficulty\":\"3\"}'),
(10, 'E001', '123417', 'D003', 'Q026', '{\"qid\":\"Q026\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":3710,\"difficulty\":\"4\"}'),
(11, 'E006', '123417', 'D008', 'H027', '{\"qid\":\"H027\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":6688,\"difficulty\":\"3\"}'),
(12, 'E006', '123417', 'D008', 'H032', '{\"qid\":\"H032\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":3367,\"difficulty\":\"4\"}'),
(13, 'E006', '123417', 'D008', 'H025', '{\"qid\":\"H025\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":9146,\"difficulty\":\"3\"}'),
(14, 'E006', '123417', 'D008', 'H012', '{\"qid\":\"H012\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":4644,\"difficulty\":\"2\"}'),
(15, 'E006', '123417', 'D008', 'H013', '{\"qid\":\"H013\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":6092,\"difficulty\":\"3\"}'),
(16, 'E006', '123417', 'D008', 'H016', '{\"qid\":\"H016\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":3020,\"difficulty\":\"2\"}'),
(17, 'E006', '123417', 'D008', 'H020', '{\"qid\":\"H020\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":3209,\"difficulty\":\"3\"}'),
(18, 'E006', '123417', 'D008', 'H007', '{\"qid\":\"H007\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":6555,\"difficulty\":\"2\"}'),
(19, 'E006', '123417', 'D008', 'H006', '{\"qid\":\"H006\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":8556,\"difficulty\":\"1\"}'),
(20, 'E006', '123417', 'D008', 'H017', '{\"qid\":\"H017\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":6970,\"difficulty\":\"2\"}'),
(41, 'E001', '34664', 'D003', 'Q024', '{\"qid\":\"Q024\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":4155,\"difficulty\":\"3\"}'),
(42, 'E001', '34664', 'D003', 'Q039', '{\"qid\":\"Q039\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":7518,\"difficulty\":\"4\"}'),
(43, 'E001', '34664', 'D003', 'Q013', '{\"qid\":\"Q013\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":7284,\"difficulty\":\"3\"}'),
(44, 'E001', '34664', 'D003', 'Q033', '{\"qid\":\"Q033\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":7746,\"difficulty\":\"4\"}'),
(45, 'E001', '34664', 'D003', 'Q004', '{\"qid\":\"Q004\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":1757,\"difficulty\":\"3\"}'),
(46, 'E001', '34664', 'D003', 'Q001', '{\"qid\":\"Q001\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":1182,\"difficulty\":\"2\"}'),
(47, 'E001', '34664', 'D003', 'Q016', '{\"qid\":\"Q016\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":1359,\"difficulty\":\"1\"}'),
(48, 'E001', '34664', 'D003', 'Q025', '{\"qid\":\"Q025\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":1422,\"difficulty\":\"1\"}'),
(49, 'E001', '34664', 'D003', 'Q006', '{\"qid\":\"Q006\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":2237,\"difficulty\":\"1\"}'),
(50, 'E001', '34664', 'D003', 'Q011', '{\"qid\":\"Q011\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":1278,\"difficulty\":\"1\"}'),
(51, 'E001', '220150019', 'D003', 'Q020', '{\"qid\":\"Q020\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":9123,\"difficulty\":\"3\"}'),
(52, 'E001', '220150019', 'D003', 'Q027', '{\"qid\":\"Q027\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":5654,\"difficulty\":\"4\"}'),
(53, 'E001', '220150019', 'D003', 'Q036', '{\"qid\":\"Q036\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":120884,\"difficulty\":\"5\"}'),
(54, 'E001', '220150019', 'D003', 'Q028', '{\"qid\":\"Q028\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":12691,\"difficulty\":\"5\"}'),
(55, 'E001', '220150019', 'D003', 'Q038', '{\"qid\":\"Q038\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":24472,\"difficulty\":\"5\"}'),
(56, 'E001', '220150019', 'D003', 'Q039', '{\"qid\":\"Q039\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":13831,\"difficulty\":\"4\"}'),
(57, 'E001', '220150019', 'D003', 'Q034', '{\"qid\":\"Q034\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":9642,\"difficulty\":\"5\"}'),
(58, 'E001', '220150019', 'D003', 'Q035', '{\"qid\":\"Q035\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":3832,\"difficulty\":\"5\"}'),
(59, 'E001', '220150019', 'D003', 'Q037', '{\"qid\":\"Q037\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":5051,\"difficulty\":\"4\"}'),
(60, 'E001', '220150019', 'D003', 'Q040', '{\"qid\":\"Q040\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":5828,\"difficulty\":\"5\"}'),
(61, 'E006', 'r', 'D008', 'H020', '{\"qid\":\"H020\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":9848,\"difficulty\":\"3\"}'),
(62, 'E006', 'r', 'D008', 'H016', '{\"qid\":\"H016\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":4420,\"difficulty\":\"2\"}'),
(63, 'E006', 'r', 'D008', 'H022', '{\"qid\":\"H022\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":7352,\"difficulty\":\"3\"}'),
(64, 'E006', 'r', 'D008', 'H032', '{\"qid\":\"H032\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":17046,\"difficulty\":\"4\"}'),
(65, 'E006', 'r', 'D008', 'H009', '{\"qid\":\"H009\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":6959,\"difficulty\":\"3\"}'),
(66, 'E006', 'r', 'D008', 'H002', '{\"qid\":\"H002\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":5759,\"difficulty\":\"2\"}'),
(67, 'E006', 'r', 'D008', 'H014', '{\"qid\":\"H014\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":7238,\"difficulty\":\"1\"}'),
(68, 'E006', 'r', 'D008', 'H018', '{\"qid\":\"H018\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":4286,\"difficulty\":\"2\"}'),
(69, 'E006', 'r', 'D008', 'H004', '{\"qid\":\"H004\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":3974,\"difficulty\":\"1\"}'),
(70, 'E006', 'r', 'D008', 'H019', '{\"qid\":\"H019\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":9465,\"difficulty\":\"2\"}'),
(71, 'E002', '123417', 'D007', 'P005', '{\"qid\":\"P005\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":21234,\"difficulty\":\"3\"}'),
(72, 'E002', '123417', 'D007', 'P034', '{\"qid\":\"P034\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":6777,\"difficulty\":\"4\"}'),
(73, 'E002', '123417', 'D007', 'P033', '{\"qid\":\"P033\",\"useroption\":3,\"iscorrect\":true,\"timetaken\":5491,\"difficulty\":\"5\"}'),
(74, 'E002', '123417', 'D007', 'P036', '{\"qid\":\"P036\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":6567,\"difficulty\":\"5\"}'),
(75, 'E002', '123417', 'D007', 'P026', '{\"qid\":\"P026\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":3444,\"difficulty\":\"5\"}'),
(76, 'E002', '123417', 'D007', 'P022', '{\"qid\":\"P022\",\"useroption\":3,\"iscorrect\":true,\"timetaken\":10102,\"difficulty\":\"4\"}'),
(77, 'E002', '123417', 'D007', 'P029', '{\"qid\":\"P029\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":6885,\"difficulty\":\"5\"}'),
(78, 'E002', '123417', 'D007', 'P037', '{\"qid\":\"P037\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":15836,\"difficulty\":\"4\"}'),
(79, 'E002', '123417', 'D007', 'P009', '{\"qid\":\"P009\",\"useroption\":3,\"iscorrect\":true,\"timetaken\":3001,\"difficulty\":\"3\"}'),
(80, 'E002', '123417', 'D007', 'P027', '{\"qid\":\"P027\",\"useroption\":3,\"iscorrect\":true,\"timetaken\":7120,\"difficulty\":\"4\"}'),
(81, 'E003', '123417', 'D002', 'C015', '{\"qid\":\"C015\",\"useroption\":4,\"iscorrect\":true,\"timetaken\":6482,\"difficulty\":\"3\"}'),
(82, 'E003', '123417', 'D002', 'C027', '{\"qid\":\"C027\",\"useroption\":3,\"iscorrect\":true,\"timetaken\":4014,\"difficulty\":\"4\"}'),
(83, 'E003', '123417', 'D002', 'C045', '{\"qid\":\"C045\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":3007,\"difficulty\":\"5\"}'),
(84, 'E003', '123417', 'D002', 'C046', '{\"qid\":\"C046\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":4454,\"difficulty\":\"5\"}'),
(85, 'E003', '123417', 'D002', 'C048', '{\"qid\":\"C048\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":15569,\"difficulty\":\"5\"}'),
(86, 'E003', '123417', 'D002', 'C032', '{\"qid\":\"C032\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":11672,\"difficulty\":\"4\"}'),
(87, 'E003', '123417', 'D002', 'C016', '{\"qid\":\"C016\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":2311,\"difficulty\":\"3\"}'),
(88, 'E003', '123417', 'D002', 'C007', '{\"qid\":\"C007\",\"useroption\":2,\"iscorrect\":false,\"timetaken\":8410,\"difficulty\":\"2\"}'),
(89, 'E003', '123417', 'D002', 'C001', '{\"qid\":\"C001\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":6347,\"difficulty\":\"1\"}'),
(90, 'E003', '123417', 'D002', 'C017', '{\"qid\":\"C017\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":13642,\"difficulty\":\"2\"}'),
(91, 'E004', '123417', 'D010', 'B021', '{\"qid\":\"B021\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":9020,\"difficulty\":\"3\"}'),
(92, 'E004', '123417', 'D010', 'B032', '{\"qid\":\"B032\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":9687,\"difficulty\":\"4\"}'),
(93, 'E004', '123417', 'D010', 'B023', '{\"qid\":\"B023\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":3405,\"difficulty\":\"3\"}'),
(94, 'E004', '123417', 'D010', 'B017', '{\"qid\":\"B017\",\"useroption\":3,\"iscorrect\":true,\"timetaken\":6429,\"difficulty\":\"2\"}'),
(95, 'E004', '123417', 'D010', 'B026', '{\"qid\":\"B026\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":9335,\"difficulty\":\"3\"}'),
(96, 'E004', '123417', 'D010', 'B013', '{\"qid\":\"B013\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":9340,\"difficulty\":\"2\"}'),
(97, 'E004', '123417', 'D010', 'B022', '{\"qid\":\"B022\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":9021,\"difficulty\":\"3\"}'),
(98, 'E004', '123417', 'D010', 'B011', '{\"qid\":\"B011\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":8728,\"difficulty\":\"2\"}'),
(99, 'E004', '123417', 'D010', 'B024', '{\"qid\":\"B024\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":2320,\"difficulty\":\"3\"}'),
(100, 'E004', '123417', 'D010', 'B037', '{\"qid\":\"B037\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":2958,\"difficulty\":\"4\"}'),
(101, 'E007', '123417', 'D004', 'CS019', '{\"qid\":\"CS019\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":4370,\"difficulty\":\"3\"}'),
(102, 'E007', '123417', 'D004', 'CS013', '{\"qid\":\"CS013\",\"useroption\":3,\"iscorrect\":false,\"timetaken\":12322,\"difficulty\":\"2\"}'),
(103, 'E007', '123417', 'D004', 'CS002', '{\"qid\":\"CS002\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":5336,\"difficulty\":\"1\"}'),
(104, 'E007', '123417', 'D004', 'CS014', '{\"qid\":\"CS014\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":4513,\"difficulty\":\"2\"}'),
(105, 'E007', '123417', 'D004', 'CS017', '{\"qid\":\"CS017\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":7655,\"difficulty\":\"3\"}'),
(106, 'E007', '123417', 'D004', 'CS016', '{\"qid\":\"CS016\",\"useroption\":3,\"iscorrect\":true,\"timetaken\":6058,\"difficulty\":\"2\"}'),
(107, 'E007', '123417', 'D004', 'CS024', '{\"qid\":\"CS024\",\"useroption\":1,\"iscorrect\":true,\"timetaken\":3076,\"difficulty\":\"3\"}'),
(108, 'E007', '123417', 'D004', 'CS025', '{\"qid\":\"CS025\",\"useroption\":1,\"iscorrect\":false,\"timetaken\":5300,\"difficulty\":\"4\"}'),
(109, 'E007', '123417', 'D004', 'CS022', '{\"qid\":\"CS022\",\"useroption\":2,\"iscorrect\":true,\"timetaken\":4131,\"difficulty\":\"3\"}'),
(110, 'E007', '123417', 'D004', 'CS030', '{\"qid\":\"CS030\",\"useroption\":4,\"iscorrect\":false,\"timetaken\":3267,\"difficulty\":\"4\"}');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `sid` varchar(11) NOT NULL,
  `sname` varchar(255) DEFAULT NULL,
  `Phone_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`sid`, `sname`, `Phone_number`) VALUES
('123417', 'Himanshu Singhal', '08800182654'),
('132467980', 'Jimmy', '123567980'),
('1438561', 'satan', '35471371'),
('220150019', 'zombie', '9836339918'),
('23467453254', 'ishan', '3456257257'),
('34664', 'Rishita Agarwal', '7014377898'),
('354247698', 'Jimmy McGrill', '3425678970'),
('4578126', 'joker', '64712824567'),
('68745965', 'morgana', '5433482146'),
('r', 'Rista', '6');

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentdetails`
-- (See below for the actual view)
--
CREATE TABLE `studentdetails` (
`id` int(11)
,`email` varchar(100)
,`password_hash` varchar(255)
,`name` varchar(100)
,`role` enum('student','evaluator','admin')
,`sid` varchar(11)
,`Phone_number` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_result`
-- (See below for the actual view)
--
CREATE TABLE `student_result` (
`sid` varchar(255)
,`eid` varchar(255)
,`qid` varchar(255)
,`sname` varchar(255)
,`ename` varchar(255)
,`qcontent` text
,`correct_option_id` int(11)
,`response` text
,`date` date
,`did` varchar(25)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_schedule`
-- (See below for the actual view)
--
CREATE TABLE `student_schedule` (
`sid` varchar(11)
,`eid` varchar(11)
,`ename` varchar(255)
,`did` varchar(25)
,`Venue` varchar(255)
,`Timeslot` varchar(255)
,`Date` date
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `role` enum('student','evaluator','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `name`, `role`) VALUES
(20, 'himanshu.hs918@gmail.com', '$2b$10$F08U9E8pw1xberlSBfO4..mAfwJTaZ2ysY9H.Ij01ECCWqNXM4B6q', 'Himanshu Singhal', 'student'),
(22, 'm@gmail.com', '$2b$10$iSfCygWwl.2ORB.cRMm4MO3WBZTE9TYHDG0v548JNwiZ9576ZRHHe', 'morgana', 'student'),
(23, 'j@gmail.com', '$2b$10$vHG0OjffrKcUuY4rrshGFeGWVkUMDKXYE6.Bk0bKgyU8JylTxvy1O', 'joker', 'student'),
(24, 's@gmail.com', '$2b$10$2LsQ1l/AH4Nv6Kmrn4ZuRegGMuzS98ccsd2z3GJ4PNwLHkVj8C1Bu', 'satan', 'student'),
(25, 'j2@gmail.com', '$2b$10$8NGQp5Ny2y.ueXooBP/gx.oln6K/RlOPYppoUoMdtOqw1N.Resa7C', 'Jimmy', 'student'),
(26, 'i@gmail.com', '$2b$10$JkBCceX05LT/QPQMx.dzx.xN8Y2a0MhoplVC.5L7nIe1VJTg5prLa', 'ishan', 'student'),
(27, 'rishitaagarwal2604@gmail.com', '$2b$10$/A99enq.xOKEyc83oTf5p.2huRfUT7vGVr2/7QXo14faxr/CXDroa', 'Rishita Agarwal', 'student'),
(28, 'm.saptarshi@iitg.ac.in', '$2b$10$KtVL7RJ2cZu7me.OD/6MZeCT2aeerOZOpSNrXQClATSSj.D0p65ii', 'zombie', 'student'),
(29, 'rista@mail.com', '$2b$10$7vpAqbKJ3yV50heEUEKx8u1aUgX06S7acO461BA1YYdnZAM77W.lq', 'Rista', 'student'),
(42, 'bojack@gmail.com', '$2b$10$VV/hvLLbSfFU8Dl9k3GOPujBT422YD3rpobvxRPY3dkoDCNLImXlG', 'Bojack', 'evaluator'),
(43, 'h.singhal@iitg.ac.in', '$2b$10$eQcKMENdXdeqZEeIoXC8COwoIYOfeZEOyfMDu8meLPicEto8Erzw6', 'Himanshu', 'evaluator');

-- --------------------------------------------------------

--
-- Structure for view `evaluator_details`
--
DROP TABLE IF EXISTS `evaluator_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `evaluator_details`  AS SELECT `u`.`id` AS `id`, `u`.`email` AS `email`, `u`.`password_hash` AS `password_hash`, `u`.`name` AS `name`, `u`.`role` AS `role`, `e`.`evid` AS `evid`, `e`.`Phone` AS `Phone` FROM (`users` `u` join `evaluators` `e` on(`e`.`name` = `u`.`name`)) ;

-- --------------------------------------------------------

--
-- Structure for view `exam_schedule_view`
--
DROP TABLE IF EXISTS `exam_schedule_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `exam_schedule_view`  AS SELECT `e`.`eid` AS `eid`, `e`.`ename` AS `ename`, `e`.`fees` AS `fees`, `d`.`did` AS `did`, `d`.`Venue` AS `Venue`, `d`.`Timeslot` AS `Timeslot`, `d`.`Date` AS `Date` FROM ((`exam` `e` join `exam_schedule` `es` on(`e`.`eid` = `es`.`eid`)) join `dates` `d` on(`d`.`did` = `es`.`did`)) ;

-- --------------------------------------------------------

--
-- Structure for view `studentdetails`
--
DROP TABLE IF EXISTS `studentdetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentdetails`  AS SELECT `u`.`id` AS `id`, `u`.`email` AS `email`, `u`.`password_hash` AS `password_hash`, `u`.`name` AS `name`, `u`.`role` AS `role`, `s`.`sid` AS `sid`, `s`.`Phone_number` AS `Phone_number` FROM (`users` `u` join `student` `s` on(`s`.`sname` = `u`.`name`)) ;

-- --------------------------------------------------------

--
-- Structure for view `student_result`
--
DROP TABLE IF EXISTS `student_result`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_result`  AS SELECT `sa`.`sid` AS `sid`, `sa`.`eid` AS `eid`, `sa`.`qid` AS `qid`, `s`.`sname` AS `sname`, `e`.`ename` AS `ename`, `q`.`qcontent` AS `qcontent`, `q`.`correct_option_id` AS `correct_option_id`, `sa`.`response` AS `response`, `d`.`Date` AS `date`, `d`.`did` AS `did` FROM ((((`savedanswers` `sa` join `student` `s` on(`s`.`sid` = `sa`.`sid`)) join `exam` `e` on(`e`.`eid` = `sa`.`eid`)) join `questions` `q` on(`q`.`qid` = `sa`.`qid`)) join `dates` `d` on(`d`.`did` = `sa`.`did`)) ;

-- --------------------------------------------------------

--
-- Structure for view `student_schedule`
--
DROP TABLE IF EXISTS `student_schedule`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_schedule`  AS SELECT `s`.`sid` AS `sid`, `e`.`eid` AS `eid`, `e`.`ename` AS `ename`, `d`.`did` AS `did`, `d`.`Venue` AS `Venue`, `d`.`Timeslot` AS `Timeslot`, `d`.`Date` AS `Date` FROM ((((`student` `s` join `exam_choices` `ec` on(`s`.`sid` = `ec`.`sid`)) join `dates` `d` on(`d`.`did` = `ec`.`did`)) join `exam_schedule` `es` on(`es`.`did` = `d`.`did`)) join `exam` `e` on(`e`.`eid` = `es`.`eid`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dates`
--
ALTER TABLE `dates`
  ADD PRIMARY KEY (`did`,`Timeslot`,`Date`);

--
-- Indexes for table `evaluators`
--
ALTER TABLE `evaluators`
  ADD PRIMARY KEY (`evid`);

--
-- Indexes for table `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`eid`);

--
-- Indexes for table `exam_choices`
--
ALTER TABLE `exam_choices`
  ADD PRIMARY KEY (`sid`,`did`),
  ADD KEY `did` (`did`);

--
-- Indexes for table `exam_schedule`
--
ALTER TABLE `exam_schedule`
  ADD PRIMARY KEY (`eid`,`did`),
  ADD KEY `did` (`did`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`qid`),
  ADD KEY `eid` (`eid`);

--
-- Indexes for table `savedanswers`
--
ALTER TABLE `savedanswers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eid` (`eid`),
  ADD KEY `sid` (`sid`),
  ADD KEY `qid` (`qid`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`sid`);

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
-- AUTO_INCREMENT for table `savedanswers`
--
ALTER TABLE `savedanswers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exam_choices`
--
ALTER TABLE `exam_choices`
  ADD CONSTRAINT `exam_choices_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`),
  ADD CONSTRAINT `exam_choices_ibfk_2` FOREIGN KEY (`did`) REFERENCES `dates` (`did`);

--
-- Constraints for table `exam_schedule`
--
ALTER TABLE `exam_schedule`
  ADD CONSTRAINT `exam_schedule_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`),
  ADD CONSTRAINT `exam_schedule_ibfk_2` FOREIGN KEY (`did`) REFERENCES `dates` (`did`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`);

--
-- Constraints for table `savedanswers`
--
ALTER TABLE `savedanswers`
  ADD CONSTRAINT `savedanswers_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`),
  ADD CONSTRAINT `savedanswers_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`),
  ADD CONSTRAINT `savedanswers_ibfk_3` FOREIGN KEY (`qid`) REFERENCES `questions` (`qid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
