// Form Validation Functions for Library Management System

/**
 * Validate email format
 */
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * Validate phone number
 */
function validatePhone(phone) {
    const phoneRegex = /^[0-9]{10,15}$/;
    return phoneRegex.test(phone);
}

/**
 * Validate ISBN format
 */
function validateISBN(isbn) {
    // Accept both ISBN-10 and ISBN-13
    const isbnRegex = /^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[X0-9]$/i;
    return isbnRegex.test(isbn);
}

/**
 * Validate registration form
 */
function validateRegistration() {
    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const address = document.getElementById('address').value.trim();

    if (name === '') {
        alert('Please enter your name');
        return false;
    }

    if (email === '') {
        alert('Please enter your email');
        return false;
    }

    if (!validateEmail(email)) {
        alert('Please enter a valid email address');
        return false;
    }

    if (phone === '') {
        alert('Please enter your phone number');
        return false;
    }

    if (!validatePhone(phone)) {
        alert('Please enter a valid 10-15 digit phone number');
        return false;
    }

    if (address === '') {
        alert('Please enter your address');
        return false;
    }

    return true;
}

/**
 * Validate login form
 */
function validateLogin() {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();

    if (username === '') {
        alert('Please enter username/email');
        return false;
    }

    if (password === '') {
        alert('Please enter password');
        return false;
    }

    if (password.length < 6) {
        alert('Password must be at least 6 characters');
        return false;
    }

    return true;
}

/**
 * Validate book form
 */
function validateBookForm() {
    const title = document.getElementById('title').value.trim();
    const author = document.getElementById('author').value.trim();
    const isbn = document.getElementById('isbn').value.trim();
    const copies = document.getElementById('total_copies').value;

    if (title === '') {
        alert('Please enter book title');
        return false;
    }

    if (author === '') {
        alert('Please enter author name');
        return false;
    }

    if (isbn === '') {
        alert('Please enter ISBN');
        return false;
    }

    if (copies === '' || copies <= 0) {
        alert('Please enter valid number of copies');
        return false;
    }

    return true;
}

/**
 * Confirm deletion
 */
function confirmDelete(item) {
    return confirm('Are you sure you want to delete this ' + item + '?');
}

/**
 * Show/Hide password
 */
function togglePasswordVisibility(id) {
    const passwordField = document.getElementById(id);
    if (passwordField.type === 'password') {
        passwordField.type = 'text';
    } else {
        passwordField.type = 'password';
    }
}
