<?php
// Universal Dataset Search Engine
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Universal Search</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .search-container { max-width: 1400px; margin: 0 auto; }
        
        /* Layout */
        .search-grid {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 1.5rem;
            align-items: start;
        }
        @media (max-width: 1024px) {
            .search-grid { grid-template-columns: 1fr; }
        }

        /* Sidebar / Filters */
        .filter-panel {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 1.5rem;
            position: sticky;
            top: 2rem;
        }
        .filter-panel h3 { font-size: 1.1rem; margin-bottom: 1rem; color: #fff; }
        
        .form-group { margin-bottom: 1rem; }
        .form-group label {
            display: block; font-size: 0.78rem; text-transform: uppercase;
            letter-spacing: 0.06em; color: var(--text-muted);
            margin-bottom: 0.35rem; font-weight: 600;
        }
        .form-group input, .form-group select {
            width: 100%; padding: 0.65rem 0.85rem;
            background: rgba(255,255,255,0.05); border: 1px solid var(--border-color);
            border-radius: 0.5rem; color: var(--text-color); font-size: 0.88rem;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none; border-color: var(--primary-color);
            background: rgba(255,255,255,0.08);
        }

        .filter-divider {
            height: 1px; background: rgba(255,255,255,0.1);
            margin: 1.5rem 0;
        }

        /* Results Area */
        .results-panel {
            background: rgba(30,41,59,0.5);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            overflow: hidden;
            display: flex; flex-direction: column;
            min-height: 500px;
        }
        
        .results-header {
            padding: 1rem 1.5rem;
            background: rgba(15,23,42,0.8);
            border-bottom: 1px solid var(--border-color);
            display: flex; justify-content: space-between; align-items: center;
        }
        .results-stats { font-size: 0.9rem; color: var(--text-muted); }
        
        .action-btn {
            display: inline-flex; align-items: center; gap: 0.4rem;
            padding: 0.5rem 1rem; border-radius: 0.5rem;
            font-size: 0.8rem; font-weight: 600; border: none;
            cursor: pointer; transition: all 0.2s;
            text-decoration: none;
        }
        .action-btn.primary { background: var(--primary-color); color: #fff; }
        .action-btn.primary:hover { background: var(--primary-hover); }
        .action-btn.secondary { background: rgba(255,255,255,0.05); color: var(--text-color); border: 1px solid var(--border-color); }
        .action-btn.secondary:hover { background: rgba(255,255,255,0.1); }

        /* Table */
        .table-wrap { overflow-x: auto; flex: 1; }
        .data-table { width: 100%; border-collapse: collapse; font-size: 0.85rem; }
        .data-table th {
            background: rgba(15,23,42,0.9); padding: 0.75rem 1rem;
            text-align: left; font-size: 0.72rem; text-transform: uppercase;
            letter-spacing: 0.05em; color: #a5b4fc;
            border-bottom: 2px solid var(--border-color);
            position: sticky; top: 0; z-index: 10;
            cursor: pointer;
            white-space: nowrap;
        }
        .data-table th:hover { background: rgba(99,102,241,0.2); }
        .data-table td {
            padding: 0.6rem 1rem;
            border-bottom: 1px solid rgba(255,255,255,0.04);
            white-space: nowrap; max-width: 300px;
            overflow: hidden; text-overflow: ellipsis;
        }
        .data-table tr:hover td { background: rgba(99,102,241,0.05); }

        /* Loader */
        .loader-wrap {
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            padding: 3rem; color: var(--text-muted);
        }
        .loader {
            border: 3px solid rgba(255,255,255,0.1); border-top: 3px solid var(--primary-color);
            border-radius: 50%; width: 24px; height: 24px; animation: spin 1s linear infinite;
            margin-bottom: 1rem;
        }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        .pagination { padding: 1rem 1.5rem; border-top: 1px solid var(--border-color); display: flex; gap: 0.5rem; justify-content: flex-end; }
        .page-btn { padding: 0.4rem 0.8rem; background: rgba(255,255,255,0.05); border: 1px solid var(--border-color); border-radius: 0.4rem; color: var(--text-color); cursor: pointer; font-size: 0.8rem; }
        .page-btn:hover:not(:disabled) { background: rgba(255,255,255,0.1); }
        .page-btn:disabled { opacity: 0.3; cursor: not-allowed; }
        .page-btn.active { background: var(--primary-color); border-color: var(--primary-color); }
    </style>
</head>
<body>
    <div class="container search-container">
        <header>
            <?php $active_page = 'search'; include 'header.php'; ?>
        </header>

        <main class="search-grid">
            <!-- Sidebar / Filters -->
            <aside class="filter-panel">
                <h3>🔍 Dataset Search</h3>
                
                <div class="form-group">
                    <label>Select Dataset</label>
                    <select id="dataset-select" onchange="onDatasetChange()">
                        <option value="">Loading datasets...</option>
                    </select>
                </div>

                <div id="dynamic-filters-wrap" style="display:none;">
                    <div class="filter-divider"></div>
                    
                    <div class="form-group">
                        <label>Global Search (Any Column)</label>
                        <input type="text" id="global-search" placeholder="Type to search..." onkeyup="debounceSearch()">
                    </div>
                    
                    <div id="column-filters">
                        <!-- Dynamic filters injected here -->
                    </div>
                </div>
            </aside>

            <!-- Results -->
            <section class="results-panel">
                <div class="results-header">
                    <div class="results-stats" id="results-stats">Select a dataset to begin search.</div>
                    <div style="display:flex; gap:0.5rem;">
                        <button class="action-btn secondary" onclick="clearFilters()" id="btn-clear" style="display:none;">Clear Filters</button>
                        <button class="action-btn primary" onclick="exportData()" id="btn-export" style="display:none;">⬇️ Export CSV</button>
                    </div>
                </div>
                
                <div class="table-wrap">
                    <table class="data-table" id="data-table">
                        <thead id="table-head"></thead>
                        <tbody id="table-body">
                            <tr><td style="text-align:center;padding:3rem;color:#64748b;border:none;">No dataset selected.</td></tr>
                        </tbody>
                    </table>
                </div>

                <div class="pagination" id="pagination" style="display:none;"></div>
            </section>
        </main>
    </div>

    <script>
    const API = 'api_datasets.php';
    const SEARCH_API = 'api_search.php';
    
    let currentHeaders = [];
    let state = {
        file: '',
        q: '',
        filters: {},
        page: 1,
        sort: '',
        sort_dir: 'asc'
    };
    let searchTimeout;

    // init
    document.addEventListener('DOMContentLoaded', () => {
        loadFileList();
        
        // Parse URL params
        const params = new URLSearchParams(window.location.search);
        if (params.has('file')) {
            state.file = params.get('file');
            state.q = params.get('q') || '';
            // Load filters from URL
            for (const [key, value] of params.entries()) {
                if (key.startsWith('f_') && value) {
                    state.filters[key.substring(2)] = value;
                }
            }
        }
    });

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
            const select = document.getElementById('dataset-select');
            select.innerHTML = '<option value="">— Choose a CSV —</option>' + 
                files.map(f => `<option value="${f}">${f}</option>`).join('');
                
            if (state.file && files.includes(state.file)) {
                select.value = state.file;
                onDatasetChange(true);
            }
        } catch(e) { console.error(e); }
    }

    async function onDatasetChange(fromUrl = false) {
        const file = document.getElementById('dataset-select').value;
        if (!file) {
            document.getElementById('dynamic-filters-wrap').style.display = 'none';
            document.getElementById('btn-export').style.display = 'none';
            document.getElementById('btn-clear').style.display = 'none';
            document.getElementById('table-head').innerHTML = '';
            document.getElementById('table-body').innerHTML = '<tr><td style="text-align:center;padding:3rem;color:#64748b;">No dataset selected.</td></tr>';
            document.getElementById('results-stats').textContent = 'Select a dataset to begin search.';
            document.getElementById('pagination').style.display = 'none';
            return;
        }

        if (!fromUrl) {
            state = { file, q: '', filters: {}, page: 1, sort: '', sort_dir: 'asc' };
            document.getElementById('global-search').value = '';
            updateUrl();
        }

        document.getElementById('dynamic-filters-wrap').style.display = 'block';
        document.getElementById('btn-export').style.display = 'inline-flex';
        document.getElementById('btn-clear').style.display = 'inline-flex';
        
        await fetchHeaders();
        doSearch();
    }

    async function fetchHeaders() {
        try {
            const res = await fetch(`${SEARCH_API}?action=headers&file=${encodeURIComponent(state.file)}`);
            const data = await res.json();
            if (data.error) return;
            currentHeaders = data.headers;
            buildFilterUI();
            buildTableHeaders();
        } catch(e) {}
    }

    function buildFilterUI() {
        const wrap = document.getElementById('column-filters');
        let html = '';
        
        // Only create explicit filters for up to 5 interesting looking columns to avoid clutter
        // Simple heuristic: avoid ID, timestamp, lat/lon
        const filterCols = currentHeaders.filter(h => {
            const hl = h.toLowerCase();
            return !hl.includes('id') && !hl.includes('lat') && !hl.includes('lon') && !hl.includes('time') && !hl.includes('url');
        }).slice(0, 5);

        filterCols.forEach(col => {
            const val = state.filters[col] || '';
            html += `
            <div class="form-group">
                <label>${escHtml(col)}</label>
                <input type="text" class="col-filter" data-col="${escHtml(col)}" value="${escHtml(val)}" placeholder="Filter ${escHtml(col)}..." onkeyup="debounceSearch()">
            </div>`;
        });
        
        wrap.innerHTML = html;
        if (!fromUrl) document.getElementById('global-search').value = state.q;
    }

    function buildTableHeaders() {
        const tr = document.createElement('tr');
        currentHeaders.forEach(col => {
            const th = document.createElement('th');
            th.textContent = col;
            
            // Add sort indicator if active
            if (state.sort === col) {
                th.textContent += state.sort_dir === 'asc' ? ' ▴' : ' ▾';
            }
            
            th.onclick = () => {
                if (state.sort === col) {
                    state.sort_dir = state.sort_dir === 'asc' ? 'desc' : 'asc';
                } else {
                    state.sort = col;
                    state.sort_dir = 'asc';
                }
                doSearch();
            };
            tr.appendChild(th);
        });
        document.getElementById('table-head').innerHTML = '';
        document.getElementById('table-head').appendChild(tr);
    }

    function debounceSearch() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            state.q = document.getElementById('global-search').value.trim();
            state.filters = {};
            document.querySelectorAll('.col-filter').forEach(inp => {
                const val = inp.value.trim();
                if (val) state.filters[inp.getAttribute('data-col')] = val;
            });
            state.page = 1;
            doSearch();
        }, 300);
    }

    function clearFilters() {
        state.q = '';
        state.filters = {};
        state.page = 1;
        document.getElementById('global-search').value = '';
        document.querySelectorAll('.col-filter').forEach(inp => inp.value = '');
        doSearch();
    }

    async function doSearch() {
        updateUrl();
        document.getElementById('table-body').innerHTML = `<tr><td colspan="${currentHeaders.length}"><div class="loader-wrap"><div class="loader"></div>Searching...</div></td></tr>`;
        
        let url = `${SEARCH_API}?action=search&file=${encodeURIComponent(state.file)}&page=${state.page}&q=${encodeURIComponent(state.q)}`;
        if (state.sort) url += `&sort=${encodeURIComponent(state.sort)}&sort_dir=${state.sort_dir}`;
        
        for (const [col, val] of Object.entries(state.filters)) {
            url += `&filters[${encodeURIComponent(col)}]=${encodeURIComponent(val)}`;
        }

        try {
            const res = await fetch(url);
            const data = await res.json();
            
            if (data.error) {
                document.getElementById('table-body').innerHTML = `<tr><td colspan="${currentHeaders.length}" style="color:#ef4444;text-align:center;padding:2rem;">Error: ${escHtml(data.error)}</td></tr>`;
                return;
            }

            renderResults(data);
            renderPagination(data);
            buildTableHeaders(); // update sort arrows
        } catch(e) {
            document.getElementById('table-body').innerHTML = `<tr><td colspan="${currentHeaders.length}" style="color:#ef4444;text-align:center;padding:2rem;">Search failed.</td></tr>`;
        }
    }

    function renderResults(data) {
        const tbody = document.getElementById('table-body');
        document.getElementById('results-stats').textContent = 
            `Found ${data.total.toLocaleString()} rows • Page ${data.page} of ${data.totalPages}`;

        if (data.rows.length === 0) {
            tbody.innerHTML = `<tr><td colspan="${currentHeaders.length}" style="text-align:center;padding:3rem;color:#64748b;">No matching records found.</td></tr>`;
            return;
        }

        tbody.innerHTML = data.rows.map(row => 
            '<tr>' + row.data.map((c, i) => {
                // If it looks like a URL, make it clickable and truncate
                if (c && (c.startsWith('http://') || c.startsWith('https://'))) {
                    return `<td><a href="${escHtml(c)}" target="_blank" style="color:#60a5fa;text-decoration:none;" title="${escHtml(c)}">Link ↗</a></td>`;
                }
                return `<td title="${escHtml(c)}">${escHtml(c)}</td>`;
            }).join('') + '</tr>'
        ).join('');
    }

    function renderPagination(data) {
        const wrap = document.getElementById('pagination');
        if (data.totalPages <= 1) { wrap.style.display = 'none'; return; }
        
        wrap.style.display = 'flex';
        let html = '';
        
        html += `<button class="page-btn" ${data.page === 1 ? 'disabled' : ''} onclick="goToPage(${data.page - 1})">← Prev</button>`;
        
        // Show max 5 page buttons
        let start = Math.max(1, data.page - 2);
        let end = Math.min(data.totalPages, start + 4);
        if (end - start < 4) start = Math.max(1, end - 4);
        
        if (start > 1) html += `<button class="page-btn" onclick="goToPage(1)">1</button>${start > 2 ? '<span style="color:#64748b;padding:0.4rem;">...</span>' : ''}`;
        
        for (let i = start; i <= end; i++) {
            html += `<button class="page-btn ${i === data.page ? 'active' : ''}" onclick="goToPage(${i})">${i}</button>`;
        }
        
        if (end < data.totalPages) html += `${end < data.totalPages - 1 ? '<span style="color:#64748b;padding:0.4rem;">...</span>' : ''}<button class="page-btn" onclick="goToPage(${data.totalPages})">${data.totalPages}</button>`;
        
        html += `<button class="page-btn" ${data.page === data.totalPages ? 'disabled' : ''} onclick="goToPage(${data.page + 1})">Next →</button>`;
        
        wrap.innerHTML = html;
    }

    function goToPage(p) {
        state.page = p;
        doSearch();
        document.querySelector('.table-wrap').scrollTo(0,0);
    }

    function exportData() {
        let url = `${SEARCH_API}?action=export_filtered&file=${encodeURIComponent(state.file)}&q=${encodeURIComponent(state.q)}`;
        for (const [col, val] of Object.entries(state.filters)) {
            url += `&filters[${encodeURIComponent(col)}]=${encodeURIComponent(val)}`;
        }
        window.location.href = url;
    }

    function updateUrl() {
        const params = new URLSearchParams();
        if (state.file) params.set('file', state.file);
        if (state.q) params.set('q', state.q);
        for (const [col, val] of Object.entries(state.filters)) {
            params.set(`f_${col}`, val);
        }
        
        const newUrl = `${window.location.pathname}${params.toString() ? '?' + params.toString() : ''}`;
        window.history.replaceState({}, '', newUrl);
    }

    function escHtml(s) {
        if (s === null || s === undefined) return '';
        const d = document.createElement('div'); d.textContent = s; return d.innerHTML;
    }
    
    // allow variables to not be undefined
    let fromUrl = false;
    </script>
</body>
</html>
