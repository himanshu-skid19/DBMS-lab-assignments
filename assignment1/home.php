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
    
    $prescribes = $conn->prepare("SELECT * FROM prescribes WHERE patient_ssn = ?");
    $prescribes->bind_param("s", $ssn);
    $prescribes->execute();
    $prescribes_result = $prescribes->get_result();
    if ($prescribes_result->num_rows > 0) {
        $prescribes_row = $prescribes_result->fetch_assoc();
        $prescribes_name = $prescribes_row['drug_Trade_name'];
        $prescribes_company = $prescribes_row['company_name'];
        $prescribes_date = $prescribes_row['date'];
        $prescribes_qty = $prescribes_row['qty'];
    
        $prescribes->close();
    }
    
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

                <h2>Prescription Details</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name of Drug</th>
                            <th>Company</th>
                            <th>Prescription Date</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><?php echo $prescribes_name; ?></td>
                            <td><?php echo $prescribes_company; ?> </td>
                            <td><?php echo $prescribes_date; ?></td>
                            <td><?php echo $prescribes_qty; ?></td>
                        </tr>
                    </tbody>
                </table>
            </section>
        </div>
    </main>
</body>
</html>