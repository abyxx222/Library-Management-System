<?php
// Common Functions for Library Management System

/**
 * Check if user is logged in
 */
function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

/**
 * Redirect to login if not authenticated
 */
function requireLogin() {
    if (!isLoggedIn()) {
        header("Location: " . APP_URL . "auth/login.php");
        exit();
    }
}

/**
 * Sanitize input
 */
function sanitizeInput($input) {
    global $conn;
    return $conn->real_escape_string(trim($input));
}

/**
 * Calculate fine for overdue books
 */
function calculateFine($dueDate) {
    $today = date('Y-m-d');
    $due = new DateTime($dueDate);
    $current = new DateTime($today);
    
    if ($current > $due) {
        $interval = $current->diff($due);
        $days = $interval->days;
        return $days * FINE_PER_DAY;
    }
    return 0;
}

/**
 * Get member details
 */
function getMemberDetails($memberId) {
    global $conn;
    $query = "SELECT * FROM members WHERE member_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $memberId);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

/**
 * Get book details
 */
function getBookDetails($bookId) {
    global $conn;
    $query = "SELECT * FROM books WHERE book_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $bookId);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

/**
 * Get member issued books
 */
function getMemberIssuedBooks($memberId) {
    global $conn;
    $query = "SELECT ir.*, b.title, b.author, b.isbn FROM issue_return ir 
              JOIN books b ON ir.book_id = b.book_id 
              WHERE ir.member_id = ? AND ir.status = 'Issued'
              ORDER BY ir.due_date ASC";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $memberId);
    $stmt->execute();
    return $stmt->get_result();
}

/**
 * Get member pending fines
 */
function getMemberPendingFines($memberId) {
    global $conn;
    $query = "SELECT * FROM fines WHERE member_id = ? AND payment_status = 'Pending'";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $memberId);
    $stmt->execute();
    return $stmt->get_result();
}

/**
 * Format date
 */
function formatDate($date) {
    return date('d-m-Y', strtotime($date));
}

/**
 * Log activity
 */
function logActivity($admin_id, $action, $entity_type, $entity_id) {
    global $conn;
    $query = "INSERT INTO activity_log (admin_id, action, entity_type, entity_id, timestamp) 
              VALUES (?, ?, ?, ?, NOW())";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("issi", $admin_id, $action, $entity_type, $entity_id);
    $stmt->execute();
}

/**
 * Send email notification (dummy function - implement as needed)
 */
function sendNotification($email, $subject, $message) {
    // Implement email sending functionality
    // mail($email, $subject, $message, "From: noreply@library.com");
    return true;
}
?>