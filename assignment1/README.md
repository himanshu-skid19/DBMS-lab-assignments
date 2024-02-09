# Hospital Management System

This code is a simple demonstration of how you can create a database from an ER diagram and demonstrate using a frontend how you can use views to only show data relevant to a user based on his role

## Getting Started
1. Before you do anything in this code, you must start a MySQL and Apache server using XAMPP.

2. Next you must run the following commands to create the tables needed for to run this ER diagram.

### Doctor
```sql
CREATE TABLE `doctor` (
  `ssn` varchar(255) NOT NULL,
  `doctor_name` varchar(255) DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `Years_exp` int(11) DEFAULT NULL,
  PRIMARY KEY (`ssn`)
)
```


### Patient
```sql
CREATE TABLE `patient` (
  `ssn` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Pri_physician_ssn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `Pri_physician_ssn` (`Pri_physician_ssn`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`Pri_physician_ssn`) REFERENCES `doctor` (`ssn`)
)
```

###  Users
```sql
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `role` enum('doctor','patient','company','admin') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `username_2` (`username`),
  KEY `role` (`role`)
)
```

### Pharmaceutical Company
```sql
	
CREATE TABLE `pharmaceutical_company` (
  `name` varchar(255) NOT NULL,
  `Phone_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`name`)
) 
```

### Pharmacy
```sql
CREATE TABLE `pharmacy` (
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `Phone_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`name`)
)
```
### Drug
```sql
CREATE TABLE `drug` (
  `Trade_name` varchar(255) NOT NULL,
  `formula` text DEFAULT NULL,
  `Company_name` varchar(255) NOT NULL,
  PRIMARY KEY (`Trade_name`,`Company_name`),
  KEY `Company_name` (`Company_name`),
  CONSTRAINT `drug_ibfk_1` FOREIGN KEY (`Company_name`) REFERENCES `pharmaceutical_company` (`name`)
)
```

### Prescribes
```sql
CREATE TABLE `prescribes` (
  `patient_ssn` varchar(20) NOT NULL,
  `doctor_ssn` varchar(20) NOT NULL,
  `drug_Trade_name` varchar(100) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `date` date DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_ssn`,`doctor_ssn`,`drug_Trade_name`,`company_name`),
  KEY `doctor_ssn` (`doctor_ssn`),
  KEY `drug_Trade_name` (`drug_Trade_name`,`company_name`),
  CONSTRAINT `prescribes_ibfk_1` FOREIGN KEY (`patient_ssn`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `prescribes_ibfk_2` FOREIGN KEY (`doctor_ssn`) REFERENCES `doctor` (`ssn`),
  CONSTRAINT `prescribes_ibfk_3` FOREIGN KEY (`drug_Trade_name`, `company_name`) REFERENCES `drug` (`Trade_name`, `Company_name`)
) 
```

### Sells
```sql
CREATE TABLE `sells` (
  `pharmacy_name` varchar(100) NOT NULL,
  `drug_Trade_name` varchar(100) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`pharmacy_name`,`drug_Trade_name`,`company_name`),
  KEY `drug_Trade_name` (`drug_Trade_name`,`company_name`),
  CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`pharmacy_name`) REFERENCES `pharmacy` (`name`),
  CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`drug_Trade_name`, `company_name`) REFERENCES `drug` (`Trade_name`, `Company_name`)
)
```




