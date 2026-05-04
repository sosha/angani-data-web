<?php
// Airline Search
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Airlines Search</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .search-container { max-width: 1400px; margin: 0 auto; }
        
        .hero {
            background: linear-gradient(to right, rgba(15,23,42,0.9), rgba(30,41,59,0.8)), url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0MDAiIGhlaWdodD0iNDAwIj48ZzBvcGFjaXR5PSIwLjAyIj48cGF0aCBkPSJNMTAwLDEwMCBoMjAwIHYyMDAgaC0yMDAgeiIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjEiLz48L2c+PC9zdmc+');
            background-size: cover;
            border-radius: 1rem;
            padding: 3rem 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
            position: relative; overflow: hidden;
        }
        .hero::before {
            content: ''; position: absolute; top:0; left:0; right:0; bottom:0;
            background: radial-gradient(circle at top right, rgba(99,102,241,0.15), transparent 60%);
        }
        .hero h2 { font-size: 2.2rem; margin-bottom: 0.5rem; position: relative; }
        .hero p { color: var(--text-muted); font-size: 1.1rem; max-width: 600px; position: relative; }

        .search-grid { display: grid; grid-template-columns: 320px 1fr; gap: 1.5rem; align-items: start; }
        @media (max-width: 1024px) { .search-grid { grid-template-columns: 1fr; } }

        .filter-panel {
            background: var(--card-bg); border: 1px solid var(--border-color);
            border-radius: 1rem; padding: 1.5rem; position: sticky; top: 2rem;
        }
        
        .form-group { margin-bottom: 1.25rem; }
        .form-group label {
            display: block; font-size: 0.78rem; text-transform: uppercase;
            letter-spacing: 0.06em; color: var(--text-muted); margin-bottom: 0.4rem; font-weight: 600;
        }
        .form-group input, .form-group select {
            width: 100%; padding: 0.7rem 0.85rem;
            background: rgba(15,23,42,0.6); border: 1px solid var(--border-color);
            border-radius: 0.5rem; color: var(--text-color); font-size: 0.88rem;
            transition: all 0.2s;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none; border-color: var(--primary-color); background: rgba(15,23,42,0.8);
            box-shadow: 0 0 0 2px rgba(99,102,241,0.2);
        }

        .results-panel {
            background: var(--card-bg); border: 1px solid var(--border-color);
            border-radius: 1rem; overflow: hidden; display: flex; flex-direction: column; min-height: 500px;
        }
        
        .results-header {
            padding: 1.25rem 1.5rem; background: rgba(15,23,42,0.8);
            border-bottom: 1px solid var(--border-color);
            display: flex; justify-content: space-between; align-items: center;
        }
        
        .airline-card {
            display: flex; align-items: center; gap: 1.5rem;
            padding: 1rem 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.05);
            transition: background 0.2s;
        }
        .airline-card:hover { background: rgba(99,102,241,0.05); }
        .ac-codes { display: flex; flex-direction: column; gap: 0.2rem; min-width: 60px; }
        .ac-code { background: rgba(255,255,255,0.1); padding: 0.1rem 0.4rem; border-radius: 0.25rem; font-size: 0.7rem; font-family: monospace; text-align: center; }
        .ac-iata { background: rgba(59,130,246,0.2); color: #93c5fd; }
        .ac-icao { background: rgba(16,185,129,0.2); color: #6ee7b7; }
        .ac-main { flex: 1; }
        .ac-name { font-weight: 600; font-size: 1.05rem; margin-bottom: 0.2rem; }
        .ac-details { font-size: 0.8rem; color: var(--text-muted); display: flex; gap: 1rem; }
        .ac-status { padding: 0.2rem 0.6rem; border-radius: 1rem; font-size: 0.72rem; font-weight: 700; text-transform: uppercase; }
        .status-y { background: rgba(16,185,129,0.15); color: #10b981; border: 1px solid rgba(16,185,129,0.3); }
        .status-n { background: rgba(239,68,68,0.15); color: #ef4444; border: 1px solid rgba(239,68,68,0.3); }

        .loader-wrap { padding: 4rem; text-align: center; color: var(--text-muted); }
        .loader { border: 3px solid rgba(255,255,255,0.1); border-top: 3px solid var(--primary-color); border-radius: 50%; width: 30px; height: 30px; animation: spin 1s linear infinite; margin: 0 auto 1rem auto; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        .pagination { padding: 1rem 1.5rem; border-top: 1px solid var(--border-color); display: flex; gap: 0.5rem; justify-content: center; }
        .page-btn { padding: 0.4rem 0.8rem; background: rgba(255,255,255,0.05); border: 1px solid var(--border-color); border-radius: 0.4rem; color: var(--text-color); cursor: pointer; }
        .page-btn:hover:not(:disabled) { background: rgba(255,255,255,0.1); }
        .page-btn.active { background: var(--primary-color); border-color: var(--primary-color); }
        .page-btn:disabled { opacity: 0.3; cursor: not-allowed; }
    </style>
</head>
<body>
    <div class="container search-container">
        <header>
            <?php $active_page = 'airlines'; include 'header.php'; ?>
        </header>

        <div class="hero">
            <h2>✈️ Global Airlines Directory</h2>
            <p>Search across all active and defunct commercial operators globally. Data is aggregated from the unified AnganiData master dataset.</p>
        </div>

        <main class="search-grid">
            <!-- Sidebar / Filters -->
            <aside class="filter-panel">
                <div class="form-group">
                    <label>Airline Name</label>
                    <input type="text" id="f-name" placeholder="e.g. Kenya Airways" onkeyup="debounceSearch()">
                </div>
                
                <div style="display:grid; grid-template-columns: 1fr 1fr; gap:0.5rem;">
                    <div class="form-group">
                        <label>IATA</label>
                        <input type="text" id="f-iata" placeholder="e.g. KQ" onkeyup="debounceSearch()" maxlength="2" style="text-transform:uppercase;">
                    </div>
                    <div class="form-group">
                        <label>ICAO</label>
                        <input type="text" id="f-icao" placeholder="e.g. KQA" onkeyup="debounceSearch()" maxlength="3" style="text-transform:uppercase;">
                    </div>
                </div>

                <div class="form-group">
                    <label>Country / Region</label>
                    <input type="text" id="f-country" placeholder="e.g. KE" onkeyup="debounceSearch()" maxlength="2" style="text-transform:uppercase;">
                </div>

                <div class="form-group">
                    <label>Operating Status</label>
                    <select id="f-status" onchange="doSearch()">
                        <option value="">Any Status</option>
                        <option value="Y">Active (Y)</option>
                        <option value="N">Defunct (N)</option>
                        <option value="Unknown">Unknown</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Alliance</label>
                    <select id="f-alliance" onchange="doSearch()">
                        <option value="">Any Alliance</option>
                        <option value="SkyTeam">SkyTeam</option>
                        <option value="Star Alliance">Star Alliance</option>
                        <option value="Oneworld">Oneworld</option>
                    </select>
                </div>

                <button class="action-btn" style="width:100%; justify-content:center; background:rgba(255,255,255,0.05); color:var(--text-color); border:1px solid var(--border-color); padding:0.6rem; border-radius:0.5rem; cursor:pointer;" onclick="clearFilters()">Reset Filters</button>
            </aside>

            <!-- Results -->
            <section class="results-panel">
                <div class="results-header">
                    <div id="results-count" style="font-weight:600; color:#a5b4fc;">Searching...</div>
                </div>
                
                <div id="results-body" style="flex:1;">
                    <!-- Results injected here -->
                </div>

                <div class="pagination" id="pagination" style="display:none;"></div>
            </section>
        </main>
    </div>

    <script>
    const SEARCH_API = 'api_search.php';
    let state = { page: 1 };
    let searchTimeout;

    document.addEventListener('DOMContentLoaded', doSearch);

    function debounceSearch() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => { state.page = 1; doSearch(); }, 300);
    }

    function clearFilters() {
        document.getElementById('f-name').value = '';
        document.getElementById('f-iata').value = '';
        document.getElementById('f-icao').value = '';
        document.getElementById('f-country').value = '';
        document.getElementById('f-status').value = '';
        document.getElementById('f-alliance').value = '';
        state.page = 1;
        doSearch();
    }

    async function doSearch() {
        const body = document.getElementById('results-body');
        body.innerHTML = '<div class="loader-wrap"><div class="loader"></div>Searching global datasets...</div>';
        
        let url = `${SEARCH_API}?action=search_multi&pattern=${encodeURIComponent('Global/Airlines/airlines.csv')}&page=${state.page}&per_page=30`;
        
        // In the Global dataset, cols are: IATA, ICAO, Airline, Call sign, Country/Region, Comments, Alias, Active, Hubs, Fleet Size, Alliance, Frequent Flyer Program, Website, Logo
        const name = document.getElementById('f-name').value.trim();
        if (name) url += `&filters[Airline]=${encodeURIComponent(name)}`;
        
        const iata = document.getElementById('f-iata').value.trim();
        if (iata) url += `&filters[IATA]=${encodeURIComponent(iata)}`;
        
        const icao = document.getElementById('f-icao').value.trim();
        if (icao) url += `&filters[ICAO]=${encodeURIComponent(icao)}`;
        
        const country = document.getElementById('f-country').value.trim();
        if (country) url += `&filters[Country/Region]=${encodeURIComponent(country)}`;
        
        const status = document.getElementById('f-status').value;
        if (status) url += `&filters[Active]=${encodeURIComponent(status === 'Unknown' ? '-' : status)}`;
        
        const alliance = document.getElementById('f-alliance').value;
        if (alliance) url += `&filters[Alliance]=${encodeURIComponent(alliance)}`;

        try {
            const res = await fetch(url);
            const data = await res.json();
            
            if (data.error) {
                body.innerHTML = `<div style="padding:3rem;text-align:center;color:#ef4444;">Error: ${escHtml(data.error)}</div>`;
                return;
            }

            document.getElementById('results-count').textContent = `${data.total.toLocaleString()} Airlines Found`;
            renderResults(data);
            renderPagination(data);
        } catch(e) {
            body.innerHTML = '<div style="padding:3rem;text-align:center;color:#ef4444;">Search failed.</div>';
        }
    }

    function renderResults(data) {
        const body = document.getElementById('results-body');
        if (data.rows.length === 0) {
            body.innerHTML = '<div style="padding:4rem;text-align:center;color:#64748b;font-size:1.1rem;">No airlines matched your filters.</div>';
            return;
        }

        const h = data.headers;
        const iIATA = h.indexOf('IATA'), iICAO = h.indexOf('ICAO'), iName = h.indexOf('Airline');
        const iCall = h.indexOf('Call sign'), iCountry = h.indexOf('Country/Region'), iActive = h.indexOf('Active');
        const iAlliance = h.indexOf('Alliance'), iHubs = h.indexOf('Hubs');

        body.innerHTML = data.rows.map(row => {
            const d = row.data;
            const iata = d[iIATA] || '--';
            const icao = d[iICAO] || '---';
            const isActive = (d[iActive]||'').toUpperCase() === 'Y';
            const statusClass = isActive ? 'status-y' : 'status-n';
            const statusText = isActive ? 'Active' : 'Defunct';
            
            return `
            <div class="airline-card">
                <div class="ac-codes">
                    <span class="ac-code ac-iata" title="IATA Code">${escHtml(iata)}</span>
                    <span class="ac-code ac-icao" title="ICAO Code">${escHtml(icao)}</span>
                </div>
                <div class="ac-main">
                    <div class="ac-name">${escHtml(d[iName])}</div>
                    <div class="ac-details">
                        <span>🌍 ${escHtml(d[iCountry])}</span>
                        ${d[iCall] ? `<span>🎙️ Callsign: ${escHtml(d[iCall])}</span>` : ''}
                        ${d[iHubs] ? `<span>📍 Hubs: ${escHtml(d[iHubs])}</span>` : ''}
                        ${d[iAlliance] ? `<span>🤝 ${escHtml(d[iAlliance])}</span>` : ''}
                    </div>
                </div>
                <div>
                    <span class="ac-status ${statusClass}">${statusText}</span>
                </div>
            </div>`;
        }).join('');
    }

    function renderPagination(data) {
        const wrap = document.getElementById('pagination');
        if (data.totalPages <= 1) { wrap.style.display = 'none'; return; }
        
        wrap.style.display = 'flex';
        let html = '';
        
        if (data.page > 1) html += `<button class="page-btn" onclick="goToPage(${data.page - 1})">Prev</button>`;
        
        let start = Math.max(1, data.page - 2);
        let end = Math.min(data.totalPages, start + 4);
        if (end - start < 4) start = Math.max(1, end - 4);
        
        for (let i = start; i <= end; i++) {
            html += `<button class="page-btn ${i === data.page ? 'active' : ''}" onclick="goToPage(${i})">${i}</button>`;
        }
        
        if (data.page < data.totalPages) html += `<button class="page-btn" onclick="goToPage(${data.page + 1})">Next</button>`;
        wrap.innerHTML = html;
    }

    function goToPage(p) { state.page = p; doSearch(); window.scrollTo({top: 0, behavior: 'smooth'}); }
    function escHtml(s) { if (!s) return ''; const d = document.createElement('div'); d.textContent = s; return d.innerHTML; }
    </script>
</body>
</html>
