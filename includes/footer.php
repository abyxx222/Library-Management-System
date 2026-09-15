<?php
if (isset($_SESSION['user_id'])) {
?>
<footer class="footer">
    <div class="container">
        <p>&copy; <?php echo date('Y'); ?> <?php echo APP_NAME; ?>. All rights reserved.</p>
        <p>Version <?php echo APP_VERSION; ?></p>
    </div>
</footer>
</body>
</html>
<?php
}
?>