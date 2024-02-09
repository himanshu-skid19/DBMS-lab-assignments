<?php
session_start();
require_once('db_connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name= $_POST['name'];
    $username = $_POST['username'];
    $password = $_POST['password'];
    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    if (!empty($_POST['role'])) {
        $role = $_POST['role'];
   
    $conn->begin_transaction();

    try {
        $stmt = $conn->prepare("INSERT INTO Users (username, password_hash, name,  role) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $username, $password_hash, $name, $role);
        $stmt->execute();
        $conn->commit();

        $_SESSION['id'] = $stmt->insert_id;
        $_SESSION['role'] = $role;
        $_SESSION['name'] = $name;
        

        $stmt->close();
        $conn->close();

        switch ($role) {
            case 'doctor':
                header('Location: doctor_register.html');
                break;
            case 'patient':
                header('Location: patient_register.html');
                break;
            case 'admin':
                header('Location: admin_register.html');
                break;
            default:
                header('Location: error_page.html' );
                break;
        }



    } catch (Exception $e) {
        $conn->rollback();
        echo "Registration failed" . $e->getMessage();
        exit();
    }
}

    
}
?>