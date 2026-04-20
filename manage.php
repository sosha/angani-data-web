<?php
// File Management Dashboard — Create, Upload, Delete CSV files
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | File Management</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .manage-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem; }
        @media (max-width: 900px) { .manage-grid { grid-template-columns: 1fr; } }

        .manage-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 2rem;
            animation: fadeIn 0.4s ease-out;
        }
        .manage-card h3 {
            margin: 0 0 0.25rem 0;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .manage-card .subtitle {
            font-size: 0.82rem;
            color: var(--text-muted);
            margin-bottom: 1.25rem;
        }

        .field-group { margin-bottom: 1rem; }
        .field-group label {
            display: block;
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--text-muted);
            margin-bottom: 0.35rem;
            font-weight: 600;
        }
        .field-group input, .field-group select {
            width: 100%;
            padding: 0.65rem 0.85rem;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            color: var(--text-color);
            font-size: 0.88rem;
        }
        .field-group input:focus, .field-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            background: rgba(255,255,255,0.08);
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.6rem 1.2rem;
            border-radius: 0.5rem;
            font-size: 0.85rem;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .action-btn.primary { background: var(--primary-color); color: #fff; }
        .action-btn.primary:hover { background: var(--primary-hover); }
        .action-btn.danger { background: rgba(239,68,68,0.15); color: #fca5a5; border: 1px solid rgba(239,68,68,0.3); }
        .action-btn.danger:hover { background: rgba(239,68,68,0.25); }
        .action-btn.success { background: rgba(16,185,129,0.15); color: #6ee7b7; border: 1px solid rgba(16,185,129,0.3); }
        .action-btn.success:hover { background: rgba(16,185,129,0.25); }

        /* Drop zone */
        .drop-zone {
            border: 2px dashed var(--border-color);
            border-radius: 0.75rem;
            padding: 2rem;
            text-align: center;
            color: var(--text-muted);
            cursor: pointer;
            transition: all 0.2s;
            margin-bottom: 1rem;
        }
        .drop-zone:hover, .drop-zone.dragover {
            border-color: var(--primary-color);
            background: rgba(99,102,241,0.05);
            color: var(--text-color);
        }
        .drop-zone .icon { font-size: 2rem; margin-bottom: 0.5rem; }
        .drop-zone input[type="file"] { display: none; }

        /* Audit log */
        .audit-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.82rem;
        }
        .audit-table th {
            text-align: left;
            padding: 0.6rem 0.85rem;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border-color);
            background: rgba(15,23,42,0.5);
        }
        .audit-table td {
            padding: 0.55rem 0.85rem;
            border-bottom: 1px solid rgba(255,255,255,0.04);
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .audit-table tr:hover td { background: rgba(99,102,241,0.04); }

        .action-badge {
            display: inline-block;
            padding: 0.15rem 0.5rem;
            border-radius: 0.3rem;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        .action-badge.create { background: rgba(16,185,129,0.2); color: #6ee7b7; }
        .action-badge.upload { background: rgba(59,130,246,0.2); color: #93c5fd; }
        .action-badge.delete { background: rgba(239,68,68,0.2); color: #fca5a5; }
        .action-badge.update { background: rgba(245,158,11,0.2); color: #fbbf24; }
        .action-badge.add    { background: rgba(139,92,246,0.2); color: #c4b5fd; }

        /* Toast */
        .toast {
            position: fixed; bottom: 2rem; right: 2rem;
            padding: 0.85rem 1.5rem; border-radius: 0.6rem;
            font-size: 0.85rem; font-weight: 600; z-index: 200;
            animation: toastIn 0.3s ease-out, toastOut 0.3s ease-in 2.7s forwards;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        .toast.success { background: #065f46; color: #6ee7b7; border: 1px solid #10b981; }
        .toast.error { background: #7f1d1d; color: #fca5a5; border: 1px solid #ef4444; }
        @keyframes toastIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes toastOut { from { opacity: 1; } to { opacity: 0; transform: translateY(-10px); } }

        /* Header chips */
        .header-chips {
            display: flex; flex-wrap: wrap; gap: 0.35rem;
            margin-top: 0.5rem; min-height: 32px;
            align-items: center;
        }
        .header-chip {
            display: inline-flex; align-items: center; gap: 0.3rem;
            padding: 0.25rem 0.6rem;
            background: rgba(99,102,241,0.15); color: #a5b4fc;
            border-radius: 0.3rem; font-size: 0.78rem; font-weight: 500;
        }
        .header-chip .remove {
            cursor: pointer; opacity: 0.6; font-size: 0.7rem;
            transition: opacity 0.15s;
        }
        .header-chip .remove:hover { opacity: 1; }
    </style>
</head>
<body>
    <div class="container" style="max-width: 1400px;">
        <header>
            <?php $active_page = 'manage'; include 'header.php'; ?>
        </header>

        <main>
            <div class="manage-grid">
                <!-- CREATE NEW CSV -->
                <div class="manage-card">
                    <h3>📝 Create New Dataset</h3>
                    <p class="subtitle">Initialize an empty CSV with custom column headers.</p>

                    <div class="field-group">
                        <label>Target Folder</label>
                        <select id="create-folder"><option value="">Loading folders...</option></select>
                    </div>
                    <div class="field-group">
                        <label>File Name</label>
                        <input type="text" id="create-filename" placeholder="e.g. fleet_list.csv">
                    </div>
                    <div class="field-group">
                        <label>Column Headers</label>
                        <div style="display:flex;gap:0.5rem;">
                            <input type="text" id="create-header-input" placeholder="Type header name, press Enter"
                                   style="flex:1;" onkeydown="if(event.key==='Enter'){event.preventDefault();addHeaderChip();}">
                            <button class="action-btn primary" onclick="addHeaderChip()" style="padding:0.5rem 0.8rem;font-size:0.8rem;">+ Add</button>
                        </div>
                        <div class="header-chips" id="header-chips"></div>
                    </div>
                    <button class="action-btn success" onclick="createCSV()">✨ Create Dataset</button>
                </div>

                <!-- UPLOAD CSV -->
                <div class="manage-card">
                    <h3>📤 Upload CSV File</h3>
                    <p class="subtitle">Upload a CSV file into any folder in the dataset tree.</p>

                    <div class="field-group">
                        <label>Target Folder</label>
                        <select id="upload-folder"><option value="">Loading folders...</option></select>
                    </div>
                    <div class="drop-zone" id="drop-zone" onclick="document.getElementById('file-input').click()">
                        <div class="icon">📂</div>
                        <div>Drop a CSV file here, or click to browse</div>
                        <div id="drop-file-name" style="margin-top:0.5rem;color:var(--primary-color);font-weight:600;"></div>
                        <input type="file" id="file-input" accept=".csv" onchange="handleFileSelect(this)">
                    </div>
                    <button class="action-btn primary" onclick="uploadCSV()">⬆️ Upload</button>
                </div>

                <!-- DELETE CSV -->
                <div class="manage-card">
                    <h3>🗑️ Delete Dataset</h3>
                    <p class="subtitle">Permanently remove a CSV file. A backup will be created first.</p>

                    <div class="field-group">
                        <label>Select File to Delete</label>
                        <select id="delete-file"><option value="">Loading files...</option></select>
                    </div>
                    <button class="action-btn danger" onclick="deleteCSV()">🗑️ Delete Permanently</button>
                </div>

                <!-- QUICK STATS -->
                <div class="manage-card">
                    <h3>📊 Repository Stats</h3>
                    <p class="subtitle">Live statistics from the dataset tree.</p>
                    <div id="repo-stats" style="display:flex;flex-wrap:wrap;gap:1.5rem;margin-top:1rem;">
                        <div><span style="font-size:2rem;font-weight:800;background:linear-gradient(135deg,#818cf8,#c084fc);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent;" id="stat-folders">—</span><br><span style="font-size:0.72rem;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);">Folders</span></div>
                        <div><span style="font-size:2rem;font-weight:800;background:linear-gradient(135deg,#818cf8,#c084fc);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent;" id="stat-files">—</span><br><span style="font-size:0.72rem;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);">CSV Files</span></div>
                        <div><span style="font-size:2rem;font-weight:800;background:linear-gradient(135deg,#818cf8,#c084fc);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent;" id="stat-records">—</span><br><span style="font-size:0.72rem;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);">Total Records</span></div>
                    </div>
                </div>
            </div>

            <!-- AUDIT LOG -->
            <div class="manage-card">
                <h3>📋 Audit Log</h3>
                <p class="subtitle">Recent file operations and changes.</p>
                <div style="overflow-x:auto;">
                    <table class="audit-table" id="audit-table">
                        <thead>
                            <tr><th>Timestamp</th><th>Action</th><th>File</th><th>Details</th></tr>
                        </thead>
                        <tbody id="audit-body">
                            <tr><td colspan="4" style="text-align:center;padding:2rem;color:var(--text-muted);">Loading audit log...</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script>
    const API = 'api_datasets.php';
    let selectedFile = null;
    let createHeaders = [];

    // ── Init ─────────────────────────────────────────────────────────────
    document.addEventListener('DOMContentLoaded', () => {
        loadFolders();
        loadFileList();
        loadAuditLog();
        loadStats();
        setupDropZone();
    });

    // ── Load Folders for Dropdowns ────────────────────────────────────────
    async function loadFolders() {
        try {
            const res = await fetch(`${API}?action=folders`);
            const folders = await res.json();
            const html = '<option value="">— Select folder —</option>' +
                folders.map(f => `<option value="${f}">${f}</option>`).join('');
            document.getElementById('create-folder').innerHTML = html;
            document.getElementById('upload-folder').innerHTML = html;
        } catch(e) { console.error('Failed to load folders', e); }
    }

    // ── Load File List for Delete Dropdown ────────────────────────────────
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
            const html = '<option value="">— Select file —</option>' +
                files.map(f => `<option value="${f}">${f}</option>`).join('');
            document.getElementById('delete-file').innerHTML = html;
        } catch(e) { console.error('Failed to load file list', e); }
    }

    // ── Create CSV ───────────────────────────────────────────────────────
    function addHeaderChip() {
        const input = document.getElementById('create-header-input');
        const val = input.value.trim();
        if (!val) return;
        if (createHeaders.includes(val)) { input.value = ''; return; }
        createHeaders.push(val);
        renderHeaderChips();
        input.value = '';
        input.focus();
    }

    function removeHeaderChip(idx) {
        createHeaders.splice(idx, 1);
        renderHeaderChips();
    }

    function renderHeaderChips() {
        const container = document.getElementById('header-chips');
        container.innerHTML = createHeaders.map((h, i) =>
            `<span class="header-chip">${escHtml(h)} <span class="remove" onclick="removeHeaderChip(${i})">✕</span></span>`
        ).join('');
    }

    async function createCSV() {
        const folder = document.getElementById('create-folder').value;
        const filename = document.getElementById('create-filename').value.trim();
        if (!folder) return toast('Select a target folder.', 'error');
        if (!filename) return toast('Enter a file name.', 'error');
        if (!filename.endsWith('.csv')) return toast('File name must end with .csv', 'error');
        if (createHeaders.length === 0) return toast('Add at least one column header.', 'error');

        try {
            const res = await fetch(`${API}?action=create`, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({ file: folder + '/' + filename, headers: createHeaders })
            });
            const data = await res.json();
            if (data.error) return toast(data.error, 'error');
            toast(`Created ${filename} with ${createHeaders.length} columns!`, 'success');
            createHeaders = [];
            renderHeaderChips();
            document.getElementById('create-filename').value = '';
            loadFileList();
            loadAuditLog();
            loadStats();
        } catch(e) { toast('Failed: ' + e.message, 'error'); }
    }

    // ── Upload CSV ───────────────────────────────────────────────────────
    function setupDropZone() {
        const zone = document.getElementById('drop-zone');
        zone.addEventListener('dragover', e => { e.preventDefault(); zone.classList.add('dragover'); });
        zone.addEventListener('dragleave', () => zone.classList.remove('dragover'));
        zone.addEventListener('drop', e => {
            e.preventDefault();
            zone.classList.remove('dragover');
            if (e.dataTransfer.files.length) {
                document.getElementById('file-input').files = e.dataTransfer.files;
                handleFileSelect(document.getElementById('file-input'));
            }
        });
    }

    function handleFileSelect(input) {
        const file = input.files[0];
        if (file) {
            selectedFile = file;
            document.getElementById('drop-file-name').textContent = `Selected: ${file.name} (${(file.size/1024).toFixed(1)} KB)`;
        }
    }

    async function uploadCSV() {
        const folder = document.getElementById('upload-folder').value;
        if (!folder) return toast('Select a target folder.', 'error');
        if (!selectedFile) return toast('Select or drop a CSV file first.', 'error');

        const formData = new FormData();
        formData.append('target_dir', folder);
        formData.append('csv_file', selectedFile);

        try {
            const res = await fetch(`${API}?action=upload`, { method: 'POST', body: formData });
            const data = await res.json();
            if (data.error) return toast(data.error, 'error');
            toast(`Uploaded ${selectedFile.name} — ${data.records} records!`, 'success');
            selectedFile = null;
            document.getElementById('drop-file-name').textContent = '';
            document.getElementById('file-input').value = '';
            loadFileList();
            loadAuditLog();
            loadStats();
        } catch(e) { toast('Upload failed: ' + e.message, 'error'); }
    }

    // ── Delete CSV ───────────────────────────────────────────────────────
    async function deleteCSV() {
        const file = document.getElementById('delete-file').value;
        if (!file) return toast('Select a file to delete.', 'error');
        if (!confirm(`Are you sure you want to delete:\n${file}\n\nA backup will be created first.`)) return;

        try {
            const res = await fetch(`${API}?action=delete_file`, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({ file })
            });
            const data = await res.json();
            if (data.error) return toast(data.error, 'error');
            toast(`Deleted ${file}`, 'success');
            loadFileList();
            loadAuditLog();
            loadStats();
        } catch(e) { toast('Delete failed: ' + e.message, 'error'); }
    }

    // ── Audit Log ────────────────────────────────────────────────────────
    async function loadAuditLog() {
        try {
            const res = await fetch(`${API}?action=audit&limit=25`);
            const data = await res.json();
            const tbody = document.getElementById('audit-body');

            if (!data.entries || data.entries.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" style="text-align:center;padding:2rem;color:var(--text-muted);">No audit entries yet. Perform an action to start logging.</td></tr>';
                return;
            }

            tbody.innerHTML = data.entries.map(e => {
                const actionClass = e.action.toLowerCase().replace('_file','');
                return `<tr>
                    <td style="font-family:monospace;font-size:0.78rem;">${escHtml(e.timestamp)}</td>
                    <td><span class="action-badge ${actionClass}">${escHtml(e.action)}</span></td>
                    <td title="${escHtml(e.file)}">${escHtml(e.file)}</td>
                    <td title="${escHtml(e.details)}">${escHtml(e.details)}</td>
                </tr>`;
            }).join('');
        } catch(e) {
            document.getElementById('audit-body').innerHTML = '<tr><td colspan="4" style="color:#ef4444;">Failed to load audit log.</td></tr>';
        }
    }

    // ── Stats ─────────────────────────────────────────────────────────────
    async function loadStats() {
        try {
            const res = await fetch(`${API}?action=tree`);
            const tree = await res.json();
            let folders = 0, files = 0, records = 0;
            function walk(items) {
                items.forEach(i => {
                    if (i.type === 'file') { files++; records += i.records || 0; }
                    else { folders++; if (i.children) walk(i.children); }
                });
            }
            walk(tree);
            document.getElementById('stat-folders').textContent = folders.toLocaleString();
            document.getElementById('stat-files').textContent = files.toLocaleString();
            document.getElementById('stat-records').textContent = records.toLocaleString();
        } catch(e) {}
    }

    // ── Helpers ───────────────────────────────────────────────────────────
    function escHtml(s) {
        const d = document.createElement('div'); d.textContent = s || ''; return d.innerHTML;
    }

    function toast(msg, type = 'success') {
        const el = document.createElement('div');
        el.className = 'toast ' + type;
        el.textContent = msg;
        document.body.appendChild(el);
        setTimeout(() => el.remove(), 3200);
    }
    </script>
</body>
</html>
