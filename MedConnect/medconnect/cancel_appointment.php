<?php
session_start();

if (!isset($_SESSION['new_id'])) {
    echo "You must be logged in to cancel an appointment.";
    exit;
}

//database connection file
require_once 'database_connection.php';

//make sure appointment id is provided for cancellation
if (!isset($_POST['appointment_id'])) {
    echo "Appointment ID is required to cancel."; // Error message for missing appointment ID
    exit;
}

//gets appointment id from post data
$appointment_id = $_POST['appointment_id'];

//Update appoint status to "cancelled"
$stmt = $db->prepare("UPDATE appointments SET appointment_status = 'cancelled' WHERE appointment_id = ?");
$stmt->bind_param("i", $appointment_id);


if ($stmt->execute()) {
    //message for the successfull cancellation of the appointment
    echo "Appointment successfully cancelled.";
} else {
    // Error message for cancellation issues
    echo "Error cancelling the appointment.";
}
$stmt->close(); 

?>