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
  `Pri_physician_ssn` varchar(255) DEFAULT NOT NULL,
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


### Contracts_with
```sql
CREATE TABLE `contracts_with` (
  `pharmacy_name` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date,
  `text` text,
  `supervisor_name` varchar(255),
  PRIMARY KEY (`pharmacy_name`, `company_name`),
  FOREIGN KEY (`pharmacy_name`) REFERENCES `pharmacy` (`name`),
  FOREIGN KEY (`company_name`) REFERENCES `pharmaceutical_company` (`name`)
)
```



## Views

To facilitate the operation of only viewing what the user's authorization allows you to, you must create several views. For example, a patient must only be able to view details related to him such as his physician's details (anything that is not sensitive) and his prescriptions. 

Given below are commands to create several views based on the role of the user.

### Patient View
```sql
CREATE VIEW PatientDetails AS
SELECT
  u.id,
	p.SSN,
    p.Name,
    P.Address,
    p.Age,
    ph.doctor_name AS PhysicianName,
    ph.Years_exp,
    ph.specialization,
    d.Trade_name AS DrugName,
    d.Company_name,
    pr.date,
    pr.qty,
    s.price,
    pa.name AS PharmacyName,
    pa.address AS PharmacyAddress,
    pa.Phone_number AS PharmacyPhone,
    c.Phone_number AS CompanyPhone
FROM
 	Patient p
JOIN
  users u ON p.name = u.name
JOIN
	doctor ph ON p.Pri_physician_ssn = ph.ssn
JOIN
	prescribes pr ON p.SSN = pr.patient_ssn
JOIN
	drug d ON pr.drug_Trade_name = d.Trade_name
JOIN
	sells s ON d.Trade_name = s.drug_Trade_name AND d.Company_name = s.company_name
JOIN
	pharmacy pa ON s.pharmacy_name = pa.name
JOIN
	pharmaceutical_company c ON d.Company_name = c.name
```

### Company View

```sql
CREATE VIEW CompanyDetails AS
SELECT
 	p.name,
    p.Phone_number as company_phone,
    pr.drug_Trade_name,
    pr.date,
    pr.qty,
 	d.formula,
    s.pharmacy_name,
    s.price,
    pa.address,
    pa.Phone_number as pharmacy_phone
    
FROM
 	pharmaceutical_company p
JOIN
	prescribes pr ON p.name = pr.company_name
JOIN
	drug d ON pr.drug_Trade_name = d.Trade_name
JOIN
	sells s ON d.Trade_name = s.drug_Trade_name AND d.Company_name = s.company_name
JOIN
	pharmacy pa ON s.pharmacy_name = pa.name

```

### Pharmacy Details

```sql
CREATE VIEW PharmacyDetails AS
SELECT
	ph.name,
    ph.address,
    ph.Phone_number,
    s.drug_Trade_name,
    s.company_name,
    s.price,
    d.formula,
    cw.start_date,
    cw.end_date,
    cw.text,
    cw.supervisor_name
    
FROM
 	pharmacy ph
JOIN
	sells s ON ph.name = s.pharmacy_name
JOIN
	drug d ON s.drug_Trade_name = d.Trade_name
JOIN
	contracts_with cw ON cw.pharmacy_name = ph.name


```