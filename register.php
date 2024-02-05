<?php
require_once('db_connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    $role = $_POST['role'];


    $reference_id = null;
    $userRole = ($role == "user") ? 'patient' : (($role == 'admin') ? 'doctor' : 'admin');

    $conn->begin_transaction();

    try {
        if ($role == 'doctor') {
            $doctor_ssn = $_POST['doctor_ssn'];
            $doctor_name = $_POST['doctor_name'];
            $speciality = $_POST['speciality'];
            $Years_exp = $_POST['Years_exp'];
            
            $stmt = $conn->prepare("INSERT INTO Doctors (ssn, name, speciality, years_of_experience) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("sssi", $doctor_ssn, $doctor_name, $speciality, $Years_exp);
            $stmt->execute();
            $reference_id = $doctor_ssn;
        }
        elseif ($role == 'patient') {
            $patient_ssn = $_POST['patient_ssn'];
            $patient_name = $_POST['patient_name'];
            $patient_address = $_POST['patient_address'];
            $patient_age = $_POST['patient_age'];
            $pri_physician = $_POST['pri_physician'];

            $stmt = $conn->prepare("INSERT INTO Patients (ssn, name, address, age, primary_physician) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssis", $patient_ssn, $patient_name, $patient_address, $patient_age, $pri_physician);
            $stmt->execute();
            $reference_id = $patient_ssn;
        }
        elseif ($role == 'company'){
            $company_name = $_POST['company_name'];
            $company_phone = $_POST['company_phone'];

            $stmt = $conn->prepare("INSERT INTO Companies (name, phone) VALUES (?, ?)");
            $stmt->bind_param("ss", $company_name, $company_phone);
            $stmt->execute();
            $reference_id = $company_name;
        }

        $stmt = $conn->prepare("INSERT INTO Users (username, password_hash, role, reference_id) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("sssi", $username, $password_hash, $userRole, $reference_id);
        $stmt->execute();

        $conn->commit();
        echo "User registered successfully";

    } catch (Exception $e) {
        $conn->rollback();
        echo "Registration failed: " . $e->getMessage();
    }

    $stmt->close();
    $conn->close();
    

    // $sql = "INSERT INTO Users (username, password_hash, role, reference_id) VALUES (?, ?, ?, ?)";

    // $stmt = $conn->prepare($sql);
    // $stmt->bind_param("sssi", $username, $passwordHash, $userRole, $reference_id);

    // if ($stmt->execute()) {
    //     echo "User registered successfully";
    // } else {
    //     echo "Error: " . $sql . "<br>" . $conn->error;
    // }

    // $stmt->close();
    // $conn->close();
}
?>