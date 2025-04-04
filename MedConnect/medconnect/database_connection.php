<?php
// connecting php to database

$db = new mysqli('localhost','root','','MedicalAppointmentSystem');

//check for connecetion errors if any is found
if($db->connect_error){

    echo "<p>Error: Could not connect to database. <br/>
            Please try again later. </p>";
            
            exit;
}

?>