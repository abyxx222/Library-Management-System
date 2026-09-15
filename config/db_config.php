<?php
// Database Configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'library_db');

// Create connection
$conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Set charset
$conn->set_charset("utf8mb4");

// Application Configuration
define('APP_NAME', 'Library Management System');
define('APP_URL', 'http://localhost/Library-Management-System/');
define('APP_VERSION', '1.0');

// Fine calculation (per day in currency units)
define('FINE_PER_DAY', 10);

// Book issue period (in days)
define('ISSUE_PERIOD', 14);

// Session configuration
session_start();
?>