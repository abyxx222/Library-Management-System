# Library Management System - Project Structure

## Directory Layout

```
Library-Management-System/
│
├── README.md                      # Main project documentation
├── DOCUMENTATION.md               # Technical documentation
├── SETUP_GUIDE.md                 # Installation guide
├── DATABASE_SCHEMA.sql            # Database creation script
├── PROJECT_STRUCTURE.md           # This file
├── .gitignore                     # Git ignore rules
│
├── config/
│   └── db_config.php              # Database configuration
│
├── admin/
│   ├── dashboard.php              # Admin dashboard
│   ├── logout.php                 # Admin logout
│   │
│   ├── books/
│   │   ├── manage_books.php       # List all books
│   │   ├── add_book.php           # Add new book
│   │   ├── edit_book.php          # Edit book details
│   │   └── delete_book.php        # Delete book
│   │
│   ├── members/
│   │   ├── manage_members.php     # List all members
│   │   ├── register_member.php    # Register new member
│   │   ├── edit_member.php        # Edit member details
│   │   └── deactivate_member.php  # Deactivate member
│   │
│   ├── transactions/
│   │   ├── issue_book.php         # Issue book to member
│   │   ├── return_book.php        # Process book return
│   │   └── transaction_history.php # View all transactions
│   │
│   ├── fines/
│   │   ├── manage_fines.php       # List all fines
│   │   └── record_payment.php     # Record fine payment
│   │
│   └── reports/
│       ├── book_report.php        # Book inventory report
│       ├── member_report.php      # Member activity report
│       └── fine_report.php        # Fine collection report
│
├── member/
│   ├── dashboard.php              # Member dashboard
│   ├── catalog.php                # Browse book catalog
│   ├── my_issues.php              # View issued books
│   ├── my_fines.php               # View pending fines
│   ├── profile.php                # Member profile settings
│   └── logout.php                 # Member logout
│
├── auth/
│   ├── admin_login.php            # Admin login page
│   ├── member_login.php           # Member login page
│   ├── member_register.php        # Member registration
│   └── logout.php                 # Common logout
│
├── includes/
│   ├── header.php                 # Common header
│   ├── footer.php                 # Common footer
│   ├── navbar.php                 # Navigation bar
│   └── functions.php              # Common functions
│
├── css/
│   ├── style.css                  # Main stylesheet
│   ├── admin.css                  # Admin panel styles
│   ├── member.css                 # Member portal styles
│   └── responsive.css             # Mobile responsive styles
│
├── js/
│   ├── script.js                  # Main JavaScript
│   ├── validation.js              # Form validation
│   ├── search.js                  # Search functionality
│   └── chart.js                   # Chart library (optional)
│
├── images/
│   ├── logo.png                   # Site logo
│   ├── icons/                     # Icon files
│   └── placeholders/              # Placeholder images
│
├── uploads/
│   ├── profile_pictures/          # Member profile images
│   ├── book_covers/               # Book cover images
│   └── documents/                 # Document uploads
│
└── assets/
    ├── fonts/                     # Custom fonts
    ├── libraries/                 # Third-party libraries
    └── downloads/                 # Downloadable files
```

## File Descriptions

### Root Level Files

| File | Purpose |
|------|----------|
| README.md | Main project overview and documentation |
| SETUP_GUIDE.md | Step-by-step installation instructions |
| DATABASE_SCHEMA.sql | SQL script to create database and tables |
| .gitignore | Specifies files to ignore in version control |

### config/ Directory

- **db_config.php** - Database connection and configuration

### admin/ Directory

Contains all admin panel functionality:
- Dashboard for system overview
- Book inventory management (CRUD operations)
- Member account management
- Transaction handling (issue/return)
- Fine management
- Report generation

### member/ Directory

Contains all member portal functionality:
- Dashboard with personal information
- Book catalog search and browsing
- View issued books and due dates
- View pending fines and payment history
- Profile settings and password change

### auth/ Directory

Authentication pages:
- Admin login
- Member login and registration
- Common logout functionality

### includes/ Directory

Shared components:
- Header and footer templates
- Navigation bar
- Common utility functions

### css/ Directory

Stylesheets:
- style.css - Main design
- admin.css - Admin panel specific styles
- member.css - Member portal specific styles
- responsive.css - Mobile and tablet responsive design

### js/ Directory

JavaScript files:
- script.js - Main functionality
- validation.js - Form validation functions
- search.js - Search and filter features

### uploads/ Directory

User-generated content:
- Profile pictures for members
- Book cover images
- Document files

---

## Navigation Flow

### Public Access
```
Home → Login → Authentication
```

### Admin Portal
```
Admin Login → Dashboard → 
├── Book Management
├── Member Management
├── Transactions
├── Fines
└── Reports
```

### Member Portal
```
Member Login → Dashboard →
├── Book Catalog
├── My Issues
├── My Fines
└── Profile
```

---

## Database Files

- **DATABASE_SCHEMA.sql** - Complete database schema with:
  - Table definitions
  - Sample data
  - Views for reports
  - Indexes for performance

---

## Configuration Files

- **config/db_config.php** - Database connection details
- **.gitignore** - Files to exclude from version control

---

## Static Assets

- **css/** - All stylesheets for responsive design
- **js/** - Client-side functionality
- **images/** - Logo, icons, and graphics
- **uploads/** - User uploaded content

---

## Development Workflow

1. **Setup Phase**: Run `DATABASE_SCHEMA.sql`
2. **Configure**: Update `config/db_config.php`
3. **Develop**: Create features in respective directories
4. **Test**: Use provided test cases
5. **Deploy**: Follow SETUP_GUIDE.md

---

## Adding New Features

### To add a new admin feature:
1. Create file in `admin/` directory
2. Include `includes/functions.php`
3. Add link to navigation in `admin/` layout
4. Follow coding standards from DOCUMENTATION.md

### To add a new member feature:
1. Create file in `member/` directory
2. Add authentication check
3. Include stylesheet in `css/member.css`
4. Update member dashboard navigation

---

## Maintenance

### Regular Tasks
- Clean up `uploads/` directory
- Archive old transaction logs
- Update database backups
- Review and optimize queries

### Security Updates
- Keep database credentials secure
- Update password hashing if needed
- Review access control logs

---

**Last Updated:** September 15, 2026

**Document Version:** 1.0
