SET NAMES utf8mb4;
START TRANSACTION;

INSERT INTO subscription_tiers (id, code, name, description, monthly_usd, annual_usd, search_limit_daily, export_limit_monthly, api_limit_monthly, display_order, is_active) VALUES
(1,'free','Free','Public teasers, account dashboard, limited dataset browsing and selected preset questions.',0.00,0.00,25,0,0,10,1),
(2,'explorer','Explorer','For students, journalists and early researchers who need structured airline and airport reference data.',19.00,190.00,150,5,0,20,1),
(3,'analyst','Analyst','For consultants and commercial teams needing routes, schedules, regulatory views and CSV export.',49.00,499.00,600,40,0,30,1),
(4,'pro','Pro','For aviation professionals needing aircraft history, lessors, ownership, sources and deeper exports.',149.00,1490.00,2000,250,10000,40,1),
(5,'team','Team','For companies needing shared seats, API keys, watchlists and workflow access.',499.00,4990.00,10000,2000,100000,50,1),
(6,'enterprise','Enterprise','Custom data products, private dashboards, high-volume API access and advisory support.',1500.00,15000.00,999999,999999,999999,60,1)
ON DUPLICATE KEY UPDATE name=VALUES(name), description=VALUES(description), monthly_usd=VALUES(monthly_usd), annual_usd=VALUES(annual_usd), search_limit_daily=VALUES(search_limit_daily), export_limit_monthly=VALUES(export_limit_monthly), api_limit_monthly=VALUES(api_limit_monthly), display_order=VALUES(display_order), is_active=VALUES(is_active);

INSERT INTO tier_features (tier_id, feature_code, feature_label) VALUES
(1,'public_view','View public homepage insights and basic catalogue'),(1,'preset_questions','Use selected free preset questions'),(1,'basic_airline_search','Search public airline and airport lists'),
(2,'public_view','View public homepage insights and basic catalogue'),(2,'preset_questions','Use Explorer preset questions'),(2,'basic_airline_search','Search airlines, airports and aircraft types'),(2,'basic_exports','Limited CSV exports'),
(3,'public_view','View public homepage insights and basic catalogue'),(3,'preset_questions','Use Analyst preset questions'),(3,'basic_airline_search','Search all reference datasets'),(3,'route_intelligence','Routes, schedules, equipment and competitor view'),(3,'regulatory_intelligence','Regulatory records, AOCs and authority search'),(3,'csv_exports','Monthly CSV exports'),
(4,'public_view','View public homepage insights and basic catalogue'),(4,'preset_questions','Use Pro preset questions'),(4,'route_intelligence','Routes, schedules, equipment and competitor view'),(4,'regulatory_intelligence','Regulatory records, AOCs and authority search'),(4,'aircraft_history','Aircraft registration, ownership, lease, engine and cabin history'),(4,'source_history','Source records, confidence and change history'),(4,'api_access','API access for approved datasets'),
(5,'public_view','View public homepage insights and basic catalogue'),(5,'preset_questions','Use all team preset questions'),(5,'route_intelligence','Routes, schedules, equipment and competitor view'),(5,'regulatory_intelligence','Regulatory records, AOCs and authority search'),(5,'aircraft_history','Aircraft history and lessor exposure'),(5,'source_history','Source records and audit history'),(5,'api_access','Team API access'),(5,'team_seats','Multiple users and shared saved searches'),
(6,'public_view','View public homepage insights and basic catalogue'),(6,'preset_questions','Use all preset questions'),(6,'route_intelligence','Routes, schedules, equipment and competitor view'),(6,'regulatory_intelligence','Regulatory records and bilateral rights'),(6,'aircraft_history','Aircraft history and lessor exposure'),(6,'source_history','Source records and audit history'),(6,'api_access','Enterprise API access'),(6,'private_datasets','Custom/private datasets and advisory support')
ON DUPLICATE KEY UPDATE feature_label=VALUES(feature_label);

INSERT INTO users (id, name, email, password_hash, tier_id, role, status, email_verified_at, created_at, updated_at) VALUES
(1,'Angani Admin','admin@angani.co.uk','$2y$12$8xquwNly3mnAB52TJ9ANLev8xzWF3BsSveP8PdgY8lgcoyqVI8Mj2',6,'admin','active',NOW(),NOW(),NOW()),
(2,'Demo Analyst','analyst@angani.co.uk','$2y$12$8xquwNly3mnAB52TJ9ANLev8xzWF3BsSveP8PdgY8lgcoyqVI8Mj2',3,'user','active',NOW(),NOW(),NOW()),
(3,'Demo Pro','pro@angani.co.uk','$2y$12$8xquwNly3mnAB52TJ9ANLev8xzWF3BsSveP8PdgY8lgcoyqVI8Mj2',4,'user','active',NOW(),NOW(),NOW())
ON DUPLICATE KEY UPDATE name=VALUES(name), tier_id=VALUES(tier_id), role=VALUES(role), status=VALUES(status), updated_at=NOW();

INSERT INTO question_presets (code,title,question_text,category,answer_key,required_tier_id,display_order,is_active) VALUES
('routes_competitors','Which airlines compete on the same route?','Show route markets with operating airlines, equipment and competitor count.','Routes','route_competitors',3,10,1),
('oldest_aircraft','Which are the oldest aircraft in the database?','Rank aircraft records by recorded age and show aircraft type and operator.','Aircraft','oldest_aircraft',1,20,1),
('highest_airports','Which airports sit at the highest elevation?','Rank airports by elevation and show country/city context.','Airports','highest_airports',1,30,1),
('smallest_airlines','Which active airlines have the smallest fleet size?','Find active carriers with the lowest recorded fleet-size field.','Airlines','smallest_airlines_capacity',2,40,1),
('fleet_by_country','Which countries have the most aircraft records?','Summarise aircraft registrations by country and average recorded age.','Aircraft','fleet_by_country',3,50,1),
('regulatory_by_country','Where is the regulatory dataset deepest?','Show countries with the largest regulatory/AOC record counts and record types.','Regulatory','regulatory_by_country',3,60,1),
('hub_airlines','Which airlines use an airport as a hub, base or focus city?','List airport-airline roles such as hub, base, focus city or cargo hub.','Airports','hub_airlines',2,70,1),
('aircraft_history','What is the known operator history of aircraft in the database?','Display sample operator history rows for aircraft where historical data has been added.','Aircraft','aircraft_history',4,80,1),
('sources_to_review','What changed recently and what needs review?','Show latest field-level change logs for manual review and source control.','Data Quality','sources_to_review',4,90,1)
ON DUPLICATE KEY UPDATE title=VALUES(title), question_text=VALUES(question_text), category=VALUES(category), answer_key=VALUES(answer_key), required_tier_id=VALUES(required_tier_id), display_order=VALUES(display_order), is_active=VALUES(is_active), updated_at=NOW();

INSERT INTO insight_cards (title, metric_label, description, query_key, chart_type, required_tier_id, display_order, is_active, created_at, updated_at) VALUES
('Oldest aircraft records','Aircraft age','A rotating teaser showing the oldest recorded airframes in the database.', 'oldest_aircraft','ranked_bar',NULL,10,1,NOW(),NOW()),
('Highest airports','Airport elevation','Aviation geography can be interesting; rank airports by recorded elevation.', 'highest_airports','ranked_bar',NULL,20,1,NOW(),NOW()),
('Smallest active airlines','Fleet size','Show the smallest recorded active airlines by fleet size field.', 'smallest_airlines_capacity','ranked_bar',2,30,1,NOW(),NOW()),
('Competitive route markets','Routes','Markets where more than one airline is recorded as operating.', 'routes_with_competition','ranked_bar',3,40,1,NOW(),NOW()),
('Dataset coverage by category','Raw data','Which source categories contain the most rows and populated files.', 'dataset_coverage','ranked_bar',NULL,50,1,NOW(),NOW()),
('Regulatory depth by country','Regulatory','Countries with the largest number of regulatory/AOC records.', 'regulatory_depth','ranked_bar',3,60,1,NOW(),NOW());

INSERT INTO sources (id, source_name, source_type, base_url, reliability_score, licence_notes, scraping_allowed) VALUES
(1,'Wikipedia aviation pages','wikipedia','https://en.wikipedia.org/',70.00,'Use as a starting point; verify important commercial fields from primary sources.',1),
(2,'Airline official websites','airline_website',NULL,85.00,'Use public route, fleet and corporate pages subject to each website terms.',1),
(3,'Civil aviation authority websites','caa_website',NULL,92.00,'Primary source for AOC, regulatory and airport authority data.',1),
(4,'Airport official websites','airport_website',NULL,85.00,'Primary source for airport services, terminals and airlines served.',1),
(5,'Manual Angani research','manual_research',NULL,80.00,'Research manually entered or verified by Angani Data editors.',0)
ON DUPLICATE KEY UPDATE source_name=VALUES(source_name), source_type=VALUES(source_type), reliability_score=VALUES(reliability_score), licence_notes=VALUES(licence_notes), scraping_allowed=VALUES(scraping_allowed);

COMMIT;
