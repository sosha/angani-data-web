<?php
require_once __DIR__ . '/DatasetMap.php';

final class AnganiImportEngine
{
    private PDO $pdo;
    private string $root;
    private array $options;
    private array $tableColumns = [];
    private array $truncated = [];
    private int $batchId = 0;
    private array $summary = [
        'files_seen' => 0,
        'files_imported' => 0,
        'files_skipped' => 0,
        'rows_seen' => 0,
        'rows_inserted' => 0,
        'rows_staged' => 0,
        'rows_raw_logged' => 0,
        'warnings' => [],
    ];

    public function __construct(PDO $pdo, string $root, array $options = [])
    {
        $this->pdo = $pdo;
        $this->root = rtrim($root, '/');
        $this->options = array_merge([
            'mode' => 'append',
            'dry_run' => false,
            'limit' => 0,
            'country' => null,
            'store_raw' => false,
            'fallback_raw' => true,
            'verbose' => true,
            'batch_name' => 'Phase 4 import',
        ], $options);
        $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    public function run(string $group, ?string $path = null): array
    {
        $this->ensureImportTablesExist();
        $this->startBatch($group, $path);
        try {
            if ($group === 'all') {
                foreach (['global','country'] as $g) {
                    $this->runGroup($g, null);
                }
            } else {
                $this->runGroup($group, $path);
            }
            $this->finishBatch('completed');
        } catch (Throwable $e) {
            $this->summary['warnings'][] = $e->getMessage();
            $this->finishBatch('failed', $e->getMessage());
            throw $e;
        }
        return $this->summary;
    }

    private function runGroup(string $group, ?string $path = null): void
    {
        switch ($group) {
            case 'global':
                $this->importGlobalDirectory($path ?: $this->root . '/data/global', null);
                break;
            case 'aircraft':
            case 'reference':
            case 'commercial':
            case 'iata-iosa':
            case 'gds':
                $this->importGlobalDirectory($path ?: $this->root . '/data/global', $group);
                break;
            case 'infrastructure':
                $this->importGlobalDirectory($this->root . '/data/global', 'infrastructure');
                $this->importCountryZip($path ?: $this->root . '/data/countries/countries.zip', 'infrastructure');
                break;
            case 'country':
                $this->importCountryZip($path ?: $this->root . '/data/countries/countries.zip', null);
                break;
            default:
                throw new InvalidArgumentException("Unknown import group: {$group}");
        }
    }

    private function importGlobalDirectory(string $dir, ?string $onlyGroup): void
    {
        if (!is_dir($dir)) {
            throw new RuntimeException("Global import path is not a directory: {$dir}");
        }
        $map = phase4_global_map();
        $files = glob(rtrim($dir, '/') . '/*.csv') ?: [];
        sort($files);
        foreach ($files as $file) {
            $basename = basename($file);
            $cfg = $map[$basename] ?? null;
            if (!$cfg) {
                $this->summary['files_skipped']++;
                if ($this->options['fallback_raw']) {
                    $this->importCsvFile($file, $basename, 'global', null, null, 'global/unmapped');
                }
                continue;
            }
            if ($onlyGroup && ($cfg['group'] ?? '') !== $onlyGroup) {
                continue;
            }
            $this->importCsvFile($file, $basename, 'global', null, $cfg, 'global/' . ($cfg['group'] ?? 'general'));
        }
    }

    private function importCountryZip(string $zipPath, ?string $onlyGroup): void
    {
        if (!is_file($zipPath)) {
            throw new RuntimeException("Country ZIP not found: {$zipPath}");
        }
        if (class_exists('ZipArchive')) {
            $this->importCountryZipWithExtension($zipPath, $onlyGroup);
            return;
        }
        if ($this->commandExists('unzip')) {
            $this->summary['warnings'][] = 'PHP ZipArchive extension is not available; using system unzip fallback.';
            $this->importCountryZipWithSystemUnzip($zipPath, $onlyGroup);
            return;
        }
        throw new RuntimeException('Country ZIP imports require either the PHP ZipArchive extension or the system unzip command.');
    }

    private function importCountryZipWithExtension(string $zipPath, ?string $onlyGroup): void
    {
        $zip = new ZipArchive();
        if ($zip->open($zipPath) !== true) {
            throw new RuntimeException("Could not open country ZIP: {$zipPath}");
        }
        $map = phase4_country_map();
        for ($i=0; $i < $zip->numFiles; $i++) {
            $name = $zip->getNameIndex($i);
            if (!$this->countryZipEntryShouldImport($name, $onlyGroup, $map, $country, $relative, $cfg)) continue;
            $stream = $zip->getStream($name);
            if (!$stream) {
                $this->summary['warnings'][] = "Could not read {$name} from ZIP";
                continue;
            }
            $contents = stream_get_contents($stream);
            fclose($stream);
            $this->importCsvString((string)$contents, $name, 'country_zip', $country, $cfg, $relative);
        }
        $zip->close();
    }

    private function importCountryZipWithSystemUnzip(string $zipPath, ?string $onlyGroup): void
    {
        $map = phase4_country_map();
        $listing = shell_exec('unzip -Z1 ' . escapeshellarg($zipPath));
        if ($listing === null || trim($listing) === '') {
            throw new RuntimeException("Could not list country ZIP using system unzip: {$zipPath}");
        }
        foreach (preg_split('/?
/', trim($listing)) as $name) {
            if (!$this->countryZipEntryShouldImport($name, $onlyGroup, $map, $country, $relative, $cfg)) continue;
            $contents = shell_exec('unzip -p ' . escapeshellarg($zipPath) . ' ' . escapeshellarg($name));
            if ($contents === null) {
                $this->summary['warnings'][] = "Could not read {$name} from ZIP using system unzip";
                continue;
            }
            $this->importCsvString($contents, $name, 'country_zip', $country, $cfg, $relative);
        }
    }

    private function countryZipEntryShouldImport(string $name, ?string $onlyGroup, array $map, ?string &$country, ?string &$relative, ?array &$cfg): bool
    {
        $country = null;
        $relative = null;
        $cfg = null;
        if (!str_ends_with(strtolower($name), '.csv')) return false;
        $parts = explode('/', $name);
        if (count($parts) < 3) return false;
        $country = strtoupper($parts[0]);
        if ($this->options['country'] && strtoupper((string)$this->options['country']) !== $country) return false;
        $relative = implode('/', array_slice($parts, 1));
        $cfg = $map[$relative] ?? null;
        if ($cfg && $onlyGroup && ($cfg['group'] ?? '') !== $onlyGroup) return false;
        if (!$cfg && $onlyGroup) return false;
        return true;
    }

    private function commandExists(string $command): bool
    {
        $result = shell_exec('command -v ' . escapeshellarg($command) . ' 2>/dev/null');
        return is_string($result) && trim($result) !== '';
    }

    private function importCsvFile(string $file, string $displayPath, string $scope, ?string $country, ?array $cfg, string $category): void
    {
        $contents = file_get_contents($file);
        if ($contents === false) {
            $this->summary['warnings'][] = "Could not read {$file}";
            return;
        }
        $this->importCsvString($contents, $displayPath, $scope, $country, $cfg, $category);
    }

    private function importCsvString(string $contents, string $displayPath, string $scope, ?string $country, ?array $cfg, string $category): void
    {
        $this->summary['files_seen']++;
        $csv = $this->parseCsv($contents);
        if (!$csv['headers']) {
            $this->summary['files_skipped']++;
            return;
        }
        $rows = $csv['rows'];
        $datasetFileId = $this->recordDatasetFile($displayPath, $scope, $category, basename($displayPath), $country, count($rows), $csv['headers']);

        if (!$cfg) {
            $this->summary['files_skipped']++;
            if ($this->options['fallback_raw']) {
                foreach ($rows as $rowIndex => $row) {
                    $this->summary['rows_seen']++;
                    if ($this->shouldStop()) break;
                    if (!$this->options['dry_run']) {
                        $this->insertDatasetRecord($datasetFileId, $country, $category, basename($displayPath), $row);
                    }
                    $this->summary['rows_raw_logged']++;
                }
            }
            return;
        }

        $table = $cfg['table'];
        if (!$this->tableExists($table)) {
            foreach ($rows as $rowIndex => $row) {
                $this->stage($cfg, $row, $rowIndex + 2, $country, "Configured table {$table} does not exist", $displayPath);
            }
            $this->summary['warnings'][] = "Missing table {$table} for {$displayPath}";
            $this->summary['files_skipped']++;
            return;
        }

        if ($this->options['mode'] === 'replace') {
            $this->truncateOnce($table);
        }

        $this->summary['files_imported']++;
        $order = 0;
        foreach ($rows as $rowIndex => $row) {
            $order++;
            $this->summary['rows_seen']++;
            if ($this->shouldStop()) break;
            if ($this->isEmptyRow($row)) continue;
            if (!$this->options['dry_run'] && $this->options['store_raw']) {
                $this->insertDatasetRecord($datasetFileId, $country, $category, basename($displayPath), $row);
                $this->summary['rows_raw_logged']++;
            }
            $payload = $this->buildPayload($cfg, $row, $country, $order);
            if (!$payload) continue;
            try {
                if (!$this->options['dry_run']) {
                    $this->insertPayload($table, $payload, $cfg);
                }
                $this->summary['rows_inserted']++;
            } catch (Throwable $e) {
                $this->stage($cfg, $row, $rowIndex + 2, $country, $e->getMessage(), $displayPath);
            }
        }
    }

    private function parseCsv(string $contents): array
    {
        $contents = preg_replace('/^\xEF\xBB\xBF/', '', $contents);
        $fh = fopen('php://temp', 'r+');
        fwrite($fh, $contents);
        rewind($fh);
        $headers = fgetcsv($fh);
        if (!$headers) return ['headers'=>[], 'rows'=>[]];
        $headers = array_map(fn($h) => trim((string)$h), $headers);
        $rows = [];
        while (($data = fgetcsv($fh)) !== false) {
            $row = [];
            foreach ($headers as $i => $header) {
                $row[$header] = isset($data[$i]) ? trim((string)$data[$i]) : null;
            }
            $rows[] = $row;
        }
        fclose($fh);
        return ['headers'=>$headers, 'rows'=>$rows];
    }

    private function buildPayload(array $cfg, array $row, ?string $country, int $order): array
    {
        $table = $cfg['table'];
        $columns = $this->columns($table);
        $payload = [];
        $normalizedRow = [];
        foreach ($row as $k => $v) {
            $normalizedRow[$this->norm($k)] = $v;
        }

        foreach (($cfg['map'] ?? []) as $dbColumn => $sourceHeader) {
            if (!in_array($dbColumn, $columns, true)) continue;
            $key = $this->norm($sourceHeader);
            $payload[$dbColumn] = $this->cleanValue($normalizedRow[$key] ?? null, $dbColumn);
        }
        foreach ($columns as $column) {
            if (isset($payload[$column]) || $this->isSystemColumn($column)) continue;
            $key = $this->norm($column);
            if (array_key_exists($key, $normalizedRow)) {
                $payload[$column] = $this->cleanValue($normalizedRow[$key], $column);
            }
        }
        if ($country) {
            if (in_array('country_code', $columns, true) && empty($payload['country_code'])) $payload['country_code'] = $country;
            if (in_array('iso_country', $columns, true) && empty($payload['iso_country'])) $payload['iso_country'] = $country;
        }
        if (!empty($cfg['auto_order']) && in_array('sort_order', $columns, true) && empty($payload['sort_order'])) {
            $payload['sort_order'] = $order;
        }
        return array_filter($payload, fn($v) => $v !== null && $v !== '', ARRAY_FILTER_USE_BOTH);
    }

    private function insertPayload(string $table, array $payload, array $cfg): void
    {
        if (!$payload) return;
        $columns = array_keys($payload);
        $quoted = array_map(fn($c) => '`' . str_replace('`','``',$c) . '`', $columns);
        $placeholders = array_map(fn($c) => ':' . $c, $columns);
        $sql = 'INSERT INTO `' . str_replace('`','``',$table) . '` (' . implode(',', $quoted) . ') VALUES (' . implode(',', $placeholders) . ')';
        $updates = [];
        foreach ($columns as $c) {
            if (in_array($c, ['id','created_at'], true)) continue;
            $updates[] = '`' . str_replace('`','``',$c) . '` = VALUES(`' . str_replace('`','``',$c) . '`)';
        }
        if (!empty($cfg['unique'])) {
            // Generic fallback upsert. Without a unique database key this behaves as insert-only.
            $sql .= ' ON DUPLICATE KEY UPDATE ' . implode(',', $updates ?: ['id=id']);
        }
        $stmt = $this->pdo->prepare($sql);
        foreach ($payload as $c => $v) {
            $stmt->bindValue(':' . $c, $v);
        }
        $stmt->execute();
    }

    private function recordDatasetFile(string $path, string $scope, string $category, string $filename, ?string $country, int $rowCount, array $headers): int
    {
        if ($this->options['dry_run']) return 0;
        if (!$this->tableExists('dataset_files')) return 0;
        $sql = 'INSERT INTO dataset_files (path, scope, category, filename, country_code, row_count, is_populated, headers_json)
                VALUES (?,?,?,?,?,?,?,?)
                ON DUPLICATE KEY UPDATE row_count=VALUES(row_count), is_populated=VALUES(is_populated), headers_json=VALUES(headers_json), scope=VALUES(scope), category=VALUES(category), country_code=VALUES(country_code)';
        $this->pdo->prepare($sql)->execute([$path,$scope,$category,$filename,$country,$rowCount,$rowCount>0?1:0,json_encode($headers, JSON_UNESCAPED_UNICODE)]);
        $id = (int)$this->pdo->lastInsertId();
        if ($id > 0) return $id;
        $stmt = $this->pdo->prepare('SELECT id FROM dataset_files WHERE path=?');
        $stmt->execute([$path]);
        return (int)$stmt->fetchColumn();
    }

    private function insertDatasetRecord(int $datasetFileId, ?string $country, string $category, string $filename, array $row): void
    {
        if (!$datasetFileId || !$this->tableExists('dataset_records')) return;
        $this->pdo->prepare('INSERT INTO dataset_records (dataset_file_id,country_code,category,filename,row_json) VALUES (?,?,?,?,?)')
            ->execute([$datasetFileId,$country,$category,$filename,json_encode($row, JSON_UNESCAPED_UNICODE)]);
    }

    private function stage(array $cfg, array $row, int $sourceRow, ?string $country, string $issue, string $sourcePath): void
    {
        $this->summary['rows_staged']++;
        if ($this->options['dry_run'] || !$this->tableExists('staging_import_records')) return;
        $this->pdo->prepare('INSERT INTO staging_import_records (import_batch_id,module_key,source_row_number,row_json,status,issue_summary,created_at) VALUES (?,?,?,?,?,?,NOW())')
            ->execute([$this->batchId, $cfg['table'] ?? 'unmapped', $sourceRow, json_encode(['country'=>$country,'source'=>$sourcePath,'row'=>$row], JSON_UNESCAPED_UNICODE), 'needs_review', mb_substr($issue,0,1000)]);
    }

    private function startBatch(string $group, ?string $path): void
    {
        if ($this->options['dry_run'] || !$this->tableExists('import_batches')) return;
        $this->pdo->prepare("INSERT INTO import_batches (batch_name,source_file,module_key,status,started_at,notes) VALUES (?,?,?,'running',NOW(),?)")
            ->execute([$this->options['batch_name'], $path ?: '', $group, 'Mode: ' . $this->options['mode']]);
        $this->batchId = (int)$this->pdo->lastInsertId();
    }

    private function finishBatch(string $status, ?string $notes = null): void
    {
        if ($this->options['dry_run'] || !$this->batchId || !$this->tableExists('import_batches')) return;
        $this->pdo->prepare('UPDATE import_batches SET status=?, finished_at=NOW(), rows_total=?, rows_imported=?, rows_failed=?, notes=CONCAT(COALESCE(notes,""), ?) WHERE id=?')
            ->execute([$status, $this->summary['rows_seen'], $this->summary['rows_inserted'], $this->summary['rows_staged'], $notes ? "\n".$notes : '', $this->batchId]);
    }

    private function truncateOnce(string $table): void
    {
        if (isset($this->truncated[$table])) return;
        if (!$this->options['dry_run']) {
            $this->pdo->exec('SET FOREIGN_KEY_CHECKS=0');
            $this->pdo->exec('TRUNCATE TABLE `' . str_replace('`','``',$table) . '`');
            $this->pdo->exec('SET FOREIGN_KEY_CHECKS=1');
        }
        $this->truncated[$table] = true;
    }

    private function ensureImportTablesExist(): void
    {
        // The main schema creates these. This is just a safety net for older installs.
        $this->pdo->exec("CREATE TABLE IF NOT EXISTS import_batches (
            id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
            batch_name VARCHAR(190) NOT NULL,
            source_file VARCHAR(512) DEFAULT NULL,
            module_key VARCHAR(120) DEFAULT NULL,
            status VARCHAR(40) DEFAULT NULL,
            rows_total INT NOT NULL DEFAULT 0,
            rows_imported INT NOT NULL DEFAULT 0,
            rows_failed INT NOT NULL DEFAULT 0,
            started_at DATETIME DEFAULT NULL,
            finished_at DATETIME DEFAULT NULL,
            notes TEXT DEFAULT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        $this->pdo->exec("CREATE TABLE IF NOT EXISTS staging_import_records (
            id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
            import_batch_id BIGINT UNSIGNED DEFAULT NULL,
            module_key VARCHAR(120) DEFAULT NULL,
            source_row_number INT DEFAULT NULL,
            row_json LONGTEXT DEFAULT NULL,
            status VARCHAR(40) DEFAULT 'pending',
            issue_summary TEXT DEFAULT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
    }

    private function tableExists(string $table): bool
    {
        $stmt = $this->pdo->prepare('SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=?');
        $stmt->execute([$table]);
        return (int)$stmt->fetchColumn() > 0;
    }

    private function columns(string $table): array
    {
        if (isset($this->tableColumns[$table])) return $this->tableColumns[$table];
        $stmt = $this->pdo->prepare('SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=? ORDER BY ORDINAL_POSITION');
        $stmt->execute([$table]);
        return $this->tableColumns[$table] = $stmt->fetchAll(PDO::FETCH_COLUMN) ?: [];
    }

    private function isSystemColumn(string $column): bool
    {
        return in_array($column, ['id','uuid','created_at','updated_at','last_modified','deleted_at'], true);
    }

    private function norm(string $value): string
    {
        $value = strtolower(trim($value));
        $value = str_replace(['/', '-', '(', ')', '.', '#', '&'], ' ', $value);
        $value = preg_replace('/[^a-z0-9]+/', '_', $value);
        return trim($value, '_');
    }

    private function cleanValue($value, string $column)
    {
        if ($value === null) return null;
        $value = trim((string)$value);
        if ($value === '') return null;
        if (preg_match('/(_count|count|_ft|_kg|_seats|gates_count|engine_count|total_built|rank_order|sort_order)$/', $column)) {
            $n = preg_replace('/[^0-9\.-]/', '', $value);
            return $n === '' || $n === '-' ? null : (int)round((float)$n);
        }
        if (preg_match('/(price|cost|rate|yield|tax|fare|revenue|ebit|profit|value|range|latitude|longitude|volume|tonnes|mhz|kn|m3|mach|weight|length|width|height|wingspan|payload|ceiling|age)$/', $column)) {
            $n = preg_replace('/[^0-9\.-]/', '', $value);
            return $n === '' || $n === '-' ? null : (float)$n;
        }
        if (in_array($column, ['is_primary'], true)) {
            return in_array(strtolower($value), ['1','yes','true','y','primary'], true) ? 1 : 0;
        }
        if (in_array($column, ['iata_code','icao_code','country_code','iso_country','alpha_2','alpha_3','gds_code'], true)) {
            return strtoupper($value);
        }
        return $value;
    }

    private function isEmptyRow(array $row): bool
    {
        foreach ($row as $v) {
            if (trim((string)$v) !== '') return false;
        }
        return true;
    }

    private function shouldStop(): bool
    {
        $limit = (int)$this->options['limit'];
        return $limit > 0 && $this->summary['rows_seen'] > $limit;
    }
}

function phase4_db_from_config(string $root): PDO
{
    $configFile = $root . '/includes/config.php';
    if (!is_file($configFile)) $configFile = $root . '/includes/config.example.php';
    $cfg = require $configFile;
    $charset = $cfg['charset'] ?? 'utf8mb4';
    $dsn = sprintf('mysql:host=%s;port=%s;dbname=%s;charset=%s', $cfg['host'] ?? '127.0.0.1', $cfg['port'] ?? '3306', $cfg['database'] ?? 'angani_data', $charset);
    return new PDO($dsn, $cfg['username'] ?? 'root', $cfg['password'] ?? '', [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
}
