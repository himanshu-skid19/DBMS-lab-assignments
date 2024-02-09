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
$currentDate = date('Y-m-d');
$qty = rand(1, 10);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $conn->begin_transaction();

    try {
        ;
        $patient_ssn = $_POST['patient_ssn'];
        $patient_address = $_POST['patient_address'];
        $patient_age = $_POST['patient_age'];


        
        $query = "SELECT * FROM doctor ORDER BY RAND() LIMIT 1";
    
        $st = $conn->prepare($query);
        $st->execute();
        
        
        $result = $st->get_result();
        if ($result->num_rows > 0){
            $random_doctor = $result->fetch_assoc();
            $doctor_ssn = $random_doctor['ssn'];
        } else {
            throw new Exception("No doctor available");
        }
        $st->free_result();


        $drug = "SELECT * FROM drug ORDER BY RAND() LIMIT 1";
        $st2 = $conn->prepare($drug);
        $st2->execute();
        $result2 = $st2->get_result();
        if ($result2->num_rows > 0){
            $random_drug = $result2->fetch_assoc();
            $drug_name = $random_drug['Trade_name'];
            $drug_company = $random_drug['Company_name'];
        } else {
            throw new Exception("No drug available");
        }
        $st2->free_result();
        



        $stmt = $conn->prepare("INSERT INTO patient (ssn, name, address, Age, Pri_physician_ssn) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssis", $patient_ssn, $name, $patient_address, $patient_age, $doctor_ssn);
        $stmt->execute();
        $stmt->close();

        $stmt2 = $conn->prepare("INSERT INTO prescribes (patient_ssn, doctor_ssn,  drug_Trade_name, company_name, date, qty) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt2->bind_param("sssssi", $patient_ssn, $doctor_ssn, $drug_name, $drug_company, $currentDate, $qty);
        $stmt2->execute();
        $stmt2->close();

        $conn->commit();
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