<?php
// Shared Header Component
$active_link = isset($active_page) ? $active_page : '';
?>
<header>
    <h1>AnganiData</h1>
    <nav>
        <a href="index.php" class="<?= $active_link === 'home' ? 'active' : '' ?>">Home</a>
        <a href="viewer.php" class="<?= $active_link === 'directory' ? 'active' : '' ?>">Directory</a>
        <a href="tracking.php" class="<?= $active_link === 'tracking' ? 'active' : '' ?>">Flight Tracking</a>
        <a href="admin.php" class="<?= $active_link === 'admin' ? 'active' : '' ?>">Administration</a>
    </nav>
</header>
