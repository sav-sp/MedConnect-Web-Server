<?php
session_start();
require_once 'database_connection.php';

//doctor has to be logged in to be able to view their history
if (!isset($_SESSION['new_id'])) {
    echo "Please log in to view your appointment history."; // Error message for unauthenticated access
    exit;
}

//gets logged in doctor's id from the session
$doctor_id = $_SESSION['new_id'];

// Prepare the SQL query to fetch appointment history using a join
$stmt = $db->prepare("SELECT a.appointment_id, a.appointment_date AS date, a.appointment_time AS time, a.appointment_status AS status, 
                             p.name AS patient_name, p.email AS patient_email
                      FROM appointments a
                      JOIN patients p ON a.patient_id = p.patient_id
                      WHERE a.doctor_id = ?");
$stmt->bind_param("i", $doctor_id); // Bind doctor ID to the query
$stmt->execute();
$stmt->bind_result($appointment_id, $appointment_date, $appointment_time, $appointment_status, $name, $email);

// Store appointment details in an array
$appointments = [];
while ($stmt->fetch()) {
    $appointments[] = [
        'appointment_id'  => $appointment_id,
        'patient_name' => $name,       // name
        'patient_email' => $email, // email
        'date' => $appointment_date,      // Appointment date
        'time' => $appointment_time,        // Appointment time
        'status' => $appointment_status,     // Appointment status
    ];
}

$stmt->close();

// Set content type to JSON and return the array as a JSON response
header('Content-Type: application/json');
echo json_encode($appointments); // Convert the array to a JSON string

?>