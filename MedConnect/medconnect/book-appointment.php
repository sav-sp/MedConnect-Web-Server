<?php
session_start();
require_once 'database_connection.php';
ini_set('display_errors', 1);
error_reporting(E_ALL);

if (!isset($_SESSION['new_id'])) {
  echo "You must log in first to book an appointment.";
  exit;
}




// Query to fetch all doctors
$result = $db->query("SELECT doctor_id, name FROM doctors");

?>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Book Appointment - medconnect</title>
  <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>

  <div class="dashboard-container">
    <h2>Book Appointment</h2>

    <form class="dashboard-buttons" action="schedule_appointment.php" method="post">
      <!-- Select doctor -->
      <label for="doctor">Select Doctor:</label>
      <select name="doctor_id" id="doctor" required>
        <option value="">Select Doctor</option>
        
        <?php
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                echo '<option value="' . $row['doctor_id'] . '">Dr. ' . htmlspecialchars($row['name']) . '</option>';
            }
        } else {
            echo '<option value="">No doctors available</option>';
        }
      ?>


      </select>

      <!-- Input for appointment date -->
      <label for="appointment_date">Select Date:</label>
      <input type="date" name="appointment_date" id="appointment_date" required>
      
      <!-- Input for appointment time -->
      <label for="appointment_time">Select Time:</label>
      <input type="time" name="appointment_time" id="appointment_time" required>
      
      <!-- Submit button -->
      <button type="submit" class="btn">Book Appointment</button>


    </form>
  </div>

</body>
</html>
