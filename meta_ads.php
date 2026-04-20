<?php
// Dataset Application — Meta Digital Properties
$active_page = 'meta_ads';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Meta Ads Library</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .ads-layout {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 2rem;
            min-height: calc(100vh - 160px);
            align-items: start;
        }

        /* ── Left Panel: Filters ─────────────────────────────── */
        .filter-panel {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 1.5rem;
            position: sticky;
            top: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }

        .filter-panel h3 {
            margin: 0 0 1.5rem 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .form-group select,
        .form-group input {
            padding: 0.75rem 1rem;
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            color: var(--text-color);
            font-size: 0.95rem;
            font-family: inherit;
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #1877F2;
        }

        .category-tabs {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .category-tab {
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            background: rgba(15, 23, 42, 0.5);
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.2s;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .category-tab:hover {
            background: rgba(15, 23, 42, 0.8);
        }

        .category-tab.active {
            background: rgba(24, 119, 242, 0.15);
            border-color: #1877F2;
            color: #1877F2;
        }

        .sync-btn {
            width: 100%;
            background: #1877F2;
            color: white;
            border: none;
            padding: 0.85rem;
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: background 0.2s, transform 0.1s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .sync-btn:hover { background: #166FE5; }
        .sync-btn:active { transform: scale(0.98); }
        .sync-btn:disabled { background: #475569; cursor: not-allowed; opacity: 0.7; }

        /* ── Right Panel: Results ────────────────────────────────── */
        .results-panel {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: 1rem;
            border: 1px solid var(--border-color);
        }

        .results-header h2 { margin: 0; font-size: 1.5rem; }
        .results-header .meta-stat { color: var(--text-muted); font-size: 0.95rem; }

        .loading-state {
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 4rem 0;
            color: var(--text-muted);
            gap: 1rem;
        }
        
        .loading-state.active { display: flex; }

        .spinner {
            width: 40px; height: 40px;
            border: 4px solid rgba(24, 119, 242, 0.2);
            border-top-color: #1877F2;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin { to { transform: rotate(360deg); } }

        .ads-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .ad-card {
            background: #ffffff;
            color: #1c1e21;
            border-radius: 0.75rem;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            display: flex;
            flex-direction: column;
            border: 1px solid #dddfe2;
            transition: transform 0.2s;
        }
        
        .ad-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        }

        .ad-header {
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            border-bottom: 1px solid #ebedf0;
        }

        .ad-avatar {
            width: 40px; height: 40px;
            background: #e4e6eb;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; color: #606770;
            font-size: 1.2rem;
        }

        .ad-meta {
            display: flex;
            flex-direction: column;
        }

        .ad-meta strong { font-size: 0.95rem; }
        .ad-meta span { font-size: 0.75rem; color: #65676b; }

        .ad-body {
            padding: 1rem;
            font-size: 0.9rem;
            line-height: 1.4;
            color: #050505;
            flex-grow: 1;
        }
        
        .ad-status {
            padding: 0.4rem 0.75rem;
            background: #e7f3ff;
            color: #1877F2;
            font-weight: 600;
            font-size: 0.75rem;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 0.5rem;
        }

        .ad-footer {
            padding: 0.75rem 1rem;
            background: #f0f2f5;
            border-top: 1px solid #ebedf0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.8rem;
            color: #65676b;
        }

        .ad-footer a { color: #1877F2; text-decoration: none; font-weight: 500; }
        .ad-footer a:hover { text-decoration: underline; }
        
        .no-results {
            padding: 4rem 2rem;
            text-align: center;
            background: var(--card-bg);
            border-radius: 1rem;
            border: 1px solid var(--border-color);
            grid-column: 1 / -1;
            display: none;
        }
        .no-results h3 { margin-bottom: 0.5rem; }
        .no-results p { color: var(--text-muted); }

    </style>
</head>
<body>
    <div class="container" style="max-width: 1600px;">
        <header>
            <?php include 'header.php'; ?>
        </header>

        <main>
            <div class="ads-layout">
                <!-- Left: Filters Panel -->
                <div class="filter-panel">
                    <h3>🌐 Ads Library Sync</h3>
                    
                    <div class="form-group">
                        <label>Target Country</label>
                        <select id="country-select">
                            <option value="">-- Select Country --</option>
<?php
$iso_countries = [
    "AF"=>"Afghanistan", "AX"=>"Åland Islands", "AL"=>"Albania", "DZ"=>"Algeria", "AS"=>"American Samoa", "AD"=>"Andorra", "AO"=>"Angola", "AI"=>"Anguilla", "AQ"=>"Antarctica", "AG"=>"Antigua and Barbuda", "AR"=>"Argentina", "AM"=>"Armenia", "AW"=>"Aruba", "AU"=>"Australia", "AT"=>"Austria", "AZ"=>"Azerbaijan", "BS"=>"Bahamas", "BH"=>"Bahrain", "BD"=>"Bangladesh", "BB"=>"Barbados", "BY"=>"Belarus", "BE"=>"Belgium", "BZ"=>"Belize", "BJ"=>"Benin", "BM"=>"Bermuda", "BT"=>"Bhutan", "BO"=>"Bolivia", "BQ"=>"Bonaire, Sint Eustatius and Saba", "BA"=>"Bosnia and Herzegovina", "BW"=>"Botswana", "BV"=>"Bouvet Island", "BR"=>"Brazil", "IO"=>"British Indian Ocean Territory", "BN"=>"Brunei Darussalam", "BG"=>"Bulgaria", "BF"=>"Burkina Faso", "BI"=>"Burundi", "CV"=>"Cabo Verde", "KH"=>"Cambodia", "CM"=>"Cameroon", "CA"=>"Canada", "KY"=>"Cayman Islands", "CF"=>"Central African Republic", "TD"=>"Chad", "CL"=>"Chile", "CN"=>"China", "CX"=>"Christmas Island", "CC"=>"Cocos (Keeling) Islands", "CO"=>"Colombia", "KM"=>"Comoros", "CG"=>"Congo", "CD"=>"Congo, Democratic Republic", "CK"=>"Cook Islands", "CR"=>"Costa Rica", "CI"=>"Côte d'Ivoire", "HR"=>"Croatia", "CU"=>"Cuba", "CW"=>"Curaçao", "CY"=>"Cyprus", "CZ"=>"Czechia", "DK"=>"Denmark", "DJ"=>"Djibouti", "DM"=>"Dominica", "DO"=>"Dominican Republic", "EC"=>"Ecuador", "EG"=>"Egypt", "SV"=>"El Salvador", "GQ"=>"Equatorial Guinea", "ER"=>"Eritrea", "EE"=>"Estonia", "SZ"=>"Eswatini", "ET"=>"Ethiopia", "FK"=>"Falkland Islands (Malvinas)", "FO"=>"Faroe Islands", "FJ"=>"Fiji", "FI"=>"Finland", "FR"=>"France", "GF"=>"French Guiana", "PF"=>"French Polynesia", "TF"=>"French Southern Territories", "GA"=>"Gabon", "GM"=>"Gambia", "GE"=>"Georgia", "DE"=>"Germany", "GH"=>"Ghana", "GI"=>"Gibraltar", "GR"=>"Greece", "GL"=>"Greenland", "GD"=>"Grenada", "GP"=>"Guadeloupe", "GU"=>"Guam", "GT"=>"Guatemala", "GG"=>"Guernsey", "GN"=>"Guinea", "GW"=>"Guinea-Bissau", "GY"=>"Guyana", "HT"=>"Haiti", "HM"=>"Heard Island and McDonald Islands", "VA"=>"Holy See", "HN"=>"Honduras", "HK"=>"Hong Kong", "HU"=>"Hungary", "IS"=>"Iceland", "IN"=>"India", "ID"=>"Indonesia", "IR"=>"Iran", "IQ"=>"Iraq", "IE"=>"Ireland", "IM"=>"Isle of Man", "IL"=>"Israel", "IT"=>"Italy", "JM"=>"Jamaica", "JP"=>"Japan", "JE"=>"Jersey", "JO"=>"Jordan", "KZ"=>"Kazakhstan", "KE"=>"Kenya", "KI"=>"Kiribati", "KP"=>"Korea, Democratic People's Republic", "KR"=>"Korea, Republic of", "KW"=>"Kuwait", "KG"=>"Kyrgyzstan", "LA"=>"Lao People's Democratic Republic", "LV"=>"Latvia", "LB"=>"Lebanon", "LS"=>"Lesotho", "LR"=>"Liberia", "LY"=>"Libya", "LI"=>"Liechtenstein", "LT"=>"Lithuania", "LU"=>"Luxembourg", "MO"=>"Macao", "MG"=>"Madagascar", "MW"=>"Malawi", "MY"=>"Malaysia", "MV"=>"Maldives", "ML"=>"Mali", "MT"=>"Malta", "MH"=>"Marshall Islands", "MQ"=>"Martinique", "MR"=>"Mauritania", "MU"=>"Mauritius", "YT"=>"Mayotte", "MX"=>"Mexico", "FM"=>"Micronesia", "MD"=>"Moldova", "MC"=>"Monaco", "MN"=>"Mongolia", "ME"=>"Montenegro", "MS"=>"Montserrat", "MA"=>"Morocco", "MZ"=>"Mozambique", "MM"=>"Myanmar", "NA"=>"Namibia", "NR"=>"Nauru", "NP"=>"Nepal", "NL"=>"Netherlands", "NC"=>"New Caledonia", "NZ"=>"New Zealand", "NI"=>"Nicaragua", "NE"=>"Niger", "NG"=>"Nigeria", "NU"=>"Niue", "NF"=>"Norfolk Island", "MK"=>"North Macedonia", "MP"=>"Northern Mariana Islands", "NO"=>"Norway", "OM"=>"Oman", "PK"=>"Pakistan", "PW"=>"Palau", "PS"=>"Palestine", "PA"=>"Panama", "PG"=>"Papua New Guinea", "PY"=>"Paraguay", "PE"=>"Peru", "PH"=>"Philippines", "PN"=>"Pitcairn", "PL"=>"Poland", "PT"=>"Portugal", "PR"=>"Puerto Rico", "QA"=>"Qatar", "RE"=>"Réunion", "RO"=>"Romania", "RU"=>"Russian Federation", "RW"=>"Rwanda", "BL"=>"Saint Barthélemy", "SH"=>"Saint Helena", "KN"=>"Saint Kitts and Nevis", "LC"=>"Saint Lucia", "MF"=>"Saint Martin", "PM"=>"Saint Pierre and Miquelon", "VC"=>"Saint Vincent and the Grenadines", "WS"=>"Samoa", "SM"=>"San Marino", "ST"=>"Sao Tome and Principe", "SA"=>"Saudi Arabia", "SN"=>"Senegal", "RS"=>"Serbia", "SC"=>"Seychelles", "SL"=>"Sierra Leone", "SG"=>"Singapore", "SX"=>"Sint Maarten (Dutch part)", "SK"=>"Slovakia", "SI"=>"Slovenia", "SB"=>"Solomon Islands", "SO"=>"Somalia", "ZA"=>"South Africa", "GS"=>"South Georgia", "SS"=>"South Sudan", "ES"=>"Spain", "LK"=>"Sri Lanka", "SD"=>"Sudan", "SR"=>"Suriname", "SJ"=>"Svalbard and Jan Mayen", "SE"=>"Sweden", "CH"=>"Switzerland", "SY"=>"Syrian Arab Republic", "TW"=>"Taiwan", "TJ"=>"Tajikistan", "TZ"=>"Tanzania", "TH"=>"Thailand", "TL"=>"Timor-Leste", "TG"=>"Togo", "TK"=>"Tokelau", "TO"=>"Tonga", "TT"=>"Trinidad and Tobago", "TN"=>"Tunisia", "TR"=>"Turkey", "TM"=>"Turkmenistan", "TC"=>"Turks and Caicos Islands", "TV"=>"Tuvalu", "UG"=>"Uganda", "UA"=>"Ukraine", "AE"=>"United Arab Emirates", "GB"=>"United Kingdom", "US"=>"United States", "UM"=>"United States Minor Outlying Islands", "UY"=>"Uruguay", "UZ"=>"Uzbekistan", "VU"=>"Vanuatu", "VE"=>"Venezuela", "VN"=>"Viet Nam", "VG"=>"Virgin Islands, British", "VI"=>"Virgin Islands, U.S.", "WF"=>"Wallis and Futuna", "EH"=>"Western Sahara", "YE"=>"Yemen", "ZM"=>"Zambia", "ZW"=>"Zimbabwe"
];
foreach($iso_countries as $code => $name) {
    echo "<option value=\"$code\">$name</option>\n";
}
?>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Dataset Category</label>
                        <div class="category-tabs">
                            <div class="category-tab active" data-cat="airlines">✈️ Airlines</div>
                            <div class="category-tab" data-cat="airports">🏢 Airports</div>
                            <div class="category-tab" data-cat="regulatory">🏛️ Regulatory</div>
                        </div>
                    </div>

                    <div class="form-group" id="entity-selector-group" style="display: none;">
                        <label id="entity-label">Target Airline</label>
                        <select id="entity-select">
                            <option value="">All (Warning: Extremely Slow)</option>
                        </select>
                    </div>

                    <div class="form-group" style="margin-top: 2rem;">
                        <button id="sync-btn" class="sync-btn">
                            <span>Fetch Targeted Ads</span>
                        </button>
                    </div>
                    
                    <div id="sync-status" style="margin-top: 1rem; font-size: 0.85rem; color: var(--text-muted);">
                        Select a country and category to scan for Meta Ads and generate 'meta_ads.csv' records.
                    </div>
                    
                    <hr style="border-color: var(--border-color); margin: 1.5rem 0;">
                    
                    <button id="global-sync-btn" class="sync-btn" style="background: var(--card-bg); border: 1px solid #1877F2; color: #1877F2;">
                        🌍 Run Global Sync
                    </button>
                    <p style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.5rem; text-align: center;">Batches all countries sequentially.</p>
                </div>

                <!-- Right: Results Panel -->
                <div class="results-panel">
                    <div class="results-header">
                        <div>
                            <h2>Ad Creatives Preview</h2>
                            <div class="meta-stat" id="results-count">Results will appear here</div>
                        </div>
                    </div>

                    <div class="loading-state" id="loading-state">
                        <div class="spinner"></div>
                        <div>Querying Meta Graph API...</div>
                    </div>
                    
                    <div class="no-results" id="no-results">
                        <h3>📭 No active ads found</h3>
                        <p>Meta returned zero results for the selected category and country.</p>
                    </div>

                    <div class="ads-grid" id="ads-grid">
                        <!-- Ads will be populated here -->
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', () => {
        let activeCategory = 'airlines';
        const countrySelect = document.getElementById('country-select');
        const entityGroup = document.getElementById('entity-selector-group');
        const entityLabel = document.getElementById('entity-label');
        const entitySelect = document.getElementById('entity-select');
        const syncBtn = document.getElementById('sync-btn');
        const globalSyncBtn = document.getElementById('global-sync-btn');
        const adsGrid = document.getElementById('ads-grid');
        const loadingState = document.getElementById('loading-state');
        const noResults = document.getElementById('no-results');
        const resultsCount = document.getElementById('results-count');
        const syncStatus = document.getElementById('sync-status');

        // Refresh dynamic options based on selection
        async function loadEntities() {
            const country = countrySelect.value;
            if (!country) {
                entityGroup.style.display = 'none';
                return;
            }
            
            const catNames = {
                'airlines': 'Target Airline',
                'airports': 'Target Airport',
                'regulatory': 'Target Agency'
            };
            entityLabel.innerText = catNames[activeCategory];
            entitySelect.innerHTML = '<option value="">Loading...</option>';
            entityGroup.style.display = 'flex';
            
            try {
                const res = await fetch(`api_meta_ads.php?action=get_entities&country=${country}&category=${activeCategory}`);
                const data = await res.json();
                
                if (data.entities) {
                    let opts = '<option value="">All (Warning: Extremely Slow)</option>';
                    data.entities.forEach(ent => {
                        opts += `<option value="${ent.id}" data-name="${escapeHTML(ent.name)}">${escapeHTML(ent.name)}</option>`;
                    });
                    entitySelect.innerHTML = opts;
                } else {
                    entitySelect.innerHTML = '<option value="">(No records found for this category)</option>';
                }
            } catch (err) {
                entitySelect.innerHTML = '<option value="">Error loading list</option>';
            }
        }

        countrySelect.addEventListener('change', loadEntities);

        // Tab Switching
        document.querySelectorAll('.category-tab').forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelectorAll('.category-tab').forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                activeCategory = tab.dataset.cat;
                loadEntities();
            });
        });

        // Sync Target Action
        syncBtn.addEventListener('click', async () => {
            const country = countrySelect.value;
            if (!country) return alert("Please select a country first.");
            
            const selectedEntityOption = entitySelect.options[entitySelect.selectedIndex];
            const entityId = selectedEntityOption.value;
            const entityName = entityId ? selectedEntityOption.getAttribute('data-name') : '';

            adsGrid.innerHTML = '';
            noResults.style.display = 'none';
            loadingState.classList.add('active');
            syncBtn.disabled = true;
            
            if (entityName) {
                syncStatus.innerText = `Scanning Meta Library for ${entityName} in ${country}...`;
            } else {
                syncStatus.innerText = `Scanning Meta Library for all ${activeCategory} in ${country}...`;
            }
            
            resultsCount.innerText = "Processing...";

            try {
                const queryStr = `action=sync_target&country=${encodeURIComponent(country)}&category=${encodeURIComponent(activeCategory)}` +
                                 (entityId ? `&entity_id=${encodeURIComponent(entityId)}&entity_name=${encodeURIComponent(entityName)}` : '');
                
                const res = await fetch(`api_meta_ads.php?${queryStr}`);
                const data = await res.json();
                
                if (data.error) {
                    throw new Error(data.error);
                }

                syncStatus.innerText = `Saved ${data.saved_records} records to meta_ads.csv. Found ${data.ads.length} unique creatives.`;
                resultsCount.innerText = `Previewing ${data.ads.length} Ads`;

                if (data.ads.length === 0) {
                    noResults.style.display = 'block';
                } else {
                    renderAds(data.ads);
                }
            } catch (err) {
                alert("Error synchronizing ads: " + err.message);
                syncStatus.innerText = "Error: " + err.message;
            } finally {
                loadingState.classList.remove('active');
                syncBtn.disabled = false;
            }
        });
        
        // Global Sync Action
        globalSyncBtn.addEventListener('click', () => {
            if(!confirm("This will scan ALL countries for airlines, potentially taking a long time and consuming API limits. Proceed?")) return;
            window.location.href = 'sync_meta_ads.php';
        });

        function renderAds(ads) {
            let html = '';
            ads.forEach(ad => {
                const initial = ad.page_name ? ad.page_name.charAt(0).toUpperCase() : '?';
                const created = new Date(ad.ad_creation_time).toLocaleDateString();
                
                html += `
                <div class="ad-card">
                    <div class="ad-header">
                        <div class="ad-avatar">${initial}</div>
                        <div class="ad-meta">
                            <strong>${ad.page_name}</strong>
                            <span>Sponsored • Parent ID: ${ad.parent_id}</span>
                        </div>
                    </div>
                    <div class="ad-body">
                        <div class="ad-status">${ad.status || 'ACTIVE'}</div>
                        <p>${escapeHTML(ad.ad_text).substring(0, 180)}${ad.ad_text.length > 180 ? '...' : ''}</p>
                    </div>
                    <div class="ad-footer">
                        <span>Since ${created}</span>
                        <a href="${ad.snapshot_url}" target="_blank">View Library Snapshot ↗</a>
                    </div>
                </div>`;
            });
            adsGrid.innerHTML = html;
        }

        function escapeHTML(str) {
            if (!str) return '';
            return str.replace(/[&<>'"]/g, 
                tag => ({
                    '&': '&amp;',
                    '<': '&lt;',
                    '>': '&gt;',
                    "'": '&#39;',
                    '"': '&quot;'
                }[tag] || tag)
            );
        }
    });
    </script>
</body>
</html>
