# User Guide — Using the Angani Data Website

This guide explains everything about the public website. It assumes you are visiting the site for the first time and know nothing about aviation data.

---

## 1. Access Tiers

The system has three subscription levels:

| Tier | Cost | What You Get |
|------|------|-------------|
| **Free** | $0 | Access to core datasets: Countries, Airlines, Airports, Aircraft Types, Navaids, Reference tables, Frequent Flyer programmes, GDS systems. Search and browse. |
| **Pro** | Contact us | Everything in Free + Aircraft Registry, Lessors, Routes, all Aircraft Intelligence tables, all Airport Intelligence tables, all Commercial tables, all Regulatory tables, CSV export. |
| **Ultimate** | Contact us | Everything in Pro + bulk API access, custom dashboards, import pipeline tools, dedicated support. |

You can view the pricing page at `?page=pricing` to see current prices.

---

## 2. Navigation

The website has a top navigation bar with these items:

| Nav Item | Goes To | Description |
|----------|---------|-------------|
| **Home** | `?page=home` | Landing page with stats, insight cards, and module grid |
| **Countries** | `?page=countries` | Browse all countries aviation data |
| **Airlines** | `?page=airlines` | Browse airlines worldwide |
| **Airports** | `?page=airports` | Browse airports globally |
| **Aircraft Types** | `?page=aircraft_types` | Browse aircraft type models and specs |
| **Data Catalogue** | `?page=catalogue` | Full list of every dataset available |
| **Search** | (overlay) | Global search across all datasets |
| **Pricing** | `?page=pricing` | View subscription plans |
| **Log in / Account** | `?page=login` / `?page=account` | Authentication and profile |

On mobile phones, the navigation collapses into a hamburger menu (three horizontal lines).

---

## 3. Pages Explained

### 3.1 Home Page (`?page=home`)

The home page shows:
- **Hero section** — Welcome text and summary statistics (number of airlines, airports, aircraft types, navaids in the database)
- **Insight Cards** — Rotating data highlights (oldest aircraft, highest airports, navaid coverage by country, etc.). These are managed by administrators.
- **Module Grid** — All dataset groups shown as clickable cards (Core, Airline Intelligence, Airport & Infrastructure, Aircraft Intelligence, etc.)

Click any module card to see that dataset (e.g., click "Airlines" to browse all airlines).

### 3.2 Module Listing Pages

Each dataset (e.g. Airlines, Airports, Aircraft Types) has a listing page that shows records as interactive cards.

URL pattern: `?page={module_key}` e.g. `?page=airlines`, `?page=airports`, `?page=aircraft_types`

**Rich card modules** (Countries, Airlines, Airports, Aircraft Types, Aircraft Registry) use expandable cards:

1. **Card view** — Each record is shown as a card with key info (name, code, country, status)
2. **Click to expand** — Click any card to reveal more details inline (fleet info, hubs, related data)
3. **Click again** — Click the expanded card or the "Collapse" button to close it

**Other modules** (all Pro/Ultimate datasets) use a plain table view with pagination.

**Toolbar features:**
- **Search input** — Type to search within the dataset (searches by name, code, etc.)
- **Filter buttons** — Click pills to filter by continent, status, type (e.g., "Africa", "Active", "Large airports")
- **Country dropdown** — Some modules let you filter by country
- **Sort** — Change sort order (by name, last modified, etc.)
- **Reset** — Clear all filters

### 3.3 Detail Pages (`?page=detail&module={key}&id={id}`)

Clicking a record card takes you to a detail page with tabbed content. Each module has different tabs.

#### Countries detail tabs:
| Tab | What it shows |
|-----|--------------|
| **Overview** | Geography (name, continent, region, area, capital), Identity (ISO codes, languages, currency), Demographics (population, GDP), Aviation stats (airports, airlines) |
| **Details** | All raw fields from the database |
| **Airlines** | Airlines registered in this country |
| **Airports** | Airports in this country |
| **Regulatory** | Civil aviation authorities for this country |
| **Registry** | Aircraft registered in this country |
| **Navaids** | Navigation aids located in this country |
| **Statistics** | Bar chart + data table of GDP, population, passenger traffic, cargo over years |

#### Airlines detail tabs:
| Tab | What it shows |
|-----|--------------|
| **Overview** | Identity (name, IATA, ICAO, callsign), Location (country), Operations (fleet size, hubs, registry count), Memberships (IATA/IOSA status) |
| **Details** | All raw fields |
| **Digital** | Website, social media, digital properties |
| **Fleet** | Fleet list (tail numbers) and fleet summary (by aircraft type) |
| **Hubs** | Hub airports and bases |
| **Operations** | Yearly operational statistics (passengers, cargo, revenue) |
| **Commercial** | Frequent flyer programmes |
| **Regulatory** | IATA membership, IOSA registration, regulatory authority info |

#### Airports detail tabs:
| Tab | What it shows |
|-----|--------------|
| **Overview** | Basic details, country, elevation, type |
| **Details** | All raw fields |
| **Frequencies** | Radio frequencies (ATIS, Tower, Ground, etc.) |
| **Runways** | Runway info (length, surface, lighting, ILS) |
| **Terminals** | Terminal names, capacity, gates |
| **Hubs** | Airlines that use this airport as a hub |

#### Aircraft Types detail tabs:
| Tab | What it shows |
|-----|--------------|
| **Overview** | Basic specifications, manufacturer, codes |
| **Details** | All raw fields |
| **Profile** | Aircraft role, country of origin, performance, dimensions, production history |
| **Cabin & Payload** | Seat configuration (business/economy), max capacity, cargo volume, payload |
| **Engine** | Engine variants, type, count, thrust, fuel burn, SAF compatibility |
| **Specs** | Technical specs: weights (MTOW, MZFW, empty), wingspan, length, height |
| **Economic Data** | List price, operating cost per hour, lease rate, residual value |
| **Environmental** | Carbon intensity, noise chapter, fuel type |
| **Registry** | Aircraft registered in our database of this type |

#### Aircraft Registry detail tabs (Pro):
| Tab | What it shows |
|-----|--------------|
| **Overview** | Registration, aircraft type, operator, age, status |
| **Details** | All raw fields |
| **Same Type** | Other aircraft of the same make/model in the registry |

### 3.4 Search (`?page=search&q={term}`)

The global search bar (top of every page) searches across ALL datasets at once. It returns up to 5 results per module. Results are grouped by module and show:
- Record title and subtitle
- A preview of key fields
- Click to view the full detail page
- Lock icon for Pro results you cannot access

### 3.5 Data Catalogue (`?page=catalogue`)

Shows every dataset available in the system, organized by group:
- **Core** — Countries, Airlines, Airports, Aircraft Registry, Aircraft Types, Lessors, Routes
- **Airline Intelligence** — Digital properties, Fleet, Hubs, IT, Personnel, Stats
- **Airport & Infrastructure** — Frequencies, Runways, Terminals, Services, Financial, Navaids, NOTAMs
- **Aircraft Intelligence** — Profile, Cabin, Engine, Economics, Environmental, Performance, Specs, Models
- **Regulatory & Standards** — Regulatory records, Authorities, IATA/IOSA
- **Commercial** — Fares, Inventory, Rules, Taxes, Yield
- **Reference** — Country codes, Service types, Booking classes, Phonetic alphabet
- **Data Quality** — Dataset files, Sources, Change logs, Import/Export records

Each group shows the module count and click to browse.

### 3.6 Dashboard (`?page=dashboard`) — Logged-in users only

A personal dashboard with:
- Key stats (airlines, airports, aircraft types, dataset files)
- **Preset Questions** — Pre-defined intelligence questions (e.g., "Which aircraft need the shortest runways?", "Which countries have the most navaids?"). Click to run and see results.
- **Live Insight Cards** — The same rotating highlights from the home page
- **Global Search** — Same as the main search

### 3.7 Answer Page (`?page=answer&q={key}`) — Logged-in users only

Runs a preset question and shows results as:
- A horizontal bar chart (if applicable)
- A data table below

Use the "← Back to questions" link to return to the dashboard.

### 3.8 Pricing Page (`?page=pricing`)

Shows the three subscription tiers (Free, Pro, Ultimate) with features and pricing.

### 3.9 Account Page (`?page=account`) — Logged-in users only

Shows your profile (name, email) and current subscription tier. You can update your name here.

---

## 4. How to Log In / Register

1. Click **Log in** in the top navigation
2. If you don't have an account, click "Create account" link
3. Fill in name, email, and password (at least 8 characters)
4. Submit to create your Free account
5. You'll be automatically logged in

**Demo admin account**: `admin@angani.co.uk` / `Angani@2026`

---

## 5. Understanding Card Colors and Status

In the expandable card views, status is shown as colored chips:

| Chip Color | Meaning |
|-----------|---------|
| **Green** (`chip.ok`) | Active / Operational |
| **Red** (`chip.danger`) | Defunct / Inactive / Closed |
| **Gold** (`chip.gold`) | Special status (hub, premium, etc.) |

---

## 6. Using Filter Buttons

On module listing pages (e.g., Airlines), you'll see pill-shaped filter buttons:
- **Continent filters**: Africa, Asia, Europe, North America, South America, Oceania
- **Status filters**: Active, Defunct (for airlines)
- **Type filters**: Large airport, Medium airport, etc. (for airports)

**How they work:**
1. Click a filter pill to activate it (turns gold)
2. Only cards matching that filter remain visible
3. Click the active filter again to deactivate
4. Click "Reset" to clear all filters

Filters combine with search — you can filter by continent AND type a search term.

---

## 7. What Each Database Table Stores (Simplified)

For a complete reference, see the [Database Reference](database-reference.md). But here is what the main tables contain:

| Table | Stores | Example |
|-------|--------|---------|
| `countries` | Country names, ISO codes, continent, region | United Kingdom (GB) in Europe |
| `airlines` | Airline names, IATA/ICAO codes, country, active status | British Airways (BA/BAW) in GB |
| `airports` | Airport names, codes, location, type, elevation | Heathrow (LHR/EGLL) in GB |
| `aircraft_types` | Aircraft model names, manufacturer, codes, specs | Boeing 737-800 (B738) |
| `aircraft_registrations` | Individual aircraft by tail number, operator, age | G-EZAT (easyJet Airbus A319) |
| `airport_frequencies` | Radio frequencies at airports | LHR Tower 118.500 MHz |
| `airport_runways` | Runway physical characteristics | 27L 12,795ft asphalt |
| `navaids` | Navigation aids (VOR, NDB, DME) | LON VOR 113.60 MHz |
| `regulatory_authorities` | Civil aviation authorities worldwide | UK CAA |
| `airline_fleet_summary` | Airline fleet composition by aircraft type | BA has 12 A380s |
| `airline_fleet_list` | Individual aircraft in airline fleets | G-XLEA (BA A380) |

---

## 8. Tips and Tricks

- **Hard refresh**: If the page looks wrong or data seems missing, do a hard refresh (Ctrl+F5 or Cmd+Shift+R) to bypass browser cache.
- **Long press on card**: On mobile, tap and hold to see the detail link.
- **Search multiple terms**: The search finds partial matches, so "boeing 737" will find aircraft types with those words in any order.
- **No results?** The dataset might have no records for that filter combination, or the data might not have been imported yet.
- **Report a problem**: On any detail page, click "Report data problem" at the bottom to notify administrators about incorrect or outdated data.
