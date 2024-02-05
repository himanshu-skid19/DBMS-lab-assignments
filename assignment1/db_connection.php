<?php
$servername = "localhost";
$dbusername = "root";
$dbPassword = "";
$dbName = "hospital";

$conn = new mysqli($servername, $dbusername, $dbPassword, $dbName);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>