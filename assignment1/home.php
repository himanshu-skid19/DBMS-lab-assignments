<?php
session_start();

require_once('db_connection.php');

$user_id = $_SESSION['id'];
$user_role = $_SESSION['role'];
$user_name = $_SESSION['name'];

if ($user_role == 'patient'){
    $sql = $conn->prepare("SELECT * FROM patientdetails WHERE id = ?");

    $sql->bind_param("i", $user_id);

    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $ssn = $row['SSN'];
        $name = $row['Name'];
        $address = $row['Address'];
        $age = $row['Age'];
        $doc_name = $row['PhysicianName'];
        $doc_exp = $row['Years_exp'];
        $doctor_specialization = $row['specialization'];
        $prescribes_name = $row['DrugName'];
        $prescribes_company = $row['Company_name'];
        $prescribes_date = $row['date'];
        $prescribes_qty = $row['qty'];
        $price = $row['price'];
        $pharmacy_name = $row['PharmacyName'];
        $pharmacy_address = $row['PharmacyAddress'];
        $pharmacy_phone = $row['PharmacyPhone'];
        $company_phone_number = $row['CompanyPhone'];
        
        
    
    } else {
    echo "No user found with that username";
    }
} else if ($user_role == "doctor"){
    $sql = $conn->prepare("SELECT * FROM doctordetails WHERE doctor_name = ?");
    $sql->bind_param("s", $user_name);
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $ssn = $row['ssn'];
        $name = $row['doctor_name'];
        $exp = $row['Years_exp'];
        $patient_name = $row['name'];
        $patient_address = $row['address'];
        $patient_age = $row['Age'];
        $prescription = $row['drug_Trade_name'];
        $company = $row['company_name'];
        $date = $row['date'];
        $qty = $row['qty'];
        $price = $row['price'];
        $formula = $row['formula'];
        $pharmacy_name = $row['pharmacy_name'];
        $pharmacy_address = $row['PharmacyAddress'];
        $pharmacy_phone = $row['PharmacyPhoneNumber'];
        $company_phone_number = $row['CompanyPhoneNumber'];    

    } else {
    echo "No user found with that username";
    }
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
                <?php if ($user_role == 'patient'): ?>
                    <h1>Your Details</h1>
                    <div class="card">
                        <p><strong>SSN:</strong> <?php echo $ssn; ?></p>
                        <p><strong>Name:</strong> <?php echo $name; ?></p>
                        <p><strong>Address:</strong> <?php echo $patient_address; ?></p>
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
                                <th>Price</th>
                                <th>Pharmacy Name</th>
                                <th>Pharmacy Address</th>
                                <th>Pharmacy Phone</th>
                                <th>Company Phone</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><?php echo $prescribes_name; ?></td>
                                <td><?php echo $prescribes_company; ?> </td>
                                <td><?php echo $prescribes_date; ?></td>
                                <td><?php echo $prescribes_qty; ?></td>
                                <td><?php echo $price, " $"; ?></td>
                                <td><?php echo $pharmacy_name; ?></td>
                                <td><?php echo $pharmacy_address; ?></td>
                                <td><?php echo $pharmacy_phone; ?></td>
                                <td><?php echo $company_phone_number; ?></td>

                            </tr>
                        </tbody>
                    </table>
                <?php elseif ($user_role == 'doctor'): ?>
                    <h1>Your Details</h1>
                    <div class="card">
                        <p><strong>SSN:</strong> <?php echo $ssn; ?></p>
                        <p><strong>Name:</strong> <?php echo $name; ?></p>
                        <p><strong>Experience:</strong> <?php echo $exp; ?> years</p>
                    </div>
                    <h2>Patient Details</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Address</th>
                                <th>Age</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><?php echo $patient_name; ?></td>
                                <td><?php echo $patient_address; ?></td>
                                <td><?php echo $patient_age; ?> years</td>
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
                                <th>Price</th>
                                <th>Pharmacy Name</th>
                                <th>Pharmacy Address</th>
                                <th>Pharmacy Phone</th>
                                <th>Company Phone</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><?php echo $prescription; ?></td>
                                <td><?php echo $company; ?></td>
                                <td><?php echo $date; ?></td>
                                <td><?php echo $qty; ?></td>
                                <td><?php echo $price, " $"; ?></td>
                                <td><?php echo $pharmacy_name; ?></td>
                                <td><?php echo $pharmacy_address; ?></td>
                                <td><?php echo $pharmacy_phone; ?></td>
                                <td><?php echo $company_phone_number; ?></td>
                            </tr>
                        </tbody>
                    </table>
                <?php endif; ?>
            </section>
        </div>
    </main>
</body>
</html>