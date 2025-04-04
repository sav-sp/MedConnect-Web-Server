<?php
//We will start the session to be able to store user data if they register properly.
session_start();

//Including the file that contains the database connection.
require_once 'database_connection.php';

//check that all required feilds ehich are email and password are entered.
if (!isset($_POST['Email']) || !isset($_POST['Password'])) {
    echo "Enter both Email and password";
    exit;
}

// Get's inputs
$email = trim($_POST['Email']);
$password = $_POST['Password'];

//using doctor's email to identify them.
$stmt = $db->prepare("Select doctor_id, name, password From doctors where email = ?");
if(!$stmt){
    echo "Error in database" , $db->error;
    exit;

}

$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();

//To check if an account with that email exists.
if ($stmt->num_rows === 1) {
    $stmt->bind_result($doctor_id, $name, $hashed_password);
    $stmt->fetch();

// Verify the supplied password against the hashed one.
if (password_verify($password, $hashed_password)) {
    // Login successful: set session variables.
    $_SESSION['identity'] = 'doctor';
    $_SESSION['name'] = $name;
    $_SESSION['new_id'] = $doctor_id;
    
// Display welcome message and then redirect using JavaScript to doctor dashboard.
    echo "Login successful. Welcome, Doctor  " . htmlspecialchars($name) . "! You will be redirected shortly.";
    echo "<script>
            setTimeout(function(){
              window.location.href = 'dashboard-doctor.html';
            }, 3000); 
          </script>";
} else {
    // if password is incorrect.
    echo "Incorrect password. Please try again.";
}
} else {
// No account found with that email.
echo "No account found with that email address.";
}


$stmt->close();




?>