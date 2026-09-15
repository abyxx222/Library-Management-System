<?php
if (!isset($_SESSION['user_id'])) {
    // Header for non-logged in users
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo APP_NAME; ?></title>
    <link rel="stylesheet" href="<?php echo APP_URL; ?>css/style.css">
    <link rel="stylesheet" href="<?php echo APP_URL; ?>css/responsive.css">
</head>
<body>
<?php
}
?>