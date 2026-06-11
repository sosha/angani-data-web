# Modules Overview -- All Dataset Groups

The system has 80+ datasets organized into 8 groups, defined in `includes/modules.php`.

## Core (7 modules)

| Module Key | Table | Records | Tier | Content |
|------------|-------|---------|------|---------|
| `countries` | `countries` | 253 | Free | Country names, ISO codes, continent, UN region, flag, aviation description |
| `airlines` | `airlines` | 9,202 | Free | Airline names, IATA/ICAO codes, country, callsign, fleet size, status |
| `airports` | `airports` | 84,146 | Free | Airport ICAO/IATA, type, location, elevation, municipality, scheduled service |
| `aircraft` | `aircraft_registrations` | 35,522 | Pro | Aircraft by tail number, type, operator, age, construction number |
| `aircraft_types` | `aircraft_types` | 345 | Free | ICAO/IATA type codes, manufacturer, engine type, WTC |
| `lessors` | `lessors` | 35 | Pro | Aircraft lessors: name, HQ, fleet count, status |
| `routes` | `airline_route_services` | 0 | Pro | Flight schedules, service types, booking URLs |

## Airline Intelligence (8 modules)

| Key | Table | Records | Tier | Content |
|-----|-------|---------|------|---------|
| `airline_digital` | `airline_digital_properties` | 6,796 | Pro | Websites, social media, digital platforms |
| `frequent_flyer` | `frequent_flyer_programs` | 394 | Free | Loyalty programmes with points currency |
| `airline_fleet_list` | `airline_fleet_list` | 0 | Pro | Individual aircraft per airline fleet |
| `airline_fleet_summary` | `airline_fleet_summary` | 1,090 | Pro | Fleet composition by aircraft type |
| `airline_hubs` | `airline_hubs` | 222 | Pro | Hub airports and bases |
| `airline_it` | `airline_it_infrastructure` | 0 | Pro | IT systems (reservations, check-in, crew) |
| `airline_people` | `airline_key_personnel` | 0 | Pro | Executives and personnel |
| `airline_stats` | `airline_operational_stats` | 0 | Pro | Yearly pax, cargo, revenue, EBIT |

## Airport & Infrastructure (22 modules)

| Key | Table | Records | Tier | Content |
|-----|-------|---------|------|---------|
| `airport_frequencies` | `airport_frequencies` | 30,250 | Free | Radio frequencies (ATIS, TWR, GND, APP) |
| `airport_runways` | `airport_runways` | 0 | Pro | Runway ID, length, width, surface, ILS |
| `airport_terminals` | `airport_terminals` | 0 | Pro | Terminal names, capacity, gates |
| `airport_services` | `airport_services` | 0 | Pro | Services provided at airports |
| `airport_hubs` | `airport_hubs_and_airlines` | 0 | Pro | Hub/base airline relationships |
| `airport_financial` | `airport_financial_performance` | 0 | Pro | Revenue, profit/loss, investment |
| `airport_ground_handling` | `airport_ground_handling` | 0 | Pro | Ground handling companies |
| `airport_ground_transport` | `airport_ground_transport` | 0 | Pro | Ground transport modes/providers |
| `airport_it` | `airport_it_infrastructure` | 0 | Pro | IT systems and innovation notes |
| `airport_people` | `airport_key_personnel` | 0 | Pro | Key personnel contacts |
| `navaids` | `navaids` | 10,953 | Free | VOR, DME, NDB, ILS locations |
| `navaid_technical` | `navaid_technical` | 11,010 | Pro | Frequency, channel, morse code, signal |
| `navaid_operational` | `navaid_operational` | 11,010 | Pro | Service volume, range, status |
| `navaid_connectivity` | `navaid_connectivity` | 11,010 | Pro | Associated airports, airways |
| `navaid_references` | `navaid_references` | 11,010 | Pro | Additional notes, data sources |
| `notam_sources` | `notam_sources` | 8 | Free | NOTAM issuing authorities |
| `notams` | `notams` | 12 | Pro | NOTAM archive entries |
| `notam_classification` | `notam_classification` | 0 | Pro | Subject, purpose, scope codes |
| `notam_content` | `notam_content` | 0 | Pro | Raw/cleaned text, flight level limits |
| `notam_schedule` | `notam_schedule` | 0 | Pro | Start/end UTC, perm/temp flag |
| `notam_connectivity` | `notam_connectivity` | 0 | Pro | Associated airports, navaids, airways |
| `notam_references` | `notam_references` | 0 | Pro | Additional notes, data sources |

## Aircraft Intelligence (17 modules)

| Key | Table | Records | Tier | Content |
|-----|-------|---------|------|---------|
| `aircraft_manufacturers` | `aircraft_manufacturers` | 522 | Free | Manufacturer names, HQ, products |
| `aircraft_profile` | `aircraft_type_profile_data` | 0 | Pro | Role, powerplants, performance, history |
| `aircraft_assets` | `aircraft_type_assets` | 0 | Pro | Livery, LOPA, cockpit reference URLs |
| `aircraft_cabin_payload` | `aircraft_type_cabin_payload` | 0 | Pro | Seats by class, cargo volume, payload |
| `aircraft_engine_data` | `aircraft_type_engine_data` | 0 | Pro | Engine variants, thrust, fuel burn, SAF |
| `aircraft_economic_data` | `aircraft_type_economic_data` | 0 | Pro | List price, operating cost, lease rate |
| `aircraft_environmental` | `aircraft_type_environmental_data` | 0 | Pro | Carbon intensity, noise chapter |
| `aircraft_manufacturer_support` | `aircraft_type_manufacturer_support` | 0 | Pro | Production years, total built, MRO |
| `aircraft_performance` | `aircraft_type_operational_performance` | 0 | Pro | Range, ceiling, V-speeds, climb rate |
| `aircraft_runways` | `aircraft_type_runway_requirements` | 0 | Pro | Min takeoff/landing length, surface |
| `aircraft_technical_specs` | `aircraft_type_technical_specs` | 0 | Pro | MTOW, MZFW, empty weight, dimensions |
| `aircraft_models` | `aircraft_models` | 742 | Free | Model encyclopedia |
| `aircraft_model_history` | `aircraft_model_history` | 18 | Pro | Development story, milestones |
| `aircraft_model_capacity` | `aircraft_model_capacity` | 200 | Pro | Seating config, cargo volume |
| `aircraft_model_specs` | `aircraft_model_specs` | 400 | Pro | Powerplant, weights, dimensions |
| `aircraft_model_production` | `aircraft_model_production` | 20 | Pro | Units built, years, price |
| `aircraft_model_sources` | `aircraft_model_sources` | 0 | Pro | Source URLs, bibliography |

## Regulatory & Standards (12 modules)

| Key | Table | Records | Tier | Content |
|-----|-------|---------|------|---------|
| `regulatory` | `regulatory_records` | 160 | Pro | AOC numbers, status buckets |
| `regulatory_authorities` | `regulatory_authorities` | 233 | Free | Civil aviation authorities |
| `regulatory_economic` | `regulatory_economic_licensing` | 163 | Pro | License types, ownership limits |
| `regulatory_operational` | `regulatory_operational_certification` | 565 | Pro | AOC registry, aircraft limits |
| `regulatory_environmental` | `regulatory_environmental_security` | 0 | Pro | CORSIA, emissions, noise |
| `regulatory_references` | `regulatory_references` | 0 | Pro | Additional notes, cross-links |
| `regulatory_safety` | `regulatory_safety_oversight` | 0 | Pro | USOAP scores, authority |
| `regulatory_licensing` | `regulatory_licensing_categories` | 0 | Free | License categories, costs |
| `iata_membership` | `iata_membership_requirements` | 13 | Free | IATA membership rules |
| `iosa_registration` | `iosa_registration_steps` | 8 | Free | IOSA process steps |
| `airline_iata` | `airline_iata_membership` | 0 | Pro | Per-airline IATA status |
| `airline_iosa` | `airline_iosa_registration` | 0 | Pro | Per-airline IOSA status |

## Commercial (7 modules)

| Key | Table | Records | Tier | Content |
|-----|-------|---------|------|---------|
| `commercial_fares` | `commercial_fares` | 0 | Pro | Fares: origin/dest, base/total fare |
| `commercial_inventory` | `commercial_fare_inventory` | 0 | Pro | Cabin class, RBD, baggage |
| `commercial_rules` | `commercial_fare_rules` | 0 | Pro | Refundability, change fees |
| `commercial_taxes` | `commercial_taxes_fees` | 0 | Pro | Surcharges, taxes, fees |
| `commercial_yield` | `commercial_yield_analysis` | 0 | Pro | Yield per km, revenue per pax |
| `country_fare_policies` | `country_fare_policies` | 0 | Pro | Country-level fare policies |
| `gds` | `gds_systems` | 15 | Free | Amadeus, Sabre, Travelport |

## Reference (8 modules)

| Key | Table | Records | Tier | Content |
|-----|-------|---------|------|---------|
| `ref_country_codes` | `ref_country_codes` | 249 | Free | ISO codes + aircraft prefix |
| `ref_service_types` | `ref_service_types` | 12 | Free | Service type codes |
| `ref_meal_codes` | `ref_meal_service_codes` | 36 | Free | Meal service codes |
| `ref_booking_classes` | `ref_booking_classes` | 88 | Free | Booking/RBD class hierarchy |
| `ref_terminal_codes` | `ref_passenger_terminal_codes` | 12 | Free | Terminal/process codes |
| `ref_reject_reasons` | `ref_reject_reasons` | 12 | Free | Reject reason codes |
| `ref_phonetic` | `ref_phonetic_alphabet` | 26 | Free | NATO phonetic alphabet |
| `ref_timezones` | `ref_timezones` | — | Free | Timezone names and UTC offsets |

## Data Quality (6 modules)

| Key | Table | Records | Tier | Content |
|-----|-------|---------|------|---------|
| `dataset_files` | `dataset_files` | 0 | Pro | Import pipeline raw file records |
| `source_records` | `source_records` | 0 | Pro | Source record raw text/screenshots |
| `change_log` | `entity_change_log` | 0 | Pro | Field-level change tracking |
| `import_batches` | `import_batches` | 0 | Ultimate | Batch-level import metadata |
| `staging_records` | `staging_import_records` | 0 | Ultimate | Staged rows awaiting review |
| `export_logs` | `export_logs` | 0 | Ultimate | CSV/ZIP export history |

## Platform Tables (not in module list, used by auth/admin)

`users`, `subscription_tiers`, `tier_features`, `question_presets`, `insight_cards`, `data_reports`, `data_audit_log`, `data_table_provenance`, `data_licenses`, `pipeline_sources`, `pipeline_runs`, `email_providers`, `email_queue`, `admin_tasks`, `organisations`, `airline_destinations`
