<?php
require_once('db_connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $conn->begin_transaction();

    try {
        $doctor_ssn = $_POST['doctor_ssn'];
        $doctor_name = $_POST['doctor_name'];
        $doctor_specialization = $_POST['doctor_specialization'];
        $doctor_experience = $_POST['doctor_experience'];

        $stmt = $conn->prepare("INSERT INTO doctor (ssn, doctor_name, specialization, Years_exp) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("sssi", $doctor_ssn, $doctor_name, $doctor_specialization, $doctor_experience);
        $stmt->execute();
        $conn->commit();
        $stmt->close();
        $conn->close();
        header('Location: login.html');
        echo "Doctor registered successfully";

    } catch (Exception $e) {
        $conn->rollback();
        echo "Registration failed" . $e->getMessage();
        exit();
    }

}
    
?>