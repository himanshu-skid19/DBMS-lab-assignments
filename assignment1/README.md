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