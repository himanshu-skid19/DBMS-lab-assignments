<?php
session_start();

require_once('db_connection.php');

$user_id = $_SESSION['id'];
$user_role = $_SESSION['role'];

$sql = $conn->prepare("SELECT * FROM user_doctor_details WHERE user_id = ?");


$sql->bind_param("i", $user_id);

$sql->execute();
$result = $sql->get_result();
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $ssn = $row['ssn'];
    $name = $row['name'];
    $address = $row['address'];
    $age = $row['Age'];
    $doc_name = $row['doc_name'];
    $doc_exp = $row['experience'];
    $doctor_specialization = $row['doctor_specialization'];
    
    
} else {
    echo "No user found with that username";
}
$sql->close();
$conn->close();
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <title>Homepage</title>
</head>
<body>
    <nav class="container-fluid">
        <ul>
            <li><strong>HomePage</strong></li>
        </ul>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#" role="button">About</a></li>
        </ul>
    </nav>
    <main class="container">
        <div class="grid">
            <section>
                <h1>Your Details</h1>
                <div class="card">
                    <p><strong>SSN:</strong> <?php echo $ssn; ?></p>
                    <p><strong>Name:</strong> <?php echo $name; ?></p>
                    <p><strong>Address:</strong> <?php echo $address; ?></p>
                    <p><strong>Age:</strong> <?php echo $age; ?> years</p>
                </div>
                <h2>Primary Physician Details</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Experience</th>
                            <th>Specialization</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><?php echo $doc_name; ?></td>
                            <td><?php echo $doc_exp; ?> Years</td>
                            <td><?php echo $doctor_specialization; ?></td>
                        </tr>
                    </tbody>
                </table>
            </section>
        </div>
    </main>
</body>
</html>