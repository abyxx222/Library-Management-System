# SETUP GUIDE - Library Management System

## Installation & Configuration Guide

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Step-by-Step Installation](#step-by-step-installation)
3. [Database Configuration](#database-configuration)
4. [Project Configuration](#project-configuration)
5. [Verification](#verification)
6. [Common Issues & Troubleshooting](#troubleshooting)
7. [Default Login Credentials](#default-login-credentials)

---

## Prerequisites

### System Requirements
- **Operating System:** Windows 7+ / Linux / macOS
- **RAM:** Minimum 2GB
- **Disk Space:** Minimum 500MB
- **Internet:** Required for initial setup

### Required Software
- XAMPP 7.0 or higher
- Git (optional, for cloning from GitHub)
- Web Browser (Chrome, Firefox, Edge, Safari)

---

## Step-by-Step Installation

### Step 1: Download and Install XAMPP

#### For Windows:
1. Visit https://www.apachefriends.org/
2. Download XAMPP for Windows
3. Run the installer (e.g., `xampp-windows-x64-7.4.0-installer.exe`)
4. Choose installation directory (default: `C:\xampp`)
5. Select components: Apache, MySQL, PHP, phpMyAdmin
6. Complete the installation

#### For Linux:
```bash
# Download XAMPP
cd ~/Downloads
wget https://www.apachefriends.org/xampp-files/x.x.x/xampp-linux-x64-x.x.x-installer.run

# Make executable and run
chmod +x xampp-linux-x64-x.x.x-installer.run
sudo ./xampp-linux-x64-x.x.x-installer.run
```

#### For macOS:
1. Download XAMPP for macOS from https://www.apachefriends.org/
2. Open the `.dmg` file
3. Drag XAMPP to Applications folder
4. Run XAMPP Control Panel from Applications

---

### Step 2: Start XAMPP Services

#### Windows:
1. Open XAMPP Control Panel
2. Start **Apache** (click Start button next to Apache)
3. Start **MySQL** (click Start button next to MySQL)
4. Verify both show "Running" status

#### Linux/macOS:
```bash
# Start XAMPP services
sudo /opt/lampp/manager-linux-x64.run

# Or use command line
sudo /opt/lampp/lampp start
```

---

### Step 3: Clone or Download Project

#### Option A: Using Git (Recommended)
```bash
# Navigate to XAMPP htdocs directory
cd C:\xampp\htdocs          # Windows
# or
cd /opt/lampp/htdocs        # Linux
# or
cd /Applications/XAMPP/htdocs # macOS

# Clone the repository
git clone https://github.com/abyxx222/Library-Management-System.git
cd Library-Management-System
```

#### Option B: Manual Download
1. Go to https://github.com/abyxx222/Library-Management-System
2. Click "Code" → "Download ZIP"
3. Extract the ZIP file to XAMPP htdocs directory:
   - Windows: `C:\xampp\htdocs\Library-Management-System`
   - Linux: `/opt/lampp/htdocs/Library-Management-System`
   - macOS: `/Applications/XAMPP/htdocs/Library-Management-System`

---

### Step 4: Create Database

1. Open phpMyAdmin in browser:
   ```
   http://localhost/phpmyadmin
   ```

2. Create new database:
   - Click "New" on the left panel
   - Database name: `library_db`
   - Collation: `utf8mb4_unicode_ci`
   - Click "Create"

3. Import database schema:
   - Select the newly created `library_db` database
   - Click "Import" tab
   - Click "Choose File"
   - Select `DATABASE_SCHEMA.sql` from the project folder
   - Click "Go" to execute

4. Verify tables are created:
   - Expand `library_db` in left panel
   - You should see tables: admin, members, books, issue_return, fines, etc.

---

### Step 5: Configure Database Connection

1. Open the project configuration file:
   ```
   config/db_config.php
   ```

2. Update database credentials (if different from defaults):
   ```php
   <?php
   // Database Configuration
   define('DB_HOST', 'localhost');      // Server hostname
   define('DB_USER', 'root');           // MySQL username
   define('DB_PASS', '');               // MySQL password (empty by default in XAMPP)
   define('DB_NAME', 'library_db');     // Database name
   
   // Connection
   $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
   
   // Check connection
   if ($conn->connect_error) {
       die("Connection failed: " . $conn->connect_error);
   }
   
   $conn->set_charset("utf8mb4");
   ?>
   ```

3. Save the file

---

### Step 6: Verify Installation

1. Open browser and navigate to:
   ```
   http://localhost/Library-Management-System/
   ```

2. You should see the Library Management System home page

3. Try admin login:
   - Username: `admin`
   - Password: `admin123`

---

## Database Configuration

### XAMPP Default Credentials
```
MySQL Host: localhost
MySQL User: root
MySQL Password: (empty)
MySQL Port: 3306
```

### Database Details
```
Database Name: library_db
Charset: utf8mb4
Collation: utf8mb4_unicode_ci
```

### Tables Created
| Table Name | Purpose |
|------------|---------|
| admin | Store admin user credentials |
| members | Store library member information |
| books | Store book inventory |
| issue_return | Track book issue/return transactions |
| fines | Track member fines |
| categories | Book categories |
| book_reservation | Book reservations (optional) |
| activity_log | System activity logging |

### Sample Data Included
- 1 Admin user
- 4 Member users
- 6 Sample books
- 8 Book categories
- Sample transactions and fines

---

## Project Configuration

### Main Configuration File: `config/db_config.php`

Create this file if it doesn't exist:

```php
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

// Session configuration
session_start();

// Define application constants
define('APP_NAME', 'Library Management System');
define('APP_URL', 'http://localhost/Library-Management-System/');
define('APP_VERSION', '1.0');

// Fine calculation (per day in Rs)
define('FINE_PER_DAY', 10);

// Book issue period (in days)
define('ISSUE_PERIOD', 14);
?>
```

---

## Verification

### Checklist to Verify Installation

- [ ] XAMPP is installed and running
- [ ] Apache service is started
- [ ] MySQL service is started
- [ ] Database `library_db` is created
- [ ] All tables are imported successfully
- [ ] `config/db_config.php` is configured correctly
- [ ] Project folder is in `htdocs` directory
- [ ] Can access http://localhost/Library-Management-System/
- [ ] Can login as admin with username: `admin` and password: `admin123`

### Test the System

1. **Admin Access:**
   - Navigate to: http://localhost/Library-Management-System/admin_login.php
   - Login with: admin / admin123
   - View admin dashboard

2. **Member Access:**
   - Navigate to: http://localhost/Library-Management-System/member_login.php
   - Login with: arun@email.com / password123
   - View member dashboard

3. **Database Access:**
   - Navigate to: http://localhost/phpmyadmin
   - Select `library_db`
   - Verify all tables and data

---

## Troubleshooting

### Issue 1: XAMPP Services Not Starting

**Problem:** Apache or MySQL won't start

**Solutions:**
- Check if ports 80 (Apache) or 3306 (MySQL) are already in use
- Run XAMPP Control Panel as Administrator
- Check Windows Firewall settings
- Restart the computer and try again

---

### Issue 2: "Connection refused" Error

**Problem:** Cannot connect to MySQL database

**Solutions:**
```php
// Check database connection in config/db_config.php
// Verify:
$conn = new mysqli('localhost', 'root', '', 'library_db');
if ($conn->connect_error) {
    echo "Error: " . $conn->connect_error;
}
// Make sure MySQL is running
```

---

### Issue 3: "Database not found" Error

**Problem:** Database `library_db` doesn't exist

**Solutions:**
1. Open phpMyAdmin: http://localhost/phpmyadmin
2. Create database `library_db`
3. Import `DATABASE_SCHEMA.sql` file
4. Verify tables are created

---

### Issue 4: "File not found" or 404 Error

**Problem:** Cannot access the application

**Solutions:**
- Ensure project folder is in correct location:
  - Windows: `C:\xampp\htdocs\Library-Management-System`
  - Linux: `/opt/lampp/htdocs/Library-Management-System`
- Check URL: http://localhost/Library-Management-System/
- Verify Apache is running
- Clear browser cache

---

### Issue 5: Login Not Working

**Problem:** Cannot login with provided credentials

**Solutions:**
```sql
-- Reset admin password in phpMyAdmin SQL tab
USE library_db;
UPDATE admin SET password = SHA2('admin123', 256) WHERE username = 'admin';
```

---

### Issue 6: File Upload Errors

**Problem:** Cannot upload files (profile pictures, book covers)

**Solutions:**
1. Create `uploads` folder in project root:
   ```bash
   mkdir uploads
   chmod 777 uploads  # Linux/macOS
   ```

2. Verify folder permissions
3. Check PHP upload settings in `php.ini`

---

### Issue 7: Sessions Not Working

**Problem:** Session variables not persisting

**Solutions:**
1. Ensure session is started in all pages:
   ```php
   <?php
   session_start();
   ```

2. Check PHP session settings in phpMyAdmin
3. Verify browser cookies are enabled

---

## Default Login Credentials

### Admin Access
```
Username: admin
Password: admin123
URL: http://localhost/Library-Management-System/admin_login.php
```

### Member Access (Sample Accounts)
```
Email: arun@email.com
Password: password123

Email: priya@email.com
Password: password123

Email: rajesh@email.com
Password: password123

Email: neha@email.com
Password: password123
```

---

## Changing Default Passwords

### Change Admin Password

1. Login as admin
2. Go to Settings/Profile
3. Click "Change Password"
4. Enter old password
5. Enter new password
6. Confirm new password
7. Click "Update"

### Reset Password via Database

```sql
-- Login to phpMyAdmin
USE library_db;

-- Reset admin password
UPDATE admin SET password = SHA2('newpassword', 256) WHERE username = 'admin';

-- Reset member password
UPDATE members SET password = SHA2('newpassword', 256) WHERE email = 'arun@email.com';
```

---

## Performance Tips

1. **Regular Database Backups:**
   - Use phpMyAdmin to export database regularly
   - Or use command line: `mysqldump -u root -p library_db > backup.sql`

2. **Clear Temporary Files:**
   - Delete old session files
   - Clean up temporary uploads

3. **Optimize Database:**
   - Use indexes (already included in schema)
   - Regular VACUUM operations

4. **Monitor Log Files:**
   - Check Apache error logs
   - Check MySQL error logs

---

## Next Steps

1. ✅ Installation complete
2. 📚 Read the main README.md for project overview
3. 🔐 Change default admin password
4. 👥 Add more members to the system
5. 📖 Add more books to the inventory
6. 🚀 Customize the application as per requirements
7. 📝 Create backup of database before major changes

---

## Additional Resources

- **PHP Documentation:** https://www.php.net/docs.php
- **MySQL Documentation:** https://dev.mysql.com/doc/
- **XAMPP Official Guide:** https://www.apachefriends.org/
- **Bootstrap CSS:** https://getbootstrap.com/
- **JavaScript Guide:** https://developer.mozilla.org/en-US/docs/Web/JavaScript

---

## Support

For issues or questions:
1. Check the Troubleshooting section above
2. Review phpMyAdmin for database issues
3. Check Apache/MySQL error logs
4. Consult the main README.md for project details

---

**Last Updated:** September 15, 2026

**Document Version:** 1.0
