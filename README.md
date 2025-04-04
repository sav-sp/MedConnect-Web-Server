# MedConnect-Web-Server

📌 Overview

MedConnect is a web-based medical appointment system that allows patients to book appointments, doctors to manage schedules, and admins to oversee the system. Built using PHP, MySQL, HTML, and CSS. it ensures a secure and efficient medical booking experience.

🚀 Features

✅ User Roles & Authentication: Patients and doctors can securely log in.
✅ Appointment Booking: Patients can schedule, reschedule, and cancel appointments.
✅ Doctor Management: Doctors can view and manage their schedules.

👏🏽 Installation

How to Run the MedConnect Application Locally (Using XAMPP)
Step 1: Start XAMPP Services
• Open XAMPP Control Panel
• Click Start for: Apache & MySQL
 
Step 2: Open MedConnect Project Folder
• Go to: Hard Drive, Applications, XAMPP, xamppfiles, htdocs, medconnect.
 
Step 3: Import the Database
1. Open your browser and visit:
• http://localhost/phpmyadmin
•  Click Import
•  Choose the medconnect.sql file
•  Click Go to import it into MySQL
 
Step 4: Confirm Database Connection in Your Code
Check your PHP database config file (db.php) and make sure it matches:
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'medconnect'; // should match the name in phpMyAdmin
$conn = mysqli_connect($host, $user, $password, $database);
 
Step 5: Run the Application in Browser
Open your browser and go to: http://localhost/MedConnect
