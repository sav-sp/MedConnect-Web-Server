<?php
session_start();
require_once 'database_connection.php';

//patient has to be logged in to be able to view their history
if (!isset($_SESSION['new_id'])) {
    echo "Please log in to view your appointment history."; // Error message for unauthenticated access
    exit;
}

//gets logged in patient's id from the session
$patient_id = $_SESSION['new_id'];

// Prepare the SQL query to fetch appointment history using a join
$stmt = $db->prepare("SELECT a.appointment_id, a.appointment_date, a.appointment_time, a.appointment_status, 
                             d.name AS doctor_name, d.specialization
                      FROM appointments a
                      JOIN doctors d ON a.doctor_id = d.doctor_id
                      WHERE a.patient_id = ?");
$stmt->bind_param("i", $patient_id); // Bind patient ID to the query
$stmt->execute();
$stmt->bind_result($appointment_id, $appointment_date, $appointment_time, $appointment_status, $name, $specialization);

// Store appointment details in an array
$appointments = [];
while ($stmt->fetch()) {
    $appointments[] = [
        'appointment_id'  => $appointment_id, // Appointment ID
        'doctor_name' => $name,       // Doctor's name
        'specialization' => $specialization, // Doctor's specialization
        'date' => $appointment_date,                     // Appointment date
        'time' => $appointment_time,                     // Appointment time
        'status' => $appointment_status,                 // Appointment status
    ];
}

$stmt->close();

// Set content type to JSON and return the array as a JSON response
header('Content-Type: application/json');
echo json_encode($appointments); // Convert the array to a JSON string

?>