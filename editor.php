<?php
// CSV Editor — Inline editing interface
$filePath = isset($_GET['file']) ? $_GET['file'] : '';
$fileName = $filePath ? basename($filePath) : 'No File Selected';
$pathParts = $filePath ? explode('/', $filePath) : [];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Editing <?= htmlspecialchars($fileName) ?></title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* ── Editor Layout ──────────────────────────────────────── */
        .editor-container {
            max-width: 1800px;
            margin: 0 auto;
        }

        /* Toolbar */
        .editor-toolbar {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem 1.5rem;
            background: rgba(30, 41, 59, 0.7);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
            backdrop-filter: blur(12px);
        }
        .toolbar-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .toolbar-divider {
            width: 1px;
            height: 28px;
            background: var(--border-color);
            margin: 0 0.25rem;
        }
        .toolbar-search {
            padding: 0.45rem 0.85rem;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            color: var(--text-color);
            font-size: 0.85rem;
            width: 240px;
        }
        .toolbar-search:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        .toolbar-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.45rem 0.85rem;
            border-radius: 0.5rem;
            font-size: 0.82rem;
            font-weight: 600;
            border: 1px solid var(--border-color);
            background: rgba(255,255,255,0.05);
            color: var(--text-color);
            cursor: pointer;
            transition: all 0.15s;
            white-space: nowrap;
        }
        .toolbar-btn:hover {
            background: rgba(255,255,255,0.1);
            border-color: rgba(255,255,255,0.2);
        }
        .toolbar-btn.primary {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: #fff;
        }
        .toolbar-btn.primary:hover { background: var(--primary-hover); }
        .toolbar-btn.danger { border-color: var(--error-color); color: #fca5a5; }
        .toolbar-btn.danger:hover { background: rgba(239,68,68,0.15); }
        .toolbar-btn.success { border-color: var(--success-color); color: #6ee7b7; }
        .toolbar-btn.success:hover { background: rgba(16,185,129,0.15); }
        .toolbar-btn:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }
        .toolbar-btn:disabled:hover {
            background: rgba(255,255,255,0.05);
        }

        .toolbar-info {
            margin-left: auto;
            font-size: 0.78rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .change-indicator {
            display: none;
            align-items: center;
            gap: 0.3rem;
            padding: 0.3rem 0.65rem;
            background: rgba(245, 158, 11, 0.15);
            border: 1px solid rgba(245, 158, 11, 0.3);
            border-radius: 0.4rem;
            color: #fbbf24;
            font-weight: 600;
            font-size: 0.78rem;
        }
        .change-indicator.visible { display: flex; }

        /* Breadcrumb */
        .editor-breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 0.75rem;
        }
        .editor-breadcrumb a {
            color: var(--text-muted);
            text-decoration: none;
        }
        .editor-breadcrumb a:hover { color: var(--primary-color); }
        .editor-breadcrumb .sep { opacity: 0.4; }
        .editor-breadcrumb .current { color: var(--text-color); font-weight: 600; }

        /* ── Data Table ─────────────────────────────────────────── */
        .table-wrapper {
            background: rgba(30, 41, 59, 0.5);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            overflow: hidden;
        }
        .table-scroll {
            overflow-x: auto;
            max-height: calc(100vh - 320px);
            overflow-y: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.85rem;
        }
        .data-table thead {
            position: sticky;
            top: 0;
            z-index: 5;
        }
        .data-table th {
            background: rgba(15, 23, 42, 0.95);
            padding: 0.65rem 0.85rem;
            text-align: left;
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--text-muted);
            border-bottom: 2px solid var(--border-color);
            white-space: nowrap;
            cursor: pointer;
            user-select: none;
            transition: color 0.15s;
        }
        .data-table th:hover { color: var(--primary-color); }
        .data-table th.sorted { color: #a5b4fc; }
        .data-table th .sort-icon { margin-left: 0.3rem; font-size: 0.65rem; }

        .data-table td {
            padding: 0.5rem 0.85rem;
            border-bottom: 1px solid rgba(255,255,255,0.04);
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            transition: background 0.1s;
        }
        .data-table tr:hover td { background: rgba(99,102,241,0.04); }

        /* Row selection checkbox column */
        .data-table .col-select {
            width: 40px;
            text-align: center;
            padding: 0.5rem;
        }
        .data-table .col-select input[type="checkbox"] {
            width: 15px;
            height: 15px;
            cursor: pointer;
            accent-color: var(--primary-color);
        }

        /* Row line number */
        .data-table .col-line {
            width: 55px;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.72rem;
            font-family: monospace;
        }

        /* Editable cell */
        .data-table td.editable {
            cursor: text;
            position: relative;
        }
        .data-table td.editable:hover {
            background: rgba(99,102,241,0.08);
            outline: 1px solid rgba(99,102,241,0.3);
            outline-offset: -1px;
        }
        .data-table td.editing {
            padding: 0;
            outline: 2px solid var(--primary-color);
            outline-offset: -2px;
            background: rgba(15,23,42,0.9);
        }
        .data-table td.editing input {
            width: 100%;
            padding: 0.5rem 0.85rem;
            background: transparent;
            border: none;
            color: var(--text-color);
            font-size: 0.85rem;
            font-family: inherit;
            outline: none;
        }

        /* Dirty row indicator */
        .data-table tr.row-modified td:first-child {
            box-shadow: inset 3px 0 0 #f59e0b;
        }
        .data-table tr.row-added td:first-child {
            box-shadow: inset 3px 0 0 var(--success-color);
        }
        .data-table tr.row-deleted {
            opacity: 0.35;
            text-decoration: line-through;
        }
        .data-table tr.selected {
            background: rgba(99, 102, 241, 0.08) !important;
        }

        /* ── Pagination ─────────────────────────────────────────── */
        .table-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.75rem 1.25rem;
            border-top: 1px solid var(--border-color);
            background: rgba(15, 23, 42, 0.5);
            font-size: 0.82rem;
            color: var(--text-muted);
        }
        .page-controls {
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }
        .page-btn {
            padding: 0.35rem 0.65rem;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.375rem;
            color: var(--text-color);
            cursor: pointer;
            font-size: 0.8rem;
            transition: all 0.15s;
        }
        .page-btn:hover { background: rgba(255,255,255,0.1); }
        .page-btn.active { background: var(--primary-color); border-color: var(--primary-color); }
        .page-btn:disabled { opacity: 0.3; cursor: not-allowed; }

        .per-page-select {
            padding: 0.3rem 0.5rem;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.375rem;
            color: var(--text-color);
            font-size: 0.8rem;
        }

        /* ── Add Row Modal ──────────────────────────────────────── */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.6);
            z-index: 100;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(4px);
        }
        .modal-overlay.visible { display: flex; }
        .modal-box {
            background: #1e293b;
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 2rem;
            min-width: 500px;
            max-width: 700px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            animation: modalIn 0.2s ease-out;
        }
        @keyframes modalIn {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }
        .modal-box h3 {
            margin: 0 0 1.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .modal-box .form-row {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.75rem;
        }
        .modal-box .form-row label {
            min-width: 140px;
            font-size: 0.8rem;
            font-weight: 500;
            color: var(--text-muted);
            text-align: right;
        }
        .modal-box .form-row input {
            flex: 1;
            padding: 0.55rem 0.75rem;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.4rem;
            color: var(--text-color);
            font-size: 0.85rem;
        }
        .modal-box .form-row input:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        .modal-actions {
            display: flex;
            gap: 0.5rem;
            justify-content: flex-end;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }

        /* Toast notifications */
        .toast {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            padding: 0.85rem 1.5rem;
            border-radius: 0.6rem;
            font-size: 0.85rem;
            font-weight: 600;
            z-index: 200;
            animation: toastIn 0.3s ease-out, toastOut 0.3s ease-in 2.7s forwards;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        .toast.success { background: #065f46; color: #6ee7b7; border: 1px solid #10b981; }
        .toast.error { background: #7f1d1d; color: #fca5a5; border: 1px solid #ef4444; }
        .toast.info { background: #1e3a5f; color: #93c5fd; border: 1px solid #3b82f6; }
        @keyframes toastIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes toastOut { from { opacity: 1; } to { opacity: 0; transform: translateY(-10px); } }

        /* Loading overlay */
        .loading-overlay {
            display: none;
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(15,23,42,0.7);
            z-index: 50;
            align-items: center;
            justify-content: center;
            border-radius: 0.75rem;
        }
        .loading-overlay.visible { display: flex; }
        .spinner {
            width: 36px;
            height: 36px;
            border: 3px solid rgba(99,102,241,0.2);
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* No-file state */
        .no-file-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 400px;
            text-align: center;
            color: var(--text-muted);
        }
        .no-file-state .icon { font-size: 4rem; margin-bottom: 1rem; opacity: 0.5; }
    </style>
</head>
<body>
    <div class="container editor-container" style="max-width:1800px;">
        <header>
            <?php $active_page = 'datasets'; include 'header.php'; ?>
        </header>

        <main>
            <?php if (!$filePath): ?>
            <div class="card no-file-state">
                <div class="icon">📄</div>
                <h3>No File Selected</h3>
                <p>Go to the <a href="datasets.php" style="color:var(--primary-color);">Dataset Browser</a> and select a CSV file to edit.</p>
            </div>
            <?php else: ?>

            <!-- Breadcrumb -->
            <div class="editor-breadcrumb">
                <a href="datasets.php">📂 Datasets</a>
                <?php foreach ($pathParts as $i => $part): ?>
                    <span class="sep">›</span>
                    <?php if ($i < count($pathParts) - 1): ?>
                        <a href="datasets.php"><?= htmlspecialchars($part) ?></a>
                    <?php else: ?>
                        <span class="current"><?= htmlspecialchars($part) ?></span>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>

            <!-- Toolbar -->
            <div class="editor-toolbar">
                <div class="toolbar-group">
                    <button class="toolbar-btn primary" id="btn-save" disabled onclick="saveChanges()">
                        💾 Save
                    </button>
                    <button class="toolbar-btn" id="btn-undo" disabled onclick="undoChanges()">
                        ↩️ Undo All
                    </button>
                </div>
                <div class="toolbar-divider"></div>
                <div class="toolbar-group">
                    <button class="toolbar-btn success" onclick="showAddModal()">
                        ➕ Add Row
                    </button>
                    <button class="toolbar-btn danger" id="btn-delete" disabled onclick="deleteSelected()">
                        🗑️ Delete Selected
                    </button>
                </div>
                <div class="toolbar-divider"></div>
                <div class="toolbar-group">
                    <input type="text" class="toolbar-search" id="search-input" placeholder="Search records..." oninput="handleSearch()">
                    <button class="toolbar-btn" onclick="exportCSV()">
                        📥 Export CSV
                    </button>
                </div>
                <div class="toolbar-info">
                    <div class="change-indicator" id="change-indicator">
                        ⚡ <span id="change-count">0</span> unsaved changes
                    </div>
                    <span id="record-count"></span>
                </div>
            </div>

            <!-- Data Table -->
            <div class="table-wrapper" style="position:relative;">
                <div class="loading-overlay" id="loading-overlay"><div class="spinner"></div></div>
                <div class="table-scroll" id="table-scroll">
                    <table class="data-table" id="data-table">
                        <thead id="table-head"></thead>
                        <tbody id="table-body"></tbody>
                    </table>
                </div>
                <div class="table-footer" id="table-footer"></div>
            </div>

            <!-- Add Row Modal -->
            <div class="modal-overlay" id="add-modal">
                <div class="modal-box">
                    <h3>➕ Add New Record</h3>
                    <div id="add-form-fields"></div>
                    <div class="modal-actions">
                        <button class="toolbar-btn" onclick="closeAddModal()">Cancel</button>
                        <button class="toolbar-btn primary" onclick="addRow()">Add Record</button>
                    </div>
                </div>
            </div>

            <script>
            (function() {
                const API = 'api_datasets.php';
                const FILE_PATH = <?= json_encode($filePath) ?>;

                // State
                let headers = [];
                let originalRows = [];   // Server data
                let currentPage = 1;
                let perPage = 100;
                let totalRows = 0;
                let totalPages = 1;
                let searchTerm = '';
                let pendingChanges = {};  // { lineIndex: {data: [...]} }
                let pendingAdds = [];     // [ [...], [...] ]
                let pendingDeletes = new Set(); // line indices
                let sortCol = -1;
                let sortDir = 'asc';

                // ── Load Data ─────────────────────────────────────────
                async function loadData() {
                    showLoading(true);
                    try {
                        const params = new URLSearchParams({
                            action: 'read',
                            file: FILE_PATH,
                            page: currentPage,
                            per_page: perPage,
                            search: searchTerm
                        });
                        const res = await fetch(`${API}?${params}`);
                        const data = await res.json();

                        if (data.error) {
                            toast(data.error, 'error');
                            return;
                        }

                        headers = data.headers;
                        originalRows = data.rows;
                        totalRows = data.total;
                        totalPages = data.totalPages;
                        currentPage = data.page;

                        renderTable();
                        renderFooter();
                        document.getElementById('record-count').textContent =
                            `${totalRows.toLocaleString()} records`;
                    } catch (e) {
                        toast('Failed to load data: ' + e.message, 'error');
                    } finally {
                        showLoading(false);
                    }
                }

                // ── Render Table ──────────────────────────────────────
                function renderTable() {
                    // Header
                    const thead = document.getElementById('table-head');
                    let headHtml = '<tr>';
                    headHtml += '<th class="col-select"><input type="checkbox" id="select-all" onchange="toggleSelectAll(this)"></th>';
                    headHtml += '<th class="col-line">#</th>';
                    headers.forEach((h, i) => {
                        const isSorted = sortCol === i;
                        const icon = isSorted ? (sortDir === 'asc' ? '↑' : '↓') : '';
                        headHtml += `<th class="${isSorted ? 'sorted' : ''}" onclick="sortColumn(${i})">${escHtml(h)}<span class="sort-icon">${icon}</span></th>`;
                    });
                    headHtml += '</tr>';
                    thead.innerHTML = headHtml;

                    // Body
                    const tbody = document.getElementById('table-body');
                    if (originalRows.length === 0) {
                        tbody.innerHTML = `<tr><td colspan="${headers.length + 2}" style="text-align:center;padding:3rem;color:var(--text-muted);">No records found.</td></tr>`;
                        return;
                    }

                    let bodyHtml = '';
                    originalRows.forEach((row) => {
                        const lineIdx = row._line;
                        const data = pendingChanges[lineIdx] ? pendingChanges[lineIdx].data : row.data;
                        const isModified = !!pendingChanges[lineIdx];
                        const isDeleted = pendingDeletes.has(lineIdx);

                        let rowClass = '';
                        if (isDeleted) rowClass = 'row-deleted';
                        else if (isModified) rowClass = 'row-modified';

                        bodyHtml += `<tr class="${rowClass}" data-line="${lineIdx}">`;
                        bodyHtml += `<td class="col-select"><input type="checkbox" class="row-check" value="${lineIdx}" onchange="updateDeleteBtn()"></td>`;
                        bodyHtml += `<td class="col-line">${lineIdx}</td>`;
                        data.forEach((cell, ci) => {
                            bodyHtml += `<td class="editable" data-line="${lineIdx}" data-col="${ci}" ondblclick="editCell(this)">${escHtml(cell || '')}</td>`;
                        });
                        bodyHtml += '</tr>';
                    });

                    // Pending adds (shown at the bottom)
                    pendingAdds.forEach((addRow, ai) => {
                        bodyHtml += `<tr class="row-added" data-add-index="${ai}">`;
                        bodyHtml += `<td class="col-select">✨</td>`;
                        bodyHtml += `<td class="col-line" style="color:#10b981;">NEW</td>`;
                        addRow.forEach((cell, ci) => {
                            bodyHtml += `<td class="editable" data-add-index="${ai}" data-col="${ci}" ondblclick="editAddCell(this)">${escHtml(cell || '')}</td>`;
                        });
                        bodyHtml += '</tr>';
                    });

                    tbody.innerHTML = bodyHtml;
                }

                // ── Render Pagination Footer ──────────────────────────
                function renderFooter() {
                    const footer = document.getElementById('table-footer');
                    const start = (currentPage - 1) * perPage + 1;
                    const end = Math.min(currentPage * perPage, totalRows);

                    let html = `<span>Showing ${start}-${end} of ${totalRows.toLocaleString()}</span>`;

                    html += '<div class="page-controls">';
                    html += `<button class="page-btn" onclick="goPage(1)" ${currentPage <= 1 ? 'disabled' : ''}>«</button>`;
                    html += `<button class="page-btn" onclick="goPage(${currentPage - 1})" ${currentPage <= 1 ? 'disabled' : ''}>‹</button>`;

                    // Page numbers
                    let pageStart = Math.max(1, currentPage - 3);
                    let pageEnd = Math.min(totalPages, currentPage + 3);
                    for (let p = pageStart; p <= pageEnd; p++) {
                        html += `<button class="page-btn ${p === currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button>`;
                    }

                    html += `<button class="page-btn" onclick="goPage(${currentPage + 1})" ${currentPage >= totalPages ? 'disabled' : ''}>›</button>`;
                    html += `<button class="page-btn" onclick="goPage(${totalPages})" ${currentPage >= totalPages ? 'disabled' : ''}>»</button>`;

                    html += `<select class="per-page-select" onchange="changePerPage(this.value)">`;
                    [50, 100, 200, 500].forEach(n => {
                        html += `<option value="${n}" ${perPage === n ? 'selected' : ''}>${n}/page</option>`;
                    });
                    html += '</select>';
                    html += '</div>';

                    footer.innerHTML = html;
                }

                // ── Inline Cell Editing ───────────────────────────────
                window.editCell = function(td) {
                    if (td.classList.contains('editing')) return;
                    const lineIdx = parseInt(td.dataset.line);
                    const colIdx = parseInt(td.dataset.col);
                    const currentValue = td.textContent;

                    td.classList.add('editing');
                    const input = document.createElement('input');
                    input.value = currentValue;
                    td.textContent = '';
                    td.appendChild(input);
                    input.focus();
                    input.select();

                    function commitEdit() {
                        const newValue = input.value;
                        td.classList.remove('editing');
                        td.textContent = newValue;

                        if (newValue !== currentValue) {
                            // Track the change
                            const row = originalRows.find(r => r._line === lineIdx);
                            if (row) {
                                if (!pendingChanges[lineIdx]) {
                                    pendingChanges[lineIdx] = { data: [...row.data] };
                                }
                                pendingChanges[lineIdx].data[colIdx] = newValue;
                                td.closest('tr').classList.add('row-modified');
                                updateChangeCount();
                            }
                        }
                    }

                    input.addEventListener('blur', commitEdit);
                    input.addEventListener('keydown', (e) => {
                        if (e.key === 'Enter') { input.blur(); }
                        if (e.key === 'Escape') {
                            input.value = currentValue;
                            input.blur();
                        }
                        if (e.key === 'Tab') {
                            e.preventDefault();
                            input.blur();
                            // Move to next/prev cell
                            const nextTd = e.shiftKey ? td.previousElementSibling : td.nextElementSibling;
                            if (nextTd && nextTd.classList.contains('editable')) {
                                editCell(nextTd);
                            }
                        }
                    });
                };

                window.editAddCell = function(td) {
                    if (td.classList.contains('editing')) return;
                    const addIdx = parseInt(td.dataset.addIndex);
                    const colIdx = parseInt(td.dataset.col);
                    const currentValue = td.textContent;

                    td.classList.add('editing');
                    const input = document.createElement('input');
                    input.value = currentValue;
                    td.textContent = '';
                    td.appendChild(input);
                    input.focus();

                    function commitEdit() {
                        const newValue = input.value;
                        td.classList.remove('editing');
                        td.textContent = newValue;
                        if (pendingAdds[addIdx]) {
                            pendingAdds[addIdx][colIdx] = newValue;
                            updateChangeCount();
                        }
                    }

                    input.addEventListener('blur', commitEdit);
                    input.addEventListener('keydown', (e) => {
                        if (e.key === 'Enter') input.blur();
                        if (e.key === 'Escape') { input.value = currentValue; input.blur(); }
                    });
                };

                // ── Checkbox / Selection ──────────────────────────────
                window.toggleSelectAll = function(el) {
                    document.querySelectorAll('.row-check').forEach(cb => {
                        cb.checked = el.checked;
                    });
                    updateDeleteBtn();
                };

                window.updateDeleteBtn = function() {
                    const checked = document.querySelectorAll('.row-check:checked');
                    document.getElementById('btn-delete').disabled = checked.length === 0;
                };

                // ── Delete Selected ───────────────────────────────────
                window.deleteSelected = function() {
                    const checked = document.querySelectorAll('.row-check:checked');
                    if (checked.length === 0) return;
                    if (!confirm(`Delete ${checked.length} row(s)? This will be applied when you save.`)) return;

                    checked.forEach(cb => {
                        const lineIdx = parseInt(cb.value);
                        pendingDeletes.add(lineIdx);
                        const tr = cb.closest('tr');
                        tr.classList.add('row-deleted');
                        cb.checked = false;
                    });
                    updateDeleteBtn();
                    updateChangeCount();
                };

                // ── Add Row ───────────────────────────────────────────
                window.showAddModal = function() {
                    const fields = document.getElementById('add-form-fields');
                    let html = '';
                    headers.forEach((h, i) => {
                        html += `<div class="form-row">
                            <label>${escHtml(h)}</label>
                            <input type="text" id="add-field-${i}" placeholder="Enter ${escHtml(h)}">
                        </div>`;
                    });
                    fields.innerHTML = html;
                    document.getElementById('add-modal').classList.add('visible');
                    // Focus first field
                    setTimeout(() => {
                        const first = document.getElementById('add-field-0');
                        if (first) first.focus();
                    }, 100);
                };

                window.closeAddModal = function() {
                    document.getElementById('add-modal').classList.remove('visible');
                };

                window.addRow = function() {
                    const newRow = [];
                    headers.forEach((_, i) => {
                        const input = document.getElementById(`add-field-${i}`);
                        newRow.push(input ? input.value : '');
                    });
                    pendingAdds.push(newRow);
                    closeAddModal();
                    renderTable();
                    updateChangeCount();
                    toast('Row added (save to persist)', 'info');
                };

                // ── Save Changes ──────────────────────────────────────
                window.saveChanges = async function() {
                    showLoading(true);
                    try {
                        // 1. Apply deletes
                        if (pendingDeletes.size > 0) {
                            const delRes = await fetch(`${API}?action=delete`, {
                                method: 'POST',
                                headers: {'Content-Type': 'application/json'},
                                body: JSON.stringify({
                                    file: FILE_PATH,
                                    lines: [...pendingDeletes]
                                })
                            });
                            const delData = await delRes.json();
                            if (delData.error) throw new Error(delData.error);
                        }

                        // 2. Apply updates
                        const changes = Object.entries(pendingChanges).map(([line, change]) => ({
                            line: parseInt(line),
                            data: change.data
                        }));
                        if (changes.length > 0) {
                            const upRes = await fetch(`${API}?action=update`, {
                                method: 'POST',
                                headers: {'Content-Type': 'application/json'},
                                body: JSON.stringify({ file: FILE_PATH, changes })
                            });
                            const upData = await upRes.json();
                            if (upData.error) throw new Error(upData.error);
                        }

                        // 3. Apply adds
                        if (pendingAdds.length > 0) {
                            const addRes = await fetch(`${API}?action=add`, {
                                method: 'POST',
                                headers: {'Content-Type': 'application/json'},
                                body: JSON.stringify({ file: FILE_PATH, rows: pendingAdds })
                            });
                            const addData = await addRes.json();
                            if (addData.error) throw new Error(addData.error);
                        }

                        // Clear pending state
                        pendingChanges = {};
                        pendingAdds = [];
                        pendingDeletes.clear();
                        updateChangeCount();

                        toast('All changes saved successfully!', 'success');
                        await loadData();
                    } catch (e) {
                        toast('Save failed: ' + e.message, 'error');
                    } finally {
                        showLoading(false);
                    }
                };

                // ── Undo All ──────────────────────────────────────────
                window.undoChanges = function() {
                    if (!confirm('Discard all unsaved changes?')) return;
                    pendingChanges = {};
                    pendingAdds = [];
                    pendingDeletes.clear();
                    renderTable();
                    updateChangeCount();
                    toast('All changes discarded', 'info');
                };

                // ── Sort ──────────────────────────────────────────────
                window.sortColumn = function(colIdx) {
                    if (sortCol === colIdx) {
                        sortDir = sortDir === 'asc' ? 'desc' : 'asc';
                    } else {
                        sortCol = colIdx;
                        sortDir = 'asc';
                    }

                    originalRows.sort((a, b) => {
                        const va = (a.data[colIdx] || '').toString().toLowerCase();
                        const vb = (b.data[colIdx] || '').toString().toLowerCase();
                        // Try numeric
                        const na = parseFloat(va), nb = parseFloat(vb);
                        if (!isNaN(na) && !isNaN(nb)) {
                            return sortDir === 'asc' ? na - nb : nb - na;
                        }
                        return sortDir === 'asc' ? va.localeCompare(vb) : vb.localeCompare(va);
                    });

                    renderTable();
                };

                // ── Search ────────────────────────────────────────────
                let searchTimeout;
                window.handleSearch = function() {
                    clearTimeout(searchTimeout);
                    searchTimeout = setTimeout(() => {
                        searchTerm = document.getElementById('search-input').value;
                        currentPage = 1;
                        loadData();
                    }, 400);
                };

                // ── Pagination ────────────────────────────────────────
                window.goPage = function(p) {
                    currentPage = Math.max(1, Math.min(p, totalPages));
                    loadData();
                };

                window.changePerPage = function(val) {
                    perPage = parseInt(val);
                    currentPage = 1;
                    loadData();
                };

                // ── Export ────────────────────────────────────────────
                window.exportCSV = function() {
                    window.location.href = `${API}?action=export&file=${encodeURIComponent(FILE_PATH)}`;
                };

                // ── UI Helpers ────────────────────────────────────────
                function updateChangeCount() {
                    const count = Object.keys(pendingChanges).length + pendingAdds.length + pendingDeletes.size;
                    const indicator = document.getElementById('change-indicator');
                    const countEl = document.getElementById('change-count');
                    const saveBtn = document.getElementById('btn-save');
                    const undoBtn = document.getElementById('btn-undo');

                    countEl.textContent = count;
                    indicator.classList.toggle('visible', count > 0);
                    saveBtn.disabled = count === 0;
                    undoBtn.disabled = count === 0;
                }

                function showLoading(show) {
                    document.getElementById('loading-overlay').classList.toggle('visible', show);
                }

                function escHtml(str) {
                    const div = document.createElement('div');
                    div.textContent = str;
                    return div.innerHTML;
                }

                window.toast = function(msg, type = 'info') {
                    const el = document.createElement('div');
                    el.className = `toast ${type}`;
                    el.textContent = msg;
                    document.body.appendChild(el);
                    setTimeout(() => el.remove(), 3500);
                };

                // ── Init ─────────────────────────────────────────────
                loadData();

                // Warn before leaving with unsaved changes
                window.addEventListener('beforeunload', (e) => {
                    const count = Object.keys(pendingChanges).length + pendingAdds.length + pendingDeletes.size;
                    if (count > 0) {
                        e.preventDefault();
                        e.returnValue = '';
                    }
                });
            })();
            </script>
            <?php endif; ?>
        </main>
    </div>
</body>
</html>
