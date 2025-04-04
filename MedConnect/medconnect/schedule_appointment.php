<?php
session_start();
require_once 'database_connection.php';

//make sure all required details are provided
if(!isset($_SESSION['new_id'], $_POST['doctor_id'], $_POST['appointment_date'], $_POST['appointment_time'])) {
    echo "Enter all required feilds."; 
    exit;
}

//get inputs
$patient_id = $_SESSION['new_id']; 
$doctor_id = $_POST['doctor_id'];  
$appointment_date = $_POST['appointment_date'];
$appointment_time = $_POST['appointment_time']; 

// Check if the selected time slot is already booked for the given doctor
$stmt = $db->prepare("SELECT * FROM appointments WHERE doctor_id = ? AND appointment_date = ? AND appointment_time = ?");
$stmt->bind_param("iss", $doctor_id, $appointment_date, $appointment_time);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    // inform user if time slot is taken
    echo "This time slot is already taken. Please choose another.";
} else {
    // Insert the appointment if time slot is not taken
    $stmt->close();
    $stmt = $db->prepare("INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, appointment_status) 
                          VALUES (?, ?, ?, ?, 'scheduled')");
    $stmt->bind_param("iiss", $patient_id, $doctor_id, $appointment_date, $appointment_time);
    if ($stmt->execute()) {
        // message for successfully scheduling of the appointment
        echo "Appointment successfully scheduled!";
    } else {
        // Error message for with scheduling appointment
        echo "Error scheduling the appointment.";
    }
}
$stmt->close();

?>