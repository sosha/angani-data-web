<?php
define('ANGANI_ADMIN_CONTEXT', true);
session_start();
require __DIR__ . '/../includes/db.php';
require __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/admin_render.php';

try { handle_post_actions(); } catch (Throwable $e) { flash('error', $e->getMessage()); }
if (getv('page') === 'logout') { if(!hash_equals(csrf_token(),getv('csrf'))) { flash('error','Invalid logout link.'); redirect_to('../?page=home'); } logout_user(); redirect_to('../?page=home'); }
if (getv('page') === 'export') { export_module_csv(getv('module')); }
if (getv('page') === 'export_all') { export_database_zip(); }

$user = current_user();
$dbError = null;
try { $stats = get_stats(); } catch (Throwable $e) { $dbError = $e->getMessage(); }
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Angani Data Admin Console</title>
    <link rel="icon" href="../assets/favicon.png" type="image/png">
    <link rel="stylesheet" href="../css/styles.css">
    <script src="https://kit.fontawesome.com/c0adf715c1.js" crossorigin="anonymous"></script>
</head>
<body class="admin-shell-page">
<div class="flight-grid" aria-hidden="true"></div>
<header class="site-header admin-entry-header">
    <a class="brand-lockup" href="./"><img src="../assets/angani-logo-white.png" alt="Angani" class="brand-logo"><span><strong>Angani Data</strong><small>Admin Console</small></span></a>
    <nav class="main-nav">
        <a href="../?page=home">Public site</a>
        <?php if ($user): ?><a href="?page=logout&amp;csrf=<?=e(csrf_token())?>">Logout</a><?php endif; ?>
    </nav>
</header>
<main id="app"><?=flash_html()?>
<?php if ($dbError): ?>
<section class="view"><div class="empty-state"><h2>Database connection required</h2><p><?=e($dbError)?></p><p>Import <code>database/00_create_database.sql</code>, then <code>database/01_schema.sql</code>, then run <code>php database/import_all_seeds.php</code>.</p></div></section>
<?php elseif (!$user): ?>
<section class="auth-shell"><div class="panel auth-card"><div class="eyebrow">Admin access</div><h1>Log in</h1><p class="muted">Use an administrator account to continue.</p><form method="post" class="stack-form"><?=csrf_field()?><input type="hidden" name="action" value="login"><label>Email<input name="email" type="email" required></label><label>Password<input name="password" type="password" required></label><button class="btn ink" type="submit">Log in to Admin</button></form><p><a class="linkish" href="../?page=home">Back to public site</a></p></div></section>
<?php elseif (!is_admin()): ?>
<section class="view"><?=access_gate('Admin access required','Your account is signed in, but it does not have administrator privileges.','Back to public site')?></section>
<?php else: ?>
<?php render_admin_page(); ?>
<?php endif; ?>
</main>
<script src="../js/app.js"></script>
</body>
</html>
