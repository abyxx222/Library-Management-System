-- Library Management System Database Schema
-- MySQL Database Setup Script
-- Last Updated: September 15, 2026

-- Create Database
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- =====================================================
-- 1. ADMIN TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('Active', 'Inactive') DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 2. MEMBERS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(10),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    membership_status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active',
    expiry_date DATE,
    membership_type ENUM('Student', 'Faculty', 'Staff', 'Regular') DEFAULT 'Regular',
    password VARCHAR(255),
    profile_picture VARCHAR(255),
    total_fines DECIMAL(10, 2) DEFAULT 0.00,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 3. BOOKS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL,
    subcategory VARCHAR(50),
    publisher VARCHAR(100),
    publication_year INT,
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    language VARCHAR(50) DEFAULT 'English',
    pages INT,
    price DECIMAL(10, 2),
    book_condition ENUM('Good', 'Fair', 'Poor') DEFAULT 'Good',
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    description TEXT,
    book_image VARCHAR(255),
    INDEX idx_title (title),
    INDEX idx_author (author),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 4. ISSUE_RETURN TABLE (Transactions)
-- =====================================================
CREATE TABLE IF NOT EXISTS issue_return (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    actual_return_date DATETIME NULL,
    status ENUM('Issued', 'Returned', 'Overdue', 'Lost') DEFAULT 'Issued',
    issued_by INT,
    returned_by INT,
    remarks TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (issued_by) REFERENCES admin(admin_id),
    FOREIGN KEY (returned_by) REFERENCES admin(admin_id),
    INDEX idx_member_id (member_id),
    INDEX idx_book_id (book_id),
    INDEX idx_status (status),
    INDEX idx_issue_date (issue_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 5. FINES TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    issue_id INT NOT NULL,
    fine_amount DECIMAL(10, 2) NOT NULL,
    fine_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason ENUM('Overdue', 'Damage', 'Lost Book', 'Other') DEFAULT 'Overdue',
    payment_status ENUM('Pending', 'Paid', 'Partial', 'Waived') DEFAULT 'Pending',
    payment_date DATETIME NULL,
    payment_method VARCHAR(50),
    transaction_id VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (issue_id) REFERENCES issue_return(issue_id) ON DELETE CASCADE,
    INDEX idx_member_id (member_id),
    INDEX idx_payment_status (payment_status),
    INDEX idx_fine_date (fine_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 6. CATEGORIES TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 7. BOOK_RESERVATION TABLE (Optional)
-- =====================================================
CREATE TABLE IF NOT EXISTS book_reservation (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expected_availability_date DATE,
    status ENUM('Pending', 'Notified', 'Cancelled', 'Fulfilled') DEFAULT 'Pending',
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    INDEX idx_member_id (member_id),
    INDEX idx_book_id (book_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 8. ACTIVITY_LOG TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS activity_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT,
    member_id INT,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id INT,
    old_value TEXT,
    new_value TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    FOREIGN KEY (admin_id) REFERENCES admin(admin_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    INDEX idx_timestamp (timestamp),
    INDEX idx_action (action)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 9. INSERT SAMPLE DATA
-- =====================================================

-- Insert Sample Admin
INSERT INTO admin (username, password, email, full_name, phone, status) VALUES
('admin', SHA2('admin123', 256), 'admin@library.com', 'Library Admin', '9876543210', 'Active');

-- Insert Sample Categories
INSERT INTO categories (category_name, description) VALUES
('Fiction', 'Novels and fictional stories'),
('Non-Fiction', 'Educational and factual books'),
('Science', 'Science and technology books'),
('History', 'Historical books and references'),
('Biography', 'Biographical works'),
('Children', 'Books for children'),
('Reference', 'Reference materials and dictionaries'),
('Technology', 'IT and Computer Science books');

-- Insert Sample Books
INSERT INTO books (title, author, isbn, category, publisher, publication_year, total_copies, available_copies, pages, price, description) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '978-0743273565', 'Fiction', 'Penguin Books', 1925, 5, 3, 180, 250.00, 'A classic American novel about the Jazz Age'),
('To Kill a Mockingbird', 'Harper Lee', '978-0061120084', 'Fiction', 'J.B. Lippincott', 1960, 4, 2, 281, 300.00, 'A gripping tale of racial injustice'),
('Sapiens', 'Yuval Noah Harari', '978-0062316097', 'Non-Fiction', 'Penguin Random House', 2014, 6, 4, 443, 450.00, 'A brief history of humankind'),
('Atomic Habits', 'James Clear', '978-0735211292', 'Non-Fiction', 'Penguin Random House', 2018, 7, 5, 320, 400.00, 'Tiny habits, remarkable results'),
('Python Programming', 'Mark Lutz', '978-1449355739', 'Technology', 'O''Reilly', 2013, 3, 2, 1500, 800.00, 'Learn Python Programming'),
('A Brief History of Time', 'Stephen Hawking', '978-0553380163', 'Science', 'Bantam', 1988, 4, 3, 198, 350.00, 'The universe explained');

-- Insert Sample Members
INSERT INTO members (name, email, phone, address, city, state, postal_code, date_of_birth, gender, membership_type, password, total_fines, membership_status) VALUES
('Arun Kumar', 'arun@email.com', '9876543210', '123 Main Street', 'Chennai', 'Tamil Nadu', '600001', '2000-01-15', 'Male', 'Student', SHA2('password123', 256), 0.00, 'Active'),
('Priya Singh', 'priya@email.com', '9876543211', '456 Oak Avenue', 'Bangalore', 'Karnataka', '560001', '1999-05-20', 'Female', 'Student', SHA2('password123', 256), 50.00, 'Active'),
('Rajesh Patel', 'rajesh@email.com', '9876543212', '789 Pine Road', 'Mumbai', 'Maharashtra', '400001', '1995-08-10', 'Male', 'Faculty', SHA2('password123', 256), 0.00, 'Active'),
('Neha Gupta', 'neha@email.com', '9876543213', '321 Elm Street', 'Delhi', 'Delhi', '110001', '2001-03-25', 'Female', 'Student', SHA2('password123', 256), 100.00, 'Active');

-- Insert Sample Issue/Return Transactions
INSERT INTO issue_return (member_id, book_id, issue_date, due_date, return_date, status, issued_by) VALUES
(1, 1, '2026-08-01', '2026-08-15', '2026-08-14', 'Returned', 1),
(1, 3, '2026-09-01', '2026-09-15', NULL, 'Issued', 1),
(2, 2, '2026-08-20', '2026-09-03', NULL, 'Overdue', 1),
(3, 5, '2026-09-10', '2026-09-24', NULL, 'Issued', 1),
(4, 4, '2026-08-15', '2026-08-29', '2026-08-28', 'Returned', 1),
(2, 6, '2026-08-25', '2026-09-08', NULL, 'Overdue', 1);

-- Insert Sample Fines
INSERT INTO fines (member_id, issue_id, fine_amount, reason, payment_status, fine_date) VALUES
(2, 3, 50.00, 'Overdue', 'Pending', '2026-09-04'),
(4, 6, 100.00, 'Overdue', 'Pending', '2026-09-09');

-- =====================================================
-- 10. CREATE VIEWS FOR REPORTS
-- =====================================================

-- View for Overdue Books
CREATE OR REPLACE VIEW overdue_books AS
SELECT 
    ir.issue_id,
    m.member_id,
    m.name AS member_name,
    m.email,
    m.phone,
    b.book_id,
    b.title,
    b.author,
    ir.issue_date,
    ir.due_date,
    DATEDIFF(CURDATE(), ir.due_date) AS days_overdue
FROM issue_return ir
JOIN members m ON ir.member_id = m.member_id
JOIN books b ON ir.book_id = b.book_id
WHERE ir.status = 'Issued' AND ir.due_date < CURDATE();

-- View for Most Issued Books
CREATE OR REPLACE VIEW most_issued_books AS
SELECT 
    b.book_id,
    b.title,
    b.author,
    b.isbn,
    COUNT(ir.issue_id) AS total_issues
FROM books b
LEFT JOIN issue_return ir ON b.book_id = ir.book_id
GROUP BY b.book_id
ORDER BY total_issues DESC;

-- View for Member Activity
CREATE OR REPLACE VIEW member_activity AS
SELECT 
    m.member_id,
    m.name,
    m.email,
    COUNT(ir.issue_id) AS total_books_issued,
    SUM(CASE WHEN ir.status = 'Issued' THEN 1 ELSE 0 END) AS currently_issued,
    SUM(CASE WHEN ir.status = 'Overdue' THEN 1 ELSE 0 END) AS overdue_books,
    COALESCE(SUM(f.fine_amount), 0) AS total_fines
FROM members m
LEFT JOIN issue_return ir ON m.member_id = ir.member_id
LEFT JOIN fines f ON m.member_id = f.member_id
GROUP BY m.member_id;

-- View for Pending Fines
CREATE OR REPLACE VIEW pending_fines AS
SELECT 
    f.fine_id,
    m.member_id,
    m.name AS member_name,
    m.email,
    b.title AS book_title,
    f.fine_amount,
    f.reason,
    f.fine_date
FROM fines f
JOIN members m ON f.member_id = m.member_id
JOIN issue_return ir ON f.issue_id = ir.issue_id
JOIN books b ON ir.book_id = b.book_id
WHERE f.payment_status = 'Pending';

-- =====================================================
-- 11. CREATE INDEXES FOR PERFORMANCE
-- =====================================================

CREATE INDEX idx_issue_return_member ON issue_return(member_id);
CREATE INDEX idx_issue_return_book ON issue_return(book_id);
CREATE INDEX idx_issue_return_due_date ON issue_return(due_date);
CREATE INDEX idx_fines_member ON fines(member_id);
CREATE INDEX idx_fines_payment_status ON fines(payment_status);
CREATE INDEX idx_members_email ON members(email);
CREATE INDEX idx_members_phone ON members(phone);
CREATE INDEX idx_books_isbn ON books(isbn);

-- =====================================================
-- Database Setup Complete
-- =====================================================
-- Default Admin Credentials:
-- Username: admin
-- Password: admin123
--
-- Sample Member Credentials:
-- Email: arun@email.com, Password: password123
-- Email: priya@email.com, Password: password123
-- =====================================================
