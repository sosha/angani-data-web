SET NAMES utf8mb4;
START TRANSACTION;

SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE tier_features;
TRUNCATE TABLE user_subscriptions;
TRUNCATE TABLE saved_searches;
TRUNCATE TABLE users;
TRUNCATE TABLE question_presets;
TRUNCATE TABLE insight_cards;
TRUNCATE TABLE subscription_tiers;
SET FOREIGN_KEY_CHECKS=1;

INSERT INTO subscription_tiers (id, code, name, description, monthly_usd, annual_usd, search_limit_daily, export_limit_monthly, api_limit_monthly, display_order, is_active) VALUES
(1,'free','Free','Public discovery, limited database browsing, reference lookup and teaser insights.',0.00,0.00,25,0,0,10,1),
(2,'pro','Pro','Paid self-service aviation intelligence: full standard databases, drill-downs, preset questions and controlled CSV exports.',49.00,499.00,1000,100,0,20,1),
(3,'enterprise','Enterprise','Contact us for API access, bulk exports, team accounts, private datasets and advisory support.',0.00,0.00,999999,999999,999999,30,1);

INSERT INTO tier_features (tier_id, feature_code, feature_label) VALUES
(1,'public_view','View public homepage insights and basic catalogue'),
(1,'reference_view','Search public aviation reference codes'),
(1,'limited_detail','Open limited record detail pages'),
(2,'public_view','View public homepage insights and catalogue'),
(2,'reference_view','Search aviation reference codes'),
(2,'full_detail','Open full record drill-down pages'),
(2,'preset_questions','Use all preset intelligence questions'),
(2,'route_intelligence','Routes, schedules, destinations, equipment and competitor views'),
(2,'aircraft_intelligence','Aircraft types, fleets, lessors, engines, cabin and performance data'),
(2,'regulatory_intelligence','Regulatory, IATA/IOSA, CAA and country profiles'),
(2,'csv_exports','Export filtered CSV records within monthly limits'),
(3,'public_view','View public homepage insights and catalogue'),
(3,'full_detail','Open full record drill-down pages'),
(3,'preset_questions','Use all preset intelligence questions'),
(3,'route_intelligence','Routes, schedules, destinations, equipment and competitor views'),
(3,'aircraft_intelligence','Aircraft types, fleets, lessors, engines, cabin and performance data'),
(3,'regulatory_intelligence','Regulatory, IATA/IOSA, CAA and country profiles'),
(3,'csv_exports','Bulk exports and scheduled extracts'),
(3,'api_access','API access for approved datasets'),
(3,'team_seats','Team accounts and role-based access'),
(3,'private_datasets','Custom/private datasets and advisory support');

INSERT INTO users (id, name, email, password_hash, tier_id, role, status, email_verified_at, created_at, updated_at) VALUES
(1,'Angani Admin','admin@angani.co.uk','$2y$12$8xquwNly3mnAB52TJ9ANLev8xzWF3BsSveP8PdgY8lgcoyqVI8Mj2',3,'admin','active',NOW(),NOW(),NOW()),
(2,'Demo Pro','pro@angani.co.uk','$2y$12$8xquwNly3mnAB52TJ9ANLev8xzWF3BsSveP8PdgY8lgcoyqVI8Mj2',2,'user','active',NOW(),NOW(),NOW()),
(3,'Demo Free','free@angani.co.uk','$2y$12$8xquwNly3mnAB52TJ9ANLev8xzWF3BsSveP8PdgY8lgcoyqVI8Mj2',1,'user','active',NOW(),NOW(),NOW());

INSERT INTO question_presets (code,title,question_text,category,answer_key,required_tier_id,display_order,is_active) VALUES
('routes_competitors','Which airlines compete on the same route?','Show route markets with operating airlines, equipment and competitor count.','Routes','route_competitors',2,10,1),
('oldest_aircraft','Which are the oldest aircraft in the database?','Rank aircraft records by recorded age and show aircraft type and operator.','Aircraft','oldest_aircraft',1,20,1),
('highest_airports','Which airports sit at the highest elevation?','Rank airports by elevation and show country/city context.','Airports','highest_airports',1,30,1),
('smallest_airlines','Which active airlines have the smallest fleet size?','Find active carriers with the lowest recorded fleet-size field.','Airlines','smallest_airlines_capacity',2,40,1),
('fleet_by_country','Which countries have the most aircraft records?','Summarise aircraft registrations by country and average recorded age.','Aircraft','fleet_by_country',2,50,1),
('regulatory_by_country','Where is the regulatory dataset deepest?','Show countries with the largest regulatory/AOC record counts and record types.','Regulatory','regulatory_by_country',2,60,1),
('hub_airlines','Which airlines use an airport as a hub, base or focus city?','List airport-airline roles such as hub, base, focus city or cargo hub.','Airports','hub_airlines',2,70,1),
('aircraft_type_short_runway','Which aircraft types are suitable for shorter runways?','Rank aircraft types by minimum takeoff and landing distance where populated.','Aircraft Types','short_runway_aircraft',2,80,1),
('engines_saf','Which aircraft types are SAF compatible?','List engine and fuel compatibility data by aircraft type.','Aircraft Types','saf_compatible_aircraft',2,90,1),
('sources_to_review','What changed recently and what needs review?','Show latest field-level change logs for manual review and source control.','Data Quality','sources_to_review',2,100,1);

INSERT INTO insight_cards (title, metric_label, description, query_key, chart_type, required_tier_id, display_order, is_active, created_at, updated_at) VALUES
('Oldest aircraft records','Aircraft age','A rotating teaser showing the oldest recorded airframes in the database.', 'oldest_aircraft','ranked_bar',NULL,10,1,NOW(),NOW()),
('Highest airports','Airport elevation','Rank airports by recorded elevation.', 'highest_airports','ranked_bar',NULL,20,1,NOW(),NOW()),
('Smallest active airlines','Fleet size','Show the smallest recorded active airlines by fleet size field.', 'smallest_airlines_capacity','ranked_bar',2,30,1,NOW(),NOW()),
('Competitive route markets','Routes','Markets where more than one airline is recorded as operating.', 'routes_with_competition','ranked_bar',2,40,1,NOW(),NOW()),
('Dataset coverage by category','Raw data','Which source categories contain the most rows and populated files.', 'dataset_coverage','ranked_bar',NULL,50,1,NOW(),NOW()),
('Regulatory depth by country','Regulatory','Countries with the largest number of regulatory/AOC records.', 'regulatory_depth','ranked_bar',2,60,1,NOW(),NOW()),
('Aircraft type runway requirements','Aircraft performance','Aircraft types ordered by minimum takeoff runway where populated.', 'short_runway_aircraft','ranked_bar',2,70,1,NOW(),NOW()),
('Navaid coverage','Infrastructure','Countries with the most recorded navaids.', 'navaid_coverage','ranked_bar',NULL,80,1,NOW(),NOW());

INSERT INTO sources (id, source_name, source_type, base_url, reliability_score, licence_notes, scraping_allowed) VALUES
(1,'Wikipedia aviation pages','wikipedia','https://en.wikipedia.org/',70.00,'Use as a starting point; verify important commercial fields from primary sources.',1),
(2,'Airline official websites','airline_website',NULL,85.00,'Use public route, fleet and corporate pages subject to each website terms.',1),
(3,'Civil aviation authority websites','caa_website',NULL,92.00,'Primary source for AOC, regulatory and airport authority data.',1),
(4,'Airport official websites','airport_website',NULL,85.00,'Primary source for airport services, terminals and airlines served.',1),
(5,'Manual Angani research','manual_research',NULL,80.00,'Research manually entered or verified by Angani Data editors.',0)
ON DUPLICATE KEY UPDATE source_name=VALUES(source_name), source_type=VALUES(source_type), reliability_score=VALUES(reliability_score), licence_notes=VALUES(licence_notes), scraping_allowed=VALUES(scraping_allowed);

INSERT INTO admin_tasks (category, task_title, description, status, priority, sort_order) VALUES
('Admin','Separate admin console from public frontend','Admin pages use their own sidebar, dense data tables and action bars.', 'done','critical',10),
('Admin','Add CRUD for every database module','Generic add/edit/list/delete/export/import is configured per table.', 'done','critical',20),
('Users','Add user management','Admins can edit tier, role and status for users.', 'done','critical',30),
('Access','Reduce tiers to Free, Pro, Enterprise','The confusing multi-tier model has been replaced with three plans.', 'done','critical',40),
('Data','Add Aircraft Types, Lessors, IATA/IOSA, GDS and Reference modules','All uploaded modules are represented in schema, admin and user views.', 'done','critical',50),
('Data','Add Infrastructure & AIM module','Navaids, frequencies and NOTAM source tables are defined.', 'done','high',60),
('UX','Make cards drill down to detail pages','Airline, airport, aircraft type and module records have clickable details.', 'done','high',70),
('UX','Hide internal fields from end users','IDs, raw import fields and timestamps are hidden or relabelled on public pages.', 'done','high',80),
('Imports','Support import/export','Admin upload and CSV exports are provided; users export through Pro/Enterprise access.', 'done','critical',90);

COMMIT;
