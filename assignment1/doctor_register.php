<?php
require_once('db_connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $conn->begin_transaction();

    try {
        $doctor_ssn = $_POST['doctor_ssn'];
        $doctor_specialization = $_POST['doctor_specialization'];
        $doctor_experience = $_POST['doctor_experience'];

        $stmt = $conn->prepare("INSERT INTO doctor (ssn, specialization, Years_exp) VALUES (?, ?, ?)");
        $stmt->bind_param("ssi", $doctor_ssn, $doctor_specialization, $doctor_experience);
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