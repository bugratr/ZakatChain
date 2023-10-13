<?php

$serverName = "your_server_name";
$username = "your_username";
$password = "your_password";
$dbName = "your_dbname";

// Create connection
$conn = new mysqli($serverName, $username, $password, $dbName);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, name, idNumber, email, phone, documentURL, walletAddress FROM applicants";
$result = $conn->query($sql);

$applicants = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        array_push($applicants, $row);
    }
} 

echo json_encode($applicants);

$conn->close();

?>
