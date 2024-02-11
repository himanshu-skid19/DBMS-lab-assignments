<?php
require_once('db_connection.php');

session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $conn->begin_transaction();

    try {
        $rep_name = $_SESSION['name'];
        $company_name = $_POST['company_name'];
        $company_phone = $_POST['company_phone'];

        $stmt = $conn->prepare("INSERT INTO pharmaceutical_company (name, Phone_number) VALUES (?, ?)");
        $stmt->bind_param("ss", $company_name, $company_phone);
        $stmt->execute();
        $conn->commit();
        $stmt->close();
        $conn->close();
        header('Location: login.html');
        echo "Company Rep registered successfully";

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
    <title>Company Representative Registration Page</title>
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
                    <input type="text" id="company_name" name="company_name" placeholder="Name of the Company" aria-label="company_name" required>
                    <input type="text" id="company_phone" name="company_phone" placeholder="Phone number" aria-label="company_phone" required>
                    <button type="submit">Register</button>
                </form>

            </section>
        </div>
    </main>

</body>
</html>
