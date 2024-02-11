<?php
session_start();

require_once('db_connection.php');

$user_id = $_SESSION['id'];
$user_role = $_SESSION['role'];
$user_name = $_SESSION['name'];

$patient_details = [];
$doctor_details = [];
$company_details = [];

if ($user_role == 'patient'){
    $sql = $conn->prepare("SELECT * FROM patientdetails WHERE id = ?");

    $sql->bind_param("i", $user_id);

    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
       while ($row = $result->fetch_assoc()) {
           $patient_details[] = $row;
       }
    
    } else {
    echo "No user found with that username";
    echo $user_name;
    }
} else if ($user_role == "doctor"){
    $sql = $conn->prepare("SELECT * FROM doctordetails WHERE doctor_name = ?");
    $sql->bind_param("s", $user_name);
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $doctor_details[] = $row;
        }

    } else {
    echo "No user found with that username";
    
    }
} else if ($user_role == "company"){
    $sql = $conn->prepare("SELECT * FROM companydetails WHERE name = ?");
    $sql->bind_param("s", $user_name);
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $company_details[] = $row;
        }



    } else {
    echo "No user found with that username";
    
    }
} else if ($user_role == "admin"){
    $sql = $conn->prepare("SELECT * FROM admin WHERE name = ?");
    $sql->bind_param("s", $user_name);
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $admin_name = $row['name'];
        $admin_phone = $row['Phone_number'];
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
                        <p><strong>SSN:</strong> <?php echo $patient_details[0]['SSN']; ?></p>
                        <p><strong>Name:</strong> <?php echo $patient_details[0]['Name']; ?></p>
                        <p><strong>Address:</strong> <?php echo $patient_details[0]['Address']; ?></p>
                        <p><strong>Age:</strong> <?php echo $patient_details[0]['Age']; ?> years</p>
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
                                <td><?php echo $patient_details[0]['PhysicianName']; ?></td>
                                <td><?php echo $patient_details[0]['Years_exp']; ?> Years</td>
                                <td><?php echo $patient_details[0]['specialization']; ?></td>
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
                            <?php foreach ($patient_details as $patient): ?>
                                <tr>
                                    <td><?php echo $patient['DrugName']; ?></td>
                                    <td><?php echo $patient['Company_name']; ?></td>
                                    <td><?php echo $patient['date']; ?></td>
                                    <td><?php echo $patient['qty']; ?></td>
                                    <td><?php echo $patient['price'], " $"; ?></td>
                                    <td><?php echo $patient['PharmacyName']; ?></td>
                                    <td><?php echo $patient['PharmacyAddress']; ?></td>
                                    <td><?php echo $patient['PharmacyPhone']; ?></td>
                                    <td><?php echo $patient['CompanyPhone']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php elseif ($user_role == 'doctor'): ?>
                    <h1>Your Details</h1>
                    <div class="card">
                        <p><strong>SSN:</strong> <?php echo $doctor_details[0]['ssn']; ?></p>
                        <p><strong>Name:</strong> <?php echo $doctor_details[0]['doctor_name']; ?></p>
                        <p><strong>Experience:</strong> <?php echo $doctor_details[0]['Years_exp']; ?> years</p>
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
                            <?php foreach ($doctor_details as $patient): ?>
                                <tr>
                                    <td><?php echo $patient['name']; ?></td>
                                    <td><?php echo $patient['address']; ?></td>
                                    <td><?php echo $patient['Age']; ?> years</td>
                                </tr>
                            <?php endforeach; ?>
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
                                <th>Formula</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($doctor_details as $patient): ?>
                                <tr>
                                    <td><?php echo $patient['drug_Trade_name']; ?></td>
                                    <td><?php echo $patient['company_name']; ?></td>
                                    <td><?php echo $patient['date']; ?></td>
                                    <td><?php echo $patient['qty']; ?></td>
                                    <td><?php echo $patient['price'], " $"; ?></td>
                                    <td><?php echo $patient['pharmacy_name']; ?></td>
                                    <td><?php echo $patient['PharmacyAddress']; ?></td>
                                    <td><?php echo $patient['PharmacyPhoneNumber']; ?></td>
                                    <td><?php echo $patient['CompanyPhoneNumber']; ?></td>
                                    <td><?php echo $patient['formula']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php elseif ($user_role == 'company'): ?>
                    <h1>Your Details</h1>
                    <div class="card">
                        <p><strong>Name:</strong> <?php echo $user_name; ?></p>
                        <p><strong>Phone Number:</strong> <?php echo $company_details[0]['company_phone']; ?></p>
                    </div>
                    <h2>Company Details</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Drug Name</th>
                                <th>Date</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Pharmacy name</th>
                                <th>Formula</th>
                                <th>Pharmacy Address</th>
                                <th>Pharmacy Phone</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($company_details as $company): ?>
                                <tr>
                                    <td><?php echo $company['drug_Trade_name']; ?></td>
                                    <td><?php echo $company['date']; ?></td>
                                    <td><?php echo $company['qty']; ?></td>
                                    <td><?php echo $company['price'], "$"; ?></td>
                                    <td><?php echo $company['pharmacy_name']; ?></td>
                                    <td><?php echo $company['formula']; ?></td>
                                    <td><?php echo $company['address']; ?></td>
                                    <td><?php echo $company['pharmacy_phone']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php endif; ?>
            </section>
        </div>
    </main>
</body>
</html>