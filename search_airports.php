<?php
// Airport Search
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Airports Search</title>
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
            background: radial-gradient(circle at top right, rgba(16,185,129,0.15), transparent 60%);
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
            outline: none; border-color: #10b981; background: rgba(15,23,42,0.8);
            box-shadow: 0 0 0 2px rgba(16,185,129,0.2);
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
        
        .apt-card {
            display: flex; align-items: flex-start; gap: 1.5rem;
            padding: 1.25rem 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.05);
            transition: background 0.2s;
        }
        .apt-card:hover { background: rgba(16,185,129,0.05); }
        .apt-codes { display: flex; flex-direction: column; gap: 0.3rem; min-width: 65px; margin-top: 0.2rem; }
        .apt-code { background: rgba(255,255,255,0.1); padding: 0.15rem 0.4rem; border-radius: 0.25rem; font-size: 0.75rem; font-family: monospace; text-align: center; font-weight: 600;}
        .apt-iata { background: rgba(139,92,246,0.2); color: #c4b5fd; border: 1px solid rgba(139,92,246,0.3); }
        .apt-icao { background: rgba(16,185,129,0.2); color: #6ee7b7; border: 1px solid rgba(16,185,129,0.3); }
        
        .apt-main { flex: 1; }
        .apt-title { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.4rem; }
        .apt-name { font-weight: 600; font-size: 1.1rem; }
        .apt-type { padding: 0.15rem 0.5rem; border-radius: 1rem; font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.05em; background: rgba(255,255,255,0.1); }
        .type-large_airport { background: rgba(59,130,246,0.2); color: #93c5fd; }
        .type-medium_airport { background: rgba(245,158,11,0.2); color: #fcd34d; }
        .type-small_airport { background: rgba(100,116,139,0.2); color: #cbd5e1; }
        
        .apt-details { font-size: 0.85rem; color: var(--text-muted); display: flex; flex-wrap: wrap; gap: 1rem; row-gap: 0.4rem; }
        .apt-pill { display: inline-flex; align-items: center; gap: 0.3rem; }

        .loader-wrap { padding: 4rem; text-align: center; color: var(--text-muted); }
        .loader { border: 3px solid rgba(255,255,255,0.1); border-top: 3px solid #10b981; border-radius: 50%; width: 30px; height: 30px; animation: spin 1s linear infinite; margin: 0 auto 1rem auto; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        .pagination { padding: 1rem 1.5rem; border-top: 1px solid var(--border-color); display: flex; gap: 0.5rem; justify-content: center; }
        .page-btn { padding: 0.4rem 0.8rem; background: rgba(255,255,255,0.05); border: 1px solid var(--border-color); border-radius: 0.4rem; color: var(--text-color); cursor: pointer; }
        .page-btn:hover:not(:disabled) { background: rgba(255,255,255,0.1); }
        .page-btn.active { background: #10b981; border-color: #10b981; }
        .page-btn:disabled { opacity: 0.3; cursor: not-allowed; }
    </style>
</head>
<body>
    <div class="container search-container">
        <header>
            <?php $active_page = 'airports'; include 'header.php'; ?>
        </header>

        <div class="hero">
            <h2>🏢 Global Airports Directory</h2>
            <p>Search over 85,000 global airports, heliports, and seaplane bases. Integrated with our Wikipedia data enhancements.</p>
        </div>

        <main class="search-grid">
            <aside class="filter-panel">
                <div class="form-group">
                    <label>Airport Name/City</label>
                    <input type="text" id="f-name" placeholder="e.g. Heathrow" onkeyup="debounceSearch()">
                </div>
                
                <div style="display:grid; grid-template-columns: 1fr 1fr; gap:0.5rem;">
                    <div class="form-group">
                        <label>IATA</label>
                        <input type="text" id="f-iata" placeholder="e.g. LHR" onkeyup="debounceSearch()" maxlength="3" style="text-transform:uppercase;">
                    </div>
                    <div class="form-group">
                        <label>ICAO / Ident</label>
                        <input type="text" id="f-icao" placeholder="e.g. EGLL" onkeyup="debounceSearch()" maxlength="7" style="text-transform:uppercase;">
                    </div>
                </div>

                <div class="form-group">
                    <label>ISO Country</label>
                    <input type="text" id="f-country" placeholder="e.g. GB" onkeyup="debounceSearch()" maxlength="2" style="text-transform:uppercase;">
                </div>

                <div class="form-group">
                    <label>Airport Type</label>
                    <select id="f-type" onchange="doSearch()">
                        <option value="">Any Type</option>
                        <option value="large_airport">Large Airport</option>
                        <option value="medium_airport">Medium Airport</option>
                        <option value="small_airport">Small Airport</option>
                        <option value="heliport">Heliport</option>
                        <option value="seaplane_base">Seaplane Base</option>
                        <option value="closed">Closed / Abandoned</option>
                    </select>
                </div>

                <button class="action-btn" style="width:100%; justify-content:center; background:rgba(255,255,255,0.05); color:var(--text-color); border:1px solid var(--border-color); padding:0.6rem; border-radius:0.5rem; cursor:pointer;" onclick="clearFilters()">Reset Filters</button>
            </aside>

            <section class="results-panel">
                <div class="results-header">
                    <div id="results-count" style="font-weight:600; color:#6ee7b7;">Searching...</div>
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
        document.getElementById('f-type').value = '';
        state.page = 1;
        doSearch();
    }

    async function doSearch() {
        const body = document.getElementById('results-body');
        body.innerHTML = '<div class="loader-wrap"><div class="loader"></div>Searching 85,000+ airports...</div>';
        
        let url = `${SEARCH_API}?action=search_multi&pattern=${encodeURIComponent('Countries/*/airports/airports.csv')}&page=${state.page}&per_page=30`;
        
        // Airports dataset cols (from our earlier check): 
        // id, ident, type, name, latitude_deg, longitude_deg, elevation_ft, continent, iso_country, iso_region, municipality, scheduled_service, gps_code, iata_code, local_code, home_link, wikipedia_link, keywords
        
        const q = document.getElementById('f-name').value.trim();
        if (q) url += `&q=${encodeURIComponent(q)}`; // Use global search for name/city combination
        
        const iata = document.getElementById('f-iata').value.trim();
        if (iata) url += `&filters[iata_code]=${encodeURIComponent(iata)}`;
        
        const icao = document.getElementById('f-icao').value.trim();
        if (icao) url += `&filters[ident]=${encodeURIComponent(icao)}`;
        
        const country = document.getElementById('f-country').value.trim();
        if (country) url += `&filters[iso_country]=${encodeURIComponent(country)}`;
        
        const type = document.getElementById('f-type').value;
        if (type) url += `&filters[type]=${encodeURIComponent(type)}`;

        try {
            const res = await fetch(url);
            const data = await res.json();
            
            if (data.error) {
                body.innerHTML = `<div style="padding:3rem;text-align:center;color:#ef4444;">Error: ${escHtml(data.error)}</div>`;
                return;
            }

            document.getElementById('results-count').textContent = `${data.total.toLocaleString()} Airports Found`;
            renderResults(data);
            renderPagination(data);
        } catch(e) {
            body.innerHTML = '<div style="padding:3rem;text-align:center;color:#ef4444;">Search failed.</div>';
        }
    }

    function renderResults(data) {
        const body = document.getElementById('results-body');
        if (data.rows.length === 0) {
            body.innerHTML = '<div style="padding:4rem;text-align:center;color:#64748b;font-size:1.1rem;">No airports matched your filters.</div>';
            return;
        }

        const h = data.headers;
        const iIdent = h.indexOf('ident');
        const iIata = h.indexOf('iata_code');
        const iType = h.indexOf('type');
        const iName = h.indexOf('name');
        const iCity = h.indexOf('municipality');
        const iCountry = h.indexOf('iso_country');
        const iElev = h.indexOf('elevation_ft');
        const iLat = h.indexOf('latitude_deg');
        const iLon = h.indexOf('longitude_deg');

        body.innerHTML = data.rows.map(row => {
            const d = row.data;
            const iata = d[iIata] || '';
            const ident = d[iIdent] || '---';
            const type = d[iType] || 'unknown';
            const name = d[iName] || 'Unnamed';
            
            let codes = '';
            if (iata) codes += `<span class="apt-code apt-iata" title="IATA">${escHtml(iata)}</span>`;
            codes += `<span class="apt-code apt-icao" title="Ident/ICAO">${escHtml(ident)}</span>`;
            
            return `
            <div class="apt-card">
                <div class="apt-codes">${codes}</div>
                <div class="apt-main">
                    <div class="apt-title">
                        <span class="apt-name">${escHtml(name)}</span>
                        <span class="apt-type type-${escHtml(type)}">${escHtml(type.replace('_',' '))}</span>
                    </div>
                    <div class="apt-details">
                        <span class="apt-pill">📍 ${escHtml(d[iCity] || 'Unknown City')}, ${escHtml(d[iCountry])}</span>
                        ${d[iElev] ? `<span class="apt-pill">⛰️ ${escHtml(d[iElev])} ft</span>` : ''}
                        ${d[iLat] && d[iLon] ? `<span class="apt-pill" style="font-family:monospace;">🌐 ${parseFloat(d[iLat]).toFixed(4)}, ${parseFloat(d[iLon]).toFixed(4)}</span>` : ''}
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
