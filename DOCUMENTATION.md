# Library Management System - Technical Documentation

## Overview

This document provides detailed technical information about the Library Management System project implementation, including architecture, database design, API endpoints, and development guidelines.

---

## Table of Contents

1. [System Architecture](#system-architecture)
2. [Database Design](#database-design)
3. [Module Structure](#module-structure)
4. [API Endpoints](#api-endpoints)
5. [Security Implementation](#security-implementation)
6. [Coding Standards](#coding-standards)
7. [Testing Guidelines](#testing-guidelines)

---

## System Architecture

### Three-Tier Architecture

```
PRESENTATION LAYER (HTML, CSS, JavaScript)
         ↓
BUSINESS LOGIC LAYER (PHP)
         ↓
DATA ACCESS LAYER (MySQL)
```

### Component Interaction

1. **Frontend**: HTML forms and JavaScript for user interaction
2. **Backend**: PHP scripts process requests and business logic
3. **Database**: MySQL stores persistent data

---

## Database Design

### Entity Relationship Diagram

**Key Relationships:**
- 1 Admin manages many Operations
- 1 Member can Issue many Books
- 1 Book can be Issued to many Members
- 1 Issue generates many Fines

### Normalization

Database is normalized to 3NF (Third Normal Form):
- Eliminates data redundancy
- Ensures data integrity
- Improves query performance

---

## Module Structure

### Admin Module

**Functionality:**
- Dashboard with key metrics
- Book inventory management
- Member account management
- Issue/return transaction tracking
- Fine management
- Report generation

**Key Files:**
- `admin/dashboard.php` - Admin dashboard
- `admin/books/` - Book management
- `admin/members/` - Member management

### Member Module

**Functionality:**
- Member registration and authentication
- Book catalog search
- View issued books
- Track fines
- Profile management

**Key Files:**
- `member/dashboard.php` - Member dashboard
- `member/catalog.php` - Book search
- `member/my_issues.php` - Issued books

---

## API Endpoints

### Authentication

```
POST /auth/login.php
- Parameters: username, password
- Response: Session created or error

GET /auth/logout.php
- Response: Session destroyed
```

### Books

```
GET /api/books/search.php?q=query
- Return: Search results

GET /api/books/details.php?id=book_id
- Return: Book details

POST /api/books/add.php
- Parameters: Book details
- Return: Success/error
```

### Members

```
GET /api/members/profile.php?id=member_id
- Return: Member profile

POST /api/members/update.php
- Parameters: Updated member data
- Return: Success/error
```

### Transactions

```
POST /api/transactions/issue.php
- Parameters: member_id, book_id
- Return: Transaction record

POST /api/transactions/return.php
- Parameters: issue_id
- Return: Updated transaction
```

---

## Security Implementation

### Authentication

- User credentials stored with SHA-256 hashing
- Session-based authentication
- Auto-logout on inactivity

### Authorization

- Role-based access control (Admin/Member)
- Permission checks on sensitive operations

### Data Protection

- SQL Injection prevention using prepared statements
- Input validation and sanitization
- CSRF token implementation

### Password Policy

- Minimum 6 characters
- SHA-256 hashing algorithm
- Password change required on first login (optional)

---

## Coding Standards

### PHP Guidelines

```php
// Use meaningful variable names
$memberName = "John Doe";

// Use prepared statements
$stmt = $conn->prepare("SELECT * FROM books WHERE title = ?");
$stmt->bind_param("s", $title);
$stmt->execute();

// Error handling
try {
    // Code here
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
```

### HTML/CSS Guidelines

- Use semantic HTML5 elements
- Follow CSS naming conventions
- Implement responsive design
- Ensure accessibility standards

### JavaScript Guidelines

- Use ES6 syntax
- Implement proper error handling
- Validate input before submission
- Use meaningful function names

---

## Testing Guidelines

### Unit Testing

- Test individual functions
- Test database operations
- Test input validation

### Integration Testing

- Test module interactions
- Test complete workflows
- Test database transactions

### System Testing

- End-to-end testing
- Performance testing
- Security testing

### Test Cases Example

```
Test Case: Member Registration
1. Enter valid data
2. Click Register
3. Verify member account created
4. Check database entry

Test Case: Issue Book
1. Login as admin
2. Search member
3. Select book
4. Click Issue
5. Verify transaction recorded
```

---

## Performance Optimization

### Database

- Use indexes on frequently searched columns
- Implement query caching
- Regular database maintenance

### Server

- Enable output compression
- Implement page caching
- Optimize image sizes

### Client

- Minify CSS and JavaScript
- Lazy loading for images
- Reduce HTTP requests

---

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check database credentials
   - Verify MySQL is running
   - Check database name

2. **Session Not Working**
   - Ensure session_start() is called
   - Check browser cookie settings
   - Verify session directory permissions

3. **File Upload Errors**
   - Check upload directory permissions
   - Verify file size limits
   - Check PHP upload settings

---

**Last Updated:** September 15, 2026

**Document Version:** 1.0
