<?php
session_start();

require_once('db_connection.php');

$user_id = $_SESSION['id'];
$user_role = $_SESSION['role'];
$user_name = $_SESSION['name'];

$patient_details = [];
$doctor_details = [];
$company_details = [];
$pharmacy_details = [];

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


} else if ($user_role == "pharmacy"){
    $sql = $conn->prepare("SELECT * FROM pharmacydetails WHERE name = ?");
    $sql->bind_param("s", $user_name);
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $pharmacy_details[] = $row;
        }

    } else {
    echo "No user found with that username";
    
    }
} else if ($user_role == "admin"){

    # getting from patients
    $sql = $conn->prepare("SELECT * FROM patient");
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $patient_details[] = $row;
        }
    } else {
    echo "No user found with that username";
    
    }

    # getting from doctors
    $sql = $conn->prepare("SELECT * FROM doctor");  
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $doctor_details[] = $row;
        }
    } else {
      echo "No user found with that username";
    
    }

    # getting from company
    $sql = $conn->prepare("SELECT * FROM pharmaceutical_company");
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $company_details[] = $row;
        }
    } else { 
        echo "No user found with that username";
    
    }

    # getting from pharmacy
    $sql = $conn->prepare("SELECT * FROM pharmacy");
    $sql->execute();
    $result = $sql->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $pharmacy_details[] = $row;
        }
    } else {
        echo "No user found with that username";
    
    }

    # getting from sells
    $sql = $conn->prepare("SELECT * FROM sells");
    $sql->execute();
    $result = $sql->get_result();
    $sells_details = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $sells_details[] = $row;
        }
    } else {
        echo "No user found with that username";
    }
    # getting from prescribes
    $sql = $conn->prepare("SELECT * FROM prescribes");
    $sql->execute();
    $result = $sql->get_result();
    $prescribes_details = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $prescribes_details[] = $row;
        }
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

                <?php elseif ($user_role == 'pharmacy'): ?>
                    <h1>Your Details</h1>
                    <div class="card">
                        <p><strong>Name:</strong> <?php echo $user_name; ?></p>
                        <p><strong>Phone Number:</strong> <?php echo $pharmacy_details[0]['Phone_number']; ?></p>
                    </div>
                    <h2>Pharmacy Details</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Drug Name</th>
                                <th>Price</th>
                                <th>Company name</th>
                                <th>Formula</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($pharmacy_details as $pharmacy): ?>
                                <tr>
                                    <td><?php echo $pharmacy['drug_Trade_name']; ?></td>
                                    <td><?php echo $pharmacy['price'], "$"; ?></td>
                                    <td><?php echo $pharmacy['company_name']; ?></td>
                                    <td><?php echo $pharmacy['formula']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php elseif ($user_role == 'admin'): ?>
                    <h1>Admin Dashboard</h1>


                    <h2>Patients Details</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>SSN</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th>Age</th>
                                <th>Primary Physician</th>

                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($patient_details as $patient): ?>
                                <tr>
                                    <td><?php echo $patient['ssn']; ?></td>
                                    <td><?php echo $patient['name']; ?></td>
                                    <td><?php echo $patient['address']; ?></td>
                                    <td><?php echo $patient['Age']; ?> years</td>
                                    <td><?php echo $patient['Pri_physician_ssn']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <h2>Doctors Details</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>SSN</th>
                                <th>Name</th>
                                <th>Experience</th>
                                <th>Specialization</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($doctor_details as $doctor): ?>
                                <tr>
                                    <td><?php echo $doctor['ssn']; ?></td>
                                    <td><?php echo $doctor['doctor_name']; ?></td>
                                    <td><?php echo $doctor['Years_exp']; ?> years</td>
                                    <td><?php echo $doctor['specialization']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <h2>Company Details</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Phone Number</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($company_details as $company): ?>
                                <tr>
                                    <td><?php echo $company['name']; ?></td>
                                    <td><?php echo $company['Phone_number']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <h2>Pharmacy Details</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Address</th>
                                <th>Phone Number</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($pharmacy_details as $pharmacy): ?>
                                <tr>
                                    <td><?php echo $pharmacy['name']; ?></td>
                                    <td><?php echo $pharmacy['address']; ?></td>
                                    <td><?php echo $pharmacy['Phone_number']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <h2>Transactioms</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Drug Name</th>
                                <th>Company Name</th>
                                <th>Pharmacy Name</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($sells_details as $sells): ?>
                                <tr>
                                    <td><?php echo $sells['drug_Trade_name']; ?></td>
                                    <td><?php echo $sells['company_name']; ?></td>
                                    <td><?php echo $sells['pharmacy_name']; ?></td>
                                    <td><?php echo $sells['price'], "$"; ?></td>
    
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <h2>Prescriptions</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Patient SSN</th>
                                <th>Doctor SSN</th>
                                <th>Drug Trade name</th>
                                <th>Company Name</th>
                                <th>Date</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($prescribes_details as $prescribes): ?>
                                <tr>
                                    <td><?php echo $prescribes['patient_ssn']; ?></td>
                                    <td><?php echo $prescribes['doctor_ssn']; ?></td>
                                    <td><?php echo $prescribes['drug_Trade_name']; ?></td>
                                    <td><?php echo $prescribes['company_name']; ?></td>
                                    <td><?php echo $prescribes['date']; ?></td>
                                    <td><?php echo $prescribes['qty']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                <?php endif; ?>
            </section>
        </div>
    </main>
</body>
</html>