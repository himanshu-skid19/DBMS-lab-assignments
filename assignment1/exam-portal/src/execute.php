
<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
include_once 'db.php';

function executeSQL($sql, $types = null, $params = []) {
    // Assume $conn is the active database connection
    global $conn;
    $stmt = $conn->prepare($sql);

    if ($types && $params) {
        $stmt->bind_param($types, ...$params);
    }

    if ($stmt->execute()) {
        if (stripos($sql, 'SELECT') === 0) {
            $result = $stmt->get_result();
            $data = $result->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $data;
        } else {
            $affected_rows = $stmt->affected_rows;
            $stmt->close();
            return $affected_rows;
        }
    } else {
        $error = $stmt->error;
        $stmt->close();
        return ['error' => $error];
    }
}

$action = $_POST['action'] ?? '';

switch ($action) {
    case 'register':
        $name = $_POST['name'] ?? '';
        $email = $_POST['email'] ?? '';
        $password = $_POST['password'] ?? '';
        $role = $_POST['role'] ?? '';

        // Always hash passwords before inserting into the database
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        $sql = "INSERT INTO users (email,  password_hash, name, role) VALUES (?, ?, ?, ?)";
        $result = executeSQL($sql, 'ssss', [$email, $hashed_password, $name, $role]);

        if (!isset($result['error'])) {
            echo "User registered successfully";
        } else {
            echo "Error: " . $result['error'];
        }
        break;

    case 'login':
        $email = $_POST['email'] ?? '';
        $password = $_POST['password'] ?? '';

        $sql = "SELECT * FROM users WHERE email = ?";
        $result = executeSQL($sql, 's', [$email]);

        if (count($result) > 0) {
            $user = $result[0];
            if (password_verify($password, $user['password_hash'])) {
                echo "Login successful";
            } else {
                echo "Invalid email or password";
            }
        } else {
            echo "Invalid email or password";
        }
        break;
}

$conn->close();
?>
