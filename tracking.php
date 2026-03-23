<?php
require_once 'db.php';

$active_page = 'tracking';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Live Flight Tracking</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <style>
        #map { height: 75vh; border-radius: 1rem; border: 1px solid var(--border); margin-top: 1rem; background: #1a1a1a; }
        .stats-bar { display: flex; gap: 2rem; margin-top: 1rem; padding: 1rem; background: rgba(255,255,255,0.03); border-radius: 0.5rem; border: 1px solid var(--border); }
        .stat-item { display: flex; flex-direction: column; }
        .stat-item label { font-size: 0.7rem; color: var(--text-muted); text-transform: uppercase; }
        .stat-item span { font-size: 1.2rem; font-weight: bold; color: var(--accent-color); }
        .aircraft-icon { transition: transform 0.5s ease; }
    </style>
</head>
<body>
    <div class="container">
        <?php include 'header.php'; ?>

        <main>
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h2>Live Air Traffic</h2>
                    <p class="text-muted">Real-time aircraft positions over East Africa via OpenSky Network.</p>
                </div>
                <div id="refresh-status" class="text-muted" style="font-size: 0.8rem;">Updated: Just now</div>
            </div>

            <div class="stats-bar">
                <div class="stat-item">
                    <label>Tracked Aircraft</label>
                    <span id="count-total">0</span>
                </div>
                <div class="stat-item">
                    <label>Mean Altitude</label>
                    <span id="mean-alt">0 ft</span>
                </div>
                <div class="stat-item">
                    <label>Active Region</label>
                    <span>East Africa</span>
                </div>
            </div>

            <div id="map"></div>
        </main>
    </div>

    <script>
        var map = L.map('map').setView([0.0, 37.0], 6); // Centered on Kenya/Uganda
        
        // Use a dark theme for the map
        L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
            attribution: '© OpenStreetMap © CARTO © OpenSky Network',
            subdomains: 'abcd',
            maxZoom: 20
        }).addTo(map);

        var markers = {};

        function fetchTrackingData() {
            fetch('tracking_data.php')
                .then(response => response.json())
                .then(data => {
                    if (data.states) {
                        updateMarkers(data.states);
                        updateStats(data.states);
                        document.getElementById('refresh-status').innerText = 'Updated: ' + new Date().toLocaleTimeString();
                    }
                })
                .catch(err => console.error('Error fetching data:', err));
        }

        function updateMarkers(states) {
            // Keep track of aircraft IDs found in this update
            const currentIds = new Set();

            states.forEach(s => {
                const icao = s[0];
                const callsign = (s[1] || 'N/A').trim();
                const lon = s[5];
                const lat = s[6];
                const alt = s[7] || 0;
                const velocity = s[9] || 0;
                const heading = s[10] || 0;

                if (!lat || !lon) return;

                currentIds.add(icao);

                const popupContent = `
                    <div style="min-width: 150px;">
                        <h4 style="margin: 0; color: #6366f1;">${callsign}</h4>
                        <p style="margin: 5px 0 0 0; font-size: 0.8rem;">ICAO: <code>${icao}</code></p>
                        <hr style="border: 0; border-top: 1px solid #333; margin: 10px 0;">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 5px; font-size: 0.8rem;">
                            <div><b>Alt:</b> ${Math.round(alt * 3.28084)} ft</div>
                            <div><b>Vel:</b> ${Math.round(velocity * 1.94384)} kts</div>
                            <div><b>Head:</b> ${Math.round(heading)}°</div>
                        </div>
                        <a href="viewer.php?search=${callsign}" style="display: inline-block; margin-top: 10px; font-size: 0.7rem; color: #6366f1; text-decoration: none;">Search in Directory →</a>
                    </div>
                `;

                // SVG Aircraft Icon
                const iconHtml = `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="transform: rotate(${heading}deg);">
                    <path d="M21 16V14.5L13 9.5V3.5C13 2.67 12.33 2 11.5 2C10.67 2 10 2.67 10 3.5V9.5L2 14.5V16L10 13.5V19L8 20.5V22L11.5 21L15 22V20.5L13 19V13.5L21 16Z" fill="#6366f1"/>
                </svg>`;

                const icon = L.divIcon({
                    html: iconHtml,
                    className: 'aircraft-icon',
                    iconSize: [24, 24],
                    iconAnchor: [12, 12]
                });

                if (markers[icao]) {
                    markers[icao].setLatLng([lat, lon]);
                    markers[icao].setIcon(icon);
                    markers[icao].setPopupContent(popupContent);
                } else {
                    markers[icao] = L.marker([lat, lon], { icon: icon }).addTo(map)
                        .bindPopup(popupContent);
                }
            });

            // Remove aircraft that are no longer in the state
            Object.keys(markers).forEach(icao => {
                if (!currentIds.has(icao)) {
                    map.removeLayer(markers[icao]);
                    delete markers[icao];
                }
            });
        }

        function updateStats(states) {
            document.getElementById('count-total').innerText = states.length;
            
            let totalAlt = 0;
            states.forEach(s => totalAlt += (s[7] || 0));
            const avgAlt = states.length > 0 ? (totalAlt / states.length) * 3.28084 : 0;
            document.getElementById('mean-alt').innerText = Math.round(avgAlt).toLocaleString() + ' ft';
        }

        // Initial fetch and set interval
        fetchTrackingData();
        setInterval(fetchTrackingData, 10000); // Update every 10 seconds
    </script>
</body>
</html>
