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

$name = $_POST['name'];
$idNumber = $_POST['idNumber'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$documentURL = $_POST['documentURL'];  // Assuming the document is stored and you have the URL
$walletAddress = $_POST['walletAddress'];

$sql = "INSERT INTO applicants (name, idNumber, email, phone, documentURL, walletAddress) VALUES ('$name', '$idNumber', '$email', '$phone', '$documentURL', '$walletAddress')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();

?>
