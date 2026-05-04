<?php
// Aircraft Search
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Aircraft Search</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .search-container { max-width: 1400px; margin: 0 auto; }
        
        .hero {
            background: linear-gradient(to right, rgba(15,23,42,0.9), rgba(30,41,59,0.8)), url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0MDAiIGhlaWdodD0iNDAwIj48ZzBvcGFjaXR5PSIwLjAyIj48cGF0aCBkPSJNMTAwLDEwMCBoMjAwIHYyMDAgaC0yMDAgeiIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjEiLz48L2c+PC9zdmc+');
            background-size: cover; border-radius: 1rem; padding: 3rem 2rem; margin-bottom: 2rem;
            border: 1px solid var(--border-color); position: relative; overflow: hidden;
        }
        .hero::before {
            content: ''; position: absolute; top:0; left:0; right:0; bottom:0;
            background: radial-gradient(circle at top right, rgba(239,68,68,0.15), transparent 60%);
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
            border-radius: 0.5rem; color: var(--text-color); font-size: 0.88rem; transition: all 0.2s;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none; border-color: #ef4444; background: rgba(15,23,42,0.8);
            box-shadow: 0 0 0 2px rgba(239,68,68,0.2);
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
        
        .ac-card {
            display: flex; align-items: flex-start; gap: 1.5rem;
            padding: 1.25rem 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.05);
            transition: background 0.2s;
        }
        .ac-card:hover { background: rgba(239,68,68,0.05); }
        
        .ac-codes { display: flex; flex-direction: column; gap: 0.3rem; min-width: 65px; margin-top: 0.2rem; }
        .ac-code { background: rgba(255,255,255,0.1); padding: 0.15rem 0.4rem; border-radius: 0.25rem; font-size: 0.75rem; font-family: monospace; text-align: center; font-weight: 600;}
        .ac-iata { background: rgba(59,130,246,0.2); color: #93c5fd; border: 1px solid rgba(59,130,246,0.3); }
        .ac-icao { background: rgba(16,185,129,0.2); color: #6ee7b7; border: 1px solid rgba(16,185,129,0.3); }
        
        .ac-main { flex: 1; }
        .ac-title { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.4rem; }
        .ac-name { font-weight: 600; font-size: 1.1rem; }
        .ac-mfg { color: var(--text-muted); font-size: 0.9rem; margin-right: 0.5rem; }
        
        .ac-type { padding: 0.15rem 0.5rem; border-radius: 1rem; font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.05em; background: rgba(255,255,255,0.1); }
        
        .ac-details { font-size: 0.85rem; color: var(--text-muted); display: flex; flex-wrap: wrap; gap: 1rem; row-gap: 0.4rem; }
        .ac-pill { display: inline-flex; align-items: center; gap: 0.3rem; }

        .loader-wrap { padding: 4rem; text-align: center; color: var(--text-muted); }
        .loader { border: 3px solid rgba(255,255,255,0.1); border-top: 3px solid #ef4444; border-radius: 50%; width: 30px; height: 30px; animation: spin 1s linear infinite; margin: 0 auto 1rem auto; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        .pagination { padding: 1rem 1.5rem; border-top: 1px solid var(--border-color); display: flex; gap: 0.5rem; justify-content: center; }
        .page-btn { padding: 0.4rem 0.8rem; background: rgba(255,255,255,0.05); border: 1px solid var(--border-color); border-radius: 0.4rem; color: var(--text-color); cursor: pointer; }
        .page-btn:hover:not(:disabled) { background: rgba(255,255,255,0.1); }
        .page-btn.active { background: #ef4444; border-color: #ef4444; }
        .page-btn:disabled { opacity: 0.3; cursor: not-allowed; }
    </style>
</head>
<body>
    <div class="container search-container">
        <header>
            <?php $active_page = 'aircraft'; include 'header.php'; ?>
        </header>

        <div class="hero">
            <h2>🛩️ Global Aircraft Directory</h2>
            <p>Search aircraft types, manufacturer codes, and wake turbulence categories from the IATA/ICAO combined dataset.</p>
        </div>

        <main class="search-grid">
            <aside class="filter-panel">
                <div class="form-group">
                    <label>Manufacturer / Model / Name</label>
                    <input type="text" id="f-name" placeholder="e.g. Boeing 737" onkeyup="debounceSearch()">
                </div>
                
                <div style="display:grid; grid-template-columns: 1fr 1fr; gap:0.5rem;">
                    <div class="form-group">
                        <label>IATA</label>
                        <input type="text" id="f-iata" placeholder="e.g. 738" onkeyup="debounceSearch()" maxlength="3" style="text-transform:uppercase;">
                    </div>
                    <div class="form-group">
                        <label>ICAO</label>
                        <input type="text" id="f-icao" placeholder="e.g. B738" onkeyup="debounceSearch()" maxlength="4" style="text-transform:uppercase;">
                    </div>
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select id="f-status" onchange="doSearch()">
                        <option value="">Any Status</option>
                        <option value="In Service">In Service</option>
                        <option value="Out of Service">Out of Service</option>
                        <option value="Development">In Development</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Mission Type</label>
                    <select id="f-mission" onchange="doSearch()">
                        <option value="">Any Mission</option>
                        <option value="Passenger">Passenger</option>
                        <option value="Freighter">Freighter</option>
                        <option value="Combi">Combi</option>
                        <option value="Military">Military</option>
                        <option value="Business">Business</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Wake Turbulence (WTC)</label>
                    <select id="f-wtc" onchange="doSearch()">
                        <option value="">Any Category</option>
                        <option value="L">Light (L)</option>
                        <option value="M">Medium (M)</option>
                        <option value="H">Heavy (H)</option>
                        <option value="J">Super (J)</option>
                    </select>
                </div>

                <button class="action-btn" style="width:100%; justify-content:center; background:rgba(255,255,255,0.05); color:var(--text-color); border:1px solid var(--border-color); padding:0.6rem; border-radius:0.5rem; cursor:pointer;" onclick="clearFilters()">Reset Filters</button>
            </aside>

            <section class="results-panel">
                <div class="results-header">
                    <div id="results-count" style="font-weight:600; color:#fca5a5;">Searching...</div>
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
        document.getElementById('f-status').value = '';
        document.getElementById('f-mission').value = '';
        document.getElementById('f-wtc').value = '';
        state.page = 1;
        doSearch();
    }

    async function doSearch() {
        const body = document.getElementById('results-body');
        body.innerHTML = '<div class="loader-wrap"><div class="loader"></div>Searching aircraft databases...</div>';
        
        let url = `${SEARCH_API}?action=search&file=${encodeURIComponent('Global/Aircraft/aircraft_types.csv')}&page=${state.page}&per_page=30`;
        
        // Cols: IATA_Code, ICAO_Code, Manufacturer, Model, Full_Designation, Common_Name, Generation, Category, Mission_Type, WTC, Status
        const q = document.getElementById('f-name').value.trim();
        if (q) url += `&q=${encodeURIComponent(q)}`; 
        
        const iata = document.getElementById('f-iata').value.trim();
        if (iata) url += `&filters[IATA_Code]=${encodeURIComponent(iata)}`;
        
        const icao = document.getElementById('f-icao').value.trim();
        if (icao) url += `&filters[ICAO_Code]=${encodeURIComponent(icao)}`;
        
        const status = document.getElementById('f-status').value;
        if (status) url += `&filters[Status]=${encodeURIComponent(status)}`;
        
        const mission = document.getElementById('f-mission').value;
        if (mission) url += `&filters[Mission_Type]=${encodeURIComponent(mission)}`;
        
        const wtc = document.getElementById('f-wtc').value;
        if (wtc) url += `&filters[WTC]=${encodeURIComponent(wtc)}`;

        try {
            const res = await fetch(url);
            const data = await res.json();
            
            if (data.error) {
                body.innerHTML = `<div style="padding:3rem;text-align:center;color:#ef4444;">Error: ${escHtml(data.error)}</div>`;
                return;
            }

            document.getElementById('results-count').textContent = `${data.total.toLocaleString()} Aircraft Types Found`;
            renderResults(data);
            renderPagination(data);
        } catch(e) {
            body.innerHTML = '<div style="padding:3rem;text-align:center;color:#ef4444;">Search failed.</div>';
        }
    }

    function renderResults(data) {
        const body = document.getElementById('results-body');
        if (data.rows.length === 0) {
            body.innerHTML = '<div style="padding:4rem;text-align:center;color:#64748b;font-size:1.1rem;">No aircraft matched your filters.</div>';
            return;
        }

        const h = data.headers;
        const iIata = h.indexOf('IATA_Code');
        const iIcao = h.indexOf('ICAO_Code');
        const iMfg = h.indexOf('Manufacturer');
        const iModel = h.indexOf('Model');
        const iName = h.indexOf('Full_Designation');
        const iCategory = h.indexOf('Category');
        const iMission = h.indexOf('Mission_Type');
        const iWtc = h.indexOf('WTC');
        const iStatus = h.indexOf('Status');

        body.innerHTML = data.rows.map(row => {
            const d = row.data;
            const iata = d[iIata] || '--';
            const icao = d[iIcao] || '---';
            const mfg = d[iMfg] || 'Unknown';
            const name = d[iName] || d[iModel] || 'Unnamed Aircraft';
            const status = d[iStatus] || 'Unknown';
            
            let codes = '';
            codes += `<span class="ac-code ac-iata" title="IATA">${escHtml(iata)}</span>`;
            codes += `<span class="ac-code ac-icao" title="ICAO">${escHtml(icao)}</span>`;
            
            return `
            <div class="ac-card">
                <div class="ac-codes">${codes}</div>
                <div class="ac-main">
                    <div class="ac-title">
                        <span class="ac-mfg">${escHtml(mfg)}</span>
                        <span class="ac-name">${escHtml(name)}</span>
                        <span class="ac-type">${escHtml(status)}</span>
                    </div>
                    <div class="ac-details">
                        ${d[iMission] ? `<span class="ac-pill">🎯 ${escHtml(d[iMission])}</span>` : ''}
                        ${d[iCategory] ? `<span class="ac-pill">📏 Category ${escHtml(d[iCategory])}</span>` : ''}
                        ${d[iWtc] ? `<span class="ac-pill">💨 WTC: ${escHtml(d[iWtc])}</span>` : ''}
                    </div>
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
