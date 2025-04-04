<?php
//We will start the session to be able to store user data if they register properly.
session_start();

//Including the file that contains the database connection.
require_once 'database_connection.php';

//check that all required Post variables are set before processing.
if (!isset($_POST['Fullname'], $_POST['Email'], $_POST['Password'], $_POST['Confirm_Password'])) {
    echo "Enter all Required Details";
    exit;
}

// Get's inputs
$name = trim($_POST['Fullname']);
$email = trim($_POST['Email']);
$password = $_POST['Password'];
$confirm_password = $_POST['Confirm_Password'];


//Ensure both passwords match
if($password !== $confirm_password) {
    echo "Passwords do not match.";
    exit;
}

//Password security measure. Hash the password using php's built in function.
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

//insert the new registered doctor into patients table
$stmt = $db->prepare("Insert into doctors (name, email, password)  values(?, ?, ?)");

if(!$stmt){
echo "Database error". $db->error;
exit;
}

// binding parameters to the statment.
$stmt->bind_param("sss", $name, $email, $hashed_password);

//if registration is successful
if($stmt->execute()){
    $_SESSION['identity'] = 'doctor';
    $_SESSION['name'] = $name;
    $_SESSION['new_id'] = $db->insert_id;  //new patient id assigned by database

    echo "Welcome, Dr " . htmlspecialchars($name). "!";

} else{
    echo "Error: Registration unsuccessful.";
}

$stmt->close();


?>