<?php
function db(): mysqli {
    static $mysqli = null;
    if ($mysqli instanceof mysqli) return $mysqli;
    $c = require __DIR__ . '/config.php';
    $mysqli = mysqli_connect(
        $c['host'] ?? '127.0.0.1',
        $c['username'] ?? 'root',
        $c['password'] ?? '',
        $c['database'] ?? 'angani_data',
        $c['port'] ?? '3306'
    );
    if (!$mysqli) {
        throw new Exception("Connection failed: " . mysqli_connect_error());
    }
    mysqli_set_charset($mysqli, $c['charset'] ?? 'utf8mb4');
    return $mysqli;
}
function rows(string $sql, array $params = []): array {
    $mysqli = db();
    $types = str_repeat('s', count($params));
    $stmt = mysqli_prepare($mysqli, $sql);
    if ($params) {
        mysqli_stmt_bind_param($stmt, $types, ...$params);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
    } else {
        $result = mysqli_query($mysqli, $sql);
    }
    return $result ? mysqli_fetch_all($result, MYSQLI_ASSOC) : [];
}
function row(string $sql, array $params = []): ?array {
    $rows = rows($sql, $params);
    return $rows[0] ?? null;
}
function scalar(string $sql, array $params = []): mixed {
    $mysqli = db();
    if ($params) {
        $types = str_repeat('s', count($params));
        $stmt = mysqli_prepare($mysqli, $sql);
        mysqli_stmt_bind_param($stmt, $types, ...$params);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
    } else {
        $result = mysqli_query($mysqli, $sql);
    }
    if ($result) {
        $row = mysqli_fetch_row($result);
        mysqli_free_result($result);
        return $row[0] ?? null;
    }
    return null;
}
function exec_sql(string $sql, array $params = []): bool {
    $mysqli = db();
    if ($params) {
        $types = str_repeat('s', count($params));
        $stmt = mysqli_prepare($mysqli, $sql);
        mysqli_stmt_bind_param($stmt, $types, ...$params);
        return mysqli_stmt_execute($stmt);
    }
    return mysqli_query($mysqli, $sql);
}
function table_exists(string $table): bool {
    try { return (bool) scalar("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = ?", [$table]); }
    catch (Throwable $e) { return false; }
}
