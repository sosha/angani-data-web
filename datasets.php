<?php
// Dataset Browser — File Explorer UI
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Dataset Browser</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .browser-layout {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 0;
            min-height: calc(100vh - 160px);
            border-radius: 1rem;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        /* ── Left Panel: Folder Tree ─────────────────────────────── */
        .tree-panel {
            background: rgba(15, 23, 42, 0.95);
            border-right: 1px solid var(--border-color);
            overflow-y: auto;
            padding: 0;
        }
        .tree-panel-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            background: rgba(30, 41, 59, 0.5);
            position: sticky;
            top: 0;
            z-index: 10;
            backdrop-filter: blur(12px);
        }
        .tree-panel-header h3 {
            margin: 0 0 0.75rem 0;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--text-muted);
        }
        .tree-search {
            width: 100%;
            padding: 0.5rem 0.75rem;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            color: var(--text-color);
            font-size: 0.85rem;
        }
        .tree-search:focus {
            outline: none;
            border-color: var(--primary-color);
            background: rgba(255,255,255,0.08);
        }
        .tree-search::placeholder { color: rgba(148,163,184,0.6); }

        .tree-list {
            padding: 0.5rem 0;
        }

        /* Tree item styles */
        .tree-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.45rem 1rem;
            cursor: pointer;
            font-size: 0.875rem;
            color: var(--text-color);
            transition: background 0.15s, color 0.15s;
            user-select: none;
            border-left: 3px solid transparent;
        }
        .tree-item:hover {
            background: rgba(99, 102, 241, 0.08);
        }
        .tree-item.active {
            background: rgba(99, 102, 241, 0.12);
            border-left-color: var(--primary-color);
            color: #a5b4fc;
        }
        .tree-item .icon {
            font-size: 1rem;
            flex-shrink: 0;
            width: 20px;
            text-align: center;
        }
        .tree-item .label {
            flex: 1;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .tree-item .badge {
            font-size: 0.7rem;
            background: rgba(99,102,241,0.2);
            color: #a5b4fc;
            padding: 0.1rem 0.45rem;
            border-radius: 10px;
            font-weight: 600;
        }
        .tree-item .chevron {
            font-size: 0.65rem;
            transition: transform 0.2s;
            color: var(--text-muted);
            width: 12px;
        }
        .tree-item .chevron.open { transform: rotate(90deg); }

        .tree-children {
            display: none;
            padding-left: 0.75rem;
        }
        .tree-children.open { display: block; }

        /* ── Right Panel: Content ────────────────────────────────── */
        .content-panel {
            background: rgba(15, 23, 42, 0.6);
            overflow-y: auto;
            padding: 2rem;
        }

        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        /* Breadcrumb */
        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 0.85rem;
            color: var(--text-muted);
        }
        .breadcrumb a {
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.15s;
        }
        .breadcrumb a:hover { color: var(--primary-color); }
        .breadcrumb .sep { opacity: 0.4; }
        .breadcrumb .current { color: var(--text-color); font-weight: 600; }

        /* File grid */
        .file-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 1rem;
        }
        .file-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            padding: 1.25rem;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            color: var(--text-color);
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        .file-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.15);
        }
        .file-card .file-icon {
            font-size: 2rem;
            margin-bottom: 0.25rem;
        }
        .file-card .file-name {
            font-weight: 600;
            font-size: 0.95rem;
            word-break: break-word;
        }
        .file-card .file-meta {
            display: flex;
            gap: 1rem;
            font-size: 0.75rem;
            color: var(--text-muted);
        }
        .file-card .file-meta span {
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        /* Folder cards */
        .folder-card {
            background: rgba(30, 41, 59, 0.5);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            padding: 1rem 1.25rem;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .folder-card:hover {
            border-color: rgba(99,102,241,0.4);
            background: rgba(30, 41, 59, 0.8);
        }
        .folder-card .folder-icon { font-size: 1.4rem; }
        .folder-card .folder-name { font-weight: 500; font-size: 0.9rem; }
        .folder-card .folder-count {
            margin-left: auto;
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        /* Welcome state */
        .welcome-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 400px;
            text-align: center;
            color: var(--text-muted);
        }
        .welcome-state .icon { font-size: 4rem; margin-bottom: 1rem; opacity: 0.5; }
        .welcome-state h3 { color: var(--text-color); margin-bottom: 0.5rem; }

        /* Stats bar */
        .stats-bar {
            display: flex;
            gap: 2rem;
            padding: 1rem 1.5rem;
            background: rgba(30, 41, 59, 0.3);
            border-radius: 0.75rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--border-color);
        }
        .stat-item {
            display: flex;
            flex-direction: column;
            gap: 0.15rem;
        }
        .stat-item .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #818cf8, #c084fc);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .stat-item .stat-label {
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
        }

        /* Loading spinner */
        .loading-spinner {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem;
        }
        .spinner {
            width: 36px;
            height: 36px;
            border: 3px solid rgba(99,102,241,0.2);
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
</head>
<body>
    <div class="container" style="max-width: 1600px;">
        <header>
            <?php $active_page = 'datasets'; include 'header.php'; ?>
        </header>

        <main>
            <div class="browser-layout">
                <!-- Left: Folder Tree -->
                <div class="tree-panel">
                    <div class="tree-panel-header">
                        <h3>📂 Dataset Explorer</h3>
                        <input type="text" class="tree-search" id="tree-search" placeholder="Filter folders...">
                    </div>
                    <div class="tree-list" id="tree-root">
                        <div class="loading-spinner"><div class="spinner"></div></div>
                    </div>
                </div>

                <!-- Right: Content / File View -->
                <div class="content-panel" id="content-panel">
                    <div class="welcome-state" id="welcome-state">
                        <div class="icon">📊</div>
                        <h3>Welcome to the Dataset Browser</h3>
                        <p>Select a folder from the tree to browse CSV datasets.<br>Click any file to open it in the editor.</p>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
    (function() {
        const API = 'api_datasets.php';
        let treeData = null;
        let activePath = '';

        // ── Load Tree ─────────────────────────────────────────────
        async function loadTree() {
            try {
                const res = await fetch(`${API}?action=tree`);
                treeData = await res.json();
                renderTree(treeData);
                updateStats(treeData);
            } catch (e) {
                document.getElementById('tree-root').innerHTML = '<div style="padding:1rem;color:#ef4444;">Failed to load datasets.</div>';
            }
        }

        function renderTree(items, container, depth = 0) {
            if (!container) container = document.getElementById('tree-root');
            container.innerHTML = '';

            items.forEach(item => {
                if (item.type === 'folder') {
                    const wrapper = document.createElement('div');
                    wrapper.className = 'tree-folder-wrapper';
                    wrapper.dataset.name = item.name.toLowerCase();

                    const el = document.createElement('div');
                    el.className = 'tree-item';
                    el.style.paddingLeft = (1 + depth * 0.75) + 'rem';

                    const csvCount = countCSVs(item.children);
                    el.innerHTML = `
                        <span class="chevron">▶</span>
                        <span class="icon">📁</span>
                        <span class="label">${item.name}</span>
                        ${csvCount > 0 ? `<span class="badge">${csvCount}</span>` : ''}
                    `;

                    const childContainer = document.createElement('div');
                    childContainer.className = 'tree-children';

                    el.addEventListener('click', (e) => {
                        e.stopPropagation();
                        const chev = el.querySelector('.chevron');
                        const isOpen = childContainer.classList.toggle('open');
                        chev.classList.toggle('open', isOpen);

                        // Show folder contents in right panel
                        showFolderContent(item);
                        setActive(el);
                    });

                    wrapper.appendChild(el);
                    wrapper.appendChild(childContainer);
                    container.appendChild(wrapper);

                    renderTree(item.children, childContainer, depth + 1);

                } else if (item.type === 'file') {
                    const el = document.createElement('div');
                    el.className = 'tree-item';
                    el.style.paddingLeft = (1 + depth * 0.75) + 'rem';
                    el.dataset.name = item.name.toLowerCase();
                    el.innerHTML = `
                        <span class="icon">📄</span>
                        <span class="label">${item.name}</span>
                        <span class="badge">${item.records}</span>
                    `;
                    el.addEventListener('click', (e) => {
                        e.stopPropagation();
                        openEditor(item.path);
                        setActive(el);
                    });
                    container.appendChild(el);
                }
            });
        }

        function countCSVs(items) {
            let n = 0;
            items.forEach(i => {
                if (i.type === 'file') n++;
                else if (i.children) n += countCSVs(i.children);
            });
            return n;
        }

        function setActive(el) {
            document.querySelectorAll('.tree-item.active').forEach(e => e.classList.remove('active'));
            el.classList.add('active');
        }

        // ── Show Folder Content ───────────────────────────────────
        function showFolderContent(folder) {
            activePath = folder.path;
            const panel = document.getElementById('content-panel');
            const parts = folder.path.split('/');

            let breadcrumb = '<div class="breadcrumb"><a href="#" onclick="resetView()">🏠 datasets</a>';
            let accumulated = '';
            parts.forEach((p, i) => {
                accumulated += (i > 0 ? '/' : '') + p;
                if (i < parts.length - 1) {
                    breadcrumb += `<span class="sep">›</span><a href="#">${p}</a>`;
                } else {
                    breadcrumb += `<span class="sep">›</span><span class="current">${p}</span>`;
                }
            });
            breadcrumb += '</div>';

            const folders = folder.children.filter(c => c.type === 'folder');
            const files = folder.children.filter(c => c.type === 'file');

            let html = `<div class="content-header">${breadcrumb}</div>`;

            if (folders.length > 0) {
                html += '<div style="margin-bottom:0.75rem;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);">Folders</div>';
                html += '<div class="file-grid" style="grid-template-columns:repeat(auto-fill,minmax(200px,1fr));margin-bottom:1.5rem;">';
                folders.forEach(f => {
                    const count = countCSVs(f.children);
                    html += `<div class="folder-card" onclick="navigateFolder('${f.path}')">
                        <span class="folder-icon">📁</span>
                        <span class="folder-name">${f.name}</span>
                        <span class="folder-count">${count} file${count !== 1 ? 's' : ''}</span>
                    </div>`;
                });
                html += '</div>';
            }

            if (files.length > 0) {
                html += '<div style="margin-bottom:0.75rem;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);">CSV Files</div>';
                html += '<div class="file-grid">';
                files.forEach(f => {
                    const sizeStr = formatSize(f.size);
                    html += `<a class="file-card" href="editor.php?file=${encodeURIComponent(f.path)}">
                        <div class="file-icon">📊</div>
                        <div class="file-name">${f.name}</div>
                        <div class="file-meta">
                            <span>📏 ${f.records} records</span>
                            <span>💾 ${sizeStr}</span>
                        </div>
                    </a>`;
                });
                html += '</div>';
            }

            if (folders.length === 0 && files.length === 0) {
                html += '<div class="welcome-state"><div class="icon">📭</div><h3>Empty Folder</h3><p>No CSV files in this directory.</p></div>';
            }

            panel.innerHTML = html;
        }

        // Navigate into a subfolder from the right panel
        window.navigateFolder = function(path) {
            const folder = findNode(treeData, path);
            if (folder) {
                showFolderContent(folder);
                // Expand tree to this path
                expandTreeTo(path);
            }
        };

        window.resetView = function() {
            document.getElementById('content-panel').innerHTML = document.getElementById('welcome-state')?.outerHTML || '';
        };

        function findNode(items, path) {
            for (const item of items) {
                if (item.path === path) return item;
                if (item.children) {
                    const found = findNode(item.children, path);
                    if (found) return found;
                }
            }
            return null;
        }

        function expandTreeTo(path) {
            // Open all parent tree-children elements
            const parts = path.split('/');
            let current = '';
            parts.forEach((p, i) => {
                current += (i > 0 ? '/' : '') + p;
                // Find tree items and open their children
                document.querySelectorAll('.tree-item').forEach(el => {
                    const label = el.querySelector('.label');
                    if (label && label.textContent === p) {
                        const children = el.nextElementSibling;
                        if (children && children.classList.contains('tree-children')) {
                            children.classList.add('open');
                            const chev = el.querySelector('.chevron');
                            if (chev) chev.classList.add('open');
                        }
                    }
                });
            });
        }

        function openEditor(filePath) {
            window.location.href = 'editor.php?file=' + encodeURIComponent(filePath);
        }

        function formatSize(bytes) {
            if (bytes < 1024) return bytes + ' B';
            if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB';
            return (bytes / 1048576).toFixed(1) + ' MB';
        }

        // ── Stats ─────────────────────────────────────────────────
        function updateStats(items) {
            let totalFiles = 0, totalRecords = 0, totalFolders = 0;
            function walk(arr) {
                arr.forEach(i => {
                    if (i.type === 'file') { totalFiles++; totalRecords += i.records || 0; }
                    else { totalFolders++; if (i.children) walk(i.children); }
                });
            }
            walk(items);

            const statsHtml = `
                <div class="stats-bar">
                    <div class="stat-item"><span class="stat-value">${totalFolders}</span><span class="stat-label">Folders</span></div>
                    <div class="stat-item"><span class="stat-value">${totalFiles}</span><span class="stat-label">CSV Files</span></div>
                    <div class="stat-item"><span class="stat-value">${totalRecords.toLocaleString()}</span><span class="stat-label">Total Records</span></div>
                </div>
            `;
            const panel = document.getElementById('content-panel');
            panel.insertAdjacentHTML('afterbegin', statsHtml);
        }

        // ── Search/Filter ─────────────────────────────────────────
        document.getElementById('tree-search').addEventListener('input', function() {
            const term = this.value.toLowerCase().trim();
            document.querySelectorAll('.tree-folder-wrapper, .tree-item[data-name]').forEach(el => {
                const name = (el.dataset.name || '').toLowerCase();
                if (!term) {
                    el.style.display = '';
                } else {
                    el.style.display = name.includes(term) ? '' : 'none';
                }
            });
            // If filtering, expand all
            if (term) {
                document.querySelectorAll('.tree-children').forEach(c => c.classList.add('open'));
                document.querySelectorAll('.chevron').forEach(c => c.classList.add('open'));
            }
        });

        // ── Init ──────────────────────────────────────────────────
        loadTree();
    })();
    </script>
</body>
</html>
