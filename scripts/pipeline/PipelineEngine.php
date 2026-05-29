<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/functions.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/Validator.php';
require_once __DIR__ . '/DiffEngine.php';
require_once __DIR__ . '/Publisher.php';

class PipelineEngine {
    private int $adminUserId;

    public function __construct(int $adminUserId) {
        $this->adminUserId = $adminUserId;
    }

    public function run(int $sourceId): array {
        $source = row('SELECT * FROM pipeline_sources WHERE id=? AND is_active=1', [$sourceId]);
        if (!$source) throw new RuntimeException("Pipeline source #$sourceId not found or inactive.");

        $runId = $this->createRun($sourceId, $source['module_key']);
        $rawContent = '';

        try {
            $this->updateRunStatus($runId, 'running');

            $records = Fetcher::fetch($sourceId, $source, $rawContent);
            $this->updateRunCounts($runId, ['records_fetched' => count($records)]);

            if ($rawContent !== '') {
                exec_sql('UPDATE pipeline_runs SET raw_content=? WHERE id=?', [$rawContent, $runId]);
            }

            [$valid, $errors] = Validator::validate($source['module_key'], $records);
            $this->updateRunCounts($runId, ['records_valid' => count($valid)]);

            $staged = DiffEngine::diff($source['module_key'], $valid);
            $this->stageRecords($runId, $source['module_key'], $staged);

            $insertCount = count(array_filter($staged, fn($r) => $r['action'] === 'insert'));
            $updateCount = count(array_filter($staged, fn($r) => $r['action'] === 'update'));

            $this->updateRunCounts($runId, [
                'records_insert' => $insertCount,
                'records_update' => $updateCount,
            ]);

            $this->updateRunStatus($runId, 'pending_review');

            return [
                'run_id' => $runId,
                'fetched' => count($records),
                'valid' => count($valid),
                'errors' => count($errors),
                'inserts' => $insertCount,
                'updates' => $updateCount,
                'total_staged' => count($staged),
            ];
        } catch (Throwable $e) {
            $this->updateRunStatus($runId, 'failed', $e->getMessage());
            throw $e;
        }
    }

    public function approveRun(int $runId): array {
        $records = rows(
            'SELECT id FROM staging_records WHERE pipeline_run_id=? AND status="pending"',
            [$runId]
        );
        if (!empty($records)) {
            $ids = array_column($records, 'id');
            $this->approveStagingRecords($ids);
        }
        return Publisher::publish($runId, $this->adminUserId);
    }

    public function rejectRun(int $runId): void {
        exec_sql('UPDATE pipeline_runs SET status="rejected" WHERE id=?', [$runId]);
    }

    public function approveStagingRecords(array $recordIds): void {
        if (empty($recordIds)) return;
        $placeholders = implode(',', array_fill(0, count($recordIds), '?'));
        exec_sql(
            "UPDATE staging_records SET status='approved', reviewed_by=?, reviewed_at=NOW() WHERE id IN ($placeholders)",
            array_merge([$this->adminUserId], $recordIds)
        );
    }

    public function rejectStagingRecords(array $recordIds): void {
        if (empty($recordIds)) return;
        $placeholders = implode(',', array_fill(0, count($recordIds), '?'));
        exec_sql(
            "UPDATE staging_records SET status='rejected', reviewed_by=?, reviewed_at=NOW() WHERE id IN ($placeholders)",
            array_merge([$this->adminUserId], $recordIds)
        );
    }

    private function createRun(int $sourceId, string $moduleKey): int {
        exec_sql(
            'INSERT INTO pipeline_runs (pipeline_source_id, module_key, status, run_type, started_at) VALUES (?,?,"running","manual",NOW())',
            [$sourceId, $moduleKey]
        );
        return (int)db()->lastInsertId();
    }

    private function updateRunStatus(int $runId, string $status, ?string $error = null): void {
        $sql = 'UPDATE pipeline_runs SET status=?, finished_at=' . ($status === 'running' ? 'NULL' : 'NOW()');
        $params = [$status];
        if ($error !== null) {
            $sql .= ', error_message=?';
            $params[] = $error;
        }
        $sql .= ' WHERE id=?';
        $params[] = $runId;
        exec_sql($sql, $params);

        if (in_array($status, ['completed', 'failed', 'pending_review'])) {
            $sourceId = (int)scalar('SELECT pipeline_source_id FROM pipeline_runs WHERE id=?', [$runId]);
            if ($sourceId) {
                exec_sql(
                    'UPDATE pipeline_sources SET last_run_at=NOW(), last_run_status=? WHERE id=?',
                    [$status, $sourceId]
                );
            }
        }
    }

    private function updateRunCounts(int $runId, array $counts): void {
        $sets = [];
        $params = [];
        foreach ($counts as $col => $val) {
            $sets[] = "$col=?";
            $params[] = (int)$val;
        }
        $params[] = $runId;
        exec_sql(
            'UPDATE pipeline_runs SET ' . implode(',', $sets) . ' WHERE id=?',
            $params
        );
    }

    private function stageRecords(int $runId, string $moduleKey, array $staged): void {
        foreach ($staged as $rec) {
            $rowHash = $rec['row_hash'] ?? hash('sha256', json_encode($rec['row_data']));
            exec_sql(
                'INSERT INTO staging_records (pipeline_run_id, module_key, action, row_hash, row_data, diff_json, status) VALUES (?,?,?,?,?,?,"pending")',
                [$runId, $moduleKey, $rec['action'], $rowHash, json_encode($rec['row_data']), $rec['diff_json'] ? json_encode($rec['diff_json']) : null]
            );
        }
    }
}
