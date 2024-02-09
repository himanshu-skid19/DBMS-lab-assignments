<?php
require_once('db_connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    if (!empty($_POST['role'])) {
        $role = $_POST['role'];
   
    $conn->begin_transaction();

    try {
        $stmt = $conn->prepare("INSERT INTO Users (username, password_hash, role) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $username, $password_hash, $role);
        $stmt->execute();
        $conn->commit();
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