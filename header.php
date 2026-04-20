<?php
// Shared Header Component
$active_link = isset($active_page) ? $active_page : '';
?>
<header>
    <h1>AnganiData</h1>
    <nav>
        <a href="index.php" class="<?= $active_link === 'home' ? 'active' : '' ?>">Home</a>
        <a href="datasets.php" class="<?= $active_link === 'datasets' ? 'active' : '' ?>">📂 Datasets</a>
        <a href="batch_import.php" class="<?= $active_link === 'batch' ? 'active' : '' ?>">📥 Batch Import</a>
        <a href="manage.php" class="<?= $active_link === 'manage' ? 'active' : '' ?>">⚙️ Manage</a>
        <a href="routes.php" class="<?= $active_link === 'routes' ? 'active' : '' ?>">✈️ Routes</a>
        <a href="meta_ads.php" class="<?= $active_link === 'meta_ads' ? 'active' : '' ?>">🌐 Digital Properties</a>
        <a href="viewer.php" class="<?= $active_link === 'directory' ? 'active' : '' ?>">Directory</a>
        <a href="tracking.php" class="<?= $active_link === 'tracking' ? 'active' : '' ?>">Flight Tracking</a>
    </nav>
</header>
