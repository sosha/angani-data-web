SET NAMES utf8mb4;
START TRANSACTION;

-- Ensure useful East Africa / global starter airports exist for route demos.
INSERT INTO airports (country_code,iata_code,icao_code,airport_name,city_name,latitude,longitude,elevation_ft,slot_coordination_level,status,last_updated)
SELECT 'KE','NBO','HKJK','Jomo Kenyatta International Airport','Nairobi',-1.3192,36.9278,5330,'','active','2026-05'
WHERE NOT EXISTS (SELECT 1 FROM airports WHERE iata_code='NBO');
INSERT INTO airports (country_code,iata_code,icao_code,airport_name,city_name,latitude,longitude,elevation_ft,slot_coordination_level,status,last_updated)
SELECT 'KE','MBA','HKMO','Moi International Airport','Mombasa',-4.0348,39.5942,200,'','active','2026-05'
WHERE NOT EXISTS (SELECT 1 FROM airports WHERE iata_code='MBA');
INSERT INTO airports (country_code,iata_code,icao_code,airport_name,city_name,latitude,longitude,elevation_ft,slot_coordination_level,status,last_updated)
SELECT 'ET','ADD','HAAB','Addis Ababa Bole International Airport','Addis Ababa',8.9779,38.7993,7625,'','active','2026-05'
WHERE NOT EXISTS (SELECT 1 FROM airports WHERE iata_code='ADD');
INSERT INTO airports (country_code,iata_code,icao_code,airport_name,city_name,latitude,longitude,elevation_ft,slot_coordination_level,status,last_updated)
SELECT 'AE','DXB','OMDB','Dubai International Airport','Dubai',25.2532,55.3657,62,'','active','2026-05'
WHERE NOT EXISTS (SELECT 1 FROM airports WHERE iata_code='DXB');
INSERT INTO airports (country_code,iata_code,icao_code,airport_name,city_name,latitude,longitude,elevation_ft,slot_coordination_level,status,last_updated)
SELECT 'ZA','JNB','FAOR','O. R. Tambo International Airport','Johannesburg',-26.1337,28.2420,5558,'','active','2026-05'
WHERE NOT EXISTS (SELECT 1 FROM airports WHERE iata_code='JNB');
INSERT INTO airports (country_code,iata_code,icao_code,airport_name,city_name,latitude,longitude,elevation_ft,slot_coordination_level,status,last_updated)
SELECT 'UG','EBB','HUEN','Entebbe International Airport','Entebbe',0.0424,32.4435,3782,'','active','2026-05'
WHERE NOT EXISTS (SELECT 1 FROM airports WHERE iata_code='EBB');

-- Ensure core airlines exist for demo route markets.
INSERT INTO airlines (source_scope,country_code,region,name,iata_code,icao_code,callsign,fleet_size,destinations_count,status,status_bucket,hubs,alliance,data_source)
SELECT 'starter','KE','Africa','Kenya Airways','KQ','KQA','KENYA',34,45,'active','active','Nairobi Jomo Kenyatta International Airport','SkyTeam','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM airlines WHERE icao_code='KQA');
INSERT INTO airlines (source_scope,country_code,region,name,iata_code,icao_code,callsign,fleet_size,destinations_count,status,status_bucket,hubs,alliance,data_source)
SELECT 'starter','ET','Africa','Ethiopian Airlines','ET','ETH','ETHIOPIAN',140,130,'active','active','Addis Ababa Bole International Airport','Star Alliance','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM airlines WHERE icao_code='ETH');
INSERT INTO airlines (source_scope,country_code,region,name,iata_code,icao_code,callsign,fleet_size,destinations_count,status,status_bucket,hubs,alliance,data_source)
SELECT 'starter','AE','Asia','Emirates','EK','UAE','EMIRATES',260,130,'active','active','Dubai International Airport','','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM airlines WHERE icao_code='UAE');
INSERT INTO airlines (source_scope,country_code,region,name,iata_code,icao_code,callsign,fleet_size,destinations_count,status,status_bucket,hubs,alliance,data_source)
SELECT 'starter','KE','Africa','Jambojet','JM','JMA','JAMBOJET',8,9,'active','active','Nairobi Jomo Kenyatta International Airport','','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM airlines WHERE icao_code='JMA');
INSERT INTO airlines (source_scope,country_code,region,name,iata_code,icao_code,callsign,fleet_size,destinations_count,status,status_bucket,hubs,alliance,data_source)
SELECT 'starter','RW','Africa','RwandAir','WB','RWD','RWANDAIR',13,25,'active','active','Kigali International Airport','','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM airlines WHERE icao_code='RWD');

-- Ensure useful aircraft types exist.
INSERT INTO aircraft_types (aircraft_type,common_name,full_designation,manufacturer,model,iata_code,icao_code,engine_type,engine_count,max_pax,range_km,mtow_kg,status,record_status,source_url)
SELECT 'Boeing 787-8','B787-8','Boeing 787-8 Dreamliner','Boeing','787-8','788','B788','Jet',2,248,13620,227930,'active','starter',''
WHERE NOT EXISTS (SELECT 1 FROM aircraft_types WHERE icao_code='B788');
INSERT INTO aircraft_types (aircraft_type,common_name,full_designation,manufacturer,model,iata_code,icao_code,engine_type,engine_count,max_pax,range_km,mtow_kg,status,record_status,source_url)
SELECT 'Boeing 737-800','B737-800','Boeing 737-800','Boeing','737-800','738','B738','Jet',2,189,5436,79015,'active','starter',''
WHERE NOT EXISTS (SELECT 1 FROM aircraft_types WHERE icao_code='B738');
INSERT INTO aircraft_types (aircraft_type,common_name,full_designation,manufacturer,model,iata_code,icao_code,engine_type,engine_count,max_pax,range_km,mtow_kg,status,record_status,source_url)
SELECT 'Boeing 777-300ER','B777-300ER','Boeing 777-300ER','Boeing','777-300ER','77W','B77W','Jet',2,396,13650,351534,'active','starter',''
WHERE NOT EXISTS (SELECT 1 FROM aircraft_types WHERE icao_code='B77W');
INSERT INTO aircraft_types (aircraft_type,common_name,full_designation,manufacturer,model,iata_code,icao_code,engine_type,engine_count,max_pax,range_km,mtow_kg,status,record_status,source_url)
SELECT 'Embraer E190','E190','Embraer 190','Embraer','E190','E90','E190','Jet',2,114,4537,51800,'active','starter',''
WHERE NOT EXISTS (SELECT 1 FROM aircraft_types WHERE icao_code='E190');

-- Demo aircraft where not present.
INSERT INTO aircraft_registrations (country_code,icao_code,aircraft_type,registration,type_code,construction_number,age,operator_icao,operator_name,record_status,date_added,date_modified,data_source)
SELECT 'KE','B788','Boeing 787-8','5Y-KZA','B788','35510',11.4,'KQA','Kenya Airways','starter','2026-05','2026-05','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM aircraft_registrations WHERE registration='5Y-KZA');
INSERT INTO aircraft_registrations (country_code,icao_code,aircraft_type,registration,type_code,construction_number,age,operator_icao,operator_name,record_status,date_added,date_modified,data_source)
SELECT 'KE','E190','Embraer E190','5Y-KYF','E190','19000634',9.7,'KQA','Kenya Airways','starter','2026-05','2026-05','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM aircraft_registrations WHERE registration='5Y-KYF');
INSERT INTO aircraft_registrations (country_code,icao_code,aircraft_type,registration,type_code,construction_number,age,operator_icao,operator_name,record_status,date_added,date_modified,data_source)
SELECT 'AE','B77W','Boeing 777-300ER','A6-EQA','B77W','42331',7.2,'UAE','Emirates','starter','2026-05','2026-05','Angani starter seed'
WHERE NOT EXISTS (SELECT 1 FROM aircraft_registrations WHERE registration='A6-EQA');

-- Organisation layer.
INSERT INTO organisations (name, legal_name, organisation_type, country_code, website, status, description)
SELECT 'Kenya Airways','Kenya Airways PLC','airline','KE','https://www.kenya-airways.com','active','Starter organisation record linked to Kenya Airways.'
WHERE NOT EXISTS (SELECT 1 FROM organisations WHERE name='Kenya Airways');
INSERT INTO organisations (name, legal_name, organisation_type, country_code, website, status, description)
SELECT 'Ethiopian Airlines','Ethiopian Airlines Group','airline','ET','https://www.ethiopianairlines.com','active','Starter organisation record linked to Ethiopian Airlines.'
WHERE NOT EXISTS (SELECT 1 FROM organisations WHERE name='Ethiopian Airlines');
INSERT INTO organisations (name, legal_name, organisation_type, country_code, website, status, description)
SELECT 'Emirates','Emirates','airline','AE','https://www.emirates.com','active','Starter organisation record linked to Emirates.'
WHERE NOT EXISTS (SELECT 1 FROM organisations WHERE name='Emirates');
INSERT INTO organisations (name, legal_name, organisation_type, country_code, website, status, description)
SELECT 'Kenya Civil Aviation Authority','Kenya Civil Aviation Authority','regulator','KE','https://www.kcaa.or.ke','active','Civil aviation regulator starter record.'
WHERE NOT EXISTS (SELECT 1 FROM organisations WHERE name='Kenya Civil Aviation Authority');
INSERT INTO organisations (name, legal_name, organisation_type, country_code, website, status, description)
SELECT 'AerCap','AerCap Holdings N.V.','lessor','IE','https://www.aercap.com','active','Aircraft lessor starter record.'
WHERE NOT EXISTS (SELECT 1 FROM organisations WHERE name='AerCap');
INSERT INTO organisations (name, legal_name, organisation_type, country_code, website, status, description)
SELECT 'GE Aerospace','GE Aerospace','manufacturer','US','https://www.geaerospace.com','active','Engine manufacturer starter record.'
WHERE NOT EXISTS (SELECT 1 FROM organisations WHERE name='GE Aerospace');

INSERT IGNORE INTO organisation_roles (organisation_id, role_type)
SELECT id,'airline' FROM organisations WHERE name IN ('Kenya Airways','Ethiopian Airlines','Emirates');
INSERT IGNORE INTO organisation_roles (organisation_id, role_type)
SELECT id,'regulator' FROM organisations WHERE name='Kenya Civil Aviation Authority';
INSERT IGNORE INTO organisation_roles (organisation_id, role_type)
SELECT id,'lessor' FROM organisations WHERE name='AerCap';
INSERT IGNORE INTO organisation_roles (organisation_id, role_type)
SELECT id,'engine_manufacturer' FROM organisations WHERE name='GE Aerospace';

INSERT INTO lessors (organisation_id, headquarters_country_code, fleet_count, notes)
SELECT o.id,'IE',NULL,'Starter lessor record used to demonstrate aircraft lease/ownership schema.' FROM organisations o WHERE o.name='AerCap' AND NOT EXISTS (SELECT 1 FROM lessors l WHERE l.organisation_id=o.id);

-- Airport hub/base roles.
INSERT INTO airport_airline_roles (airport_id, airline_id, role_type, valid_from, source_id)
SELECT ap.id,a.id,'hub','1977-01-01',5 FROM airports ap JOIN airlines a ON a.icao_code='KQA' WHERE ap.iata_code='NBO' AND NOT EXISTS (SELECT 1 FROM airport_airline_roles WHERE airport_id=ap.id AND airline_id=a.id AND role_type='hub');
INSERT INTO airport_airline_roles (airport_id, airline_id, role_type, valid_from, source_id)
SELECT ap.id,a.id,'hub','1945-01-01',5 FROM airports ap JOIN airlines a ON a.icao_code='ETH' WHERE ap.iata_code='ADD' AND NOT EXISTS (SELECT 1 FROM airport_airline_roles WHERE airport_id=ap.id AND airline_id=a.id AND role_type='hub');
INSERT INTO airport_airline_roles (airport_id, airline_id, role_type, valid_from, source_id)
SELECT ap.id,a.id,'hub','1985-01-01',5 FROM airports ap JOIN airlines a ON a.icao_code='UAE' WHERE ap.iata_code='DXB' AND NOT EXISTS (SELECT 1 FROM airport_airline_roles WHERE airport_id=ap.id AND airline_id=a.id AND role_type='hub');
INSERT INTO airport_airline_roles (airport_id, airline_id, role_type, valid_from, source_id)
SELECT ap.id,a.id,'base','2014-01-01',5 FROM airports ap JOIN airlines a ON a.icao_code='JMA' WHERE ap.iata_code='NBO' AND NOT EXISTS (SELECT 1 FROM airport_airline_roles WHERE airport_id=ap.id AND airline_id=a.id AND role_type='base');

-- Route markets.
INSERT IGNORE INTO route_markets (origin_airport_id,destination_airport_id,route_type,distance_km,is_directional)
SELECT o.id,d.id,'international',3560,1 FROM airports o JOIN airports d ON o.iata_code='NBO' AND d.iata_code='DXB';
INSERT IGNORE INTO route_markets (origin_airport_id,destination_airport_id,route_type,distance_km,is_directional)
SELECT o.id,d.id,'regional',1160,1 FROM airports o JOIN airports d ON o.iata_code='NBO' AND d.iata_code='ADD';
INSERT IGNORE INTO route_markets (origin_airport_id,destination_airport_id,route_type,distance_km,is_directional)
SELECT o.id,d.id,'international',2910,1 FROM airports o JOIN airports d ON o.iata_code='NBO' AND d.iata_code='JNB';
INSERT IGNORE INTO route_markets (origin_airport_id,destination_airport_id,route_type,distance_km,is_directional)
SELECT o.id,d.id,'domestic',425,1 FROM airports o JOIN airports d ON o.iata_code='NBO' AND d.iata_code='MBA';
INSERT IGNORE INTO route_markets (origin_airport_id,destination_airport_id,route_type,distance_km,is_directional)
SELECT o.id,d.id,'regional',520,1 FROM airports o JOIN airports d ON o.iata_code='NBO' AND d.iata_code='EBB';

-- Airline services and schedules.
INSERT INTO airline_route_services (route_market_id,airline_id,flight_number_prefix,service_type,status,start_date,notes)
SELECT rm.id,a.id,'KQ','scheduled passenger','active','2024-01-01','Starter scheduled service for route intelligence demo.' FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id JOIN airlines a ON a.icao_code='KQA' WHERE o.iata_code='NBO' AND d.iata_code='DXB' AND NOT EXISTS (SELECT 1 FROM airline_route_services WHERE route_market_id=rm.id AND airline_id=a.id);
INSERT INTO airline_route_services (route_market_id,airline_id,flight_number_prefix,service_type,status,start_date,notes)
SELECT rm.id,a.id,'EK','scheduled passenger','active','2024-01-01','Starter competitor service.' FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id JOIN airlines a ON a.icao_code='UAE' WHERE o.iata_code='NBO' AND d.iata_code='DXB' AND NOT EXISTS (SELECT 1 FROM airline_route_services WHERE route_market_id=rm.id AND airline_id=a.id);
INSERT INTO airline_route_services (route_market_id,airline_id,flight_number_prefix,service_type,status,start_date,notes)
SELECT rm.id,a.id,'KQ','scheduled passenger','active','2024-01-01','Starter regional service.' FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id JOIN airlines a ON a.icao_code='KQA' WHERE o.iata_code='NBO' AND d.iata_code='ADD' AND NOT EXISTS (SELECT 1 FROM airline_route_services WHERE route_market_id=rm.id AND airline_id=a.id);
INSERT INTO airline_route_services (route_market_id,airline_id,flight_number_prefix,service_type,status,start_date,notes)
SELECT rm.id,a.id,'ET','scheduled passenger','active','2024-01-01','Starter competitor regional service.' FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id JOIN airlines a ON a.icao_code='ETH' WHERE o.iata_code='NBO' AND d.iata_code='ADD' AND NOT EXISTS (SELECT 1 FROM airline_route_services WHERE route_market_id=rm.id AND airline_id=a.id);
INSERT INTO airline_route_services (route_market_id,airline_id,flight_number_prefix,service_type,status,start_date,notes)
SELECT rm.id,a.id,'JM','scheduled passenger','active','2024-01-01','Starter domestic service.' FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id JOIN airlines a ON a.icao_code='JMA' WHERE o.iata_code='NBO' AND d.iata_code='MBA' AND NOT EXISTS (SELECT 1 FROM airline_route_services WHERE route_market_id=rm.id AND airline_id=a.id);
INSERT INTO airline_route_services (route_market_id,airline_id,flight_number_prefix,service_type,status,start_date,notes)
SELECT rm.id,a.id,'KQ','scheduled passenger','active','2024-01-01','Starter domestic competitor service.' FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id JOIN airlines a ON a.icao_code='KQA' WHERE o.iata_code='NBO' AND d.iata_code='MBA' AND NOT EXISTS (SELECT 1 FROM airline_route_services WHERE route_market_id=rm.id AND airline_id=a.id);

INSERT INTO route_schedule_patterns (airline_route_service_id,season,valid_from,valid_to,flight_number,departure_time_local,arrival_time_local,operating_days,frequency_per_week,source_id)
SELECT ars.id,'S26','2026-03-29','2026-10-24',CONCAT(ars.flight_number_prefix,'310'),'18:10:00','00:20:00','1234567',7,5 FROM airline_route_services ars WHERE NOT EXISTS (SELECT 1 FROM route_schedule_patterns WHERE airline_route_service_id=ars.id);

INSERT INTO route_service_equipment (airline_route_service_id,aircraft_type_id,usage_type,valid_from)
SELECT ars.id, atp.id, 'scheduled','2026-03-29' FROM airline_route_services ars JOIN airlines a ON a.id=ars.airline_id JOIN aircraft_types atp ON atp.icao_code=CASE WHEN a.icao_code='UAE' THEN 'B77W' WHEN a.icao_code='JMA' THEN 'B738' WHEN a.icao_code='ETH' THEN 'B788' ELSE 'B788' END WHERE NOT EXISTS (SELECT 1 FROM route_service_equipment WHERE airline_route_service_id=ars.id);

INSERT INTO route_traffic_statistics (route_market_id,airline_id,period_type,period_start,period_end,passengers,seats,cargo_tonnes,movements,load_factor,traffic_basis,source_id)
SELECT rm.id,NULL,'year','2025-01-01','2025-12-31',420000,580000,7800,2100,72.40,'estimated public market placeholder',5 FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id WHERE o.iata_code='NBO' AND d.iata_code='DXB' AND NOT EXISTS (SELECT 1 FROM route_traffic_statistics WHERE route_market_id=rm.id AND period_start='2025-01-01');
INSERT INTO route_traffic_statistics (route_market_id,airline_id,period_type,period_start,period_end,passengers,seats,cargo_tonnes,movements,load_factor,traffic_basis,source_id)
SELECT rm.id,NULL,'year','2025-01-01','2025-12-31',360000,510000,4600,1900,70.60,'estimated public market placeholder',5 FROM route_markets rm JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id WHERE o.iata_code='NBO' AND d.iata_code='ADD' AND NOT EXISTS (SELECT 1 FROM route_traffic_statistics WHERE route_market_id=rm.id AND period_start='2025-01-01');

-- Aircraft history starter records.
INSERT INTO aircraft_operator_history (aircraft_id, airline_id, start_date, end_date, operation_type, remarks, source_id)
SELECT ar.id,a.id,'2014-10-01',NULL,'owned/operated','Starter operator history row.',5 FROM aircraft_registrations ar JOIN airlines a ON a.icao_code='KQA' WHERE ar.registration='5Y-KZA' AND NOT EXISTS (SELECT 1 FROM aircraft_operator_history WHERE aircraft_id=ar.id AND airline_id=a.id);
INSERT INTO aircraft_ownership_history (aircraft_id, owner_organisation_id, start_date, end_date, ownership_type, source_id)
SELECT ar.id,o.id,'2014-10-01',NULL,'owned/financed',5 FROM aircraft_registrations ar JOIN organisations o ON o.name='Kenya Airways' WHERE ar.registration='5Y-KZA' AND NOT EXISTS (SELECT 1 FROM aircraft_ownership_history WHERE aircraft_id=ar.id AND owner_organisation_id=o.id);
INSERT INTO aircraft_lease_history (aircraft_id, lessor_organisation_id, lessee_airline_id, lease_type, start_date, end_date, lease_status, source_id)
SELECT ar.id,o.id,a.id,'operating_lease','2014-10-01',NULL,'active/sample',5 FROM aircraft_registrations ar JOIN organisations o ON o.name='AerCap' JOIN airlines a ON a.icao_code='KQA' WHERE ar.registration='5Y-KYF' AND NOT EXISTS (SELECT 1 FROM aircraft_lease_history WHERE aircraft_id=ar.id AND lessor_organisation_id=o.id);

INSERT INTO people (full_name,nationality_country_code,bio)
SELECT 'Sample Airline CEO','KE','Starter key staff record for demonstrating organisation_people.' WHERE NOT EXISTS (SELECT 1 FROM people WHERE full_name='Sample Airline CEO');
INSERT INTO organisation_people (organisation_id,person_id,title,department,role_type,start_date,is_current,source_id)
SELECT o.id,p.id,'Chief Executive Officer','Executive','CEO','2024-01-01',1,5 FROM organisations o JOIN people p ON p.full_name='Sample Airline CEO' WHERE o.name='Kenya Airways' AND NOT EXISTS (SELECT 1 FROM organisation_people WHERE organisation_id=o.id AND person_id=p.id AND role_type='CEO');

INSERT INTO entity_change_log (entity_type, entity_id, field_name, old_value, new_value, changed_at, change_source, confidence_score)
SELECT 'airline', a.id, 'fleet_size', '32', CAST(a.fleet_size AS CHAR), NOW(), 'starter_seed', 70.00 FROM airlines a WHERE a.icao_code='KQA' AND NOT EXISTS (SELECT 1 FROM entity_change_log WHERE entity_type='airline' AND entity_id=a.id AND field_name='fleet_size');

COMMIT;
