#!/usr/bin/env php
<?php
/**
 * Backwards-compatible entry point.
 *
 * Phase 4 moved source imports into scripts/importers/phase4_import.php.
 * This helper now forwards to the new importer and imports all configured groups.
 */
$script = __DIR__ . '/importers/phase4_import.php';
$args = array_slice($_SERVER['argv'], 1);
if (!array_filter($args, fn($a) => str_starts_with((string)$a, '--group='))) {
    array_unshift($args, '--group=all');
}
$cmd = escapeshellarg(PHP_BINARY) . ' ' . escapeshellarg($script);
foreach ($args as $arg) $cmd .= ' ' . escapeshellarg($arg);
passthru($cmd, $code);
exit($code);
