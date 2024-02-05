<?php
session_start();

require_once('db_connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = $conn->prepare("SELECT * id, password_hash, role FROM Users WHERE username = ?");
    $sql->bind_param("s", $username);
    $sql->execute();
    $result = $sql->get_result();
    
    
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        if (password_verify($password, $row['password_hash'])) {
            $_SESSION['id'] = $row['id'];
            $_SESSION['role'] = $row['role'];
            header('Location: index.php');
        } else {
            echo "Invalid username or password";
        }
    } else {
        echo "No user found with that username";
    }

    $sql->close();
    $conn->close();

}
?>