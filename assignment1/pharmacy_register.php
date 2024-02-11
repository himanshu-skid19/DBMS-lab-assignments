<?php
require_once('db_connection.php');

session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $conn->begin_transaction();

    try {
        $name = $_SESSION['name'];
        $pharmacy_address = $_POST['pharmacy_address'];
        $pharmacy_phone = $_POST['pharamcy_phone'];

        $stmt = $conn->prepare("INSERT INTO pharmacy (name, address, Phone_number) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $name, $pharmacy_address ,$pharmacy_phone);
        $stmt->execute();
        $conn->commit();
        $stmt->close();
        $conn->close();
        header('Location: login.html');
        echo "Pharmacy registered successfully";

    } catch (Exception $e) {
        $conn->rollback();
        echo "Registration failed" . $e->getMessage();
        exit();
    }

}
    
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <title>Pharmacy Registration Page</title>
</head>
<body>
    <nav class="container-fluid">
        <ul>
            <li><strong>Register</strong></li>
        </ul>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#" role="button">About</a></li>
        </ul>
    </nav>
    <main class="container">
        <div class="grid">
            <section>
                <hgroup>
                    <h1>Fill in your Details</h2>
                </hgroup>
                <form action="company_register.php" method="POST">
                    <input type="text" id="pharmacy_address" name="pharamcy_address" placeholder="Address of the Pharmacy" aria-label="pharmacy_address" required>
                    <input type="text" id="pharmacy_phone" name="pharmacy_phone" placeholder="Phone number" aria-label="pharmay_phone" required>
                    <button type="submit">Register</button>
                </form>

            </section>
        </div>
    </main>

</body>
</html>
