<?php
function db(): PDO {
    static $pdo = null;
    if ($pdo instanceof PDO) return $pdo;
    $configPath = __DIR__ . '/config.php';
    if (!file_exists($configPath)) {
        $configPath = __DIR__ . '/config.example.php';
    }
    $c = require $configPath;
    $dsn = sprintf(
        'mysql:host=%s;port=%s;dbname=%s;charset=%s',
        $c['host'] ?? '127.0.0.1',
        $c['port'] ?? '3306',
        $c['database'] ?? 'angani_data',
        $c['charset'] ?? 'utf8mb4'
    );
    $pdo = new PDO($dsn, $c['username'] ?? 'root', $c['password'] ?? '', [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
    return $pdo;
}
function rows(string $sql, array $params = []): array { $s = db()->prepare($sql); $s->execute($params); return $s->fetchAll(); }
function row(string $sql, array $params = []): ?array { $s = db()->prepare($sql); $s->execute($params); $r = $s->fetch(); return $r === false ? null : $r; }
function scalar(string $sql, array $params = []) { $s = db()->prepare($sql); $s->execute($params); return $s->fetchColumn(); }
function exec_sql(string $sql, array $params = []): bool { $s = db()->prepare($sql); return $s->execute($params); }
function table_exists(string $table): bool {
    try { return (bool) scalar('SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = ?', [$table]); }
    catch (Throwable $e) { return false; }
}
