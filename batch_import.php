<?php
// Batch Import — Paste or upload rows into an existing CSV
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Batch Import</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .import-layout { max-width: 1200px; margin: 0 auto; }

        .step-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 1.5rem;
            animation: fadeIn 0.4s ease-out;
        }
        .step-card h3 {
            margin: 0 0 0.25rem 0;
            font-size: 1.1rem;
            display: flex; align-items: center; gap: 0.5rem;
        }
        .step-card .subtitle {
            font-size: 0.82rem; color: var(--text-muted); margin-bottom: 1.25rem;
        }
        .step-number {
            display: inline-flex; align-items: center; justify-content: center;
            width: 28px; height: 28px; border-radius: 50%;
            background: var(--primary-color); color: #fff;
            font-size: 0.8rem; font-weight: 700; flex-shrink: 0;
        }

        .field-group { margin-bottom: 1rem; }
        .field-group label {
            display: block; font-size: 0.78rem; text-transform: uppercase;
            letter-spacing: 0.06em; color: var(--text-muted);
            margin-bottom: 0.35rem; font-weight: 600;
        }
        .field-group select {
            width: 100%; padding: 0.65rem 0.85rem;
            background: rgba(255,255,255,0.05); border: 1px solid var(--border-color);
            border-radius: 0.5rem; color: var(--text-color); font-size: 0.88rem;
        }
        .field-group select:focus { outline: none; border-color: var(--primary-color); }

        .paste-area {
            width: 100%; min-height: 200px; padding: 1rem;
            background: rgba(15,23,42,0.8); border: 1px solid var(--border-color);
            border-radius: 0.75rem; color: var(--text-color);
            font-family: 'SF Mono', 'Fira Code', monospace; font-size: 0.82rem;
            resize: vertical; line-height: 1.6;
        }
        .paste-area:focus { outline: none; border-color: var(--primary-color); }
        .paste-area::placeholder { color: rgba(148,163,184,0.5); }

        .delimiter-row {
            display: flex; gap: 0.75rem; align-items: center;
            margin-bottom: 1rem; flex-wrap: wrap;
        }
        .delimiter-option {
            display: flex; align-items: center; gap: 0.3rem;
            padding: 0.4rem 0.8rem; border-radius: 0.4rem;
            background: rgba(255,255,255,0.05); border: 1px solid var(--border-color);
            cursor: pointer; font-size: 0.82rem; transition: all 0.15s;
        }
        .delimiter-option:hover { border-color: rgba(99,102,241,0.4); }
        .delimiter-option.active { border-color: var(--primary-color); background: rgba(99,102,241,0.1); color: #a5b4fc; }
        .delimiter-option input { display: none; }

        /* Preview table */
        .preview-wrap {
            background: rgba(30,41,59,0.5); border: 1px solid var(--border-color);
            border-radius: 0.75rem; overflow: hidden; margin-top: 1rem;
        }
        .preview-table {
            width: 100%; border-collapse: collapse; font-size: 0.82rem;
        }
        .preview-table th {
            background: rgba(15,23,42,0.9); padding: 0.55rem 0.75rem;
            text-align: left; font-size: 0.7rem; text-transform: uppercase;
            letter-spacing: 0.06em; color: #a5b4fc;
            border-bottom: 2px solid var(--border-color);
        }
        .preview-table td {
            padding: 0.45rem 0.75rem;
            border-bottom: 1px solid rgba(255,255,255,0.04);
            max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
        }
        .preview-table tr:hover td { background: rgba(99,102,241,0.04); }

        .preview-stats {
            display: flex; gap: 1.5rem; padding: 0.75rem 1rem;
            background: rgba(15,23,42,0.5); border-top: 1px solid var(--border-color);
            font-size: 0.78rem; color: var(--text-muted);
        }

        .action-btn {
            display: inline-flex; align-items: center; gap: 0.4rem;
            padding: 0.6rem 1.2rem; border-radius: 0.5rem;
            font-size: 0.85rem; font-weight: 600; border: none;
            cursor: pointer; transition: all 0.2s;
        }
        .action-btn.primary { background: var(--primary-color); color: #fff; }
        .action-btn.primary:hover { background: var(--primary-hover); }
        .action-btn.success { background: var(--success-color); color: #fff; }
        .action-btn.success:hover { background: #059669; }
        .action-btn:disabled { opacity: 0.4; cursor: not-allowed; }

        .toast {
            position: fixed; bottom: 2rem; right: 2rem;
            padding: 0.85rem 1.5rem; border-radius: 0.6rem;
            font-size: 0.85rem; font-weight: 600; z-index: 200;
            animation: toastIn 0.3s ease-out, toastOut 0.3s ease-in 2.7s forwards;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        .toast.success { background: #065f46; color: #6ee7b7; border: 1px solid #10b981; }
        .toast.error { background: #7f1d1d; color: #fca5a5; border: 1px solid #ef4444; }
        .toast.info { background: #1e3a5f; color: #93c5fd; border: 1px solid #3b82f6; }
        @keyframes toastIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes toastOut { from { opacity: 1; } to { opacity: 0; } }

        .target-headers {
            display: flex; flex-wrap: wrap; gap: 0.3rem; margin-top: 0.75rem;
        }
        .target-header-tag {
            padding: 0.2rem 0.5rem; border-radius: 0.3rem;
            background: rgba(99,102,241,0.15); color: #a5b4fc;
            font-size: 0.72rem; font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container import-layout" style="max-width: 1200px;">
        <header>
            <?php $active_page = 'batch'; include 'header.php'; ?>
        </header>

        <main>
            <!-- STEP 1: Select Target -->
            <div class="step-card">
                <h3><span class="step-number">1</span> Select Target Dataset</h3>
                <p class="subtitle">Choose the CSV file you want to append rows to.</p>

                <div class="field-group">
                    <label>Target File</label>
                    <select id="target-file" onchange="loadTargetHeaders()">
                        <option value="">Loading files...</option>
                    </select>
                </div>
                <div id="target-info" style="display:none;">
                    <div style="font-size:0.78rem;color:var(--text-muted);margin-top:0.5rem;">Expected Columns:</div>
                    <div class="target-headers" id="target-headers-display"></div>
                </div>
            </div>

            <!-- STEP 2: Paste / Input Data -->
            <div class="step-card">
                <h3><span class="step-number">2</span> Paste Your Data</h3>
                <p class="subtitle">Paste rows from a spreadsheet or text file. Each line becomes a row.</p>

                <div class="delimiter-row">
                    <span style="font-size:0.78rem;color:var(--text-muted);font-weight:600;">Delimiter:</span>
                    <label class="delimiter-option active" id="delim-comma">
                        <input type="radio" name="delimiter" value="," checked onchange="updateDelimiter(',')"> Comma (,)
                    </label>
                    <label class="delimiter-option" id="delim-tab">
                        <input type="radio" name="delimiter" value="tab" onchange="updateDelimiter('\\t')"> Tab
                    </label>
                    <label class="delimiter-option" id="delim-pipe">
                        <input type="radio" name="delimiter" value="|" onchange="updateDelimiter('|')"> Pipe (|)
                    </label>
                    <label class="delimiter-option" id="delim-semi">
                        <input type="radio" name="delimiter" value=";" onchange="updateDelimiter(';')"> Semicolon (;)
                    </label>
                </div>

                <textarea class="paste-area" id="paste-data" placeholder="Paste your data here...&#10;&#10;Example (comma-separated):&#10;KQ-001,12345,Boeing 737,-800,2015-03-12,Kenya Airways,Active&#10;KQ-002,12346,Boeing 787,-8,2018-06-01,Kenya Airways,Active"></textarea>

                <div style="margin-top:1rem;">
                    <button class="action-btn primary" onclick="previewData()">👁️ Preview Import</button>
                </div>
            </div>

            <!-- STEP 3: Preview & Confirm -->
            <div class="step-card" id="preview-section" style="display:none;">
                <h3><span class="step-number">3</span> Preview & Confirm</h3>
                <p class="subtitle">Review the parsed data before importing.</p>

                <div class="preview-wrap">
                    <div style="overflow-x:auto;max-height:400px;overflow-y:auto;">
                        <table class="preview-table" id="preview-table">
                            <thead id="preview-head"></thead>
                            <tbody id="preview-body"></tbody>
                        </table>
                    </div>
                    <div class="preview-stats" id="preview-stats"></div>
                </div>

                <div style="margin-top:1.25rem;display:flex;gap:0.75rem;">
                    <button class="action-btn success" id="btn-import" onclick="executeImport()">✅ Import Rows</button>
                    <button class="action-btn" style="background:rgba(255,255,255,0.05);color:var(--text-color);border:1px solid var(--border-color);" onclick="document.getElementById('preview-section').style.display='none';">Cancel</button>
                </div>
            </div>
        </main>
    </div>

    <script>
    const API = 'api_datasets.php';
    let targetHeaders = [];
    let parsedRows = [];
    let delimiter = ',';

    // ── Init ─────────────────────────────────────────────────────────
    document.addEventListener('DOMContentLoaded', loadFileList);

    async function loadFileList() {
        try {
            const res = await fetch(`${API}?action=tree`);
            const tree = await res.json();
            const files = [];
            function walk(items) {
                items.forEach(i => {
                    if (i.type === 'file') files.push(i.path);
                    else if (i.children) walk(i.children);
                });
            }
            walk(tree);
            const html = '<option value="">— Select target CSV —</option>' +
                files.map(f => `<option value="${f}">${f} </option>`).join('');
            document.getElementById('target-file').innerHTML = html;
        } catch(e) { console.error(e); }
    }

    // ── Load Target Headers ──────────────────────────────────────────
    async function loadTargetHeaders() {
        const file = document.getElementById('target-file').value;
        const info = document.getElementById('target-info');
        if (!file) { info.style.display = 'none'; return; }

        try {
            const res = await fetch(`${API}?action=read&file=${encodeURIComponent(file)}&page=1&per_page=1`);
            const data = await res.json();
            if (data.error) { toast(data.error, 'error'); return; }

            targetHeaders = data.headers;
            info.style.display = 'block';
            document.getElementById('target-headers-display').innerHTML =
                targetHeaders.map(h => `<span class="target-header-tag">${escHtml(h)}</span>`).join('');
        } catch(e) { toast('Failed to load headers', 'error'); }
    }

    // ── Delimiter ────────────────────────────────────────────────────
    function updateDelimiter(d) {
        delimiter = d === '\\t' ? '\t' : d;
        document.querySelectorAll('.delimiter-option').forEach(el => el.classList.remove('active'));
        event.target.closest('.delimiter-option').classList.add('active');
    }

    // ── Preview ──────────────────────────────────────────────────────
    function previewData() {
        const file = document.getElementById('target-file').value;
        if (!file) return toast('Select a target file first.', 'error');
        if (targetHeaders.length === 0) return toast('Target file has no headers.', 'error');

        const raw = document.getElementById('paste-data').value.trim();
        if (!raw) return toast('Paste some data first.', 'error');

        // Parse lines
        const lines = raw.split('\n').filter(l => l.trim());
        parsedRows = lines.map(line => {
            // Simple CSV-aware split
            if (delimiter === ',') {
                return parseCSVLine(line);
            }
            return line.split(delimiter).map(c => c.trim());
        });

        // Pad/trim to match headers
        parsedRows = parsedRows.map(row => {
            const padded = [...row];
            while (padded.length < targetHeaders.length) padded.push('');
            return padded.slice(0, targetHeaders.length);
        });

        // Check if first row looks like a header — skip if so
        if (parsedRows.length > 0) {
            const firstRow = parsedRows[0];
            const matchCount = firstRow.filter((c, i) =>
                c.toLowerCase().trim() === targetHeaders[i].toLowerCase().trim()
            ).length;
            if (matchCount >= targetHeaders.length * 0.6) {
                parsedRows.shift(); // Skip header row
            }
        }

        if (parsedRows.length === 0) return toast('No data rows found after parsing.', 'error');

        // Render preview
        const section = document.getElementById('preview-section');
        section.style.display = 'block';

        document.getElementById('preview-head').innerHTML = '<tr>' +
            targetHeaders.map(h => `<th>${escHtml(h)}</th>`).join('') + '</tr>';

        const maxPreview = Math.min(parsedRows.length, 50);
        document.getElementById('preview-body').innerHTML = parsedRows.slice(0, maxPreview).map(row =>
            '<tr>' + row.map(c => `<td>${escHtml(c)}</td>`).join('') + '</tr>'
        ).join('');

        document.getElementById('preview-stats').innerHTML =
            `<span>📊 ${parsedRows.length} rows parsed</span>` +
            `<span>📐 ${targetHeaders.length} columns</span>` +
            (parsedRows.length > maxPreview ? `<span>⚠️ Showing first ${maxPreview} of ${parsedRows.length}</span>` : '');

        section.scrollIntoView({ behavior: 'smooth' });
    }

    // Simple CSV line parser (handles quoted fields)
    function parseCSVLine(line) {
        const result = [];
        let current = '';
        let inQuotes = false;
        for (let i = 0; i < line.length; i++) {
            const ch = line[i];
            if (ch === '"') {
                if (inQuotes && line[i+1] === '"') { current += '"'; i++; }
                else { inQuotes = !inQuotes; }
            } else if (ch === ',' && !inQuotes) {
                result.push(current.trim()); current = '';
            } else {
                current += ch;
            }
        }
        result.push(current.trim());
        return result;
    }

    // ── Execute Import ───────────────────────────────────────────────
    async function executeImport() {
        const file = document.getElementById('target-file').value;
        if (!file || parsedRows.length === 0) return;

        const btn = document.getElementById('btn-import');
        btn.disabled = true;
        btn.textContent = '⏳ Importing...';

        try {
            const res = await fetch(`${API}?action=add`, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({ file, rows: parsedRows })
            });
            const data = await res.json();
            if (data.error) { toast(data.error, 'error'); return; }

            toast(`Successfully imported ${data.added} rows! Total: ${data.total}`, 'success');
            document.getElementById('paste-data').value = '';
            document.getElementById('preview-section').style.display = 'none';
            parsedRows = [];
        } catch(e) {
            toast('Import failed: ' + e.message, 'error');
        } finally {
            btn.disabled = false;
            btn.textContent = '✅ Import Rows';
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────
    function escHtml(s) {
        const d = document.createElement('div'); d.textContent = s || ''; return d.innerHTML;
    }
    function toast(msg, type = 'info') {
        const el = document.createElement('div');
        el.className = 'toast ' + type;
        el.textContent = msg;
        document.body.appendChild(el);
        setTimeout(() => el.remove(), 3200);
    }
    </script>
</body>
</html>
