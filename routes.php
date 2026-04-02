<?php
// Airport Route Visualizer
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Route Visualizer</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>
        /* ── Layout ─────────────────────────────────────────────── */
        .viz-layout {
            display: grid;
            grid-template-columns: 420px 1fr;
            gap: 0;
            min-height: calc(100vh - 140px);
            border-radius: 1rem;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        /* ── Control Panel (Left) ───────────────────────────────── */
        .control-panel {
            background: rgba(15, 23, 42, 0.95);
            border-right: 1px solid var(--border-color);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }
        .panel-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            background: rgba(30, 41, 59, 0.5);
        }
        .panel-header h2 {
            margin: 0;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .panel-header p {
            margin: 0.5rem 0 0;
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .panel-body {
            padding: 1.5rem;
            flex: 1;
        }

        /* Airport selector */
        .airport-selector {
            margin-bottom: 1.5rem;
        }
        .selector-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
            font-weight: 600;
        }
        .selector-label .dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
        }
        .dot-origin { background: #10b981; }
        .dot-destination { background: #f59e0b; }

        .search-wrapper {
            position: relative;
        }
        .airport-search {
            width: 100%;
            padding: 0.75rem 1rem;
            padding-left: 2.5rem;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.6rem;
            color: var(--text-color);
            font-size: 0.9rem;
            transition: all 0.2s;
        }
        .airport-search:focus {
            outline: none;
            border-color: var(--primary-color);
            background: rgba(255,255,255,0.08);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.15);
        }
        .search-icon {
            position: absolute;
            left: 0.85rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 0.9rem;
            opacity: 0.5;
        }

        /* Search results dropdown */
        .search-results {
            display: none;
            position: absolute;
            top: calc(100% + 4px);
            left: 0; right: 0;
            background: #1e293b;
            border: 1px solid var(--border-color);
            border-radius: 0.6rem;
            max-height: 280px;
            overflow-y: auto;
            z-index: 100;
            box-shadow: 0 15px 40px rgba(0,0,0,0.4);
        }
        .search-results.visible { display: block; }
        .search-result-item {
            padding: 0.65rem 1rem;
            cursor: pointer;
            border-bottom: 1px solid rgba(255,255,255,0.04);
            transition: background 0.12s;
        }
        .search-result-item:hover { background: rgba(99,102,241,0.1); }
        .search-result-item:last-child { border-bottom: none; }
        .result-name {
            font-weight: 600;
            font-size: 0.88rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .result-name .iata-badge {
            background: rgba(99,102,241,0.2);
            color: #a5b4fc;
            padding: 0.1rem 0.4rem;
            border-radius: 4px;
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 0.05em;
        }
        .result-meta {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 0.15rem;
        }
        .result-type {
            font-size: 0.65rem;
            text-transform: uppercase;
            padding: 0.1rem 0.35rem;
            border-radius: 3px;
            font-weight: 600;
        }
        .type-large { background: rgba(16,185,129,0.15); color: #6ee7b7; }
        .type-medium { background: rgba(59,130,246,0.15); color: #93c5fd; }
        .type-small { background: rgba(148,163,184,0.15); color: #94a3b8; }

        /* Selected airport card */
        .selected-airport {
            display: none;
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid var(--border-color);
            border-radius: 0.6rem;
            padding: 1rem;
            margin-top: 0.5rem;
            animation: fadeSlideIn 0.25s ease-out;
        }
        .selected-airport.visible { display: block; }
        @keyframes fadeSlideIn {
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .selected-name {
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 0.35rem;
        }
        .selected-details {
            font-size: 0.78rem;
            color: var(--text-muted);
            line-height: 1.6;
        }
        .selected-details .detail-row {
            display: flex;
            justify-content: space-between;
        }
        .selected-details .detail-label { color: rgba(148,163,184,0.7); }
        .clear-btn {
            background: none;
            border: none;
            color: #f87171;
            cursor: pointer;
            font-size: 0.75rem;
            float: right;
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            transition: background 0.15s;
        }
        .clear-btn:hover { background: rgba(248,113,113,0.1); }

        /* Divider */
        .panel-divider {
            height: 1px;
            background: var(--border-color);
            margin: 1.25rem 0;
        }

        /* ── Route Info Card ────────────────────────────────────── */
        .route-info {
            display: none;
            animation: fadeSlideIn 0.3s ease-out;
        }
        .route-info.visible { display: block; }

        .route-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
            margin-bottom: 0.75rem;
            font-weight: 600;
        }

        .route-codes {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }
        .route-code {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: 0.05em;
        }
        .route-code.origin { color: #10b981; }
        .route-code.destination { color: #f59e0b; }
        .route-arrow {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.2rem;
        }
        .route-arrow .line {
            width: 60px;
            height: 2px;
            background: linear-gradient(90deg, #10b981, #f59e0b);
            border-radius: 1px;
        }
        .route-arrow .plane-icon { font-size: 1.2rem; }

        /* Stats grid */
        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.75rem;
        }
        .stat-card {
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid var(--border-color);
            border-radius: 0.6rem;
            padding: 1rem;
            text-align: center;
        }
        .stat-card.highlight {
            grid-column: 1 / -1;
            background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(139,92,246,0.1));
            border-color: rgba(99,102,241,0.3);
        }
        .stat-value {
            font-size: 1.6rem;
            font-weight: 800;
            background: linear-gradient(135deg, #818cf8, #c084fc);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.15rem;
        }
        .stat-card.highlight .stat-value {
            font-size: 2rem;
        }
        .stat-label {
            font-size: 0.68rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
        }
        .stat-sub {
            font-size: 0.72rem;
            color: rgba(148,163,184,0.6);
            margin-top: 0.15rem;
        }

        /* Action buttons */
        .route-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1.25rem;
        }
        .route-actions .action-btn {
            flex: 1;
            padding: 0.6rem;
            border-radius: 0.5rem;
            border: 1px solid var(--border-color);
            background: rgba(255,255,255,0.05);
            color: var(--text-color);
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 600;
            text-align: center;
            transition: all 0.15s;
        }
        .route-actions .action-btn:hover {
            background: rgba(255,255,255,0.1);
            border-color: var(--primary-color);
        }

        /* ── Map Panel (Right) ──────────────────────────────────── */
        .map-panel {
            position: relative;
        }
        #map {
            width: 100%;
            height: 100%;
            min-height: 600px;
        }

        /* Map overlay labels */
        .map-overlay {
            position: absolute;
            bottom: 1.5rem;
            left: 1.5rem;
            z-index: 800;
            display: flex;
            gap: 0.5rem;
            pointer-events: none;
        }
        .map-badge {
            padding: 0.4rem 0.8rem;
            background: rgba(15, 23, 42, 0.85);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            font-size: 0.75rem;
            font-weight: 600;
            backdrop-filter: blur(8px);
            color: var(--text-color);
        }

        /* Welcome state */
        .map-welcome {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 800;
            text-align: center;
            color: var(--text-muted);
            pointer-events: none;
        }
        .map-welcome.hidden { display: none; }
        .map-welcome .icon { font-size: 3rem; opacity: 0.4; margin-bottom: 0.5rem; }
        .map-welcome h3 { color: rgba(248,250,252,0.5); font-size: 1rem; }
        .map-welcome p { font-size: 0.82rem; }

        /* Leaflet popup custom */
        .leaflet-popup-content-wrapper {
            background: #1e293b !important;
            color: #f8fafc !important;
            border: 1px solid rgba(255,255,255,0.1) !important;
            border-radius: 0.6rem !important;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4) !important;
        }
        .leaflet-popup-tip { background: #1e293b !important; }
        .leaflet-popup-content {
            margin: 0.8rem 1rem !important;
            font-family: 'Inter', sans-serif !important;
        }
        .popup-name { font-weight: 700; font-size: 0.9rem; margin-bottom: 0.3rem; }
        .popup-code { color: #a5b4fc; font-size: 0.8rem; }
        .popup-meta { font-size: 0.75rem; color: #94a3b8; margin-top: 0.3rem; }

        /* Leaflet tiles darker */
        .leaflet-tile {
            filter: brightness(0.75) contrast(1.1) saturate(0.8);
        }

        /* Responsive */
        @media (max-width: 900px) {
            .viz-layout {
                grid-template-columns: 1fr;
                grid-template-rows: auto 1fr;
            }
            .control-panel { max-height: 50vh; }
        }
    </style>
</head>
<body>
    <div class="container" style="max-width: 1800px;">
        <header>
            <?php $active_page = 'routes'; include 'header.php'; ?>
        </header>

        <main>
            <div class="viz-layout">
                <!-- Left: Controls -->
                <div class="control-panel">
                    <div class="panel-header">
                        <h2>✈️ Route Visualizer</h2>
                        <p>Select two airports to visualize the route, distance, and estimated flight time.</p>
                    </div>

                    <div class="panel-body">
                        <!-- Origin Airport -->
                        <div class="airport-selector">
                            <div class="selector-label"><span class="dot dot-origin"></span> Origin Airport</div>
                            <div class="search-wrapper">
                                <span class="search-icon">🔍</span>
                                <input type="text" class="airport-search" id="origin-search" placeholder="Search by name, IATA, ICAO..." autocomplete="off">
                                <div class="search-results" id="origin-results"></div>
                            </div>
                            <div class="selected-airport" id="origin-card"></div>
                        </div>

                        <!-- Destination Airport -->
                        <div class="airport-selector">
                            <div class="selector-label"><span class="dot dot-destination"></span> Destination Airport</div>
                            <div class="search-wrapper">
                                <span class="search-icon">🔍</span>
                                <input type="text" class="airport-search" id="dest-search" placeholder="Search by name, IATA, ICAO..." autocomplete="off">
                                <div class="search-results" id="dest-results"></div>
                            </div>
                            <div class="selected-airport" id="dest-card"></div>
                        </div>

                        <div class="panel-divider"></div>

                        <!-- Route Info -->
                        <div class="route-info" id="route-info">
                            <div class="route-title">📐 Route Analysis</div>

                            <div class="route-codes">
                                <span class="route-code origin" id="code-origin">---</span>
                                <div class="route-arrow">
                                    <span class="plane-icon">✈️</span>
                                    <div class="line"></div>
                                </div>
                                <span class="route-code destination" id="code-dest">---</span>
                            </div>

                            <div class="stats-grid">
                                <div class="stat-card highlight">
                                    <div class="stat-value" id="stat-distance">—</div>
                                    <div class="stat-label">Great Circle Distance</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-value" id="stat-distance-mi">—</div>
                                    <div class="stat-label">Distance (mi)</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-value" id="stat-distance-nm">—</div>
                                    <div class="stat-label">Distance (nm)</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-value" id="stat-flight-time">—</div>
                                    <div class="stat-label">Est. Flight Time</div>
                                    <div class="stat-sub" id="stat-speed-info"></div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-value" id="stat-bearing">—</div>
                                    <div class="stat-label">Initial Bearing</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-value" id="stat-elev-diff">—</div>
                                    <div class="stat-label">Elevation Diff</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-value" id="stat-midpoint">—</div>
                                    <div class="stat-label">Midpoint Coords</div>
                                    <div class="stat-sub" id="stat-midpoint-sub"></div>
                                </div>
                            </div>

                            <div class="route-actions">
                                <button class="action-btn" onclick="swapAirports()">🔄 Swap</button>
                                <button class="action-btn" onclick="resetAll()">🗑️ Reset</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right: Map -->
                <div class="map-panel">
                    <div id="map"></div>
                    <div class="map-welcome" id="map-welcome">
                        <div class="icon">🗺️</div>
                        <h3>Select Two Airports</h3>
                        <p>Pick an origin and destination to see the route.</p>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
    (function() {
        const API = 'api_airports.php';

        // ── State ─────────────────────────────────────────────────
        let originAirport = null;
        let destAirport = null;
        let originMarker = null;
        let destMarker = null;
        let routeLine = null;
        let midpointMarker = null;

        // ── Map Init ──────────────────────────────────────────────
        const map = L.map('map', {
            center: [5, 38],
            zoom: 3,
            zoomControl: true,
            attributionControl: true
        });

        L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://carto.com/">CARTO</a> &copy; <a href="https://www.openstreetmap.org/">OSM</a>',
            subdomains: 'abcd',
            maxZoom: 19
        }).addTo(map);

        // Custom marker icons
        function createIcon(color, label) {
            return L.divIcon({
                className: 'custom-marker',
                html: `<div style="
                    width: 32px; height: 32px;
                    background: ${color};
                    border: 3px solid white;
                    border-radius: 50%;
                    box-shadow: 0 3px 10px rgba(0,0,0,0.4);
                    display: flex; align-items: center; justify-content: center;
                    font-size: 14px; font-weight: 800; color: white;
                    font-family: 'Inter', sans-serif;
                ">${label}</div>`,
                iconSize: [32, 32],
                iconAnchor: [16, 16],
                popupAnchor: [0, -20]
            });
        }

        const originIcon = createIcon('#10b981', 'A');
        const destIcon = createIcon('#f59e0b', 'B');
        const midIcon = L.divIcon({
            className: 'mid-marker',
            html: `<div style="
                width: 14px; height: 14px;
                background: #8b5cf6;
                border: 2px solid white;
                border-radius: 50%;
                box-shadow: 0 2px 6px rgba(0,0,0,0.3);
            "></div>`,
            iconSize: [14, 14],
            iconAnchor: [7, 7]
        });

        // ── Search Logic ──────────────────────────────────────────
        function setupSearch(inputId, resultsId, onSelect) {
            const input = document.getElementById(inputId);
            const results = document.getElementById(resultsId);
            let debounce = null;

            input.addEventListener('input', () => {
                clearTimeout(debounce);
                const q = input.value.trim();
                if (q.length < 2) { results.classList.remove('visible'); return; }

                debounce = setTimeout(async () => {
                    try {
                        const res = await fetch(`${API}?action=search&q=${encodeURIComponent(q)}`);
                        const data = await res.json();
                        renderResults(results, data.results || [], onSelect);
                    } catch(e) { console.error(e); }
                }, 250);
            });

            input.addEventListener('focus', () => {
                if (results.children.length > 0) results.classList.add('visible');
            });

            // Close on outside click
            document.addEventListener('click', (e) => {
                if (!input.contains(e.target) && !results.contains(e.target)) {
                    results.classList.remove('visible');
                }
            });
        }

        function renderResults(container, airports, onSelect) {
            if (airports.length === 0) {
                container.innerHTML = '<div style="padding:1rem;text-align:center;color:var(--text-muted);font-size:0.82rem;">No airports found</div>';
                container.classList.add('visible');
                return;
            }

            container.innerHTML = airports.map(a => {
                const typeClass = a.type === 'large_airport' ? 'type-large' : a.type === 'medium_airport' ? 'type-medium' : 'type-small';
                const typeLabel = a.type ? a.type.replace('_', ' ') : '';
                return `<div class="search-result-item" data-airport='${JSON.stringify(a).replace(/'/g, "&#39;")}'>
                    <div class="result-name">
                        ${escHtml(a.name)}
                        ${a.iata_code ? `<span class="iata-badge">${escHtml(a.iata_code)}</span>` : ''}
                        <span class="result-type ${typeClass}">${typeLabel}</span>
                    </div>
                    <div class="result-meta">
                        ${a.municipality ? escHtml(a.municipality) + ', ' : ''}${escHtml(a.country)}
                        · ICAO: ${escHtml(a.icao_code || a.ident)}
                    </div>
                </div>`;
            }).join('');

            container.classList.add('visible');

            container.querySelectorAll('.search-result-item').forEach(item => {
                item.addEventListener('click', () => {
                    const airport = JSON.parse(item.dataset.airport);
                    onSelect(airport);
                    container.classList.remove('visible');
                });
            });
        }

        // ── Airport Selection ─────────────────────────────────────
        function selectOrigin(airport) {
            originAirport = airport;
            document.getElementById('origin-search').value = formatAirportLabel(airport);
            renderSelectedCard('origin-card', airport, 'origin');
            updateMap();
        }

        function selectDest(airport) {
            destAirport = airport;
            document.getElementById('dest-search').value = formatAirportLabel(airport);
            renderSelectedCard('dest-card', airport, 'dest');
            updateMap();
        }

        function formatAirportLabel(a) {
            const code = a.iata_code || a.icao_code || a.ident;
            return `${code} — ${a.name}`;
        }

        function renderSelectedCard(cardId, airport, type) {
            const card = document.getElementById(cardId);
            const color = type === 'origin' ? '#10b981' : '#f59e0b';
            card.innerHTML = `
                <button class="clear-btn" onclick="clear${type === 'origin' ? 'Origin' : 'Dest'}()">✕ Clear</button>
                <div class="selected-name" style="color: ${color};">${escHtml(airport.name)}</div>
                <div class="selected-details">
                    <div class="detail-row"><span class="detail-label">IATA / ICAO</span><span>${escHtml(airport.iata_code || '—')} / ${escHtml(airport.icao_code || airport.ident)}</span></div>
                    <div class="detail-row"><span class="detail-label">Location</span><span>${escHtml(airport.municipality || '—')}, ${escHtml(airport.country)}</span></div>
                    <div class="detail-row"><span class="detail-label">Coordinates</span><span>${Number(airport.latitude).toFixed(4)}°, ${Number(airport.longitude).toFixed(4)}°</span></div>
                    <div class="detail-row"><span class="detail-label">Elevation</span><span>${airport.elevation ? airport.elevation + ' ft' : '—'}</span></div>
                    <div class="detail-row"><span class="detail-label">Type</span><span>${escHtml((airport.type || '').replace(/_/g, ' '))}</span></div>
                </div>
            `;
            card.classList.add('visible');
        }

        window.clearOrigin = function() {
            originAirport = null;
            document.getElementById('origin-search').value = '';
            document.getElementById('origin-card').classList.remove('visible');
            updateMap();
        };

        window.clearDest = function() {
            destAirport = null;
            document.getElementById('dest-search').value = '';
            document.getElementById('dest-card').classList.remove('visible');
            updateMap();
        };

        window.swapAirports = function() {
            const temp = originAirport;
            selectOrigin(destAirport);
            selectDest(temp);
        };

        window.resetAll = function() {
            clearOrigin();
            clearDest();
        };

        // ── Map Update ────────────────────────────────────────────
        function updateMap() {
            // Clear existing markers/line
            if (originMarker) { map.removeLayer(originMarker); originMarker = null; }
            if (destMarker) { map.removeLayer(destMarker); destMarker = null; }
            if (routeLine) { map.removeLayer(routeLine); routeLine = null; }
            if (midpointMarker) { map.removeLayer(midpointMarker); midpointMarker = null; }

            const welcome = document.getElementById('map-welcome');
            const routeInfo = document.getElementById('route-info');

            if (!originAirport && !destAirport) {
                welcome.classList.remove('hidden');
                routeInfo.classList.remove('visible');
                map.setView([5, 38], 3);
                return;
            }
            welcome.classList.add('hidden');

            // Add origin marker
            if (originAirport) {
                const lat = parseFloat(originAirport.latitude);
                const lon = parseFloat(originAirport.longitude);
                originMarker = L.marker([lat, lon], { icon: originIcon }).addTo(map);
                originMarker.bindPopup(popupHtml(originAirport, 'Origin'));
            }

            // Add destination marker
            if (destAirport) {
                const lat = parseFloat(destAirport.latitude);
                const lon = parseFloat(destAirport.longitude);
                destMarker = L.marker([lat, lon], { icon: destIcon }).addTo(map);
                destMarker.bindPopup(popupHtml(destAirport, 'Destination'));
            }

            // If both selected → draw route and calculate stats
            if (originAirport && destAirport) {
                const lat1 = parseFloat(originAirport.latitude);
                const lon1 = parseFloat(originAirport.longitude);
                const lat2 = parseFloat(destAirport.latitude);
                const lon2 = parseFloat(destAirport.longitude);

                // Great circle arc (approximated with intermediate points)
                const arcPoints = greatCircleArc(lat1, lon1, lat2, lon2, 80);
                routeLine = L.polyline(arcPoints, {
                    color: '#818cf8',
                    weight: 3,
                    opacity: 0.8,
                    dashArray: '8, 6',
                    lineCap: 'round'
                }).addTo(map);

                // Add glow effect
                L.polyline(arcPoints, {
                    color: '#818cf8',
                    weight: 8,
                    opacity: 0.15,
                }).addTo(map);

                // Midpoint marker
                const mid = midpoint(lat1, lon1, lat2, lon2);
                midpointMarker = L.marker(mid, { icon: midIcon }).addTo(map);
                midpointMarker.bindPopup(`<div style="font-family:'Inter',sans-serif;font-size:0.8rem;"><strong>Route Midpoint</strong><br>${mid[0].toFixed(4)}°, ${mid[1].toFixed(4)}°</div>`);

                // Fit bounds
                const bounds = L.latLngBounds([
                    [lat1, lon1],
                    [lat2, lon2]
                ]);
                map.fitBounds(bounds, { padding: [60, 60] });

                // Calculate and display stats
                calculateRouteStats(lat1, lon1, lat2, lon2);
            } else {
                routeInfo.classList.remove('visible');
                // Zoom to single airport
                const a = originAirport || destAirport;
                map.setView([parseFloat(a.latitude), parseFloat(a.longitude)], 8);
            }
        }

        // ── Route Calculations ────────────────────────────────────
        function calculateRouteStats(lat1, lon1, lat2, lon2) {
            const distKm = haversineKm(lat1, lon1, lat2, lon2);
            const distMi = distKm * 0.621371;
            const distNm = distKm * 0.539957;

            // Estimated flight time at different speeds based on distance
            let cruiseSpeed; // km/h
            if (distKm < 500) {
                cruiseSpeed = 450; // regional turboprop
            } else if (distKm < 2000) {
                cruiseSpeed = 800; // narrow-body jet
            } else {
                cruiseSpeed = 850; // wide-body jet
            }

            // Add 30min for taxi, takeoff, climb, descent, landing
            const flightHoursRaw = distKm / cruiseSpeed;
            const totalHours = flightHoursRaw + 0.5;
            const hours = Math.floor(totalHours);
            const minutes = Math.round((totalHours - hours) * 60);

            const bearing = initialBearing(lat1, lon1, lat2, lon2);
            const compassDir = bearingToCompass(bearing);

            const elev1 = parseInt(originAirport.elevation) || 0;
            const elev2 = parseInt(destAirport.elevation) || 0;
            const elevDiff = Math.abs(elev1 - elev2);

            const mid = midpoint(lat1, lon1, lat2, lon2);

            // Update UI
            document.getElementById('code-origin').textContent = originAirport.iata_code || originAirport.ident;
            document.getElementById('code-dest').textContent = destAirport.iata_code || destAirport.ident;

            document.getElementById('stat-distance').textContent = distKm.toFixed(0) + ' km';
            document.getElementById('stat-distance-mi').textContent = distMi.toFixed(0);
            document.getElementById('stat-distance-nm').textContent = distNm.toFixed(0);
            document.getElementById('stat-flight-time').textContent = `${hours}h ${minutes}m`;
            document.getElementById('stat-speed-info').textContent = `@ ${cruiseSpeed} km/h cruise`;
            document.getElementById('stat-bearing').textContent = `${bearing.toFixed(0)}° ${compassDir}`;
            document.getElementById('stat-elev-diff').textContent = `${elevDiff.toLocaleString()} ft`;
            document.getElementById('stat-midpoint').textContent = `${mid[0].toFixed(2)}°, ${mid[1].toFixed(2)}°`;

            document.getElementById('route-info').classList.add('visible');
        }

        // ── Math Functions ────────────────────────────────────────
        function toRad(deg) { return deg * Math.PI / 180; }
        function toDeg(rad) { return rad * 180 / Math.PI; }

        function haversineKm(lat1, lon1, lat2, lon2) {
            const R = 6371;
            const dLat = toRad(lat2 - lat1);
            const dLon = toRad(lon2 - lon1);
            const a = Math.sin(dLat / 2) ** 2 +
                      Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
                      Math.sin(dLon / 2) ** 2;
            return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        }

        function initialBearing(lat1, lon1, lat2, lon2) {
            const dLon = toRad(lon2 - lon1);
            const y = Math.sin(dLon) * Math.cos(toRad(lat2));
            const x = Math.cos(toRad(lat1)) * Math.sin(toRad(lat2)) -
                      Math.sin(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.cos(dLon);
            return (toDeg(Math.atan2(y, x)) + 360) % 360;
        }

        function bearingToCompass(deg) {
            const dirs = ['N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'];
            return dirs[Math.round(deg / 22.5) % 16];
        }

        function midpoint(lat1, lon1, lat2, lon2) {
            const dLon = toRad(lon2 - lon1);
            const lat1R = toRad(lat1);
            const lat2R = toRad(lat2);
            const lon1R = toRad(lon1);

            const Bx = Math.cos(lat2R) * Math.cos(dLon);
            const By = Math.cos(lat2R) * Math.sin(dLon);

            const midLat = Math.atan2(
                Math.sin(lat1R) + Math.sin(lat2R),
                Math.sqrt((Math.cos(lat1R) + Bx) ** 2 + By ** 2)
            );
            const midLon = lon1R + Math.atan2(By, Math.cos(lat1R) + Bx);
            return [toDeg(midLat), toDeg(midLon)];
        }

        function greatCircleArc(lat1, lon1, lat2, lon2, numPoints) {
            const points = [];
            for (let i = 0; i <= numPoints; i++) {
                const f = i / numPoints;
                const lat1R = toRad(lat1), lon1R = toRad(lon1);
                const lat2R = toRad(lat2), lon2R = toRad(lon2);

                const d = 2 * Math.asin(Math.sqrt(
                    Math.sin((lat2R - lat1R) / 2) ** 2 +
                    Math.cos(lat1R) * Math.cos(lat2R) * Math.sin((lon2R - lon1R) / 2) ** 2
                ));

                if (d === 0) { points.push([lat1, lon1]); continue; }

                const A = Math.sin((1 - f) * d) / Math.sin(d);
                const B = Math.sin(f * d) / Math.sin(d);

                const x = A * Math.cos(lat1R) * Math.cos(lon1R) + B * Math.cos(lat2R) * Math.cos(lon2R);
                const y = A * Math.cos(lat1R) * Math.sin(lon1R) + B * Math.cos(lat2R) * Math.sin(lon2R);
                const z = A * Math.sin(lat1R) + B * Math.sin(lat2R);

                const latI = Math.atan2(z, Math.sqrt(x * x + y * y));
                const lonI = Math.atan2(y, x);

                points.push([toDeg(latI), toDeg(lonI)]);
            }
            return points;
        }

        function popupHtml(airport, label) {
            return `<div>
                <div class="popup-name">${escHtml(airport.name)}</div>
                <div class="popup-code">${label} · ${escHtml(airport.iata_code || '')} / ${escHtml(airport.icao_code || airport.ident)}</div>
                <div class="popup-meta">${escHtml(airport.municipality || '')}, ${escHtml(airport.country)} · ${airport.elevation || '—'} ft</div>
            </div>`;
        }

        function escHtml(str) {
            const d = document.createElement('div');
            d.textContent = str || '';
            return d.innerHTML;
        }

        // ── Init Search ───────────────────────────────────────────
        setupSearch('origin-search', 'origin-results', selectOrigin);
        setupSearch('dest-search', 'dest-results', selectDest);
    })();
    </script>
</body>
</html>
