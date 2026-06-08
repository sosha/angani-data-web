# OpenAP Integration: Aircraft Performance Models

## Overview

[OpenAP](https://github.com/TUDelft-CNS-ATM/openap) is an open-source aircraft performance model and Python toolkit from TU Delft. It provides ~40 commercial aircraft YAML profiles (A320, B738, E190, etc.) with detailed performance data, plus ICAO engine emission databanks, drag polar models, fuel flow polynomials, and kinematic climb/descent profiles.

Our `aircraft_types` DB already stores basic specs (MTOW, MZFW, dimensions) but lacks the numeric drag/fuel/emission models needed for actual performance calculations. OpenAP fills this gap.

### What OpenAP provides

| Domain | OpenAP Data | Format | Our Coverage Today |
|--------|-------------|--------|-------------------|
| Aircraft specs | MTOW, MLW, OEW, MFC, ceiling, pax, dimensions | YAML per type | Partial (MTOW in `aircraft_type_technical_specs`) |
| Wing/geometry | Area, span, MAC, sweep, t/c, flap config | YAML | Not present |
| Drag polar | Cd0, K, e (clean), gear drag, flap drag | YAML per type | Not present |
| Engine data | BPR, PR, thrust, fuel flow (4 phases), cruise SFC | CSV (400+ engines) | VARCHAR fields only |
| Fuel models | Polynomial coefficients c1/c2/c3 per aircraft-engine | CSV | Not present |
| Emissions | EI_HC, EI_CO, EI_NOx per LTO phase | CSV | Not present |
| Kinematics | Speed/altitude/vertical rate profiles (WRAP) | CSV | Not present |
| Navigation | Airports, waypoints | CSV | Already have airports |

### Key Insight

OpenAP's most valuable contribution is the **drag polar + fuel polynomial model** — these are derived from academic research (not just published specs) and enable actual **fuel flow, thrust, and emissions calculations** that are impossible from the raw spec data alone.

Our existing `aircraft_type_engine_data.fuel_burn_rate` is `VARCHAR(120)` free-text. OpenAP gives us numeric models ready for computation.

### License

LGPL-3.0 — fine to use with attribution.

### Constraint

Only ~40 aircraft types (commercial jets), mostly Airbus, Boeing, Embraer, Bombardier, Gulfstream. Covers the most common fleet but not the full ~300+ in our DB.

---

## Phase 1: Data Ingestion (~2 days)

### 1.1 Schema: New Tables

#### `engine_models` — ICAO engine databank

```sql
CREATE TABLE IF NOT EXISTS engine_models (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  uid VARCHAR(16) DEFAULT NULL,
  name VARCHAR(120) NOT NULL,
  manufacturer VARCHAR(120) DEFAULT NULL,
  engine_type VARCHAR(40) DEFAULT NULL,
  bypass_ratio DECIMAL(8,2) DEFAULT NULL,
  pressure_ratio DECIMAL(8,2) DEFAULT NULL,
  max_thrust_lbf INT DEFAULT NULL,
  ei_hc_takeoff DECIMAL(10,4) DEFAULT NULL,
  ei_hc_climbout DECIMAL(10,4) DEFAULT NULL,
  ei_hc_approach DECIMAL(10,4) DEFAULT NULL,
  ei_hc_idle DECIMAL(10,4) DEFAULT NULL,
  ei_co_takeoff DECIMAL(10,4) DEFAULT NULL,
  ei_co_climbout DECIMAL(10,4) DEFAULT NULL,
  ei_co_approach DECIMAL(10,4) DEFAULT NULL,
  ei_co_idle DECIMAL(10,4) DEFAULT NULL,
  ei_nox_takeoff DECIMAL(10,4) DEFAULT NULL,
  ei_nox_climbout DECIMAL(10,4) DEFAULT NULL,
  ei_nox_approach DECIMAL(10,4) DEFAULT NULL,
  ei_nox_idle DECIMAL(10,4) DEFAULT NULL,
  ff_takeoff DECIMAL(10,4) DEFAULT NULL,
  ff_climbout DECIMAL(10,4) DEFAULT NULL,
  ff_approach DECIMAL(10,4) DEFAULT NULL,
  ff_idle DECIMAL(10,4) DEFAULT NULL,
  fuel_lto_kg DECIMAL(10,2) DEFAULT NULL,
  cruise_thrust_lbf DECIMAL(10,2) DEFAULT NULL,
  cruise_sfc DECIMAL(10,6) DEFAULT NULL,
  cruise_mach DECIMAL(6,3) DEFAULT NULL,
  cruise_alt_ft INT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_eng_name (name),
  INDEX idx_eng_manufacturer (manufacturer)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### `aircraft_type_drag_polar` — OpenAP drag models per type

```sql
CREATE TABLE IF NOT EXISTS aircraft_type_drag_polar (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  icao_code VARCHAR(16) NOT NULL,
  cd0_clean DECIMAL(10,6) DEFAULT NULL,
  k_clean DECIMAL(10,6) DEFAULT NULL,
  e_clean DECIMAL(10,6) DEFAULT NULL,
  cd0_gears DECIMAL(10,6) DEFAULT NULL,
  flap_type VARCHAR(40) DEFAULT NULL,
  flap_lambda_f DECIMAL(10,6) DEFAULT NULL,
  flap_cf_c DECIMAL(10,6) DEFAULT NULL,
  flap_sf_s DECIMAL(10,6) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_drag_icao (icao_code),
  CONSTRAINT fk_drag_aircraft FOREIGN KEY (icao_code) REFERENCES aircraft_types(icao_code) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### `aircraft_type_fuel_model` — Polynomial fuel coefficients

```sql
CREATE TABLE IF NOT EXISTS aircraft_type_fuel_model (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  icao_code VARCHAR(16) NOT NULL,
  engine_name VARCHAR(120) DEFAULT NULL,
  c1 DECIMAL(18,14) DEFAULT NULL,
  c2 DECIMAL(18,14) DEFAULT NULL,
  c3 DECIMAL(18,14) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_fuel_icao (icao_code),
  CONSTRAINT fk_fuel_aircraft FOREIGN KEY (icao_code) REFERENCES aircraft_types(icao_code) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 1.2 Schema: New Columns on Existing Tables

#### `aircraft_type_technical_specs` — add wing/weight fields

```sql
ALTER TABLE aircraft_type_technical_specs
  ADD COLUMN oew_kg DECIMAL(12,2) DEFAULT NULL AFTER empty_weight_kg,
  ADD COLUMN max_fuel_capacity_kg DECIMAL(12,2) DEFAULT NULL,
  ADD COLUMN wing_area_m2 DECIMAL(10,2) DEFAULT NULL,
  ADD COLUMN wing_span_m DECIMAL(10,2) DEFAULT NULL,
  ADD COLUMN wing_mac_m DECIMAL(10,2) DEFAULT NULL,
  ADD COLUMN wing_sweep_deg DECIMAL(6,2) DEFAULT NULL;
```

#### `aircraft_type_engine_data` — add numeric fuel/emission fields

```sql
ALTER TABLE aircraft_type_engine_data
  ADD COLUMN cruise_sfc DECIMAL(10,6) DEFAULT NULL,
  ADD COLUMN cruise_thrust_kn DECIMAL(12,2) DEFAULT NULL,
  ADD COLUMN bypass_ratio DECIMAL(8,2) DEFAULT NULL,
  ADD COLUMN pressure_ratio DECIMAL(8,2) DEFAULT NULL,
  ADD COLUMN saf_compatible VARCHAR(40) DEFAULT NULL;
```

### 1.3 Ingestion Script

File: `scripts/ingest_openap_data.php`

```
Steps:
1. git clone https://github.com/TUDelft-CNS-ATM/openap.git /tmp/openap
2. Parse /tmp/openap/openap/data/aircraft/*.yml → aircraft_type_* tables
3. Parse /tmp/openap/openap/data/engine/engines.csv → engine_models
4. Parse /tmp/openap/openap/data/dragpolar/*.yml → aircraft_type_drag_polar
5. Parse /tmp/openap/openap/data/fuel/fuel_models.csv → aircraft_type_fuel_model
6. Match OpenAP aircraft codes (a320, b738, etc.) to our aircraft_types.icao_code
7. Report match rate and gaps
```

### 1.4 Module Config

Add to `includes/modules.php`:

```php
'engine_models'=>['label'=>'Engine Models','table'=>'engine_models','icon'=>'⚙','tier'=>'pro',
  'title'=>'name','subtitle'=>'manufacturer',
  'search'=>['name','manufacturer','engine_type'],
  'list'=>['name','manufacturer','engine_type','max_thrust_lbf','bypass_ratio'],
  'detail'=>['uid','name','manufacturer','engine_type','bypass_ratio','pressure_ratio','max_thrust_lbf',
    'ei_hc_takeoff','ei_hc_climbout','ei_hc_approach','ei_hc_idle',
    'ei_co_takeoff','ei_co_climbout','ei_co_approach','ei_co_idle',
    'ei_nox_takeoff','ei_nox_climbout','ei_nox_approach','ei_nox_idle',
    'ff_takeoff','ff_climbout','ff_approach','ff_idle','fuel_lto_kg',
    'cruise_thrust_lbf','cruise_sfc','cruise_mach','cruise_alt_ft','last_modified'],
  'fields'=>['uid','name','manufacturer','engine_type','bypass_ratio','pressure_ratio','max_thrust_lbf',
    'ei_hc_takeoff','ei_hc_climbout','ei_hc_approach','ei_hc_idle',
    'ei_co_takeoff','ei_co_climbout','ei_co_approach','ei_co_idle',
    'ei_nox_takeoff','ei_nox_climbout','ei_nox_approach','ei_nox_idle',
    'ff_takeoff','ff_climbout','ff_approach','ff_idle','fuel_lto_kg',
    'cruise_thrust_lbf','cruise_sfc','cruise_mach','cruise_alt_ft']],
'aircraft_drag_polar'=>['label'=>'Drag Polar','table'=>'aircraft_type_drag_polar','icon'=>'🌀','tier'=>'pro',
  'title'=>'icao_code','subtitle'=>'cd0_clean',
  'search'=>['icao_code'],
  'list'=>['icao_code','cd0_clean','k_clean','e_clean'],
  'detail'=>['icao_code','cd0_clean','k_clean','e_clean','cd0_gears',
    'flap_type','flap_lambda_f','flap_cf_c','flap_sf_s','last_modified'],
  'fields'=>['icao_code','cd0_clean','k_clean','e_clean','cd0_gears',
    'flap_type','flap_lambda_f','flap_cf_c','flap_sf_s']],
'aircraft_fuel_model'=>['label'=>'Fuel Models','table'=>'aircraft_type_fuel_model','icon'=>'⛽','tier'=>'pro',
  'title'=>'icao_code','subtitle'=>'c1',
  'search'=>['icao_code','engine_name'],
  'list'=>['icao_code','engine_name','c1','c2','c3'],
  'detail'=>['icao_code','engine_name','c1','c2','c3','last_modified'],
  'fields'=>['icao_code','engine_name','c1','c2','c3']],
```

### 1.5 Files Modified

- `database/01_schema.sql` — add CREATE TABLE IF NOT EXISTS for 3 new tables + ALTER TABLE for existing
- `includes/modules.php` — add 3 new module configs
- `scripts/ingest_openap_data.php` — new file
- `database/seeds/` — optional seed data from OpenAP

---

## Phase 2: Python API Service (~3 days)

### 2.1 Install OpenAP

```bash
pip install openap
```

### 2.2 Create API Service

File: `api/performance.py` (Flask/FastAPI)

Endpoints:

```
GET /api/performance/{icao}/info
  → aircraft specs, engine, drag polar, fuel model
  → Python: openap.prop.aircraft(icao)

GET /api/performance/{icao}/fuel-flow?mass=kg&alt=ft&tas=knots
  → fuel flow kg/s per engine
  → Python: openap.FuelFlow(icao).enroute(mass, tas, alt)

GET /api/performance/{icao}/thrust?alt=ft&mach=
  → thrust per engine N
  → Python: openap.Thrust(icao).cruise(alt, mach)

GET /api/performance/{icao}/drag?alt=ft&mach=&mass=kg
  → drag N
  → Python: openap.Drag(icao).cruise(alt, mach, mass)

GET /api/performance/{icao}/emissions?mass=kg&alt=ft&tas=knots&dist=nm
  → CO2, H2O, SOx (kg) for given flight segment
  → Python: openap.Emission(icao).non_co2(mass, tas, alt, dist)

GET /api/performance/{icao}/profile?origin=ICAO&dest=ICAO
  → climb/cruise/descent waypoints (WRAP kinematic model)
  → Python: openap.FlightGenerator(icao).trajectory(origin, dest)
```

### 2.3 PHP Bridge

In `includes/functions.php`:

```php
function openap_performance(string $icao, string $endpoint, array $params = []): ?array {
    $url = 'http://127.0.0.1:5000/api/performance/' . urlencode($icao) . '/' . $endpoint;
    if ($params) $url .= '?' . http_build_query($params);
    $ctx = stream_context_create(['http' => ['timeout' => 10]]);
    $json = @file_get_contents($url, false, $ctx);
    return $json ? json_decode($json, true) : null;
}
```

### 2.4 Systemd Service

File: `/etc/systemd/system/openap-api.service`

```
[Unit]
Description=OpenAP Performance API
After=network.target

[Service]
ExecStart=/usr/bin/python3 /home/ubuntu/angani-data-web/api/performance.py
WorkingDirectory=/home/ubuntu/angani-data-web/api
Restart=always
User=ubuntu

[Install]
WantedBy=multi-user.target
```

### 2.5 Files Created

- `api/performance.py`
- `api/requirements.txt`
- `api/README.md`

---

## Phase 3: Web UI Integration (~2 days)

### 3.1 Aircraft Type Detail — Performance Tab

In `aircraft_types` detail view (`index.php` or module template):

Add a tab/section with:
- **Specs card**: MTOW, OEW, MZFW, max fuel, wing area, span, MAC (from `aircraft_type_technical_specs`)
- **Drag polar card**: Cd0, K, e, gear drag (from `aircraft_type_drag_polar`)
- **Engine card**: Default engine, variants, thrust, SFC, BPR, emission indices (from `aircraft_type_engine_data` + `engine_models`)
- **Fuel model card**: Coefficients c1/c2/c3 (from `aircraft_type_fuel_model`)

### 3.2 Interactive Performance Calculator

Inline calculator form:
- Input: Aircraft mass (kg), Altitude (ft), True airspeed (knots), Distance (nm)
- Output from Python API:
  - Fuel flow (kg/h per engine, total)
  - Thrust (kN per engine, total)
  - Drag (kN)
  - CO2 emissions (kg) for segment
  - LTO fuel burn (kg)
- Cache API results in session or Redis to avoid repeated calls

### 3.3 Flight Profile Visualizer

Using a canvas/SVG chart:
- Plot altitude vs distance for a flight between two airports
- Show climb/cruise/descent phases
- Highlight fuel burn per phase

### 3.4 Files Modified

- `includes/modules.php` — add calculator endpoints to aircraft_types config
- `index.php` — add tabs to detail view
- `css/styles.css` — calculator form styles
- `js/performance-calc.js` — new file for AJAX calls + chart rendering

---

## Quick Reference: OpenAP ↔ DB Mapping

| OpenAP YAML Field | Our Table.Column | Notes |
|-------------------|-----------------|-------|
| `aircraft` | `aircraft_types.description` | |
| `mtow` | `aircraft_type_technical_specs.mtow_kg` | |
| `mlw` | NEW column | Max landing weight |
| `oew` | NEW column `oew_kg` | Operating empty weight |
| `mfc` | NEW column `max_fuel_capacity_kg` | Max fuel capacity |
| `vmo` | NEW column | Max operating speed |
| `mmo` | NEW column | Max mach |
| `ceiling` | NEW column | Service ceiling (currently ft) |
| `pax.max/low/high` | `aircraft_type_cabin_payload.max_capacity` | |
| `fuselage.length` | `aircraft_type_technical_specs.length_m` | |
| `fuselage.height` | NEW column | |
| `fuselage.width` | NEW column | Cabin width |
| `wing.area` | NEW column `wing_area_m2` | |
| `wing.span` | `aircraft_type_technical_specs.wingspan_m` | |
| `wing.mac` | NEW column `wing_mac_m` | Mean aerodynamic chord |
| `wing.sweep` | NEW column `wing_sweep_deg` | |
| `wing.t/c` | NEW column | Thickness/chord ratio |
| `drag.cd0` | `aircraft_type_drag_polar.cd0_clean` | |
| `drag.k` | `aircraft_type_drag_polar.k_clean` | Induced drag factor |
| `drag.e` | `aircraft_type_drag_polar.e_clean` | Oswald efficiency |
| `drag.gears` | `aircraft_type_drag_polar.cd0_gears` | Gear drag increment |
| `engine.default` | `aircraft_type_engine_data.engine_variants` | Linked to engine_models |
| `fuel.fuel_coef` | `aircraft_type_fuel_model.c1` | Primary coefficient |
| `cruise.height` | `aircraft_type_operational_performance.service_ceiling_ft` | |
| `cruise.mach` | `aircraft_type_operational_performance.cruise_speed_mach` | |
| `cruise.range` | `aircraft_type_operational_performance.max_range_nm` | |

---

## OpenAP Repository Structure

```
openap/
├── openap/
│   ├── data/
│   │   ├── aircraft/    # ~40 YAML files (a320.yml, b738.yml, ...)
│   │   ├── engine/      # engines.csv (ICAO databank)
│   │   ├── dragpolar/   # YAML files per type
│   │   ├── fuel/        # fuel_models.csv (polynomials)
│   │   ├── wrap/        # kinematic climb/descent data
│   │   └── nav/         # airports + waypoints
│   ├── prop.py          # Aircraft/engine property access
│   ├── aero.py          # Aeronautical conversions
│   ├── thrust.py        # Thrust() class
│   ├── drag.py          # Drag() class
│   ├── fuel.py          # FuelFlow() class
│   ├── emission.py      # Emission() class
│   ├── kinematic.py     # WRAP class
│   ├── phase.py         # FlightPhase() class
│   ├── gen.py           # FlightGenerator() class
│   ├── mass.py          # Mass model
│   └── contrail.py      # Contrail model
└── pyproject.toml
```
