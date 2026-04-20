<?php
// CSV-native logger — writes to logs/audit.csv
function logAction(string $action, string $target, int $count = 0, $oldData = null, $newData = null): void {
    $logDir = __DIR__ . '/logs';
    if (!is_dir($logDir)) @mkdir($logDir, 0755, true);
    $logFile = $logDir . '/audit.csv';

    $writeHeader = !file_exists($logFile);
    $handle = fopen($logFile, 'a');
    if (!$handle) return;

    if ($writeHeader) {
        fputcsv($handle, ['Timestamp', 'Action', 'File', 'Details']);
    }

    $details = $action . ' on ' . $target;
    if ($count > 0) $details .= " ($count records)";

    fputcsv($handle, [date('Y-m-d H:i:s'), $action, $target, $details]);
    fclose($handle);
}
