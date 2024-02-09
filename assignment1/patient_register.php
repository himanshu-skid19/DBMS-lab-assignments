<?php
session_start();

if (!isset($_SESSION['id'])) {
    header('Location: login.php');
    exit;
}

$userID = $_SESSION['id'];
$userRole = $_SESSION['role'];

require_once('db_connection.php');

$name = $_SESSION['name'];


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $conn->begin_transaction();

    try {
        ;
        $patient_ssn = $_POST['patient_ssn'];
        $patient_address = $_POST['patient_address'];
        $patient_age = $_POST['patient_age'];


        try{
            $query = "SELECT * FROM doctor ORDER BY RAND() LIMIT 1";
            $st = $conn->prepare($query);
            $st->execute();
    
            $result = $st->get_result();
            if ($result->num_rows > 0){
                $random_doctor = $result->fetch_assoc();
                $doctor_ssn = $random_doctor['ssn'];
            } else {
                echo "No doctor available";
                exit();
            }
        }
        catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            exit();
        }
     



        $stmt = $conn->prepare("INSERT INTO patient (ssn, name, address, Age, Pri_physician_ssn) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssis", $patient_ssn, $name, $patient_address, $patient_age, $doctor_ssn);
        $stmt->execute();
        $conn->commit();
        $stmt->close();
        $conn->close();
        header('Location: login.html');
        echo "Patient registered successfully";
        

    } catch (Exception $e) {
        $conn->rollback();
        echo "Registration failed" . $e->getMessage();
        exit();
    }

}
    
?>