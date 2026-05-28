SET NAMES utf8mb4;
START TRANSACTION;
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE ref_country_codes;
TRUNCATE TABLE ref_service_types;
TRUNCATE TABLE ref_meal_service_codes;
TRUNCATE TABLE ref_booking_classes;
TRUNCATE TABLE ref_passenger_terminal_codes;
TRUNCATE TABLE ref_reject_reasons;
TRUNCATE TABLE ref_phonetic_alphabet;
TRUNCATE TABLE regulatory_licensing_categories;
TRUNCATE TABLE gds_systems;
TRUNCATE TABLE iata_membership_requirements;
TRUNCATE TABLE iosa_registration_steps;
TRUNCATE TABLE notam_sources;
TRUNCATE TABLE aircraft_type_assets;
TRUNCATE TABLE aircraft_type_cabin_payload;
TRUNCATE TABLE aircraft_type_economic_data;
TRUNCATE TABLE aircraft_type_engine_data;
TRUNCATE TABLE aircraft_type_environmental_data;
TRUNCATE TABLE aircraft_type_manufacturer_support;
TRUNCATE TABLE aircraft_type_operational_performance;
TRUNCATE TABLE aircraft_type_runway_requirements;
TRUNCATE TABLE aircraft_type_technical_specs;
TRUNCATE TABLE aircraft_models;
TRUNCATE TABLE aircraft_model_history;
TRUNCATE TABLE aircraft_model_capacity;
TRUNCATE TABLE aircraft_model_specs;
TRUNCATE TABLE aircraft_model_production;
TRUNCATE TABLE aircraft_model_sources;
TRUNCATE TABLE lessors;
TRUNCATE TABLE frequent_flyer_programs;
TRUNCATE TABLE commercial_fares;
TRUNCATE TABLE commercial_fare_inventory;
TRUNCATE TABLE commercial_fare_rules;
TRUNCATE TABLE commercial_taxes_fees;
TRUNCATE TABLE commercial_yield_analysis;
SET FOREIGN_KEY_CHECKS=1;
INSERT INTO ref_country_codes (country_name,alpha_2,alpha_3,numeric_code,aircraft_prefix) VALUES
('Andorra','AD',NULL,NULL,'C3'),
('United Arab Emirates','AE',NULL,NULL,'A6'),
('Afghanistan','AF',NULL,NULL,'YA'),
('Antigua and Barbuda','AG',NULL,NULL,'V2'),
('Anguilla','AI',NULL,NULL,'VP-A'),
('Albania','AL',NULL,NULL,'ZA'),
('Armenia','AM',NULL,NULL,'EK'),
('Angola','AO',NULL,NULL,NULL),
('Antarctica','AQ',NULL,NULL,NULL),
('Argentina','AR',NULL,NULL,'LQ, LV'),
('American Samoa','AS',NULL,NULL,'5W'),
('Austria','AT',NULL,NULL,NULL),
('Australia','AU',NULL,NULL,'VH'),
('Aruba','AW',NULL,NULL,'P4'),
('Åland Islands','AX',NULL,NULL,NULL),
('Azerbaijan','AZ',NULL,NULL,'4K'),
('Bosnia and Herzegovina','BA',NULL,NULL,'E7'),
('Barbados','BB',NULL,NULL,NULL),
('Bangladesh','BD',NULL,NULL,'S2'),
('Belgium','BE',NULL,NULL,'OO'),
('Burkina Faso','BF',NULL,NULL,NULL),
('Bulgaria','BG',NULL,NULL,'LZ'),
('Bahrain','BH',NULL,NULL,'A9C'),
('Burundi','BI',NULL,NULL,'9U'),
('Benin','BJ',NULL,NULL,'TY'),
('Saint Barthélemy','BL',NULL,NULL,NULL),
('Bermuda','BM',NULL,NULL,'VP-B,'),
('Brunei Darussalam','BN',NULL,NULL,'V8'),
('Bolivia, Plurinational State of','BO',NULL,NULL,NULL),
('Bonaire, Sint Eustatius and Saba','BQ',NULL,NULL,NULL),
('Brazil','BR',NULL,NULL,'PP, PR,'),
('Bahamas','BS',NULL,NULL,'C6'),
('Bhutan','BT',NULL,NULL,'A5'),
('Bouvet Island','BV',NULL,NULL,NULL),
('Botswana','BW',NULL,NULL,'A2'),
('Belarus','BY',NULL,NULL,'EW'),
('Belize','BZ',NULL,NULL,'V3'),
('Canada','CA',NULL,NULL,'C-F, C-'),
('Cocos (Keeling) Islands','CC',NULL,NULL,NULL),
('Congo, the Democratic Republic of the','CD',NULL,NULL,'Congo'),
('Central African Republic','CF',NULL,NULL,'TL'),
('Congo','CG',NULL,NULL,NULL),
('Switzerland','CH',NULL,NULL,'HB'),
('Côte d''Ivoire','CI',NULL,NULL,'TU'),
('Cook Islands','CK',NULL,NULL,'E5'),
('Chile','CL',NULL,NULL,'CC'),
('Cameroon','CM',NULL,NULL,'TJ'),
('China','CN',NULL,NULL,'B'),
('Colombia','CO',NULL,NULL,'HJ, HK'),
('Costa Rica','CR',NULL,NULL,'TI'),
('Cuba','CU',NULL,NULL,NULL),
('Cape Verde','CV',NULL,NULL,'D4'),
('Curaçao','CW',NULL,NULL,'PJ'),
('Christmas Island','CX',NULL,NULL,NULL),
('Cyprus','CY',NULL,NULL,'5B'),
('Czech Republic','CZ',NULL,NULL,'OK'),
('Germany','DE',NULL,NULL,'D'),
('Djibouti','DJ',NULL,NULL,'J2'),
('Denmark','DK',NULL,NULL,'OY'),
('Dominica','DM',NULL,NULL,'J7'),
('Dominican Republic','DO',NULL,NULL,'J7'),
('Algeria','DZ',NULL,NULL,'7T'),
('Ecuador','EC',NULL,NULL,'HC'),
('Estonia','EE',NULL,NULL,'ES'),
('Egypt','EG',NULL,NULL,NULL),
('Western Sahara','EH',NULL,NULL,NULL),
('Eritrea','ER',NULL,NULL,'E3'),
('Spain','ES',NULL,NULL,'EC'),
('Ethiopia','ET',NULL,NULL,NULL),
('Finland','FI',NULL,NULL,'OH'),
('Fiji','FJ',NULL,NULL,'DQ'),
('Falkland Islands (Malvinas)','FK',NULL,NULL,'VP-F'),
('Micronesia, Federated States of','FM',NULL,NULL,'V6'),
('Faroe Islands','FO',NULL,NULL,NULL),
('France','FR',NULL,NULL,'F'),
('Gabon','GA',NULL,NULL,NULL),
('United Kingdom','GB',NULL,NULL,'G'),
('Grenada','GD',NULL,NULL,'J3'),
('Georgia','GE',NULL,NULL,NULL),
('French Guiana','GF',NULL,NULL,NULL),
('Guernsey','GG',NULL,NULL,'2'),
('Ghana','GH',NULL,NULL,'9G'),
('Gibraltar','GI',NULL,NULL,NULL),
('Greenland','GL',NULL,NULL,NULL),
('Gambia','GM',NULL,NULL,'C5'),
('Guinea','GN',NULL,NULL,'3C'),
('Guadeloupe','GP',NULL,NULL,NULL),
('Equatorial Guinea','GQ',NULL,NULL,'3C'),
('Greece','GR',NULL,NULL,'SX'),
('South Georgia and the South Sandwich Islands','GS',NULL,NULL,NULL),
('Guatemala','GT',NULL,NULL,'TG'),
('Guam','GU',NULL,NULL,NULL),
('Guinea-Bissau','GW',NULL,NULL,NULL),
('Guyana','GY',NULL,NULL,'8R'),
('Hong Kong','HK',NULL,NULL,NULL),
('Heard Island and McDonald Islands','HM',NULL,NULL,NULL),
('Honduras','HN',NULL,NULL,'HR'),
('Croatia','HR',NULL,NULL,'9A'),
('Haiti','HT',NULL,NULL,'HH'),
('Hungary','HU',NULL,NULL,'HA'),
('Indonesia','ID',NULL,NULL,'PK'),
('Ireland','IE',NULL,NULL,'EI, EJ'),
('Israel','IL',NULL,NULL,'4X'),
('Isle of Man','IM',NULL,NULL,'M'),
('India','IN',NULL,NULL,'VT'),
('British Indian Ocean Territory','IO',NULL,NULL,'VT'),
('Iraq','IQ',NULL,NULL,NULL),
('Iran, Islamic Republic of','IR',NULL,NULL,'EP'),
('Iceland','IS',NULL,NULL,'TF'),
('Italy','IT',NULL,NULL,'I'),
('Jersey','JE',NULL,NULL,'ZJ'),
('Jamaica','JM',NULL,NULL,NULL),
('Jordan','JO',NULL,NULL,'JY'),
('Japan','JP',NULL,NULL,'JA'),
('Kenya','KE',NULL,NULL,NULL),
('Kyrgyzstan','KG',NULL,NULL,'EX'),
('Cambodia','KH',NULL,NULL,'XU'),
('Kiribati','KI',NULL,NULL,'T3'),
('Comoros','KM',NULL,NULL,'D6'),
('Saint Kitts and Nevis','KN',NULL,NULL,'V4'),
('Korea, Democratic People''s Republic of','KP',NULL,NULL,NULL),
('Korea, Republic of','KR',NULL,NULL,'P'),
('Kuwait','KW',NULL,NULL,'9K'),
('Cayman Islands','KY',NULL,NULL,'VP-C,'),
('Kazakhstan','KZ',NULL,NULL,'UP'),
('Lao People''s Democratic Republic','LA',NULL,NULL,NULL),
('Lebanon','LB',NULL,NULL,'OD'),
('Saint Lucia','LC',NULL,NULL,'J6'),
('Liechtenstein','LI',NULL,NULL,NULL),
('Sri Lanka','LK',NULL,NULL,'4R'),
('Liberia','LR',NULL,NULL,'A8'),
('Lesotho','LS',NULL,NULL,'7P'),
('Lithuania','LT',NULL,NULL,NULL),
('Luxembourg','LU',NULL,NULL,'LX'),
('Latvia','LV',NULL,NULL,NULL),
('Libya','LY',NULL,NULL,'5A'),
('Morocco','MA',NULL,NULL,'CN'),
('Monaco','MC',NULL,NULL,'3A'),
('Moldova, Republic of','MD',NULL,NULL,'ER'),
('Montenegro','ME',NULL,NULL,'4O'),
('Saint Martin (French part)','MF',NULL,NULL,NULL),
('Madagascar','MG',NULL,NULL,'5R'),
('Marshall Islands','MH',NULL,NULL,'V7'),
('Macedonia, the Former Yugoslav Republic of','MK',NULL,NULL,'Z3'),
('Mali','ML',NULL,NULL,'TZ'),
('Myanmar','MM',NULL,NULL,'XY'),
('Mongolia','MN',NULL,NULL,'JU, MT'),
('Macao','MO',NULL,NULL,NULL),
('Northern Mariana Islands','MP',NULL,NULL,'Congo'),
('Martinique','MQ',NULL,NULL,NULL),
('Mauritania','MR',NULL,NULL,'5T'),
('Montserrat','MS',NULL,NULL,NULL),
('Malta','MT',NULL,NULL,'9H'),
('Mauritius','MU',NULL,NULL,'3B'),
('Maldives','MV',NULL,NULL,'8Q'),
('Malawi','MW',NULL,NULL,NULL),
('Mexico','MX',NULL,NULL,NULL),
('Malaysia','MY',NULL,NULL,'9M'),
('Mozambique','MZ',NULL,NULL,'C9'),
('Namibia','NA',NULL,NULL,'V5'),
('New Caledonia','NC',NULL,NULL,NULL),
('Niger','NE',NULL,NULL,'5U'),
('Norfolk Island','NF',NULL,NULL,NULL),
('Nigeria','NG',NULL,NULL,'5U'),
('Nicaragua','NI',NULL,NULL,'YN'),
('Netherlands','NL',NULL,NULL,'Congo'),
('Norway','NO',NULL,NULL,NULL),
('Nepal','NP',NULL,NULL,'9N'),
('Nauru','NR',NULL,NULL,NULL),
('Niue','NU',NULL,NULL,NULL),
('New Zealand','NZ',NULL,NULL,'ZK, ZL,'),
('Oman','OM',NULL,NULL,'A4O'),
('Panama','PA',NULL,NULL,'HP'),
('Peru','PE',NULL,NULL,'OB'),
('French Polynesia','PF',NULL,NULL,NULL),
('Papua New Guinea','PG',NULL,NULL,NULL),
('Philippines','PH',NULL,NULL,'RP'),
('Pakistan','PK',NULL,NULL,'AP'),
('Poland','PL',NULL,NULL,'SP'),
('Saint Pierre and Miquelon','PM',NULL,NULL,NULL),
('Pitcairn','PN',NULL,NULL,NULL),
('Puerto Rico','PR',NULL,NULL,NULL),
('Palestine, State of','PS',NULL,NULL,NULL),
('Portugal','PT',NULL,NULL,NULL),
('Palau','PW',NULL,NULL,'T8A'),
('Paraguay','PY',NULL,NULL,'ZP'),
('Qatar','QA',NULL,NULL,'A7'),
('Réunion','RE',NULL,NULL,NULL),
('Romania','RO',NULL,NULL,'A4O'),
('Serbia','RS',NULL,NULL,'YU'),
('Russian Federation','RU',NULL,NULL,'RA'),
('Rwanda','RW',NULL,NULL,'9XR'),
('Saudi Arabia','SA',NULL,NULL,'HZ'),
('Solomon Islands','SB',NULL,NULL,'H4'),
('Seychelles','SC',NULL,NULL,'S7'),
('Sudan','SD',NULL,NULL,'ST'),
('Sweden','SE',NULL,NULL,'SE'),
('Singapore','SG',NULL,NULL,'9V'),
('Saint Helena, Ascension and Tristan da Cunha','SH',NULL,NULL,NULL),
('Slovenia','SI',NULL,NULL,NULL);
INSERT INTO ref_country_codes (country_name,alpha_2,alpha_3,numeric_code,aircraft_prefix) VALUES
('Svalbard and Jan Mayen','SJ',NULL,NULL,NULL),
('Slovakia','SK',NULL,NULL,'OM'),
('Sierra Leone','SL',NULL,NULL,NULL),
('San Marino','SM',NULL,NULL,'T7'),
('Senegal','SN',NULL,NULL,'6V, 6W'),
('Somalia','SO',NULL,NULL,'TZ'),
('Suriname','SR',NULL,NULL,'PZ'),
('South Sudan','SS',NULL,NULL,'ST'),
('Sao Tome and Principe','ST',NULL,NULL,'S9'),
('El Salvador','SV',NULL,NULL,'YS'),
('Sint Maarten (Dutch part)','SX',NULL,NULL,NULL),
('Syrian Arab Republic','SY',NULL,NULL,'YK'),
('Eswatini','SZ',NULL,NULL,NULL),
('Turks and Caicos Islands','TC',NULL,NULL,'VQ-T'),
('Chad','TD',NULL,NULL,'TT'),
('French Southern Territories','TF',NULL,NULL,'Congo'),
('Togo','TG',NULL,NULL,NULL),
('Thailand','TH',NULL,NULL,'HS'),
('Tajikistan','TJ',NULL,NULL,NULL),
('Tokelau','TK',NULL,NULL,NULL),
('Timor-Leste','TL',NULL,NULL,NULL),
('Turkmenistan','TM',NULL,NULL,NULL),
('Tunisia','TN',NULL,NULL,'TS'),
('Tonga','TO',NULL,NULL,'A3'),
('Turkey','TR',NULL,NULL,'TC'),
('Trinidad and Tobago','TT',NULL,NULL,'caa.gov.tt'),
('Tuvalu','TV',NULL,NULL,'T2'),
('Taiwan, Province of China','TW',NULL,NULL,'B'),
('Tanzania, United Republic of','TZ',NULL,NULL,'5H'),
('Ukraine','UA',NULL,NULL,'UR'),
('Uganda','UG',NULL,NULL,'5X'),
('United States Minor Outlying Islands','UM',NULL,NULL,'N'),
('United States','US',NULL,NULL,'N'),
('Uruguay','UY',NULL,NULL,NULL),
('Uzbekistan','UZ',NULL,NULL,'UK'),
('Holy See (Vatican City State)','VA',NULL,NULL,'HV'),
('Saint Vincent and the Grenadines','VC',NULL,NULL,'J8'),
('Venezuela, Bolivarian Republic of','VE',NULL,NULL,'YV'),
('Virgin Islands, British','VG',NULL,NULL,NULL),
('Virgin Islands, U.S.','VI',NULL,NULL,NULL),
('Viet Nam','VN',NULL,NULL,NULL),
('Vanuatu','VU',NULL,NULL,'YJ'),
('Wallis and Futuna','WF',NULL,NULL,NULL),
('Samoa','WS',NULL,NULL,'5W'),
('Yemen','YE',NULL,NULL,'7O'),
('Mayotte','YT',NULL,NULL,NULL),
('South Africa','ZA',NULL,NULL,'ZS, ZT,'),
('Zambia','ZM',NULL,NULL,'9J'),
('Zimbabwe','ZW',NULL,NULL,'Z');
INSERT IGNORE INTO countries (code,name,region,subregion) VALUES
('AD','Andorra',NULL,NULL),
('AE','United Arab Emirates',NULL,NULL),
('AF','Afghanistan',NULL,NULL),
('AG','Antigua and Barbuda',NULL,NULL),
('AI','Anguilla',NULL,NULL),
('AL','Albania',NULL,NULL),
('AM','Armenia',NULL,NULL),
('AO','Angola',NULL,NULL),
('AQ','Antarctica',NULL,NULL),
('AR','Argentina',NULL,NULL),
('AS','American Samoa',NULL,NULL),
('AT','Austria',NULL,NULL),
('AU','Australia',NULL,NULL),
('AW','Aruba',NULL,NULL),
('AX','Åland Islands',NULL,NULL),
('AZ','Azerbaijan',NULL,NULL),
('BA','Bosnia and Herzegovina',NULL,NULL),
('BB','Barbados',NULL,NULL),
('BD','Bangladesh',NULL,NULL),
('BE','Belgium',NULL,NULL),
('BF','Burkina Faso',NULL,NULL),
('BG','Bulgaria',NULL,NULL),
('BH','Bahrain',NULL,NULL),
('BI','Burundi',NULL,NULL),
('BJ','Benin',NULL,NULL),
('BL','Saint Barthélemy',NULL,NULL),
('BM','Bermuda',NULL,NULL),
('BN','Brunei Darussalam',NULL,NULL),
('BO','Bolivia, Plurinational State of',NULL,NULL),
('BQ','Bonaire, Sint Eustatius and Saba',NULL,NULL),
('BR','Brazil',NULL,NULL),
('BS','Bahamas',NULL,NULL),
('BT','Bhutan',NULL,NULL),
('BV','Bouvet Island',NULL,NULL),
('BW','Botswana',NULL,NULL),
('BY','Belarus',NULL,NULL),
('BZ','Belize',NULL,NULL),
('CA','Canada',NULL,NULL),
('CC','Cocos (Keeling) Islands',NULL,NULL),
('CD','Congo, the Democratic Republic of the',NULL,NULL),
('CF','Central African Republic',NULL,NULL),
('CG','Congo',NULL,NULL),
('CH','Switzerland',NULL,NULL),
('CI','Côte d''Ivoire',NULL,NULL),
('CK','Cook Islands',NULL,NULL),
('CL','Chile',NULL,NULL),
('CM','Cameroon',NULL,NULL),
('CN','China',NULL,NULL),
('CO','Colombia',NULL,NULL),
('CR','Costa Rica',NULL,NULL),
('CU','Cuba',NULL,NULL),
('CV','Cape Verde',NULL,NULL),
('CW','Curaçao',NULL,NULL),
('CX','Christmas Island',NULL,NULL),
('CY','Cyprus',NULL,NULL),
('CZ','Czech Republic',NULL,NULL),
('DE','Germany',NULL,NULL),
('DJ','Djibouti',NULL,NULL),
('DK','Denmark',NULL,NULL),
('DM','Dominica',NULL,NULL),
('DO','Dominican Republic',NULL,NULL),
('DZ','Algeria',NULL,NULL),
('EC','Ecuador',NULL,NULL),
('EE','Estonia',NULL,NULL),
('EG','Egypt',NULL,NULL),
('EH','Western Sahara',NULL,NULL),
('ER','Eritrea',NULL,NULL),
('ES','Spain',NULL,NULL),
('ET','Ethiopia',NULL,NULL),
('FI','Finland',NULL,NULL),
('FJ','Fiji',NULL,NULL),
('FK','Falkland Islands (Malvinas)',NULL,NULL),
('FM','Micronesia, Federated States of',NULL,NULL),
('FO','Faroe Islands',NULL,NULL),
('FR','France',NULL,NULL),
('GA','Gabon',NULL,NULL),
('GB','United Kingdom',NULL,NULL),
('GD','Grenada',NULL,NULL),
('GE','Georgia',NULL,NULL),
('GF','French Guiana',NULL,NULL),
('GG','Guernsey',NULL,NULL),
('GH','Ghana',NULL,NULL),
('GI','Gibraltar',NULL,NULL),
('GL','Greenland',NULL,NULL),
('GM','Gambia',NULL,NULL),
('GN','Guinea',NULL,NULL),
('GP','Guadeloupe',NULL,NULL),
('GQ','Equatorial Guinea',NULL,NULL),
('GR','Greece',NULL,NULL),
('GS','South Georgia and the South Sandwich Islands',NULL,NULL),
('GT','Guatemala',NULL,NULL),
('GU','Guam',NULL,NULL),
('GW','Guinea-Bissau',NULL,NULL),
('GY','Guyana',NULL,NULL),
('HK','Hong Kong',NULL,NULL),
('HM','Heard Island and McDonald Islands',NULL,NULL),
('HN','Honduras',NULL,NULL),
('HR','Croatia',NULL,NULL),
('HT','Haiti',NULL,NULL),
('HU','Hungary',NULL,NULL),
('ID','Indonesia',NULL,NULL),
('IE','Ireland',NULL,NULL),
('IL','Israel',NULL,NULL),
('IM','Isle of Man',NULL,NULL),
('IN','India',NULL,NULL),
('IO','British Indian Ocean Territory',NULL,NULL),
('IQ','Iraq',NULL,NULL),
('IR','Iran, Islamic Republic of',NULL,NULL),
('IS','Iceland',NULL,NULL),
('IT','Italy',NULL,NULL),
('JE','Jersey',NULL,NULL),
('JM','Jamaica',NULL,NULL),
('JO','Jordan',NULL,NULL),
('JP','Japan',NULL,NULL),
('KE','Kenya',NULL,NULL),
('KG','Kyrgyzstan',NULL,NULL),
('KH','Cambodia',NULL,NULL),
('KI','Kiribati',NULL,NULL),
('KM','Comoros',NULL,NULL),
('KN','Saint Kitts and Nevis',NULL,NULL),
('KP','Korea, Democratic People''s Republic of',NULL,NULL),
('KR','Korea, Republic of',NULL,NULL),
('KW','Kuwait',NULL,NULL),
('KY','Cayman Islands',NULL,NULL),
('KZ','Kazakhstan',NULL,NULL),
('LA','Lao People''s Democratic Republic',NULL,NULL),
('LB','Lebanon',NULL,NULL),
('LC','Saint Lucia',NULL,NULL),
('LI','Liechtenstein',NULL,NULL),
('LK','Sri Lanka',NULL,NULL),
('LR','Liberia',NULL,NULL),
('LS','Lesotho',NULL,NULL),
('LT','Lithuania',NULL,NULL),
('LU','Luxembourg',NULL,NULL),
('LV','Latvia',NULL,NULL),
('LY','Libya',NULL,NULL),
('MA','Morocco',NULL,NULL),
('MC','Monaco',NULL,NULL),
('MD','Moldova, Republic of',NULL,NULL),
('ME','Montenegro',NULL,NULL),
('MF','Saint Martin (French part)',NULL,NULL),
('MG','Madagascar',NULL,NULL),
('MH','Marshall Islands',NULL,NULL),
('MK','Macedonia, the Former Yugoslav Republic of',NULL,NULL),
('ML','Mali',NULL,NULL),
('MM','Myanmar',NULL,NULL),
('MN','Mongolia',NULL,NULL),
('MO','Macao',NULL,NULL),
('MP','Northern Mariana Islands',NULL,NULL),
('MQ','Martinique',NULL,NULL),
('MR','Mauritania',NULL,NULL),
('MS','Montserrat',NULL,NULL),
('MT','Malta',NULL,NULL),
('MU','Mauritius',NULL,NULL),
('MV','Maldives',NULL,NULL),
('MW','Malawi',NULL,NULL),
('MX','Mexico',NULL,NULL),
('MY','Malaysia',NULL,NULL),
('MZ','Mozambique',NULL,NULL),
('NA','Namibia',NULL,NULL),
('NC','New Caledonia',NULL,NULL),
('NE','Niger',NULL,NULL),
('NF','Norfolk Island',NULL,NULL),
('NG','Nigeria',NULL,NULL),
('NI','Nicaragua',NULL,NULL),
('NL','Netherlands',NULL,NULL),
('NO','Norway',NULL,NULL),
('NP','Nepal',NULL,NULL),
('NR','Nauru',NULL,NULL),
('NU','Niue',NULL,NULL),
('NZ','New Zealand',NULL,NULL),
('OM','Oman',NULL,NULL),
('PA','Panama',NULL,NULL),
('PE','Peru',NULL,NULL),
('PF','French Polynesia',NULL,NULL),
('PG','Papua New Guinea',NULL,NULL),
('PH','Philippines',NULL,NULL),
('PK','Pakistan',NULL,NULL),
('PL','Poland',NULL,NULL),
('PM','Saint Pierre and Miquelon',NULL,NULL),
('PN','Pitcairn',NULL,NULL),
('PR','Puerto Rico',NULL,NULL),
('PS','Palestine, State of',NULL,NULL),
('PT','Portugal',NULL,NULL),
('PW','Palau',NULL,NULL),
('PY','Paraguay',NULL,NULL),
('QA','Qatar',NULL,NULL),
('RE','Réunion',NULL,NULL),
('RO','Romania',NULL,NULL),
('RS','Serbia',NULL,NULL),
('RU','Russian Federation',NULL,NULL),
('RW','Rwanda',NULL,NULL),
('SA','Saudi Arabia',NULL,NULL),
('SB','Solomon Islands',NULL,NULL),
('SC','Seychelles',NULL,NULL),
('SD','Sudan',NULL,NULL),
('SE','Sweden',NULL,NULL),
('SG','Singapore',NULL,NULL),
('SH','Saint Helena, Ascension and Tristan da Cunha',NULL,NULL),
('SI','Slovenia',NULL,NULL);
INSERT IGNORE INTO countries (code,name,region,subregion) VALUES
('SJ','Svalbard and Jan Mayen',NULL,NULL),
('SK','Slovakia',NULL,NULL),
('SL','Sierra Leone',NULL,NULL),
('SM','San Marino',NULL,NULL),
('SN','Senegal',NULL,NULL),
('SO','Somalia',NULL,NULL),
('SR','Suriname',NULL,NULL),
('SS','South Sudan',NULL,NULL),
('ST','Sao Tome and Principe',NULL,NULL),
('SV','El Salvador',NULL,NULL),
('SX','Sint Maarten (Dutch part)',NULL,NULL),
('SY','Syrian Arab Republic',NULL,NULL),
('SZ','Eswatini',NULL,NULL),
('TC','Turks and Caicos Islands',NULL,NULL),
('TD','Chad',NULL,NULL),
('TF','French Southern Territories',NULL,NULL),
('TG','Togo',NULL,NULL),
('TH','Thailand',NULL,NULL),
('TJ','Tajikistan',NULL,NULL),
('TK','Tokelau',NULL,NULL),
('TL','Timor-Leste',NULL,NULL),
('TM','Turkmenistan',NULL,NULL),
('TN','Tunisia',NULL,NULL),
('TO','Tonga',NULL,NULL),
('TR','Turkey',NULL,NULL),
('TT','Trinidad and Tobago',NULL,NULL),
('TV','Tuvalu',NULL,NULL),
('TW','Taiwan, Province of China',NULL,NULL),
('TZ','Tanzania, United Republic of',NULL,NULL),
('UA','Ukraine',NULL,NULL),
('UG','Uganda',NULL,NULL),
('UM','United States Minor Outlying Islands',NULL,NULL),
('US','United States',NULL,NULL),
('UY','Uruguay',NULL,NULL),
('UZ','Uzbekistan',NULL,NULL),
('VA','Holy See (Vatican City State)',NULL,NULL),
('VC','Saint Vincent and the Grenadines',NULL,NULL),
('VE','Venezuela, Bolivarian Republic of',NULL,NULL),
('VG','Virgin Islands, British',NULL,NULL),
('VI','Virgin Islands, U.S.',NULL,NULL),
('VN','Viet Nam',NULL,NULL),
('VU','Vanuatu',NULL,NULL),
('WF','Wallis and Futuna',NULL,NULL),
('WS','Samoa',NULL,NULL),
('YE','Yemen',NULL,NULL),
('YT','Mayotte',NULL,NULL),
('ZA','South Africa',NULL,NULL),
('ZM','Zambia',NULL,NULL),
('ZW','Zimbabwe',NULL,NULL);
INSERT INTO ref_service_types (service_type_code,application,type_of_operation,service_type,description) VALUES
('J','Scheduled','Passenger','Normal Service',NULL),
('S','Scheduled','Passenger','Shuttle Mode',NULL),
('U','Scheduled','Passenger','Service operated by Surface Vehicle',NULL),
('F','Scheduled','Cargo/Mail','Loose Loaded cargo and/or preloaded devices',NULL),
('V','Scheduled','Cargo/Mail','Service operated by Surface Vehicle',NULL),
('M','Scheduled','Cargo/Mail','Mail only',NULL),
('Q','Scheduled','Passenger/Cargo','Passenger/Cargo in Cabin (mixed configuration aircraft)',NULL),
('G','Additional Flights','Passenger','Normal Service',NULL),
('B','Additional Flights','Passenger','Shuttle Mode',NULL),
('A','Additional Flights','Cargo/Mail','Cargo/Mail',NULL),
('R','Additional Flights','Passenger/Cargo','Passenger/Cargo in Cabin (mixed configuration aircraft)',NULL),
('C','Charter','Passenger','Passenger Only',NULL),
('O','Charter','Special Handling','Charter requiring special handling (e.g. Migrants/immigrant Flights)',NULL),
('H','Charter','Cargo/Mail','Cargo and /or Mail',NULL),
('L','Charter','Passenger/Cargo/Mail','Passenger and Cargo and/or Mail',NULL),
('P','Others','Not specific','Non-revenue (Positioning/Ferry/Delivery/Demo)',NULL),
('T','Others','Not specific','Technical Test',NULL),
('K','Others','Not specific','Training (School/Crew check)',NULL),
('D','Others','Not specific','General Aviation',NULL),
('E','Others','Not specific','Special (FAA/Government)',NULL),
('W','Others','Not specific','Military',NULL),
('X','Others','Not specific','Technical Stop',NULL),
('I','Others','Not specific','State/Diplomatic/Air Ambulance',NULL),
('N','Others','Not specific','Business Aviation/Air Taxi',NULL);
INSERT INTO ref_meal_service_codes (code,meaning) VALUES
('B','Breakfast'),
('C','Alcoholic Beverages — Complimentary'),
('D','Dinner'),
('F','Food for Purchase'),
('G','Food and Beverages for Purchase'),
('H','Hot Meal'),
('K','Continental Breakfast'),
('L','Lunch'),
('M','Meal (to be used as a generalization if no specific meal is intended)'),
('N','No Meal Service'),
('O','Cold Meal'),
('P','Alcoholic Beverages for Purchase'),
('R','Refreshments — Complimentary'),
('S','Snack or Brunch'),
('V','Refreshments for Purchase');
INSERT INTO ref_booking_classes (category,class_code,description,class_type,rank_order) VALUES
('ECONOMY','N','Lowest published fares','Public',1),
('ECONOMY','Q','Highly restricted discount','Public',2),
('ECONOMY','T','Cheap leisure fares','Public',3),
('ECONOMY','V','Cheap leisure fares','Public',4),
('ECONOMY','L','Cheap leisure fares','Public',5),
('ECONOMY','K','Cheap leisure fares','Public',6),
('ECONOMY','H','Semi-flexible fares','Public',7),
('ECONOMY','M','Semi-flexible fares','Public',8),
('ECONOMY','B','Flexible economy','Public',9),
('ECONOMY','Y','Full fare economy','Public',10),
('PREMIUM ECONOMY','W','Discount premium economy','Public',11),
('PREMIUM ECONOMY','E','Premium economy / Corporate fares','Public',12),
('PREMIUM ECONOMY','P','Highest premium economy OR discounted business','Public',13),
('BUSINESS CLASS','Z','Discount business','Public',14),
('BUSINESS CLASS','D','Semi-flex business','Public',15),
('BUSINESS CLASS','C','Full business','Public',16),
('BUSINESS CLASS','J','Highest business','Public',17),
('FIRST CLASS','A','Discounted first class','Public',18),
('FIRST CLASS','F','Full fare first class - highest overall','Public',19),
('UPGRADE','R','Upgrade inventory (premium cabins',' often business/first upgrades)',NULL),
('UPGRADE','U','Upgrade inventory (economy to business upgrades)','Special',21),
('GROUP','G','Group bookings','Special',22),
('AWARD','X','Economy award tickets','Special',23),
('AWARD','I','Business award tickets','Special',24),
('AWARD','O','First class awards','Special',25),
('STAFF','S','Staff','Non-revenue',26);
INSERT INTO ref_passenger_terminal_codes (code,meaning) VALUES
('I','International'),
('D','Domestic'),
('E','East'),
('N','North'),
('S','South or Satellite'),
('W','West'),
('L','Budget/Low Cost'),
('U','Shuttle'),
('M','Main, Central etc.'),
('H','Charter'),
('R','Regional/Commuter'),
('Z','Other. (Z has been assigned to all other terminal identifications such as Marine, Inter-Island etc.)');
INSERT INTO ref_reject_reasons (reject_reason) VALUES
('ACTION IDENTIFIER INVALID'),
('ACV CODE INVALID'),
('AIRCRAFT TYPE INVALID'),
('AIRLINE DESIGNATOR INVALID'),
('AIRLINE DESIGNATOR IS REQUIRED'),
('DATE DISCREPANCY INVALID'),
('DATE INVALID'),
('DATE OF ARRIVAL INVALID'),
('DATE OF DEPARTURE INVALID'),
('DATE VARIATION INVALID'),
('DAYS OF OPERATION INVALID'),
('DAYS/DATES OVERLAPPING'),
('DEI 2/3/4/5/9 AIRLINE DESIGNATOR INVALID'),
('DEI 7 INVALID'),
('DEI 7 WITH INVALID CLASS'),
('DEI 710/711 INVALID'),
('DEI 8 CODE INVALID'),
('DEI 8 CONFLICT'),
('DEI 8 TRAFFIC RESTRICTION TYPE INVALID'),
('DEI 10 AND 50 NOT ALLOWED ON SAME LEG'),
('DEI 98/99 CONFLICT'),
('DEI 113/114/115 IS REQUIRED'),
('DEI 127 IS REQUIRED'),
('DEI 201 INVALID'),
('DEI 501 CONFLICT'),
('DEI 502 CONFLICT'),
('DEI 503 CODE INVALID'),
('DEI 504 CODE INVALID'),
('DEI 505 CODE INVALID'),
('DEI DUPLICATION'),
('DEI FORMAT ERROR'),
('DEI IS REQUIRED'),
('DEI NOT ALLOWED IN SEGMENT INFORMATION'),
('DEI NOT ALLOWED ON FIRST LEG'),
('DEI NOT ALLOWED ON SEGMENT'),
('DEI NUMBER INVALID'),
('DEI SEGMENT/LEG INVALID'),
('DEI TEXT IS REQUIRED'),
('DEI WITH NIL NOT ALLOWED'),
('EQUIPMENT CHANGE NOT ALLOWED'),
('EQUIPMENT CHANGE USED TOO MANY TIMES'),
('EQUIPMENT DATA IS REQUIRED'),
('FLIGHT ARRIVAL — ONLY ONE PER AIRPORT PER DAY'),
('FLIGHT DEPARTURE — ONLY ONE PER AIRPORT PER DAY'),
('FLIGHT DESIGNATOR IS REQUIRED'),
('FLIGHT DOES NOT OPERATE FOR DATE AND FREQUENCY'),
('FLIGHT NUMBER INVALID'),
('FLIGHT/DATE LIMITED TO ONE OCCURRENCE'),
('INTERNAL PROCESSING ERROR — PLEASE RESUBMIT'),
('LEG CHANGE NOT ALLOWED'),
('LEG DATA CANNOT BE COMPLETELEY DELETED'),
('LEG DATA CONFLICT WITH EXISTING SCHEDULE'),
('LEG DATA INVALID'),
('LEG DATA IS REQUIRED'),
('LEG NUMBER GREATER THAN MAXIMUM ALLOWED'),
('MESSAGE FUNCTION INVALID'),
('MESSAGE SEQUENCE REFERENCE INVALID'),
('ON-TIME PERFORMANCE INVALID'),
('ON-TIME PERFORMANCE INDICATOR FOR DELAYS & CANCELLATIONS INVALID'),
('OPERATIONAL SUFFIX INVALID'),
('PERIOD — FREQUENCY RATE INVALID'),
('PERIOD OF OPERATION INVALID'),
('PERIOD OF SCHEDULE VALIDITY INVALID'),
('PERIOD OUTSIDE SYSTEM DATA RANGE'),
('PERIOD/FREQUENCY CONFLICT WITH EXISTING'),
('PERIOD/FREQUENCY NOT ALLOWED'),
('PRBD DUPLICATION'),
('PRBD INVALID'),
('PRBD/PRBM OR ACV DO NOT MATCH'),
('PRBM INVALID'),
('REPEAT REQUEST — UPDATING IN PROGRESS'),
('RTNS NOT USED PROPERLY'),
('SECONDARY ACTION IDENTIFIER INVALID'),
('SECURE FLIGHT INDICATOR INVALID'),
('SERVICE TYPE CODE INVALID'),
('STATION CODE INVALID'),
('STATION OF ARRIVAL INVALID'),
('STATION OF DEPARTURE DIFFERS FROM PREVIOUS ARRIVAL'),
('STATION OF DEPARTURE INVALID'),
('TERMINAL CODE INVALID'),
('TIME INVALID'),
('TIME MODE INVALID'),
('TIME OF ARRIVAL INVALID'),
('TIME OF DEPARTURE EARLIER THAN PREVIOUS ARRIVAL'),
('TIME OF DEPARTURE INVALID'),
('UNAUTHORISED TO AMEND THIS FLIGHT'),
('UTC/LT VARIATION INVALID'),
('XASM NOT USED PROPERLY');
INSERT INTO ref_phonetic_alphabet (character_code,phonetic) VALUES
('A','Alfa'),
('B','Bravo'),
('C','Charlie'),
('D','Delta'),
('E','Echo'),
('F','Foxtrot'),
('G','Golf'),
('H','Hotel'),
('I','India'),
('J','Juliett'),
('K','Kilo'),
('L','Lima'),
('M','Mike'),
('N','November'),
('O','Oscar'),
('P','Papa'),
('Q','Quebec'),
('R','Romeo'),
('S','Sierra'),
('T','Tango'),
('U','Uniform'),
('V','Victor'),
('W','Whiskey'),
('X','X-ray'),
('Y','Yankee'),
('Z','Zulu'),
('0','Zero'),
('1','One'),
('2','Two'),
('3','Three'),
('4','Four'),
('5','Five'),
('6','Six'),
('7','Seven'),
('8','Eight'),
('9','Nine');
INSERT INTO gds_systems (gds_code,company,region,notes) VALUES
('1A','Amadeus IT Group','Global','Headquartered in Madrid, Spain. Largest GDS by market share.'),
('1B','Sabre Travel Network Asia-Pacific (Abacus)','Asia-Pacific','Formerly Abacus International; integrated into Sabre.'),
('1E','Travelsky Technology','China','State-owned GDS operated by Civil Aviation Administration of China (CAAC).'),
('1F','Infini Travel Information Inc.','Japan','Joint venture between Sabre and All Nippon Airways (ANA).'),
('1G','Travelport (Galileo)','Global','Galileo core system operated by Travelport.'),
('1H','Sirena Travel','Russia / CIS','GDS serving Russian and CIS markets.'),
('1J','PT. Navios Evolusi Solusindo','Indonesia','Regional GDS serving Indonesian market.'),
('1K','MixVel / Southern Cross Distribution','Russia / Australia','Dual-use code; MixVel in Russia, Southern Cross Distribution in Australia.'),
('1M','Online Reservation System JSC','Russia','Russian domestic reservation system.'),
('1P','Travelport (Worldspan)','Global','Worldspan core system operated by Travelport.'),
('1Q','Sirena-Travel (alternate)','Russia','Alternate code used by Sirena-Travel for specific markets.'),
('1S','Sabre Travel Network','Global','Headquartered in Southlake, Texas, USA.'),
('1V','Travelport (Apollo)','Global','Apollo core system operated by Travelport.'),
('1W','Travelport (combined)','Global','Combined Travelport platform code.'),
('1Z','Sabre Pacific','Asia-Pacific','Sabre distribution platform for Asia-Pacific region.');
INSERT INTO iata_membership_requirements (section,detail,description,sort_order) VALUES
('ELIGIBILITY','IOSA Registration','Airline must have a valid IATA Operational Safety Audit (IOSA) registration.',0),
('ELIGIBILITY','Operation','Must operate scheduled or non-scheduled air services.',0),
('APPLICATION PROCEDURE','Submission','Complete the application form signed by the airline''s Chief Executive Officer (CEO).',0),
('APPLICATION PROCEDURE','Review','The application is submitted to the IATA Director General for consideration and approval once received.',0),
('APPLICATION PROCEDURE','Payment','Receipt of funds for the annual dues must be confirmed before final approval.',0),
('ANNUAL MEMBERSHIP DUES','Fixed Fee','A flat annual amount paid by all IATA members.',0),
('ANNUAL MEMBERSHIP DUES','Variable Fee','Proportional amount based on international traffic volume (RTK).',0),
('ANNUAL MEMBERSHIP DUES','Calculation','Calculated based on Revenue Tonne Kilometres (RTK) with weightings for passenger and cargo.',0),
('ANNUAL MEMBERSHIP DUES','Settlement','Invoice submitted for IATA Clearing House (ICH) settlement after confirmation.',0),
('APPROVAL PROCESS','Director General','Final approval granted by the IATA Director General.',0),
('APPROVAL PROCESS','Notification','Membership team sends confirmation of membership letter to the applicant CEO.',0),
('CONTACTS','Membership Team','membership@iata.org',0),
('CONTACTS','Website','www.iata.org/membership',0);
INSERT INTO iosa_registration_steps (step,action,description,sort_order) VALUES
('1. Preparation','Airline Assessment','Airlines must assess their operation and ensure conformity with IOSA Standards and Recommended Practices (ISARPs).',1),
('2. Documentation Review','Audit Request','Airline requests an audit by a third-party Audit Organization (AO).',2),
('3. On-Site Audit','Execution','The Audit Organization conducts a 5-day on-site audit to verify implementation of ISARPs.',3),
('4. Response & Corrective Actions','Gap Analysis','Airline must address and close all non-conformities found during the audit.',4),
('5. Audit Data Transfer','Quality Assurance','Audit report is submitted to IATA for Quality Assurance (QA) review.',5),
('6. Registration Assessment','Compliance Verification','IATA verifies that all audit procedures were correctly followed.',6),
('7. Registration','Final Approval','The airline is added to the IOSA registry and receives its certificate.',7),
('8. Maintenance/Renewal','Recurrent Audit','Registration is valid for two years and the renewal audit must be completed before expiration.',8);
INSERT INTO notam_sources (iso_country,country_name,official_source_name,notam_portal_url,icao_nof_code,notes) VALUES
('KE','Kenya','Kenya Civil Aviation Authority (KCAA)','https://eaip.kcaa.or.ke/','HKJK','AIS/AIM Department'),
('UG','Uganda','Uganda Civil Aviation Authority (UCAA)','https://aim.caa.go.ug/','HUEC','Aeronautical Information Management'),
('TZ','Tanzania','Tanzania Civil Aviation Authority (TCAA)','https://tcaa.go.tz/air-navigation-services/ais/','HTDA','International NOTAM Office'),
('SS','South Sudan','South Sudan Civil Aviation Authority (SSCAA)','https://sscaa.gov.ss/','HSSJ','Aeronautical Information Services'),
('SO','Somalia','Somali Civil Aviation Authority (SCAA)','https://scaa.gov.so/','HCSM','Mogadishu NOF (Currently managed from Nairobi)'),
('US','United States','Federal Aviation Administration (FAA)','https://notams.aim.faa.gov/notamSearch/','KDZZ','FAA NOTAM Search Portal'),
('GB','United Kingdom','NATS Aeronautical Information Service','https://www.nats.aero/ais','EGZZ','AIS Information Centre'),
('ZA','South Africa','Air Traffic and Navigation Services (ATNS)','https://www.atns.com/','FAZZ','Aeronautical Information Management');
INSERT INTO aircraft_types (aircraft_type,common_name,full_designation,manufacturer,model,iata_code,icao_code,status,generation,category,mission_type,wtc,record_status,source_url) VALUES
('100','100','Fokker 100','Fokker','100','100','F100','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('146-100','146-100','BAe 146-100','BAe','146-100','141','B461','In Service',NULL,'4J','Passenger','M','uploaded',NULL),
('BAE Systems 146-200 Passenger','BAE Systems 146-200 Passenger','BAe BAE Systems 146-200 Passenger','BAe','BAE Systems 146-200 Passenger','142','B462','In Service',NULL,'4J','Passenger','M','uploaded',NULL),
('146-300','146-300','BAe 146-300','BAe','146-300','143','B463','In Service',NULL,'4J','Passenger','M','uploaded',NULL),
('146','146','BAe 146','BAe','146','146',NULL,'In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('146 Freighter (-100/200/300QT & QC)','146 Freighter (-100/200/300QT & QC)','BAe 146 Freighter (-100/200/300QT & QC)','BAe','146 Freighter (-100/200/300QT & QC)','14F',NULL,'In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('146 Freighter (-100QT & QC)','146 Freighter (-100QT & QC)','BAe 146 Freighter (-100QT & QC)','BAe','146 Freighter (-100QT & QC)','14X','B461','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('146 Freighter (-200QT & QC)','146 Freighter (-200QT & QC)','BAe 146 Freighter (-200QT & QC)','BAe','146 Freighter (-200QT & QC)','14Y','B462','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('146 Freighter (-300QT & QC)','146 Freighter (-300QT & QC)','BAe 146 Freighter (-300QT & QC)','BAe','146 Freighter (-300QT & QC)','14Z','B463','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('A319','A319','Airbus A319','Airbus','A319','19D',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A220-100','A220-100','Airbus A220-100','Airbus','A220-100','221','BCS1','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A220-200','A220-200','Airbus A220-200','Airbus','A220-200','223','BCS3','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('E190-E2','E190-E2','Embraer E190-E2','Embraer','E190-E2','290','E290','In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('E195-E2','E195-E2','Embraer E195-E2','Embraer','E195-E2','295','E295','In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('A310','A310','Airbus A310','Airbus','A310','310',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('A310-200','A310-200','Airbus A310-200','Airbus','A310-200','312','A310','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A310-300','A310-300','Airbus A310-300','Airbus','A310-300','313','A310','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A318','A318','Airbus A318','Airbus','A318','318','A318','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('A319','A319','Airbus A319','Airbus','A319','319','A319','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('A310F','A310F','Airbus A310F','Airbus','A310F','31F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A319 Neo','A319 Neo','Airbus A319 Neo','Airbus','A319 Neo','31N','A19N','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('A319 (Sharklets)','A319 (Sharklets)','Airbus A319 (Sharklets)','Airbus','A319 (Sharklets)','31W',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A310-200F','A310-200F','Airbus A310-200F','Airbus','A310-200F','31X','A310','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A310-300F','A310-300F','Airbus A310-300F','Airbus','A310-300F','31Y','A310','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A320-100/200','A320-100/200','Airbus A320-100/200','Airbus','A320-100/200','320','A320','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('A321-100/200','A321-100/200','Airbus A321-100/200','Airbus','A321-100/200','321','A321','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('A320 (sharklets)','A320 (sharklets)','Airbus A320 (sharklets)','Airbus','A320 (sharklets)','32A','A320','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A321 (sharklets)','A321 (sharklets)','Airbus A321 (sharklets)','Airbus','A321 (sharklets)','32B','A321','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A318 (sharklets)','A318 (sharklets)','Airbus A318 (sharklets)','Airbus','A318 (sharklets)','32C',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A319 (sharklets)','A319 (sharklets)','Airbus A319 (sharklets)','Airbus','A319 (sharklets)','32D',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A320 Freighter','A320 Freighter','Airbus A320 Freighter','Airbus','A320 Freighter','32F','A320','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A320-200 Neo','A320-200 Neo','Airbus A320-200 Neo','Airbus','A320-200 Neo','32N','A20N','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('A321-200 Neo','A321-200 Neo','Airbus A321-200 Neo','Airbus','A321-200 Neo','32Q','A21N','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('A318/319/320/321','A318/319/320/321','Airbus A318/319/320/321','Airbus','A318/319/320/321','32S',NULL,'In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A321 Freighter','A321 Freighter','Airbus A321 Freighter','Airbus','A321 Freighter','32X','A321','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A330','A330','Airbus A330','Airbus','A330','330',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('A330-200','A330-200','Airbus A330-200','Airbus','A330-200','332','A332','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A330-300','A330-300','Airbus A330-300','Airbus','A330-300','333','A333','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A330-800 Neo','A330-800 Neo','Airbus A330-800 Neo','Airbus','A330-800 Neo','338','A338','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A330-900 Neo','A330-900 Neo','Airbus A330-900 Neo','Airbus','A330-900 Neo','339','A339','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A330 Freighter','A330 Freighter','Airbus A330 Freighter','Airbus','A330 Freighter','33F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A330-200 Freighter','A330-200 Freighter','Airbus A330-200 Freighter','Airbus','A330-200 Freighter','33X','A332','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A340','A340','Airbus A340','Airbus','A340','340',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('A340-200','A340-200','Airbus A340-200','Airbus','A340-200','342','A342','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('A340-300','A340-300','Airbus A340-300','Airbus','A340-300','343','A343','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('A340-500','A340-500','Airbus A340-500','Airbus','A340-500','345','A345','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('A340-600','A340-600','Airbus A340-600','Airbus','A340-600','346','A346','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('A350','A350','Airbus A350','Airbus','A350','350',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('A350-1000','A350-1000','Airbus A350-1000','Airbus','A350-1000','351','ZZZZ','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A350-800','A350-800','Airbus A350-800','Airbus','A350-800','358','ZZZZ','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A350-900','A350-900','Airbus A350-900','Airbus','A350-900','359','ZZZZ','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A380','A380','Airbus A380','Airbus','A380','380',NULL,'In Service',NULL,NULL,'Passenger','J','uploaded',NULL),
('A380','A380','Airbus A380','Airbus','A380','388','A388','In Service',NULL,'4J','Passenger','J','uploaded',NULL),
('A380F','A380F','Airbus A380F','Airbus','A380F','38F','A388','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('707-300','707-300','Boeing 707-300','Boeing','707-300','703','B703','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('707/720','707/720','Boeing 707/720','Boeing','707/720','707',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('707 Freighter','707 Freighter','Boeing 707 Freighter','Boeing','707 Freighter','70F','B703','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('707 Combi','707 Combi','Boeing 707 Combi','Boeing','707 Combi','70M','B703','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('717','717','Boeing 717','Boeing','717','717','B712','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('727-100','727-100','Boeing 727-100','Boeing','727-100','721','B721','In Service',NULL,'3J','Passenger','M','uploaded',NULL),
('727-200','727-200','Boeing 727-200','Boeing','727-200','722','B722','In Service',NULL,'3J','Passenger','M','uploaded',NULL),
('727','727','Boeing 727','Boeing','727','727',NULL,'In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('727-200 Advanced','727-200 Advanced','Boeing 727-200 Advanced','Boeing','727-200 Advanced','72A',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('727-100 Mixed','727-100 Mixed','Boeing 727-100 Mixed','Boeing','727-100 Mixed','72B','B721','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('727-200 Mixed','727-200 Mixed','Boeing 727-200 Mixed','Boeing','727-200 Mixed','72C','B722','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('727 Freighter (-100/200)','727 Freighter (-100/200)','Boeing 727 Freighter (-100/200)','Boeing','727 Freighter (-100/200)','72F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('727 Combi','727 Combi','Boeing 727 Combi','Boeing','727 Combi','72M',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('727-200 Adv.','727-200 Adv.','Boeing 727-200 Adv.','Boeing','727-200 Adv.','72S',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('727-200 (winglets)','727-200 (winglets)','Boeing 727-200 (winglets)','Boeing','727-200 (winglets)','72W','B722','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('727-100 Freighter','727-100 Freighter','Boeing 727-100 Freighter','Boeing','727-100 Freighter','72X','B721','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('727-200 Freighter','727-200 Freighter','Boeing 727-200 Freighter','Boeing','727-200 Freighter','72Y','B722','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('737-100','737-100','Boeing 737-100','Boeing','737-100','731','B731','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-200','737-200','Boeing 737-200','Boeing','737-200','732','B732','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737-300','737-300','Boeing 737-300','Boeing','737-300','733','B733','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737-400','737-400','Boeing 737-400','Boeing','737-400','734','B734','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737-500','737-500','Boeing 737-500','Boeing','737-500','735','B735','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737-600','737-600','Boeing 737-600','Boeing','737-600','736','B736','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737','737','Boeing 737','Boeing','737','737',NULL,'In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('737-800','737-800','Boeing 737-800','Boeing','737-800','738','B738','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737-900','737-900','Boeing 737-900','Boeing','737-900','739','B739','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737-200 Advanced','737-200 Advanced','Boeing 737-200 Advanced','Boeing','737-200 Advanced','73A',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('737-300 (winglets)','737-300 (winglets)','Boeing 737-300 (winglets)','Boeing','737-300 (winglets)','73C','B733','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-500 (winglets)','737-500 (winglets)','Boeing 737-500 (winglets)','Boeing','737-500 (winglets)','73E','B735','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737 Freighter','737 Freighter','Boeing 737 Freighter','Boeing','737 Freighter','73F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('737-700','737-700','Boeing 737-700','Boeing','737-700','73G','B737','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737-800 (winglets)','737-800 (winglets)','Boeing 737-800 (winglets)','Boeing','737-800 (winglets)','73H','B738','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-900 (winglets)','737-900 (winglets)','Boeing 737-900 (winglets)','Boeing','737-900 (winglets)','73J','B739','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-200 Mixed Configuration','737-200 Mixed Configuration','Boeing 737-200 Mixed Configuration','Boeing','737-200 Mixed Configuration','73L','B732','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-200 Combi','737-200 Combi','Boeing 737-200 Combi','Boeing','737-200 Combi','73M',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('737-300 Mixed Configuration','737-300 Mixed Configuration','Boeing 737-300 Mixed Configuration','Boeing','737-300 Mixed Configuration','73N','B733','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-400 Freighter','737-400 Freighter','Boeing 737-400 Freighter','Boeing','737-400 Freighter','73P','B734','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-400 Mixed Configuration','737-400 Mixed Configuration','Boeing 737-400 Mixed Configuration','Boeing','737-400 Mixed Configuration','73Q','B734','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-700 Mixed Configuration','737-700 Mixed Configuration','Boeing 737-700 Mixed Configuration','Boeing','737-700 Mixed Configuration','73R','B737','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-200 Advanced','737-200 Advanced','Boeing 737-200 Advanced','Boeing','737-200 Advanced','73S','B737','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-700 (winglets)','737-700 (winglets)','Boeing 737-700 (winglets)','Boeing','737-700 (winglets)','73W','B737','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-200 Freighter','737-200 Freighter','Boeing 737-200 Freighter','Boeing','737-200 Freighter','73X','B732','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-300 Freighter','737-300 Freighter','Boeing 737-300 Freighter','Boeing','737-300 Freighter','73Y','B733','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('737-400 Freighter','737-400 Freighter','Boeing 737-400 Freighter','Boeing','737-400 Freighter','73Z',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('747-100','747-100','Boeing 747-100','Boeing','747-100','741','B741','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('747-200','747-200','Boeing 747-200','Boeing','747-200','742','B742','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('747-300','747-300','Boeing 747-300','Boeing','747-300','743','B743','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('747-400','747-400','Boeing 747-400','Boeing','747-400','744','B744','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('747','747','Boeing 747','Boeing','747','747',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('747-8 pax','747-8 pax','Boeing 747-8 pax','Boeing','747-8 pax','748','B748','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('747-400 Swingtail Freighter','747-400 Swingtail Freighter','Boeing 747-400 Swingtail Freighter','Boeing','747-400 Swingtail Freighter','74B','B744','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-200 Combi','747-200 Combi','Boeing 747-200 Combi','Boeing','747-200 Combi','74C','B742','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-300 Combi','747-300 Combi','Boeing 747-300 Combi','Boeing','747-300 Combi','74D','B743','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-400 Combi','747-400 Combi','Boeing 747-400 Combi','Boeing','747-400 Combi','74E','B744','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747 Freighter','747 Freighter','Boeing 747 Freighter','Boeing','747 Freighter','74F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('747-8i','747-8i','Boeing 747-8i','Boeing','747-8i','74H','B748','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-400 (Domestic)','747-400 (Domestic)','Boeing 747-400 (Domestic)','Boeing','747-400 (Domestic)','74J','B74D','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747SP','747SP','Boeing 747SP','Boeing','747SP','74L','B74S','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747 Combi','747 Combi','Boeing 747 Combi','Boeing','747 Combi','74M',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('747-8F','747-8F','Boeing 747-8F','Boeing','747-8F','74N','B748','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747SR','747SR','Boeing 747SR','Boeing','747SR','74R','B74R','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-100 Freighter','747-100 Freighter','Boeing 747-100 Freighter','Boeing','747-100 Freighter','74T','B741','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-300 / 747-200 SUD Freighter','747-300 / 747-200 SUD Freighter','Boeing 747-300 / 747-200 SUD Freighter','Boeing','747-300 / 747-200 SUD Freighter','74U','B743','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747SR Freighter','747SR Freighter','Boeing 747SR Freighter','Boeing','747SR Freighter','74V','B74R','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-200 Freighter','747-200 Freighter','Boeing 747-200 Freighter','Boeing','747-200 Freighter','74X','B742','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('747-400 Freighter','747-400 Freighter','Boeing 747-400 Freighter','Boeing','747-400 Freighter','74Y','B744','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('757-200','757-200','Boeing 757-200','Boeing','757-200','752','B752','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('757-300','757-300','Boeing 757-300','Boeing','757-300','753','B753','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('757','757','Boeing 757','Boeing','757','757',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('757 Freighter','757 Freighter','Boeing 757 Freighter','Boeing','757 Freighter','75F','B752','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('757 Mixed','757 Mixed','Boeing 757 Mixed','Boeing','757 Mixed','75M','B752','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('757-300 (winglets)','757-300 (winglets)','Boeing 757-300 (winglets)','Boeing','757-300 (winglets)','75T','B753','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('757-200 (winglets)','757-200 (winglets)','Boeing 757-200 (winglets)','Boeing','757-200 (winglets)','75W','B752','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('767-200','767-200','Boeing 767-200','Boeing','767-200','762','B762','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('767-300','767-300','Boeing 767-300','Boeing','767-300','763','B763','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('767-400','767-400','Boeing 767-400','Boeing','767-400','764','B764','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('767','767','Boeing 767','Boeing','767','767',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('767 Freighter','767 Freighter','Boeing 767 Freighter','Boeing','767 Freighter','76F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('767-300 (winglets) Freighter','767-300 (winglets) Freighter','Boeing 767-300 (winglets) Freighter','Boeing','767-300 (winglets) Freighter','76V','B763','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('767-300 (winglets)','767-300 (winglets)','Boeing 767-300 (winglets)','Boeing','767-300 (winglets)','76W','B763','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('767-200 Freighter','767-200 Freighter','Boeing 767-200 Freighter','Boeing','767-200 Freighter','76X','B762','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('767-300 Freighter','767-300 Freighter','Boeing 767-300 Freighter','Boeing','767-300 Freighter','76Y','B763','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('777-200','777-200','Boeing 777-200','Boeing','777-200','772','B77L','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('777-300','777-300','Boeing 777-300','Boeing','777-300','773','B773','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('777','777','Boeing 777','Boeing','777','777',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('777 Freighter','777 Freighter','Boeing 777 Freighter','Boeing','777 Freighter','77F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('777-200LR','777-200LR','Boeing 777-200LR','Boeing','777-200LR','77L','B772','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('777-300ER','777-300ER','Boeing 777-300ER','Boeing','777-300ER','77W','B77W','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('777-200F Freighter','777-200F Freighter','Boeing 777-200F Freighter','Boeing','777-200F Freighter','77X','B772','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('787-10 pax','787-10 pax','Boeing 787-10 pax','Boeing','787-10 pax','781','B78X','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('787-3','787-3','Boeing 787-3','Boeing','787-3','783','B783','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('787','787','Boeing 787','Boeing','787','787',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('787-8','787-8','Boeing 787-8','Boeing','787-8','788','B788','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('787-9','787-9','Boeing 787-9','Boeing','787-9','789','B789','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('737 MAX 7 pax','737 MAX 7 pax','Boeing 737 MAX 7 pax','Boeing','737 MAX 7 pax','7M7','B37M','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737 MAX 8 pax','737 MAX 8 pax','Boeing 737 MAX 8 pax','Boeing','737 MAX 8 pax','7M8','B38M','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737 MAX 9 pax','737 MAX 9 pax','Boeing 737 MAX 9 pax','Boeing','737 MAX 9 pax','7M9','B39M','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('737 MAX 10 pax','737 MAX 10 pax','Boeing 737 MAX 10 pax','Boeing','737 MAX 10 pax','7MJ','B3XM','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('An-22','An-22','Antonov An-22','Antonov','An-22','A22','AN22','In Service',NULL,'4T','Passenger',NULL,'uploaded',NULL),
('/ Antonov An-26','/ Antonov An-26','Antonow / Antonov An-26','Antonow','/ Antonov An-26','A26','AN26','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ Antonov An-28 / PZL Mielec M-28','/ Antonov An-28 / PZL Mielec M-28','Antonow / Antonov An-28 / PZL Mielec M-28','Antonow','/ Antonov An-28 / PZL Mielec M-28','A28','AN28','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ Antonov An-30','/ Antonov An-30','Antonow / Antonov An-30','Antonow','/ Antonov An-30','A30','AN30','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ Antonov An-32','/ Antonov An-32','Antonow / Antonov An-32','Antonow','/ Antonov An-32','A32','AN32','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('An-38','An-38','Antonov An-38','Antonov','An-38','A38','AN38','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ Antonov An-140','/ Antonov An-140','Antonow / Antonov An-140','Antonow','/ Antonov An-140','A40','A140','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ Antonov An-124','/ Antonov An-124','Antonow / Antonov An-124','Antonow','/ Antonov An-124','A4F','A124','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('An-158','An-158','Antonov An-158','Antonov','An-158','A58','ZZZZ','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('An-225','An-225','Antonov An-225','Antonov','An-225','A5F','A225','In Service',NULL,'6J','Passenger',NULL,'uploaded',NULL),
('An-148-100','An-148-100','Antonov An-148-100','Antonov','An-148-100','A81','A148','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A300B2','A300B2','Airbus A300B2','Airbus','A300B2','AB2',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A300','A300','Airbus A300','Airbus','A300','AB3',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('A300B2/B4/C4','A300B2/B4/C4','Airbus A300B2/B4/C4','Airbus','A300B2/B4/C4','AB4','A30B','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A300-600','A300-600','Airbus A300-600','Airbus','A300-600','AB6','A306','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A300-600ST Beluga','A300-600ST Beluga','Airbus A300-600ST Beluga','Airbus','A300-600ST Beluga','ABB','A3ST','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('A300F','A300F','Airbus A300F','Airbus','A300F','ABF',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A300-600 Mixed Configuration','A300-600 Mixed Configuration','Airbus A300-600 Mixed Configuration','Airbus','A300-600 Mixed Configuration','ABM',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('A300C4/F4 Freighter','A300C4/F4 Freighter','Airbus A300C4/F4 Freighter','Airbus','A300C4/F4 Freighter','ABX','A30B','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('A300-600F','A300-600F','Airbus A300-600F','Airbus','A300-600F','ABY','A306','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Commander/Turbo Commander','Commander/Turbo Commander','Rockwell Commander/Turbo Commander','Rockwell','Commander/Turbo Commander','ACD',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Commander','Commander','Rockwell Commander','Rockwell','Commander','ACP','*','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('Turbo Commander','Turbo Commander','Rockwell Turbo Commander','Rockwell','Turbo Commander','ACT','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ AgustaWestland A-109','/ AgustaWestland A-109','Agusta / AgustaWestland A-109','Agusta','/ AgustaWestland A-109','AGH','A109','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('LM-200 Loadmaster','LM-200 Loadmaster','Ayres LM-200 Loadmaster','Ayres','LM-200 Loadmaster','ALM',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('FALCON 10 / 20 / 50','FALCON 10 / 20 / 50','Dassault FALCON 10 / 20 / 50','Dassault','FALCON 10 / 20 / 50','AMD',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('An-2','An-2','Antonov An-2','Antonov','An-2','AN2',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('/ Antonov An-24','/ Antonov An-24','Antonow / Antonov An-24','Antonow','/ Antonov An-24','AN4','AN24','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('/ Antonov An-26 / An-30 / An-32','/ Antonov An-26 / An-30 / An-32','Antonow / Antonov An-26 / An-30 / An-32','Antonow','/ Antonov An-26 / An-30 / An-32','AN6',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('/ Antonov An-72 / An-74','/ Antonov An-72 / An-74','Antonow / Antonov An-72 / An-74','Antonow','/ Antonov An-72 / An-74','AN7','AN72','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('/ Antonov An-12','/ Antonov An-12','Antonow / Antonov An-12','Antonow','/ Antonov An-12','ANF','AN12','In Service',NULL,'4T','Passenger','M','uploaded',NULL),
('ATP Freighter','ATP Freighter','BAe ATP Freighter','BAe','ATP Freighter','APF','ZZZZ','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('SA330 Puma / AS332 Super Puma','SA330 Puma / AS332 Super Puma','Eurocopter SA330 Puma / AS332 Super Puma','Eurocopter','SA330 Puma / AS332 Super Puma','APH','*','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('Avro RJ100','Avro RJ100','BAe Avro RJ100','BAe','Avro RJ100','AR1','RJ1H','In Service',NULL,'4J','Passenger','M','uploaded',NULL),
('Avro RJ70','Avro RJ70','BAe Avro RJ70','BAe','Avro RJ70','AR7','RJ70','In Service',NULL,'4J','Passenger','M','uploaded',NULL),
('Avro RJ85','Avro RJ85','BAe Avro RJ85','BAe','Avro RJ85','AR8','RJ85','In Service',NULL,'4J','Passenger','M','uploaded',NULL),
('Avro RJ70 / RJ85 / RJ100','Avro RJ70 / RJ85 / RJ100','BAe Avro RJ70 / RJ85 / RJ100','BAe','Avro RJ70 / RJ85 / RJ100','ARJ',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('RJX85 / RJX100','RJX85 / RJX100','Avro RJX85 / RJX100','Avro','RJX85 / RJX100','ARX',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('ATR 42-300 / 320','ATR 42-300 / 320','ATR ATR 42-300 / 320','ATR','ATR 42-300 / 320','AT4','AT43','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('ATR 42-500','ATR 42-500','ATR ATR 42-500','ATR','ATR 42-500','AT5','AT45','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('ATR 72','ATR 72','ATR ATR 72','ATR','ATR 72','AT7','AT72','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('ATR 42-400','ATR 42-400','ATR ATR 42-400','ATR','ATR 42-400','ATD','AT44','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('ATR 72 Freighter','ATR 72 Freighter','ATR ATR 72 Freighter','ATR','ATR 72 Freighter','ATF','AT72','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('ATP','ATP','BAe ATP','BAe','ATP','ATP','ATP','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('ATR 42 / ATR 72','ATR 42 / ATR 72','ATR ATR 42 / ATR 72','ATR','ATR 42 / ATR 72','ATR',NULL,'In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('ATR 42 Freighter','ATR 42 Freighter','ATR ATR 42 Freighter','ATR','ATR 42 Freighter','ATZ','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('AW139','AW139','AgustaWestland AW139','AgustaWestland','AW139','AWH','A139','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('RJX100','RJX100','Avro RJX100','Avro','RJX100','AX1','RX1H','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL);
INSERT INTO aircraft_types (aircraft_type,common_name,full_designation,manufacturer,model,iata_code,icao_code,status,generation,category,mission_type,wtc,record_status,source_url) VALUES
('RJX85','RJX85','Avro RJX85','Avro','RJX85','AX8','RX85','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('One Eleven','One Eleven','BAC One Eleven','BAC','One Eleven','B11',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('One Eleven 200','One Eleven 200','BAC One Eleven 200','BAC','One Eleven 200','B12','BA11','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('One Eleven 300','One Eleven 300','BAC One Eleven 300','BAC','One Eleven 300','B13','BA11','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('One Eleven 400/47','One Eleven 400/47','BAC One Eleven 400/47','BAC','One Eleven 400/47','B14','BA11','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('One Eleven 500','One Eleven 500','BAC One Eleven 500','BAC','One Eleven 500','B15','BA11','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('720B','720B','Boeing 720B','Boeing','720B','B72','B720','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('1900/1900C/1900D','1900/1900C/1900D','Beechcraft 1900/1900C/1900D','Beechcraft','1900/1900C/1900D','BE1',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Beech twin piston','Beech twin piston','Beechcraft Beech twin piston','Beechcraft','Beech twin piston','BE2','*','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('Beechcraft 400','Beechcraft 400','Beechcraft Beechcraft 400','Beechcraft','Beechcraft 400','BE4','BE40','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Beechcraft C99','Beechcraft C99','Beechcraft Beechcraft C99','Beechcraft','Beechcraft C99','BE9','BE99','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Beech light aircraft','Beech light aircraft','Beechcraft Beech light aircraft','Beechcraft','Beech light aircraft','BEC',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Beechcraft 1900 Freighter','Beechcraft 1900 Freighter','Beechcraft Beechcraft 1900 Freighter','Beechcraft','Beechcraft 1900 Freighter','BEF','B190','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('1900D','1900D','Beechcraft 1900D','Beechcraft','1900D','BEH','B190','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('Beech singe piston','Beech singe piston','Beechcraft Beech singe piston','Beechcraft','Beech singe piston','BEP','*','In Service',NULL,'1P','Passenger',NULL,'uploaded',NULL),
('1900/1900C','1900/1900C','Beechcraft 1900/1900C','Beechcraft','1900/1900C','BES','B190','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Beech twin turboprop','Beech twin turboprop','Beechcraft Beech twin turboprop','Beechcraft','Beech twin turboprop','BET','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Helicopter Bell Helicopters','Helicopter Bell Helicopters','Bell Helicopter Bell Helicopters','Bell','Helicopter Bell Helicopters','BH2','*','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('Norman BN-2A/B Islander','Norman BN-2A/B Islander','Britten Norman BN-2A/B Islander','Britten','Norman BN-2A/B Islander','BNI','BN2P','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('Norman BN-2A Mk III Trislander','Norman BN-2A Mk III Trislander','Britten Norman BN-2A Mk III Trislander','Britten','Norman BN-2A Mk III Trislander','BNT','TRIS','In Service',NULL,'3P','Passenger',NULL,'uploaded',NULL),
('Turbo-Prop Aircraft','Turbo-Prop Aircraft','Business Turbo-Prop Aircraft','Business','Turbo-Prop Aircraft','BTA','ZZZZ','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Equipment Bus','Equipment Bus','Surface Equipment Bus','Surface','Equipment Bus','BUS','0000','In Service',NULL,'S','Passenger',NULL,'uploaded',NULL),
('ARJ21-700','ARJ21-700','Comac ARJ21-700','Comac','ARJ21-700','C27','AJ27','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('CRJ 900NG','CRJ 900NG','Canadair CRJ 900NG','Canadair','CRJ 900NG','C9B',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Challenger','Challenger','Canadair Challenger','Canadair','Challenger','CCJ','CL60','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Global Express','Global Express','Bombardier Global Express','Bombardier','Global Express','CCX','GLEX','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('N22B / N24A Nomad','N22B / N24A Nomad','GAF N22B / N24A Nomad','GAF','N22B / N24A Nomad','CD2','NOMA','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('500/501/525 Citation','500/501/525 Citation','Cessna 500/501/525 Citation','Cessna','500/501/525 Citation','CJ1','*','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('550/551/552 Citation','550/551/552 Citation','Cessna 550/551/552 Citation','Cessna','550/551/552 Citation','CJ2','*','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('560 Citation','560 Citation','Cessna 560 Citation','Cessna','560 Citation','CJ5','*','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('650 Citation','650 Citation','Cessna 650 Citation','Cessna','650 Citation','CJ6','*','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('680 Citation','680 Citation','Cessna 680 Citation','Cessna','680 Citation','CJ8','*','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('560 XL/XLS Citation','560 XL/XLS Citation','Cessna 560 XL/XLS Citation','Cessna','560 XL/XLS Citation','CJL','*','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('510 Mustang Citation','510 Mustang Citation','Cessna 510 Mustang Citation','Cessna','510 Mustang Citation','CJM','C510','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Challenger 300','Challenger 300','Bombardier Challenger 300','Bombardier','Challenger 300','CL3','CL30','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('CL-44','CL-44','Canadair CL-44','Canadair','CL-44','CL4',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Cessna single piston engine','Cessna single piston engine','Cessna Cessna single piston engine','Cessna','Cessna single piston engine','CN1','*','In Service',NULL,'1P','Passenger','L','uploaded',NULL),
('Cessna twin piston engines','Cessna twin piston engines','Cessna Cessna twin piston engines','Cessna','Cessna twin piston engines','CN2','*','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('750 Citation X','750 Citation X','Cessna 750 Citation X','Cessna','750 Citation X','CN7','C750','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Cessna light aircraft','Cessna light aircraft','Cessna Cessna light aircraft','Cessna','Cessna light aircraft','CNA',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Cessna single turboprop engine','Cessna single turboprop engine','Cessna Cessna single turboprop engine','Cessna','Cessna single turboprop engine','CNC','*','In Service',NULL,'1T','Passenger',NULL,'uploaded',NULL),
('208B Freighter','208B Freighter','Cessna 208B Freighter','Cessna','208B Freighter','CNF','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Citation','Citation','Cessna Citation','Cessna','Citation','CNJ','*','In Service',NULL,'2J','Passenger','L','uploaded',NULL),
('Cessna twin turboprop engines','Cessna twin turboprop engines','Cessna Cessna twin turboprop engines','Cessna','Cessna twin turboprop engines','CNT','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('CRJ 100','CRJ 100','Canadair CRJ 100','Canadair','CRJ 100','CR1','CRJ1','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('CRJ 200','CRJ 200','Canadair CRJ 200','Canadair','CRJ 200','CR2','CRJ2','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('CRJ 700','CRJ 700','Canadair CRJ 700','Canadair','CRJ 700','CR7','CRJ7','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('CRJ 900','CRJ 900','Canadair CRJ 900','Canadair','CRJ 900','CR9','CRJ9','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('CRJ 705','CRJ 705','Canadair CRJ 705','Canadair','CRJ 705','CRA','CRJ9','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('CRJ Freighter','CRJ Freighter','Canadair CRJ Freighter','Canadair','CRJ Freighter','CRF','ZZZZ','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('CRJ','CRJ','Canadair CRJ','Canadair','CRJ','CRJ',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('CRJ 1000','CRJ 1000','Canadair CRJ 1000','Canadair','CRJ 1000','CRK','CRJX','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('SE.210 Caravelle','SE.210 Caravelle','Sud-Est SE.210 Caravelle','Sud-Est','SE.210 Caravelle','CRV',NULL,'In Service',NULL,NULL,'Passenger','M','uploaded',NULL),
('CSeries CS100','CSeries CS100','Bombardier CSeries CS100','Bombardier','CSeries CS100','CS1','ZZZZ','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('212 Aviocar','212 Aviocar','CASA 212 Aviocar','CASA','212 Aviocar','CS2','C212','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('CS300','CS300','Bombardier CS300','Bombardier','CS300','CS3','ZZZZ','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('CN-235','CN-235','Airtech CN-235','Airtech','CN-235','CS5','CN35','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('CV-240','CV-240','Convair CV-240','Convair','CV-240','CV2','CVLP','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('CV-440 Metropolitan','CV-440 Metropolitan','Convair CV-440 Metropolitan','Convair','CV-440 Metropolitan','CV4','CVLP','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('CV-580','CV-580','Convair CV-580','Convair','CV-580','CV5','CVLT','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('CV-600/640','CV-600/640','Convair CV-600/640','Convair','CV-600/640','CV6',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('CV-240 / 440 / 580 / 600 / 640 Freighter','CV-240 / 440 / 580 / 600 / 640 Freighter','Convair CV-240 / 440 / 580 / 600 / 640 Freighter','Convair','CV-240 / 440 / 580 / 600 / 640 Freighter','CVF',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('CV-240 / 440 / 580 / 600 / 640','CV-240 / 440 / 580 / 600 / 640','Convair CV-240 / 440 / 580 / 600 / 640','Convair','CV-240 / 440 / 580 / 600 / 640','CVR',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('CV-240 Freighter','CV-240 Freighter','Convair CV-240 Freighter','Convair','CV-240 Freighter','CVV','CVLP','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('CV-440 Freighter','CV-440 Freighter','Convair CV-440 Freighter','Convair','CV-440 Freighter','CVX','CVLP','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('CV-580 / 600 / 640 Freighter','CV-580 / 600 / 640 Freighter','Convair CV-580 / 600 / 640 Freighter','Convair','CV-580 / 600 / 640 Freighter','CVY','CVLT','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('C-46 Commando','C-46 Commando','Curtiss C-46 Commando','Curtiss','C-46 Commando','CWC','C46','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('Douglas DC-10','Douglas DC-10','McDonnell Douglas DC-10','McDonnell','Douglas DC-10','D10',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('Douglas DC-10-10/15','Douglas DC-10-10/15','McDonnell Douglas DC-10-10/15','McDonnell','Douglas DC-10-10/15','D11','DC10','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Douglas DC-10-40','Douglas DC-10-40','McDonnell Douglas DC-10-40','McDonnell','Douglas DC-10-40','D14',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Douglas DC-10-30/40','Douglas DC-10-30/40','McDonnell Douglas DC-10-30/40','McDonnell','Douglas DC-10-30/40','D1C','DC10','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Douglas DC-10 Freighter','Douglas DC-10 Freighter','McDonnell Douglas DC-10 Freighter','McDonnell','Douglas DC-10 Freighter','D1F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Douglas DC-10 Combi','Douglas DC-10 Combi','McDonnell Douglas DC-10 Combi','McDonnell','Douglas DC-10 Combi','D1M','DC10','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Douglas DC-10-10 Freighter','Douglas DC-10-10 Freighter','McDonnell Douglas DC-10-10 Freighter','McDonnell','Douglas DC-10-10 Freighter','D1X','DC10','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Douglas DC-10-30 / 40 Freighter','Douglas DC-10-30 / 40 Freighter','McDonnell Douglas DC-10-30 / 40 Freighter','McDonnell','Douglas DC-10-30 / 40 Freighter','D1Y','DC10','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Falcon 2000/2000DX','Falcon 2000/2000DX','Dassault Falcon 2000/2000DX','Dassault','Falcon 2000/2000DX','D20','F2TH','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Do 228','Do 228','Dornier Do 228','Dornier','Do 228','D28','D228','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('Falcon 2000EX/EASY/LX','Falcon 2000EX/EASY/LX','Dassault Falcon 2000EX/EASY/LX','Dassault','Falcon 2000EX/EASY/LX','D2L','F2TH','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Do 328','Do 328','Dornier Do 328','Dornier','Do 328','D38','D328','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('DC-3 Freighter','DC-3 Freighter','Douglas DC-3 Freighter','Douglas','DC-3 Freighter','D3F','DC3','In Service',NULL,'2P','Passenger','L','uploaded',NULL),
('Aircraft DA42 Twin Star','Aircraft DA42 Twin Star','Diamond Aircraft DA42 Twin Star','Diamond','Aircraft DA42 Twin Star','D42','DA42','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('Havilland Canada-Bombardier DHC-8-400 Dash 8Q Freighter','Havilland Canada-Bombardier DHC-8-400 Dash 8Q Freighter','De Havilland Canada-Bombardier DHC-8-400 Dash 8Q Freighter','De','Havilland Canada-Bombardier DHC-8-400 Dash 8Q Freighter','D4X','DH8D','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('DC-6A/B/C Freighter','DC-6A/B/C Freighter','Douglas DC-6A/B/C Freighter','Douglas','DC-6A/B/C Freighter','D6F','DC6','In Service',NULL,'4P','Passenger',NULL,'uploaded',NULL),
('DC-8-50','DC-8-50','Douglas DC-8-50','Douglas','DC-8-50','D85',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('DC-8-61','DC-8-61','Douglas DC-8-61','Douglas','DC-8-61','D86',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('DC-8-71','DC-8-71','Douglas DC-8-71','Douglas','DC-8-71','D87',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('DC-8-63','DC-8-63','Douglas DC-8-63','Douglas','DC-8-63','D8A',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('DC-8-73','DC-8-73','Douglas DC-8-73','Douglas','DC-8-73','D8B',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('DC-8 Freighter','DC-8 Freighter','Douglas DC-8 Freighter','Douglas','DC-8 Freighter','D8F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('DC-8-62','DC-8-62','Douglas DC-8-62','Douglas','DC-8-62','D8L','DC86','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('DC-8 Combi','DC-8 Combi','Douglas DC-8 Combi','Douglas','DC-8 Combi','D8M','DC86','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('DC-8-72','DC-8-72','Douglas DC-8-72','Douglas','DC-8-72','D8Q','DC87','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('DC-8-50 Freighter','DC-8-50 Freighter','Douglas DC-8-50 Freighter','Douglas','DC-8-50 Freighter','D8T','DC85','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('DC-8-61 / 62 / 63 Freighter','DC-8-61 / 62 / 63 Freighter','Douglas DC-8-61 / 62 / 63 Freighter','Douglas','DC-8-61 / 62 / 63 Freighter','D8X','DC86','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('DC-8-71 / 72 / 73 Freighter','DC-8-71 / 72 / 73 Freighter','Douglas DC-8-71 / 72 / 73 Freighter','Douglas','DC-8-71 / 72 / 73 Freighter','D8Y','DC87','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('DC-9-10','DC-9-10','Douglas DC-9-10','Douglas','DC-9-10','D91','DC91','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-9-20','DC-9-20','Douglas DC-9-20','Douglas','DC-9-20','D92','DC92','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-9-30','DC-9-30','Douglas DC-9-30','Douglas','DC-9-30','D93','DC93','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-9-40','DC-9-40','Douglas DC-9-40','Douglas','DC-9-40','D94','DC94','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-9-50','DC-9-50','Douglas DC-9-50','Douglas','DC-9-50','D95','DC95','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-9-30 Freighter','DC-9-30 Freighter','Douglas DC-9-30 Freighter','Douglas','DC-9-30 Freighter','D9C','DC93','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-9-40 Freighter','DC-9-40 Freighter','Douglas DC-9-40 Freighter','Douglas','DC-9-40 Freighter','D9D','DC94','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-9 Freighter','DC-9 Freighter','Douglas DC-9 Freighter','Douglas','DC-9 Freighter','D9F',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Falcon 900LX','Falcon 900LX','Dassault Falcon 900LX','Dassault','Falcon 900LX','D9L','F900','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('DC-9-10 Freighter','DC-9-10 Freighter','Douglas DC-9-10 Freighter','Douglas','DC-9-10 Freighter','D9X','DC91','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('DC-3','DC-3','Douglas DC-3','Douglas','DC-3','DC3','DC3','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('DC-4','DC-4','Douglas DC-4','Douglas','DC-4','DC4','DC4','In Service',NULL,'4P','Passenger',NULL,'uploaded',NULL),
('DC6A/B','DC6A/B','Douglas DC6A/B','Douglas','DC6A/B','DC6','DC6','In Service',NULL,'4P','Passenger',NULL,'uploaded',NULL),
('DC-8','DC-8','Douglas DC-8','Douglas','DC-8','DC8',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('DC-9','DC-9','Douglas DC-9','Douglas','DC-9','DC9',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Falcon 10/100','Falcon 10/100','Dassault Falcon 10/100','Dassault','Falcon 10/100','DF1','FA10','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Falcon 10 / 100 / 20 / 200 / 2000','Falcon 10 / 100 / 20 / 200 / 2000','Dassault Falcon 10 / 100 / 20 / 200 / 2000','Dassault','Falcon 10 / 100 / 20 / 200 / 2000','DF2','FA20','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Falcon 50 / 900','Falcon 50 / 900','Dassault Falcon 50 / 900','Dassault','Falcon 50 / 900','DF3',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Falcon 50/50EX','Falcon 50/50EX','Dassault Falcon 50/50EX','Dassault','Falcon 50/50EX','DF5','FA50','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Falcon 7X','Falcon 7X','Dassault Falcon 7X','Dassault','Falcon 7X','DF7','FA7X','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Falcon 900/900B/900C/900DX/900EX/EASY','Falcon 900/900B/900C/900DX/900EX/EASY','Dassault Falcon 900/900B/900C/900DX/900EX/EASY','Dassault','Falcon 900/900B/900C/900DX/900EX/EASY','DF9','F900','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Falcon','Falcon','Dassault Falcon','Dassault','Falcon','DFL',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Havilland Canada-Bombardier DHC-8-100 Dash 8 / 8Q','Havilland Canada-Bombardier DHC-8-100 Dash 8 / 8Q','De Havilland Canada-Bombardier DHC-8-100 Dash 8 / 8Q','De','Havilland Canada-Bombardier DHC-8-100 Dash 8 / 8Q','DH1','DH8A','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('Havilland Canada-Bombardier DHC-8-200 Dash 8 / 8Q','Havilland Canada-Bombardier DHC-8-200 Dash 8 / 8Q','De Havilland Canada-Bombardier DHC-8-200 Dash 8 / 8Q','De','Havilland Canada-Bombardier DHC-8-200 Dash 8 / 8Q','DH2','DH8B','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('Havilland Canada-Bombardier DHC-8-300 Dash 8 / 8Q','Havilland Canada-Bombardier DHC-8-300 Dash 8 / 8Q','De Havilland Canada-Bombardier DHC-8-300 Dash 8 / 8Q','De','Havilland Canada-Bombardier DHC-8-300 Dash 8 / 8Q','DH3','DH8C','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('Havilland Canada-Bombardier DHC-8-400 Dash 8Q','Havilland Canada-Bombardier DHC-8-400 Dash 8Q','De Havilland Canada-Bombardier DHC-8-400 Dash 8Q','De','Havilland Canada-Bombardier DHC-8-400 Dash 8Q','DH4','DH8D','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('Havilland Canada DHC-7 Dash 7','Havilland Canada DHC-7 Dash 7','De Havilland Canada DHC-7 Dash 7','De','Havilland Canada DHC-7 Dash 7','DH7','DHC7','In Service',NULL,'4T','Passenger','M','uploaded',NULL),
('Havilland Canada-Bombardier DHC-8 Dash 8','Havilland Canada-Bombardier DHC-8 Dash 8','De Havilland Canada-Bombardier DHC-8 Dash 8','De','Havilland Canada-Bombardier DHC-8 Dash 8','DH8',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-2 Beaver / Turbo Beaver','Havilland Canada DHC-2 Beaver / Turbo Beaver','De Havilland Canada DHC-2 Beaver / Turbo Beaver','De','Havilland Canada DHC-2 Beaver / Turbo Beaver','DHB',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-4 Caribou','Havilland Canada DHC-4 Caribou','De Havilland Canada DHC-4 Caribou','De','Havilland Canada DHC-4 Caribou','DHC','DHC4','In Service',NULL,'2P','Passenger','L','uploaded',NULL),
('Havilland DH.104 Dove','Havilland DH.104 Dove','De Havilland DH.104 Dove','De','Havilland DH.104 Dove','DHD','DOVE','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('Havilland-Bombardier DHC-8 Freighter','Havilland-Bombardier DHC-8 Freighter','De Havilland-Bombardier DHC-8 Freighter','De','Havilland-Bombardier DHC-8 Freighter','DHF','0000','In Service',NULL,'00','Passenger',NULL,'uploaded',NULL),
('Havilland DH.114 Heron','Havilland DH.114 Heron','De Havilland DH.114 Heron','De','Havilland DH.114 Heron','DHH','HERN','In Service',NULL,'4P','Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-3 Turbo Otter','Havilland Canada DHC-3 Turbo Otter','De Havilland Canada DHC-3 Turbo Otter','De','Havilland Canada DHC-3 Turbo Otter','DHL','DH3T','In Service',NULL,'1T','Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-3 Otter / Turbo Otter','Havilland Canada DHC-3 Otter / Turbo Otter','De Havilland Canada DHC-3 Otter / Turbo Otter','De','Havilland Canada DHC-3 Otter / Turbo Otter','DHO',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-2 Beaver','Havilland Canada DHC-2 Beaver','De Havilland Canada DHC-2 Beaver','De','Havilland Canada DHC-2 Beaver','DHP','DHC2','In Service',NULL,'1P','Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-2 Turbo-Beaver','Havilland Canada DHC-2 Turbo-Beaver','De Havilland Canada DHC-2 Turbo-Beaver','De','Havilland Canada DHC-2 Turbo-Beaver','DHR','DH2T','In Service',NULL,'1T','Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-3 Otter','Havilland Canada DHC-3 Otter','De Havilland Canada DHC-3 Otter','De','Havilland Canada DHC-3 Otter','DHS','DHC3','In Service',NULL,'1P','Passenger',NULL,'uploaded',NULL),
('Havilland Canada DHC-6 Twin Otter','Havilland Canada DHC-6 Twin Otter','De Havilland Canada DHC-6 Twin Otter','De','Havilland Canada DHC-6 Twin Otter','DHT','DHC6','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('EMB 170 / EMB 175','EMB 170 / EMB 175','Embraer EMB 170 / EMB 175','Embraer','EMB 170 / EMB 175','E70','E170','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('EMB 175','EMB 175','Embraer EMB 175','Embraer','EMB 175','E75','E170','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('EMB 190 / EMB 195','EMB 190 / EMB 195','Embraer EMB 190 / EMB 195','Embraer','EMB 190 / EMB 195','E90','E190','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('EMB 195','EMB 195','Embraer EMB 195','Embraer','EMB 195','E95','E190','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Eclipse 500','Eclipse 500','Eclipse Eclipse 500','Eclipse','Eclipse 500','EA5','EA50','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('EC130','EC130','Eurocopter EC130','Eurocopter','EC130','EC3','EC30','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('EMB 120 Brasilia','EMB 120 Brasilia','Embraer EMB 120 Brasilia','Embraer','EMB 120 Brasilia','EM2','E120','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('EMB 110 Bandeirante','EMB 110 Bandeirante','Embraer EMB 110 Bandeirante','Embraer','EMB 110 Bandeirante','EMB','E110','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('EMB 170 / EMB 190','EMB 170 / EMB 190','Embraer EMB 170 / EMB 190','Embraer','EMB 170 / EMB 190','EMJ',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('EMB-500 Phenom 100','EMB-500 Phenom 100','Embraer EMB-500 Phenom 100','Embraer','EMB-500 Phenom 100','EP1','E50P','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('EMB-505 Phenom 300','EMB-505 Phenom 300','Embraer EMB-505 Phenom 300','Embraer','EMB-505 Phenom 300','EP3','E55P','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('ERJ 135','ERJ 135','Embraer ERJ 135','Embraer','ERJ 135','ER3','E135','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('ERJ 145','ERJ 145','Embraer ERJ 145','Embraer','ERJ 145','ER4','E145','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('ERJ 140','ERJ 140','Embraer ERJ 140','Embraer','ERJ 140','ERD','E135','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('ERJ 135 / ERJ 140 / ERJ 145','ERJ 135 / ERJ 140 / ERJ 145','Embraer ERJ 135 / ERJ 140 / ERJ 145','Embraer','ERJ 135 / ERJ 140 / ERJ 145','ERJ',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('F28 Fellowship 1000','F28 Fellowship 1000','Fokker F28 Fellowship 1000','Fokker','F28 Fellowship 1000','F21','F28','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('F28 Fellowship 2000','F28 Fellowship 2000','Fokker F28 Fellowship 2000','Fokker','F28 Fellowship 2000','F22','F28','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('F28 Fellowship 3000','F28 Fellowship 3000','Fokker F28 Fellowship 3000','Fokker','F28 Fellowship 3000','F23','F28','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('F28 Fellowship 4000','F28 Fellowship 4000','Fokker F28 Fellowship 4000','Fokker','F28 Fellowship 4000','F24','F28','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('F27 Friendship','F27 Friendship','Fokker F27 Friendship','Fokker','F27 Friendship','F27','F27','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('F28 Fellowship','F28 Fellowship','Fokker F28 Fellowship','Fokker','F28 Fellowship','F28',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('50','50','Fokker 50','Fokker','50','F50','F50','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('50 Freighter','50 Freighter','Fokker 50 Freighter','Fokker','50 Freighter','F5F','F50','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('70','70','Fokker 70','Fokker','70','F70','F70','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('728JET','728JET','Dornier 728JET','Dornier','728JET','FA7',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('FH-227','FH-227','Fairchild-Hiller FH-227','Fairchild-Hiller','FH-227','FK7','F27','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('328JET','328JET','Dornier 328JET','Dornier','328JET','FR3',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('428JET','428JET','Dornier 428JET','Dornier','428JET','FR4',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('328JET','328JET','Dornier 328JET','Dornier','328JET','FRJ','J328','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('GA8 Airvan','GA8 Airvan','GippsAero GA8 Airvan','GippsAero','GA8 Airvan','GA8','GA8','In Service',NULL,'1P','Passenger',NULL,'uploaded',NULL),
('G-100/G-150','G-100/G-150','Gulfstream G-100/G-150','Gulfstream','G-100/G-150','GR1','G150','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('G-200 (Galaxy)','G-200 (Galaxy)','Gulfstream G-200 (Galaxy)','Gulfstream','G-200 (Galaxy)','GR2','GALX','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('G-250','G-250','Gulfstream G-250','Gulfstream','G-250','GR3','G250','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('G-21 Goose','G-21 Goose','Grumman G-21 Goose','Grumman','G-21 Goose','GRG','G21','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('G-1159 Gulfstream II / III / IV / V','G-1159 Gulfstream II / III / IV / V','Gulfstream G-1159 Gulfstream II / III / IV / V','Gulfstream','G-1159 Gulfstream II / III / IV / V','GRJ','*','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('G-73 Turbo Mallard','G-73 Turbo Mallard','Gulfstream G-73 Turbo Mallard','Gulfstream','G-73 Turbo Mallard','GRM','G73T','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('G-159 Gulfstream I','G-159 Gulfstream I','Gulfstream G-159 Gulfstream I','Gulfstream','G-159 Gulfstream I','GRS','G159','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Hawker 200','Hawker 200','Hawker-Beechcraft Hawker 200','Hawker-Beechcraft','Hawker 200','H20','ZZZZ','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Hawker 1000','Hawker 1000','Hawker-Beechcraft Hawker 1000','Hawker-Beechcraft','Hawker 1000','H21','H25C','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Hawker 4000','Hawker 4000','Hawker-Beechcraft Hawker 4000','Hawker-Beechcraft','Hawker 4000','H24','HA4T','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('HS.125','HS.125','Hawker-Siddeley HS.125','Hawker-Siddeley','HS.125','H25','H25B','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Hawker 850XP/900','Hawker 850XP/900','Hawker-Beechcraft Hawker 850XP/900','Hawker-Beechcraft','Hawker 850XP/900','H28','H25B','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Hawker 900XP','Hawker 900XP','Hawker-Beechcraft Hawker 900XP','Hawker-Beechcraft','Hawker 900XP','H29','H25B','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('H-250 Courier / H-295 / 385 Super Courie','H-250 Courier / H-295 / 385 Super Courie','Helio H-250 Courier / H-295 / 385 Super Courie','Helio','H-250 Courier / H-295 / 385 Super Courie','HEC','COUR','In Service',NULL,'1P','Passenger',NULL,'uploaded',NULL),
('Equipment-Hovercraft','Equipment-Hovercraft','Surface Equipment-Hovercraft','Surface','Equipment-Hovercraft','HOV','0000','In Service',NULL,'S','Passenger',NULL,'uploaded',NULL),
('HS.748','HS.748','BAe HS.748','BAe','HS.748','HS7','A748','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('IL-114','IL-114','Ilyushin IL-114','Ilyushin','IL-114','I14','I114','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('IL-96-300','IL-96-300','Ilyushin IL-96-300','Ilyushin','IL-96-300','I93',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('IL-96 Freighter','IL-96 Freighter','Ilyushin IL-96 Freighter','Ilyushin','IL-96 Freighter','I9F','IL96','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('IL-96M','IL-96M','Ilyushin IL-96M','Ilyushin','IL-96M','I9M',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('IL-96-300 Freighter','IL-96-300 Freighter','Ilyushin IL-96-300 Freighter','Ilyushin','IL-96-300 Freighter','I9X',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('IL-96T Freighter','IL-96T Freighter','Ilyushin IL-96T Freighter','Ilyushin','IL-96T Freighter','I9Y',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('IL-62','IL-62','Ilyushin IL-62','Ilyushin','IL-62','IL6','IL62','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('IL-76','IL-76','Ilyushin IL-76','Ilyushin','IL-76','IL7','IL76','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('IL-18','IL-18','Ilyushin IL-18','Ilyushin','IL-18','IL8','IL18','In Service',NULL,'4T','Passenger',NULL,'uploaded',NULL),
('IL-96','IL-96','Ilyushin IL-96','Ilyushin','IL-96','IL9','IL96','In Service',NULL,'4J','Passenger',NULL,'uploaded',NULL),
('IL-86','IL-86','Ilyushin IL-86','Ilyushin','IL-86','ILW','IL86','In Service',NULL,'4J','Passenger','H','uploaded',NULL),
('Jetstream 31','Jetstream 31','BAe Jetstream 31','BAe','Jetstream 31','J31','JS31','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('Jetstream 32','Jetstream 32','BAe Jetstream 32','BAe','Jetstream 32','J32','JS32','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('Jetstream 41','Jetstream 41','BAe Jetstream 41','BAe','Jetstream 41','J41','JS41','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('Jetstream 31 / 32 / 41','Jetstream 31 / 32 / 41','BAe Jetstream 31 / 32 / 41','BAe','Jetstream 31 / 32 / 41','JST',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Ju 52/3M','Ju 52/3M','Junkers Ju 52/3M','Junkers','Ju 52/3M','JU5','JU52','In Service',NULL,'3P','Passenger',NULL,'uploaded',NULL),
('L-1011 Tristar','L-1011 Tristar','Lockheed L-1011 Tristar','Lockheed','L-1011 Tristar','L10',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('L-1011 1 / 50 / 100 / 150 / 200 / 250 Tr','L-1011 1 / 50 / 100 / 150 / 200 / 250 Tr','Lockheed L-1011 1 / 50 / 100 / 150 / 200 / 250 Tr','Lockheed','L-1011 1 / 50 / 100 / 150 / 200 / 250 Tr','L11','L101','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('L-1011 500 Tristar','L-1011 500 Tristar','Lockheed L-1011 500 Tristar','Lockheed','L-1011 500 Tristar','L15','L101','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('L-1011 Tristar Freighter','L-1011 Tristar Freighter','Lockheed L-1011 Tristar Freighter','Lockheed','L-1011 Tristar Freighter','L1F','L101','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL);
INSERT INTO aircraft_types (aircraft_type,common_name,full_designation,manufacturer,model,iata_code,icao_code,status,generation,category,mission_type,wtc,record_status,source_url) VALUES
('L-1049 Super Constellation','L-1049 Super Constellation','Lockheed L-1049 Super Constellation','Lockheed','L-1049 Super Constellation','L49',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Industries (LET) L-410 Freighter','Industries (LET) L-410 Freighter','Aircraft Industries (LET) L-410 Freighter','Aircraft','Industries (LET) L-410 Freighter','L4F','L410','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('L-410','L-410','LET L-410','LET','L-410','L4T','L410','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Equipment Launch/Boat','Equipment Launch/Boat','Surface Equipment Launch/Boat','Surface','Equipment Launch/Boat','LCH','0000','In Service',NULL,'S','Passenger',NULL,'uploaded',NULL),
('Jet Aircraft','Jet Aircraft','Light Jet Aircraft','Light','Jet Aircraft','LJA','ZZZZ','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Equipment Limousine','Equipment Limousine','Surface Equipment Limousine','Surface','Equipment Limousine','LMO','0000','In Service',NULL,'S','Passenger',NULL,'uploaded',NULL),
('L-188 Electra','L-188 Electra','Lockheed L-188 Electra','Lockheed','L-188 Electra','LOE','L188','In Service',NULL,'4T','Passenger',NULL,'uploaded',NULL),
('L-188 Electra Freighter','L-188 Electra Freighter','Lockheed L-188 Electra Freighter','Lockheed','L-188 Electra Freighter','LOF','L188','In Service',NULL,'4T','Passenger',NULL,'uploaded',NULL),
('L-182 / 282 / 382 (L-100) Hercules','L-182 / 282 / 382 (L-100) Hercules','Lockheed L-182 / 282 / 382 (L-100) Hercules','Lockheed','L-182 / 282 / 382 (L-100) Hercules','LOH','C130','In Service',NULL,'4T','Passenger','H','uploaded',NULL),
('L-188 Electra Mixed','L-188 Electra Mixed','Lockheed L-188 Electra Mixed','Lockheed','L-188 Electra Mixed','LOM',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Gates Learjet','Gates Learjet','Learjet Gates Learjet','Learjet','Gates Learjet','LRJ','*','In Service',NULL,'2J','Passenger','L','uploaded',NULL),
('Douglas MD-11','Douglas MD-11','McDonnell Douglas MD-11','McDonnell','Douglas MD-11','M11','MD11','In Service',NULL,'3J','Passenger','H','uploaded',NULL),
('Douglas MD-11 Freighter','Douglas MD-11 Freighter','McDonnell Douglas MD-11 Freighter','McDonnell','Douglas MD-11 Freighter','M1F','MD11','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Douglas MD-11 Mixed','Douglas MD-11 Mixed','McDonnell Douglas MD-11 Mixed','McDonnell','Douglas MD-11 Mixed','M1M','MD11','In Service',NULL,'3J','Passenger',NULL,'uploaded',NULL),
('Douglas MD82 Freighter','Douglas MD82 Freighter','McDonnell Douglas MD82 Freighter','McDonnell','Douglas MD82 Freighter','M2F','MD82','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Douglas MD83 Freighter','Douglas MD83 Freighter','McDonnell Douglas MD83 Freighter','McDonnell','Douglas MD83 Freighter','M3F','MD83','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Douglas MD-80','Douglas MD-80','McDonnell Douglas MD-80','McDonnell','Douglas MD-80','M80',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Douglas MD-81','Douglas MD-81','McDonnell Douglas MD-81','McDonnell','Douglas MD-81','M81','MD81','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Douglas MD-82','Douglas MD-82','McDonnell Douglas MD-82','McDonnell','Douglas MD-82','M82','MD82','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Douglas MD-83','Douglas MD-83','McDonnell Douglas MD-83','McDonnell','Douglas MD-83','M83','MD83','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Douglas MD-87','Douglas MD-87','McDonnell Douglas MD-87','McDonnell','Douglas MD-87','M87','MD87','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Douglas MD-88','Douglas MD-88','McDonnell Douglas MD-88','McDonnell','Douglas MD-88','M88','MD88','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Douglas MD88 Freighter','Douglas MD88 Freighter','McDonnell Douglas MD88 Freighter','McDonnell','Douglas MD88 Freighter','M8F','MD88','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Douglas MD-90','Douglas MD-90','McDonnell Douglas MD-90','McDonnell','Douglas MD-90','M90','MD90','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Douglas MD-95','Douglas MD-95','McDonnell Douglas MD-95','McDonnell','Douglas MD-95','M95',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('MA-60','MA-60','Xian MA-60','Xian','MA-60','MA6','AN24','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Bo 105','Bo 105','MBB Bo 105','MBB','Bo 105','MBH','B105','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('Helicopters MD900 Explorer','Helicopters MD900 Explorer','MD Helicopters MD900 Explorer','MD','Helicopters MD900 Explorer','MD9','EXPL','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('Mi-8 / Mi-17 / Mi-171 / Mil-172','Mi-8 / Mi-17 / Mi-171 / Mil-172','Mil Mi-8 / Mi-17 / Mi-171 / Mil-172','Mil','Mi-8 / Mi-17 / Mi-171 / Mil-172','MIH','MI8','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('Mu-2','Mu-2','Mitsubishi Mu-2','Mitsubishi','Mu-2','MU2','MU2','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ SNCAN N.262','/ SNCAN N.262','Nord / SNCAN N.262','Nord','/ SNCAN N.262','ND2',NULL,'In Service',NULL,NULL,'Passenger','L','uploaded',NULL),
('/ SNIAS SN.601 Corvette','/ SNIAS SN.601 Corvette','Aerospatiale / SNIAS SN.601 Corvette','Aerospatiale','/ SNIAS SN.601 Corvette','NDC','S601','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('AS350 Ecureuil / AS355 Ecureuil 2','AS350 Ecureuil / AS355 Ecureuil 2','Eurocopter AS350 Ecureuil / AS355 Ecureuil 2','Eurocopter','AS350 Ecureuil / AS355 Ecureuil 2','NDE','*','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('SA365C / SA365N Dauphin 2','SA365C / SA365N Dauphin 2','Eurocopter SA365C / SA365N Dauphin 2','Eurocopter','SA365C / SA365N Dauphin 2','NDH','*','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('Aero P180 Avanti II','Aero P180 Avanti II','Piaggio Aero P180 Avanti II','Piaggio','Aero P180 Avanti II','P18','P180','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Piper single piston engine','Piper single piston engine','Piper Piper single piston engine','Piper','Piper single piston engine','PA1','*','In Service',NULL,'1P','Passenger',NULL,'uploaded',NULL),
('Piper twin piston engines','Piper twin piston engines','Piper Piper twin piston engines','Piper','Piper twin piston engines','PA2','*','In Service',NULL,'2P','Passenger','L','uploaded',NULL),
('Piper light aircraft','Piper light aircraft','Piper Piper light aircraft','Piper','Piper light aircraft','PAG',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Piper twin turboprop engines','Piper twin turboprop engines','Piper Piper twin turboprop engines','Piper','Piper twin turboprop engines','PAT','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('PC-12','PC-12','Pilatus PC-12','Pilatus','PC-12','PL2','PC12','In Service',NULL,'1T','Passenger','L','uploaded',NULL),
('PC-6 Turbo Porter','PC-6 Turbo Porter','Pilatus PC-6 Turbo Porter','Pilatus','PC-6 Turbo Porter','PL6','PC6T','In Service',NULL,'1T','Passenger',NULL,'uploaded',NULL),
('P.68','P.68','Partenavia P.68','Partenavia','P.68','PN6','P68','In Service',NULL,'2P','Passenger',NULL,'uploaded',NULL),
('Hawker 390 Premier 1/1A','Hawker 390 Premier 1/1A','Hawker-Beechcraft Hawker 390 Premier 1/1A','Hawker-Beechcraft','Hawker 390 Premier 1/1A','PRI','PRM1','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Equipment-Road Feeder Service (Truck)','Equipment-Road Feeder Service (Truck)','Surface Equipment-Road Feeder Service (Truck)','Surface','Equipment-Road Feeder Service (Truck)','RFS','0000','In Service',NULL,'S','Passenger',NULL,'uploaded',NULL),
('2000','2000','Saab 2000','Saab','2000','S20','SB20','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('S-58T','S-58T','Sikorsky S-58T','Sikorsky','S-58T','S58','S58T','In Service',NULL,'H','Passenger',NULL,'uploaded',NULL),
('S-61','S-61','Sikorsky S-61','Sikorsky','S-61','S61','S61','In Service',NULL,'H','Passenger','M','uploaded',NULL),
('S-76','S-76','Sikorsky S-76','Sikorsky','S-76','S76','S76','In Service',NULL,'H','Passenger','L','uploaded',NULL),
('SF340A/B','SF340A/B','Saab SF340A/B','Saab','SF340A/B','SF3','SF34','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('SF340B','SF340B','Saab SF340B','Saab','SF340B','SFB','SF34','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('SF340 Freighter','SF340 Freighter','Saab SF340 Freighter','Saab','SF340 Freighter','SFF','SF34','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('SD.330','SD.330','Shorts SD.330','Shorts','SD.330','SH3','SH33','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('SD.360','SD.360','Shorts SD.360','Shorts','SD.360','SH6','SH36','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('SC-5 Belfast','SC-5 Belfast','Shorts SC-5 Belfast','Shorts','SC-5 Belfast','SHB',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('SC-7 Skyvan','SC-7 Skyvan','Shorts SC-7 Skyvan','Shorts','SC-7 Skyvan','SHS','SC7','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('/ SNIAS Concorde','/ SNIAS Concorde','Aerospatiale / SNIAS Concorde','Aerospatiale','/ SNIAS Concorde','SSC',NULL,'In Service',NULL,NULL,'Passenger','H','uploaded',NULL),
('Superjet 100','Superjet 100','Sukhoi Superjet 100','Sukhoi','Superjet 100','SU1',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Superjet 100-75','Superjet 100-75','Sukhoi Superjet 100-75','Sukhoi','Superjet 100-75','SU7','ZZZZ','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Superjet 100-95','Superjet 100-95','Sukhoi Superjet 100-95','Sukhoi','Superjet 100-95','SU9','SU95','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('SA226 Freighter','SA226 Freighter','Fairchild-Swearingen SA226 Freighter','Fairchild-Swearingen','SA226 Freighter','SWF','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('SA26 / SA226 / SA227 Metro / Merlin','SA26 / SA226 / SA227 Metro / Merlin','Fairchild-Swearingen SA26 / SA226 / SA227 Metro / Merlin','Fairchild-Swearingen','SA26 / SA226 / SA227 Metro / Merlin','SWM','*','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('Y-8','Y-8','Shaanxi Y-8','Shaanxi','Y-8','SY8','AN12','In Service',NULL,'4T','Passenger',NULL,'uploaded',NULL),
('Tu-204 / Tu-214','Tu-204 / Tu-214','Tupolev Tu-204 / Tu-214','Tupolev','Tu-204 / Tu-214','T20','T204','In Service',NULL,'2J','Passenger','H','uploaded',NULL),
('Tu-204 Freighter','Tu-204 Freighter','Tupolev Tu-204 Freighter','Tupolev','Tu-204 Freighter','T2F','T204','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('Tu-334','Tu-334','Tupolev Tu-334','Tupolev','Tu-334','T34','T334','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('TBM-700','TBM-700','DAHER-SOCATA TBM-700','DAHER-SOCATA','TBM-700','TBM','TBM7','In Service',NULL,'1T','Passenger',NULL,'uploaded',NULL),
('Equipment Train','Equipment Train','Surface Equipment Train','Surface','Equipment Train','TRN','0000','In Service',NULL,'S','Passenger',NULL,'uploaded',NULL),
('Tu-134','Tu-134','Tupolev Tu-134','Tupolev','Tu-134','TU3','T134','In Service',NULL,'2J','Passenger','M','uploaded',NULL),
('Tu-154','Tu-154','Tupolev Tu-154','Tupolev','Tu-154','TU5','T154','In Service',NULL,'3J','Passenger','H','uploaded',NULL),
('Viscount','Viscount','Vickers Viscount','Vickers','Viscount','VCV',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('VC-10','VC-10','Vickers VC-10','Vickers','VC-10','VCX',NULL,'In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('1124 Westwind','1124 Westwind','IAI 1124 Westwind','IAI','1124 Westwind','WWP','WW24','In Service',NULL,'2J','Passenger',NULL,'uploaded',NULL),
('/ Jakovlev Yak 42','/ Jakovlev Yak 42','Yakovlev / Jakovlev Yak 42','Yakovlev','/ Jakovlev Yak 42','YK2','YK42','In Service',NULL,'3J','Passenger','M','uploaded',NULL),
('/ Jakovlev Yak 40','/ Jakovlev Yak 40','Yakovlev / Jakovlev Yak 40','Yakovlev','/ Jakovlev Yak 40','YK4','YK40','In Service',NULL,'3J','Passenger','L','uploaded',NULL),
('/ Harbin Y12','/ Harbin Y12','HAMC / Harbin Y12','HAMC','/ Harbin Y12','YN2','Y12','In Service',NULL,'2T','Passenger','L','uploaded',NULL),
('Yunshuji Y7','Yunshuji Y7','Xian Yunshuji Y7','Xian','Yunshuji Y7','YN7','AN24','In Service',NULL,'2T','Passenger',NULL,'uploaded',NULL),
('YS-11','YS-11','NAMC YS-11','NAMC','YS-11','YS1','YS11','In Service',NULL,'2T','Passenger','M','uploaded',NULL),
('A330-700 Beluga XL','A330-700 Beluga XL','Airbus A330-700 Beluga XL','Airbus','A330-700 Beluga XL',NULL,'A337','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('An-225 Mriya','An-225 Mriya','Antonov An-225 Mriya','Antonov','An-225 Mriya','A25','A225','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Baron','Baron','Beechcraft Baron','Beechcraft','Baron',NULL,'BE58','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Baron / 55 Baron','Baron / 55 Baron','Beechcraft Baron / 55 Baron','Beechcraft','Baron / 55 Baron',NULL,'BE55','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('777-8','777-8','Boeing 777-8','Boeing','777-8','778','B778','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('777-9','777-9','Boeing 777-9','Boeing','777-9','779','B779','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('787-10','787-10','Boeing 787-10','Boeing','787-10','78J','B78X','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('415','415','Bombardier 415','Bombardier','415',NULL,'CL2T','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('BD-100 Challenger 300','BD-100 Challenger 300','Bombardier BD-100 Challenger 300','Bombardier','BD-100 Challenger 300',NULL,'CL30','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('152','152','Cessna 152','Cessna','152',NULL,'C152','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('C-919','C-919','COMAC C-919','COMAC','C-919',NULL,'C919','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('175 (long wing)','175 (long wing)','Embraer 175 (long wing)','Embraer','175 (long wing)','E7W','E75L','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('175 (short wing)','175 (short wing)','Embraer 175 (short wing)','Embraer','175 (short wing)','E7W','E75S','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Legacy 450','Legacy 450','Embraer Legacy 450','Embraer','Legacy 450',NULL,'E545','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('G650','G650','Gulfstream G650','Gulfstream','G650','GJ6','GLF6','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('IV','IV','Gulfstream IV','Gulfstream','IV','GJ4','GLF4','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('V','V','Gulfstream V','Gulfstream','V','GJ5','GLF5','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('PA-28 (above 200 hp)','PA-28 (above 200 hp)','Piper PA-28 (above 200 hp)','Piper','PA-28 (above 200 hp)',NULL,'P28B','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('PA-28 (up to 180 hp)','PA-28 (up to 180 hp)','Piper PA-28 (up to 180 hp)','Piper','PA-28 (up to 180 hp)',NULL,'P28A','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('PA-44 Seminole','PA-44 Seminole','Piper PA-44 Seminole','Piper','PA-44 Seminole',NULL,'PA44','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('S-92','S-92','Sikorsky S-92','Sikorsky','S-92','S92','S92','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL),
('Tu-144','Tu-144','Tupolev Tu-144','Tupolev','Tu-144',NULL,'T144','In Service',NULL,NULL,'Passenger',NULL,'uploaded',NULL);
INSERT INTO aircraft_type_assets (iata_code,icao_code,primary_livery_url,lopa_template_url,cockpit_reference_url) VALUES
('100','100',NULL,NULL,NULL),
('141','141',NULL,NULL,NULL),
('142','142',NULL,NULL,NULL),
('143','143',NULL,NULL,NULL),
('146','146',NULL,NULL,NULL),
('14F','14F',NULL,NULL,NULL),
('14X','14X',NULL,NULL,NULL),
('14Y','14Y',NULL,NULL,NULL),
('14Z','14Z',NULL,NULL,NULL),
('19D','19D',NULL,NULL,NULL),
('221','221',NULL,NULL,NULL),
('223','223',NULL,NULL,NULL),
('290','290',NULL,NULL,NULL),
('295','295',NULL,NULL,NULL),
('310','310',NULL,NULL,NULL),
('312','312',NULL,NULL,NULL),
('313','313',NULL,NULL,NULL),
('318','318',NULL,NULL,NULL),
('319','319',NULL,NULL,NULL),
('31F','31F',NULL,NULL,NULL),
('31N','31N',NULL,NULL,NULL),
('31W','31W',NULL,NULL,NULL),
('31X','31X',NULL,NULL,NULL),
('31Y','31Y',NULL,NULL,NULL),
('320','320',NULL,NULL,NULL),
('321','321',NULL,NULL,NULL),
('32A','32A',NULL,NULL,NULL),
('32B','32B',NULL,NULL,NULL),
('32C','32C',NULL,NULL,NULL),
('32D','32D',NULL,NULL,NULL),
('32F','32F',NULL,NULL,NULL),
('32N','32N',NULL,NULL,NULL),
('32Q','32Q',NULL,NULL,NULL),
('32S','32S',NULL,NULL,NULL),
('32X','32X',NULL,NULL,NULL),
('330','330',NULL,NULL,NULL),
('332','332',NULL,NULL,NULL),
('333','333',NULL,NULL,NULL),
('338','338',NULL,NULL,NULL),
('339','339',NULL,NULL,NULL),
('33F','33F',NULL,NULL,NULL),
('33X','33X',NULL,NULL,NULL),
('340','340',NULL,NULL,NULL),
('342','342',NULL,NULL,NULL),
('343','343',NULL,NULL,NULL),
('345','345',NULL,NULL,NULL),
('346','346',NULL,NULL,NULL),
('350','350',NULL,NULL,NULL),
('351','351',NULL,NULL,NULL),
('358','358',NULL,NULL,NULL),
('359','359',NULL,NULL,NULL),
('380','380',NULL,NULL,NULL),
('388','388',NULL,NULL,NULL),
('38F','38F',NULL,NULL,NULL),
('703','703',NULL,NULL,NULL),
('707','707',NULL,NULL,NULL),
('70F','70F',NULL,NULL,NULL),
('70M','70M',NULL,NULL,NULL),
('717','717',NULL,NULL,NULL),
('721','721',NULL,NULL,NULL),
('722','722',NULL,NULL,NULL),
('727','727',NULL,NULL,NULL),
('72A','72A',NULL,NULL,NULL),
('72B','72B',NULL,NULL,NULL),
('72C','72C',NULL,NULL,NULL),
('72F','72F',NULL,NULL,NULL),
('72M','72M',NULL,NULL,NULL),
('72S','72S',NULL,NULL,NULL),
('72W','72W',NULL,NULL,NULL),
('72X','72X',NULL,NULL,NULL),
('72Y','72Y',NULL,NULL,NULL),
('731','731',NULL,NULL,NULL),
('732','732',NULL,NULL,NULL),
('733','733',NULL,NULL,NULL),
('734','734',NULL,NULL,NULL),
('735','735',NULL,NULL,NULL),
('736','736',NULL,NULL,NULL),
('737','737',NULL,NULL,NULL),
('738','738',NULL,NULL,NULL),
('739','739',NULL,NULL,NULL),
('73A','73A',NULL,NULL,NULL),
('73C','73C',NULL,NULL,NULL),
('73E','73E',NULL,NULL,NULL),
('73F','73F',NULL,NULL,NULL),
('73G','73G',NULL,NULL,NULL),
('73H','73H',NULL,NULL,NULL),
('73J','73J',NULL,NULL,NULL),
('73L','73L',NULL,NULL,NULL),
('73M','73M',NULL,NULL,NULL),
('73N','73N',NULL,NULL,NULL),
('73P','73P',NULL,NULL,NULL),
('73Q','73Q',NULL,NULL,NULL),
('73R','73R',NULL,NULL,NULL),
('73S','73S',NULL,NULL,NULL),
('73W','73W',NULL,NULL,NULL),
('73X','73X',NULL,NULL,NULL),
('73Y','73Y',NULL,NULL,NULL),
('73Z','73Z',NULL,NULL,NULL),
('741','741',NULL,NULL,NULL),
('742','742',NULL,NULL,NULL),
('743','743',NULL,NULL,NULL),
('744','744',NULL,NULL,NULL),
('747','747',NULL,NULL,NULL),
('748','748',NULL,NULL,NULL),
('74B','74B',NULL,NULL,NULL),
('74C','74C',NULL,NULL,NULL),
('74D','74D',NULL,NULL,NULL),
('74E','74E',NULL,NULL,NULL),
('74F','74F',NULL,NULL,NULL),
('74H','74H',NULL,NULL,NULL),
('74J','74J',NULL,NULL,NULL),
('74L','74L',NULL,NULL,NULL),
('74M','74M',NULL,NULL,NULL),
('74N','74N',NULL,NULL,NULL),
('74R','74R',NULL,NULL,NULL),
('74T','74T',NULL,NULL,NULL),
('74U','74U',NULL,NULL,NULL),
('74V','74V',NULL,NULL,NULL),
('74X','74X',NULL,NULL,NULL),
('74Y','74Y',NULL,NULL,NULL),
('752','752',NULL,NULL,NULL),
('753','753',NULL,NULL,NULL),
('757','757',NULL,NULL,NULL),
('75F','75F',NULL,NULL,NULL),
('75M','75M',NULL,NULL,NULL),
('75T','75T',NULL,NULL,NULL),
('75W','75W',NULL,NULL,NULL),
('762','762',NULL,NULL,NULL),
('763','763',NULL,NULL,NULL),
('764','764',NULL,NULL,NULL),
('767','767',NULL,NULL,NULL),
('76F','76F',NULL,NULL,NULL),
('76V','76V',NULL,NULL,NULL),
('76W','76W',NULL,NULL,NULL),
('76X','76X',NULL,NULL,NULL),
('76Y','76Y',NULL,NULL,NULL),
('772','772',NULL,NULL,NULL),
('773','773',NULL,NULL,NULL),
('777','777',NULL,NULL,NULL),
('77F','77F',NULL,NULL,NULL),
('77L','77L',NULL,NULL,NULL),
('77W','77W',NULL,NULL,NULL),
('77X','77X',NULL,NULL,NULL),
('781','781',NULL,NULL,NULL),
('783','783',NULL,NULL,NULL),
('787','787',NULL,NULL,NULL),
('788','788',NULL,NULL,NULL),
('789','789',NULL,NULL,NULL),
('7M7','7M7',NULL,NULL,NULL),
('7M8','7M8',NULL,NULL,NULL),
('7M9','7M9',NULL,NULL,NULL),
('7MJ','7MJ',NULL,NULL,NULL),
('A22','A22',NULL,NULL,NULL),
('A26','A26',NULL,NULL,NULL),
('A28','A28',NULL,NULL,NULL),
('A30','A30',NULL,NULL,NULL),
('A32','A32',NULL,NULL,NULL),
('A38','A38',NULL,NULL,NULL),
('A40','A40',NULL,NULL,NULL),
('A4F','A4F',NULL,NULL,NULL),
('A58','A58',NULL,NULL,NULL),
('A5F','A5F',NULL,NULL,NULL),
('A81','A81',NULL,NULL,NULL),
('AB2','AB2',NULL,NULL,NULL),
('AB3','AB3',NULL,NULL,NULL),
('AB4','AB4',NULL,NULL,NULL),
('AB6','AB6',NULL,NULL,NULL),
('ABB','ABB',NULL,NULL,NULL),
('ABF','ABF',NULL,NULL,NULL),
('ABM','ABM',NULL,NULL,NULL),
('ABX','ABX',NULL,NULL,NULL),
('ABY','ABY',NULL,NULL,NULL),
('ACD','ACD',NULL,NULL,NULL),
('ACP','ACP',NULL,NULL,NULL),
('ACT','ACT',NULL,NULL,NULL),
('AGH','AGH',NULL,NULL,NULL),
('ALM','ALM',NULL,NULL,NULL),
('AMD','AMD',NULL,NULL,NULL),
('AN2','AN2',NULL,NULL,NULL),
('AN4','AN4',NULL,NULL,NULL),
('AN6','AN6',NULL,NULL,NULL),
('AN7','AN7',NULL,NULL,NULL),
('ANF','ANF',NULL,NULL,NULL),
('APF','APF',NULL,NULL,NULL),
('APH','APH',NULL,NULL,NULL),
('AR1','AR1',NULL,NULL,NULL),
('AR7','AR7',NULL,NULL,NULL),
('AR8','AR8',NULL,NULL,NULL),
('ARJ','ARJ',NULL,NULL,NULL),
('ARX','ARX',NULL,NULL,NULL),
('AT4','AT4',NULL,NULL,NULL),
('AT5','AT5',NULL,NULL,NULL),
('AT7','AT7',NULL,NULL,NULL),
('ATD','ATD',NULL,NULL,NULL),
('ATF','ATF',NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL),
('ATR','ATR',NULL,NULL,NULL),
('ATZ','ATZ',NULL,NULL,NULL),
('AWH','AWH',NULL,NULL,NULL),
('AX1','AX1',NULL,NULL,NULL);
INSERT INTO aircraft_type_assets (iata_code,icao_code,primary_livery_url,lopa_template_url,cockpit_reference_url) VALUES
('AX8','AX8',NULL,NULL,NULL),
('B11','B11',NULL,NULL,NULL),
('B12','B12',NULL,NULL,NULL),
('B13','B13',NULL,NULL,NULL),
('B14','B14',NULL,NULL,NULL),
('B15','B15',NULL,NULL,NULL),
('B72','B72',NULL,NULL,NULL),
('BE1','BE1',NULL,NULL,NULL),
('BE2','BE2',NULL,NULL,NULL),
('BE4','BE4',NULL,NULL,NULL),
('BE9','BE9',NULL,NULL,NULL),
('BEC','BEC',NULL,NULL,NULL),
('BEF','BEF',NULL,NULL,NULL),
('BEH','BEH',NULL,NULL,NULL),
('BEP','BEP',NULL,NULL,NULL),
('BES','BES',NULL,NULL,NULL),
('BET','BET',NULL,NULL,NULL),
('BH2','BH2',NULL,NULL,NULL),
('BNI','BNI',NULL,NULL,NULL),
('BNT','BNT',NULL,NULL,NULL),
('BTA','BTA',NULL,NULL,NULL),
('BUS','BUS',NULL,NULL,NULL),
('C27','C27',NULL,NULL,NULL),
('C9B','C9B',NULL,NULL,NULL),
('CCJ','CCJ',NULL,NULL,NULL),
('CCX','CCX',NULL,NULL,NULL),
('CD2','CD2',NULL,NULL,NULL),
('CJ1','CJ1',NULL,NULL,NULL),
('CJ2','CJ2',NULL,NULL,NULL),
('CJ5','CJ5',NULL,NULL,NULL),
('CJ6','CJ6',NULL,NULL,NULL),
('CJ8','CJ8',NULL,NULL,NULL),
('CJL','CJL',NULL,NULL,NULL),
('CJM','CJM',NULL,NULL,NULL),
('CL3','CL3',NULL,NULL,NULL),
('CL4','CL4',NULL,NULL,NULL),
('CN1','CN1',NULL,NULL,NULL),
('CN2','CN2',NULL,NULL,NULL),
('CN7','CN7',NULL,NULL,NULL),
('CNA','CNA',NULL,NULL,NULL),
('CNC','CNC',NULL,NULL,NULL),
('CNF','CNF',NULL,NULL,NULL),
('CNJ','CNJ',NULL,NULL,NULL),
('CNT','CNT',NULL,NULL,NULL),
('CR1','CR1',NULL,NULL,NULL),
('CR2','CR2',NULL,NULL,NULL),
('CR7','CR7',NULL,NULL,NULL),
('CR9','CR9',NULL,NULL,NULL),
('CRA','CRA',NULL,NULL,NULL),
('CRF','CRF',NULL,NULL,NULL),
('CRJ','CRJ',NULL,NULL,NULL),
('CRK','CRK',NULL,NULL,NULL),
('CRV','CRV',NULL,NULL,NULL),
('CS1','CS1',NULL,NULL,NULL),
('CS2','CS2',NULL,NULL,NULL),
('CS3','CS3',NULL,NULL,NULL),
('CS5','CS5',NULL,NULL,NULL),
('CV2','CV2',NULL,NULL,NULL),
('CV4','CV4',NULL,NULL,NULL),
('CV5','CV5',NULL,NULL,NULL),
('CV6','CV6',NULL,NULL,NULL),
('CVF','CVF',NULL,NULL,NULL),
('CVR','CVR',NULL,NULL,NULL),
('CVV','CVV',NULL,NULL,NULL),
('CVX','CVX',NULL,NULL,NULL),
('CVY','CVY',NULL,NULL,NULL),
('CWC','CWC',NULL,NULL,NULL),
('D10','D10',NULL,NULL,NULL),
('D11','D11',NULL,NULL,NULL),
('D14','D14',NULL,NULL,NULL),
('D1C','D1C',NULL,NULL,NULL),
('D1F','D1F',NULL,NULL,NULL),
('D1M','D1M',NULL,NULL,NULL),
('D1X','D1X',NULL,NULL,NULL),
('D1Y','D1Y',NULL,NULL,NULL),
('D20','D20',NULL,NULL,NULL),
('D28','D28',NULL,NULL,NULL),
('D2L','D2L',NULL,NULL,NULL),
('D38','D38',NULL,NULL,NULL),
('D3F','D3F',NULL,NULL,NULL),
('D42','D42',NULL,NULL,NULL),
('D4X','D4X',NULL,NULL,NULL),
('D6F','D6F',NULL,NULL,NULL),
('D85','D85',NULL,NULL,NULL),
('D86','D86',NULL,NULL,NULL),
('D87','D87',NULL,NULL,NULL),
('D8A','D8A',NULL,NULL,NULL),
('D8B','D8B',NULL,NULL,NULL),
('D8F','D8F',NULL,NULL,NULL),
('D8L','D8L',NULL,NULL,NULL),
('D8M','D8M',NULL,NULL,NULL),
('D8Q','D8Q',NULL,NULL,NULL),
('D8T','D8T',NULL,NULL,NULL),
('D8X','D8X',NULL,NULL,NULL),
('D8Y','D8Y',NULL,NULL,NULL),
('D91','D91',NULL,NULL,NULL),
('D92','D92',NULL,NULL,NULL),
('D93','D93',NULL,NULL,NULL),
('D94','D94',NULL,NULL,NULL),
('D95','D95',NULL,NULL,NULL),
('D9C','D9C',NULL,NULL,NULL),
('D9D','D9D',NULL,NULL,NULL),
('D9F','D9F',NULL,NULL,NULL),
('D9L','D9L',NULL,NULL,NULL),
('D9X','D9X',NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL),
('DC8','DC8',NULL,NULL,NULL),
('DC9','DC9',NULL,NULL,NULL),
('DF1','DF1',NULL,NULL,NULL),
('DF2','DF2',NULL,NULL,NULL),
('DF3','DF3',NULL,NULL,NULL),
('DF5','DF5',NULL,NULL,NULL),
('DF7','DF7',NULL,NULL,NULL),
('DF9','DF9',NULL,NULL,NULL),
('DFL','DFL',NULL,NULL,NULL),
('DH1','DH1',NULL,NULL,NULL),
('DH2','DH2',NULL,NULL,NULL),
('DH3','DH3',NULL,NULL,NULL),
('DH4','DH4',NULL,NULL,NULL),
('DH7','DH7',NULL,NULL,NULL),
('DH8','DH8',NULL,NULL,NULL),
('DHB','DHB',NULL,NULL,NULL),
('DHC','DHC',NULL,NULL,NULL),
('DHD','DHD',NULL,NULL,NULL),
('DHF','DHF',NULL,NULL,NULL),
('DHH','DHH',NULL,NULL,NULL),
('DHL','DHL',NULL,NULL,NULL),
('DHO','DHO',NULL,NULL,NULL),
('DHP','DHP',NULL,NULL,NULL),
('DHR','DHR',NULL,NULL,NULL),
('DHS','DHS',NULL,NULL,NULL),
('DHT','DHT',NULL,NULL,NULL),
('E70','E70',NULL,NULL,NULL),
('E75','E75',NULL,NULL,NULL),
('E90','E90',NULL,NULL,NULL),
('E95','E95',NULL,NULL,NULL),
('EA5','EA5',NULL,NULL,NULL),
('EC3','EC3',NULL,NULL,NULL),
('EM2','EM2',NULL,NULL,NULL),
('EMB','EMB',NULL,NULL,NULL),
('EMJ','EMJ',NULL,NULL,NULL),
('EP1','EP1',NULL,NULL,NULL),
('EP3','EP3',NULL,NULL,NULL),
('ER3','ER3',NULL,NULL,NULL),
('ER4','ER4',NULL,NULL,NULL),
('ERD','ERD',NULL,NULL,NULL),
('ERJ','ERJ',NULL,NULL,NULL),
('F21','F21',NULL,NULL,NULL),
('F22','F22',NULL,NULL,NULL),
('F23','F23',NULL,NULL,NULL),
('F24','F24',NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL),
('F28','F28',NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL),
('F5F','F5F',NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL),
('FA7','FA7',NULL,NULL,NULL),
('FK7','FK7',NULL,NULL,NULL),
('FR3','FR3',NULL,NULL,NULL),
('FR4','FR4',NULL,NULL,NULL),
('FRJ','FRJ',NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL),
('GR1','GR1',NULL,NULL,NULL),
('GR2','GR2',NULL,NULL,NULL),
('GR3','GR3',NULL,NULL,NULL),
('GRG','GRG',NULL,NULL,NULL),
('GRJ','GRJ',NULL,NULL,NULL),
('GRM','GRM',NULL,NULL,NULL),
('GRS','GRS',NULL,NULL,NULL),
('H20','H20',NULL,NULL,NULL),
('H21','H21',NULL,NULL,NULL),
('H24','H24',NULL,NULL,NULL),
('H25','H25',NULL,NULL,NULL),
('H28','H28',NULL,NULL,NULL),
('H29','H29',NULL,NULL,NULL),
('HEC','HEC',NULL,NULL,NULL),
('HOV','HOV',NULL,NULL,NULL),
('HS7','HS7',NULL,NULL,NULL),
('I14','I14',NULL,NULL,NULL),
('I93','I93',NULL,NULL,NULL),
('I9F','I9F',NULL,NULL,NULL),
('I9M','I9M',NULL,NULL,NULL),
('I9X','I9X',NULL,NULL,NULL),
('I9Y','I9Y',NULL,NULL,NULL),
('IL6','IL6',NULL,NULL,NULL),
('IL7','IL7',NULL,NULL,NULL),
('IL8','IL8',NULL,NULL,NULL),
('IL9','IL9',NULL,NULL,NULL),
('ILW','ILW',NULL,NULL,NULL),
('J31','J31',NULL,NULL,NULL),
('J32','J32',NULL,NULL,NULL),
('J41','J41',NULL,NULL,NULL),
('JST','JST',NULL,NULL,NULL),
('JU5','JU5',NULL,NULL,NULL),
('L10','L10',NULL,NULL,NULL),
('L11','L11',NULL,NULL,NULL),
('L15','L15',NULL,NULL,NULL),
('L1F','L1F',NULL,NULL,NULL);
INSERT INTO aircraft_type_assets (iata_code,icao_code,primary_livery_url,lopa_template_url,cockpit_reference_url) VALUES
('L49','L49',NULL,NULL,NULL),
('L4F','L4F',NULL,NULL,NULL),
('L4T','L4T',NULL,NULL,NULL),
('LCH','LCH',NULL,NULL,NULL),
('LJA','LJA',NULL,NULL,NULL),
('LMO','LMO',NULL,NULL,NULL),
('LOE','LOE',NULL,NULL,NULL),
('LOF','LOF',NULL,NULL,NULL),
('LOH','LOH',NULL,NULL,NULL),
('LOM','LOM',NULL,NULL,NULL),
('LRJ','LRJ',NULL,NULL,NULL),
('M11','M11',NULL,NULL,NULL),
('M1F','M1F',NULL,NULL,NULL),
('M1M','M1M',NULL,NULL,NULL),
('M2F','M2F',NULL,NULL,NULL),
('M3F','M3F',NULL,NULL,NULL),
('M80','M80',NULL,NULL,NULL),
('M81','M81',NULL,NULL,NULL),
('M82','M82',NULL,NULL,NULL),
('M83','M83',NULL,NULL,NULL),
('M87','M87',NULL,NULL,NULL),
('M88','M88',NULL,NULL,NULL),
('M8F','M8F',NULL,NULL,NULL),
('M90','M90',NULL,NULL,NULL),
('M95','M95',NULL,NULL,NULL),
('MA6','MA6',NULL,NULL,NULL),
('MBH','MBH',NULL,NULL,NULL),
('MD9','MD9',NULL,NULL,NULL),
('MIH','MIH',NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL),
('ND2','ND2',NULL,NULL,NULL),
('NDC','NDC',NULL,NULL,NULL),
('NDE','NDE',NULL,NULL,NULL),
('NDH','NDH',NULL,NULL,NULL),
('P18','P18',NULL,NULL,NULL),
('PA1','PA1',NULL,NULL,NULL),
('PA2','PA2',NULL,NULL,NULL),
('PAG','PAG',NULL,NULL,NULL),
('PAT','PAT',NULL,NULL,NULL),
('PL2','PL2',NULL,NULL,NULL),
('PL6','PL6',NULL,NULL,NULL),
('PN6','PN6',NULL,NULL,NULL),
('PRI','PRI',NULL,NULL,NULL),
('RFS','RFS',NULL,NULL,NULL),
('S20','S20',NULL,NULL,NULL),
('S58','S58',NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL),
('SF3','SF3',NULL,NULL,NULL),
('SFB','SFB',NULL,NULL,NULL),
('SFF','SFF',NULL,NULL,NULL),
('SH3','SH3',NULL,NULL,NULL),
('SH6','SH6',NULL,NULL,NULL),
('SHB','SHB',NULL,NULL,NULL),
('SHS','SHS',NULL,NULL,NULL),
('SSC','SSC',NULL,NULL,NULL),
('SU1','SU1',NULL,NULL,NULL),
('SU7','SU7',NULL,NULL,NULL),
('SU9','SU9',NULL,NULL,NULL),
('SWF','SWF',NULL,NULL,NULL),
('SWM','SWM',NULL,NULL,NULL),
('SY8','SY8',NULL,NULL,NULL),
('T20','T20',NULL,NULL,NULL),
('T2F','T2F',NULL,NULL,NULL),
('T34','T34',NULL,NULL,NULL),
('TBM','TBM',NULL,NULL,NULL),
('TRN','TRN',NULL,NULL,NULL),
('TU3','TU3',NULL,NULL,NULL),
('TU5','TU5',NULL,NULL,NULL),
('VCV','VCV',NULL,NULL,NULL),
('VCX','VCX',NULL,NULL,NULL),
('WWP','WWP',NULL,NULL,NULL),
('YK2','YK2',NULL,NULL,NULL),
('YK4','YK4',NULL,NULL,NULL),
('YN2','YN2',NULL,NULL,NULL),
('YN7','YN7',NULL,NULL,NULL),
('YS1','YS1',NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
('A25','A25',NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
('778','778',NULL,NULL,NULL),
('779','779',NULL,NULL,NULL),
('78J','78J',NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
('E7W','E7W',NULL,NULL,NULL),
('E7W','E7W',NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
('GJ6','GJ6',NULL,NULL,NULL),
('GJ4','GJ4',NULL,NULL,NULL),
('GJ5','GJ5',NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL),
(NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_cabin_payload (iata_code,icao_code,typical_c_seats,typical_y_seats,max_capacity,cargo_volume_m3,max_payload_kg) VALUES
('100','F100',NULL,NULL,NULL,NULL,NULL),
('141','B461',NULL,NULL,NULL,NULL,NULL),
('142','B462',NULL,NULL,NULL,NULL,NULL),
('143','B463',NULL,NULL,NULL,NULL,NULL),
('146',NULL,NULL,NULL,NULL,NULL,NULL),
('14F',NULL,NULL,NULL,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL,NULL,NULL),
('290','E290',NULL,NULL,NULL,NULL,NULL),
('295','E295',NULL,NULL,NULL,NULL,NULL),
('310',NULL,NULL,NULL,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL,NULL,NULL),
('318','A318',NULL,NULL,NULL,NULL,NULL),
('319','A319',NULL,NULL,NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL,NULL,NULL),
('31N','A19N',NULL,NULL,NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL,NULL,NULL),
('320','A320',NULL,NULL,NULL,NULL,NULL),
('321','A321',NULL,NULL,NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL,NULL,NULL),
('32N','A20N',NULL,NULL,NULL,NULL,NULL),
('32Q','A21N',NULL,NULL,NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL,NULL,NULL),
('330',NULL,NULL,NULL,NULL,NULL,NULL),
('332','A332',NULL,NULL,NULL,NULL,NULL),
('333','A333',NULL,NULL,NULL,NULL,NULL),
('338','A338',NULL,NULL,NULL,NULL,NULL),
('339','A339',NULL,NULL,NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL,NULL,NULL),
('340',NULL,NULL,NULL,NULL,NULL,NULL),
('342','A342',NULL,NULL,NULL,NULL,NULL),
('343','A343',NULL,NULL,NULL,NULL,NULL),
('345','A345',NULL,NULL,NULL,NULL,NULL),
('346','A346',NULL,NULL,NULL,NULL,NULL),
('350',NULL,NULL,NULL,NULL,NULL,NULL),
('351','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('359','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('380',NULL,NULL,NULL,NULL,NULL,NULL),
('388','A388',NULL,NULL,NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL,NULL,NULL),
('703','B703',NULL,NULL,NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL,NULL,NULL),
('717','B712',NULL,NULL,NULL,NULL,NULL),
('721','B721',NULL,NULL,NULL,NULL,NULL),
('722','B722',NULL,NULL,NULL,NULL,NULL),
('727',NULL,NULL,NULL,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL,NULL,NULL),
('732','B732',NULL,NULL,NULL,NULL,NULL),
('733','B733',NULL,NULL,NULL,NULL,NULL),
('734','B734',NULL,NULL,NULL,NULL,NULL),
('735','B735',NULL,NULL,NULL,NULL,NULL),
('736','B736',NULL,NULL,NULL,NULL,NULL),
('737',NULL,NULL,NULL,NULL,NULL,NULL),
('738','B738',NULL,NULL,NULL,NULL,NULL),
('739','B739',NULL,NULL,NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL,NULL,NULL),
('73G','B737',NULL,NULL,NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL,NULL,NULL),
('741','B741',NULL,NULL,NULL,NULL,NULL),
('742','B742',NULL,NULL,NULL,NULL,NULL),
('743','B743',NULL,NULL,NULL,NULL,NULL),
('744','B744',NULL,NULL,NULL,NULL,NULL),
('747',NULL,NULL,NULL,NULL,NULL,NULL),
('748','B748',NULL,NULL,NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL,NULL,NULL),
('752','B752',NULL,NULL,NULL,NULL,NULL),
('753','B753',NULL,NULL,NULL,NULL,NULL),
('757',NULL,NULL,NULL,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL,NULL,NULL),
('762','B762',NULL,NULL,NULL,NULL,NULL),
('763','B763',NULL,NULL,NULL,NULL,NULL),
('764','B764',NULL,NULL,NULL,NULL,NULL),
('767',NULL,NULL,NULL,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL,NULL,NULL),
('772','B77L',NULL,NULL,NULL,NULL,NULL),
('773','B773',NULL,NULL,NULL,NULL,NULL),
('777',NULL,NULL,NULL,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL,NULL,NULL),
('77L','B772',NULL,NULL,NULL,NULL,NULL),
('77W','B77W',NULL,NULL,NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL,NULL,NULL),
('787',NULL,NULL,NULL,NULL,NULL,NULL),
('788','B788',NULL,NULL,NULL,NULL,NULL),
('789','B789',NULL,NULL,NULL,NULL,NULL),
('7M7','B37M',NULL,NULL,NULL,NULL,NULL),
('7M8','B38M',NULL,NULL,NULL,NULL,NULL),
('7M9','B39M',NULL,NULL,NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,NULL,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL,NULL,NULL),
('AB6','A306',NULL,NULL,NULL,NULL,NULL),
('ABB','A3ST',NULL,NULL,NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,NULL,NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL,NULL,NULL),
('ANF','AN12',NULL,NULL,NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL,NULL,NULL),
('AR1','RJ1H',NULL,NULL,NULL,NULL,NULL),
('AR7','RJ70',NULL,NULL,NULL,NULL,NULL),
('AR8','RJ85',NULL,NULL,NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,NULL,NULL,NULL,NULL),
('AT5','AT45',NULL,NULL,NULL,NULL,NULL),
('AT7','AT72',NULL,NULL,NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL,NULL,NULL),
('ATR',NULL,NULL,NULL,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_cabin_payload (iata_code,icao_code,typical_c_seats,typical_y_seats,max_capacity,cargo_volume_m3,max_payload_kg) VALUES
('AX8','RX85',NULL,NULL,NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL,NULL,NULL),
('BEH','B190',NULL,NULL,NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,NULL,NULL,NULL,NULL),
('CCX','GLEX',NULL,NULL,NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL,NULL,NULL),
('CN1','*',NULL,NULL,NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL,NULL,NULL),
('CNJ','*',NULL,NULL,NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL,NULL,NULL),
('CR1','CRJ1',NULL,NULL,NULL,NULL,NULL),
('CR2','CRJ2',NULL,NULL,NULL,NULL,NULL),
('CR7','CRJ7',NULL,NULL,NULL,NULL,NULL),
('CR9','CRJ9',NULL,NULL,NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,NULL,NULL,NULL,NULL),
('CRV',NULL,NULL,NULL,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL,NULL,NULL),
('CS3','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL,NULL,NULL),
('D10',NULL,NULL,NULL,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL,NULL,NULL),
('D20','F2TH',NULL,NULL,NULL,NULL,NULL),
('D28','D228',NULL,NULL,NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL,NULL,NULL),
('D38','D328',NULL,NULL,NULL,NULL,NULL),
('D3F','DC3',NULL,NULL,NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,NULL,NULL,NULL,NULL),
('DH2','DH8B',NULL,NULL,NULL,NULL,NULL),
('DH3','DH8C',NULL,NULL,NULL,NULL,NULL),
('DH4','DH8D',NULL,NULL,NULL,NULL,NULL),
('DH7','DHC7',NULL,NULL,NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,NULL,NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL,NULL,NULL),
('DHT','DHC6',NULL,NULL,NULL,NULL,NULL),
('E70','E170',NULL,NULL,NULL,NULL,NULL),
('E75','E170',NULL,NULL,NULL,NULL,NULL),
('E90','E190',NULL,NULL,NULL,NULL,NULL),
('E95','E190',NULL,NULL,NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL,NULL,NULL),
('EM2','E120',NULL,NULL,NULL,NULL,NULL),
('EMB','E110',NULL,NULL,NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL,NULL,NULL),
('ER4','E145',NULL,NULL,NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL,NULL,NULL),
('F21','F28',NULL,NULL,NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,NULL,NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL,NULL,NULL),
('H25','H25B',NULL,NULL,NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL,NULL,NULL),
('HS7','A748',NULL,NULL,NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL,NULL,NULL),
('I93',NULL,NULL,NULL,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,NULL,NULL,NULL,NULL),
('IL7','IL76',NULL,NULL,NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL,NULL,NULL),
('ILW','IL86',NULL,NULL,NULL,NULL,NULL),
('J31','JS31',NULL,NULL,NULL,NULL,NULL),
('J32','JS32',NULL,NULL,NULL,NULL,NULL),
('J41','JS41',NULL,NULL,NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL,NULL,NULL),
('L10',NULL,NULL,NULL,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_cabin_payload (iata_code,icao_code,typical_c_seats,typical_y_seats,max_capacity,cargo_volume_m3,max_payload_kg) VALUES
('L49',NULL,NULL,NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL,NULL,NULL),
('LOH','C130',NULL,NULL,NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL,NULL,NULL),
('LRJ','*',NULL,NULL,NULL,NULL,NULL),
('M11','MD11',NULL,NULL,NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL,NULL,NULL),
('M81','MD81',NULL,NULL,NULL,NULL,NULL),
('M82','MD82',NULL,NULL,NULL,NULL,NULL),
('M83','MD83',NULL,NULL,NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL,NULL,NULL),
('M88','MD88',NULL,NULL,NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL,NULL,NULL),
('M90','MD90',NULL,NULL,NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL,NULL,NULL),
('ND2',NULL,NULL,NULL,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL,NULL,NULL),
('PA2','*',NULL,NULL,NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL,NULL,NULL),
('PL2','PC12',NULL,NULL,NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL,NULL,NULL),
('S20','SB20',NULL,NULL,NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL,NULL,NULL),
('SF3','SF34',NULL,NULL,NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL,NULL,NULL),
('SH3','SH33',NULL,NULL,NULL,NULL,NULL),
('SH6','SH36',NULL,NULL,NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL,NULL,NULL),
('SSC',NULL,NULL,NULL,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL,NULL,NULL),
('SU9','SU95',NULL,NULL,NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL,NULL,NULL),
('T20','T204',NULL,NULL,NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL,NULL,NULL),
('TU3','T134',NULL,NULL,NULL,NULL,NULL),
('TU5','T154',NULL,NULL,NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL,NULL,NULL),
('YK2','YK42',NULL,NULL,NULL,NULL,NULL),
('YK4','YK40',NULL,NULL,NULL,NULL,NULL),
('YN2','Y12',NULL,NULL,NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL,NULL,NULL),
('YS1','YS11',NULL,NULL,NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_economic_data (iata_code,icao_code,list_price_usd,op_cost_per_hour,lease_rate_monthly,residual_value_trend) VALUES
('100','F100',NULL,NULL,NULL,NULL),
('141','B461',NULL,NULL,NULL,NULL),
('142','B462',NULL,NULL,NULL,NULL),
('143','B463',NULL,NULL,NULL,NULL),
('146',NULL,NULL,NULL,NULL,NULL),
('14F',NULL,NULL,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL,NULL),
('290','E290',NULL,NULL,NULL,NULL),
('295','E295',NULL,NULL,NULL,NULL),
('310',NULL,NULL,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL,NULL),
('318','A318',NULL,NULL,NULL,NULL),
('319','A319',NULL,NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL,NULL),
('31N','A19N',NULL,NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL,NULL),
('320','A320',NULL,NULL,NULL,NULL),
('321','A321',NULL,NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL,NULL),
('32N','A20N',NULL,NULL,NULL,NULL),
('32Q','A21N',NULL,NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL,NULL),
('330',NULL,NULL,NULL,NULL,NULL),
('332','A332',NULL,NULL,NULL,NULL),
('333','A333',NULL,NULL,NULL,NULL),
('338','A338',NULL,NULL,NULL,NULL),
('339','A339',NULL,NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL,NULL),
('340',NULL,NULL,NULL,NULL,NULL),
('342','A342',NULL,NULL,NULL,NULL),
('343','A343',NULL,NULL,NULL,NULL),
('345','A345',NULL,NULL,NULL,NULL),
('346','A346',NULL,NULL,NULL,NULL),
('350',NULL,NULL,NULL,NULL,NULL),
('351','ZZZZ',NULL,NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL,NULL),
('359','ZZZZ',NULL,NULL,NULL,NULL),
('380',NULL,NULL,NULL,NULL,NULL),
('388','A388',NULL,NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL,NULL),
('703','B703',NULL,NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL,NULL),
('717','B712',NULL,NULL,NULL,NULL),
('721','B721',NULL,NULL,NULL,NULL),
('722','B722',NULL,NULL,NULL,NULL),
('727',NULL,NULL,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL,NULL),
('732','B732',NULL,NULL,NULL,NULL),
('733','B733',NULL,NULL,NULL,NULL),
('734','B734',NULL,NULL,NULL,NULL),
('735','B735',NULL,NULL,NULL,NULL),
('736','B736',NULL,NULL,NULL,NULL),
('737',NULL,NULL,NULL,NULL,NULL),
('738','B738',NULL,NULL,NULL,NULL),
('739','B739',NULL,NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL,NULL),
('73G','B737',NULL,NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL,NULL),
('741','B741',NULL,NULL,NULL,NULL),
('742','B742',NULL,NULL,NULL,NULL),
('743','B743',NULL,NULL,NULL,NULL),
('744','B744',NULL,NULL,NULL,NULL),
('747',NULL,NULL,NULL,NULL,NULL),
('748','B748',NULL,NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL,NULL),
('752','B752',NULL,NULL,NULL,NULL),
('753','B753',NULL,NULL,NULL,NULL),
('757',NULL,NULL,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL,NULL),
('762','B762',NULL,NULL,NULL,NULL),
('763','B763',NULL,NULL,NULL,NULL),
('764','B764',NULL,NULL,NULL,NULL),
('767',NULL,NULL,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL,NULL),
('772','B77L',NULL,NULL,NULL,NULL),
('773','B773',NULL,NULL,NULL,NULL),
('777',NULL,NULL,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL,NULL),
('77L','B772',NULL,NULL,NULL,NULL),
('77W','B77W',NULL,NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL,NULL),
('787',NULL,NULL,NULL,NULL,NULL),
('788','B788',NULL,NULL,NULL,NULL),
('789','B789',NULL,NULL,NULL,NULL),
('7M7','B37M',NULL,NULL,NULL,NULL),
('7M8','B38M',NULL,NULL,NULL,NULL),
('7M9','B39M',NULL,NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL,NULL),
('AB6','A306',NULL,NULL,NULL,NULL),
('ABB','A3ST',NULL,NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL,NULL),
('ANF','AN12',NULL,NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL,NULL),
('AR1','RJ1H',NULL,NULL,NULL,NULL),
('AR7','RJ70',NULL,NULL,NULL,NULL),
('AR8','RJ85',NULL,NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,NULL,NULL,NULL),
('AT5','AT45',NULL,NULL,NULL,NULL),
('AT7','AT72',NULL,NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL,NULL),
('ATR',NULL,NULL,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_economic_data (iata_code,icao_code,list_price_usd,op_cost_per_hour,lease_rate_monthly,residual_value_trend) VALUES
('AX8','RX85',NULL,NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL,NULL),
('BEH','B190',NULL,NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,NULL,NULL,NULL),
('CCX','GLEX',NULL,NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL,NULL),
('CN1','*',NULL,NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL,NULL),
('CNJ','*',NULL,NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL,NULL),
('CR1','CRJ1',NULL,NULL,NULL,NULL),
('CR2','CRJ2',NULL,NULL,NULL,NULL),
('CR7','CRJ7',NULL,NULL,NULL,NULL),
('CR9','CRJ9',NULL,NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,NULL,NULL,NULL),
('CRV',NULL,NULL,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL,NULL),
('CS3','ZZZZ',NULL,NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL,NULL),
('D10',NULL,NULL,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL,NULL),
('D20','F2TH',NULL,NULL,NULL,NULL),
('D28','D228',NULL,NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL,NULL),
('D38','D328',NULL,NULL,NULL,NULL),
('D3F','DC3',NULL,NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,NULL,NULL,NULL),
('DH2','DH8B',NULL,NULL,NULL,NULL),
('DH3','DH8C',NULL,NULL,NULL,NULL),
('DH4','DH8D',NULL,NULL,NULL,NULL),
('DH7','DHC7',NULL,NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL,NULL),
('DHT','DHC6',NULL,NULL,NULL,NULL),
('E70','E170',NULL,NULL,NULL,NULL),
('E75','E170',NULL,NULL,NULL,NULL),
('E90','E190',NULL,NULL,NULL,NULL),
('E95','E190',NULL,NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL,NULL),
('EM2','E120',NULL,NULL,NULL,NULL),
('EMB','E110',NULL,NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL,NULL),
('ER4','E145',NULL,NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL,NULL),
('F21','F28',NULL,NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL,NULL),
('H25','H25B',NULL,NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL,NULL),
('HS7','A748',NULL,NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL,NULL),
('I93',NULL,NULL,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,NULL,NULL,NULL),
('IL7','IL76',NULL,NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL,NULL),
('ILW','IL86',NULL,NULL,NULL,NULL),
('J31','JS31',NULL,NULL,NULL,NULL),
('J32','JS32',NULL,NULL,NULL,NULL),
('J41','JS41',NULL,NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL,NULL),
('L10',NULL,NULL,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_economic_data (iata_code,icao_code,list_price_usd,op_cost_per_hour,lease_rate_monthly,residual_value_trend) VALUES
('L49',NULL,NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL,NULL),
('LOH','C130',NULL,NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL,NULL),
('LRJ','*',NULL,NULL,NULL,NULL),
('M11','MD11',NULL,NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL,NULL),
('M81','MD81',NULL,NULL,NULL,NULL),
('M82','MD82',NULL,NULL,NULL,NULL),
('M83','MD83',NULL,NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL,NULL),
('M88','MD88',NULL,NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL,NULL),
('M90','MD90',NULL,NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL,NULL),
('ND2',NULL,NULL,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL,NULL),
('PA2','*',NULL,NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL,NULL),
('PL2','PC12',NULL,NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL,NULL),
('S20','SB20',NULL,NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL,NULL),
('SF3','SF34',NULL,NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL,NULL),
('SH3','SH33',NULL,NULL,NULL,NULL),
('SH6','SH36',NULL,NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL,NULL),
('SSC',NULL,NULL,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL,NULL),
('SU9','SU95',NULL,NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL,NULL),
('T20','T204',NULL,NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL,NULL),
('TU3','T134',NULL,NULL,NULL,NULL),
('TU5','T154',NULL,NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL,NULL),
('YK2','YK42',NULL,NULL,NULL,NULL),
('YK4','YK40',NULL,NULL,NULL,NULL),
('YN2','Y12',NULL,NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL,NULL),
('YS1','YS11',NULL,NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_engine_data (iata_code,icao_code,engine_variants,engine_type,engine_count,thrust_per_engine_kn,fuel_burn_rate,saf_compatible) VALUES
('100','F100',NULL,'Turbofan',2,NULL,NULL,NULL),
('141','B461',NULL,'Turbofan',4,NULL,NULL,NULL),
('142','B462',NULL,'Turbofan',4,NULL,NULL,NULL),
('143','B463',NULL,'Turbofan',4,NULL,NULL,NULL),
('146',NULL,NULL,'Turbofan',4,NULL,NULL,NULL),
('14F',NULL,NULL,'Turbofan',4,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL,NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL,NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL,NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL,NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL,NULL,NULL,NULL),
('290','E290',NULL,'Turbofan',2,NULL,NULL,NULL),
('295','E295',NULL,'Turbofan',2,NULL,NULL,NULL),
('310',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('318','A318',NULL,'Turbofan',2,NULL,NULL,NULL),
('319','A319',NULL,'Turbofan',2,NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31N','A19N',NULL,'Turbofan',2,NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('320','A320',NULL,'Turbofan',2,NULL,NULL,NULL),
('321','A321',NULL,'Turbofan',2,NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL,NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL,NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL,NULL,NULL,NULL),
('32N','A20N',NULL,'Turbofan',2,NULL,NULL,NULL),
('32Q','A21N',NULL,'Turbofan',2,NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL,NULL,NULL,NULL),
('330',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('332','A332',NULL,'Turbofan',2,NULL,NULL,NULL),
('333','A333',NULL,'Turbofan',2,NULL,NULL,NULL),
('338','A338',NULL,'Turbofan',2,NULL,NULL,NULL),
('339','A339',NULL,'Turbofan',2,NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL,NULL,NULL,NULL),
('340',NULL,NULL,'Turbofan',4,NULL,NULL,NULL),
('342','A342',NULL,'Turbofan',4,NULL,NULL,NULL),
('343','A343',NULL,'Turbofan',4,NULL,NULL,NULL),
('345','A345',NULL,'Turbofan',4,NULL,NULL,NULL),
('346','A346',NULL,'Turbofan',4,NULL,NULL,NULL),
('350',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('351','ZZZZ',NULL,'Turbofan',2,NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('359','ZZZZ',NULL,'Turbofan',2,NULL,NULL,NULL),
('380',NULL,NULL,'Turbofan',4,NULL,NULL,NULL),
('388','A388',NULL,'Turbofan',4,NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL,NULL,NULL,NULL),
('703','B703',NULL,'Turbojet',4,NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL,NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL,NULL,NULL,NULL),
('717','B712',NULL,'Turbofan',2,NULL,NULL,NULL),
('721','B721',NULL,'Turbojet',3,NULL,NULL,NULL),
('722','B722',NULL,'Turbojet',3,NULL,NULL,NULL),
('727',NULL,NULL,'Turbojet',3,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL,NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL,NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL,NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL,NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL,NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL,NULL,NULL,NULL),
('732','B732',NULL,'Turbofan',2,NULL,NULL,NULL),
('733','B733',NULL,'Turbofan',2,NULL,NULL,NULL),
('734','B734',NULL,'Turbofan',2,NULL,NULL,NULL),
('735','B735',NULL,'Turbofan',2,NULL,NULL,NULL),
('736','B736',NULL,'Turbofan',2,NULL,NULL,NULL),
('737',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('738','B738',NULL,'Turbofan',2,NULL,NULL,NULL),
('739','B739',NULL,'Turbofan',2,NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL,NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL,NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73G','B737',NULL,'Turbofan',2,NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL,NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL,NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL,NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL,NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL,NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL,NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL,NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL,NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL,NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL,NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL,NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('741','B741',NULL,'Turbofan',4,NULL,NULL,NULL),
('742','B742',NULL,'Turbofan',4,NULL,NULL,NULL),
('743','B743',NULL,'Turbofan',4,NULL,NULL,NULL),
('744','B744',NULL,'Turbofan',4,NULL,NULL,NULL),
('747',NULL,NULL,'Turbofan',4,NULL,NULL,NULL),
('748','B748',NULL,'Turbofan',4,NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL,NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL,NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL,NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL,NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL,NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL,NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL,NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL,NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL,NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL,NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL,NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL,NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL,NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL,NULL,NULL,NULL),
('752','B752',NULL,'Turbofan',2,NULL,NULL,NULL),
('753','B753',NULL,'Turbofan',2,NULL,NULL,NULL),
('757',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL,NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL,NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL,NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL,NULL,NULL,NULL),
('762','B762',NULL,'Turbofan',2,NULL,NULL,NULL),
('763','B763',NULL,'Turbofan',2,NULL,NULL,NULL),
('764','B764',NULL,'Turbofan',2,NULL,NULL,NULL),
('767',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL,NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL,NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL,NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL,NULL,NULL,NULL),
('772','B77L',NULL,'Turbofan',2,NULL,NULL,NULL),
('773','B773',NULL,'Turbofan',2,NULL,NULL,NULL),
('777',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('77L','B772',NULL,'Turbofan',2,NULL,NULL,NULL),
('77W','B77W',NULL,'Turbofan',2,NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL,NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL,NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL,NULL,NULL,NULL),
('787',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('788','B788',NULL,'Turbofan',2,NULL,NULL,NULL),
('789','B789',NULL,'Turbofan',2,NULL,NULL,NULL),
('7M7','B37M',NULL,'Turbofan',2,NULL,NULL,NULL),
('7M8','B38M',NULL,'Turbofan',2,NULL,NULL,NULL),
('7M9','B39M',NULL,'Turbofan',2,NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL,NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL,NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL,NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL,NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL,NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL,NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL,NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL,NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL,NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL,NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL,NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,'Turbofan',2,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL,NULL,NULL,NULL),
('AB6','A306',NULL,'Turbofan',2,NULL,NULL,NULL),
('ABB','A3ST',NULL,'Turbofan',2,NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL,NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL,NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL,NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL,NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL,NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,'Turboprop',2,NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL,NULL,NULL,NULL),
('ANF','AN12',NULL,'Turboprop',4,NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL,NULL,NULL,NULL),
('AR1','RJ1H',NULL,'Turbofan',4,NULL,NULL,NULL),
('AR7','RJ70',NULL,'Turbofan',4,NULL,NULL,NULL),
('AR8','RJ85',NULL,'Turbofan',4,NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,'Turboprop',2,NULL,NULL,NULL),
('AT5','AT45',NULL,'Turboprop',2,NULL,NULL,NULL),
('AT7','AT72',NULL,'Turboprop',2,NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL,NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL,NULL,NULL,NULL),
('ATP','ATP',NULL,'Turboprop',2,NULL,NULL,NULL),
('ATR',NULL,NULL,'Turboprop',2,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL,NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL,NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_engine_data (iata_code,icao_code,engine_variants,engine_type,engine_count,thrust_per_engine_kn,fuel_burn_rate,saf_compatible) VALUES
('AX8','RX85',NULL,NULL,NULL,NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL,NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL,NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL,NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL,NULL,NULL,NULL),
('BEH','B190',NULL,'Turboprop',2,NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL,NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL,NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL,NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL,NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,'Turbofan',2,NULL,NULL,NULL),
('CCX','GLEX',NULL,'Turbofan',2,NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL,NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL,NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CN1','*',NULL,'Piston',1,NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL,NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CNJ','*',NULL,'Turbofan',2,NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CR1','CRJ1',NULL,'Turbofan',2,NULL,NULL,NULL),
('CR2','CRJ2',NULL,'Turbofan',2,NULL,NULL,NULL),
('CR7','CRJ7',NULL,'Turbofan',2,NULL,NULL,NULL),
('CR9','CRJ9',NULL,'Turbofan',2,NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL,NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,'Turbofan',2,NULL,NULL,NULL),
('CRV',NULL,NULL,'Turbojet',2,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,'Turbofan',2,NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL,NULL,NULL,NULL),
('CS3','ZZZZ',NULL,'Turbofan',2,NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL,NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL,NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL,NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL,NULL,NULL,NULL),
('D10',NULL,NULL,'Turbofan',3,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D20','F2TH',NULL,'Turbofan',2,NULL,NULL,NULL),
('D28','D228',NULL,'Turboprop',2,NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL,NULL,NULL,NULL),
('D38','D328',NULL,'Turboprop',2,NULL,NULL,NULL),
('D3F','DC3',NULL,'Piston',2,NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL,NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL,NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL,NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL,NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL,NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL,NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL,NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL,NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL,NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL,NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL,NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL,NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL,NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL,NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL,NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL,NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL,NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL,NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL,NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL,NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL,NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL,NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL,NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL,NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL,NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL,NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,'Turboprop',2,NULL,NULL,NULL),
('DH2','DH8B',NULL,'Turboprop',2,NULL,NULL,NULL),
('DH3','DH8C',NULL,'Turboprop',2,NULL,NULL,NULL),
('DH4','DH8D',NULL,'Turboprop',2,NULL,NULL,NULL),
('DH7','DHC7',NULL,'Turboprop',4,NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,'Piston',2,NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL,NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL,NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL,NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL,NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL,NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL,NULL,NULL,NULL),
('DHT','DHC6',NULL,'Turboprop',2,NULL,NULL,NULL),
('E70','E170',NULL,'Turbofan',2,NULL,NULL,NULL),
('E75','E170',NULL,'Turbofan',2,NULL,NULL,NULL),
('E90','E190',NULL,'Turbofan',2,NULL,NULL,NULL),
('E95','E190',NULL,'Turbofan',2,NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL,NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL,NULL,NULL,NULL),
('EM2','E120',NULL,'Turboprop',2,NULL,NULL,NULL),
('EMB','E110',NULL,'Turboprop',2,NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL,NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL,NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL,NULL,NULL,NULL),
('ER4','E145',NULL,'Turbofan',2,NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL,NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F21','F28',NULL,'Turbofan',2,NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F27','F27',NULL,'Turboprop',2,NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F50','F50',NULL,'Turboprop',2,NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL,NULL,NULL,NULL),
('F70','F70',NULL,'Turbofan',2,NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL,NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,'Turbofan',2,NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL,NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL,NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL,NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL,NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL,NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL,NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL,NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL,NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL,NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL,NULL,NULL,NULL),
('H25','H25B',NULL,'Turbofan',2,NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL,NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL,NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL,NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('HS7','A748',NULL,'Turboprop',2,NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL,NULL,NULL,NULL),
('I93',NULL,NULL,'Turbofan',4,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL,NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,'Turbojet',4,NULL,NULL,NULL),
('IL7','IL76',NULL,'Turbofan',4,NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL,NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL,NULL,NULL,NULL),
('ILW','IL86',NULL,'Turbofan',4,NULL,NULL,NULL),
('J31','JS31',NULL,'Turboprop',2,NULL,NULL,NULL),
('J32','JS32',NULL,'Turboprop',2,NULL,NULL,NULL),
('J41','JS41',NULL,'Turboprop',2,NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL,NULL,NULL,NULL),
('L10',NULL,NULL,'Turbofan',3,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL,NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL,NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_engine_data (iata_code,icao_code,engine_variants,engine_type,engine_count,thrust_per_engine_kn,fuel_burn_rate,saf_compatible) VALUES
('L49',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL,NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL,NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL,NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL,NULL,NULL,NULL),
('LOH','C130',NULL,'Turboprop',4,NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LRJ','*',NULL,'Turbofan',2,NULL,NULL,NULL),
('M11','MD11',NULL,'Turbofan',3,NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL,NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL,NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL,NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL,NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M81','MD81',NULL,'Turbofan',2,NULL,NULL,NULL),
('M82','MD82',NULL,'Turbofan',2,NULL,NULL,NULL),
('M83','MD83',NULL,'Turbofan',2,NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL,NULL,NULL,NULL),
('M88','MD88',NULL,'Turbofan',2,NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL,NULL,NULL,NULL),
('M90','MD90',NULL,'Turbofan',2,NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL,NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL,NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL,NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL,NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL,NULL,NULL,NULL),
('ND2',NULL,NULL,'Turboprop',2,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL,NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL,NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL,NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL,NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL,NULL,NULL,NULL),
('PA2','*',NULL,'Piston',2,NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL,NULL,NULL,NULL),
('PL2','PC12',NULL,'Turboprop',1,NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL,NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL,NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL,NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('S20','SB20',NULL,'Turboprop',2,NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL,NULL,NULL,NULL),
('S61','S61',NULL,'Turboshaft',2,NULL,NULL,NULL),
('S76','S76',NULL,'Turboshaft',2,NULL,NULL,NULL),
('SF3','SF34',NULL,'Turboprop',2,NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL,NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL,NULL,NULL,NULL),
('SH3','SH33',NULL,'Turboprop',2,NULL,NULL,NULL),
('SH6','SH36',NULL,'Turboprop',2,NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL,NULL,NULL,NULL),
('SSC',NULL,NULL,'Turbojet',4,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('SU9','SU95',NULL,'Turbofan',2,NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL,NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL,NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL,NULL,NULL,NULL),
('T20','T204',NULL,'Turbofan',2,NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL,NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL,NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL,NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('TU3','T134',NULL,'Turbojet',2,NULL,NULL,NULL),
('TU5','T154',NULL,'Turbojet',3,NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL,NULL,NULL,NULL),
('YK2','YK42',NULL,'Turbofan',3,NULL,NULL,NULL),
('YK4','YK40',NULL,'Turbojet',3,NULL,NULL,NULL),
('YN2','Y12',NULL,'Turboprop',2,NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL,NULL,NULL,NULL),
('YS1','YS11',NULL,'Turboprop',2,NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL,NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL,NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL,NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL,NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL,NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL,NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL,NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL,NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL,NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL,NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_environmental_data (iata_code,icao_code,carbon_intensity,noise_chapter,fuel_type) VALUES
('100','F100',NULL,NULL,NULL),
('141','B461',NULL,NULL,NULL),
('142','B462',NULL,NULL,NULL),
('143','B463',NULL,NULL,NULL),
('146',NULL,NULL,NULL,NULL),
('14F',NULL,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL),
('290','E290',NULL,NULL,NULL),
('295','E295',NULL,NULL,NULL),
('310',NULL,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL),
('318','A318',NULL,NULL,NULL),
('319','A319',NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL),
('31N','A19N',NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL),
('320','A320',NULL,NULL,NULL),
('321','A321',NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL),
('32N','A20N',NULL,NULL,NULL),
('32Q','A21N',NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL),
('330',NULL,NULL,NULL,NULL),
('332','A332',NULL,NULL,NULL),
('333','A333',NULL,NULL,NULL),
('338','A338',NULL,NULL,NULL),
('339','A339',NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL),
('340',NULL,NULL,NULL,NULL),
('342','A342',NULL,NULL,NULL),
('343','A343',NULL,NULL,NULL),
('345','A345',NULL,NULL,NULL),
('346','A346',NULL,NULL,NULL),
('350',NULL,NULL,NULL,NULL),
('351','ZZZZ',NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL),
('359','ZZZZ',NULL,NULL,NULL),
('380',NULL,NULL,NULL,NULL),
('388','A388',NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL),
('703','B703',NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL),
('717','B712',NULL,NULL,NULL),
('721','B721',NULL,NULL,NULL),
('722','B722',NULL,NULL,NULL),
('727',NULL,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL),
('732','B732',NULL,NULL,NULL),
('733','B733',NULL,NULL,NULL),
('734','B734',NULL,NULL,NULL),
('735','B735',NULL,NULL,NULL),
('736','B736',NULL,NULL,NULL),
('737',NULL,NULL,NULL,NULL),
('738','B738',NULL,NULL,NULL),
('739','B739',NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL),
('73G','B737',NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL),
('741','B741',NULL,NULL,NULL),
('742','B742',NULL,NULL,NULL),
('743','B743',NULL,NULL,NULL),
('744','B744',NULL,NULL,NULL),
('747',NULL,NULL,NULL,NULL),
('748','B748',NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL),
('752','B752',NULL,NULL,NULL),
('753','B753',NULL,NULL,NULL),
('757',NULL,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL),
('762','B762',NULL,NULL,NULL),
('763','B763',NULL,NULL,NULL),
('764','B764',NULL,NULL,NULL),
('767',NULL,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL),
('772','B77L',NULL,NULL,NULL),
('773','B773',NULL,NULL,NULL),
('777',NULL,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL),
('77L','B772',NULL,NULL,NULL),
('77W','B77W',NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL),
('787',NULL,NULL,NULL,NULL),
('788','B788',NULL,NULL,NULL),
('789','B789',NULL,NULL,NULL),
('7M7','B37M',NULL,NULL,NULL),
('7M8','B38M',NULL,NULL,NULL),
('7M9','B39M',NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL),
('AB6','A306',NULL,NULL,NULL),
('ABB','A3ST',NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL),
('ANF','AN12',NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL),
('AR1','RJ1H',NULL,NULL,NULL),
('AR7','RJ70',NULL,NULL,NULL),
('AR8','RJ85',NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,NULL,NULL),
('AT5','AT45',NULL,NULL,NULL),
('AT7','AT72',NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL),
('ATR',NULL,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL);
INSERT INTO aircraft_type_environmental_data (iata_code,icao_code,carbon_intensity,noise_chapter,fuel_type) VALUES
('AX8','RX85',NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL),
('BEH','B190',NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,NULL,NULL),
('CCX','GLEX',NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL),
('CN1','*',NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL),
('CNJ','*',NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL),
('CR1','CRJ1',NULL,NULL,NULL),
('CR2','CRJ2',NULL,NULL,NULL),
('CR7','CRJ7',NULL,NULL,NULL),
('CR9','CRJ9',NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,NULL,NULL),
('CRV',NULL,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL),
('CS3','ZZZZ',NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL),
('D10',NULL,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL),
('D20','F2TH',NULL,NULL,NULL),
('D28','D228',NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL),
('D38','D328',NULL,NULL,NULL),
('D3F','DC3',NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,NULL,NULL),
('DH2','DH8B',NULL,NULL,NULL),
('DH3','DH8C',NULL,NULL,NULL),
('DH4','DH8D',NULL,NULL,NULL),
('DH7','DHC7',NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL),
('DHT','DHC6',NULL,NULL,NULL),
('E70','E170',NULL,NULL,NULL),
('E75','E170',NULL,NULL,NULL),
('E90','E190',NULL,NULL,NULL),
('E95','E190',NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL),
('EM2','E120',NULL,NULL,NULL),
('EMB','E110',NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL),
('ER4','E145',NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL),
('F21','F28',NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL),
('H25','H25B',NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL),
('HS7','A748',NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL),
('I93',NULL,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,NULL,NULL),
('IL7','IL76',NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL),
('ILW','IL86',NULL,NULL,NULL),
('J31','JS31',NULL,NULL,NULL),
('J32','JS32',NULL,NULL,NULL),
('J41','JS41',NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL),
('L10',NULL,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL);
INSERT INTO aircraft_type_environmental_data (iata_code,icao_code,carbon_intensity,noise_chapter,fuel_type) VALUES
('L49',NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL),
('LOH','C130',NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL),
('LRJ','*',NULL,NULL,NULL),
('M11','MD11',NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL),
('M81','MD81',NULL,NULL,NULL),
('M82','MD82',NULL,NULL,NULL),
('M83','MD83',NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL),
('M88','MD88',NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL),
('M90','MD90',NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL),
('ND2',NULL,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL),
('PA2','*',NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL),
('PL2','PC12',NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL),
('S20','SB20',NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL),
('SF3','SF34',NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL),
('SH3','SH33',NULL,NULL,NULL),
('SH6','SH36',NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL),
('SSC',NULL,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL),
('SU9','SU95',NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL),
('T20','T204',NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL),
('TU3','T134',NULL,NULL,NULL),
('TU5','T154',NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL),
('YK2','YK42',NULL,NULL,NULL),
('YK4','YK40',NULL,NULL,NULL),
('YN2','Y12',NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL),
('YS1','YS11',NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL);
INSERT INTO aircraft_type_manufacturer_support (iata_code,icao_code,production_start,production_end,total_built,mro_availability) VALUES
('100','F100',NULL,NULL,NULL,NULL),
('141','B461',NULL,NULL,NULL,NULL),
('142','B462',NULL,NULL,NULL,NULL),
('143','B463',NULL,NULL,NULL,NULL),
('146',NULL,NULL,NULL,NULL,NULL),
('14F',NULL,NULL,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL,NULL),
('290','E290',NULL,NULL,NULL,NULL),
('295','E295',NULL,NULL,NULL,NULL),
('310',NULL,NULL,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL,NULL),
('318','A318',NULL,NULL,NULL,NULL),
('319','A319',NULL,NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL,NULL),
('31N','A19N',NULL,NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL,NULL),
('320','A320',NULL,NULL,NULL,NULL),
('321','A321',NULL,NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL,NULL),
('32N','A20N',NULL,NULL,NULL,NULL),
('32Q','A21N',NULL,NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL,NULL),
('330',NULL,NULL,NULL,NULL,NULL),
('332','A332',NULL,NULL,NULL,NULL),
('333','A333',NULL,NULL,NULL,NULL),
('338','A338',NULL,NULL,NULL,NULL),
('339','A339',NULL,NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL,NULL),
('340',NULL,NULL,NULL,NULL,NULL),
('342','A342',NULL,NULL,NULL,NULL),
('343','A343',NULL,NULL,NULL,NULL),
('345','A345',NULL,NULL,NULL,NULL),
('346','A346',NULL,NULL,NULL,NULL),
('350',NULL,NULL,NULL,NULL,NULL),
('351','ZZZZ',NULL,NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL,NULL),
('359','ZZZZ',NULL,NULL,NULL,NULL),
('380',NULL,NULL,NULL,NULL,NULL),
('388','A388',NULL,NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL,NULL),
('703','B703',NULL,NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL,NULL),
('717','B712',NULL,NULL,NULL,NULL),
('721','B721',NULL,NULL,NULL,NULL),
('722','B722',NULL,NULL,NULL,NULL),
('727',NULL,NULL,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL,NULL),
('732','B732',NULL,NULL,NULL,NULL),
('733','B733',NULL,NULL,NULL,NULL),
('734','B734',NULL,NULL,NULL,NULL),
('735','B735',NULL,NULL,NULL,NULL),
('736','B736',NULL,NULL,NULL,NULL),
('737',NULL,NULL,NULL,NULL,NULL),
('738','B738',NULL,NULL,NULL,NULL),
('739','B739',NULL,NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL,NULL),
('73G','B737',NULL,NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL,NULL),
('741','B741',NULL,NULL,NULL,NULL),
('742','B742',NULL,NULL,NULL,NULL),
('743','B743',NULL,NULL,NULL,NULL),
('744','B744',NULL,NULL,NULL,NULL),
('747',NULL,NULL,NULL,NULL,NULL),
('748','B748',NULL,NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL,NULL),
('752','B752',NULL,NULL,NULL,NULL),
('753','B753',NULL,NULL,NULL,NULL),
('757',NULL,NULL,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL,NULL),
('762','B762',NULL,NULL,NULL,NULL),
('763','B763',NULL,NULL,NULL,NULL),
('764','B764',NULL,NULL,NULL,NULL),
('767',NULL,NULL,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL,NULL),
('772','B77L',NULL,NULL,NULL,NULL),
('773','B773',NULL,NULL,NULL,NULL),
('777',NULL,NULL,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL,NULL),
('77L','B772',NULL,NULL,NULL,NULL),
('77W','B77W',NULL,NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL,NULL),
('787',NULL,NULL,NULL,NULL,NULL),
('788','B788',NULL,NULL,NULL,NULL),
('789','B789',NULL,NULL,NULL,NULL),
('7M7','B37M',NULL,NULL,NULL,NULL),
('7M8','B38M',NULL,NULL,NULL,NULL),
('7M9','B39M',NULL,NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL,NULL),
('AB6','A306',NULL,NULL,NULL,NULL),
('ABB','A3ST',NULL,NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL,NULL),
('ANF','AN12',NULL,NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL,NULL),
('AR1','RJ1H',NULL,NULL,NULL,NULL),
('AR7','RJ70',NULL,NULL,NULL,NULL),
('AR8','RJ85',NULL,NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,NULL,NULL,NULL),
('AT5','AT45',NULL,NULL,NULL,NULL),
('AT7','AT72',NULL,NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL,NULL),
('ATR',NULL,NULL,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_manufacturer_support (iata_code,icao_code,production_start,production_end,total_built,mro_availability) VALUES
('AX8','RX85',NULL,NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL,NULL),
('BEH','B190',NULL,NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,NULL,NULL,NULL),
('CCX','GLEX',NULL,NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL,NULL),
('CN1','*',NULL,NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL,NULL),
('CNJ','*',NULL,NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL,NULL),
('CR1','CRJ1',NULL,NULL,NULL,NULL),
('CR2','CRJ2',NULL,NULL,NULL,NULL),
('CR7','CRJ7',NULL,NULL,NULL,NULL),
('CR9','CRJ9',NULL,NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,NULL,NULL,NULL),
('CRV',NULL,NULL,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL,NULL),
('CS3','ZZZZ',NULL,NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL,NULL),
('D10',NULL,NULL,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL,NULL),
('D20','F2TH',NULL,NULL,NULL,NULL),
('D28','D228',NULL,NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL,NULL),
('D38','D328',NULL,NULL,NULL,NULL),
('D3F','DC3',NULL,NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,NULL,NULL,NULL),
('DH2','DH8B',NULL,NULL,NULL,NULL),
('DH3','DH8C',NULL,NULL,NULL,NULL),
('DH4','DH8D',NULL,NULL,NULL,NULL),
('DH7','DHC7',NULL,NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL,NULL),
('DHT','DHC6',NULL,NULL,NULL,NULL),
('E70','E170',NULL,NULL,NULL,NULL),
('E75','E170',NULL,NULL,NULL,NULL),
('E90','E190',NULL,NULL,NULL,NULL),
('E95','E190',NULL,NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL,NULL),
('EM2','E120',NULL,NULL,NULL,NULL),
('EMB','E110',NULL,NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL,NULL),
('ER4','E145',NULL,NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL,NULL),
('F21','F28',NULL,NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL,NULL),
('H25','H25B',NULL,NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL,NULL),
('HS7','A748',NULL,NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL,NULL),
('I93',NULL,NULL,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,NULL,NULL,NULL),
('IL7','IL76',NULL,NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL,NULL),
('ILW','IL86',NULL,NULL,NULL,NULL),
('J31','JS31',NULL,NULL,NULL,NULL),
('J32','JS32',NULL,NULL,NULL,NULL),
('J41','JS41',NULL,NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL,NULL),
('L10',NULL,NULL,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_manufacturer_support (iata_code,icao_code,production_start,production_end,total_built,mro_availability) VALUES
('L49',NULL,NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL,NULL),
('LOH','C130',NULL,NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL,NULL),
('LRJ','*',NULL,NULL,NULL,NULL),
('M11','MD11',NULL,NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL,NULL),
('M81','MD81',NULL,NULL,NULL,NULL),
('M82','MD82',NULL,NULL,NULL,NULL),
('M83','MD83',NULL,NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL,NULL),
('M88','MD88',NULL,NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL,NULL),
('M90','MD90',NULL,NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL,NULL),
('ND2',NULL,NULL,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL,NULL),
('PA2','*',NULL,NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL,NULL),
('PL2','PC12',NULL,NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL,NULL),
('S20','SB20',NULL,NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL,NULL),
('SF3','SF34',NULL,NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL,NULL),
('SH3','SH33',NULL,NULL,NULL,NULL),
('SH6','SH36',NULL,NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL,NULL),
('SSC',NULL,NULL,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL,NULL),
('SU9','SU95',NULL,NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL,NULL),
('T20','T204',NULL,NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL,NULL),
('TU3','T134',NULL,NULL,NULL,NULL),
('TU5','T154',NULL,NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL,NULL),
('YK2','YK42',NULL,NULL,NULL,NULL),
('YK4','YK40',NULL,NULL,NULL,NULL),
('YN2','Y12',NULL,NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL,NULL),
('YS1','YS11',NULL,NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_operational_performance (iata_code,icao_code,max_range_nm,service_ceiling_ft,v1,vr,v2,vref,cruise_speed_mach,max_speed,climb_rate) VALUES
('100','F100',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('141','B461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('142','B462',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('143','B463',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('146',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('14F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('290','E290',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('295','E295',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('310',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('318','A318',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('319','A319',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31N','A19N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('320','A320',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('321','A321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32N','A20N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32Q','A21N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('330',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('332','A332',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('333','A333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('338','A338',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('339','A339',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('340',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('342','A342',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('343','A343',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('345','A345',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('346','A346',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('350',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('351','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('359','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('380',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('388','A388',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('703','B703',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('717','B712',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('721','B721',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('722','B722',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('727',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('732','B732',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('733','B733',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('734','B734',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('735','B735',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('736','B736',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('737',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('738','B738',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('739','B739',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73G','B737',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('741','B741',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('742','B742',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('743','B743',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('744','B744',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('747',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('748','B748',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('752','B752',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('753','B753',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('757',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('762','B762',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('763','B763',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('764','B764',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('767',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('772','B77L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('773','B773',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('777',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('77L','B772',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('77W','B77W',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('787',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('788','B788',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('789','B789',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('7M7','B37M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('7M8','B38M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('7M9','B39M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AB6','A306',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABB','A3ST',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ANF','AN12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AR1','RJ1H',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AR7','RJ70',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AR8','RJ85',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AT5','AT45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AT7','AT72',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ATR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_operational_performance (iata_code,icao_code,max_range_nm,service_ceiling_ft,v1,vr,v2,vref,cruise_speed_mach,max_speed,climb_rate) VALUES
('AX8','RX85',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BEH','B190',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CCX','GLEX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CN1','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CNJ','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CR1','CRJ1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CR2','CRJ2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CR7','CRJ7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CR9','CRJ9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CRV',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CS3','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D20','F2TH',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D28','D228',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D38','D328',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D3F','DC3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH2','DH8B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH3','DH8C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH4','DH8D',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH7','DHC7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHT','DHC6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('E70','E170',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('E75','E170',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('E90','E190',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('E95','E190',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EM2','E120',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EMB','E110',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ER4','E145',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F21','F28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('H25','H25B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('HS7','A748',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I93',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('IL7','IL76',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ILW','IL86',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('J31','JS31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('J32','JS32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('J41','JS41',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_operational_performance (iata_code,icao_code,max_range_nm,service_ceiling_ft,v1,vr,v2,vref,cruise_speed_mach,max_speed,climb_rate) VALUES
('L49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LOH','C130',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LRJ','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M11','MD11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M81','MD81',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M82','MD82',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M83','MD83',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M88','MD88',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M90','MD90',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ND2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PA2','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PL2','PC12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('S20','SB20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SF3','SF34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SH3','SH33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SH6','SH36',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SSC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SU9','SU95',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('T20','T204',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('TU3','T134',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('TU5','T154',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('YK2','YK42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('YK4','YK40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('YN2','Y12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('YS1','YS11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_runway_requirements (iata_code,icao_code,min_takeoff_length_ft,min_landing_length_ft,surface_compatibility) VALUES
('100','F100',NULL,NULL,NULL),
('141','B461',NULL,NULL,NULL),
('142','B462',NULL,NULL,NULL),
('143','B463',NULL,NULL,NULL),
('146',NULL,NULL,NULL,NULL),
('14F',NULL,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL),
('290','E290',NULL,NULL,NULL),
('295','E295',NULL,NULL,NULL),
('310',NULL,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL),
('318','A318',NULL,NULL,NULL),
('319','A319',NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL),
('31N','A19N',NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL),
('320','A320',NULL,NULL,NULL),
('321','A321',NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL),
('32N','A20N',NULL,NULL,NULL),
('32Q','A21N',NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL),
('330',NULL,NULL,NULL,NULL),
('332','A332',NULL,NULL,NULL),
('333','A333',NULL,NULL,NULL),
('338','A338',NULL,NULL,NULL),
('339','A339',NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL),
('340',NULL,NULL,NULL,NULL),
('342','A342',NULL,NULL,NULL),
('343','A343',NULL,NULL,NULL),
('345','A345',NULL,NULL,NULL),
('346','A346',NULL,NULL,NULL),
('350',NULL,NULL,NULL,NULL),
('351','ZZZZ',NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL),
('359','ZZZZ',NULL,NULL,NULL),
('380',NULL,NULL,NULL,NULL),
('388','A388',NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL),
('703','B703',NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL),
('717','B712',NULL,NULL,NULL),
('721','B721',NULL,NULL,NULL),
('722','B722',NULL,NULL,NULL),
('727',NULL,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL),
('732','B732',NULL,NULL,NULL),
('733','B733',NULL,NULL,NULL),
('734','B734',NULL,NULL,NULL),
('735','B735',NULL,NULL,NULL),
('736','B736',NULL,NULL,NULL),
('737',NULL,NULL,NULL,NULL),
('738','B738',NULL,NULL,NULL),
('739','B739',NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL),
('73G','B737',NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL),
('741','B741',NULL,NULL,NULL),
('742','B742',NULL,NULL,NULL),
('743','B743',NULL,NULL,NULL),
('744','B744',NULL,NULL,NULL),
('747',NULL,NULL,NULL,NULL),
('748','B748',NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL),
('752','B752',NULL,NULL,NULL),
('753','B753',NULL,NULL,NULL),
('757',NULL,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL),
('762','B762',NULL,NULL,NULL),
('763','B763',NULL,NULL,NULL),
('764','B764',NULL,NULL,NULL),
('767',NULL,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL),
('772','B77L',NULL,NULL,NULL),
('773','B773',NULL,NULL,NULL),
('777',NULL,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL),
('77L','B772',NULL,NULL,NULL),
('77W','B77W',NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL),
('787',NULL,NULL,NULL,NULL),
('788','B788',NULL,NULL,NULL),
('789','B789',NULL,NULL,NULL),
('7M7','B37M',NULL,NULL,NULL),
('7M8','B38M',NULL,NULL,NULL),
('7M9','B39M',NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL),
('AB6','A306',NULL,NULL,NULL),
('ABB','A3ST',NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL),
('ANF','AN12',NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL),
('AR1','RJ1H',NULL,NULL,NULL),
('AR7','RJ70',NULL,NULL,NULL),
('AR8','RJ85',NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,NULL,NULL),
('AT5','AT45',NULL,NULL,NULL),
('AT7','AT72',NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL),
('ATR',NULL,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL);
INSERT INTO aircraft_type_runway_requirements (iata_code,icao_code,min_takeoff_length_ft,min_landing_length_ft,surface_compatibility) VALUES
('AX8','RX85',NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL),
('BEH','B190',NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,NULL,NULL),
('CCX','GLEX',NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL),
('CN1','*',NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL),
('CNJ','*',NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL),
('CR1','CRJ1',NULL,NULL,NULL),
('CR2','CRJ2',NULL,NULL,NULL),
('CR7','CRJ7',NULL,NULL,NULL),
('CR9','CRJ9',NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,NULL,NULL),
('CRV',NULL,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL),
('CS3','ZZZZ',NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL),
('D10',NULL,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL),
('D20','F2TH',NULL,NULL,NULL),
('D28','D228',NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL),
('D38','D328',NULL,NULL,NULL),
('D3F','DC3',NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,NULL,NULL),
('DH2','DH8B',NULL,NULL,NULL),
('DH3','DH8C',NULL,NULL,NULL),
('DH4','DH8D',NULL,NULL,NULL),
('DH7','DHC7',NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL),
('DHT','DHC6',NULL,NULL,NULL),
('E70','E170',NULL,NULL,NULL),
('E75','E170',NULL,NULL,NULL),
('E90','E190',NULL,NULL,NULL),
('E95','E190',NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL),
('EM2','E120',NULL,NULL,NULL),
('EMB','E110',NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL),
('ER4','E145',NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL),
('F21','F28',NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL),
('H25','H25B',NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL),
('HS7','A748',NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL),
('I93',NULL,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,NULL,NULL),
('IL7','IL76',NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL),
('ILW','IL86',NULL,NULL,NULL),
('J31','JS31',NULL,NULL,NULL),
('J32','JS32',NULL,NULL,NULL),
('J41','JS41',NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL),
('L10',NULL,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL);
INSERT INTO aircraft_type_runway_requirements (iata_code,icao_code,min_takeoff_length_ft,min_landing_length_ft,surface_compatibility) VALUES
('L49',NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL),
('LOH','C130',NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL),
('LRJ','*',NULL,NULL,NULL),
('M11','MD11',NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL),
('M81','MD81',NULL,NULL,NULL),
('M82','MD82',NULL,NULL,NULL),
('M83','MD83',NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL),
('M88','MD88',NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL),
('M90','MD90',NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL),
('ND2',NULL,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL),
('PA2','*',NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL),
('PL2','PC12',NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL),
('S20','SB20',NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL),
('SF3','SF34',NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL),
('SH3','SH33',NULL,NULL,NULL),
('SH6','SH36',NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL),
('SSC',NULL,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL),
('SU9','SU95',NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL),
('T20','T204',NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL),
('TU3','T134',NULL,NULL,NULL),
('TU5','T154',NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL),
('YK2','YK42',NULL,NULL,NULL),
('YK4','YK40',NULL,NULL,NULL),
('YN2','Y12',NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL),
('YS1','YS11',NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL);
INSERT INTO aircraft_type_technical_specs (iata_code,icao_code,mtow_kg,mzfw_kg,empty_weight_kg,wingspan_m,length_m,height_m) VALUES
('100','F100',NULL,NULL,NULL,NULL,NULL,NULL),
('141','B461',NULL,NULL,NULL,NULL,NULL,NULL),
('142','B462',NULL,NULL,NULL,NULL,NULL,NULL),
('143','B463',NULL,NULL,NULL,NULL,NULL,NULL),
('146',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('14F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('14X','B461',NULL,NULL,NULL,NULL,NULL,NULL),
('14Y','B462',NULL,NULL,NULL,NULL,NULL,NULL),
('14Z','B463',NULL,NULL,NULL,NULL,NULL,NULL),
('19D',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('221','BCS1',NULL,NULL,NULL,NULL,NULL,NULL),
('223','BCS3',NULL,NULL,NULL,NULL,NULL,NULL),
('290','E290',NULL,NULL,NULL,NULL,NULL,NULL),
('295','E295',NULL,NULL,NULL,NULL,NULL,NULL),
('310',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('312','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('313','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('318','A318',NULL,NULL,NULL,NULL,NULL,NULL),
('319','A319',NULL,NULL,NULL,NULL,NULL,NULL),
('31F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31N','A19N',NULL,NULL,NULL,NULL,NULL,NULL),
('31W',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('31X','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('31Y','A310',NULL,NULL,NULL,NULL,NULL,NULL),
('320','A320',NULL,NULL,NULL,NULL,NULL,NULL),
('321','A321',NULL,NULL,NULL,NULL,NULL,NULL),
('32A','A320',NULL,NULL,NULL,NULL,NULL,NULL),
('32B','A321',NULL,NULL,NULL,NULL,NULL,NULL),
('32C',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32D',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32F','A320',NULL,NULL,NULL,NULL,NULL,NULL),
('32N','A20N',NULL,NULL,NULL,NULL,NULL,NULL),
('32Q','A21N',NULL,NULL,NULL,NULL,NULL,NULL),
('32S',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('32X','A321',NULL,NULL,NULL,NULL,NULL,NULL),
('330',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('332','A332',NULL,NULL,NULL,NULL,NULL,NULL),
('333','A333',NULL,NULL,NULL,NULL,NULL,NULL),
('338','A338',NULL,NULL,NULL,NULL,NULL,NULL),
('339','A339',NULL,NULL,NULL,NULL,NULL,NULL),
('33F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('33X','A332',NULL,NULL,NULL,NULL,NULL,NULL),
('340',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('342','A342',NULL,NULL,NULL,NULL,NULL,NULL),
('343','A343',NULL,NULL,NULL,NULL,NULL,NULL),
('345','A345',NULL,NULL,NULL,NULL,NULL,NULL),
('346','A346',NULL,NULL,NULL,NULL,NULL,NULL),
('350',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('351','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('358','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('359','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('380',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('388','A388',NULL,NULL,NULL,NULL,NULL,NULL),
('38F','A388',NULL,NULL,NULL,NULL,NULL,NULL),
('703','B703',NULL,NULL,NULL,NULL,NULL,NULL),
('707',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('70F','B703',NULL,NULL,NULL,NULL,NULL,NULL),
('70M','B703',NULL,NULL,NULL,NULL,NULL,NULL),
('717','B712',NULL,NULL,NULL,NULL,NULL,NULL),
('721','B721',NULL,NULL,NULL,NULL,NULL,NULL),
('722','B722',NULL,NULL,NULL,NULL,NULL,NULL),
('727',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72A',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72B','B721',NULL,NULL,NULL,NULL,NULL,NULL),
('72C','B722',NULL,NULL,NULL,NULL,NULL,NULL),
('72F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72S',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('72W','B722',NULL,NULL,NULL,NULL,NULL,NULL),
('72X','B721',NULL,NULL,NULL,NULL,NULL,NULL),
('72Y','B722',NULL,NULL,NULL,NULL,NULL,NULL),
('731','B731',NULL,NULL,NULL,NULL,NULL,NULL),
('732','B732',NULL,NULL,NULL,NULL,NULL,NULL),
('733','B733',NULL,NULL,NULL,NULL,NULL,NULL),
('734','B734',NULL,NULL,NULL,NULL,NULL,NULL),
('735','B735',NULL,NULL,NULL,NULL,NULL,NULL),
('736','B736',NULL,NULL,NULL,NULL,NULL,NULL),
('737',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('738','B738',NULL,NULL,NULL,NULL,NULL,NULL),
('739','B739',NULL,NULL,NULL,NULL,NULL,NULL),
('73A',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73C','B733',NULL,NULL,NULL,NULL,NULL,NULL),
('73E','B735',NULL,NULL,NULL,NULL,NULL,NULL),
('73F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73G','B737',NULL,NULL,NULL,NULL,NULL,NULL),
('73H','B738',NULL,NULL,NULL,NULL,NULL,NULL),
('73J','B739',NULL,NULL,NULL,NULL,NULL,NULL),
('73L','B732',NULL,NULL,NULL,NULL,NULL,NULL),
('73M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('73N','B733',NULL,NULL,NULL,NULL,NULL,NULL),
('73P','B734',NULL,NULL,NULL,NULL,NULL,NULL),
('73Q','B734',NULL,NULL,NULL,NULL,NULL,NULL),
('73R','B737',NULL,NULL,NULL,NULL,NULL,NULL),
('73S','B737',NULL,NULL,NULL,NULL,NULL,NULL),
('73W','B737',NULL,NULL,NULL,NULL,NULL,NULL),
('73X','B732',NULL,NULL,NULL,NULL,NULL,NULL),
('73Y','B733',NULL,NULL,NULL,NULL,NULL,NULL),
('73Z',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('741','B741',NULL,NULL,NULL,NULL,NULL,NULL),
('742','B742',NULL,NULL,NULL,NULL,NULL,NULL),
('743','B743',NULL,NULL,NULL,NULL,NULL,NULL),
('744','B744',NULL,NULL,NULL,NULL,NULL,NULL),
('747',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('748','B748',NULL,NULL,NULL,NULL,NULL,NULL),
('74B','B744',NULL,NULL,NULL,NULL,NULL,NULL),
('74C','B742',NULL,NULL,NULL,NULL,NULL,NULL),
('74D','B743',NULL,NULL,NULL,NULL,NULL,NULL),
('74E','B744',NULL,NULL,NULL,NULL,NULL,NULL),
('74F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74H','B748',NULL,NULL,NULL,NULL,NULL,NULL),
('74J','B74D',NULL,NULL,NULL,NULL,NULL,NULL),
('74L','B74S',NULL,NULL,NULL,NULL,NULL,NULL),
('74M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('74N','B748',NULL,NULL,NULL,NULL,NULL,NULL),
('74R','B74R',NULL,NULL,NULL,NULL,NULL,NULL),
('74T','B741',NULL,NULL,NULL,NULL,NULL,NULL),
('74U','B743',NULL,NULL,NULL,NULL,NULL,NULL),
('74V','B74R',NULL,NULL,NULL,NULL,NULL,NULL),
('74X','B742',NULL,NULL,NULL,NULL,NULL,NULL),
('74Y','B744',NULL,NULL,NULL,NULL,NULL,NULL),
('752','B752',NULL,NULL,NULL,NULL,NULL,NULL),
('753','B753',NULL,NULL,NULL,NULL,NULL,NULL),
('757',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('75F','B752',NULL,NULL,NULL,NULL,NULL,NULL),
('75M','B752',NULL,NULL,NULL,NULL,NULL,NULL),
('75T','B753',NULL,NULL,NULL,NULL,NULL,NULL),
('75W','B752',NULL,NULL,NULL,NULL,NULL,NULL),
('762','B762',NULL,NULL,NULL,NULL,NULL,NULL),
('763','B763',NULL,NULL,NULL,NULL,NULL,NULL),
('764','B764',NULL,NULL,NULL,NULL,NULL,NULL),
('767',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('76V','B763',NULL,NULL,NULL,NULL,NULL,NULL),
('76W','B763',NULL,NULL,NULL,NULL,NULL,NULL),
('76X','B762',NULL,NULL,NULL,NULL,NULL,NULL),
('76Y','B763',NULL,NULL,NULL,NULL,NULL,NULL),
('772','B77L',NULL,NULL,NULL,NULL,NULL,NULL),
('773','B773',NULL,NULL,NULL,NULL,NULL,NULL),
('777',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('77F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('77L','B772',NULL,NULL,NULL,NULL,NULL,NULL),
('77W','B77W',NULL,NULL,NULL,NULL,NULL,NULL),
('77X','B772',NULL,NULL,NULL,NULL,NULL,NULL),
('781','B78X',NULL,NULL,NULL,NULL,NULL,NULL),
('783','B783',NULL,NULL,NULL,NULL,NULL,NULL),
('787',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('788','B788',NULL,NULL,NULL,NULL,NULL,NULL),
('789','B789',NULL,NULL,NULL,NULL,NULL,NULL),
('7M7','B37M',NULL,NULL,NULL,NULL,NULL,NULL),
('7M8','B38M',NULL,NULL,NULL,NULL,NULL,NULL),
('7M9','B39M',NULL,NULL,NULL,NULL,NULL,NULL),
('7MJ','B3XM',NULL,NULL,NULL,NULL,NULL,NULL),
('A22','AN22',NULL,NULL,NULL,NULL,NULL,NULL),
('A26','AN26',NULL,NULL,NULL,NULL,NULL,NULL),
('A28','AN28',NULL,NULL,NULL,NULL,NULL,NULL),
('A30','AN30',NULL,NULL,NULL,NULL,NULL,NULL),
('A32','AN32',NULL,NULL,NULL,NULL,NULL,NULL),
('A38','AN38',NULL,NULL,NULL,NULL,NULL,NULL),
('A40','A140',NULL,NULL,NULL,NULL,NULL,NULL),
('A4F','A124',NULL,NULL,NULL,NULL,NULL,NULL),
('A58','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('A5F','A225',NULL,NULL,NULL,NULL,NULL,NULL),
('A81','A148',NULL,NULL,NULL,NULL,NULL,NULL),
('AB2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AB3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AB4','A30B',NULL,NULL,NULL,NULL,NULL,NULL),
('AB6','A306',NULL,NULL,NULL,NULL,NULL,NULL),
('ABB','A3ST',NULL,NULL,NULL,NULL,NULL,NULL),
('ABF',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABM',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ABX','A30B',NULL,NULL,NULL,NULL,NULL,NULL),
('ABY','A306',NULL,NULL,NULL,NULL,NULL,NULL),
('ACD',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ACP','*',NULL,NULL,NULL,NULL,NULL,NULL),
('ACT','*',NULL,NULL,NULL,NULL,NULL,NULL),
('AGH','A109',NULL,NULL,NULL,NULL,NULL,NULL),
('ALM',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AMD',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN4','AN24',NULL,NULL,NULL,NULL,NULL,NULL),
('AN6',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AN7','AN72',NULL,NULL,NULL,NULL,NULL,NULL),
('ANF','AN12',NULL,NULL,NULL,NULL,NULL,NULL),
('APF','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('APH','*',NULL,NULL,NULL,NULL,NULL,NULL),
('AR1','RJ1H',NULL,NULL,NULL,NULL,NULL,NULL),
('AR7','RJ70',NULL,NULL,NULL,NULL,NULL,NULL),
('AR8','RJ85',NULL,NULL,NULL,NULL,NULL,NULL),
('ARJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ARX',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AT4','AT43',NULL,NULL,NULL,NULL,NULL,NULL),
('AT5','AT45',NULL,NULL,NULL,NULL,NULL,NULL),
('AT7','AT72',NULL,NULL,NULL,NULL,NULL,NULL),
('ATD','AT44',NULL,NULL,NULL,NULL,NULL,NULL),
('ATF','AT72',NULL,NULL,NULL,NULL,NULL,NULL),
('ATP','ATP',NULL,NULL,NULL,NULL,NULL,NULL),
('ATR',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('ATZ','*',NULL,NULL,NULL,NULL,NULL,NULL),
('AWH','A139',NULL,NULL,NULL,NULL,NULL,NULL),
('AX1','RX1H',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_technical_specs (iata_code,icao_code,mtow_kg,mzfw_kg,empty_weight_kg,wingspan_m,length_m,height_m) VALUES
('AX8','RX85',NULL,NULL,NULL,NULL,NULL,NULL),
('B11',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('B12','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B13','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B14','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B15','BA11',NULL,NULL,NULL,NULL,NULL,NULL),
('B72','B720',NULL,NULL,NULL,NULL,NULL,NULL),
('BE1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BE2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BE4','BE40',NULL,NULL,NULL,NULL,NULL,NULL),
('BE9','BE99',NULL,NULL,NULL,NULL,NULL,NULL),
('BEC',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('BEF','B190',NULL,NULL,NULL,NULL,NULL,NULL),
('BEH','B190',NULL,NULL,NULL,NULL,NULL,NULL),
('BEP','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BES','B190',NULL,NULL,NULL,NULL,NULL,NULL),
('BET','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BH2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('BNI','BN2P',NULL,NULL,NULL,NULL,NULL,NULL),
('BNT','TRIS',NULL,NULL,NULL,NULL,NULL,NULL),
('BTA','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('BUS','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('C27','AJ27',NULL,NULL,NULL,NULL,NULL,NULL),
('C9B',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CCJ','CL60',NULL,NULL,NULL,NULL,NULL,NULL),
('CCX','GLEX',NULL,NULL,NULL,NULL,NULL,NULL),
('CD2','NOMA',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ1','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ5','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ6','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJ8','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJL','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CJM','C510',NULL,NULL,NULL,NULL,NULL,NULL),
('CL3','CL30',NULL,NULL,NULL,NULL,NULL,NULL),
('CL4',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CN1','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CN2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CN7','C750',NULL,NULL,NULL,NULL,NULL,NULL),
('CNA',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CNC','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CNF','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CNJ','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CNT','*',NULL,NULL,NULL,NULL,NULL,NULL),
('CR1','CRJ1',NULL,NULL,NULL,NULL,NULL,NULL),
('CR2','CRJ2',NULL,NULL,NULL,NULL,NULL,NULL),
('CR7','CRJ7',NULL,NULL,NULL,NULL,NULL,NULL),
('CR9','CRJ9',NULL,NULL,NULL,NULL,NULL,NULL),
('CRA','CRJ9',NULL,NULL,NULL,NULL,NULL,NULL),
('CRF','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('CRJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CRK','CRJX',NULL,NULL,NULL,NULL,NULL,NULL),
('CRV',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CS1','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('CS2','C212',NULL,NULL,NULL,NULL,NULL,NULL),
('CS3','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('CS5','CN35',NULL,NULL,NULL,NULL,NULL,NULL),
('CV2','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CV4','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CV5','CVLT',NULL,NULL,NULL,NULL,NULL,NULL),
('CV6',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVF',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVR',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CVV','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CVX','CVLP',NULL,NULL,NULL,NULL,NULL,NULL),
('CVY','CVLT',NULL,NULL,NULL,NULL,NULL,NULL),
('CWC','C46',NULL,NULL,NULL,NULL,NULL,NULL),
('D10',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D11','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D14',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1C','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D1F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D1M','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D1X','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D1Y','DC10',NULL,NULL,NULL,NULL,NULL,NULL),
('D20','F2TH',NULL,NULL,NULL,NULL,NULL,NULL),
('D28','D228',NULL,NULL,NULL,NULL,NULL,NULL),
('D2L','F2TH',NULL,NULL,NULL,NULL,NULL,NULL),
('D38','D328',NULL,NULL,NULL,NULL,NULL,NULL),
('D3F','DC3',NULL,NULL,NULL,NULL,NULL,NULL),
('D42','DA42',NULL,NULL,NULL,NULL,NULL,NULL),
('D4X','DH8D',NULL,NULL,NULL,NULL,NULL,NULL),
('D6F','DC6',NULL,NULL,NULL,NULL,NULL,NULL),
('D85',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D86',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D87',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8A',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8B',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D8L','DC86',NULL,NULL,NULL,NULL,NULL,NULL),
('D8M','DC86',NULL,NULL,NULL,NULL,NULL,NULL),
('D8Q','DC87',NULL,NULL,NULL,NULL,NULL,NULL),
('D8T','DC85',NULL,NULL,NULL,NULL,NULL,NULL),
('D8X','DC86',NULL,NULL,NULL,NULL,NULL,NULL),
('D8Y','DC87',NULL,NULL,NULL,NULL,NULL,NULL),
('D91','DC91',NULL,NULL,NULL,NULL,NULL,NULL),
('D92','DC92',NULL,NULL,NULL,NULL,NULL,NULL),
('D93','DC93',NULL,NULL,NULL,NULL,NULL,NULL),
('D94','DC94',NULL,NULL,NULL,NULL,NULL,NULL),
('D95','DC95',NULL,NULL,NULL,NULL,NULL,NULL),
('D9C','DC93',NULL,NULL,NULL,NULL,NULL,NULL),
('D9D','DC94',NULL,NULL,NULL,NULL,NULL,NULL),
('D9F',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('D9L','F900',NULL,NULL,NULL,NULL,NULL,NULL),
('D9X','DC91',NULL,NULL,NULL,NULL,NULL,NULL),
('DC3','DC3',NULL,NULL,NULL,NULL,NULL,NULL),
('DC4','DC4',NULL,NULL,NULL,NULL,NULL,NULL),
('DC6','DC6',NULL,NULL,NULL,NULL,NULL,NULL),
('DC8',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DC9',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF1','FA10',NULL,NULL,NULL,NULL,NULL,NULL),
('DF2','FA20',NULL,NULL,NULL,NULL,NULL,NULL),
('DF3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DF5','FA50',NULL,NULL,NULL,NULL,NULL,NULL),
('DF7','FA7X',NULL,NULL,NULL,NULL,NULL,NULL),
('DF9','F900',NULL,NULL,NULL,NULL,NULL,NULL),
('DFL',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DH1','DH8A',NULL,NULL,NULL,NULL,NULL,NULL),
('DH2','DH8B',NULL,NULL,NULL,NULL,NULL,NULL),
('DH3','DH8C',NULL,NULL,NULL,NULL,NULL,NULL),
('DH4','DH8D',NULL,NULL,NULL,NULL,NULL,NULL),
('DH7','DHC7',NULL,NULL,NULL,NULL,NULL,NULL),
('DH8',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHB',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHC','DHC4',NULL,NULL,NULL,NULL,NULL,NULL),
('DHD','DOVE',NULL,NULL,NULL,NULL,NULL,NULL),
('DHF','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('DHH','HERN',NULL,NULL,NULL,NULL,NULL,NULL),
('DHL','DH3T',NULL,NULL,NULL,NULL,NULL,NULL),
('DHO',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('DHP','DHC2',NULL,NULL,NULL,NULL,NULL,NULL),
('DHR','DH2T',NULL,NULL,NULL,NULL,NULL,NULL),
('DHS','DHC3',NULL,NULL,NULL,NULL,NULL,NULL),
('DHT','DHC6',NULL,NULL,NULL,NULL,NULL,NULL),
('E70','E170',NULL,NULL,NULL,NULL,NULL,NULL),
('E75','E170',NULL,NULL,NULL,NULL,NULL,NULL),
('E90','E190',NULL,NULL,NULL,NULL,NULL,NULL),
('E95','E190',NULL,NULL,NULL,NULL,NULL,NULL),
('EA5','EA50',NULL,NULL,NULL,NULL,NULL,NULL),
('EC3','EC30',NULL,NULL,NULL,NULL,NULL,NULL),
('EM2','E120',NULL,NULL,NULL,NULL,NULL,NULL),
('EMB','E110',NULL,NULL,NULL,NULL,NULL,NULL),
('EMJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('EP1','E50P',NULL,NULL,NULL,NULL,NULL,NULL),
('EP3','E55P',NULL,NULL,NULL,NULL,NULL,NULL),
('ER3','E135',NULL,NULL,NULL,NULL,NULL,NULL),
('ER4','E145',NULL,NULL,NULL,NULL,NULL,NULL),
('ERD','E135',NULL,NULL,NULL,NULL,NULL,NULL),
('ERJ',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F21','F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F22','F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F23','F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F24','F28',NULL,NULL,NULL,NULL,NULL,NULL),
('F27','F27',NULL,NULL,NULL,NULL,NULL,NULL),
('F28',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('F50','F50',NULL,NULL,NULL,NULL,NULL,NULL),
('F5F','F50',NULL,NULL,NULL,NULL,NULL,NULL),
('F70','F70',NULL,NULL,NULL,NULL,NULL,NULL),
('FA7',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FK7','F27',NULL,NULL,NULL,NULL,NULL,NULL),
('FR3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FR4',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('FRJ','J328',NULL,NULL,NULL,NULL,NULL,NULL),
('GA8','GA8',NULL,NULL,NULL,NULL,NULL,NULL),
('GR1','G150',NULL,NULL,NULL,NULL,NULL,NULL),
('GR2','GALX',NULL,NULL,NULL,NULL,NULL,NULL),
('GR3','G250',NULL,NULL,NULL,NULL,NULL,NULL),
('GRG','G21',NULL,NULL,NULL,NULL,NULL,NULL),
('GRJ','*',NULL,NULL,NULL,NULL,NULL,NULL),
('GRM','G73T',NULL,NULL,NULL,NULL,NULL,NULL),
('GRS','G159',NULL,NULL,NULL,NULL,NULL,NULL),
('H20','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('H21','H25C',NULL,NULL,NULL,NULL,NULL,NULL),
('H24','HA4T',NULL,NULL,NULL,NULL,NULL,NULL),
('H25','H25B',NULL,NULL,NULL,NULL,NULL,NULL),
('H28','H25B',NULL,NULL,NULL,NULL,NULL,NULL),
('H29','H25B',NULL,NULL,NULL,NULL,NULL,NULL),
('HEC','COUR',NULL,NULL,NULL,NULL,NULL,NULL),
('HOV','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('HS7','A748',NULL,NULL,NULL,NULL,NULL,NULL),
('I14','I114',NULL,NULL,NULL,NULL,NULL,NULL),
('I93',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9F','IL96',NULL,NULL,NULL,NULL,NULL,NULL),
('I9M',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9X',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('I9Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('IL6','IL62',NULL,NULL,NULL,NULL,NULL,NULL),
('IL7','IL76',NULL,NULL,NULL,NULL,NULL,NULL),
('IL8','IL18',NULL,NULL,NULL,NULL,NULL,NULL),
('IL9','IL96',NULL,NULL,NULL,NULL,NULL,NULL),
('ILW','IL86',NULL,NULL,NULL,NULL,NULL,NULL),
('J31','JS31',NULL,NULL,NULL,NULL,NULL,NULL),
('J32','JS32',NULL,NULL,NULL,NULL,NULL,NULL),
('J41','JS41',NULL,NULL,NULL,NULL,NULL,NULL),
('JST',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('JU5','JU52',NULL,NULL,NULL,NULL,NULL,NULL),
('L10',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L11','L101',NULL,NULL,NULL,NULL,NULL,NULL),
('L15','L101',NULL,NULL,NULL,NULL,NULL,NULL),
('L1F','L101',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_type_technical_specs (iata_code,icao_code,mtow_kg,mzfw_kg,empty_weight_kg,wingspan_m,length_m,height_m) VALUES
('L49',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('L4F','L410',NULL,NULL,NULL,NULL,NULL,NULL),
('L4T','L410',NULL,NULL,NULL,NULL,NULL,NULL),
('LCH','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('LJA','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('LMO','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('LOE','L188',NULL,NULL,NULL,NULL,NULL,NULL),
('LOF','L188',NULL,NULL,NULL,NULL,NULL,NULL),
('LOH','C130',NULL,NULL,NULL,NULL,NULL,NULL),
('LOM',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('LRJ','*',NULL,NULL,NULL,NULL,NULL,NULL),
('M11','MD11',NULL,NULL,NULL,NULL,NULL,NULL),
('M1F','MD11',NULL,NULL,NULL,NULL,NULL,NULL),
('M1M','MD11',NULL,NULL,NULL,NULL,NULL,NULL),
('M2F','MD82',NULL,NULL,NULL,NULL,NULL,NULL),
('M3F','MD83',NULL,NULL,NULL,NULL,NULL,NULL),
('M80',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('M81','MD81',NULL,NULL,NULL,NULL,NULL,NULL),
('M82','MD82',NULL,NULL,NULL,NULL,NULL,NULL),
('M83','MD83',NULL,NULL,NULL,NULL,NULL,NULL),
('M87','MD87',NULL,NULL,NULL,NULL,NULL,NULL),
('M88','MD88',NULL,NULL,NULL,NULL,NULL,NULL),
('M8F','MD88',NULL,NULL,NULL,NULL,NULL,NULL),
('M90','MD90',NULL,NULL,NULL,NULL,NULL,NULL),
('M95',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('MA6','AN24',NULL,NULL,NULL,NULL,NULL,NULL),
('MBH','B105',NULL,NULL,NULL,NULL,NULL,NULL),
('MD9','EXPL',NULL,NULL,NULL,NULL,NULL,NULL),
('MIH','MI8',NULL,NULL,NULL,NULL,NULL,NULL),
('MU2','MU2',NULL,NULL,NULL,NULL,NULL,NULL),
('ND2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NDC','S601',NULL,NULL,NULL,NULL,NULL,NULL),
('NDE','*',NULL,NULL,NULL,NULL,NULL,NULL),
('NDH','*',NULL,NULL,NULL,NULL,NULL,NULL),
('P18','P180',NULL,NULL,NULL,NULL,NULL,NULL),
('PA1','*',NULL,NULL,NULL,NULL,NULL,NULL),
('PA2','*',NULL,NULL,NULL,NULL,NULL,NULL),
('PAG',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('PAT','*',NULL,NULL,NULL,NULL,NULL,NULL),
('PL2','PC12',NULL,NULL,NULL,NULL,NULL,NULL),
('PL6','PC6T',NULL,NULL,NULL,NULL,NULL,NULL),
('PN6','P68',NULL,NULL,NULL,NULL,NULL,NULL),
('PRI','PRM1',NULL,NULL,NULL,NULL,NULL,NULL),
('RFS','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('S20','SB20',NULL,NULL,NULL,NULL,NULL,NULL),
('S58','S58T',NULL,NULL,NULL,NULL,NULL,NULL),
('S61','S61',NULL,NULL,NULL,NULL,NULL,NULL),
('S76','S76',NULL,NULL,NULL,NULL,NULL,NULL),
('SF3','SF34',NULL,NULL,NULL,NULL,NULL,NULL),
('SFB','SF34',NULL,NULL,NULL,NULL,NULL,NULL),
('SFF','SF34',NULL,NULL,NULL,NULL,NULL,NULL),
('SH3','SH33',NULL,NULL,NULL,NULL,NULL,NULL),
('SH6','SH36',NULL,NULL,NULL,NULL,NULL,NULL),
('SHB',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SHS','SC7',NULL,NULL,NULL,NULL,NULL,NULL),
('SSC',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SU1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('SU7','ZZZZ',NULL,NULL,NULL,NULL,NULL,NULL),
('SU9','SU95',NULL,NULL,NULL,NULL,NULL,NULL),
('SWF','*',NULL,NULL,NULL,NULL,NULL,NULL),
('SWM','*',NULL,NULL,NULL,NULL,NULL,NULL),
('SY8','AN12',NULL,NULL,NULL,NULL,NULL,NULL),
('T20','T204',NULL,NULL,NULL,NULL,NULL,NULL),
('T2F','T204',NULL,NULL,NULL,NULL,NULL,NULL),
('T34','T334',NULL,NULL,NULL,NULL,NULL,NULL),
('TBM','TBM7',NULL,NULL,NULL,NULL,NULL,NULL),
('TRN','0000',NULL,NULL,NULL,NULL,NULL,NULL),
('TU3','T134',NULL,NULL,NULL,NULL,NULL,NULL),
('TU5','T154',NULL,NULL,NULL,NULL,NULL,NULL),
('VCV',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('VCX',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('WWP','WW24',NULL,NULL,NULL,NULL,NULL,NULL),
('YK2','YK42',NULL,NULL,NULL,NULL,NULL,NULL),
('YK4','YK40',NULL,NULL,NULL,NULL,NULL,NULL),
('YN2','Y12',NULL,NULL,NULL,NULL,NULL,NULL),
('YN7','AN24',NULL,NULL,NULL,NULL,NULL,NULL),
('YS1','YS11',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'A337',NULL,NULL,NULL,NULL,NULL,NULL),
('A25','A225',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'BE58',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'BE55',NULL,NULL,NULL,NULL,NULL,NULL),
('778','B778',NULL,NULL,NULL,NULL,NULL,NULL),
('779','B779',NULL,NULL,NULL,NULL,NULL,NULL),
('78J','B78X',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'CL2T',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'CL30',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'C152',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'C919',NULL,NULL,NULL,NULL,NULL,NULL),
('E7W','E75L',NULL,NULL,NULL,NULL,NULL,NULL),
('E7W','E75S',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'E545',NULL,NULL,NULL,NULL,NULL,NULL),
('GJ6','GLF6',NULL,NULL,NULL,NULL,NULL,NULL),
('GJ4','GLF4',NULL,NULL,NULL,NULL,NULL,NULL),
('GJ5','GLF5',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'P28B',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'P28A',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'PA44',NULL,NULL,NULL,NULL,NULL,NULL),
('S92','S92',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,'T144',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO aircraft_models (model_id,model_name,origin,role,iata_type_ref) VALUES
('aasijetcruzer','AASI Jetcruzer','United States of America','Business and utility transport',NULL),
('aeaexplorer','AEA Explorer','Australia','Multirole utility transport',NULL),
('aermacchif260','Aermacchi F-260','Italy','Two seat trainer and high performance light aircraft',NULL),
('aeroboeroab95115150180','Aero Boero AB-95/115/150/180','Argentina','Family of three and four seat light aircraft',NULL),
('aeronca11chief','Aeronca 11 Chief','United States of America','Two seat light aircraft',NULL),
('aeronca7champion','Aeronca 7 Champion','United States of America','Two seat light aircraft',NULL),
('aerospatialealouetteiilama','Aerospatiale Alouette II & Lama','France','Light utility helicopters',NULL),
('aerospatialealouetteiii','Aerospatiale Alouette III','France','Light utility helicopter',NULL),
('aerospatialebritishaerospaceconcorde','Aerospatiale-British Aerospace Concorde','France and United Kingdom','Medium range supersonic airliner',NULL),
('aerospatialen262fregatemohawk298','Aerospatiale N-262 Fregate & Mohawk 298','France','Short range turboprop commuter airliner',NULL),
('aerospatialesa330puma','Aerospatiale SA-330 Puma','France','Twin engine medium lift helicopter',NULL),
('aerospatialesa341342gazelle','Aerospatiale SA-341/342 Gazelle','France','Utility helicopter',NULL),
('aerospatialesa360361365cdauphin','Aerospatiale SA-360/361/365C Dauphin','France','Mid size utility helicopters',NULL),
('aerospatialesn601corvette','Aerospatiale SN-601 Corvette','France','Light corporate jet',NULL),
('agustaa109','Agusta A-109','Italy','Twin engined utility & corporate helicopter',NULL),
('agustaa119koala','Agusta A-119 Koala','Italy','Light utility helicopter',NULL),
('airtractorseries','Air Tractor series','United States of America','Series of piston & turboprop powered agricultural aircraft',NULL),
('airbusa300600','Airbus A300-600','France, Germany, Spain and UK','Medium range widebody airliner',NULL),
('airbusa300600stsupertransporter','Airbus A300-600ST Super Transporter','European consortium','Oversize cargo freighter',NULL),
('airbusa300b2b4','Airbus A300B2/B4','European consortium','Medium range widebody airliner',NULL),
('airbusa310','Airbus A310','European consortium','Medium to long range widebody airliner',NULL),
('airbusa318','Airbus A318','European consortium','100 seat regional airliner',NULL),
('airbusa319','Airbus A319','European consortium','Medium range airliner',NULL),
('airbusa319cj','Airbus A319CJ','European consortium','Long range large corporate jet',NULL),
('airbusa320','Airbus A320','European consortium','Short to medium range airliner',NULL),
('airbusa321','Airbus A321','European consortium','Short to medium range narrowbody airliner',NULL),
('airbusa330200','Airbus A330-200','European consortium','Long range widebody airliner',NULL),
('airbusa330300','Airbus A330-300','European consortium','Large capacity medium to long range airliner',NULL),
('airbusa340200300','Airbus A340-200/300','European consortium','Long range widebody airliner',NULL),
('airbusa340500600','Airbus A340-500/600','European consortium','Long range widebody airliners',NULL),
('airbusa380','Airbus A380','Europe (France, Germany, Spain, UK)','High capacity, long range, twindeck, widebody airliner',NULL),
('americanchampionbellancaseries','American Champion & Bellanca series','United States of America','Series of two seat utility and aerobatic light aircraft',NULL),
('antonovan12shaanxiy8','Antonov An-12 & Shaanxi Y-8','Ukraine and China','Mid sized turboprop freighter',NULL),
('antonovan124ruslan','Antonov An-124 Ruslan','Ukraine','Heavylift freighter',NULL),
('antonovan140','Antonov An-140','Ukraine','Turboprop regional airliner',NULL),
('antonovan22antei','Antonov An-22 Antei','Ukraine','Large capacity turboprop freighter',NULL),
('antonovan225mriya','Antonov An-225 Mriya','Ukraine','Extra-Large cargo aircraft',NULL),
('antonovan24263032xiany7','Antonov An-24/26/30/32 & Xian Y-7','Ukraine','Regional airliner and freighter',NULL),
('antonovan38','Antonov An-38','Ukraine','Regional airliner and utility transport',NULL),
('antonovan7274','Antonov An-72/74','Ukraine','STOL capable freight and utility transport',NULL),
('antonovpzlmielecan2','Antonov/PZL Mielec An-2','Ukraine and Poland','Biplane utility transport',NULL),
('antonovpzlmielecan28','Antonov/PZL Mielec An-28','Ukraine and Poland','Regional airliner and utility transports',NULL),
('atratr42','ATR ATR-42','France and Italy','42 seat turboprop regional airliner',NULL),
('atratr72','ATR ATR-72','France and Italy','70 seat turboprop regional airliner',NULL),
('austerjseries','Auster J series','United Kingdom','Two, three and four seat light aircraft',NULL),
('aviata1husky','Aviat A-1 Husky','United States of America','Two seat utility light aircraft',NULL),
('aviationtradersatl98carvair','Aviation Traders ATL-98 Carvair','United Kingdom','Freighter/utility transport',NULL),
('ayresthrushrockwellthrushcommander','Ayres Thrush & Rockwell Thrush Commander','United States of America','Agricultural aircraft',NULL),
('bac111oneeleven','BAC 111 One-Eleven','United Kingdom','Short haul airliner',NULL),
('baesystemsavrorjx85100','BAE Systems Avro RJX85/100','United Kingdom','Regional airliner',NULL),
('beagleb121pup','Beagle B-121 Pup','United Kingdom','Two, three and four place light aircraft',NULL),
('beagleb206','Beagle B-206','United Kingdom','Six/eight place cabin twin',NULL),
('beech18','Beech 18','United States of America','Light utility transport',NULL),
('beech192324musketeersierrasportsundowner','Beech 19/23/24 Musketeer/Sierra/Sport/Sundowner','United States of America','Four seat light aircraft',NULL),
('beech2000starship1','Beech 2000 Starship 1','United States of America','Advanced technology corporate transport',NULL),
('beech35bonanza','Beech 35 Bonanza','United States of America','Four & six seat high performance light aircraft',NULL),
('beech60duke','Beech 60 Duke','United States of America','Four or six place light business twin',NULL),
('beech65708088queenair','Beech 65/70/80/88 Queen Air','United States of America','Utility, light executive transport and commuter airliner',NULL),
('beech76duchess','Beech 76 Duchess','United States of America','Four place light twin',NULL),
('beech77skipper','Beech 77 Skipper','United States of America','Two seat pilot training aircraft',NULL),
('beech99airliner','Beech 99 Airliner','United States of America','Commuter airliner',NULL),
('bell204205214b','Bell 204/205/214B','United States of America','Medium Lift Utility helicopter',NULL),
('bell206jetranger','Bell 206 JetRanger','United States of America','Light utility helicopter',NULL),
('bell206llongranger','Bell 206L LongRanger','United States of America','Light utility helicopter',NULL),
('bell206lttwinrangertridairgeminist','Bell 206LT TwinRanger & Tridair Gemini ST','United States of America & Canada','Twin engine light utility helicopters',NULL),
('bell212twintwotwelve','Bell 212 Twin TwoTwelve','United States of America and Canada','Medium lift utility helicopter',NULL),
('bell214stsupertransport','Bell 214ST SuperTransport','United States of America','Medium transport helicopter',NULL),
('bell222230','Bell 222 & 230','Canada and USA','Twin engine light utility helicopters',NULL),
('bell407','Bell 407','Canada and USA','Seven place utility helicopter',NULL),
('bell412','Bell 412','United States of America and Canada','Medium lift utility helicopter',NULL),
('bell427','Bell 427','Canada, USA and South Korea','Light twin utility helicopter',NULL),
('bell430','Bell 430','Canada and USA','Twin engine intermediate size helicopter',NULL),
('bell47','Bell 47','United States of America','Two or three seat light utility helicopter',NULL),
('bellagustaba609','Bell-Agusta BA-609','United States of America','Six to nine seat corporate/utility tiltrotor',NULL),
('berievbe200','Beriev Be-200','Russia','Firefighting and multirole amphibian',NULL),
('berievbe3032','Beriev Be-30/32','Russia','Regional airliner and utility transport',NULL),
('boeing707','Boeing 707','United States of America','Medium to long range airliner and freighter',NULL),
('boeing717','Boeing 717','United States of America','Short to medium range airliner',NULL),
('boeing720','Boeing 720','United States of America','Medium range narrowbody airliner',NULL),
('boeing727100','Boeing 727-100','United States of America','Short to medium range narrowbody airliner',NULL),
('boeing727200','Boeing 727-200','United States of America','Short to medium range narrowbody airliner',NULL),
('boeing737100200','Boeing 737-100/200','United States of America','Short range narrowbody airliner',NULL),
('boeing737300','Boeing 737-300','United States of America','Short to medium range narrowbody airliner',NULL),
('boeing737400','Boeing 737-400','United States of America','Short to medium range airliner',NULL),
('boeing737500','Boeing 737-500','United States of America','Short to medium range airliner',NULL),
('boeing737600700','Boeing 737-600/700','United States of America','Short to medium range airliners',NULL),
('boeing737700800bbjbbj2','Boeing 737-700/800 BBJ/BBJ2','United States of America','Long range large capacity corporate jet',NULL),
('boeing737800900','Boeing 737-800/900','United States of America','Short to medium range airliners',NULL),
('boeing747100200','Boeing 747-100 & 200','United States of America','Long range high capacity widebody airliners',NULL),
('boeing747300','Boeing 747-300','United States of America','Long range high capacity widebody airliner',NULL),
('boeing747400','Boeing 747-400','United States of America','Long range high capacity widebody airliner',NULL),
('boeing747sp','Boeing 747SP','United States of America','Long range high capacity widebody airliner',NULL),
('boeing757200','Boeing 757-200','United States of America','Medium range narrowbody airliner',NULL),
('boeing757300','Boeing 757-300','United States of America','Medium range narrowbody airliner',NULL),
('boeing767200','Boeing 767-200','United States of America','Medium to long range widebody airliner',NULL),
('boeing767300','Boeing 767-300','United States of America','Medium to long range widebody airliner',NULL),
('boeing767400','Boeing 767-400','United States of America','Long range widebody airliner',NULL),
('boeing777200','Boeing 777-200','United States of America','Long and ultra long range widebody airliners',NULL),
('boeing777300','Boeing 777-300','United States of America','Long range high capacity widebody airliner',NULL),
('boeing7878dreamliner','Boeing 787-8 Dreamliner','United States of America','Long range widebody airliner',NULL),
('boeingb17flyingfortress','Boeing B-17 Flying Fortress','United States of America','Four-Engined Long Range Heavy Bomber',NULL),
('boeingc97stratofreighter','Boeing C-97 Stratofreighter','United States of America','Freighter',NULL),
('boeingcommercialchinook','Boeing Commercial Chinook','United States of America','Heavylift utility and airliner helicopter',NULL),
('boeingmdexplorer','Boeing MD Explorer','United States of America','Light twin helicopter',NULL),
('boeingstearman','Boeing Stearman','United States of America','Two seat sport, utility and agricultural biplane',NULL),
('boeingvertolkawasakikv107','Boeing Vertol (Kawasaki) KV 107','United States of America','Medium to heavylift utility helicopter',NULL),
('bombardierbd100challenger300','Bombardier BD-100 Challenger 300','Canada','Super mid size corporate jet',NULL),
('bombardierbd700globalexpress','Bombardier BD-700 Global Express','Canada','Ultra long range, high speed, high capacity corporate jet',NULL),
('bombardierlearjet45','Bombardier Learjet 45','United States of America','Mid size corporate jet',NULL),
('bombardierlearjet5560','Bombardier Learjet 55 & 60','United States of America','Mid size corporate jets',NULL),
('brantlyb2305','Brantly B2 & 305','United States of America','Light piston powered utility helicopters',NULL),
('bristol170freighter','Bristol 170 Freighter','United Kingdom','Short range freighter/utility transport',NULL),
('britishaerospaceatp','British Aerospace ATP','United Kingdom','Turboprop powered regional airliners',NULL),
('britishaerospaceavrorj7085100','British Aerospace Avro RJ70/85/100','United Kingdom','Regional airliner',NULL),
('britishaerospacebae146','British Aerospace BAe-146','United Kingdom','Regional jet airliner',NULL),
('britishaerospacejetstream31super31','British Aerospace Jetstream 31/Super 31','United Kingdom','19 seat regional airliner',NULL),
('britishaerospacejetstream41','British Aerospace Jetstream 41','United Kingdom','29 seat regional turboprop airliner',NULL),
('brittennormanbn2islander','Britten-Norman BN-2 Islander','United Kingdom','Commuter airliner and light utility transport',NULL),
('brittennormanbn2amk3trislander','Britten-Norman BN-2A Mk.3 Trislander','United Kingdom','Commuter airliner',NULL),
('canadaircl215415','Canadair CL-215 & 415','Canada','Firebomber and utility amphibian',NULL),
('canadaircl44yukon','Canadair CL-44 & Yukon','Canada','Medium to long range airliner and freighter',NULL),
('canadaircl600challenger600','Canadair CL-600 Challenger 600','Canada','Medium to long range widebody corporate jet',NULL),
('canadaircl600challenger601604','Canadair CL-600 Challenger 601 & 604','Canada','Long range widebody corporate jets',NULL),
('canadaircl600regionaljetcrj100200','Canadair CL-600 Regional Jet CRJ-100 & 200','Canada','Regional jet airliner',NULL),
('canadaircl600regionaljetcrj700','Canadair CL-600 Regional Jet CRJ-700','Canada','70 seat regional jet airliner',NULL),
('capaviationcap102021230231232','CAP Aviation CAP-10/20/21/230/231/232','France','Single and two seat aerobatic light aircraft',NULL),
('casac212aviocar','CASA C212 Aviocar','Spain','STOL turboprop regional airliner and utility transport',NULL),
('casaiptncn235','CASA/IPTN CN235','Spain and Indonesia','Utility transport and 45 seat regional airliner',NULL),
('cessna150152','Cessna 150 & 152','United States of America','Two seat primary and aerobatic capable trainer',NULL),
('cessna170','Cessna 170','United States of America','Four seat light aircraft',NULL),
('cessna172skyhawkearlymodels175skylark','Cessna 172 Skyhawk (early models) & 175 Skylark','United States of America','Four seat light aircraft',NULL),
('cessna172skyhawklatermodels','Cessna 172 Skyhawk (later models)','United States of America','Four seat light aircraft',NULL),
('cessna172rsskyhawk','Cessna 172R/S Skyhawk','United States of America','Four seat light aircraft',NULL),
('cessna177cardinal','Cessna 177 Cardinal','United States of America','Four seat light aircraft',NULL),
('cessna180185skywagon','Cessna 180 & 185 Skywagon','United States of America','Four to six seat utility light aircraft',NULL),
('cessna182skylane','Cessna 182 Skylane','United States of America','High performance four seat light aircraft',NULL),
('cessna188agwagonseries','Cessna 188 Agwagon series','United States of America','Agricultural aircraft',NULL),
('cessna205206207','Cessna 205, 206 & 207','United States of America','Six seat utility light aircraft',NULL),
('cessna208caravanigrandcaravancargomaster','Cessna 208 Caravan I, Grand Caravan & Cargomaster','United States of America','Single turboprop utility transport',NULL),
('cessna210centurion','Cessna 210 Centurion','United States of America','High performance four to six seat light aircraft',NULL),
('cessna310320','Cessna 310/320','United States of America','Four to six seat light piston twins',NULL),
('cessna336337skymaster','Cessna 336 & 337 Skymaster','United States of America','Six seat light piston twins',NULL),
('cessna340335','Cessna 340 & 335','United States of America','Six seat business twins',NULL),
('cessna404titan','Cessna 404 Titan','United States of America','Ten place corporate, commuter and freighter transport',NULL),
('cessna411401402','Cessna 411, 401 & 402','United States of America','Freighter, 10 seat commuter, or six to eight seat business twins',NULL),
('cessna421414','Cessna 421 & 414','United States of America','Pressurised six to eight seat cabin twins',NULL),
('cessna500501citationcitationicitationisp','Cessna 500 & 501 Citation, Citation I & Citation I/SP','United States of America','Light corporate jets',NULL),
('cessna560citationvultraultraencore','Cessna 560 Citation V, Ultra & Ultra Encore','United States of America','Small to midsize corporate jet',NULL),
('cessna560xlcitationexcel','Cessna 560XL Citation Excel','United States of America','Small to mid size corporate jet',NULL),
('cessna680citationsovereign','Cessna 680 Citation Sovereign','United States of America','Mid size corporate jet',NULL),
('cessnacitationiibravo','Cessna Citation II & Bravo','United States of America','Light corporate jets',NULL),
('cessnacitationiiivivii','Cessna Citation III, VI & VII','United States of America','Medium size corporate jets',NULL),
('cessnacitationx','Cessna Citation X','United States of America','Long range, high speed, mid size corporate jet',NULL),
('cessnacitationjetcj1cj2','Cessna CitationJet, CJ1 & CJ2','United States of America','Light corporate jets',NULL),
('cessnacorsairconquestiiicaravanii','Cessna Corsair, Conquest I & II & Caravan II','United States of America','Turboprop powered executive transports',NULL),
('cessnat303crusader','Cessna T303 Crusader','United States of America','Six seat corporate and utility transport',NULL),
('chichestermilesleopard','Chichester-Miles Leopard','United Kingdom','High performance jet powered four seat light aircraft',NULL),
('cirrussr2022','Cirrus SR-20/22','United States of America','Four seat high performance light aircraft',NULL),
('commander114b','Commander 114B','United States of America','Four seat high performance light aircraft',NULL),
('convair2403404405405806006405800','Convair 240/340/440/540/580/600/640/5800','United States of America','Short haul commercial transports',NULL),
('curtissc46commando','Curtiss C46 Commando','United States of America','Freighter',NULL),
('dassaultfalcon2000','Dassault Falcon 2000','France','Transcontinental range mid to large size corporate jet',NULL),
('dassaultfalcon50','Dassault Falcon 50','France','Long range mid size corporate jet',NULL),
('dassaultfalcon900','Dassault Falcon 900','France','Large transcontinental range corporate jet',NULL),
('dassaultmystrefalcon10100','Dassault Mystère/Falcon 10 & 100','France','Light corporate jet',NULL),
('dassaultmystrefalcon20200','Dassault Mystère/Falcon 20 & 200','France','Mid size corporate jet and multirole utility transport',NULL),
('dehavillandcanadadash7','De Havilland Canada Dash 7','Canada','STOL turboprop regional airliner',NULL),
('dehavillandcanadadhc1chipmunk','De Havilland Canada DHC-1 Chipmunk','Canada','Two seat light aircraft',NULL),
('dehavillandcanadadhc3otter','De Havilland Canada DHC-3 Otter','Canada','STOL utility transport',NULL),
('dehavillandcanadadhc4caribou','De Havilland Canada DHC-4 Caribou','Canada','STOL utility transport',NULL),
('dehavillandcanadadhc6twinotter','De Havilland Canada DHC-6 Twin Otter','Canada','STOL turboprop regional airliner and utility transport',NULL),
('dehavillandcanadadhc8100200dash8','De Havilland Canada DHC-8-100/200 Dash 8','Canada','Turboprop regional airliner',NULL),
('dehavillandcanadadhc8300dash8','De Havilland Canada DHC-8-300 Dash 8','Canada','Turboprop regional airliner',NULL),
('dehavillandcanadadhc8400dash8','De Havilland Canada DHC-8-400 Dash 8','Canada','70 seat regional turboprop airliner',NULL),
('dehavillandcanadadhc2beaver','De Havilland Canada DHC2 Beaver','Canada','STOL utility transport',NULL),
('dehavillanddh104dove','De Havilland DH.104 Dove','United Kingdom','Eight seat commuter airliner and executive transport',NULL),
('dehavillanddh114heron','De Havilland DH.114 Heron','United Kingdom','14 seat commuter airliner',NULL),
('dehavillanddh82tigermoth','De Havilland DH.82 Tiger Moth','United Kingdom','Two seat biplane light aircraft',NULL),
('diamondda40diamondstar','Diamond DA-40 Diamond Star','Austria','Four seat light aircraft',NULL),
('diamondda42twinstar','Diamond DA-42 Twin Star','Austria','Four seat light twin',NULL),
('dornier228','Dornier 228','Germany','15-19 seat regional airliner and STOL utility transport',NULL),
('dornier328','Dornier 328','Germany','30 seat regional turboprop airliner',NULL),
('dornierdo27','Dornier Do 27','Germany','Four to six seat STOL utility light aircraft',NULL),
('dornierdo28128','Dornier Do 28 & 128','Germany','STOL utility transports',NULL),
('douglasdc3','Douglas DC-3','United States of America','Short range airliner and utility transport',NULL),
('douglasdc4','Douglas DC-4','United States of America','Piston engined airliner and freighter',NULL),
('douglasdc6','Douglas DC-6','United States of America','Piston engined airliner and freighter',NULL),
('douglasdc7','Douglas DC-7','United States of America','Piston engine airliner and freighter',NULL),
('douglasdc81020304050','Douglas DC-8-10/20/30/40/50','United States of America','Medium to long range airliner and freighter',NULL),
('douglasdc86070','Douglas DC-8-60/70','United States of America','Long range medium capacity airliner and freighter',NULL),
('ehindustrieseh101','EH Industries EH 101','Italy and United Kingdom','Commuter, offshore oil rig support & utility helicopter',NULL),
('embraeremb110bandeirante','Embraer EMB-110 Bandeirante','Brazil','15-18 seat turboprop regional airliner',NULL),
('embraeremb120brasilia','Embraer EMB120 Brasilia','Brazil','30 seat turboprop regional airliner',NULL),
('embraeremb121xingu','Embraer EMB121 Xingu','Brazil','Twin turboprop corporate transport',NULL),
('embraererj135140legacy','Embraer ERJ-135/140 & Legacy','Brazil','37 and 44 seat regional jet airliner and corporate jet',NULL),
('embraererj145','Embraer ERJ-145','Brazil','50 seat regional jet airliner',NULL),
('embraererj170175190195','Embraer ERJ-170/175/190/195','Brazil','70, 78, 98 and 108 seat regional airliner',NULL),
('enstromf28280480','Enstrom F-28/280/480','United States of America','Three and five seat light helicopters',NULL),
('ercoercoupeandderivatives','Erco Ercoupe and derivatives','United States of America','Two-seat light aircraft',NULL),
('eurocopteras332superpuma','Eurocopter AS 332 Super Puma','France','Medium lift utility helicopter',NULL);
INSERT INTO aircraft_models (model_id,model_name,origin,role,iata_type_ref) VALUES
('eurocopteras350ecureuil','Eurocopter AS-350 Ecureuil','France','Light utility helicopter',NULL),
('eurocopteras355ecureuil2','Eurocopter AS-355 Ecureuil 2','France','Twin engined light utility helicopter',NULL),
('eurocopteras365ndauphin2ec155','Eurocopter AS-365N Dauphin 2 & EC-155','France','Twin engine mid sized utility helicopter',NULL),
('eurocopterbo105ecsuperfive','Eurocopter BO 105 & EC Super Five','Germany','Five place multi purpose light utility helicopter',NULL),
('eurocopterec120colibri','Eurocopter EC-120 Colibri','France, Germany, China and Singapore','Five place light utility helicopter',NULL),
('eurocopterec135635','Eurocopter EC-135/635','Germany and France','Seven place light twin turbine utility helicopter',NULL),
('eurocopterkawasakibk117','Eurocopter/Kawasaki BK 117','Germany and Japan','Twin engine utility helicopter',NULL),
('extra230300200','Extra 230, 300 & 200','Germany','Unlimited competition aerobatic aircraft',NULL),
('fairchildaerospacemetroiiiii23','Fairchild Aerospace Metro II, III & 23','United States of America','19 seat regional airliner',NULL),
('fairchilddornier328jet','Fairchild Dornier 328JET','Germany','32 seat regional jet airliner',NULL),
('fairchilddornier728','Fairchild Dornier 728','Germany','Regional jet airliner',NULL),
('fairchildswearingenmerlin','Fairchild (Swearingen) Merlin','United States of America','Turboprop corporate transport',NULL),
('ffaas202bravo','FFA AS-202 Bravo','Switzerland','Two seat basic trainer and aerobatic light aircraft',NULL),
('fokker100','Fokker 100','Netherlands','100 seat regional jet',NULL),
('fokker50','Fokker 50','Netherlands','Turboprop regional airliner',NULL),
('fokker70','Fokker 70','Netherlands','70 seat regional jetliner',NULL),
('fokkerf27fairchildf27fh227','Fokker F-27 & Fairchild F-27 & FH-227','Netherlands','Regional airliners',NULL),
('fokkerf28fellowship','Fokker F-28 Fellowship','Netherlands','Regional jet airliner',NULL),
('fujifa200aerosubaru','Fuji FA200 Aero Subaru','Japan','Four seat light aircraft',NULL),
('gafn22n24nomad','GAF N22 & N24 Nomad','Australia','STOL utility transport',NULL),
('gippslandga200fatman','Gippsland GA-200 Fatman','Australia','Two seat agricultural aircraft',NULL),
('gippslandga8airvan','Gippsland GA-8 Airvan','Australia','Eight seat utility light aircraft',NULL),
('grobg115','Grob G-115','Germany','Two seat basic and aerobatic trainer',NULL),
('grobgf200','Grob GF 200','Germany','Four seat high performance light aircraft',NULL),
('grummanamericanaa1','Grumman American AA-1','United States of America','Two seat light aircraft',NULL),
('grummanamericanaa5','Grumman American AA-5','United States of America','Four seat light aircraft',NULL),
('grummang1159gulfstreamiiiii','Grumman G-1159 Gulfstream II/III','United States of America','Long range large corporate jet',NULL),
('grummang159gulfstreami','Grumman G-159 Gulfstream I','United States of America','Corporate transport and regional airliner',NULL),
('grummang164agcat','Grumman G-164 Ag-Cat','United States of America','Biplane agricultural aircraft',NULL),
('grummang21goose','Grumman G-21 Goose','United States of America','Eight seat utility amphibian',NULL),
('grummang44widgeon','Grumman G-44 Widgeon','United States of America','Light utility amphibian',NULL),
('grummang64111albatross','Grumman G-64/111 Albatross','United States of America','Amphibious airliner and light utility transport',NULL),
('grummang73mallard','Grumman G-73 Mallard','United States of America','Ten seat utility amphibious transport',NULL),
('gulfstreamaerospacegivgulfstreamiv','Gulfstream Aerospace G-IV Gulfstream IV','United States of America','Long range large corporate transport',NULL),
('gulfstreamaerospacegvgulfstreamv','Gulfstream Aerospace G-V Gulfstream V','United States of America','Ultra long range large corporate transport',NULL),
('gulfstreamaerospacejetpropturbocommander','Gulfstream Aerospace Jetprop & Turbo Commander','United States of America','Twin turboprop utility and corporate transports',NULL),
('handleypageherald','Handley Page Herald','United Kingdom','Turboprop airliner and freighter',NULL),
('harbiny1112','Harbin Y-11/12','China','Commuter airliners and utility transports',NULL),
('hawkersiddeleyhs125123400600','Hawker Siddeley HS-125-1/2/3/400/600','United Kingdom','Mid size corporate jet',NULL),
('hawkersiddeleyhs748','Hawker Siddeley HS-748','United Kingdom','Regional airliner',NULL),
('heliocourier','Helio Courier','United States of America','Four/six place STOL utility light aircraft',NULL),
('hilleruh12','Hiller UH12','United States of America','Light utility helicopter',NULL),
('hindustanadvancedlighthelicopter','Hindustan Advanced Light Helicopter','India','Medium utility helicopter',NULL),
('hondaha420hondajet','Honda HA-420 HondaJet','Japan and United States of America','Light corporate jet',NULL),
('iaiarava','IAI Arava','Israel','STOL utility transport',NULL),
('iaiwestwind','IAI Westwind','Israel','Small to mid size corporate jet',NULL),
('ilyushinil103','Ilyushin Il-103','Russia','Two and five seat light aircraft',NULL),
('ilyushinil114','Ilyushin Il-114','Russia','Turboprop regional airliner',NULL),
('ilyushinil14','Ilyushin Il-14','Russia','Short range airliner and utility transport',NULL),
('ilyushinil18','Ilyushin Il-18','Russia','Medium range turboprop airliner',NULL),
('ilyushinil62','Ilyushin Il-62','Russia','Medium to long range medium capacity airliner',NULL),
('ilyushinil76','Ilyushin Il-76','Russia','Medium to long range freighter',NULL),
('ilyushinil86','Ilyushin Il-86','Russia','Medium range widebody airliner',NULL),
('ilyushinil96300','Ilyushin Il-96-300','Russia','Long range widebody airliner',NULL),
('ilyushinil96mil96t','Ilyushin Il-96M & Il-96T','Russia','Long range widebody airliner and freighter',NULL),
('iptnn250','IPTN N-250','Indonesia','64/68 seat turboprop regional airliner',NULL),
('israeliai1125astragulfstreamg100','Israel IAI-1125 Astra/Gulfstream G100','Israel','Small to mid size corporate jet',NULL),
('israeliai1126galaxygulfstreamg200','Israel IAI-1126 Galaxy/Gulfstream G200','Israel','Super mid size corporate transport',NULL),
('kamank1200kmax','Kaman K-1200 K-Max','United States of America','Aerial crane and utility helicopter',NULL),
('kamovka26ka226','Kamov Ka26 & Ka-226','Russia','Light twin engine utility and training helicopter',NULL),
('kamovka32','Kamov Ka32','Russia','Medium size utility helicopter',NULL),
('kestrelk250','Kestrel K250','United States of America','Four to six place light aircraft',NULL),
('lakela4buccaneerrenegade','Lake LA4, Buccaneer & Renegade','United States of America','Four/six place amphibious light aircraft',NULL),
('lancairlc40columbia300350400','Lancair LC-40 Columbia 300/350/400','United States of America','High performance four seat light aircraft',NULL),
('learjet2324252829','Lear Jet 23/24/25/28/29','United States of America','Light corporate jets',NULL),
('learjet313536','Learjet 31/35/36','United States of America','Light corporate jets',NULL),
('letl200morava','Let L-200 Morava','Czech Republic','Four/five seat light twin',NULL),
('letl40metasokol','Let L-40 MetaSokol','Czech Republic','Three/four seat light aircraft',NULL),
('letl410l420','Let L-410 & L-420','Czech Republic','19 seat turboprop regional airliners',NULL),
('letl610','Let L-610','Czech Republic','40 seat regional airliner',NULL),
('lockheedjetstar','Lockheed JetStar','United States of America','Large size corporate jet',NULL),
('lockheedl100hercules','Lockheed L-100 Hercules','United States of America','Medium range freighter',NULL),
('lockheedl1011tristar150100150200250','Lockheed L-1011 TriStar 1/50/100/150/200/250','United States of America','Medium to long range widebody airliner',NULL),
('lockheedl1011tristar500','Lockheed L-1011 TriStar 500','United States of America','Long range widebody airliner',NULL),
('lockheedl188electra','Lockheed L-188 Electra','United States of America','Turboprop airliner and freighter',NULL),
('luscombemodel8silvaire','Luscombe Model 8 Silvaire','United States of America','Two seat light aircraft',NULL),
('luscombespartan','Luscombe Spartan','United States of America','Four seat light aircraft',NULL),
('maulem4tom7','Maule M-4 to M-7','United States of America','4-5 seat STOL capable light aircraft',NULL),
('mcdonnelldouglasdc10boeingmd10','McDonnell Douglas DC-10 & Boeing MD-10','United States of America','Medium to long range widebody airliner',NULL),
('mcdonnelldouglasdc9102030','McDonnell Douglas DC-9-10/20/30','United States of America','Short range airliners',NULL),
('mcdonnelldouglasdc94050','McDonnell Douglas DC-9-40/50','United States of America','Short to medium range airliners',NULL),
('mcdonnelldouglasmd11','McDonnell Douglas MD-11','United States of America','Long range widebody airliner',NULL),
('mcdonnelldouglasmd81828388','McDonnell Douglas MD-81/82/83/88','United States of America','Short to medium range airliner',NULL),
('mcdonnelldouglasmd87','McDonnell Douglas MD-87','United States of America','Short to medium range airliner',NULL),
('mcdonnelldouglasmd90','McDonnell Douglas MD-90','United States of America','Short to medium range airliner',NULL),
('mdhelicoptersmd500530','MD Helicopters MD-500/530','United States of America','Light utility helicopters',NULL),
('mdhelicoptersmd520n','MD Helicopters MD-520N','United States of America','Light utility helicopter',NULL),
('mdhelicoptersmd600n','MD Helicopters MD-600N','United States of America','Eight place light utility helicopter',NULL),
('milmi26','Mil Mi-26','Russia','Ultra heavy lift utility helicopter',NULL),
('milmi34','Mil Mi-34','Russia','Two/four place light helicopter',NULL),
('milmi817','Mil Mi-8/17','Russia','Medium lift utility helicopters',NULL),
('millicerm10airtourer','Millicer M10 AirTourer','Australia','Two seat aerobatic capable light aircraft',NULL),
('mitsubishimu2','Mitsubishi MU-2','Japan','Twin turboprop utility transport',NULL),
('mooneym20tom20g','Mooney M-20 to M-20G','United States of America','Four seat high performance light aircraft',NULL),
('mooneym20jtom20s','Mooney M-20J to M-20S','United States of America','High performance four seat light aircraft',NULL),
('namcys11','NAMC YS-11','Japan','Twin turboprop regional airliner',NULL),
('noorduynnorseman','Noorduyn Norseman','Canada','10 place utility transport',NULL),
('northamericanrockwell100darterlarkcommander','North American Rockwell 100 Darter/Lark Commander','United States of America','Four seat light aircraft',NULL),
('northamericanryannavion','North American/Ryan Navion','United States of America','High performance four/five seat light aircraft',NULL),
('pacificaerospacect4airtrainer','Pacific Aerospace CT-4 Airtrainer','New Zealand','Two/three seat basic trainer',NULL),
('pacificaerospacefletcherfu24cresco','Pacific Aerospace Fletcher FU-24 & Cresco','New Zealand','Agricultural aircraft',NULL),
('partenaviap68','Partenavia P-68','Italy','Six/seven place light twin',NULL),
('piaggiop166','Piaggio P-166','Italy','Commuter airliner and utility transport',NULL),
('piaggiop180avanti','Piaggio P.180 Avanti','Italy','Twin turboprop executive transport',NULL),
('pilatuspc12','Pilatus PC12','Switzerland','Utility, regional airliner and corporate turboprop',NULL),
('pilatuspc6porterturboporter','Pilatus PC6 Porter & Turbo Porter','Switzerland','STOL utility transport',NULL),
('pipercub','Piper Cub','United States of America','Two seat light aircraft',NULL),
('piperpa18supercub','Piper PA-18 Super Cub','United States of America','Two seat utility light aircraft',NULL),
('piperpa2022pacertripacercaribbeancolt','Piper PA-20/22 Pacer/Tri-Pacer/Caribbean/Colt','United States of America','Two and four seat light aircraft',NULL),
('piperpa23apacheaztec','Piper PA-23 Apache/Aztec','United States of America','Four seat light twins',NULL),
('piperpa24comanche','Piper PA-24 Comanche','United States of America','Four seat high performance light aircraft',NULL),
('piperpa25pawnee','Piper PA-25 Pawnee','United States of America','Agricultural aircraft',NULL),
('piperpa28cherokeeseries','Piper PA-28 Cherokee Series','United States of America','Two and four seat light aircraft',NULL),
('piperpa28rcherokeearrow','Piper PA-28R Cherokee Arrow','United States of America','Four seat light aircraft',NULL),
('piperpa3039twincomanche','Piper PA-30/39 Twin Comanche','United States of America','Six seat light twin',NULL),
('piperpa31chieftainmojavet1020t1040','Piper PA-31 Chieftain/Mojave/T-1020/T-1040','United States of America','Eight/ten seat corporate transport and commuter airliner',NULL),
('piperpa31navajopressurizednavajo','Piper PA-31 Navajo/Pressurized Navajo','United States of America','Six/eight seat corporate transport and commuter airliner',NULL),
('piperpa31tcheyenne','Piper PA-31T Cheyenne','United States of America','Twin turboprop corporate transports',NULL),
('piperpa32cherokeesixlancesaratoga','Piper PA-32 Cherokee Six, Lance & Saratoga','United States of America','Six seat high performance light aircraft',NULL),
('piperpa34seneca','Piper PA-34 Seneca','United States of America','Six place light twin',NULL),
('piperpa36pawneebrave','Piper PA-36 Pawnee Brave','United States of America','Agricultural aircraft',NULL),
('piperpa38tomahawk','Piper PA-38 Tomahawk','United States of America','Two seat light aircraft and basic trainer',NULL),
('piperpa42cheyenneiii400','Piper PA-42 Cheyenne III/400','United States of America','Twin turboprop corporate transport',NULL),
('piperpa44seminole','Piper PA-44 Seminole','United States of America','Four seat light twin',NULL),
('piperpa46malibumeridian','Piper PA-46 Malibu Meridian','United States of America','Six seat corporate turboprop',NULL),
('piperpa46malibumalibumirage','Piper PA-46 Malibu/Malibu Mirage','United States of America','Six seat high performance light aircraft',NULL),
('piperpa60aerostar','Piper PA-60 Aerostar','United States of America','Six seat high performance light twin',NULL),
('pittss12special','Pitts S-1/2 Special','United States of America','Single and two seat competition aerobatic biplanes',NULL),
('pzlmielecm18dromader','PZL-Mielec M-18 Dromader','Poland','Ag spraying and firefighter aircraft',NULL),
('pzlokeciepzl110111koliber','PZL-Okecie PZL-110/111 Koliber','Poland','Four seat light aircraft',NULL),
('pzlswidnikmilmi2kania','PZL Swidnik (Mil) Mi2 & Kania','Poland & Russia','Light twin turboshaft utility helicopter',NULL),
('pzlswidniksw4','PZL Swidnik SW4','Poland','Light utility helicopter',NULL),
('pzlswidnikw3sokol','PZL Swidnik W3 Sokol','Poland','Mid size twin engine utility helicopter',NULL),
('pzlwarszawaokeciepzl104wilga','PZL WarszawaOkecie PZL104 Wilga','Poland','Four seat light utility aircraft',NULL),
('raytheon390premieri','Raytheon 390 Premier I','United States of America','Light corporate jet',NULL),
('raytheon90100kingair','Raytheon 90/100 King Air','United States of America','Twin turboprop corporate and utility transport',NULL),
('raytheonbeechcraft1900','Raytheon Beechcraft 1900','United States of America','Regional airliner and corporate transport',NULL),
('raytheonbeechcraftbaron','Raytheon Beechcraft Baron','United States of America','Four or six place business, utility & advanced pilot training twin',NULL),
('raytheonbeechcraftbonanza','Raytheon Beechcraft Bonanza','United States of America','Four to six seat high performance light aircraft',NULL),
('raytheonbeechcraftkingair200','Raytheon Beechcraft King Air 200','United States of America','Twin turboprop corporate, passenger & utility transport',NULL),
('raytheonbeechcraftkingair300350','Raytheon Beechcraft King Air 300 & 350','United States of America','Turboprop powered corporate and utility aircraft',NULL),
('raytheonbeechjet400','Raytheon Beechjet 400','United States of America','Light corporate jet',NULL),
('raytheonhawker1000','Raytheon Hawker 1000','United Kingdom and USA','Mid size corporate jet',NULL),
('raytheonhawker800britishaerospacehs125700','Raytheon Hawker 800 & British Aerospace HS-125-700','United Kingdom and USA','Mid size corporate jet',NULL),
('raytheonhawkerhorizon','Raytheon Hawker Horizon','United States of America','Super mid size corporate jet',NULL),
('republicrc3seabee','Republic RC3 Seabee','United States of America','Four seat amphibious light aircraft',NULL),
('robindr400500','Robin DR-400/500','France','Four/five seat light aircraft',NULL),
('robinhr200r2000alpha','Robin HR 200 & R 2000 Alpha','France','Two seat aerobatic light aircraft',NULL),
('robinr3000','Robin R 3000','France','Two/four seat light aircraft',NULL),
('robinsonr44','Robinson R-44','United States of America','Four place piston engined light helicopter',NULL),
('robinsonr22','Robinson R22','United States of America','Two seat piston engined light helicopter',NULL),
('rockwell500520560680685720commander','Rockwell 500/520/560/680/685/720 Commander','United States of America','Utility and corporate transports',NULL),
('rockwellcommander112114','Rockwell Commander 112 & 114','United States of America','Four seat high performance light aircraft',NULL),
('rockwellsabreliner','Rockwell Sabreliner','United States of America','Mid size corporate jet',NULL),
('ruschmeyerr90','Ruschmeyer R 90','Germany','Four seat high performance light aircraft',NULL),
('saab2000','Saab 2000','Sweden','50 seat twin turboprop regional airliner',NULL),
('saab340','Saab 340','Sweden','Twin turboprop regional airliner',NULL),
('schweizer269300','Schweizer 269/300','United States of America','Light utility helicopter',NULL),
('schweizer330','Schweizer 330','United States of America','Light turbine powered utility helicopter',NULL),
('scottishaviationtwinpioneer','Scottish Aviation Twin Pioneer','United Kingdom','Utility transport',NULL),
('short330','Short 330','United Kingdom','Regional airliner and utility freighter',NULL),
('short360','Short 360','United Kingdom','36 seat regional airliner',NULL),
('shortbelfast','Short Belfast','United Kingdom','Heavy lift turboprop freighter',NULL),
('shortskyvanskyliner','Short Skyvan & Skyliner','United Kingdom','STOL utility transport and regional airliner',NULL),
('siaimarchettis205208','SIAI-Marchetti S-205/208','Italy','Four seat light aircraft',NULL),
('sikorskys55westlandwhirlwind','Sikorsky S-55 & Westland Whirlwind','United States of America','Mid size utility helicopter',NULL),
('sikorskys76','Sikorsky S-76','United States of America','Mid size utility helicopter',NULL),
('sikorskys92helibus','Sikorsky S-92 Helibus','United States of America','Medium to heavy lift airliner and utility helicopter',NULL),
('sikorskys58','Sikorsky S58','United States of America','Mid size utility helicopter',NULL),
('sikorskys61ls61n','Sikorsky S61L & S61N','United States of America','Medium lift utility helicopter',NULL),
('sikorskys62','Sikorsky S62','United States of America','Mid size utility helicopter',NULL),
('sinoswearingensj302','Sino Swearingen SJ-30-2','United States of America','Light corporate jet',NULL),
('slingsbyt67firefly','Slingsby T-67 Firefly','United Kingdom','Two seat basic trainer',NULL),
('socatagy80horizonst10diplomate','Socata GY-80 Horizon & ST-10 Diplomate','France','Four seat light aircraft',NULL),
('socatams180ms250morane','Socata MS 180 & MS 250 Morane','France','Four/five seat light aircraft',NULL),
('socatarallye','Socata Rallye','France','Series of two/four seat light aircraft',NULL),
('socatatangaragulfstreamga7','Socata Tangara & Gulfstream GA7','United States of America and France','Four place light twin',NULL),
('socatatb9102021200tampicotobagotrinidad','Socata TB-9/10/20/21/200 Tampico/Tobago/Trinidad','France','Four/five seat light aircraft',NULL),
('socatatbm700','Socata TBM-700','France','Single engine corporate turboprop',NULL),
('sudse210caravelle','Sud SE-210 Caravelle','France','Short range airliner',NULL),
('sukhoisu26su29su31','Sukhoi Su26, Su29 & Su31','Russia','Single and two seat aerobatic light aircraft',NULL),
('sukhoisuperjet100','Sukhoi Superjet 100','Russia','Regional jet airliner',NULL),
('taylorcraftseries','Taylorcraft series','United States of America','Two seat light aircraft',NULL),
('technoaviasm92finist','Technoavia SM92 Finist','Russia','STOL utility transport',NULL),
('transaviaairtrukskyfarmer','Transavia Airtruk & Skyfarmer','Australia','Agricultural aircraft',NULL),
('tupolevtu134','Tupolev Tu-134','Russia','Short range airliner',NULL),
('tupolevtu154','Tupolev Tu-154','Russia','Medium range airliner',NULL),
('tupolevtu204tu214','Tupolev Tu-204 & Tu-214','Russia','Medium range airliner',NULL),
('tupolevtu334','Tupolev Tu-334','Russia','Short to medium range airliner',NULL),
('vickersvc10','Vickers VC10','United Kingdom','Medium to long range airliner',NULL),
('vickersviscount','Vickers Viscount','United Kingdom','Turboprop airliner and freighter',NULL),
('victaaircruiser','Victa Aircruiser','Australia','Four seat light aircraft',NULL),
('victaairtourer','Victa Airtourer','Australia','Two seat light aircraft',NULL),
('visionairevantage','VisionAire Vantage','United States of America','Entry level single engine corporate jet',NULL),
('weatherly201620','Weatherly 201/620','United States of America','Agricultural aircraft',NULL),
('yakovlevyak18t','Yakovlev Yak-18T','Russia','Four seat light aircraft',NULL),
('yakovlevyak40','Yakovlev Yak-40','Russia','Regional jet airliner',NULL),
('yakovlevyak42','Yakovlev Yak-42','Russia','Short range airliner',NULL),
('zlintrenerakrobat','Zlin Trener & Akrobat','Czech Republic','One and two seat aerobatic and training light aircraft',NULL),
('zlinz42z43z142z242z143','Zlin Z 42, Z 43, Z 142, Z 242 & Z 143','Czech Republic','Two/four seat light aircraft',NULL);
INSERT INTO aircraft_model_history (model_id,development_story,milestones,status) VALUES
('aasijetcruzer','The innovative Jetcruzer 500 is designed to be a high speed low cost single engine corporate turboprop and is the product of California based Advanced Aerodynamics and Structures Inc (AASI).

The Jetcruzer 500 is based on the smaller, unpressurised Jetcruzer 450. Early design work for what would become the Jetcruzer 450 began in 1983. Construction of an Allison 250-C20S powered prototype began in 1988. It flew for the first time on January 11 1989.

The preproduction prototype first flew April 1991, and the first production standard Jetcruzer 450 on September 13 1992. When FAA Part 23 certification was granted on June 14 1994 the Jetcruzer became the first aircraft in the world to be certificated as spin resistant.

AASI elected not to place the 450 into production and instead focused its efforts on the pressurised 500. Initial work was on the 500P, which featured a modest 25cm (10in) fuselage stretch, but AASI instead decided to enlarge the design further. The definitive Jetcruzer features a 1.83m (6ft) fuselage stretch over the 450 (increasing cabin length by 90cm (3ft), plus a significantly more powerful PT6A66 turboprop driving a five (rather than three) blade prop, pressurisation to 30,000ft, an airstair entry door on the right hand side and additional cabin windows.

First flight of the prototype 500 (the modified preproduction prototype 450) was in August 22 1997, followed by the second prototype (the modified production 450) on November 7 1997. 

Other notable Jetcruzer 500 design features include its canard configuration (which allows the main wing to be positioned further aft than normal, so the wing spars do not intrude into the cabin), lack of flaps (reducing pilot work load and manufacturing costs and saving weight), and optional EFIS avionics. Like the 450 the 500 will be certificated as spin resistant. The fuselage is made from composites while the wing and canard are aluminium.

On February 8 2002, AASI announced that it was taking over the Mooney assets, and that the name Mooney would be used for the combined companies. Headquarters, development, and marketing would remain at AASI''s facility at Long Beach in California, but production of the Jetcruzer would be at Mooney''s Kerrville, Texas plant. 

The company is also working on the Stratocruzer 1250, a 13 place twin WilliamsRolls FJ-44 powered light corporate jet development.',NULL,'Operational'),
('aeaexplorer','The AEA Explorer 350R is a nine-place Australian utility aircraft developed by Aeronautical Engineers Australia Research Pty Ltd (AEA). It is designed to fill a market gap between the Cessna 206 Stationair and the much larger Cessna 208 Caravan utility singles. 

AEA''s managing director Graham Swannell first began looking at a new utility aircraft in the late 1980s, and initially considered developing a stretched and more powerful Cessna 206 conversion which would have been covered by a supplemental type certificate. But by 1993 Swannell had started design work on an all new aircraft, a 10 seater powered by an eight cylinder 300kW (400hp) Textron Lycoming IO-720. This design then evolved to become the Explorer 350R, a nine-seater powered by a Teledyne Continental TSIO-550 flat-six. 

The 350R flew for the first time on January 23 1998. Apart from its TSIO-550 engine driving a three blade prop, design features include a metal frame fuselage with a carbonfibre shell, conventional all metal wings and tail surfaces and retractable undercarriage. The main undercarriage retraction system is uncommon - the legs, which are made from fibreglass, extend further downwards before crossing each other below the fuselage with the wheels coming to rest in pods on the opposite side of the fuselage - thus not intruding into the main cabin. 

The aircraft''s basic configuration is optimised for its intended utility roles, with a high mounted, braced wing, rectangular and constant section, flat floor cabin, and large cabin windows. 

The Explorer 350R will not be built in series, but is the proof-of-concept (POC) prototype for a family of utility aircraft. The 350R prototype was  converted to the 500T prototype, powered by a 600shp Pratt & Whitney PT6A-135B turboprop, and the first flight as such was made on June 9 2000. The 500T has seating for eleven (including the pilot) in a passenger configuration, and will be the entry level aircraft for the Explorer. A second production version will be the 500R, a 600hp Orenda OE-600A piston engine powered version of the 500T. A 2.21m (7ft 3in) stretched version is planned, the Explorer 750T, which will seat 17 (including the pilot), and will be powered by a 750shp Pratt & Whitney PT6A-60A turboprop.

On May 20 1999 the 350R left Australia for a promotional tour of the USA, and will now be further developed and taken into production in the United States by Explorer Aircraft Inc, located in Jasper, Texas.',NULL,'Operational'),
('aermacchif260','The nimble SIAI-Marchetti SF-260 has sold in modest numbers to civil operators worldwide but is one of the most successful postwar two seat piston military trainers. 

The SF-260 was designed by famed Italian aircraft designer Stelio Frati (who was responsible for a number of renowned light aircraft designs) in the early 1960s. It was originally flown in 185kW (250hp) Lycoming O-540 powered form by the Aviamilano company as the F-250. However until its takeover by Aermacchi in 1997 SIAI-Marchetti undertook all production (initially under licence, before later assuming full responsibility for the program) of the aircraft as the 195kW (260hp) O-540 powered SF-260. The second aircraft to fly was the first built by SIAI-Marchetti and the first powered by the more powerful version of the O-540. This second prototype first flew in 1966. 

The initial civil production models were the SF-260 and SF-260A, and a number were sold in the USA as the Waco Meteor. In 1974 production switched to the SF-260B with improvements first developed for the military SF-260M, including a stronger undercarriage, a redesigned wing leading edge and a taller fin. The B was soon followed by the further improved SF-260C, with increased span wing. 

While the SF-260 has been further developed into E and F forms these have been sold to military operators only. The 260kW (350shp) Allison (now Rolls-Royce) 250-B17D turboprop powered SF-260TP meanwhile has been built since the early 1980s, but it too has been sold only to military customers. Nevertheless Italian civil certification was awarded in October 1993, opening the door for possible civil sales. 

In civil use the SF-260 is now regarded as something of a classic thoroughbred. Its clean aerodynamic lines, retractable undercarriage and relatively powerful engine guarantee spirited performance. 

In 1997 Aermacchi took over SIAI-Marchetti and continues to market the aircraft as the F-260, with low rate production continuing against military orders.',NULL,'Operational'),
('aeroboeroab95115150180','Development from the basic AB-95 (which first flew in 1959) has spawned one of the largest families of GA types yet developed in South America. 

Versions of the AB-95 include the AB-95 Standard, the AB-95 De Lujo with a 75kW (100hp) Continental O-200A engine, the AB-95A Fumigador ag aircraft with the O-200A engine and fitted for crop dusting or spraying, the AB-115BS air ambulance fitted with a stretcher, the more powerful AB-95B, and the AB-95-115 with a more streamlined engine cowling housing a 85kW (115hp) O-235 engine, and main wheel fairings. 

From the AB-95-115 Aero Boero developed the AB-115BS with increased wing span, greater fin sweepback and longer range, and the AB-115 Trainer. Brazil ordered 450 Trainers in the late 1980s for its aero clubs. 

The AB-180 first flew in the late 1960s and was offered in three and four seat versions with differing wingspans and a more powerful powerplant than those featured on the earlier AB-95 and AB-115. Developments included the AB-180RV with greater range, reprofiled fuselage and sweptback fin; the glider tug AB-180RVR; the high altitude AB-180 Condor with optional engine turbocharger; AB-180AG agricultural aircraft and the two seat AB-180PSA preselection aircraft for student pilot flight grading. An experimental biplane AB-180SP was also developed. The AB-150RV and AB-150AG have less powerful powerplants than corresponding AB-180 models.',NULL,'Operational'),
('aeronca11chief','The Aeronca 11 Chief, designed by Ray Hermes, was developed at the same time as the tandem seat Model 7 Champion, but it featured a wider cabin for side by side seating. The first flight was made in 1945, but the type was only shown publicly for the first time at the National Air Show in Cleveland in November 1946. 

The Chief has a welded steel tube fuselage with fabric covering. A door on each side gives entry to the side by side cabin, and a baggage compartment is located behind the seats. Streamlined wheelpants were available as an option. Except for the fuselage, 80% of the parts are interchangeable with the Model 7 Champion. 

The first version of the Chief was the 11AC, powered by a 48kW (65hp) Continental A-65-8F engine, and the Type Certificate was issued September 28 1945. A floatplane version on Edo Floats was certificated on July 22 1947 as the S11AC. The Chief was available in a "Standard" version, or as a fully-equipped "Deluxe" version. In 1947 a "Scout" version was added, which was a bare pilot trainer.

The 11BC had a more powerful 63kW (85hp) Continental C-85-8F engine and a large dorsal fin, and was also available as the float-equipped S11BC. These models were certificated respectively in August 1947 and September 1948.

The third version was the 11CC Super Chief with the same Continental C-85 engine, but with a little more room, improved styling, luxury equipment now included as standard, and some other improvements. The 11CC was certificated in May 1948, and its float-equipped equivalent, the S11CC, in October 1948.

In 1951 Aeronca stopped production of light aircraft, as the market for light aircraft was not profitable anymore and as they had large orders for Korean War equipment to fulfill.

E.J.Trytek acquired the rights for the Model 11, but did not build the Chief themselves. The 11CC was however licence-built in India as the Hindustan HUL-26 Pushpak with a 67kW (90hp) Continental C-90 engine. The first flight was made on September 28 1958, and the type was produced until 1968. A total of 154 were received by Indian flying clubs. 

Eventually, Bellanca bought the Model 11 type certificate, and they used the model for developing a new trainer. They rebuilt a standard 11AC to the new model, but after a lengthy test period did not proceed further with the design.',NULL,'Operational'),
('aeronca7champion','The Aeronca Champion was a highly popular light aircraft in the USA in the intermediate postwar period, with over 10,000 built. 

The Champion was based on the prewar Model K Scout, with which it shares an overall similar configuration, but with tandem instead of side by side seating and a reduced span but increased chord flapless wing. 

The first production version of the Champion was the 7AC, with succeeding versions similar except for the powerplant fitted. These versions were the 7BC with a 63kW (85hp) Continental C85-12 or O-190-1 (and built in large numbers for the US Army as the L-16 liaison platform); the 7CC with a Continental C-90-12F; and the 7DC with a Continental C85. 

Aeronca sold the production rights of the Champion to the Champion Aircraft Corporation in 1951. Champion Aircraft dropped production of its namesake that year and instead developed the 7EC Traveler with a 67kW (90hp) Continental C90 (which first flew in 1955), 7FC tricycle undercarriage Tri-Traveler and the 110kW (150hp) Lycoming O-320 powered Model 7GCB Challenger, with increased span wing with flaps. The Challenger formed the basis for the Citabria and subsequent Decathlon and Scout, which are described separately under American Champion. 

In September 1970 Bellanca acquired the assets of the Champion Aircraft Company and elected to return the Champion to production as the 7ACA Champ. Based on the 7AC, changes included a 45kW (60hp) Franklin 2A-120-B engine in place of the by then out of production Continental, cantilever spring steel main landing gear and modernised interior. Small numbers were built in the early 1970s.',NULL,'Operational'),
('aerospatialealouetteiilama','Among the first turbine powered helicopters in the world, the Alouette II and Lama remain in service in fairly large numbers worldwide. 

For a time the most successful western European helicopter in terms of numbers built, the Alouette II was based on the original Sud-Est SE-3120 Alouette which first flew on March 12 1955. Two prototypes were built and these were powered by Salmson 9 piston engines. Production deliveries of the turbine powered SE-3130 (around 1967 redesignated SE-313B) Alouette II occurred from 1957, the first machines bound for the French military. Civil certification was awarded on January 14 1958, although most Alouette II production was for military customers. 

During production, Sud-Est became part of Sud in March 1957, and Sud was incorporated into Aerospatiale in January 1970. The Alouette II was soon followed by a more powerful Turboméca Astazou powered development. This aircraft was the SA-3180 (around 1967 renamed SA-318C) Alouette II Astazou, and flew for the first time on January 31 1961. Power was supplied by a 395kW (530shp) Astazou IIA derated to 270kW (360shp), which increased the type''s maximum speed and max takeoff weight, but otherwise the Alouette II and Alouette II Astazou were similar. 

The SA-315B Lama was initially developed for the Indian Army as a utility helicopter with improved hot and high performance. Called Cheetah in Indian service, the Lama mated the Alouette''s airframe with the larger Alouette III''s dynamic components including Artouste IIIB engine. The Lama''s first flight was on March 17 1969. Aerospatiale built 407 through to 1989, while Hindustan (HAL) in India continues limited licence production as the SA-315B Cheetah, and seven were produced in Brazil as the Helibras HB-315B Gaviao.',NULL,'Operational'),
('aerospatialealouetteiii','The Alouette III is an enlarged development of the Alouette II series, and was Aerospatiale''s most successful helicopter in terms of numbers built until the mid 1980s when surpassed by the Ecureuil. 

Like the Alouette II, the Alouette III traces its development back to the Sud-Est SE-3120 Alouette piston powered prototypes, the first of which flew for the first time on July 31 1951. The largest member of the Alouette series, the III flew as the SE-3160 on February 28 1959. Compared with the Alouette II, the Alouette III is larger and seats seven, but in its initial form was also powered by the Turboméca Artouste turboshaft. 

This initial SE-3160 Alouette III remained in production for almost a decade until 1969, when it was replaced by the improved SA-316B with strengthened transmission and a greater max takeoff weight, but the same Artouste III turboshaft. 

Further development led to the SA-319 Alouette III Astazou, which as its name suggests is powered by a 450kW (600shp) Turboméca Astazou XIV turboshaft. The more powerful Astazou engine conferred better hot and high performance and improved fuel economy. The SA-319 entered production in 1968 as the SA-319B. 

The SA-319B and SA-316B remained in production side by side through the 1970s and into the early 1980s. Hindustan (HAL) of India continues to licence build Alouette IIIs as the Chetak (first as SE-3160, later as SA-316B), mainly for that country''s military, but also for government and civil customers. ICA of Brasov in Romania licence built SA-316Bs as IAR-316Bs, and 60 SE-3160 were built in Switzerland by F+W Emmen. Other SE-3160 were assembled by Fokker and Lichtwerk in the Netherlands. 

Like the Alouette II, the III has been used in a wide range of utility roles, and many armed military variants have been built.',NULL,'Operational'),
('aerospatialebritishaerospaceconcorde','The Concorde first flew over 25 years ago, and yet it remains the pinnacle of civil aviation development for one reason - speed. The Concorde is the only aircraft in the world operating scheduled passenger flights at supersonic speed. 

An engineering masterpiece, the Concorde was the result of a collaborative venture between the aviation industries of Britain and France. It dates back to design work for a supersonic airliner carried out by Sud Aviation and Bristol, their respective Super Caravelle and Bristol 233 designs being remarkably similar in configuration to each other. The forecast high costs of any SST program and the similarities in the designs led to a 1962 government agreement between France and Britain which resulted in the British Aircraft Corporation (into which Bristol had been merged) and SudAviation (which became a part of Aerospatiale in 1970) joining to design and develop such an aircraft. 

Talks with airlines in the 1960s resulted in a relatively long range aircraft design capable of flying trans Atlantic sectors (although for a time Sud offered a short haul version). Design of the airframe was refined to feature a highly complex delta wing featuring cambering and ogival leading edges with pairs of engines mounted in pods under the wing undersurface. The slender fuselage features a high fineness ratio to keep supersonic drag to a minimum, while the fuel system was designed to trim the aircraft longitudinally by transferring fuel between tanks to combat the change in the centre of pressure as the aircraft accelerates. Another feature is the variable geometry nose which is lowered while taxying, on takeoff and landing to improve the flightcrew''s visibility. 

A lengthy development program following the Concorde''s first flight on March 2 1969 meant that it did not enter into airline service until January 1976.

On May 30 2003 the last commercial Air France flight landed back at Paris Charles de Gaulle from New York. The very last flight for Air France was made on June 27 2003 when F-BVFC flew from Paris to its place of construction in Toulouse for preservation.

British Airways hoped to operate Concorde services well into the first decade of the new century, but will now terminate its supersonic services in October 2003.',NULL,'Operational'),
('aerospatialen262fregatemohawk298','The original design of the N-262 dates back to the Max Holste Super Broussard project, which as the MH-260 flew for the first time on July 29 1960. 

This event had been preceded by the first flight of the oneoff Pratt & Whitney Wasp piston radial powered but otherwise similar MH-250 prototype on May 20 1959. Nord built just 10 MH-260s (flown by Air Inter and Norway''s Wideröe) before beginning a significant redesign of the type in 1961, with the major changes being a redesigned fuselage with a circular cross section, pressurisation and more powerful powerplants. This resulted in the Nord N-262, which first flew on December 24 1962. 

Production of the N-262 consisted of four major variants, the initial production N-262A with Turboméca Bastan VIC engines; N-262B, of which only four were specially converted on request of Air Inter, also with Bastan VI engines; the N-262C Fregate with more powerful Bastan VIIC engines and greater wing span; and the N-262D Fregate, the French Air Force equivalent of the N-262C. 

The merger of Nord and Sud during the N-262''s production life resulted in it becoming a product of Aerospatiale from 1970. 

In the late 1970s US commuter airline Allegheny Airlines - through its subsidiary Mohawk Air Services - extensively upgraded its fleet of N-262s, subcontracting the conversions to Frakes Aviation, resulting in the Mohawk 298 (the designation being derived from the FAA FAR Part 298 airworthiness regulation). The retrofit involved reengining the 262s with more powerful Pratt & Whitney Canada PT6A-45 turboprops with five blade props, new avionics and a new APU. 

The first Mohawk 298 flew on January 7 1975, while the last of nine converted was completed in 1978. 

Production of the N-262 ended in 1976.',NULL,'Operational'),
('aerospatialesa330puma','The Aerospatiale (originally Sud) Puma is perhaps the most successful European built medium lift helicopter, and while most Pumas have been sold to military customers (largely for use as troop transports), a significant number are in commercial use. 

The Puma was first designed to meet a French army requirement for a medium lift helicopter capable of operating in all weather conditions. The first of two Sud SA-330 prototypes flew for the first time on April 15 1965, with the first production aircraft flying in September 1968. In January 1970 Sud was merged into Aerospatiale. A 1967 decision by Britain''s Royal Air Force to order the Puma as its new tactical helicopter transport resulted in substantial Westland participation in the helicopter''s design and construction. 

Early versions of the Puma were for military customers, including the SA-330B, C, E and H. The initial civil models were the Turmo IIIC powered SA-330F passenger and SA-330G freight versions, which became the first helicopters certificated for single pilot IFR operations in A and B conditions. 

The SA-330J is the definitive civil Puma, and compared to the earlier F and G has composite main rotors and an increased maximum takeoff weight. The weather radar equipped J also became the first helicopter certificated for all weather operations including flight in icing conditions, awarded in April 1978. 

IPTN of Indonesia assembled a small number of SA-330s before switching to the Super Puma. After Aerospatiale ceased production in 1987, the sole production source for the Puma became IAR (originally ICA) of Romania. 

The AS-332 Super Puma is a stretched development, and is described separately under Eurocopter.',NULL,'Operational'),
('aerospatialesa341342gazelle','The Gazelle will be long remembered for being the first helicopter to introduce Aerospatiale''s (and now Eurocopter''s) trademark Fenestron shrouded tail rotor system. 

While civil Gazelle use is not common, many are in service as personal or corporate transports. The Gazelle however is in widespread military service throughout the world, and a large number of military variants have been developed. 

The Gazelle was designed by Sud as a replacement for the popular Alouette II series. Design features included the Alouette II Astazou''s powerplant and transmission system and enclosing the tail rotor within the tail for safety on the ground. 

First flight of the original Sud SA-340 Gazelle prototype occurred on April 7 1967. This aircraft was powered by the Astazou III, which became the standard powerplant on the subsequent SA-341 production model, which flew for the first time on August 16 1971, when Sud had been merged into Aerospatiale. 

Like the larger Puma the Gazelle was the subject of a 1967 agreement that has seen it jointly built by Westland in the UK and Aerospatiale in France. 

Civil production Gazelles were designated SA-341G and powered by the Astazou IIIA. The SA-341G was the first helicopter to be certificated to be flown by one pilot under Cat I weather conditions, achieving this in January 1975. This was since upgraded to Cat II operations. Gazelles with their rear fuselage modified to allow an extra 20cm of rear legroom were known as Stretched Gazelles 

Further development led to the SA-342 with the more powerful Astazou XIV and refined Fenestron design, giving the civil SA-342J a 100kg (220lb) increase in payload. The SA-342 became available from 1977.

Apart from Westland, the Gazelle was also produced by Soko (SA-341H and SA-342L Partizan) in the former Yugoslavia, and 30 SA-342L were assembled by ABHCo in Egypt.',NULL,'Operational'),
('aerospatialesa360361365cdauphin','The single engine SA-360 Dauphin and twin engine SA-365C Dauphin 2 were developed as replacements for the Alouette III. 

The prototype SA-360 first flew on June 2 1972 and was powered by a 730kW (980shp) Turboméca Astazou XVI turboshaft. After 180 development flights a more powerful 785kW (1050shp) Astazou XVIIIA was substituted, and weights were fitted to the rotor tips to reduce vibration and to eliminate ground resonance. The first prototype flew in this new configuration on May 4 1973, following a second prototype built to the new standard which had flown for the first time that January. The first production aircraft, designated the SA-360C, flew in April 1975. 

The SA-361 is a more powerful variant with improved hot and high performance and a greater payload capability. Although prototypes were built, the SA-361 was not taken into production. A military variant of the SA-361, the SA-361H, was offered fitted with up to eight HOT anti tank missiles, but was also not ordered into production. 

The twin engine SA-365C Dauphin 2 meanwhile was announced in early 1973. First flight was on January 24 1975. It features twin Arriel turboshafts and a new engine fairing, a Starflex main rotor hub and a higher max takeoff weight. Production deliveries began in December 1978. 

SA-360 and SA-365C production ceased in 1981 in preference for the much improved SA-365N (later AS-365N), described under Eurocopter.',NULL,'Operational'),
('aerospatialesn601corvette','Although primarily a small corporate transport, Aerospatiale designed the Corvette to fulfil a variety or roles, including commuter airliner, aerial photography, airline pilot training, air ambulance, air taxi, express freight and navigation aid calibration work. 

The Corvette was a commercial failure, and was Aerospatiale''s only venture into the executive jet market. The first prototype SN-600 first flew on July 16 1970, but only completed 270 hours of test and development flying before it crashed on March 23 the following year. This aircraft was powered by 9.8kN (2200lb) JT15D-1s. 

The subsequent production version, the SN-601, had more powerful JT15D-4 turbofans and a stretched fuselage compared to the prototype. The first SN-601, or Corvette 100, made its maiden flight on December 20 1972. The second SN-601 Corvette (the first to full production standard) flew on March 7 1973, and a third on January 12 1974. 

French civil certification for the Corvette was granted on May 28 1974. Customer deliveries, delayed by strikes at engine manufacturer Pratt & Whitney Canada (then UACL) began the following September. 

Production of the Corvette continued until 1977. The initial production schedule called for 20 aircraft to be delivered in 1974 and production of six a month for 1975 and thereafter. However this proved an overly optimistic assessment of potential sales and only 40 were built (including development aircraft). Plans for a 2.08m (6ft 7in) stretched 18 seat Corvette 200 were also dropped. 

Many early Corvette customers were French regional airlines (such as Air Alpes and Air Alsace), with others sold to corporate operators in Europe. Outside Europe however the type generated little sales interest in the face of very strong competition. Many of the Corvettes built remain in service today.',NULL,'Operational'),
('agustaa109','The A-109 is a high performance twin helicopter, one of the most successful in its class during the course of its 25 year history. 

The first of four A-109 prototypes flew on August 4 1971. VFR certification was awarded on June 1 1975 although series production had already begun in 1974. First production deliveries took place in late 1976. The helicopter was originally named Hirundo, but this name was later dropped. Single pilot IFR certification was granted in January 1977. 

The base A-109A was superseded by the upgraded A-109A Mk.II from September 1981. Improvements incorporated in the Mk.II included a greater transmission rating, redesigned tailboom and a new tail rotor driveshaft, improved rotor blade life and modern avionics. The Mk.II is also available in widebody configuration with increased internal volume courtesy of bulged fuselage side panels and reshaped fuel tanks under the cabin floor. The Mk.II Plus has the more powerful 250-C20R1 engines, as does the A-109C. The 109C also has composite rotor blades. 

The A-109K first flew in April 1983 and is powered by two 470kW (640shp) max continuous operation rated Turboméca Arriel 1K1 turboshafts. The latest A-109 model is the PW-206C powered (477kW/640shp takeoff rated) A-109E Power, which first flew on February 8 1995 and was certificated in August 1996. Based on the A-109K-2 it also features a strengthened landing gear and improved main rotor. The engines feature FADEC. 

The A-109 has been developed into a number of mission specific configurations. Aside from executive transport it is used widely in medevac, police and patrol roles worldwide. Previously medevac configured A-109As were based on the standard airframe, but modifications engineered by the US firm Custom Aircraft Completions resulted in the A-109 Max, with transverse stretcher stowage and bulged side door transparencies.',NULL,'Operational'),
('agustaa119koala','Agusta''s newest helicopter, the widebody A-119 Koala is a relatively large single turbine powered helicopter designed for a range of utility transport missions where it makes economic sense to operate a single when the redundancy of a twin is not required. 

Agusta began development work on the Koala in 1994, leading to the first prototype''s maiden flight in early 1995. A second prototype flew later in that same year. Agusta originally aimed to gain certification for the A-119 in late 1996 but this was delayed until late 1998. One cause for the delay has been strong sales demand for the A-109E Power, another to enhance the A-119''s performance in response to customer feedback. Production deliveries are planned for 1999. 

The Koala''s big selling feature is its large ''widebody'' fuselage. Agusta says the cabin is 30% larger than the cabins of any other current production single engine helicopter. A measure of the cabin size is that it can accommodate two stretcher patients in an EMS role, along with two medical attendants. Most other single engine helicopters typically are only equipped for a single stretcher because of a lack of space (Agusta sees medical retrieval operators as prime potential Koala customers). 

Access to the main cabin is via two large sliding doors, one either side of the fuselage. A baggage compartment in the rear of the fuselage is also accessible in flight. 

The first prototype Koala was powered by a Turboméca Arriel 1 turboshaft but it was subsequently reengined with a 747kW (1002shp) takeoff rated Pratt & Whitney Canada PT6B-37, which powered the second prototype and will feature in production aircraft. Another design feature is the Koala''s composite four blade main rotor which features a titanium fully articulated maintenance free hub with elastomeric bearings and composite grips.',NULL,'Operational'),
('airtractorseries','The Air Tractor was designed by company founder Leyland Snow who earlier designed the Snow S-2 (built by Rockwell and Ayres). 

The initial Air Tractor model was the Pratt & Whitney R-1340 radial powered AT-301 which established the Air Tractor series'' basic configuration. First flight was in 1973, and 600 were built. The PT6 turbine powered AT-302 introduced in 1977 was replaced by the AT-402. The R-1340 powered AT-401 introduced a greater span wing and increased chemical hopper capacity and first flew in 1986. The AT-402 is similar other than its 505kW (680shp) PT6A turboprop engine, the AT-402B has increased span wings. 

The AT-502A (first flight Feb 1992) is based in the 402B but has a far more powerful 820kW (1100shp) PT6A-45R turbine driving a slow turning five blade prop. Its excess power reserves allow high speed or high altitude operations. The AT-502B has Hoerner wingtips and optional equipment including GPS. 

The 5.4 tonne MTOW PT6 powered AT-602 first flew on December 1 1995 and became available for delivery in the second half of 1996. 

The larger and heavier two seat AT-802 and single seat AT-802A are the largest purpose designed single engine ag aircraft in production. First flight was in October 1990. The AT-802F is a dedicated firefighting version.',NULL,'Operational'),
('airbusa300600','The A300-600 development of the earlier A300B4 incorporated a number of significant improvements and refinements, foremost being a two crew flightdeck and increased range. 

Apart from the two crew EFIS cockpit, with digital avionics based on that developed for the A310, changes included the A310''s tail empennage which increased freight and passenger payloads, small winglets (an option from 1989, standard from 1991), simplified systems, greater use of composites, Fowler flaps and increased camber on the wings, new brakes and APU, and improved payload/range through an extensive drag reducing airframe clean up and new engines. First flight for the A300-600 was on July 8 1983, the first airline delivery was in March 1984. 

The A300-600 was further developed into the longer range A300-600R, its extended range courtesy of a fuel trim tank in the tailplane and higher maximum takeoff weights. First flight was on December 9 1987, first delivery was April 20 1988 (to American Airlines). 

Convertible freight/passenger versions of all variants of the A300 have been offered, as has the all freight A300F4-600. The first new build pure freighter A300, one of 36 ordered for Federal Express, flew in December 1993. UPS is another major A300-600F customer, following its September 1998 order for 30. Airbus also offers conversion packages of existing passenger A300s into freighters with a left side forward freight door and strengthened floor.',NULL,'Operational'),
('airbusa300600stsupertransporter','The A300-600ST Super Transporter was designed to replace Airbus Industrie''s Super Guppy transports, used by the consortium to ferry oversize components such as wings and fuselage sections between Airbus'' partners'' plants throughout western Europe. 

Development of the A300-600ST, nicknamed Beluga and also Super Flipper, began in August 1991. The A300-600ST''s tight development program - for what in many ways is effectively a new aircraft - saw the transport rolled out in June 1994, with first flight on September 13 that year. The A300-600ST then entered a 400 hour flight test program which culminated in mid 1995, with certification awarded that September and with delivery and entry into service with Airbus in January 1996. All of the first four on order had been delivered by mid 1998 (allowing the Super Guppy''s retirement in October 1997). The fifth Super Transporter is scheduled to be delivered in 2001. 

The A300-600ST is based on the A300-600 airliner, with which it shares the wing, lower fuselage, main undercarriage and cockpit. The main differences are obvious - a bulged main deck, new forward lower fuselage, new enlarged tail with winglets and an upwards hinging main cargo door. A design study of a similarly configured A340, the A340ST Mega Transporter, to carry A3XX components is underway. 

Program management of the A300-600ST is the responsibility of the Special Aircraft Transport Company, or SATIC, an economic interest grouping formed on a 50/50 basis by Aerospatiale and DASA operating on behalf of Airbus Industrie. While much of the work on the aircraft is performed by the Airbus partners, other European companies are also involved in the program.',NULL,'Operational'),
('airbusa300b2b4','The Airbus A300 is significant not only for being a commercial success in its own right, but for being the first design of Europe''s most successful postwar airliner manufacturer. 

Aerospatiale of France, CASA of Spain and the forerunners of Germany''s DaimlerChrysler Aerospace and British Aerospace formed the Airbus Industrie consortium in the late 1960s specifically to develop a twin engined 300 seat widebody `air bus'' to fill an identified market gap. 

The original 300 seat airliner design matured into a smaller 250 seater, the A300 designation gaining a `B'' suffix to denote the change. Two prototype A300B1s were built, the first of these flying from Toulouse, France on October 28 1972, the second on February 5 the next year. The General Electric CF6 was the powerplant choice for initial A300s. Following the prototype A300B1s was the 2.65m (8ft 8in) longer A300B2, the first production version which first flew in April 1974. The B2 entered service with Air France on May 23 1974. 

Subsequent versions included the B2-200 with Krueger leading edge flaps and different wheels and brakes; the B2-300 with increased weights for greater payload and multi stop capability; the B4-100 a longer range version of the B2 with Krueger flaps; and the increased max takeoff weight B4-200 which featured reinforced wings and fuselage, improved landing gear and optional rear cargo bay fuel tank. A small number of A300C convertibles were also built, these featured a main deck freight door behind the wing on the left hand side. Late in the A300B4''s production life an optional two crew flightdeck was offered as the A300-200FF (customers were Garuda, Tunis Air and VASP). 

Production of the A300B4 ceased in May 1984, with manufacture switching to the improved A300-600. 

Older A300s are now finding a useful niche as freighters, with a number of companies, in particular DaimlerChrysler Aerospace Airbus, offering conversion programs.',NULL,'Operational'),
('airbusa310','The A310 first began life as the A300B10, one of a number of projected developments and derivatives of Airbus'' original A300B airliner. 

While based on the larger A300, the A310 introduced a number of major changes. The fuselage was shortened by 13 frames compared to the A300B, reducing seating to around 200 to 230 passengers and a new higher aspect ratio wing of smaller span and area was developed. New and smaller horizontal tail surfaces, fly-by-wire outboard spoilers and a two crew EFIS flightdeck were incorporated, while the engine pylons were common to suit both engine options. 

The first flight of the A310 occurred on April 3 1982, after the program was launched in July 1978. Service entry was with Lufthansa in April 1983. Early production A310s did not have the small winglets that became a feature of later build A310-200s and the A310-300. The A310-300 is a longer range development of the base A310-200, and has been in production since 1985. This version can carry a further 7000kg (15,430lb) of fuel in the tailplane. 

The A310-200F freighter is available new build or as a conversion of existing aircraft (13 A310s were converted to freighters for Federal Express by Airbus partner Daimler Benz [now DaimlerChrysler] Aerospace Airbus). The A310-200C convertible passenger/freighter first entered service with Dutch operator Martinair in 1984.',NULL,'Operational'),
('airbusa318','The A318 will be Airbus'' smallest airliner and is the European manufacturer''s first foray into the 100 seat market. 

Airbus'' initial efforts at developing a 100 seat airliner were focused on the all new AE31X program (covering the baseline 95 seat AE316 and 115-125 seat AE317) which Airbus and Alenia, as Airbus Industrie Asia, were developing in conjunction with AVIC of China and Singapore Technologies. The AE31X program arose out of earlier Chinese and South Korean studies for a 100 seater and a framework agreement covering its development was signed in May 1997. However on September 3 1998 Airbus announced termination of the project saying it was not economically viable. 

The AE31X would have flown in mid 2002 and entered service in mid 2003. Final assembly would have been undertaken at Xian in China by Xian Aircraft Company. 

Even before the cancellation of the AE31X program Airbus had been independently studying a minimum change 100 seat derivative of the A319 covered by the A319M5 designation (M5 = minus five fuselage frames). Following the AE31X''s cancellation Airbus announced the commercial launch of the A319M5 as the A318 at the 1998 Farnborough Airshow. 

Airbus announced the A318''s industrial launch in April 1999, allowing full scale development to get underway, permitting service entry in late 2002. Program development cost is estimated at $US300m, and the list unit price $US36m. 

Compared with the A319, the A318 is 4.5 frames shorter, reducing standard two class seating from 124 to 107. The A318''s other significant new feature will be its powerplant, the newly developed Pratt & Whitney PW-6000 (being developed in the 67-102kN/15-23,000lb thrust class), but the CFM International CFM56-5 is also available. Other changes will include a small dorsal fin added to the tail, modified wing camber, and a reduced size cargo door. 

Otherwise the A318 will retain much commonality with the rest of the A320 family, including the advanced flightdeck with side stick controllers and fly-by-wire flight controls allowing a common type rating, and the same six abreast fuselage cross section.

The first flight was made on January 15, 2002 from Hamburg-Finkenwerder.',NULL,'Operational'),
('airbusa319','The A319 is one of the smaller members of Airbus'' highly successful single aisle airliner family currently in service, and competes with Boeing''s 737-300 and 737-700. 

The A319 program was launched at the Paris Airshow in June 1993 on the basis of just six orders placed by ILFC late in 1992 and the predicted better prospects of the commercial airliner market, which were certainly realised. The first A319 airline order came from French carrier Air Inter (since merged into Air France), whose order for six was announced in February 1994. Since then Swissair, Air Canada, Lufthansa, Northwest, United, US Airways and British Airways are among the major customers that have ordered more than 500 A319s (all also operate or have on order A320s). 

The A319 flew for the first time on August 25 1995 from Hamburg in Germany. European JAA certification and service entry, with Swissair, took place in April 1996. 

The A319 is a minimum change, shortened derivative of the highly successful A320. The major difference between the A320 and A319 is that the latter is shorter by seven fuselage frames, while in almost all other respects the A319 and A320 are identical. 

Like the A321, A330 and A340, the A319 features Airbus'' common two crew glass cockpit with sidestick controllers first introduced on the A320. There are significant crew training cost benefits and operational savings from this arrangement as the A319, A320 and A321 can all be flown by pilots with the same type rating, meaning that the same flightcrew pool can fly any of the three types. Further, the identical cockpit means reduced training times for crews converting to the larger A330 and A340. The A319 is said to have the longest range in this category of airliner. 

Like the A321, A319 final assembly takes place in Hamburg with DaimlerChrysler Aerospace Airbus. Final assembly of all other Airbus airliners, including the A320, takes place at Toulouse. 

The A319 forms the basis for the new baby of the Airbus family, the A318 100 seater (described separately), and the Airbus A319 Corporate Jetliner (also described separately).',NULL,'Operational'),
('airbusa319cj','The Airbus Corporate Jetliner, or A319CJ, is a long range corporate jet development of the A319 airliner which competes directly with the Boeing Business Jet and dedicated long range corporate jets such as the Bombardier Global Express and Gulfstream V. 

Airbus launched the A319CJ at the 1997 Paris Airshow and the first A319CJ rolled out of Dasa''s Hamburg A319/A321 assembly hall in October 1998. The airframe was then due to be fitted with belly auxiliary fuel tanks and flight test instrumentation prior to making a first flight in May 1999. Certification is planned for mid 1999 with the first customer delivery due in November that year. 

Unlike the Boeing Business Jet, which combines the 737-700''s airframe with the 737-800''s strengthened wing and undercarriage, the A319CJ is designed to be a minimum change development of the A319. This means, according to Airbus, that the A319CJ can be easily converted to an airliner, thus increasing the aircraft''s potential resale value. 

The first A319CJ is powered by IAE V2500s but CFM56s are also available, while the A319''s containerised cargo hold means that the CJ''s auxiliary fuel tanks can be easily loaded and unloaded, giving operators flexibility to reconfigure the aircraft for varying payload/range requirements. Like the rest of the A320 single aisle family (plus the A330 and A340), the A319CJ shares Airbus'' common advanced six screen EFIS flightdeck with sidestick controllers, plus fly-by-wire flight controls. 

At mid 2002 Airbus had selected five cabin outfitters for the aircraft - among which Lufthansa Technik in Germany, Jet Aviation of Switzerland, and Air France Industries. Airbus will supply green A319CJ airframes to the outfitters for interior fitment. Interiors weigh around 3.8 tonnes (8500lb) and cost $US4-10m. Outfitting will typically take four to six months. 

The first A319CJ order, announced in December 1997, was placed by a Kuwaiti individual. Among the later customers are the Italian, French, and Venezuelan Air Forces, Taiwan''s Eva Air, and Qatar Airways.',NULL,'Operational'),
('airbusa320','Perhaps the most important contributor to Airbus Industrie''s success as an airliner manufacturer, the four member A320 family is a significant sales success and a technological trailblazer. The 150 seat A320 is the foundation and best selling member of the family. 

The A320 is perhaps best known as the first airliner to introduce a fly-by-wire flight control system - where control inputs from the pilot are transmitted to the flying surfaces by electronic signals rather than mechanical means. Apart from a small weight saving, the advantage of Airbus'' fly-by-wire is that as it is computer controlled, an inbuilt flight envelope protection makes it virtually impossible to exceed certain flight parameters such as G limits and the aircraft''s maximum and minimum operating speeds and angle of attack limits. 

Also integral to the A320 is the advanced electronic flightdeck, with six fully integrated EFIS colour displays and innovative sidestick controllers rather than conventional control columns. The A320 also employs a relatively high percentage of composite materials compared to earlier designs. Two engines are offered, the CFM56 and IAE V2500. 

The A320 program was launched in March 1982, first flight occurred on February 22 1987, while certification was awarded on February 26 1988. Launch customer Air France took delivery of its first A320 in March that year. The first V2500 engined A320 was delivered to Adria Airways in May 1989. 

The initial production version was the A320-100, which was built in only small numbers before being replaced by the definitive A320-200 (certificated in November 1988) with increased max takeoff weight, greater range and winglets. The stretched A321 and shortened A319 and A318 are described separately. All four share a common pilot type rating. Mid 2000 A320 family production was at a monthly rate of 22, to be increased to 30 units a month by the end of 2002.',NULL,'Operational'),
('airbusa321','Like the shortened A319, the A321 is a minimum change, in this case stretched, development of the successful A320. 

The A321 program was launched in November 1989 and the first development aircraft first flew on March 11 1993. European certification was awarded in December that year. 

Compared with the A320 the A321''s major change is the stretched fuselage, with forward and rear fuselage plugs totalling 6.93m (22ft 9in) (front plug immediately forward of wing 4.27m/14ft, rear plug directly behind the wing 2.67m/8ft 9in). 

Other changes include strengthening of the undercarriage to cope with the higher weights, more powerful engines, a simplified and refined fuel system and larger tyres for better braking. A slightly modified wing with double slotted flaps and modifications to the flight controls allows the A321''s handling characteristics to closely resemble the A320''s. The A321 features an identical flightdeck to that on the A319 and A320, and shares the same type rating as the smaller two aircraft. 

The basic A321-100 features a reduction in range compared to the A320 as extra fuel tankage was not added to the initial design to compensate for the extra weight. To overcome this Airbus launched the longer range, heavier A321-200 development in 1995 which has a full pax transcontinental US range. This is achieved through higher thrust V2533-A5 or CFM56-5B3 engines and minor structural strengthening and 2900 litres (766US gal/638Imp gal) greater fuel capacity with the installation of an ACT (additional centre tank). 

The A321-200 first flew from Daimler Benz (now DaimlerChrysler) Aerospace''s Hamburg facilities in December 1996.',NULL,'Operational'),
('airbusa330200','The A330-200 is the newest member of Airbus'' widebody twinjet family and is a long range, shortened development of the standard A330, developed in part as a replacement for the A300-600R and a competitor to the 767-300ER. 

Airbus launched development of the A330-200 in November 1995, followed by the first customer order, for 13 from ILFC, placed in February 1996. First flight was on August 13 1997, with certification and first customer deliveries,to ILFC/Canada 3000, in April 1998. 

The A330-200 is based on the A330-300 and shares near identical systems, airframe, flightdeck and wings, the only major difference being the fuselage length. Compared with the 300 the A330-200 is 10 frames shorter, and so has an overall length of 59.00m (193ft 7in), compared with 63.70m (209ft 0in) for the standard length aircraft. This allows the A330-200 to seat 256 passengers in a three class configuration, or alternatively 293 in two classes. 

Because of its decreased length the A330-200 features enlarged horizontal and vertical tail surfaces (to compensate for the loss of moment arm with the shorter fuselage). Another important change is the addition of a centre fuel tank, which increases the A330-200''s fuel capacity over the 300''s, and results in the 200''s 11,850km (6400nm) range. 

Like the A330, engine options are the GE CF6-80, Pratt & Whitney 4000 series and the RollsRoyce Trent 700. 

The A330-200 has sold quite strongly since its launch. Among the initial A330-200 customers are, apart from ILFC, Canada 3000, Korean Air, Austrian, Air Transat, Emirates, Swissair, Sabena, Monarch, Asiana, TAM, and Air Lanka.',NULL,'Operational'),
('airbusa330300','The A330-300 is the biggest member of Airbus'' twinjet family and is closely related to the four engined long range A340 with which it shares near identical systems, airframe, flightdeck and wings, the only major difference being the twin (versus four) engine configuration. 

The A340 and A330 were launched simultaneously in June 1987. Although developed in parallel the A330-300 made its first flight after the A340, on November 2 1992. It was the first aircraft to achieve simultaneous European Joint Airworthiness Authorities (JAA) and US FAA certification, on October 21 1993. Entry into service took place by the end of that year. 

Differences from the A340 aside from the number of engines are slight changes to the wing and internal systems, including fuel tankage. The A330 (like the A340) takes advantage of a number of technologies first pioneered on the A320, including the common advanced EFIS flightdeck with side stick controllers and flybywire computerised flight control system. 

While the standard A330-300 shares the same fuselage length as the A340-300, Airbus has studied various stretched (A330-400) and shortened (A330-100 and 200) versions. The shortened A330-200 was formally launched in 1996 as a long range 767-300ER competitor, and is described separately. One stretched, high capacity concept studied for a time featured lower deck seating in place of the forward freight hold.',NULL,'Operational'),
('airbusa340200300','The A340-200 and 300 are the initial variants of the successful quad engined A340 family of long haul widebodies. 

The A340 and closely related A330 were launched in June 1987, with the A340''s first flight occurring on October 25 1991 (an A340-300). The A340 entered service with Lufthansa and Air France in March 1993, following JAA certification the previous December. 

The A340 shares the same flightdeck including side stick controllers and EFIS, plus flybywire, basic airframe, systems, fuselage and wing with the A330 (the flightdeck is also common to the A320 series). Power is from four CFM56s, the four engine configuration being more efficient for long range flights (as twins need more power for a given weight for engine out on takeoff performance) and free from ETOPS restrictions. 

The A340-300 has the same fuselage length as the A330-300, while the shortened A340-200 trades seating capacity for greater range (first flight April 1 1992). 

The heavier A340-300E is available in 271,000kg (597,450lb) and 275,000kg (606,275lb) max takeoff weights, their typical ranges with 295 passengers are 13,155km (7100nm) and 13,525km (7300nm) respectively. Power for these models is from 152.3kN (34,000lb) CFM56-5C4s (the most powerful CFM56s built). The first A340-300Es were delivered to Singapore Airlines in April 1996. 

The 275,000kg (606,275lb) max takeoff weight A340-8000 is based on the 200 but has extra fuel in three additional rear cargo hold tanks and offers a 15,000km (8100nm) range with 232 three class passengers (hence the A340-8000 designation). It too is powered by CFM56-5C4s. One has been built for the Sultan of Brunei. 

All versions are offered with underfloor passenger sleepers.',NULL,'Operational'),
('airbusa340500600','The 15,740km (8500nm) ultra long range A340-500 and stretched 372 seat A340-600 are new variants of the Airbus A340 family, and are currently the world''s longest range airliners.

Compared with the A340-300, the A340-600 features a 9.07m (35ft 1in) stretch (5.87m/19ft 3in ahead of the wing and 3.20m/10ft 6in behind), allowing it to seat 372 passengers in a typical three class arrangement. This gives Airbus a true early model 747 replacement and near direct competitor to the 747-400, with similar range, but, Airbus claims, better operating economics (per seat). 

The A340-500 meanwhile is stretched by only 3.19m (10ft 6in) compared with the A340-300, and so seats 313 in three classes, but it has a massive range of 15,740km (8500nm), which makes it the longest ranging airliner in the world, capable for example of operating Los Angeles-Singapore nonstop. 

The two new A340 models share a common wing. The wing is based on the A330/A340''s but is 1.6m (5.2ft) longer and has a tapered wingbox insert, increasing wing area and fuel capacity. Both models feature three fuselage plugs. The other change to the A340 airframe is the use of the A330-200 twin''s larger fin and enlarged horizontal area stabilisers. To cope with the increased weights the centre undercarriage main gear is a four wheel bogie, rather than a two wheel unit. 

Both new A340s have a high degree of commonality with the A330 and other A340 models. They feature Airbus'' common two crew flightdeck, but with some improvements such as LCD rather than CRT displays and modernised systems. 

The A340-500 is powered by four 236kN (53,000lb) thrust Rolls-Royce Trent 556 turbofans, and the A340-600 by the 249kN (56,000lb) thrust Trent 556. 

The commercial launch for the A340-500/600 was at the 1997 Paris Airshow, the program''s industrial launch was in December that year when Virgin Atlantic ordered eight A340-600s and optioned eight. First flight of the A340-600 was made on April 23, 2001. After a 1600 hour flight test program, certification was received on May 29, 2002. Virgin Atlantic took delivery of its first A340-600 at the 2002 Farnborough International Airshow, and began commercial services in August.

The A340-500 made its first flight on February 11, 2002, and was certificated on December 3 after 400 hours of flight test.',NULL,'Operational'),
('airbusa380','The 555 seat, double deck Airbus A380 is the world''s largest airliner, easily eclipsing Boeing''s 747. The A380 base model is the 555 seat A380-800 (launch customer Emirates). Potential future models include the 590 ton MTOW 10,410km (5620nm) A380-800F freighter, able to carry a 150 tonne payload, and the stretched, 656 seat, A380-900.

Airbus first began studies on a very large 500 seat airliner in the early 1990s. The European manufacturer saw developing a competitor and successor to the Boeing 747 as a strategic play to end Boeing''s dominance of the very large airliner market and round out Airbus'' product line-up. 

Airbus began engineering development work on such an aircraft, then designated the A3XX, in June 1994. Airbus studied numerous design configurations for the A3XX and gave serious consideration to a single deck aircraft which would have seated 12 abreast and twin vertical tails. However Airbus settled upon a twin deck configuration, largely because of the significantly lighter structure required. 

Key design aims include the ability to use existing airport infrastructure with little modifications to the airports, and direct operating costs per seat 15-20% less than those for the 747-400. With 49% more floor space and only 35% more seating than the previous largest aircraft, Airbus is ensuring wider seats and aisles for more passenger comfort. Using the most advanced technologies, the A380 is also designed to have 10-15% more range, lower fuel burn and emissions, and produce less noise. 

The A380 features an advanced version of the Airbus common two crew cockpit, with pull-out keyboards for the pilots, extensive use of composite materials such as GLARE (an aluminium/glass fibre composite), and four 302 to 374kN (68,000 to 84,000lb) class Rolls-Royce Trent 900 or Engine Alliance (General Electric/Pratt & Whitney) GP7200 turbofans now under development. 
On July 24, 2000, Emirates became the first customer making a firm order commitment, followed by Air France, International Lease Finance Corporation (ILFC), Singapore Airlines, Qantas and Virgin Atlantic. Together these companies completed the 50 orders needed to launch the programme. 

On receipt of the required 50th launch order commitment, the Airbus A3XX was renamed A380 and officially launched on December 19, 2000. The out of sequence A380 designation was chosen as the "8" represents the cross-section of the twin decks. In early 2001 the general configuration design was frozen, and metal cutting for the first A380 component occurred on January 23, 2002, at Nantes in France. In 2002 more than 6000 people were working on A380 development. 

Apart from the prime contractors in France, Germany, the United Kingdom and Spain, components for the A380 airframe are also manufactured by industrial partners in Australia, Austria, Belgium, Canada, Finland, Italy, Japan, South Korea, Malaysia, Netherlands, Sweden, Switzerland and the United States. A380 final assembly is taking place in Toulouse, France, with interior fitment in Hamburg, Germany. Major A380 assemblies are transported to Toulouse by ship, barge and road. 

On January 18, 2005, the first Airbus A380 was officially revealed in a lavish ceremony, attended by 5000 invited guests including the French, German, British and Spanish president and prime ministers, representing the countries that invested heavily in the 10-year, â�¬10 billion+ ($13 billion+) aircraft program, and the CEOs of the 14 A380 customers, who had placed firm orders for 149 aircraft by then. 

Later, the following companies also ordered the A380: FedEx (the launch customer for the A380-800F freighter), Qatar Airways, Lufthansa, Korean Air, Malaysia Airlines, Etihad Airways, Thai Airways and UPS. 

However, in 2007, amid production delays, Airbus announced that it was halting design work on the A380 freighter to concentrate on the passenger version of the aircraft.  FedEx and UPS canceled their orders for the aircraft.

Five prototypes were used in the flight test programme, which was heavily delayed due to problems with configuration management and wiring issues. The first flight occurred in August 2006, and entry into commercial service, with Singapore Airlines, took place in October 2007.',NULL,'Operational'),
('americanchampionbellancaseries','The Citabria, Bellanca and Scout can trace their lineage back to the Aeronca 7 Champion (described separately).

Champion Aircraft Corporation purchased the production rights to the Aeronca 7 in 1951, and from this developed the 7EC Traveller and 7GCB Challenger. The Challengerbased Citabria first flew in May 1964 and incorporated a number of changes over the earlier models. These included more glass area, a squarer tail and stressing for limited (+5g, 2g) aerobatic flight, while other features were the flapless wing and choice of 75kW (100hp) Continental O200 or 80kW (108hp) Lycoming O235 engines. Variants on this theme were the 110kW (150hp) O320 powered 7GCAA and the 7GCBC with a longer span wing fitted with flaps.

Bellanca took over production of the Citabria in September 1970, renaming the 7ECA, which by now was powered by an 85kW (115hp) O235, as the Citabria; the 7GCAA the Citabria 150 and the 7GCBC the Citabria 150S.

Champion initially developed the 7KCAB model, but Bellanca took this over, resulting in the fully aerobatic 8KCAB Decathlon. The ultimate Decathlon design was the 135kW (180hp) AEIO360 powered Super Decathlon.

The Scout was designed to perform a number of utility roles, and appeared in 1970. The updated 8GCBC followed in 1974 with a 135kW (180hp) O360.

Bellanca production ended in 1982, while the Champion Aircraft Company produced the range in limited numbers between 198586.

All three models are once again in low rate production, this time with American Champion. American Champion restarted production of the series in 1990, and now builds the baseline 7ECA Citabria Aurora (reintroduced in 1995), the 7GCBC Citabria Explorer, 8KCAB Super Decathlon and the 8GCBC Scout (and Scout CS with constant speed propeller). These aircraft are basically similar to their earlier namesakes, save for some minor equipment changes.',NULL,'Operational'),
('antonovan12shaanxiy8','The An-12 (NATO reporting name "Cub") was developed to fulfil a Soviet air force requirement for a turboprop freighter. Based on the twin turboprop An-8 which was developed for Aeroflot service, the four engine An-12 was developed in parallel with the commercial passenger An-10. 

The prototype An-12 flew in 1958, powered by Kuznetsov NK-4 turboprops, and was essentially a militarised An-10 with a rear loading cargo ramp. Approximately 100 An-10s were built, the type seeing service between 1959 and 1973. 

Series production of the An-12 in a number of mainly military variants continued until 1973, from which time it was replaced in Soviet service by the Ilyushin Il-76 (described elsewhere). The An-12BP is the basic military transport version of the Cub. Other military versions are in use as Elint and ECM platforms. 

The defensive rear gunner''s turret is faired over on civil An-12s. Operators have included Aeroflot, Cubana, LOT Polish Airlines and Bulair for civil and quasi military work. 

China''s Xian began redesign work of the An-12 in 1969, but after the first prototype the program was transferred to Shaanxi. A number of Chinese versions were developed, including the civil variants Y-8B and Y-8C, the latter developed with cooperation from Lockheed, similar Y-8F-200, Y-8F livestock carrier and Y-8H aerial survey model.',NULL,'Operational'),
('antonovan124ruslan','For a time the massive An-124 held the mantle of the world''s largest aircraft before the arrival of the An-225, a stretched six engine derivative. It is commonly used for oversize freight charters. 

Developed primarily as a strategic military freighter (in which role it can carry missile units and main battle tanks), the first prototype An-124 flew on December 26 1982. A second prototype, named Ruslan (after a Russian folk hero), made the type''s first western public appearance at the Paris Airshow in June 1985, preceding the type''s first commercial operations in January 1986. Since that time the An-124 has set a wide range of payload records, a recent achievement being the heaviest single load ever transported by air - a 124 tonne (273,400lb) powerplant generator and its associated weight spreading cradle, a total payload weight of 132.4 tonnes (291,940lb), set in late 1993. 

Notable features include nose and tail cargo doors, 24 wheel undercarriage allowing operations from semi prepared strips, the ability to kneel to allow easier front loading, and flybywire control system. 

The two major An-124 variants are the basic An-124 and similar Russian civil certificated An-124-100. Various upgrades have been proposed, including the western avionics equipped An-124-100M built in prototype form but not flown, the three crew EFIS flighdeck equipped An-124-102 and the An-124FFF firebomber. 

Numerous reengine studies have also been conducted, including using Rolls-Royce RB-211-524Gs, General Electric CF680s (as the An-124-130) and even Aviadvigatel NK93 propfans. 

The An-225 Mryia is based on the An-124 but features six (instead of four) D18T turbofans, a stretched fuselage and a 600 tonne (1,322,750lb) max takeoff weight. One was built, intended as a transport for the Russian Buran Space Shuttle equivalent. First flight was in 1988.',NULL,'Operational'),
('antonovan140','Antonov''s An-140 is an all new 50 seat twin turboprop regional airliner developed to replace the ageing An-24.

Antonov announced development of the An-140 in 1993. The first An-140 prototype rolled out from the Kiev factory on June 6 1997 and flew for the first time on September 17 that year. The second flying prototype was completed in late 1998, while the first production standard An-140 flew on October 11 1999.

The An-140 is of conventional design and construction, with US and European certification planned in addition to Russian/CIS certification. The basic version is powered by Motor-Sich AI-30s which are licence built Klimov TV3-117VMA-SBM1s, while Pratt & Whitney Canada PW127As will be optional. The flightdeck features conventional instruments, the main cabin seats 52 in a four abreast configuration. The rear passenger door features integral stairs, while a forward starboard side freight door allows cargo to be carried. The rear of the cabin also features a galley, coat stowage and a toilet.

Production of the initial basic An-140 was superseded in 2003 by the An-140-100 which features a 1.00m (3ft 3in) increase in wing span, a higher MTOW and a 300km (160nm) longer range. Other future versions include the An-140A for Aeroflot which will be powered by PW127As, the An-140T freighter which would have a large freight door on the rear port side, the convertible An-140TK, the An-140VIP executive version, and the An-142 with a rear loading freight ramp. Military versions are also planned.    

Series production of the An-140 is being undertaken at Kharkov by KhGAPP in Ukraine and at Samara in Russia by Aviacor. The first few aircraft were for Odessa Airlines, Aeromost (originally named Aeromist), Motor-Sich and Illich Avia. 

In 1996 Antonov signed an agreement with HESA in Iran for licence assembly of an An-140 model called the IRAN-140 Faraz at a new plant in Esfahan. Initial IRAN-140s will be assembled from supplied kits, with gradually increasing Iranian local content. the first Faraz flew in February 2001. Iran Asseman and Iran Air are expected to be customers.',NULL,'Operational'),
('antonovan22antei','The massive An-22 Antei (Antheus) is the largest turboprop powered aircraft yet built - it has a maximum takeoff weight similar to that of the Airbus A340-300 - and was designed in response to a largely military Soviet requirement for a strategic heavylift freighter. 

The An-22 (NATO reporting name `Cock'') made its first flight on February 27 1965 - at that time it was comfortably the largest aircraft in the world. Production of the An-22 for the Soviet air force and Aeroflot continued through the 1960s until 1974. 

The An-22 set 14 payload to height records in 1967, the pinnacle of which was the carriage of 100 tonnes (220,500lb) of metal blocks to an altitude of 25,748ft (7848m). It also established the record for a maximum payload lifted to a height of 2000m (6562ft), carrying a payload of 104,444kg (221,443lb). A number of class speed records were also set in 1972, including a speed of 608.5km/h (328kt) around a 1000km (540nm) circuit with a 50,000kg (110,250lb) payload. Further speed with payload records were established in 1974 and 1975. 

As well as operations into the underdeveloped regions of Russia''s northeast, Siberia and Far East, Aeroflot An-22s were commonly used for military transport, their `civilian'' status allowing much freer access to landing and overflight rights. 

Notable features of the An-22 include the NK12 turboprops - which also power the Tupolev Tu-95/Tu-142 Bear family of bombers and maritime patrol aircraft and are the most powerful turboprop engines in service - comprehensive navigation and precision drop avionics, and massive undercarriage and tailplane.',NULL,'Operational'),
('antonovan225mriya','Antonov An-225 "Mriya" is the world''s largest aircraft. When it was built, it surpassed any airliner built before by 50%.  It was designed for the transportation of the Russian Space Shuttle "Buran" by the Antonov Design Bureau (HQ in Kiev, Ukraine), which already had built good and large cargo aircraft such as the Antonov An-124 "Ruslan". The basic configuration of the An-225  is the same as the An-124, except the An-225 is longer, has no rear ramp/door assembly, and incorporates a 32-wheel landing gear system (two nose and fourteen main wheel bogies, seven per side, each with two wheels).

An-225 "Mriya" ("Mriya" is Ukrainian word for "dream) is also capable to transport other oversized objects/cargo. It is not a military aircraft, but it could find many military uses, because of the ability to transport cargo that no other aircraft is capable to.

The plane had the first flight in early 1988 and entered service in 1989. It''s first flight took 75 minutes. After the cancellation of the Buran space program, the only An-225 built was stored in spring 1994, and it''s engines were used for An-124s. In 2001 the aircraft was made airworthy again, and made it''s new first flight on May 7. There were rumors that the European Space Agency had plans to launch the unmanned British HoTOL (Horizontal Take-Off and Landing) from the An-225, though these rumors appear to be unfounded. Although, some possibilities for deployment have already been found. Plenty of customers are to be found in the USA. According to Bruce Bird, Director of the Charter Division of Air Foyle, parts of rocket launchers like the Delta and Atlas could be transported in the An-225. Lockheed''s planned Venture Star could be transported on its back. Additionally the Mrija could serve as a launch platform for the X-34B. Furthermore big sections of aircraft could be transported in it. The complete assembled fuselage of a Boeing 737 can be fitted in the hold. 

A second An-225 was partly built, but was stored before it was finished.  It is possible that more aircraft of the type will be built, depending on market demand.',NULL,'Operational'),
('antonovan24263032xiany7','The An-24 is the original aircraft in a prolific and highly successful family of twin turboprop civil and military transports. 

The An-24 first flew in April 1960 with first production versions entering Aeroflot service in September 1963. Aeroflot was the largest An-24 operator, with others going to Soviet client nations. 

Subsequent production versions of the An-24 were the An-24B and the An-24T freighter. A small turbojet in the right engine nacelle to boost takeoff performance resulted in the An-24RT and An-24RV. The An-24P firebomber was also developed before Ukrainian production ceased in 1978. 

The An-24 was also developed into the An-26 "Curl" military tactical transport with more powerful engines and redesigned tail, which itself evolved into the An-32 with enhancements for better hot and high performance. Over 550 An-26s are in civil service. 

The An-30 development has been produced in limited numbers and is used largely for aerial survey and cartography work. This version is identifiable by its extensive nose glazing. 

The An-32 first flew in 1976 and features much more powerful 3760kW (5042ehp) Progress engines for improved hot and high performance. The An-32 features above wing mounted engines to give the larger diameter props adequate ground clearance. 

China''s Xian Aircraft Manufacturing Company is now the sole production source for the An-24 as the Y-7. The Y-7-100 incorporates a number of modifications including a revised passenger interior and flightdeck, and wingtip winglets. It was developed with the technical assistance of HAECO in Hong Kong during the 1980s.',NULL,'Operational'),
('antonovan38','The An-38 is an all-new development of the earlier An-28, series production of which had been transferred to PZL-Mielec in Poland. During a sales tour of India in 1989 a requirement emerged for a larger 25-30 seat version of the An-28. Late 1990 this was approved by the Soviet Ministry of Transport. At the 1991 Paris Air Show a model was shown and details were made public for the first time. The aircraft is intended to replace An-24s, Let L-410s and Yak-40s. 

As the An-28 was produced in Poland, and had to be paid in foreign currency after the break-up of the Soviet Union, payment in local currency was an added advantage for the development of the An-38.

The An-38 retains the basic wing and twin fin tail structure of the An-28, but has a stretched fuselage with three additional seat rows. New high efficiency Honeywell TPE331 or Omsk TVD-20 engines power the An-28. Many other improvements have been made such as improved sound and vibration insulation, reduced external noise, improved cockpit and passenger cabin comfort, payload, fuel efficiency and flight speed. The An-38 is equipped with a rear cargo door and a cargo-handling overhead-track hoist. The seats and the baggage compartment can be folded by the crew to provide a clear space for use as a cargo aircraft.

The fixed tricycle gear with low pressure tires enables operation from unpaved runways. The An-38 has weather radar and an integrated navigation system and can be operated by night and in adverse weather. It can be equipped with Western or CIS avionics.

Apart from passenger and cargo configuration, the multirole An-38 can also be equipped for forest patrol, aerial photography, survey, fishery patrol, ambulance, VIP transport and military airlift. 

The first flight was made on June 23 1994 by the version with TPE331 engines, the An-38-100. The TVD-20 version, the An-38-200, followed on December 11 2001. Certification of the An-38-100 in compliance with AP-25 rules was granted April 22 1997. The An-38-200 was certificated on November 28 2002.

The An-38-110 is a -100 with a reduced avionics fit, the An-38-120 is a -100 with an enhanced avionics fit.

In December 1995 Antonov and NAPO (Novosibirsk Aircraft Production Association) established a joint venture company, Siberian Antonov Aircraft, to produce, market and provide after-sale support of the An-38. Series production of the An-38-100 aircraft is by NAPO.

Two prototypes (one at Antonov and one at NAPO) and a static test airframe were built. Vostok Airlines became the launch customer for the production aircraft and the first three were received by mid-1995. The An-38 also entered service with e.g. Layang Layang Aerospace in Malaysia, Alrosa-Avia in Russia, and Vietnam Air Services.',NULL,'Operational'),
('antonovan7274','The An-72 was designed as a replacement for the An-26 tactical transport for the Soviet air force, but variants are in use as commercial freighters. 

The first of five flying An-72 prototypes flew for the first time on August 31 1977, although it was not until much later in December 1985 that the first of eight extensively revised preproduction An-72s flew. Included in this pre series batch were two An-74s, differing from the An-72s in their ability to operate in harsh weather conditions in polar regions. Production of the An-72/74 family continues. 

Versions of the An-72/74 family (NATO codename `Coaler'') include the An-72 base model with extended wings and fuselage compared to the prototypes, the An-72S VIP transport and An-72P maritime patrol aircraft. 

Versions of the An-74 include the An-74A, the base An-74 model featuring the enlarged nose radome, the An-74T freighter, the An-74TK, 74TK100 and 74TK200 convertible passenger/freighter models, and the An-74P200D VIP transport. 

The most significant design feature of the An-72 and An-74 is the use of the Coanda effect to improve STOL performance, which utilises engine exhaust gases blown over the wing''s upper surface to boost lift. Other features include multi slotted flaps, rear loading ramp and multi unit landing gear capable of operations from unprepared strips.',NULL,'Operational'),
('antonovpzlmielecan2','The An-2 was originally designed to meet a USSR Ministry of Agriculture and Forestry requirement, and flew for the first time on August 31 1947. 

Entering production and service the following year, Antonov built An-2s were powered by 745kW (1000hp) ASh62 radials. Soviet production continued through to the mid sixties by which time a number of variants had been developed, including the base model An-2P, An-2S and 2M crop sprayers, An-2VA water bomber, An-2M floatplane and the An-2ZA high altitude meteorological research aircraft. 

Production responsibility was transferred to Poland''s PZL Mielec in the 1960s, with the first example flying on October 23 1960. Aside from the An-2P, Polish versions include the An-2PK VIP transport, An-2PR for TV relay work, An-2S ambulance, An-2TD paratroop transport, An-2P cargo/passenger version, An-2 Geofiz geophysical survey version, passenger An-2T and An-2TP, and agricultural An-2R. 

Chinese production as the Y5 commenced with Nanchang in 1957, before being transferred to the Shijiazhuang Aircraft Manufacturing Company. The main Chinese version is the standard Y5N, while the latest development is the Y5B specialist ag aircraft, which first flew in June 1989. 

An Antonov built turboprop powered version, the An-3, flew in prototype form in the early 1980s powered by a 706kW (946shp) Omsk (Mars) TVD10, but did not enter production.',NULL,'Operational'),
('antonovpzlmielecan28','The An-28 was the winner of a competition against the Beriev Be30 for a new light passenger and utility transport for Aeroflot''s short haul routes. 

The An-28 is substantially derived from the earlier An14. Commonality with the An14 includes the high wing layout, twin fins and rudders, but it differs in having a new and far larger fuselage, plus turboprop engines. The original powerplant was the TVD850, but production versions are powered by the more powerful TVD10B. 

The An-28 made its first flight as the An14M in September 1969 in the Ukraine. A subsequent preproduction aircraft first flew in April 1975. Production of the An-28 was then transferred to Poland''s PZL Mielec in 1978, although it was not until 1984 that the first Polish built production aircraft flew. The An-28''s Soviet type certificate was awarded in April 1986. 

While of conventional design, one notable feature of the An-28 is that it will not stall, due to its automatic slots. An engine failure that would usually induce the wing to drop 30° is combated by an automatic spoiler forward of the aileron that opens on the opposite wing, restricting wing drop to 12° in five seconds. 

PZL Mielec has been the sole source for production An-28s, and has developed a westernised version powered by 820kW (1100shp) Pratt & Whitney PT6A65B turboprops with five blade Hartzell propellers, plus some western (BendixKing) avionics. Designated the An-28PT, first flight was during early 1993 and it is in limited production. Marketed as the M28 Skytruck, the type received Polish certification equivalent to US FAR Part 23 in March 1996. 

The An-28 was further developed into the stretched An-38.',NULL,'Operational'),
('atratr42','Aerospatiale and Aeritalia (now Alenia) established Avions de Transport Regional as a Groupement d''IntÃ©ret Economique under French law to develop a family of regional airliners. The ATR-42 was the consortium''s first aircraft and was launched in October 1981. 

The first of two ATR-42 prototypes flew for the first time on August 16 1984. Italian and French authorities granted certification in September 1985 and the first ATR-42 entered airline service on December 9 1985. 

The initial ATR-42-300 was the standard production version of the ATR-42 family until 1996 and features greater payload range and a higher takeoff weight than the prototypes. The similar ATR-42-320 (also withdrawn in 1996) differed in having the more powerful PW-121 engines for better hot and high performance, while the ATR-42 Cargo is a quick change freight/passenger version of the 42-300. 

The ATR-42-500 is the first significantly improved version of the aircraft and features a revised interior, more powerful PW-127Es for a substantially increased cruising speed (565km/h/305kt) driving six blade propellers, a 1850km (1000nm) maximum range, the EFIS cockpit, elevators and rudders of the stretched ATR-72 (described separately), plus new brakes and landing gear and strengthened wing and fuselage for higher weights. The first ATR-42-500 delivery was in October 1995. 

ATR was part of Aero International (Regional), the regional airliner consortium established in January 1996 to incorporate ATR, Avro and Jetstream. AI(R) handled sales, marketing and support for both the ATRs, plus the Avro RJs and the Jetstream 41, until its disbandment in mid 1998 when ATR regained its independence.

In mid-2000, ATR launched a freighter conversion program for both the -42 and -72, involving installing a forward freight door and modifying the cabin for freight.  The ATR-42 Freighter can carry a 5.8 tonne payload.  DHL Aviation Africa was the launch customer with two converted ATR-42-300s redelivered in September and December, 2000.',NULL,'Operational'),
('atratr72','The ATR-72 is a stretched development of the popular ATR-42 and was launched in January 1986. 

The first of three ATR-72 development aircraft flew for the first time on October 27 1988, followed by the awarding of French and then US certification in late 1989. Entry into service was on October 27 1989 with Kar Air of Finland. Some other early operators are Foshing Airlines, NFD (later Eurowings), CSA, American Eagle, TAT, Air Littoral, LOT, and Olympic Aviation. 

Significant differences between the ATR-72 and the smaller and older ATR-42 include a 4.50m (14ft 9in) fuselage stretch and reworked wings. The ATR-72''s wings are new outboard of the engine nacelles and with 30% of it made up of composite materials, comprising composite spars and skin panels and a carbon fibre wing box. 

Aside from the baseline ATR-72-200, two developments have been offered, the ATR-72-210, and the ATR-72-500 (previously ATR-72-210A). The ATR-72-210 is optimised for operations in hot and high conditions. It has more powerful PW-127 engines for better takeoff performance. 

The ATR-72-500 (renamed from ATR-72-210A on May 18, 1998) further improved hot and high model was certificated in early 1997. It features PW-127Fs driving six blade composite Hamilton Sundstrand propellers. 

The ATR-52C is an as yet unlaunched derivative with a redesigned tail to incorporate a rear loading ramp, intended for military and commercial operators. As with the ATR-42, a military maritime patrol version, known as the Petrel 72, has also been offered. 

The ATR-72 would have formed the basis for the ATR-82, a 78 seat stretched development. The ATR-82 would have been powered by two Allison AE-2100 turboprops (ATR studied turbofans for a time) and would have a cruising speed as high as 610km/h (330kt). The ATR-82 was suspended when AI(R) was formed in early 1996.',NULL,'Operational'),
('austerjseries','The Auster marque traces its lineage back to the Taylorcraft Aeroplanes (England) company, which produced Taylorcrafts under licence (described separately), and built over 1600 spotter (Air Observation Post) aircraft for Britain''s Royal Air Force and Army (many of which were resold to private operators). 

The first civil Auster (as the company become known in 1946) was the Mk 5 J/1 Autocrat, which was essentially similar to the military Mk V, but had a Cirrus Minor 2 engine in place of the Mk 5''s Lycoming, upholstered seats and a small number of other refinements. 

The J/1 Autocrat served as the basis for a family of civil aircraft. The next to appear was the two seat side by side J/2 Arrow family, with a 56kW (75hp) Continental, and was further developed into the J/4 Archer, which replaced the Continental with a Cirrus Minor engine. The J/1N Alpha was an attempt to increase sales and overcome the problems associated with fitting the Cirrus Minor engine to the J/1 with less equipment and minor improvements. 

Most Auster J/5 models were four seaters except for the initial J/5 which was an Autocrat with a more powerful engine, while the J/5B incorporated the enlarged four seat cabin. The J/5F Aiglet trainer was a fully aerobatic two seat trainer. The J/5D, introduced in 1959, was the last of the line and featured metal wing spars and ribs and Lycoming power (more than 160 were built, including 150 in Portugal by OGMA under licence). Auster was taken over by Beagle in 1960.',NULL,'Operational'),
('aviata1husky','The Aviat Husky utility has the distinction of being the only all new light aircraft designed and placed into series production in the United States in the mid to late 1980s. 

Similar in configuration, appearance and mission to Piper''s venerable Super Cub, the Husky is a much later design, being first conceived in the mid 1980s. The Husky was originally designed by Christen Industries, the company also responsible for the kit built Christen Eagle aerobatic biplane and previous owner of the Pitts Special aerobatic biplane series (described separately, Aviat now owns Pitts and Christen). 

Initial design work on the Husky began in late 1985, the aircraft being one of the few in its class designed with the benefit of Computer Aided Design. The prototype Husky flew for the first time in 1986, and the US FAA awarded certification the following year. Production deliveries followed shortly afterwards. 

Design features of the Husky include a braced high wing, seating for two in tandem and dual controls. This high wing arrangement was selected for good all round visibility, essential for the many observation and patrol roles the Husky is suited for. Power is supplied by a relatively powerful, for the Husky''s weight, 135kW (180hp) Textron Lycoming O360 flat four turning a constant speed prop. The good power reserves and wing also give good field performance. Unlike most current light aircraft the Husky''s structure features steel tube frames and Dacron covering over all but the rear of the fuselage, plus metal leading edges on the wings. 

Options include floats, skis and banner and glider hooks. 

With more than 450 sold since production began, the Husky has also quietly gone about becoming one of the largest selling light aircraft GA designs of the 1990s. Many of the aircraft are used for observation duties, fisheries patrol, pipeline inspection, boarder patrol, glider towing and a range of other utility missions. Notable users include the US Departments of the Interior and Agriculture and the Kenya Wildlife Service which flies seven on aerial patrols of elephant herds as part of the fight against illegal ivory poaching.',NULL,'Operational'),
('aviationtradersatl98carvair','Aviation Traders developed the Carvair in response to Channel Air Bridge''s requirement for an air ferry capable of transporting passengers and their cars between the United Kingdom and continental Europe. 

Although its external appearance is quite different, the Carvair is a conversion of the Douglas DC-4 airliner (or C-54 Skymaster in military guise), large numbers of which were available after World War 2. The airframe from the wings rearward is that of a standard DC-4, except for a lengthened vertical tail for enhanced controllability. The major modifications performed on the forward fuselage centred on a new lengthened nose section with a hydraulically operated cargo door and an elevated flightdeck (similar in appearance to that which would appear on the Boeing 747 several years later) which allowed nose loading for cars. 

First flight of the Carvair conversion was on June 21 1961, the type subsequently entering service with British United Air Ferries (into which Channel Air Bridge had been merged, it later became British Air Ferries and was known as British World Airways, which ceased trading in December 2001) in March 1962. Deliveries to other operators included three for Aer Lingus of Ireland and two for Aviaco of Spain, with other aircraft operated by French, Australian and Luxembourg carriers. 

Aviation Traders also proposed a Carvair type conversion of the Douglas DC-6, DC-6B and DC-7, with the option of reengining with RollsRoyce Dart turboprops, although these plans were never carried through. 

In 1998 one Carvair was operated by Hawkair Aviation in British Colombia, Canada, registered C-GAAH. Another operates from Bear Creek/Tara Field in Georgia in the USA, while a third is stored in South Africa. All are ex Ansett machines.',NULL,'Operational'),
('ayresthrushrockwellthrushcommander','The original Snow S2 was designed by Leland Snow, who incorporated his knowledge as an experienced ag pilot into the S2''s design. 

The Snow S2 prototype flew for the first time in 1956 and production deliveries began in 1958. S2 variants differed in engine options, and included the 165kW (220hp) Continental W670 powered S2A, the S2B and S2C with a Pratt & Whitney R985, and the R1340AN1 powered S2C600. 

Aero Commander acquired the design and production rights to the S2 series in 1965 and built the improved S2D Ag Commander. The rights to the S2 changed hands once more in 1967 when North American Rockwell (later Rockwell) acquired Aero Commander, continuing the series under the Thrush Commander banner. Rockwell models include the Thrush Commander600 with a 450kW (600hp) R1340 and the Thrush Commander800 with a 595kW (800hp) Wright R1300 Cyclone. 

Design and production rights changed hands a final time in 1977 when Ayres (who had previously carried out turboprop conversions to Thrush Commanders) acquired the rights to the Thrush Commander600. Ayres developments include the S2R600, which later became the S2R1340; the Bull Thrush, now just S2R1820; the Polish PZL3 powered Pezetel Thrush and the turboprop powered S2R series. The S2RT11, T15 and T34 are powered by PT6s, the S2RG6 and S2RG10 AlliedSignal TPE331s. Special missions developments are the S2RT65 NEDS Narcotics Eradication Delivery System for the US State Department, and the AlliedSignal powered Vigilante surveillance and close air support version. The latest development is the 660 Turbo Thrush, based on the S2R but with a larger hopper.',NULL,'Operational'),
('bac111oneeleven','The One-Eleven can trace its origins back to the proposed Hunting H-107 jet airliner project of 1956. 

Protracted development followed, but by 1961, when Hunting had been absorbed into British Aircraft Corporation (BAC), a larger Rolls-Royce Spey turbofan powered design was finalised. 

British United Airways placed a launch order for 10 of the new jets, then known as the BAC-111, in May 1961. The new aircraft took to the skies for the first time on August 20 1963, while the first production Series 200 first flew on December 19 1963. Certification was eventually awarded on April 6 1965, following a troubled flight test program, during which one prototype crashed with the loss of its crew, the cause attributed to deep stall from the rear engine and the T-tail configuration. With the deep stall issue resolved, the BAC-111 entered service on April 6 1965. 

Development of the basic Series 200 led to the higher weight Series 300, followed by the Series 400 designed for American requirements with a higher US equipment content. 

The Series 500 introduced a 4.11m (13ft 6in) stretched fuselage and lengthened wings and greater seating capacity for up to 119 passengers. It first flew (converted from a -400) on June 30 1967. The Series 475 was optimised for hot and high operations and combined the Series 500''s more powerful engines with the earlier shorter length fuselage. 

The last UK built One-Eleven (by this time a British Aerospace product) flew in 1982, by which time production was progressively being transferred to Bucuresti in Romania where nine were built as the Rombac 1-11. 

In the mid 1990s Bucuresti was working on a Rolls-Royce Tay 650 powered development called the Airstar 2500. The Airstar was planned to fly in late 1996 but the program has been suspended. 

In the USA, Dee Howard converted two Srs 400 to Tay powered Srs 2400.',NULL,'Operational'),
('baesystemsavrorjx85100','The Avro RJX range is a modernised development of the Avro RJ family, with the key change being new Honeywell AS977 powerplants which promised greater range, improved fuel burn and lower maintenance costs.

British Aerospace Regional Aircraft (later BAE Systems Regional Aircraft) announced it was conditionally offering the improved RJX range on February 16 1999 at the Avalon Airshow (near Melbourne, Australia). At the same time British Aerospace announced the selection of the Honeywell AS977 turbofan. At that stage certification was planned for December 2000 and service entry in May 2001.

The RJX was formally launched on March 21 2000 (somewhat later than envisaged when the program was announced). Assembly of the first RJX, an RJX85, began before formal launch in March 2000, and the first flight was made April 28 2001. The RJX100 followed with the first flight made on September 23 2001.

The RJX''s AS977 powerplant is a two spool design with dual FADEC, and compared with the LF-507 of the Avro RJ it replaces, it claimed to produce 5% more thrust in the climb, 15% lower fuel burn, 20% lower direct engine operating costs, lower emissions, and even quieter noise levels. The RJXs would have an up to 17% range increase and a 227kg (500lb) empty weight reduction over the RJs.

Like the earlier Avro RJ and BAe-146, the RJX family was offered in three sizes, the 70 seat RJX70, 85 seat RJX85 and 100 seat RJX100. The airframes are unchanged from the corresponding RJ models apart from the engine nacelles and pylons (supplied by GKN Westland). BAE Systems calls the engine, nacelle, pylon and associated accessories package the IPPS (Integrated Power Plant System). Like the RJ, the RJX was also offered as the Avro Business Jet.

However, in the wake of BAE Systems'' post September 11 concerns of poor sales prospects, the whole RJX program was cancelled on November 27 2001. Only one RJX85 and two RJX100s had flown by then. The RJX85 was parted out at Woodford, and the prototype RJX100 was transferred to the Heritage Aircraft Park at Manchester airport, and the fuselage of the second one became stored at Woodford. Some incomplete aircraft were scrapped. Just 14 aircraft had been ordered prior to program cancellation.',NULL,'Operational'),
('beagleb121pup','The Pup was one of two new designs to be produced by the British Executive and General Aviation Ltd or Beagle company, which was formed in October 1960 following the merger of Auster and Miles. 

The Pup evolved from the Miles M-117 project, which was to have made extensive use of plastics. A range of (conventional construction) Pups was planned, from a 75kW (100hp) two seat trainer through to retractable undercarriage four seaters, a light twin and a fully aerobatic 155kW (210hp) military trainer, the Bull Pup. All would have featured metal construction. 

The Pup made its first flight on April 8 1967 and deliveries of the initial Pup 100 began a year later in April 1968. The Pup is one of the few light aircraft to feature control sticks and not control columns. 

In the meantime Beagle had flown the first of the more powerful Pup 150s in October 1967. The 150 featured a 110kW (150hp) engine, as the designation reflects, and seating for an extra adult. 

Another more powerful variant originally designed in response to an Iranian Civil Air Training Organisation requirement was the Pup 160. The Pup 160 featured a 120kW (160hp) IO-320 Lycoming, but only nine were built. 

Continuing financial difficulties finally forced Beagle to close its doors in January 1970 after building 152 Pups, despite holding orders for an additional 276. As a result plans for the extended Pup based family came to nought. A further 21 near complete were subsequently assembled. 

The B-125 Bulldog military basic trainer development first flew in May 1969. Scottish Aviation (which took over the design following Beagle''s collapse) built 328 150kW (200hp) Lycoming IO-360 powered Bulldogs for a number of air forces, including Britain''s Royal Air Force. Scottish Aviation became part of British Aerospace in the late 1970s.',NULL,'Operational'),
('beagleb206','The cabin class Beagle B.206''s origins lie in a late 1950s Bristol project for a four seat twin. 

Although not built, the Bristol 220 evolved into one of Beagle''s first and few designs to reach production. The prototype of the new twin engine design, known as the B.206X, made its first flight on August 15 1961. A five/six seater powered by two 195kW (260hp) Continental IO470 engines, it was considered too small by its creators, and the design grew into the B.206Y with 230kW (310hp) Continental GIO470 engines, greater wing span, a larger cabin with increased seating capacity, greater fuel capacity and increased weights. 

This allowed it to meet a Royal Air Force requirement for a communications aircraft capable of transporting a Vbomber support crew. Twenty were ordered for this role in place of the originally planned buy of 80, selected in preference to the de Havilland Dove. In RAF service the B.206 was designated the CC.1 Basset. Basset deliveries began in May 1965. 

Following the B.206Y were two evaluation B.206Z aircraft, then the initial civil production version, the Series 1 B.206C. Poor hot and high performance was in part responsible for slow sales and so Beagle designed the Series 2 B.206S with more powerful turbocharged GTSIO520 engines. The B.206S also introduced a slightly revised cabin to seat eight with the entry door repositioned from above the wing to the rear port side fuselage. 

A commuter airliner development was also built in prototype form, the 10 seat Series 3 which a featured a further enlarged cabin. Flown in prototype form, the design died when Beagle entered liquidation in early 1970.',NULL,'Operational'),
('beech18','Beech''s most successful airliner, more than 9000 Beech 18s were built over an uninterrupted three decade long production run, and while many of those were built against wartime military contracts, vast numbers went on to see civil service. 

The prototype Beech 18 first flew on January 15 1937. The design followed conventional design wisdom at the time, including twin radial engines, metal construction and taildragger undercarriage, while less common were the twin tail fins. Early production aircraft were either powered by two 225kW (300hp) Jacobs L6s or 260kW (350hp) Wright R760Es. The Pratt & Whitney Wasp Junior became the definitive engine from the prewar C18S onwards. 

The demands of World War 2 significantly boosted the already successful Beech 18''s fortunes, with 5000 built as C45s for the US Army Air Force for use as transports and multi engine pilot trainers. 

Postwar, large numbers of C45s entered civil service, while Beech resumed production of the C18S. Progressive development resulted in the D18S of 1946, the Continental powered D18C of 1947, the E18S of 1954, the G18S from 1959 and the H18 with optional tricycle undercarriage from 1962. Beech production ceased in 1969. 

The Beech 18 has also been the subject of numerous conversions. Volpar has offered tricycle undercarriage conversions, conversions with TPE331 turboprops and stretched and TPE331 powered conversions (described in the specifications above). Hamilton meanwhile converted Beech 18s as Westwinds with Pratt & Whitney Canada PT6 turboprops and also offered stretches.',NULL,'Operational'),
('beech192324musketeersierrasportsundowner','Beechcraft developed the Musketeer family as a lower cost, lower performance four seater below its Bonanza, which would compete with the Cessna 172 and Piper Cherokee. 

The prototype O-320 powered Musketeer flew in October 1961 and Beech added the type to its sales range in 1962. A series of continual product updating followed, resulting in the aircraft in its final Sierra form being very different to the original Musketeer. The first improved model was the A23 Musketeer II with a 125kW (165hp) Continental IO346 engine (later replaced with a Lycoming O360 in the B23). 

The A23 was further developed into a three aircraft family (dubbed the Three Musketeers by Beech marketing) - the A23A Musketeer Custom III with greater max takeoff weight, the reduced MTOW A2319 Musketeer Sport III trainer with a 110kW (150hp) Lycoming O320, and the 150kW (200hp) IO360 powered and increased MTOW Musketeer Super III. From 1970 these three introduced a more rounded fuselage and were renamed the Musketeer B19 Sport, C23 Custom and A24 Super respectively. 

A retractable undercarriage variant of the Super is the A24R Super R. The Musketeer name was dropped in 1971, with the Custom renamed the Sundowner, and Super R the Sierra, and the Musketeer Sport becoming simply the Sport. The Sierra underwent significant changes for the 1974 model with a new cowling, quieter engine and more efficient prop. Further aerodynamic clean ups were introduced in 1977. Series production ended in 1983. 

 

 

 International Directory of Civil Aircraft',NULL,'Operational'),
('beech2000starship1','Despite its extensive use of modern technologies and innovative design the Starship was a commercial failure. 

Conceived as a new generation light corporate transport in the King Air class, the Starship traces back to the 85% scale proof of concept demonstrator built by Scaled Composites, which first flew in August 1983. The prototype Starship 2000 proper made its first flight on February 26 1986, provisionally powered by PT6A65 turboprops. A second prototype equipped with Collins avionics entered the flight test program in June 1986, while a third development aircraft took flight in January 1987. Initial US FAA certification was awarded on June 14 1988, while the first production example was flown on April 25 1989. 

The unconventional Starship design incorporates many innovations. Foremost of these is its rear mounted laminar flow wing and variable geometry canards or foreplanes. The foreplanes sweep forward with flap extension for pitch trim compensation, designed to make it impossible for the Starship to stall on takeoff or landing. 

The wing itself is constructed almost entirely of composites (something which attracted much criticism because of the associated difficulties of inspecting it thoroughly), and has tip mounted tails. The rear mounted engines are in a pusher arrangement, being behind the cabin noise is reduced, while their relatively close proximity to each other also improves single engine handling. The EFIS flightdeck has Collins avionics with early generation colour and monochrome CRTs. 

The improved Starship 2000A was certificated in April 1992. It introduced changes including seating for six instead of eight, a slightly higher max takeoff weight and increased range. 

A lack of customer interest forced Beech to terminate Starship production in early 1995 after just 53 had been built (including three prototypes), a somewhat inglorious end to a technologically innovative and promising design.',NULL,'Operational'),
('beech35bonanza','The distinctive Model 35 Bonanza is one of general aviation''s most famous and prolific types, and enjoyed a production life spanning four decades. 

The Bonanza first flew on December 22 1945. Featuring metal construction, retractable undercarriage and high performance, it heralded a new class of high performance GA aircraft. The design also featured the distinctive Vtail, incorporated for aerodynamic efficiency and reduced weight. Deliveries of production aircraft began in 1947. 

Subsequent development led to a significant family of subtypes. Briefly these are the A35 of 1949 with a greater max takeoff weight; the B35 with a 146kW (196hp) E1858 engine; the 153kW (205hp) E18511 powered C, D and E models through to 1954; the F and G35 with third cabin window and 170kW (225hp) E2258 of the mid fifties; the 180kW (240hp) Continental O470G powered H35 of 1957; the fuel injected 187kW (250hp) powered J35; 1960''s M35 with larger rear windows; and the N35 and P35 with a 195kW (260hp) IO470N and greater max takeoff weight. 

Then followed the redeveloped S35 of 1964 with six seats and redesigned rear cabin, optional three blade prop, 215kW (285hp) IO520B engine and yet greater weights; the heavier V35 of 1966; and turbocharged V35TC; V35A and V35ATC of 1968 with more raked windscreen; and the V35B and V35BTC (just seven built) from 1970. The V35B remained in production until 1982 and underwent a number of detail changes in that time.',NULL,'Operational'),
('beech60duke','Between the Beech Baron and Queen Air in size, performance and general capabilities, the Duke was a pioneer in the pressurised high performance light business twin class. 

Beechcraft began design work on its new Model 60 in early 1965, with the first flight of the prototype occurring the following year on December 29. US FAA Certification was awarded on February 1 1968. 

Design features of the Duke include turbocharged Lycoming TIO541 engines driving three blade propellers and a 0.32 bars (4.6psi) cabin pressure differential. The airframe was based loosely on the Baron''s wing and undercarriage, plus a new fuselage employing bonded honeycomb construction. Optional fuel tanks in the wings were offered, increasing range. 

Deliveries of the initial 60 model began in July 1968. Further development led to the improved A60. Appearing in 1970 it introduced an enhanced pressurisation system and longer life yet lighter turbochargers which increased the maximum altitude at which the engine could deliver maximum power, thus improving performance. 

The definitive model of the Duke family is the B60. New interior arrangements and more improvements to the turbochargers were the main changes to this model, which first appeared in 1974. Production ceased in 1982. 

Since its appearance the Duke has been regarded as something of a hot ship, with its high performance in a relatively small package the main attraction. However, this image did not translate into anything other than modest sales because of the Duke''s relatively complex systems (turbochargers and pressurisation among them) and high operating costs.',NULL,'Operational'),
('beech65708088queenair','The versatile Queen Air is Beech''s largest and heaviest piston twin apart from the WW2 era radial powered Beech 18. 

The prototype Model 65 Queen Air made its first flight on August 28 1958, with deliveries of production aircraft in late 1960 marking the beginning of a production run that would last almost two decades. This first model combined the wings, undercarriage, Lycoming engines and tail surfaces of the Model E50 Twin Bonanza with a new and substantially larger fuselage. A Queen Air 65 established a new class altitude record of 34,882ft in 1960. 

Many variants subsequently followed, including the 3630kg (8000lb) max takeoff weight Model 80 with more powerful 285kW (380hp) engines and swept fin and rudder. This model evolved into the A80, the first to be offered as a commuter airliner. Introduced in 1964, the A80 had a redesigned nose and interior, increased wing span and a 227kg (500lb) greater takeoff weight. The pressurised 88 had round windows and the longer wingspan of the A80 and a 3992kg (8800lb) MTOW. 

The Model B80 was the last major production model and appeared in 1966. It featured the longer span wing and the 88''s MTOW. The model A65 was essentially a Model 65 with the swept fin and rudder of the Model 80, and entered production in 1967. The Model 70 entered production in 1969, it featured the longer span wings, 3720kg (8200lb) MTOW and 255kW (340hp) engines. Production of the Queen Air ceased in 1977.',NULL,'Operational'),
('beech76duchess','The Model 76 Duchess was one of a new class of light four place twins developed in the mid 1970s. 

The prototype of the Duchess, designated the PD-289, made its first flight in September 1974. However a further 30 months of development work passed before the first production Model 76 took to the air on May 24 1977. Certification was granted in early 1978, with first deliveries commencing in that May.

The Duchess was positioned between the Bonanza and the Baron in the Beechcraft model range. Beech developed it for its Beech Aero Centers, and pitched it at the personal use light twin, light charter and multi engine training markets. Design aims included good low speed and single engine handling.

Aside from the prototype PD-289, no variations of the Duchess 76 were built before production ended in 1982. All Duchesses therefore feature two Lycoming O-360 engines (with counter rotating propellers), a T-tail (incorporated to reduce control forces and improve elevator response), entry doors on either side of the cabin and electric trim and flap controls (the prototype PD-289 featured manually operated flaps). The fuselage was based loosely on the single engine Sierra''s, and like the Sierra and its Musketeer predecessors featured a bonded honeycomb construction wing. The Sierra and Duchess also share common structural components.

Beech offered three factory option packages on the Duchess - the Weekender, Holiday and Professional - and 11 factory installed avionics packages.

Beech developed the Duchess for low cost, high volume production, but the falling popularity of light twins, an economic recession and crippling product liability laws in the USA all contributed to a relatively short production run which wound up in 1982. Sales had peaked in 1979 when 213 were built. 

Like its contemporaries the Grumman/Gulfstream American Cougar and Piper Seminole, the Duchess'' success was hampered through unfortunate timing. Ever increasing advances in engine efficiency, safety and reliability led to a rise in popularity for big high performance singles such as Beech''s own Bonanza series, which lacked the maintenance overheads of two engines, but had comparable performance. However, to a greater extent than the Seminole and Cougar, the Duchess enjoyed some success as a twin engine pilot trainer, a role in which it is widely used for today.',NULL,'Operational'),
('beech77skipper','Beech developed the Skipper as a low expense two seat trainer in response to the growing costs (mainly fuel) of pilot training in the mid 1970s. 

Starting life as the Beech PD (for Preliminary Design) 285, the new Skipper was intended to be a simple and cost effective new generation pilot training aircraft combining low purchasing and operating costs with lightweight but sturdy construction. A PD-285 prototype first flew on February 6 1975, but this differed from production aircraft in that it was powered by a 75kW (100hp) Continental O-200 engine and featured a conventional low set tailplane. 

Protracted development meant that the first of the definitive Model 77 Skippers did not fly until September 1978, by which time the 85kW (115hp) Lycoming O-235 engine and T-tail had been settled upon. In the Beech product line-up the Skipper was to replace the two seat Model 19 Sport variant of the Musketeer family, production of which ended in 1978. 

US FAA certification for the Skipper was awarded in April 1979, and the first production aircraft were delivered in May 1979 to Beechcraft''s own Beech Aero Center pilot training centres.

Production lasted just three years until mid 1981 (at the time Beech said the halt in production was a "suspension" pending an improvement in market conditions). During that time little more than 300 Skippers had been built (at a rate of about 10 per month). Unsold Skipper stocks kept the type available for a further year. 

The Skipper was in direct competition with Piper''s very successful PA-38 Tomahawk and Cessna''s 152. The Tomahawk was developed in a very similar time scale to the Skipper (entering service in early 1978) and both aircraft share a T-tail, low wing and canopy style cabin configuration (with 360° all round vision and a door on each side), and the Lycoming O-235 powerplant. Of the three the Skipper was the least successful, being comfortably outsold by the Cessna and Piper products. 

Other features of the Skipper design are a NASA developed GA(W)1 high lift wing (the result of joint NASA and Beech research into high lift, supercritical aerofoils), bonded metal construction, tubular spars, and flap and aileron actuation by torque tubes rather than the more conventional cable and pulley system. New construction techniques were intended to reduce manufacturing costs.',NULL,'Operational'),
('beech99airliner','The Beech 99 is an evolution of the successful Queen Air/King Air series, and shares the King Air''s basic powerplant and layout, but otherwise is a new design, with a significantly lengthened cabin with greater seating capacity. 

Design of the 99 began in the late 1960s, in part to find a replacement for the venerable Beech 18. In December 1965 a stretched fuselage Queen Air was flown for the first time, while the Pratt & Whitney Canada PT6 powered prototype model 99 made its first flight in July 1966. The first customer aircraft was delivered in May 1968, the series then known as the Commuter 99. At the time the 99 was Beech''s largest aircraft yet and Beech was optimistically forecasting a production rate of 100 per year. 

Subsequent models were the A99, A99A and B99, with differing powerplants, submodels and weights. The B99 was available in two variants, the B99 Airliner and the B99 Executive, a corporate transport version with seating for between eight and 17 passengers. 

Production of early models was halted in 1975, and it was not until 1979 that the improved C99 Commuter (plus the larger 1900, described separately) was announced as part of Beech''s return to the commuter airliner market. A converted B99 fitted with P&WC PT6A34 engines served as the C99 prototype, and flew in this form for the first time on June 20 1980. 

Production aircraft featured PT6A36 engines, and deliveries recommenced following certification, both in July 1981. Shortly afterwards it became known as the C99 Airliner. 

C99 production ceased in 1986.',NULL,'Operational'),
('bell204205214b','The Bell Model 204B and 205A1 are the civil counterparts to the highly successful UH1B and UH1H Iroquois military helicopters. 

Bell designed the Model 204 in response to a 1955 US Army requirement for a multi-purpose utility helicopter. The 204 was something of a quantum leap forward in helicopter design as it was one of the first to be powered by a turboshaft. The turboshaft engine radically improved the practicality of the helicopter because of its lower maintenance and operating costs, lower fuel consumption, light weight and high power to weight ratio. The use of a turboshaft in the 204 allowed it to carry a useful payload over respectable ranges and at reasonable speeds, which resulted in the 204 and 205 becoming the most successful western helicopter series in terms of numbers built. 

The UH1B, from which the 204B was derived, was first delivered March 1961. The subsequent Model 205A1 is based on the UH1H, which, when compared to the B model, is greater in length and capacity, has better performance and a more powerful engine. 

In civil guise the 204 and 205 have been operated in a number of utility roles including aerial cranes and firebombing. 

The 214A & C were developed for Iran from the 214 Huey Plus (an improved version of the 205), powered by a massive 2185kW (2930shp) Lycoming LTC4B-8D (with more than twice the power of the 205''s T53). Iran''s Army took delivery of 287 214A Isfahan troop carrier and supply transport helicopters during the 1970s, while another 39 were delivered as 214C SAR helicopters. A commercial derivative, the 214B BigLifter, powered by a 1185kW (2930shp) Lycoming T5508D turboshaft, was built in smaller numbers for civil customers through to 1981. Its main use is as an aerial crane.',NULL,'Operational'),
('bell206jetranger','The JetRanger series has become the definitive turbine powered light utility and corporate helicopter of the past three decades. 

The JetRanger can trace its lineage back to an unsuccessful contender for a US Army competition for a light observation helicopter, which was won by the Hughes 500. This first Model 206 made its first flight on December 8 1962, while the following civil 206A, powered by a 235kW (317shp) Allison C18A, followed, flying on January 10 1966. Deliveries of the first production JetRangers began late in that same year. 

In the early 1970s production switched to the Model 206B JetRanger II with a 300kW (400shp) 250C20 turboshaft, while conversion kits to upgrade earlier As to the new standard were made available. The third major variant of the JetRanger is the 315kW (420shp) 250C20B powered JetRanger III, with first deliveries commencing in late 1977. Once again Bell offered a conversion kit to update earlier JetRangers to the new standard. Other features introduced on the JetRanger III were a larger and improved tail rotor and minor modifications. 

JetRanger production was transferred from Texas to Mirabel in Canada in 1986, where the current production model remains the 206B3 JetRanger III. 

The JetRanger was also accepted by the US Army as an observation helicopter as the OH58 Kiowa, and variants of the Kiowa remain in production in the USA. Military 206Bs were also built in Australia for the Australian Army, where plans were also held to build civilian 206Bs for the Australian market under license, but these fell through.',NULL,'Operational'),
('bell206llongranger','Bell developed the LongRanger to offer a light helicopter with greater capacity and utility over the JetRanger. 

Bell announced it was developing a stretched JetRanger in September 1973, the subsequent Model 206L flew for the first time on September 11 1974, and production began in early 1975. The LongRanger seats a further two passengers compared to the JetRanger, and introduced a more powerful engine and NodaMatic transmission suspension system for greater passenger comfort. 

Subsequent versions have been the 206L1 LongRanger II, introduced in 1978, the 206L3 LongRanger III, and the current 206L4 LongRanger IV, introduced in 1992. Each subsequent version features increasingly more powerful engines and other minor improvements. LongRanger production, along with the JetRanger, was transferred to Mirabel in Canada in 1986. 

The LongRanger has found favour not only as a corporate transport, but with police and medical services worldwide, its extra cabin size providing a very useful increase in utility. Bell currently offers a twin engined LongRanger, the TwinRanger, while a US company offers the twin engine Gemini ST conversion of the LongRanger. It also forms the basis of the 407.',NULL,'Operational'),
('bell206lttwinrangertridairgeminist','Bell''s 206LT TwinRanger, is, as its name suggests, a new build twin engined development of the 206L LongRanger, while Tridair helicopters in the USA offers its twin engine Gemini ST conversion for existing LongRangers. 

The name TwinRanger predates the current 206LT to the mid 1980s when Bell first looked at developing twin engine version of the LongRanger. The Model 400 TwinRanger did fly (maiden flight was on April 4 1984) and it featured two Allison 250 turboshafts, the four blade main rotor developed for the military Bell 406/OH58 Kiowa and a reprofiled fuselage, but development was later suspended. 

The current 206LT TwinRanger is based on Tridair Helicopters'' Gemini ST conversion program. Tridair announced it was working on a twin engine conversion of the LongRanger in 1989, and the prototype flew for the first time on January 16 1991. Full FAA certification was awarded in November and covers the conversion of LongRanger 206L1s, L3s and L4s to Gemini ST configuration. 

In mid 1994 the Gemini ST made history when it was certificated as the first Single/Twin aircraft, allowing it to operate either as a single or twin engine aircraft throughout all phases of flight. This unique certification allows it to operate with a single engine for maximum economy (for ferrying etc), with the extra redundancy and performance of a twin available when required. 

Bell''s 206LT TwinRanger is a new build production model equivalent to Tridair''s Gemini ST and based on the LongRanger IV. The first example was delivered in January 1994. The TwinRanger will be replaced by the 427 which is currently under development.',NULL,'Operational'),
('bell212twintwotwelve','The Model 212 is a twin engined development of Bell''s earlier and highly successful Model 204 and 205 series. 

Bell announced its decision to develop the Model 212 in early May 1968 in large part in response to a Canadian Armed Forces requirement for a twin engined development of the CUH1H (Model 205) then entering military service in that country, and following successful negotiations with Pratt & Whitney Canada and the Canadian government. Development of the Model 212 was a joint venture between Bell, Pratt & Whitney Canada and the Canadian government, the latter providing financial support. The resulting helicopter (designated CUH1N in Canadian and UH1N in US military service) first flew in 1969 and was granted commercial certification in October 1970. The first Canadian CUH1Ns were handed over in May 1971. 

The most significant feature of the Twin TwoTwelve is the PT6T Twin-Pac engine installation. This consists of two PT6 turboshafts mounted side by side and driving a single output shaft via a combining gearbox. The most obvious benefit of the new arrangement is better performance due to the unit''s increased power output. However, the Twin-Pac engine system has a major advantage in that should one engine fail, sensors in the gearbox instruct the remaining operating engine to develop full power, thus providing a true engine out capability, even at max takeoff weight. 

Aside from the twin engines, the 212 features only minor detail changes over the earlier Model 205 and UH1H, including a slightly reprofiled nose. The 212 is also offered with a choice of IFR or VFR avionics suites. Production was transferred to Bell''s Canadian factory in August 1988.',NULL,'Operational'),
('bell214stsupertransport','Despite sharing a common model number with the 214 Huey Plus and Big Lifter (described separately), the Bell 214ST is a larger, much modified helicopter. 

Bell''s biggest helicopter yet was developed to meet an Iranian requirement for a larger transport helicopter with better performance in its hot and high environment than its 214 Isfahans. Bell based its proposal on the 214 but made substantial design changes, resulting in what is essentially an all new helicopter with little commonality with the smaller 214 series. 

The 214ST features two General Electric CT7 turboshafts (the commercial equivalent of the military T700), a stretched fuselage seating up to 17 in the main cabin, glassfibre main rotor blades, and lubrication free elastomeric bearings in the main rotor hub. The ST suffix originally stood for Stretched Twin, reflecting the changes over the 214, but this was later changed to stand for Super Transporter. 

The 214ST was to have been built under licence in Iran as part of that country''s plans to establish a large army air wing (other aircraft ordered in large numbers under this plan were the 214A Isfahan and AH1J SeaCobra), but the Islamic revolution and fall of the Shah in 1979 put paid to these plans. 

Undeterred, Bell continued development of the 214ST - which first flew in February 1977 - for civil and military customers. Three preproduction 214STs were built from 1978 and 100 production aircraft were built through to 1990. 

Most 214ST sales were to military customers. Iraq was the 214ST''s largest customer, taking delivery of 45 during 1987 and 1988, some most likely seeing service in the Gulf War. 

Civil applications for the 214ST are numerous, including oil rig support, where its twin engine configuration and 17 passenger main cabin are useful assets.',NULL,'Operational'),
('bell222230','Bell announced development of the all new 222 twin in 1974, following the positive response generated by a mockup proposal displayed at that year''s Helicopter Association of America convention. 

Having taken note of potential customers'' preferences and suggestions, Bell modified its design accordingly, and the subsequent development effort led to the Model 222''s first flight in August 1976. A number of advanced features were designed into the 222, including the Noda Matic vibration reduction system developed for the 214ST, stub wings housing the retractable undercarriage, provision for IFR avionics, and dual hydraulic and electrical systems. 

The 222 was awarded FAA certification in December 1979. Production deliveries commenced in early 1980. Subsequent development led to the more powerful 222B with a larger diameter main rotor, introduced in 1982, and the essentially similar 222UT Utility Twin, which features skid landing gear in place of wheels. 

The Bell 230 is a development of the 222 with two Allison 250 turboshafts instead of the 222''s LTS 101s plus other refinements. First flight of a 230, a converted 222, took place on August 12 1991, and Transport Canada certification was awarded in March 1992. The first delivery of a production 230 occurred that November and customers had a choice of skid or wheel undercarriage. Production ceased in 1995. The 230 has been replaced by the stretched, more powerful 430, described separately.',NULL,'Operational'),
('bell407','Bell''s already popular 407 is the long awaited successor to its JetRanger and LongRanger light singles. 

Development work on Bell''s New Light Aircraft replacement for the LongRanger and JetRanger dates back to 1993. The end result was the 407, an evolutionary development of the LongRanger. 

A modified 206L3 LongRanger served as the concept demonstrator 407 and first flew in this form on April 21 1994, while the 407 was first publicly announced at the Las Vegas HeliExpo in January 1995. 

The 407 concept demonstrator mated the LongRanger''s fuselage with the tail boom and dynamic system of the military OH58D Kiowa (which has a four blade main rotor). Fake fairings were used to simulate the wider fuselage being developed for the production standard 407. The first preproduction 407 flew in June 1995, the first production 407 flew in November 1995. Customer deliveries commenced the following February. 

Compared with the LongRanger, the 407 features the four blade main rotor developed for the OH58, which uses composite construction, and the blades and hub have no life limits. Benefits of the four blade main rotor include improved performance and better ride comfort. 

Another big change over the LongRanger is the 18cm (8in) wider cabin, increasing internal cabin width and space, plus 35% larger main cabin windows. Power is from a more powerful Allison 250C47 turboshaft fitted with FADEC, allowing an increase in max takeoff weight and improving performance at hotter temperatures and/or higher altitudes. The tail boom is made from carbonfibre composites, while Bell has studied fitting the 407 with a shrouded tail rotor. 

Bell looked at the 407T twin 407 for a time, but opted instead to develop the substantially revised twin PW206D powered 427.',NULL,'Operational'),
('bell412','The 412 family is a development of the 212, the major change being an advanced smaller diameter four blade main rotor in place of the 212''s two blade unit. 

Development of the 412 began in the late 1970s and two 212s were converted to the new standard to act as development aircraft for the program. The first of these flew in August 1979, and the 412 was awarded VFR certification in January 1981. That same month the first delivery occurred. Subsequent development led to the 412SP, or Special Performance, with increased fuel capacity, higher takeoff weight and more optional seating arrangements. The 412HP, or High Performance, superseded the 412SP in production in 1991. Features include improved transmission for better hovering performance. 

The current standard production model is the 412EP, or Enhanced Performance. The 412EP features a PT6T3D engine and a dual digital automatic flight control system fitted as standard, with optional EFIS displays. Fixed tricycle landing gear is optional. 

Meanwhile in Indonesia, IPTN has a licence to build the 412SP, which it calls the NBell412. IPTN has a licence to build up to 100 NBell412s. 

Like the 212, the 412 is in widespread use for a number of utility roles, including EMS and oil rig support, its twin engine configuration being an asset, particularly in the latter role. It too is in military service, Canada once again being a major customer (including 100 recently delivered 412EP based CH-146 Griffons).',NULL,'Operational'),
('bell427','Bell''s latest helicopter, the 427 is a replacement for the 206LT TwinRanger and the cancelled 407T, which was to be a twin engine 407 (described separately). 

When Bell first looked at a twin engine version of its new 407 light single, the company originally anticipated developing the 407T which would have been a relatively straightforward twin engine development (with two Allison 250-C22Bs). However, Bell concluded that the 407T would not offer sufficient payload/range performance, and so began studies of a new light twin. 

The result was the all new 427, which Bell announced at the Heli Expo in Dallas in February 1996. Prior to this announcement Bell had signed a collaborative partnership agreement with South Korea''s Samsung Aerospace Industries covering the 427. Samsung''s role on the 427 program is significant, the South Korean company builds the 427''s fuselage and tailboom, and may later assemble any 427s sold in South Korea and China at its Sachon plant. (Samsung also builds the left and right fuselage halves and the tailboom for the Bell 212 and 412). Bell builds the 427''s flight dynamics systems at Fort Worth in Texas, with final assembly at Bell''s Mirabel, Quebec plant. 

The 427 was the first Bell designed entirely on computer (including using CATIA 3D modelling). Compared to the 407 the 427''s cabin is 33cm (13in) longer, is largely of composite construction amd lacks the roof beam which obstructs the cabin on the 206/206L/407. 

Power is from two FADEC equipped Pratt & Whitney Canada PW-206 turboshafts, driving the composite four blade main rotor and two blade tail rotor (based on those on the OH-58D Kiowa and Bell 407) through a new combining gearbox. The main rotor''s soft-in-plane hub features a composite flexbeam yoke and elastomeric joints, eliminating the need for lubrication and any form of maintenance. The 427''s glass cockpit features an integrated instrument display system (IIDS). A hinged main cabin door is standard but a sliding door is optional. 

First flight was on December 11, 1997 and Canadian certification was awarded on November 19, 1999. First customer deliveries followed US certification in January 2000. US FAA dual pilot IFR certification was awarded in May 2000.',NULL,'Operational'),
('bell430','Bell''s 430 intermediate twin helicopter is a stretched and more powerful development of the 230. 

Bell began preliminary design work on the 430 in 1991, even though the 230 itself had only flown for the first time in August that year. The 430 program was formally launched in February 1992. Two prototypes were modified from Bell 230s, and the first of these flew in its new configuration on October 25 1994. The second prototype featured the full 430 avionics suite, its first flight was on December 19 1994. 

The first 430 production aircraft was completed in 1995, while Canadian certification was awarded on February 23 1996, allowing first deliveries from mid that year. Meanwhile 230 production wound up in August 1995, making way for the 430. 

Compared with the 230, the 430 features several significant improvements. Perhaps the most important of these is the new four blade, bearingless, hingeless, composite main rotor. Other changes include the 46cm (1ft 6in) stretched fuselage, allowing seating for an extra two passengers, 10% more powerful Allison 250 turboshafts (with FADEC) and an optional EFIS flightdeck. As well as the optional EFIS displays the 430 features as standard a RogersonKratos Integrated Instrument Display System (IIDS), comprising two LCD displays to present engine information. The 430 is offered with skids or retractable wheeled undercarriage. 

Between August 17 and September 3 1996 Americans Ron Bower and John Williams broke the round the world helicopter record with a Bell 430, flying westwards from England. 

 

 

 International Directory of Civil Aircraft',NULL,'Operational'),
('bell47','The familiar and distinctive Bell 47 is an especially significant aircraft as it was one of the world''s first practical helicopters. 

The ubiquitous Bell 47 dates back to Bell''s Model 30 of 1943, an experimental helicopter evaluated by the US Army (10 were ordered for that service). The first subsequent prototype Bell Model 47 (with a car type cabin and two seats) first flew on December 8 1945. In May 1946, this early model Bell 47 became the first civil helicopter in the world to gain civil certification. 

The first civil variants to see production were the similar Model 47B, and the 47B3 with an open cockpit. The 47D followed and was the first model to feature the famous `goldfish bowl'' canopy and the distinctive uncovered tail boom. The Model 47E was similar but powered by a 150kW (200hp) Franklin engine. 

The definitive Model 47G followed the 47E into production in 1953, and it was this variant, in a number of successively more powerful versions, that remained in production until 1974, testament to the utility and success of Bell''s basic design. The 47G had optional metal rotor blades and was powered by a range of Lycoming engines outputting 150 to 210kW (200 to 280hp). 

The Model 47H is based on the 47G, but with a fully enclosed fuselage and conventional cabin, and formed the basis for the 47J Ranger. The Ranger had a further enlarged cabin for four, and entered production in 1956. The 47J2 Ranger introduced powered controls and metal blades as standard, and was powered by a 195kW (260hp) VO540. 

Kawasaki in Japan licence built a development of the 47G, the KH4 with more traditional style enclosed cabin',NULL,'Operational'),
('bellagustaba609','The Bell BA 609 is set to become the first civil application of the revolutionary tiltrotor technology, taking advantage of its experience with the military V22 Osprey. 

Bell pioneered the tiltrotor concept with the experimental XV3 which first flew as early as 1957 and then with NASA developed the XV15 experimental demonstrator which first flew in 1977. In conjunction with Boeing it is building the military V-22 Osprey - the first production Ospreys are due to be delivered to the US Marines in 1999. 

In late 1996 Bell and Boeing announced that they intended to use their expertise and experience with the V22 to develop a nine seat civil tiltrotor. The Bell Boeing 609 was formally unveiled on November 18 1996. However in early 1998 Boeing announced its withdrawal from the program as a risk sharing partner to remain as a major subcontractor. Then in September that year Bell announced that Agusta would become a risk sharing development partner in the redesignated BA 609. Agusta will participate in BA 609 development, manufacture components and assemble BA 609s for European and other markets. 

First flight for the BA 609 is planned for mid 1999 with certification and first deliveries scheduled for April 2002. (The US FAA is drawing up a new certification category for tiltrotors and a new pilot type rating.) 

The benefits of a tiltrotor are that it has the vertical takeoff, landing and hovering abilities of a helicopter combined with fixed wing turboprop speed and performance. As such Bell anticipates that the 609 will compete against helicopters such as the Sikorsky S76 and turboprops such as Beech''s King Air. As well as point to point corporate transport Bell envisages that the 609 will be used for offshore oil rig support, search and rescue and medevac missions, where its unique capabilities would be particularly useful. 

The 609 will incorporate advanced technologies such as a glass cockpit, flybywire flight controls and a composite construction fuselage. Power will be from two PT6C67A turboprops. 

The 609 could form the basis for a family of civil tiltrotors.',NULL,'Operational'),
('berievbe200','The Beriev Be200 jet powered multirole amphibian is based on the larger military A40 Albatross. 

Beriev has extensive experience in building large amphibious aircraft. The turboprop ASW Be12 Tchaika was built in fairly large numbers from the mid 1960s (approx 150) for the Soviet navy. The Be42 Albatross jet meanwhile (which has the NATO reporting name `Mermaid'') first flew in prototype form in December 1986 and is being developed for the Russian navy for maritime surveillance and ASW. 

The Be200 is based on the Be42 and it uses many of the design features and technologies developed for the Be42, but is smaller overall and designed for civil roles, in particular firefighting. Aerodynamically the Be200 is very similar to its larger forebear, with the same overall proportions. The all metal hull design is based on the Be42''s, and the Be200 has a mildly swept wing with winglets, above fuselage mounted turbofan engines and a swept Ttail. 

The airframe is strengthened to cope with the demands of water operations and firebombing and there is some use of advanced aluminium lithium alloys. The two crew flightdeck features an ARIA2000 EFIS avionics suite (ARIA is a collaboration between the Russian avionics research institute and AlliedSignal). The ARIA2000 suite includes specialist firefighting functions including an automatic glidescope and water source/drop zone memorisation. 

Design work on the Be-200 began in 1989. It is being developed by Betair, a collaboration between Beriev and Irkutsk in central Russia where the aircraft will be built, Swiss company ILTA Trade Finance, which is providing marketing and financing support, and other partners. 

The Be200 is being built to meet western certification requirements. After a number of delays the first flight took place on September 24 1998 from Irkutsk Aviation Production Organisation''s airfield in Irktusk, Siberia.',NULL,'Operational'),
('berievbe3032','The Beriev Be-32 is an upgraded development of the Be-30 commuter that was originally developed for Aeroflot in the late 1960s. 

The Beriev Be-30 was designed against an Aeroflot requirement for a twin turboprop airliner and utility transport in the late 1960s as a replacement for the Antonov An-2 on low density routes, or where airfields were inadequate for larger aircraft. 

The prototype Be-30 first flew on March 3 1967, temporarily powered by two 550kW (740hp) ASh-21 piston radial engines. These engines were replaced by 723kW (970shp) TVD-10 turboprops, with which the first flight was made on July 13 the same year. The prototype was displayed statically at the Domodedovo air show in July 1967. Two other prototypes were also built. The Be-30 had accomodation for 14 passengers. The aircraft was further developed into the Be-32, which had higher powered TVD-10B engines, and accomodation for up to 17 passengers. It is reported that eight production aircraft were manufactured, between 1968 and 1976, three at the experimental factory No.49, and five at the Taganrog factory No.86. It is thought however that the first three are the prototype Be-30s, and the next five the (pre)production Be-32s. The airplane was thoroughly tested in many different regions in Russia under various operating conditions. In the mid seventies Beriev used the Be-32 to claim two time-to-height records (3000m in 2min 24.8sec, 6000m in 5min 18sec). NATO assigned the code name Cuff to the Be-30/32.  

The Be-30 had to compete with the Antonov An-28 (first flight September 1969) for the large Aeroflot orders that were to be expected. The Be-30 had a longer range, was faster, and had better crosswind handling. The An-28 had better landing and take-off performance and a larger capacity. Therefore both aircraft were recommended for production. But the whole project was cancelled about 1972 when Aeroflot chose the Czech Let L-410 Turbolet (described separately) in preference to Beriev''s (and Antonov''s) design. The L-410 had a slightly larger load capacity, but was mainly chosen for political reasons, strengthening the economical ties with the East European countries. Since then the Be-30/32 lay dormant until Beriev resurrected it in the early 1990s in a bid to attract new business. As Czech and other foreign aircraft and spare parts had now to be paid in hard currency, it was thought that domestic aircraft could be preferred for the internal Russian market, and could gain hard currency when exported. 

Beriev exhibited the Be-32 at the 1993 Paris and Dubai air shows, the design bureau claiming that the Be-32 incorporated a number of improvements, including more powerful engines. This demonstrator was one of the original aircraft built in the early seventies. This Be-32 was painted in the colors of Moscow Airways, who had placed an order for 50 earlier in 1993, but this company ceased operations before any were delivered.

Technical features of this high wing unpressurised commuter include a fuselage of all-metal semi-monocoque structure covered mainly with large chemically-milled panels attached by bonding and spot-welding. The cantilever wing has anhedral on the outer panels. The spars of the main torsion box and the skin panels are made of mechanically and chemically-milled profile pressings. The detachable leading edge is of bonded construction. Thin 3-layer honeycomb panels stiffened by stringers are used for about half of the wing skin. Bonding and spot-welding is used for most of the joints. Double-slotted flaps occupy the trailing edge inboard of the ailerons.
The tail unit has a similar all-metal cantilever structure with a thin honeycomb skin covering. For weight saving, glass fibre reinforced plastics are used for some non-load-carrying parts, such as the wingtips, some tail surfaces, and wing/fuselage fillets.

A hot-air de-icing system using engine-bleed air is provided for the wings, tail unit, and engine air intakes, while the windscreen and propellers have electric de-icing. The aircraft has a retractable tricycle landing gear with a single wheel with a low pressure tire on each unit. The main units retract rearward into the engine nacelles. The nosewheel retracts forward and is steerable. Floats and skis are optional. There is provision for an interconnecting shaft between the engines that permits power on both propellers during an engine-out condition. This system was installed and flight tested on the second prototype. There are four integral fuel tanks, located in the wing torsion box.

The Be-30 has accomodation for a crew of two on the flight deck and 14 passengers in the cabin, later increased to 17 in the Be-32. There are two small compartments, for mail and small freight, on the port side between the flight deck and the cabin. On the starboard side, aft of the cabin, is a carry-on baggage compartment, and a toilet is provided at the rear of the cabin. The aircraft carries its own folding stairway.

On August 15, 1995, a prototype was flown of the Pratt & Whitney PT6A-65B powered Be-32K, a conversion of the Be-32 exhibited at Paris and Dubai in 1993. Production aircraft will be powered by the Russian built version of this successful engine, the Klimov PK6A-65B.

In September 1996 it was announced that the Be-32 would be produced by IAR in Romania, but these plans were later denied. In 1998 it was stated that the Be-32K would be built by Taganrog Aviation, but flight testing was reportedly still under way in 1999. Apparently there has not been much progress in recent years, and as far as is known, no new aircraft have been built since the mid seventies.',NULL,'Operational'),
('boeing707','The 707''s jet speed, long range, high seating capacity and operating economics revolutionised airliner travel when it was introduced into service in 1958. The 707 also laid the foundations for Boeing''s dominance of the jet airliner market. 

Recognising the jet engine''s potential for commercial aviation, Boeing (at great financial risk) decided to develop a jet powered transport that could fulfil military tanker transport roles but be easily adapted to become an airliner.  The resulting prototype, known as the 367 Dash 80, flew for the first time on July 16 1954. Impressed, the US Air Force ordered a larger version, with a wider fuselage (12 ft, vs 11 ft for the Dash 80) into production as the KC-135 tanker/transport (more than 800 were built).  At first, Boeing wanted to sell the same size aircraft to the airlines, but the airlines insisted on an even larger airplane, which Douglas promised to build (this became the DC-8).  Boeing finally relented, designing the 707 as a longer aircraft with a slightly wider fuselage (12 ft 4 in).

The first production 707 (a 707-120 for Pan Am) flew on December 20 1957, and entered service later the following year. Developments of the 707-120 include the similar 707-220, the shorter 138 for Qantas, and the stretched 707-320, which flew in July 1959. The 707-120 and 320 were later reengined with JT3D turbofans (in place of the original JT3 and JT4 turbojets) to become the 707-120B, and the 707-320B respectively. The 707-320C was a convertible model, the 707-420 was powered by RollsRoyce Conways, while the proposed CFM-56 powered 707-700 upgrade was flight tested in the late 1970s but never entered production. 

Most civil 707s in service today have been converted to freighters, while a number are used as corporate transports. 

Many air forces have bought 707s, new or converted second-hand aircraft, for general transport, aerial refuelling, and electronic warfare. The E-3 Sentry is a dedicated airborne warning and control system (AWACS) platform with a large rotodome above the fuselage. The E-6 Mercury performs the TACAMO (Take Charge and Move Out) role with the US Navy, maintaining communication with the ballistic missile submarines. The E-8 J-Stars (Joint Surveillance Target Attack Radar System) performs the battlefield control role. Other military 707s received the designations C-137, or C-18, but many others have no special military designation.',NULL,'Operational'),
('boeing717','The 100 seat 717 is the latest development of the popular DC-9/MD-80/MD-90 family and the only Douglas airliner which Boeing (which merged with McDonnell Douglas in 1997) plans to retain in its product line-up. It is designed for high cycle, short range regional airline operations. 

McDonnell Douglas first announced the MD-95 at the Paris Airshow in June 1991. At the time MDC anticipated a formal program launch by late 1991 and a first flight in July 1994. As it happened program launch was not until October 1995 when US airline ValuJet (now AirTran Airlines) ordered 50 and optioned 50. 

In January 1998 Boeing (following the August 1997 Boeing/McDonnell Douglas merger) relaunched the aircraft as the 717-200 (the second use of the Boeing designation "717", as this was previously allocated to the military C-135/KC-135 family). First flight took place on September 2 1998, followed by a second development 717 on October 26. Certification was awarded on September 1 1999 while the first delivery, to AirTran, was on September 23 that year. 

Initially MDC studied powering the MD-95 with Pratt & Whitney JT8D-218s or Rolls-Royce Tays. In February 1994 however MDC announced it had chosen the new BMW Rolls-Royce (now just Rolls-Royce) BR715 over the JT8D-200 and an engine from the proposed "Project Blue" teaming of General Electric, Snecma, MTU and P&W. 

Other 717-200 features include a fuselage 1.45m (4ft 9in) longer than the DC-9-30''s, a wing based on the DC-9-34''s, an advanced six LCD screen Honeywell EFIS flightdeck, and a cabin interior similar to that developed for the MD-90. It is offered in standard 717-200BGW (Basic Gross Weight) and extended range 717-200HGW (High Gross Weight) forms. In addition, 80 seat shortened 717-100 (formerly MD-95-20) and 120 seat stretched 717-300 (formerly MD-95-50) models have been studied, as has a business jet variant. 

Companies participating in 717 production include Alenia (fuselage), Korean Air (nose), AIDC of Taiwan (empennage), ShinMaywa of Japan (engine pylons and horizontal stabilizers), Israel Aircraft Industries (undercarriage), and Fischer of Austria (interior). Final assembly is at Boeing''s Long Beach plant, in the same building that the DC-9 and MD-80 were built in. 

Initial orders and operators are:
AeBal, Airtran, Bangkok Air, Bavaria International Leasing, Hawaiian Airlines, Impulse Airlines, Midwest Express Airlines, Olympic Aviation, Pembroke Leasing, Qantas Link, Siam Reap Air, Trans World Airlines, and Turkmenistan Airlines.',NULL,'Operational'),
('boeing720','The 720 is a smaller capacity, lighter, medium range variant of the 707, given its own model number to indicate significant engineering changes. 

Introduced in 1959, the 720 (originally designated 707-020) retained the same basic structure as the 707-120, but was 2.54m (8ft 4in) shorter, which reduced seating to 112 (38 + 74) in a typical two class arrangement. Other changes were made to the wing which introduced full span leading edge flaps, while a glove between the inner engines and the fuselage increased wing sweep and wing area and decreased the wing''s thickness/chord ratio. The changes to the wing made it more aerodynamically efficient, permitting higher cruising speeds and lowered minimum speeds (which aided field performance). 

Like the early 707s the first 720s had JT3C turbojets, although less powerful models lacking water injection because of the 720''s lighter weight. Compared with the 707-120 the 720 also had reduced fuel capacity and a lower max takeoff weight. But many components were interchangeable between the 720 and 707, while inside the cabin the 720 and 707 shared the same passenger interior and flightdeck. 

The initial 720 (bound for launch customer United) first flew on November 23 1959. Certification was awarded on June 30 1960, and entry into service with United Airlines was on July 5 that year. 

The availability of the far more fuel efficient Pratt & Whitney JT3D turbofan resulted in the 720B, which was powered by either JT3D1s or 3s. First flight of the 720B was on October 6 1960, with certification awarded on March 3 1961. The 720B also featured a higher maximum zero fuel weight (significantly boosting payload/range) and an increased max takeoff weight due to the heavier turbofan engines. 

Major 720 operators included American Airlines (a number of its 720s were converted to 720Bs with turbofan engines), United, Continental, Eastern, Northwest Orient and Western, while operators outside the US included Lufthansa and Avianca. 

Today (early 2002) three 720s are believed to be in use as corporate transports, and two are used by Pratt & Whitney as engine testbeds.',NULL,'Operational'),
('boeing727100','The 727 short to medium range trijet is the world''s second most successful jet airliner built. 

Initial design studies began in 1956, although for a time it appeared that a new short/medium range airliner would not be built at all due to Boeing''s financial position before sales of the 707 had taken off. Boeing persisted however and serious development of the 727 beginning in June 1959. The program was launched on the strength of orders for 80 from Eastern and United in 1960. 

The resulting Boeing Model 727 pioneered the rear trijet configuration, with power from three specially designed Pratt & Whitney JT8D turbofans (although RollsRoyce Speys were originally considered). The trijet design was settled upon as it gave the redundancy of three engines, better climb performance than a twin and improved operating economics over a four engine jet. The 727 also introduced an advanced wing design with the first airliner application of triple slotted Krueger flaps. The 727 retained the 707''s fuselage cross section, but with a redesigned smaller lower fuselage due to the need to carry less baggage on shorter range flights, and it has limited parts commonality with the 707 and 720. The 727 was also the first Boeing airliner to feature an APU (auxiliary power unit). 

The prototype 727 first flew on February 9 1963, with certification granted in December that year. The first 727 entered service with Eastern Airlines on February 9 the following year. 

Development of the initial 727-100 resulted in a small family of sub variants, including higher gross weight options for the basic passenger carrying 727, the 727-100C Convertible and 727-200QC Quick Change, both with a large freight door on the forward left hand side of the fuselage. Many were subsequently converted to pure freighters. The stretched 727-200 is described separately. 

Production of the 727-100 ceased in 1973 but one recent notable development was Dee Howard in the USA upgrading a number of 727-100 freighters for express freight operator UPS. The major feature of the upgrade was reengining with RollsRoyce Tays, which improves performance, reduces fuel consumption and more importantly, allows the aircraft to meet Stage 3 noise requirements.',NULL,'Operational'),
('boeing727200','The 727-100 had been in service barely a year when Boeing began serious consideration of a stretched, greater capacity development. 

This resulted in the 727-200, which Boeing announced it was developing in August 1965. The 727-200 was essentially a minimum change development of the 100, the only major change being the 6.10m (20ft) fuselage stretch, which increased maximum seating to 189 passengers. The 727-200''s stretch consisted of two 3.05m (10ft) plugs, one forward and one rear of the wing. Otherwise the 727-100 and 200 shared common engines, fuel tank capacity and the same maximum takeoff weight. 

The first flight of the 727-200 occurred on July 27 1967, with certification granted in late November that year. The -200 was placed into service by launch customer Northeast Airlines (this airline was later acquired by Delta) the following month, by which time total 727 orders for both models had exceeded 500. 

The 727-200 helped broaden the sales appeal of the 727 considerably and snared significant sales. However the 200 was restricted by its relatively short range, due to it having the same fuel capacity as the 727-100, so Boeing developed the increased range Advanced 727-200. First flown in March 1972 changes introduced on the Advanced model included increased fuel capacity, and thus range, the option of more powerful engines, quieter engine nacelles and strengthened structure. The Advanced remained the primary 727-200 production model until production ceased in 1984. 

The 727-200 remains popular with passengers and pilots but it does not meet Stage 3 noise requirements. To overcome this a number of hushkit programs are on offer while Valsan converted 23 727s to its Stage 3 compliant Quiet 727 standard (before the company collapsed). This retrofit included installing JT8D-217s on the outer pylons and acoustic treatment of the centre engine. Other 727s have been fitted with winglets for improved performance.',NULL,'Operational'),
('boeing737100200','The 737-100 and 200 are the first generation production models of the world''s most successful jet airliner family, Boeing''s 737 twinjet. 

The 737 was conceived as a short range small capacity airliner to round out the Boeing jet airliner family beneath the 727, 720 and 707. Announced in February 1965, the 737 was originally envisioned as a 60 to 85 seater, although following consultation with launch customer Lufthansa, a 100 seat design was settled upon. Design features included two underwing mounted turbofans and 60% structural and systems commonality with the 727, including the same fuselage cross section (making it wider than the competing five abreast DC-9 and BAC-111). 

The 737-100 made its first flight on April 9 1967 and entered service in February 1968 with Lufthansa, while the last of 30 built was delivered to Malaysia-Singapore Airlines in October 1969. 

By this time however the larger capacity 1.93m (6ft 4in) stretched 737-200 was in service after it had made its first flight on August 8 1967. First delivery, to United, was that December.

Developments of the -200 include the -200C convertible and quick change -200QC, while an unprepared airfield kit was also offered. The definitive Advanced 737-200 appeared in 1971, featuring minor aerodynamic refinements and other improvements. 

Sales of the 737-200 far exceeded that of the shorter -100 and the 737-200 remained in production until 1988, by which time it had been superseded by the improved 737-300, after 1114 had been built. Many have been fitted with Stage 3 engine hushkits, and a number of passenger aircraft have been converted with cargo doors.

The USAF ordered 19 as navigation trainers, and some were later converted to standard transport aircraft as CT-43A. A few other air forces received 737-200s to serve in general transport, surveillance or VIP transport tasks.',NULL,'Operational'),
('boeing737300','The 737-300 is the first of the three member second generation CFM56 powered 737 family, which also comprises the stretched 737-400 and shortened 737-500. The success of the second generation Boeing 737 family pushed sales of the mark to over 3000, a record for a commercial jetliner. 

Boeing announced it was developing the 737-300 in March 1981. This new variant started off as a simple stretch over the 737-200 but Boeing decided to adopt the CFM International CFM56 high bypass turbofan (jointly developed by General Electric and SNECMA) to reduce fuel consumption and comply with the then proposed International Civil Aviation Organisation Stage 3 noise limits. 

Despite the all new engines and the 2.64m (104in) fuselage stretch, the 737-300 retains 80% airframe spares commonality and shares the same ground handling equipment with the 737-200. A number of aerodynamic improvements were incorporated to further improve efficiency including modified leading edge slats and a new dorsal fin extending from the tail. Another feature was the flattened, oval shaped engine nacelles, while the nosewheel leg was extended to increase ground clearance for the new engines. Other internal changes include materials and systems improvements first developed for the 757 and 767 programs, including an early generation EFIS flightdeck (with four colour CRT screens). 

The 737-300 flew for the first time on February 24 1984, while first deliveries were from November 1984. Since that time well over 1000 737-300s have been sold and it forms the backbone of many airlines'' short haul fleets. 

The stretched 737-400 and shortened 737-500 are described separately.',NULL,'Operational'),
('boeing737400','Boeing announced it was developing a new higher capacity version of the fast selling 737-300 in June 1986. 

The new aeroplane, the 737-400, was developed as a 150 seat class 727 replacement. Although Boeing had initially developed the 180 to 200 seat 757 to replace the successful 727, there still existed a considerable market for a near direct size replacement for the popular trijet. By developing the 737-400 as a minimum change stretch of the 737-300, Boeing was also able to offer considerable commonality, and thus cost, benefits to operators already with the 737-300, and to a lesser extent, the 737-200 in their fleets. 

The major change of the 737-400 over the smaller 300 is a 3.05m (10ft 0in) fuselage stretch, consisting of a 1.83m (6ft 0in) stretch forward and a 1.22m (4ft 0in) plug rear of the wing. The stretch increases maximum passenger seating to 188. To cope with the increased weights, more powerful CFM56s are fitted. Other changes are minor, such as a tail bumper fitted to protect against over rotation at takeoff, something that could have become a problem due to the increased fuselage length. 

A higher gross weight longer range version is offered. It features increased fuel capacity, and strengthened undercarriage and structures, but is otherwise identical to the standard 737-400. 

The first flight of the 737-400 occurred on February 19 1988 and it entered airline service in October that year with Piedmont. Of the 737-300/-400/-500 family the 400 has proven the most successful member behind the 300, its larger capacity and transcontinental US range meaning it has found a very useful market for Boeing as a 727 replacement. However the 737-400 does face stiff competition from the similar size Airbus A320, which has higher levels of technology, longer range and is faster (but is also heavier).',NULL,'Operational'),
('boeing737500','The 737-500 is the shortest and smallest member of the second generation 737-300/-400/-500 family, and the last to be developed. 

When the new stretched 737-300 first appeared it was intended to supplement, rather than replace, the 737-200. However the evolution of the 737-300 into a family of models led to the development of a new model comparable in size to the 737-200, but offering better fuel economy and extensive commonality with the 737-300 and -400 models. This was the 737-500, known before its May 1987 formal launch as the 737-1000. 

Like the preceding 737-300 and 737-400, the 737-500 is powered by CFM International CFM56s turbofans, in this case either 82.3kN (18,500lb) CFM563B1s or 89.0kN (20,000lb) CFM56-3C-1s. All three second generation 737 models share extensive systems and structure commonality, and a common aircrew type rating. These benefits offer real cost savings to an airline with two or more variants of the family in its fleet. 

The 737-500 is 31.01m (101ft 9in) in length, comparable to the 737-200''s 30.53m (100ft 2in) length, and as such is a viable direct replacement for the earlier type. Like the 300 and 400, a higher gross weight longer range version is offered, featuring auxiliary fuel tanks and uprated engines. 

The 737-500''s first flight occurred on June 30 1989, FAA certification was awarded on February 12 1990, with service entry later that same month. 

The 737-500''s main appeal is for operators of large 737-400 and 737-300 fleets, as because the 500 is a shortened development of the 300, it still carries much of the structural weight needed for the higher weight models. This makes it less efficient than if it was designed specifically for its size category, however for operators of large 737-300/400 fleets, the extensive commonality benefits more than compensate for this.',NULL,'Operational'),
('boeing737600700','The 737-600 and -700 are the smaller members of Boeing''s successful Next Generation 737-600/700/800/900 family. 

Among the many changes, the Next Generation 737s feature more efficient CFM56-7B turbofans. The CFM56-7 combines the core of the CFM56-5 with the CFM56-3''s low pressure compressor and a 1.55m (61in) fan. The 737''s new wing has greater chord, span and wing area, while the tail surfaces are also larger. The 2.4m (8ft) high winglets first developed for the Boeing Business Jet development are now offered as an option on the 737-700 (and -800). 

The new engines and wings allow the 737 to cruise at Mach 0.78 to Mach 0.80, while the larger wing allows greater fuel tankage and transcontinental USA range. Other features include a 777 style EFIS flightdeck with six flat panel LCDs which can be programmed to present information as on the 777 or as on the 737-300/400/500 series, allowing a common pilot type rating for the two 737 families. 

The improved Next Generation Boeing 737 family (originally covered by the 737X designation) was launched in November 1993. The 737-700 was the first member of the new family to be developed, and is based on the 737-300, while the 737-600 is based on the 737-500. 

The 737-700 rolled out on December 7 1996, was granted certification in November 1997 and entered service (with Southwest) the following month. The 737-600 was launched was launched on March 16 1996, first flew on January 22 1998 and entered service (with SAS) in September that year. 

The Boeing Business Jet or BBJ (described separately) is based on the fuselage of the 737-700 with the larger 737-800''s wing. 

The BBJ''s airframe also forms the basis for the convertible passenger/freighter variant of the 700, the 737-700QC, which has been ordered by the US Navy as the C-40A Clipper (to replace the DC-9 based C-9B). The C-40 first flew on April 17 2000. The naval aircraft can be converted to carry 121 passengers, or 3 pallets of cargo plus 70 passengers, or 8 pallets of cargo only. These aircraft are currently (2002) based at Naval Air Station Fort Worth, Texas (VR-59) and Naval Air Station Jacksonville, Florida (VR-58). 

The US Air Force has bought two ex-Fordair BBJs, which are designated C-40B.',NULL,'Operational'),
('boeing737700800bbjbbj2','The Boeing Business Jet - or BBJ - is a long range corporate jet development of the 737-700 and -800. 

Boeing Business Jets is a joint venture formed by Boeing and General Electric in July 1996 to develop and market a corporate version of the popular 737 airliner, initially focusing on the 737-700 based BBJ (or 737-700 BBJ). The first BBJ rolled out from Boeing''s Renton plant on August 11 1998 and flew for the first time on September 4 that year. On October 30 the US FAA awarded certification to the developed 737-700 airframe on which the BBJ is based. The first completed BBJ was delivered on September 4 1999. 

The BBJ combines the Next Generation 737-700''s airframe combined with the strengthened wing, fuselage centre section and landing gear of the larger and heavier 737-800, with three to 10 belly auxiliary fuel tanks. It features the Next Generation 737 advanced two crew six LCD screen EFIS avionics flightdeck, equipped with embedded dual GPS, TCAS, enhanced GPWS and Flight Dynamics head-up guidance system. Following their certification in September 2000, winglets became a standard option. 

Boeing supplies unfurnished or ''green'' BBJ airframes to DeCrane of Georgetown, Delaware for long range fuel tank installation. From DeCrane the BBJ is flown to a customer specified completion centre for interior fit-out and exterior painting.

On October 11, 1999 Boeing launched the BBJ2, based on the stretched 737-800 airframe, which is 5.84m (19ft 2in) longer than the BBJ, and is offering 25% greater cabin space (and 100% more baggage space), but has slightly reduced range. It is fitted with between three and seven auxiliary belly fuel tanks. The winglets are standard on this version. The first delivery was made on February 28, 2001.',NULL,'Operational'),
('boeing737800900','Boeing''s Next Generation 737-800 and 737-900 are the largest members of the strong selling 737 family. Unlike the other Next Generation 737s, the -800 and -900 introduce new fuselage lengths, extending 737 single class seating range out to 189, compared with 100 in the original 737-100. 

Like the -600 and -700, the -800 and -900 feature the Next Generation improvements including more efficient CFM56-7B turbofans, the new wing with greater chord, span and wing area, larger tail surfaces and the 777 style EFIS flightdeck with six flat panel LCDs which can present information as on the 777 or as on the 737-300/400/500 series, the latter allowing a common pilot type rating for the two 737 families. A HUD is optional. BBJ style winglets are offered as an optional feature for the -800. 

Until its launch on September 5, 1994 the 737-800 was known as the 737-400X Stretch. Compared with the -400 the -800 is 3.02m (9ft 9in) longer, taking typical two class seating from 146 to 162, while range is significantly increased. The -800 has sold strongly since its launch, and early 2002 was the highest selling Next Generation model. First flight was on July 31 1997, first delivery (to Hapag Lloyd) was in April 1998.

The largest single order for the -800 series has come from the Irish budget carrier, Ryanair. After 28 had already been ordered earlier, a firm order for 100 aircraft was made in January 2002, with an option of another 50, to be delivered over the next 8 years. Ryanair will use the aircraft in a single class configuration, to seat 189 passengers

A variant of the 737-800 is the Boeing Business Jet 2 (BBJ2), which is described separately. 

The 737-900 is the largest and latest member of the 737 family, and was launched on September 10, 1997 with an order for 10 from Alaska Airlines. A 1.57m (5ft 2in) plug forward of the wing and a 1.07m (3ft 6in) plug rear compared with the -800 increases seating to 177 in two classes (maximum seating is the same as the 737-800''s due to emergency exit requirements). First flight was made August 3, 2000, and the first delivery (to Alaska Airlines) May 15, 2001.',NULL,'Operational'),
('boeing747100200','The hugely significant 747 revolutionised airline transport. Far bigger than anything before it, the 747 slashed operating costs per seat and thus cut the cost of long haul international airline travel. 

Boeing conceived the 747 in the mid 1960s following its failure to secure a US Air Force contract for an ultra large strategic transport (which resulted in the Lockheed C-5 Galaxy), when it identified a market for a high capacity ''jumbo jet''. Boeing was able to draw upon design experience with the USAF transport and launched the new airliner on July 25 1966. First flight occurred on February 9 1969, certification was awarded on December 30 that year. 

The basic 747-100 entered service with Pan American in January 1970. Progressive development of the 747 led to the 747-200B with higher weights, more powerful engines and longer range. The -200B first flew in October 1970 entering service with KLM, while nine higher weight 747-100Bs were built. 

Developments include the 747-200F freighter, the SR (short range) optimised for high cycle short sector operations and the C (Combi). 

The 747 holds a place in the public eye unlike any other aircraft. The so called `Queen of the Skies'' opened up international travel to millions. It is also notable for being the first widebody airliner, the largest and heaviest airliner, and the first to use fuel efficient, high bypass turbofans.',NULL,'Operational'),
('boeing747300','Boeing''s 747-300 model introduced the distinctive stretched upper deck which can seat up to 69 economy class passengers. 

The 747-300 was the end result of a number of Boeing studies which looked at increasing the aircraft''s seating capacity. Ideas studied included fuselage plugs fore and aft of the wing increasing seating to around 600, or running the upper deck down the entire length of the fuselage. In the end Boeing launched the more modest 747SUD (Stretched Upper Deck) with greater upper deck seating on June 12 1980. 

The 747SUD designation was soon changed to 747EUD (for Extended Upper Deck), and then 747-300. The new model first flew on October 5 1982 and was first delivered to Swissair on March 28 1983. Other customers included UTA, Saudia, SIA, Qantas and Cathay. 

Compared to the -200, the -300''s upper deck is stretched aft by 7.11m (23ft 4in), increasing economy class seating from 32 to a maximum of 69. The lengthened upper deck introduced two new emergency exit doors and allows an optional flightcrew rest area immediately aft of the flightdeck to be fitted. Access is via a conventional rather than spiral staircase as on the earlier models. 

Otherwise the 747-300 is essentially little changed from the 747-200 and features the same takeoff weight and engine options. 747-300 variants include the 747-300M Combi and the short range 747-300SR built for Japan Air Lines for domestic Japanese services. 

The extended upper deck was also offered as a retrofit to existing 747-100/-200s, although the only airlines to take up this option were KLM and UTA. KLM has since converted two to freighters, resulting in the first 747 freighters with the stretched upper deck. Also, two JAL 747-100s were delivered new with the extended upper deck.',NULL,'Operational'),
('boeing747400','The 747-400 is the latest, longest ranging and best selling model of the 747 family. 

Boeing launched the 747-400 in October 1985 and the first development aircraft first flew on April 29 1988. US certification (with PW-4000s) was awarded in January 1989. 

The 747-400 externally resembles the -300, but it is a significantly improved aircraft. Changes include a new, two crew digital flightdeck with six large CRT displays, an increased span wing with winglets (the -400 was the first airliner to introduce winglets), new engines, recontoured wing/fuselage fairing, a new interior, lower basic but increased max takeoff weights, and greater range. 

Apart from the basic passenger 747-400 model, a number of variants have been offered including the winglet-less 747-400 Domestic optimised for Japanese short haul domestic sectors, the 747-400M Combi passenger/freight model, and the 747-400F Freighter (which combines the 747-200F''s fuselage with the -400''s wing).

The latest model is the 747-400ER, which was launched on November 28, 2000 when Qantas placed an order for 6. The -400ER has the same size as the -400, but has more range or payload capability. The MTOW was increased by 15,870kg (35,000lb) to 412,770kg (910,000lb), giving a further range of 805km (435nm) or a 6800kg (15,000lb) greater payload. The -400ER also features a wholly new cabin interior with larger luggage bins, and several flight deck improvements.

The -400ER incorporates the strengthened wing, body, and landing gear of the -400F, plus an auxiliary fuel tank in the forward cargo hold, and an optional second one. Operators who don''t need these can remove them both, gaining additional cargo volume.

The first 747-400ER was rolled out in June 2002, and flew for the first time on July 31, 2002, and this was the 1308th 747 to fly. 

A cargo version, the 747-400ERF, followed the standard -400ER, and was launched April 30, 2001 on an order by leasing company ILFC for 5. The first -400ERF is the 1315th 747 built. The -ERF has the same MTOW as the -ER, and this will give an extra range of 970km (525nm), or an extra payload of 9980kg (22,000lb) at MTOW compared with the standard -400F.     

Shortly before delivery of the first -400ER, Boeing had received orders for 15 ER/ERFs from 5 customers.

Various growth 747 models have been studied. The 747-500X and -600X models were dropped in January 1997.  Boeing is currently proposing the 747-400XQLR (Quiet Longer Range) to 747-size customers which will offer more range, more quiet, and more features.',NULL,'Operational'),
('boeing747sp','Boeing developed the 747SP in the mid 1970s as a longer range, shortened 747, trading passenger seating for extra range. The 747SP is the only 747 model to feature a changed fuselage length compared with the 747-100.

The 747SP first flew on July 4 1975, certification was awarded on February 4 1976 and first delivery (to Pan American) was in March 1976. 

The 747SP''s fuselage is shortened by 14.35m (47ft 1in) compared to other 747 models, while the vertical tail was increased in height to compensate for the reduced moment arm with the shorter fuselage. Structurally the 747SP was lightened in some areas because of the significant reduction in gross weights. Overall though the 747SP retained 90% commonality of components with the 747-100 and 200. While shortening the 747''s fuselage increased the fuel fraction and thus range, it also meant that seating capacity was reduced.  

The SP suffix in 747SP stands for Special Performance, and points to the ultra long range abilities of this 747 variant that preceded the later 747-400 by 15 years. The 747SP''s range is best illustrated by the spate of long range distance records it set in the mid 1970s. The most prominent of those was the delivery flight of a South African Airways SP, which over March 23/24 1976 flew nonstop with 50 passengers from Paine Field in Washington State to Cape Town, South Africa, a distance of 16,560km (8940nm). This world nonstop record for a commercial aircraft stood until 1989 when a Qantas 747-400 flew 17,945km (9688mn) nonstop from London to Sydney. 

Sales of the 747SP were modest despite the increased range, as the SP had poorer operating economics per seat compared to the 747-200. However the 747SP did pioneer a number of long range nonstop services that are now commonly flown by the 747-400. 

Notable SP customers included South African Airways (who found the SP''s extended range a great asset in bypassing African nations that denied it landing rights while South Africa''s apartheid policies were in place), Qantas and PanAm, the latter pioneering nonstop trans Pacific Los Angeles/Sydney services.

In early 2005 less than twenty SPs remain in airline or corporate service.',NULL,'Operational'),
('boeing757200','After a slow sales start, the medium range single aisle 757 has become yet another sales success story for Boeing. 

Boeing considered a number of proposals for a successor to the 727 tri-jet during the 1970s, with many of these designs featuring the nose and T-tail of the earlier jet. It was not until later in that decade however that Boeing settled on a more conventional design featuring the same cross section as the 727 (not to mention the 737, 707 and 720) but with the fuselage considerably longer in length, an all new wing, nose and flightdeck and fuel efficient high bypass turbofan engines. 

Boeing launched development of the 757 in March 1979 following orders from British Airways and Eastern. Developed in tandem with the larger widebody 767 the two types share a number of systems and technologies, including a common early generation EFIS flightdeck. 

First flight was on February 19 1982 and the 757 entered service in January the following year. Subsequent versions to appear are the 757-200PF Package Freighter, a pure freighter, and the 757-200M Combi (only one has been built). The standard passenger aircraft is designated the 757-200, there being no -100. The stretched 757-300 is described separately. 

Initial sales of the 757 were fairly slow, however orders picked up significantly in the mid to late 1980s as traffic on routes previously served by smaller 727s and 737s grew to require the 757''s extra capacity. Today 757 sales comfortably exceed those of the 767, a position that was reversed until the late 1980s.',NULL,'Operational'),
('boeing757300','The stretched, 240 seat Boeing 757-300 is the first significant development of the basic 757-200 and is aimed primarily at the European vacation charter market. 

Although design work on the original 757 began in the late 1970s and its entry into service was in 1983, it wasn''t until over a decade later in the mid 1990s that Boeing began to study a stretched development of its popular narrowbody twin. This new 757 stretch was covered by the 757-300X designation until its launch at the Farnborough Airshow in England in September 1996. 

The most obvious change over the 757-200 is the 300''s 54.43m (178ft 7in) long fuselage, which is 7.11m (23ft 4in) longer than the standard aircraft (and only fractionally shorter than the 767-300). This fuselage stretch allows a 20% increase in seating to 225 to 279 passengers, depending on the interior configuration. Lower hold freight capacity is also increased by 40% over the 757-200 by virtue of the longer fuselage. 

Another feature of the 757-300 is its new interior which is based on that developed for the Next Generation 737 models. Features include a new sculptured ceiling, larger overhead bins, indirect overhead lighting and vacuum toilets. 

The 757-300 shares the 200''s cockpit, wing, tail and powerplant options, although the 300 will feature strengthened structure and landing gear to cope with the increased weights, new wheels, tyres and brakes and a tailskid. 

The 757-300 first flew on August 2 1998, with certification in January 1999, and entry into service (with launch customer Condor - the charter arm of German flag carrier Lufthansa) in March 1999. The -300''s 27 month development program from final configuration to planned first delivery is the fastest for any Boeing airliner (the 777-300 took 31 months for example). Other early customers are Icelandair, Arkia, Northwest, American Trans Air, Continental, and JMC Air.',NULL,'Operational'),
('boeing767200','The narrowest widebody in service, the 767 started life as an advanced technology mid to large size airliner in the late 1970s. 

Launched in July 1978, the 767 was developed in tandem with the narrowbody 757 with which it shares a common two crew EFIS flightdeck (with six colour CRT displays) and many systems. The 767 also features a unique width fuselage typically seating seven abreast in economy, and a new wing design with greater sweepback (compared to the 757) which was designed with high altitude cruise in mind. 

The 767 program also features a high degree of international participation, with Japanese companies in particular having a large share of construction. 

Initially Boeing intended to offer two versions, the longer 767-200 and short fuselage 767100 (which was not launched as it was too close in capacity to the 757). The 767 first flew on September 26 1981, and entered service (with United) on September 26 1982 (certification with P&W engines was awarded on July 30 1982). 

The longer range 767-200ER (Extended Range) version features higher weights and an additional wing centre section fuel tank. It first flew on March 6 1984, and service entry, with Ethiopian Airlines, was two months later. The 200ER accounts for 111 of the total 239 767-200s ordered. 

The last airliner 767-200/-200ER was delivered in 1994 until a November 1998 order from Continental. These had all been delivered by 2002, but military orders for 767 tankers will keep the -200 in production.',NULL,'Operational'),
('boeing767300','Boeing announced that it was developing a stretched development of the 767-200 in February 1982. 

The resulting 767-300 features a 6.42m (21ft 1in) stretch consisting of fuselage plugs forward (3.07m/10ft 1in) and behind (3.35m/11ft) the wing centre section. The flightdeck and systems were carried directly over from the 767-200, the only other changes were minor, and related to the increased weights of the new version. Initially the max takeoff weight was the same as the later 767-200ER. 

The 767-300 flew for the first time on January 30 1986, and was awarded certification and entered service in September that year. The higher weight Extended Range ER version flew on December 19 1986, while RollsRoyce RB-211-524G engines became available from 1989. The range of the 767-300ER has proven to be very popular with a number of airlines using them for long range low density flights. 

In 1993 Boeing launched the 767-300F General Market Freighter. Changes include strengthened undercarriage and wing structure, a cargo handling system, no cabin windows and a main deck freight door. Capacity is 24 containers. The further stretched 767-400 is described separately.',NULL,'Operational'),
('boeing767400','Boeing''s 767-400ER is a stretched development of the popular 767-300ER, designed to replace early A300, A310 and 767 twins used on transcontinental services and DC-10-30s and L-1011 trijets used for intercontinental work. It competes with the A330-200. 

Design work on the then 767-400ERX began in late 1996 when Boeing signed a technical assistance agreement covering the program with the then independent Douglas Aircraft Company division of McDonnell Douglas. At the time Boeing suffered from a shortage of engineering talent with a number of other key programs underway while Douglas had surplus engineering capacity following the cancellation of the MD-XX (Boeing and McDonnell Douglas subsequently merged in August 1997). The program was formally launched as the 767-400ER in January 1997 when Delta Airlines ordered 21. 

The most significant change with the 767-300 is the 6.4m (21ft) fuselage stretch, which increases typical three class seating capacity from 218 to 245. Because of the increased fuselage length the -400 features all new, 46cm (18in) taller landing gear to restore rotation angles for acceptable takeoff and landing speeds and distances which would otherwise have been adversely affected by the fuselage stretch. The wheels, tyres and brakes are common with the 777. 

Compared to the 767-300, the 767-400ER''s wing features 2.34m (7ft 8in) long raked wingtips which improve aerodynamic efficiency. Winglets were originally considered but the wingtip extensions proved more efficient. The wing is also made from increased gauge aluminium with thicker spars. 

Inside, the 767-400ER features a 777 style advanced flightdeck with six colour multifunction displays, which can present information in the same format as earlier 767s, allowing a common type certificate, or as for the 777 and Next Generation 737s. The all new passenger interior is similar to that in the 777. 

Other features include common engines with the 767-300, a new APU, new tailskid and increased weights. 

The first flight was made 9 October 1999. Four aircraft took part in the development program. 

Delta Airlines was the launch customer, and, as of December 2001, the aircraft was also ordered by Continental Airlines and Kenya Airways.',NULL,'Operational'),
('boeing777200','Boeing''s advanced widebody 777 twin incorporates more advanced technologies than any other previous Boeing airliner, and has been progressively developed into increasingly longer range developments. 

The 777 was originally conceived as a stretched 767, but Boeing instead adopted an all new design. Notable 777 design features include a unique fuselage cross section, Boeing''s first application of fly-by-wire, an advanced technology glass flightdeck with five liquid crystal displays, comparatively large scale use of composites (10% by weight), and advanced and extremely powerful engines. The 777 was also offered with optional folding wings where the outer 6m/21ft of each would fold upwards for operations at space restricted airports. 

The basic 777-200 as launched in October 1990 was offered in two versions, the basic 777-200 (initially A-Market) and the increased weight longer range 777-200IGW (Increased Gross Weight, initially B-Market). The IGW has since been redesignated 777-200ER. 

The 777-200 first flew on June 12 1994, with FAA and JAA certification awarded on April 19 1995. The FAA awarded full 180 minutes ETOPS clearance for PW4074 -200s on May 30 that year. First customer delivery was to United Airlines in May 1995. The first 777-200IGW/ER was delivered to British Airways in February 1997. 

The 777-100X was a proposed shortened ultra long range (16,000km/8635nm) model, dropped in favour of the 777-200LR (originally 777-200X) design study. Boeing claims the 777-200LR will be the longest ranging airliner, capable of flying 16,417km (8865nm) - 18 hours flying time. It will achieve this with awesomely powerful 489kN (110,000lb) thrust GE90-110B1 turbofans, a significantly increased max takeoff weight and optional auxiliary fuel tanks in the rear cargo hold. Other changes include 2m (6.5ft) raked wingtips, new main landing gear, structural strengthening and optional overhead crew and flight attendant rest stations above the cabin. The 777-200LR was launched in 2000, but is now delayed until 2006. 

The stretched 777-300 is described separately.',NULL,'Operational'),
('boeing777300','Boeing''s 777-300 is powered by the world''s most powerful turbofan engines.

The stretched 777-300 is designed as a replacement for early generation 747s (747-100s and 200s). Compared to the older 747s the stretched 777 has comparable passenger capacity and range, but burns one third less fuel and features 40% lower maintenance costs. 

Compared with the baseline 777-200 the 300 features a 10.13m (33ft 3in) stretch, comprising plugs fore and aft of the wings. The longer fuselage allows seating for up to 550 passengers in a single class high density configuration. To cope with the stretch and the up to 13 tonne (28,600lb) increased max takeoff weight the 300 features a strengthened undercarriage, airframe and inboard wing. Other changes compared with the 777-200 include a tailskid and ground manoeuvring cameras mounted on the horizontal tail and underneath the forward fuselage. Otherwise changes have been kept to a minimum to maximise commonality. 

Boeing publicly announced it was developing the 777-300 at the Paris Airshow in mid June 1995 where it revealed it had secured 31 firm orders from All Nippon, Cathay Pacific, Korean Airlines and Thai Airways. Later that month Boeing''s board authorised production of the new aircraft. 

The 777-300 rolled out on September 8 1997, followed by first flight on October 16 that year. The type made history on May 4 1998 when it was awarded type certification simultaneously from the US FAA and European JAA and was granted 180min ETOPS approval. Service entry with Cathay Pacific was later in that month. 

Like the 777-200, a 777-300ER long range version has been developed. Changes made to the 777-300ER are more powerful General Electric GE90-115B engines (currently the world''s most powerful jet engine), raked wingtips, strengthened body, wings, empennage, nose gear, engine struts and nacelles, new main landing gear, and provision for extra fuel tanks. The range, carrying 365 passengers, is increased up to 13,427km (7,250nm).

Roll-out of the first 777-300ER was made on November 14 2002, followed by the first flight on February 24 2003. First delivery, to Air France, is scheduled for March 2004.',NULL,'Operational'),
('boeing7878dreamliner','The Boeing 7E7 was announced on 29th January 2003 following the cancellation of the Sonic Cruiser. The aircraft was renamed the Boeing 787 in 2005.

This important design marked a major shift in technology for Boeing, which aimed for maximum fuel efficiency in a number of ways. Chief among these was a radical change of construction material, with much of the aircraft being built of carbon fibre reinforced plastic (CFRP). Additionally, the fuselage was produced as ''barrels'' rather than sheets of material, reducing the number of fastenings required. This further increased the weight savings. Many of the aircraft''s systems are now electrically operated, replacing the heavier hydraulic systems of earlier Boeing designs with lighter technology.

The engines are new designs with increased fuel efficiency. Both the General Electric GEnx and Rolls-Royce Trent 1000 designs are available. Boeing decided to use bleedless designs, another major change for aircraft of this class. Interestingly, Airbus decided not to use bleedless technology on its competing Airbus A350 design and it remains to be seen which approach offers the greatest benefits over the other. The rear engine nacelle has a distinctive rippled look which reduces noise as the engine exhaust and external air mix.

For passengers, there have been a number of technology improvements. Most noticeably, the windows are amongst the largest in a civil airliner and are lower on the fuselage than is usual, so that passengers have a better view downwards. The lighting system use LED technology allowing each customer great flexibility on the lighting schemes it can use. The pressurisation system features a lower cabin altitude than normal and allows increased humidity, both factors which will contribute to passenger comfort during a long flight.

With all these technology advances and a distributed manufacturing program that was very new to Boeing, it is not suprising that the program encountered a number of delays. However, the first aircraft was delivered to a customer, All Nippon Airways, in September 2011.',NULL,'Operational'),
('boeingb17flyingfortress','The Fortress was originally designed to meet a bomber specification issued by the U.S. Army Air Corps in 1934. The prototype, Boeing Model 299, first flew on July 28, 1935 and the first Y1B-17 of a production order of thirteen was delivered to the Air Corps in March, 1937. In January, 1939 an experimental Y1B-17A fitted with turbo-supercharged engines was delivered to the Army Air Corps. Following successful trials with this aircraft an order for 39 was placed for this model under the designation B-17B.

The B-17G was introduced onto the Fortress production line in July of 1943, and was destined to be produced in larger numbers than any other Fortress variant. The most readily-noticeable innovation introduced by the B-17G was the power-operated Bendix turret mounted in a chin-type installation underneath the nose. This turret was equipped with two 0.50-inch machine guns. This installation had first been tested in combat by the YB-40 and was found to be the only viable innovation introduced by the unsuccessful escort Fortress. Another innovation introduced by the G was having the waist guns being permanently enclosed behind windows instead of being mounted behind removable hatches. This made the rear fuselage somewhat less drafty. The cheek nose guns introduced on the late B-17F were retained, but were staggered so that the left gun was in the forward side window and the right gun was in the middle side window, which reversed the positions used on the late Fs. The cheek gun mounts bulged somewhat outward into the airstream, which helped to improve the forward view from the cheek gun positions. The forward chin installation and the associated cheek guns were first tested out on B-17F-115-BO 42-30631. Originally, the Bendix turret was to be introduced on the Boeing production line with F-135, but the changes were sufficient to justify a new series letter, and the F-135s became G-1. 

The B-17G now had the defensive firepower of no less than thirteen 0.50-inch machine guns: two chin guns, two cheek guns, two guns in the dorsal turret, two guns in the ventral turret, two guns in the waist, two guns in the tail and one gun in the roof of the radio operator''s position. B-17Gs were built by all three members of the "B.V.D." production pool, with the Boeing lots ranging from production blocks G-1 to G-110, the Douglas blocks ranging from -5 to -95, and the Lockheed-Vega blocks ranging from -1 to -110.

The B-17G entered service with the Eighth and Fifteenth Air Forces in late 1943. Camouflage paint was deleted from production B-17Gs starting in January of 1944. B-17Gs were delivered in natural metal finish starting in (but not at the beginning) of production blocks G-35-BO (Boeing), G-20-VE (Lockheed-Vega), and G-35-DL (Douglas-Long Beach). The so-called "Cheyenne" tail gun mounting modifications were incorporated in the B-17G-80-BO, -45-DL, -35-VE and subsequent batches. These tail gun mountings also had a reflector gunsight instead of the previous ring and bead. With this installation, these B-17Gs were five inches shorter than the earlier versions. On later production versions, it was found necessary to stagger the waist gun positions so that the two gunners would not get in each other''s way. On the last production batches (B-17G-105 and -110-BO, B-17G-75 to -85-DL, and B-17G-85 to -110-VE), the radio compartment gun was not installed. The ammunition capacity of the waist guns was increased to 600 rpg. When production terminated in 1945, a total of 4035 B-17Gs had been built by Boeing, 2395 by Douglas and 2250 by Lockheed-Vega. The last Boeing-built B-17G was delivered on April 13, 1945. B-17G-1-VE 42-38940 was redesignated XB-17G when assigned to test work. It was not a prototype.',NULL,'Operational'),
('boeingc97stratofreighter','Boeing''s Stratofreighter formed the backbone of the US Air Force''s Military Airlift Transport Service (MATS) during the early 1950s, and more than 800 were built for use as freighters and air-to-air refuellers. 

The Model 367 Stratofreighter is based on the Boeing B-29 Superfortress, the Allies'' most technologically advanced bomber to see service in World War 2, and an aircraft famous (or infamous) for dropping the only atomic bombs used operationally in warfare on Japan in the closing stages of that conflict. The B-29 flew for the first time in September 1942 by which time Boeing had already studied a transport version, utilising the B-29''s wing, engines, tail and lower fuselage, combined with a new upper fuselage section. The new double lobe fuselage shape was very distinctive, and also formed the basis for future Boeing jet airliner fuselage cross sections. 

The US Army Air Force was impressed with Boeing''s proposals and ordered three prototypes be built, the first of which flew on November 15 1944. Ten development YC-97s were subsequently ordered, the last of which represented production aircraft, featuring the more powerful R-4360 engines and taller tail developed for the B-50, an improved B-29. The first production C-97A was delivered in October 1949. 

Development of the C-97 led to the C-97C, which was used for casualty evacuation, and the KC-97E, KC-97F and KC-97G aerial tankers. More than 590 KC-97Gs were built. The KC-97 was the US Air Force''s primary tanker until replaced by the jet powered KC-135, the predecessor to the Boeing 707. Small numbers of 377 Stratocruiser airliners were also built, but the last of these have long been retired. 

Many Stratofreighters survived their military service to be acquired by civilian operators for use as freighters and fire bombers. Only two were still airworthy in 2002, one of them operated by the Berlin Airlift Historical Foundation and the other as a firefighter by Hawkins & Powers.',NULL,'Operational'),
('boeingcommercialchinook','The Boeing Helicopters Model 234 Commercial Chinook is, as its name suggests, a commercial variant of the successful CH47 Chinook military airlifter. <p>The Chinook was developed for the US Army and first flew in September 1961, and since then has been developed into a number of progressively improved variants. The Commercial Chinook was not launched until 1978, following a British Airways Helicopters order for three for North Sea oil rig support missions. The Commercial Chinook''s first flight occurred on August 19 1980, certification was granted in June 1981, and service entry was the following month. <p>Largely identical in configuration to the CH47, the Commercial Chinook retains the former''s rear cargo ramp, but has a slightly reprofiled nose, commercial avionics and large passenger windows along both sides of the main cabin. <p>The initial orders were for the 234 LR Long Range, which compared with the CH47 has roughly twice the fuel load, plus a 44 seat passenger interior based on that used in Boeing jetliners. A number of other versions were offered - the 234 ER Extended Range with additional tankage, the 234 UT Utility, and 234 MLR Multi purpose Long Range which can be used for passenger or freight operations, or a combination of both. <p>',NULL,'Operational'),
('boeingmdexplorer','Developed by McDonnell Douglas, the Boeing MD Explorer light twin helicopter is the first all new design to incorporate the unique NOTAR (NO TAil Rotor) system. <p>McDonnell Douglas Helicopters launched the Explorer as the MDX in January 1989. First flight took place on December 18 1992. Full certification for the initial PW206B powered MD 900 version was granted in December 1994. <p>One of the most advanced helicopters in its market segment, the MD Explorer features Boeing''s unique NOTAR anti torque system (described in detail under the MD 520N entry), with benefits including increased safety, far lower noise levels and performance and controllability enhancements. <p>The design also features an advanced bearingless five blade main rotor with composite blades, plus a carbonfibre fuselage and tail. Initial aircraft are powered by two Pratt & Whitney Canada PW206Bs (the Explorer was the first application for the PW200 series). <p>The improved Explorer 902 replaced the MD 900 in September 1997. Features of the MD 902 include PW206E engines with higher one engine inoperative ratings, revised engine air inlets, improved NOTAR inlet design and a more powerful stabiliser control system. Benefits include improved range and endurance and an increased max takeoff weight. <p>On August 31 1998 the 902 configured Explorer became the first helicopter to be validated by Europe''s JAA JAR Part 27 Category A guidelines, which requires helicopters be capable of safely continuing flight during takeoff or landing on a single engine. <p>Like the MD 520N and MD 600N singles the MD Explorer line is for sale. In 1998 US regulatory authorities prohibited a planned sale of all three lines to Bell. Belgian company HeliFly has expressed an interest. <p>',NULL,'Operational'),
('boeingstearman','The Boeing Stearman is perhaps the most widely known and recognised biplane in the USA, as it was that country''s primary basic trainer throughout World War 2. 

This famous biplane began life as a design of the Stearman Division of United Aircraft (at that time United Aircraft also owned Boeing and United Airlines), which Boeing acquired as a wholly owned subsidiary in 1934. At the time of the takeover development on the X-70 training biplane was well advanced, and Stearman continued work on the type under Boeing ownership. The prototype of the Stearman Model 75, as the X70 became, flew for the first time in 1936. That year Stearman delivered the first production Model 35s, as the PT13, to the US Army Air Corps. That service immediately found the Lycoming R680 powered PT13 to be an ideal basic trainer, the airframe was rugged and forgiving, and the slow turning radial engine reliable and reasonably economical. 

America''s entry into World War 2 brought with it massive requirements for pilot training and the US Army and Navy went on to buy thousands of PT13s and Continental engined PT17s and N2Ss. During the war almost all American pilots undertook basic training on the PT13 or PT17, and the type was exported to Canada (as the Kaydet), Britain and other nations. Apart from in Canada the Kaydet name was unofficially widely adopted for the type. 

Postwar, the Stearman''s rugged construction and good low speed handling saw large numbers converted for agricultural spraying work. Many conversions involved replacing the Stearman''s fabric covering with metal (to avoid problems with chemical contamination), while many were fitted with more powerful 335kW (450hp) P&W R985A61 radials. 

Today many hundred Stearmans are still flown in private hands, although its crop spraying days are mostly over.',NULL,'Operational'),
('boeingvertolkawasakikv107','Boeing Vertol''s Model 107 is best known as the military CH46 Sea Knight, but small numbers were built as airliners and utility transports for commercial customers. <p>The then independent Vertol company (previously Piasecki) designed the 107 in the late 1950s as a medium lift helicopter for US Army evaluation. Three prototype Lycoming turboshaft powered Vertol 107s were built (the Army ordered 10) designated YHC1As, and first flight occurred on August 27 1958. By that time though the Army''s interest had switched to what would become the Chinook and it placed no orders. However in February 1961 Vertol (Boeing acquired Vertol in 1960) won a US Marine Corps competition with a developed General Electric T58GE8 powered version of the BV 107, and the type was ordered into production as the CH46A Sea Knight. <p>The commercial 107 is based on the CH46A powered by the civilianised CT58110 (equivalent to the T58GE8). The first commercial 107 to fly was one of the three original development aircraft built for the US Army converted to the new standard, its first flight in the new configuration was on October 25 1960. Offered in two forms, the KV 107/II1 utility transport and KV 107/II2 airliner, only the latter was built. KV 107/II2 customers included New York Airlines, who ordered three configured to seat 25, Columbia Helicopters in the US (Columbia still operates KV 107s) and Japan''s Air Lift. A more powerful 1045kW (1400shp) CT581401 powered longer range KV 107/IIA17 was offered and one was built for the Tokyo Police. <p>Japan''s Kawasaki built all commercial 107s, and has held manufacturing rights to the 107 since 1965. Kawasaki has also built KV 107s for the Japanese military and Saudi Arabia. <p>',NULL,'Operational'),
('bombardierbd100challenger300','Bombardier''s all new Challenger 300 is a transcontinental range eight-seat corporate jet which will sit in the company''s model line-up between the Learjet 60 and Challenger 604. It is developed for a non-stop 5471km (3100nm) mission with a load of eight passengers and NBAA IFR reserves.

Bombardier revealed it was developing the Continental (as it was known then) at the 1998 National Business Aircraft Association''s annual convention in Las Vegas in October 1998. The program was officially launched at the Paris Air Show on June 13, 1999. It would compete for what Bombardier sees as a market for 1230 super mid size corporate jets by 2012. The Continental was renamed Challenger 300 on September 9, 2002. 

The new jet will compete with the Hawker Horizon and Galaxy, among others. Bombardier claims the Continental will offer 39% more cabin space and 20% more range "than the leading mid size business jet". It is also claimed to have a larger cabin than the intercontinental range Falcon 50 and high speed Citation X. 

Features of the Challenger 300 are a cockpit equipped with Collins Pro Line 21 four-tube EFIS, EICAS, TCASII, and EGPWS avionics, a standard eight place double club interior with galley and toilet, stand-up headroom, a flat floor, an auxiliary power unit and thrust reversers, all metal construction and a large area wing for good field performance. 

The Challenger 300 has a primarily light-alloy structure, with composites used for some non-structural items. The fuselage is of a semi-monocoque construction with frames and stringers. The wing has two spars. 

The first Continental risk sharing partner is AlliedSignal, which will supply its new FADEC equipped AS-907 turbofan to power the new jet, as well as the engine nacelles and thrust reversers. The AS-907 itself is developed with a number of partner companies, with AIDC of Taiwan selected to provide the fan.

Wing/fuselage mating of the first aircraft was achieved on November 19, 2000. The first flight was made on August 14, 2001, and certification is due in the third quarter of 2002. The aircraft will start corporate service in 2003.  

The Challenger 300 made its official debut at Orlando Executive Airport on September 8, 2002 at the NBAA Convention. At that time, four aircraft were flying in the test program.',NULL,'Operational'),
('bombardierbd700globalexpress','The Global Express is one of a new class of ultra long range corporate jets, and competes against the Gulfstream V, Boeing 737 BBJ and Airbus A319CJ (all described separately). 

Designed to fly long distances at high speed, the Global Express'' range is such that it can fly between any two points on the globe and need only one refuelling stop, while it can fly nonstop between intercontinental destinations such as Sydney/Los Angeles, New York/Tokyo and Taipei/Chicago. 

Bombardier''s Canadair division announced development of the Global Express in October 1991 at the annual NBAA conference in the USA. Officially launched on December 20 1993, it flew for the first time on October 13 1996, with Canadian certification awarded on July 31 1998 and US certification following in November that year. First customer deliveries are planned for first quarter of 1999. 

The Global Express shares the Canadair Regional Jet''s fuselage cross section and is similar in length, but despite the size similarities the two aircraft are very different due to the nature of their roles. The Global Express features an advanced all new supercritical wing with a 35° sweep and winglets, plus a new Ttail. The engines are BMW RollsRoyce BR-710s with FADEC. The advanced flightdeck features a six screen Honeywell Primus 2000 XP EFIS suite and is offered with optional heads-up displays.

Three Bombardier divisions are involved with the Global Express - Canadair is the Global Express'' design leader and manufactures the nose; Shorts is responsible for the design and manufacture of the engine nacelles, horizontal stabiliser and forward fuselage; and de Havilland at Downsview is responsible for final assembly and builds the rear fuselage and vertical tail. In addition, Japan''s Mitsubishi Heavy Industries builds the wing and centre fuselage sections in Nagoya.',NULL,'Operational'),
('bombardierlearjet45','The new Bombardier Learjet 45 is Learjet''s latest entry into the medium size corporate jet market. 

Bombardier owned Learjet announced it was developing the Model 45 at the US National Business Aircraft Association''s annual convention in Dallas in September 1992. First flight was on October 7 1995 (the 32nd anniversary of the original Lear 23), and, after some delays, US FAA certification was granted on September 22 1997. The first customer aircraft was delivered in January 1998 

The 45 is of classic Learjet design and layout. However a number of key design changes were made early into the 45''s design life including a larger fin and rudder, extended engine pylons, smaller delta fins, full span elevators, and single piece flaps. 

Larger than the Learjet 31 and smaller than the 60, Learjet states that the 45''s 1.50m (4.9ft) high and 1.55m (5.1ft) wide cabin will provide more head and shoulder room than any other aircraft in its class. The cabin is designed to accommodate double club seating, a galley and a full width aft rest room, while eight windows line each side of the cabin. 

The flightdeck features a four screen (two primary flight displays and two multifunction displays) Honeywell Primus 1000 integrated avionics suite, while an APU is standard. 

The 20 FADEC equipped version of the proven AlliedSignal TFE731 engine was developed in cooperation with Learjet for the 45 and incorporates 60 design changes to increase fuel economy and reduce operating and maintenance costs. 

While Learjet retains overall 45 program leadership, and is responsible for the aircraft''s design, other Bombardier Group companies participate in Learjet 45 production. De Havilland Inc in Canada is responsible for wing construction, while Shorts of Northern Ireland in the UK builds the fuselage and empennage.',NULL,'Operational'),
('bombardierlearjet5560','The Learjet 55 and its followon successor, the Learjet 60, are the largest members of the Learjet family, and date back to development work undertaken in the late 1970s. 

In designing the 55, Learjet (or Gates Learjet as the company was then known as) took the wing of the earlier Longhorn 28/29 series and married it to an all new larger 10 seat fuselage. The original Model 55 Longhorn prototype first flew on November 15 1979. The first production aircraft meanwhile flew on August 11 1980, with the first delivered in late April 1981 (after FAA certification was granted in March that year). 

Development of the 55 led to a number of sub variants, including the 55B which introduced a digital flightdeck, modified wings, improved interior, and most importantly, the previous optional higher takeoff weights becoming standard. The 55C introduced `Delta Fins'' which gave a number of performance and handling advantages, the 55C/ER is an extended range version with additional fuel in the tail cone (the additional tank can be retrofitted to earlier aircraft), while the 55C/LR introduced more fuel capacity. 

The improved Learjet 60 first flew in its basic definitive form in June 1991 (the modified Learjet 55 prototype earlier served as a proof of concept aircraft for the 60 with Garrett engines). It differs from the 55 in having a 1.09m (43in) fuselage stretch and new Pratt & Whitney Canada PW305 turbofans. Certification of the 60 was awarded in January 1993, with first deliveries following shortly afterwards. 

 

 

 International Directory of Civil Aircraft',NULL,'Operational'),
('brantlyb2305','The Brantly B2 series of light helicopters first flew in the early 1950s and returned to production in the early 1990s, while the larger five seat 305 dates to the early 1970s. <p>The original B2 two seat light helicopter was designed and built by Mr N Brantly, and flew for the first time on February 21 1953. Certification was awarded in April 1959 allowing production deliveries to get underway soon after. The initial production B2 model featured a 135kW (180hp) VO360A1A flat four, the same basic powerplant that powered the B2 series through to the 1990s. The initial B2 was followed by the improved B2A with a redesigned cabin and the B2B, which became the definitive production model. <p>Brantly also developed a larger five seat Model 305 based on the B2, with a larger cabin and more powerful VO540 engine. The 305 first flew in January 1964 and was certificated in July the following year. <p>Brantly production ceased in the early 1970s after more than 400 B2s had been built. However production resumed in 1976 when the Hynes company acquired the design and production rights to what became the BrantlyHynes B2 and 305. <p>BrantlyHynes continued low rate manufacture of both models through to the mid 1980s when it too ceased production. Finally in 1989 James Kimura formed Brantly Helicopter Industries to build both models, and low rate production resumed for a time. By 1998 the Chinese backed Brantly International Inc had resumed low rate B2B production at Vernon, Texas. <p>',NULL,'Operational'),
('bristol170freighter','Design of the Bristol Freighter began in 1944 in anticipation of demand for a rugged airliner and freighter once WW2 was over, plus potential military requirements.

Bristol''s Type 170 started out as a private venture design and was developed under the leadership of technical director L G Frise (who also designed the Frise aileron). Design features of the 170 include its slab sided fuselage, fixed taildragger undercarriage, clamshell style nose doors, raised flightdeck, and a relatively large wing of two spar construction with swept back leading edge and straight trailing edge. As originally proposed the 170 was to be powered by improved sleeve valve Bristol Perseus radials.

The 170 soon caught the British Air Staff''s attention which considered the design well suited for use in the India-Burma theatre carrying supplies and vehicles to jungle strips. Two prototypes were ordered with a slightly enlarged fuselage and more powerful Hercules 630 radials.

The 170 made its first flight from Filton on December 2 1945 and while it was too late to be ordered into production for military service in WW2 the type''s potential had been demonstrated. The second prototype, configured in 32 seat Wayfarer airliner form (without the nose freight doors) flew the following April. Civil certification was granted in June 1946.

Early production was of the Mk1 Freighter and Mk2 Wayfarer. The Mk11 (later the Mk21) was unveiled at the 1947 SBAC airshow and introduced rounded wingtips and more powerful Hercules 672 engines, allowing an increase in gross weight of 1360kg (3000lb). The Mk31 introduced more powerful engines and remained in production until 1950.

The final 170 model is the Mk32, developed at the request of Silver City Airways. The Mk32 featured a lengthened nose which allowed it to carry three cars, rather than two, in a car ferry configuration.

The last flight of a Bristol 170 was made on September 6 2004, when Hawkair Aviation ferried C-GYQS to the Reynolds Alberta Museum in Wetaskiwin, Alberta, Canada.',NULL,'Operational'),
('britishaerospaceatp','The largest twin turboprop powered western regional airliners currently in service, the ATP and Jetstream 61 trace their development history back to the British Aerospace 748. 

The ATP and J61 are stretched developments of the 748, but they incorporate a great number of major and minor detail changes. The 748''s fuselage cross section and basic wing structure were retained, but otherwise the ATP and J61 are all new aircraft. 

British Aerospace announced it was developing an advanced derivative of the 748 in March 1984. The BAe ATP, or Advanced TurboProp, first flew on August 6 1986, while the first production aircraft flew in February 1988. Certification was granted in March 1988 and the ATP entered airline service that May. 

Compared to the 748 the ATP features a stretched fuselage taking maximum seating up to 72 passengers, while Pratt & Whitney Canada PW126 turboprops drive slow turning six blade propellers. Much of the systems and equipment was new or significantly improved. The flightdeck has EFIS instrumentation, while the cabin interior was thoroughly revised and modernised. The nose was reprofiled and some sweep back was added to the tail. 

The further improved Jetstream 61 was marketed and built by the newly created BAe division of Jetstream Aircraft. Apart from the name change it introduced a number of minor technical changes including an interior based on the Jetstream 41 (including the innovative arm rests incorporated into the cabin walls for window seats), more powerful PW127D engines and increased operating weights giving higher speeds and longer range. The Jetstream 61 was available for delivery from 1994, but marketing efforts ceased when the AI(R) consortium was formed because it was a direct competitor to the now disbanded consortium''s far more successful ATR 72. Just four were completed. 

Meanwhile the last three whitetail ATPs were not sold until late 1998 (two went to British World, one to SunAir of Scandinavia). 

 

 

 International Directory of Civil Aircraft',NULL,'Operational'),
('britishaerospaceavrorj7085100','The Avro RJ series are upgraded developments of the BAe-146 family (see separate entry), and like the 146 was built in three fuselage length variants, the RJ70, RJ85 and RJ100.

In 1990 British Aerospace first offered the improved RJ70 and RJ80, both of which were based on the 146-100. They would have seated 70 and 80 passengers respectively, but these two designs matured in the Avro RJ70 (officially Avro 146-RJ70) with improved FADEC equipped LF-507 engines and digital avionics. 

The 146-200 based Avro RJ85 was the first member of the new family to fly, on March 23 1992. The biggest member of the family, the 146-300 based RJ100, first flew on May 13 1992. The 146-100 based RJ70 was delivered from late 1993 but due to low customer interest, only 12 were sold.

RJ improvements over the 146 include more reliable and efficient FADEC equipped AlliedSignal (now Honeywell) LF-507 engines, new "Spaceliner" cabin interior and a digital flightdeck. Weight and drag savings were introduced in 1996.

The RJ100 was also offered as the RJ115 with extra emergency exits to seat 116 to 128 in a high density six abreast configuration. None were built however. The RJ was also offered as the Avro Business Jet, but also none of these were built.   

The RJ series was originally manufactured and marketed by Avro International Aerospace, a separate British Aerospace company, so named as RJ production was undertaken at the former Avro factory near Manchester (most 146s were built at Hatfield). Subsequent plans for a partnership with Taiwan Aerospace, which would have seen the RJ series built in Taiwan fell through and Avro subsequently became part of AI(R) to handle marketing, sales and support of British Aerospace (Avro and Jetstream) and ATR commercial aircraft. However, AI(R) disbanded in mid 1998 and the Avro RJ range became again a  British Aerospace (later BAE Systems) product.

The last RJ was delivered in 2002. A modernised development became the Avro RJX, for which see the  separate entry.',NULL,'Operational'),
('britishaerospacebae146','The BAe-146 family, which includes the Avro RJ and the cancelled RJX (both described separately), is likely to remain Britain''s most succesful jet transport program, with 395 built.

In August 1973 the then Hawker Siddeley Aviation announced it was designing a short range quiet airliner powered by four small turbofans with British government financial aid. Under the designation HS-146, large scale development lasted just a few months before a worsening economic recession made the risk of the project seem unjustifiable. Development then continued on a limited scale, but it was not until July 1978 that the project was officially relaunched, by which time Hawker Siddeley had been absorbed into the newly created British Aerospace. 

The resulting BAe-146-100 made its first flight on September 3 1981. Certification was granted in early 1983 with first deliveries following shortly afterwards in May 1983. A VIP version was offered as the "Statesman" which was ordered by the Royal Air Force as the BAe-146 CC2, the standard transport version being the BAe-146 C1. An air refuel receptacle equipped military version, the -100STA flew in prototype form only. 

The BAe-146-200 is a stretch of the 146-100, and is essentially similar to its smaller stablemate, but has a 2.39m (7ft 8in) longer fuselage, features 35% greater underfloor cargo volume, has slightly different performance figures and heavier weights. The stretch consists of five extra fuselage frame pitches. The first BAe-146-200 made the type''s maiden flight on August 1 1982, while the UK Civil Aviation Authority awarded the 146-200s type certificate on February 4 the following year.

Versions of the 146-200 include the -200QT Quiet Trader freighter, which has been fairly succesful because of its low external noise footprint, and the -200QC (Quick Change) passenger or freight convertible.

The 146-300 is a further stretched derivative of the original short fuselage BAe-146-100, but unlike the midsize 200 series, was not developed until later in the 1980s. The first 146-300, an aerodynamic prototype based on the original prototype 146-100, flew for the first time on May 1 1987, with certification granted that September.

Like the 146-200, a freighter version of the 300 series is known as the 146-300QT Quiet Trader. The prototype -300 was converted to 146-301ARA configuration, an atmospheric research aircraft operated by the Facility for Airborne Atmospheric Measurements as a replacement for the previously operated Hercules W2.

The last of the original 146s were built in 1993, with the series succeeded by the Avro 146-RJ family, described separately.',NULL,'Operational'),
('britishaerospacejetstream31super31','The successful Jetstream 31 traces its ancestry to the Turboméca Astazou powered Handley Page HP-137 Jetstream 1. 

The HP-137 was designed as early ago as 1965, and flew for the first time on August 18 1967. Initial Handley Page production aircraft were powered by 635kW (850hp) Astazou XIVs and named Jetstream 1 (36 built), but deliveries were delayed by excess weight and drag problems. To overcome these problems Handley Page developed the Jetstream 2 with more powerful 800kW (1073shp) Astazou XIVCs. However Handley Page ran into serious financial difficulties in the late 1960s (causing the US Air Force to cancel an order for 10 Garrett TPE331 powered C-10A Jetstreams [3Ms]) and it folded in 1969, bringing to an end development of the more powerful Jetstream 2 and plans to market a civil version of the 3M in the USA. 

A few unfinished aircraft were completed by Terravia, and development of the Jetstream 2 resumed in 1970 as the Jetstream 200 under the control of the newly formed Jetstream Aircraft in collaboration with Scottish Aviation. Scottish Aviation later assumed overall responsibility for the Jetstream and built a number as navigation and multi-engine trainers for Britain''s military services as the Jetstream T1 and T2. Development continued after Scottish Aviation was merged into British Aerospace in 1977, and work on the Jetstream 31 (or J31) began in 1978. The first flight of the Garrett TPE331 powered Jetstream 31 (a converted HP-137) occurred on March 28 1980. The first production aircraft flew in March 1982, UK certification was granted in June 1982. In British Naval service the J31 is designated the Jetstream T3. 

Subsequent development led to the Super 31, certificated in October 1988. The Super 31 (or unofficially J32) features uprated engines, higher weights and better performance. The last J31/J32 was built in 1993. 

Since 1997 British Aerospace Asset Management has been offering for sale or lease the upgraded J32EP (Enhanced Performance). Its minor aerodynamic and drag improvements enhance payload range and hot and high performance.',NULL,'Operational'),
('britishaerospacejetstream41','The Jetstream 41 is a stretched and modernised development of the 19 seat Jetstream 31, designed to compete in the 29 seat commuter airliner class alongside such types as the Brasilia, Dornier 328 and Saab 340. 

The Jetstream 41 (or J41) is based on the J31, but features a 4.88m (16ft) fuselage stretch, consisting of a 2.51m (8ft 3in) plug forward of the wing and a 2.36m (7ft 9in) stretch rear. The increased span wing (with reworked ailerons and flaps) is mounted lower on the fuselage so that it does not carry through the fuselage and interrupt the interior cabin aisle, unlike on the Jetstream 31. Other airframe modifications included a new reprofiled six piece windscreen and extended wing root fairing with greater baggage capacity. More powerful AlliedSignal TPE331 turboprops, mounted in new nacelles with increased ground clearance, drive advanced five blade McCauley propellers. The flightdeck has modern EFIS glass displays. 

Development work on the J41 was announced in mid 1989, resulting in the type''s first flight on September 25 1991. Three further aircraft were also used in the flight test program, with European JAA certification being awarded on November 23 1992. The first delivery occurred two days later on November 25. 

From mid 1994, all aircraft delivered benefited from various payload and range performance improvements, resulting from uprated engines and a higher maximum takeoff weight. 

The J41 was initially known as the BAe Jetstream 41, but BAe''s establishment of a separate Jetstream Aircraft division in mid 1993 saw the name simplified to just Jetstream 41. From January 1996 the J41 became part of the Aero International (Regional) stable, but in May 1997 BAe announced that it was terminating J41 production. 

Field Aircraft of the UK and Pilatus of Switzerland were risk sharing partners, while Gulfstream was to build 200 wingsets.',NULL,'Operational'),
('brittennormanbn2islander','The BN-2 Islander was Britten-Norman''s second original design, work on which began during 1963. 

Developed as a Dragon Rapide replacement, the emphasis was on producing a rugged and durable aircraft that had good field performance, low operating costs and was easy to maintain. One unusual feature is that there is no centre aisle between seats in the main cabin, instead there are three doors along each side of the fuselage for passenger boarding. The prototype BN-2 Islander was powered by two 155kW (210hp) IO-360s and first flight was on June 13 1965. 

The first production machines were powered by 195kW (260hp) IO-540s and were simply designated BN-2, the first flew in 1967. A small number were built before production switched to the BN-2A which introduced fairings to the main undercarriage legs, wing leading edge and flap droop, and an increased max takeoff weight. From 1970 the base A model was the BN-2A-6 and the BN-2A-7 had extended wingtips, while the BN-2A-2 and BN-2A-3 were powered by the 225kW (300hp) IO-540, the latter with the extended wingtips. 

Appearing in 1972 were the 195kW (260hp) powered BN-2A-26 and extended wingtips BN-2A-27, and the 225kW (300hp) BN-2A-20 and extended wingtips BN-2A-21, all four models having higher weights. Further improvements came with the BN-2B range with higher weights, improved interior and instrument panel and shorter diameter props. The 26, 27, 20 and 21 variants were available as before. The 27 and 21 were later dropped while the BN-2B-20 and BN-2B-26 remain in production. The turboprop (Allison 250) powered BN-2T has been built since 1981.

In September1979 Britten-Norman became Pilatus Britten-Norman, in July 1998 it was renamed back to Britten-Norman, and from April 2000 it became B-N Group.',NULL,'Operational'),
('brittennormanbn2amk3trislander','The three engined Trislander takes its inspiration from the configurations of trijets such as the L-1011 and DC-10 in its answer to the need for more power for a stretched version of the Islander (described separately). 

Britten-Norman research showed that there existed sufficient market demand to warrant the development of a stretched Islander, and the company concluded that any stretched version would need to offer a 50% increase in internal capacity. The company''s novel approach to the need for more power was to add a third engine, rather than two engines of increased power output. A nose mounted engine in the fashion of the Ju-52 was considered, but due to the Islander''s nose configuration, BrittenNorman settled on mounting the engine on the vertical tail, resulting in the BN-2A Mk.3 Trislander. 

The tail mounted engine involved significant modification to the tail and strengthening of the rear fuselage. Other changes over the Islander include a 2.29m (7ft 6in) fuselage stretch forward of the wing, new main landing gear and larger diameter wheels and tyres. 

The first Trislander was in fact converted from the second Islander prototype, and it made the type''s first flight on September 11 1970. Early production Trislanders were also conversions of Islanders, while subsequent Trislanders were built on the same production line as the Islander. The first production Trislander flew on March 6 1971, certification was granted on May 14, and first deliveries to a customer occurred on June 29 that year. 

Britten-Norman Trislander production ceased in 1982 after 73 were ordered (by which stage the company had been acquired by Pilatus). Plans to produce the Trislander in the USA as the TriCommutair by the International Aviation Corporation, and in Australia never came to fruition. However one of 12 kits built for the TriCommutair project was assembled in Guernsey in the UK and flew in March 1996.',NULL,'Operational'),
('canadaircl215415','The CL-215 was designed as a specialist firebomber, particularly suited to Canada and other heavily forested regions. 

The resulting amphibious aircraft is powered by two Pratt & Whitney R-2800 radials, and is capable of scooping up 5455 litres (1200Imp gal/1440US gal) of water in 12 seconds from a water source. The CL-215 first flew on October 23 1967, and first delivery was to the French civil protection agency in June 1969. Production of batches of CL-215s continued through to 1990. 

Originally the subsequent CL-215T was to be a simple turboprop powered development of the CL-215, and Canadair converted two aircraft in 1989 to act as development aircraft. The first of these flew on June 8 that year. Retrofit kits for CL-215s to the new standard are offered, but Canadair elected not to build new CL-215Ts, and instead developed the CL-415. 

The primary improvement added to the CL-415 over the CL-215T is an EFIS avionics suite, while other improvements, some of which first appeared on the CL-215T, include winglets and finlets, higher weights and an increased capacity firebombing system. Like the CL-215 its principle mission is that of a firebomber, but various special mission (including SAR and maritime patrol) and transport configurations are available. 

The first CL-415 flew in December 1993 and was delivered from April 1994. The new CL-415GR has higher operating weights.',NULL,'Operational'),
('canadaircl44yukon','The CL-44 can be seen as an enhanced Bristol  Britannia 300. 
In mid 1950s the Royal Canadian Air Force has a requirement for a maritime patrol aircraft to replace their Lacanster aircraft serving in this role. What resulted was the CP-107 Argus. which was licence built on the base of the Bristol Britannia. The Argus differed from the Britannia in a number of significant respects - it was powered by Wright Turbo Compound radial engines (selected in place of turboprops to give better endurance and low speed performance at low altitude), and a redesigned unpressurised fuselage incorporating a weapons bay. With Canadair already producing the Argus, it was a relatively simple matter to offer a Britannia based design to meet an RCAF requirement for a transport to replace the aging DC-4M Northstar.

The transport became the CC-106 Yukon (or to Canadair, the CL-44-6). Twelve were built, featuring Rolls Royce Tyne turboprops, lengthened fuselage with two large conventional side freight doors. The wings and tail plane, landing gears and cockpit were kept mostly the same as on the Britannia. The first Yukon flew on November 15 1959. It also featured some extra military stuff which was not taken up on the civillian version. This included an APU, elektrik trimming, enhanced radar, transportable loading system etc. 

Canadair then began to offer the Yukon to commercial customers and developed the CL-44D-4, which featured a hinged tail which considerably simplified loading. (Swingtail) Due to new FAA/CAA regulations on visibility requirements the Britannia type winshields were replaced by newer and bigger windshield originating from the Convair 880. The first CL-44D-4 flew on November 16 1960, and at that time the model was the largest and first commercial freighter in the world to offer a 30t turn around in less then 60 minutes. The CL-44 is the first modern aircarft specially built for the commercial freight market. 

While all CL-44s in civil service have sooner or later been used as freighters, Loftleidir Icelandic Airline operated four CL-44Js plus a single CL-44D-4 in passenger configuration. The J, or  "Rolls Royce 400 JetProp", differed from the D-4s in that it featured a 4.62m (15ft 2in) fuselage stretch. It is the only aircraft to be redrawn from service, cut, stretched and put into service again. In late sixties the CL-44J was the largest passenger aircraft over the Atlantic ocean with 189 passengers. This was bigger then 707 and DC-8. 

One CL-44 was converted by Conroy Aircraft in the US as a large volume freighter. Jack Conroy was hoping to get the lucratif contract to fly Rolls Royce engines for the Tristar. Instead Lockheed stretched their own L-100 and flew the engines themselves. The CL-44-O "Guppy" got a new voluminous cargo hold (similar to the Boeing 377ST Super Guppy conversions), and it flew after conversion for the first time on November 26 1969. 

All military Yukons found their way into civil service in Africa and South America after retirement in 1973. In 2001 no J-model has survived. Only one Yukon is alive and six CL-44D-4 remain in poor condition. Most have been parked for years.',NULL,'Operational'),
('canadaircl600challenger600','The Canadair CL-600 Challenger had a troubled early history but formed the basis for what became a very successful business jet family. 

In 1976 Canadair purchased the exclusive production, development and marketing rights to an all new business jet developed by Learjet designer Bill Lear. Known as the LearStar 600, this design was first conceived in 1974. Notable for its large size cabin, the LearStar promised long range and good operating economics and was also one of the first aircraft to be designed with a supercritical wing. Lear initially planned that the LearStar would be a trijet, but the design had evolved to become a twin by the time Canadair purchased the rights. 

As the CL-600 Challenger, Canadair launched development of the LearStar design on October 29 1976 with 53 firm orders. Canadair made a small number of changes to the design including repositioning the horizontal tailplane to the top of the fin rather than on the fuselage. 

Three development Challengers were built, the first of which flew for the first time on November 8 1978, the others flying in March and July the following year. However the first aircraft crashed in a deep stall accident and while certification was granted in August 1980, temporary restrictions limited maximum takeoff weight to 14,970kg (33,000lb) and maximum speed to 587km/h (317kt), with flight into known icing conditions and the use of thrust reversers prohibited. 

A major weight and drag reduction program pared back the Challenger''s weight, improving range. The addition of General Electric CF-34 turbofans as options to the Challenger 601 (described separately under Bombardier), further addressed performance shortfalls and overcame problems with the ALF-502 turbofan. 

One version that failed to see the light of day was the Challenger 610E, which would have featured a fuselage stretch allowing seating for 24 passengers, but Canadair suspended development in 1981. 

Production of the 600 ceased in 1983, having switched to the much improved 601.',NULL,'Operational'),
('canadaircl600challenger601604','The Challenger 601 addressed the original CL-600 Challenger''s weight problems and replaced the troubled ALF-502 turbofans, creating a highly successful full size corporate jet. 

Troubles with the Avco Lycoming powered Challenger 600 led Canadair (now a division of Bombardier) to develop a vastly improved variant in the form of the General Electric CF-34 powered Challenger 601. Another important change was the addition of winglets, which are also offered as a retrofit to earlier aircraft. The 601 first flew on April 10 1982 and for a time was offered alongside the 600. The 600 was dropped from the model line in 1983. 

Subsequent development of the Challenger led to the 601-3A. First flying in 1987, this variant introduced an EFIS glass flightdeck and upgraded engines. Available from 1989, the 601-3R was an extended range model with higher weights (the range increase modifications can also be retrofitted to earlier 601-3As). 

Further improvements to the basic design led to the Challenger 604. Improvements include an advanced Collins ProLine IV EFIS avionics system with colour displays, higher weights, CF-34-3B turbofans and increased fuel tankage. Many other minor changes were incorporated based on Bombardier''s experience with the Canadair Regional Jet. First flight with CF-34-3A engines was in September 1994, first flight with the CF-34-3B engines was on March 17 1995, with Transport Canada certification granted that September. First delivery was in January 1996.',NULL,'Operational'),
('canadaircl600regionaljetcrj100200','Bombardier''s Canadair Regional Jet pioneered the new 50 seat jet class, and has since become a runaway sales success. 

The Canadair Regional Jet - or CRJ - is designed to offer the high speed advantages of much larger jets, with similar standards of service while at the same time offering operating economics, particularly over longer stage lengths, close to that of comparable size turboprops. 

The concept of a stretched airliner derivative of the Challenger is not new, Canadair (now part of Bombardier Aerospace) originally studied a 24 seat stretched development of the CL-600 up to 1981. Design studies for a stretched airliner based on the 601 however were first undertaken in 1987, leading Canadair to launch the Regional Jet program on March 31 1989. The first of three development aircraft took to the skies for the first time on May 10 1991. Transport Canada certification was awarded on July 31 1992, allowing the first customer delivery to Lufthansa that October. 

Major changes over the Challenger apart from the stretched fuselage include a new advanced wing optimised for airline operations, higher design weights, EFIS flightdeck with Collins Pro-Line 4 avionics suite, new undercarriage, additional fuel capacity and slightly more powerful CF-34 engines. 

The original CRJ-100 series - the 100, 100ER and 100LR - was augmented by the 200 series (with more efficient engines) in 1995. The Series 200 is available in standard 200, long range 200LR with optional greater fuel capacity, and the extended range Series 200LR (all three are offered in B form with CF34-3B1s for improved hot and high performance). Corporate shuttle configurations are also available as the Corporate Jetliner and the SE (Special Edition). 

The stretched, 70 seat CRJ-700 is described separately.',NULL,'Operational'),
('canadaircl600regionaljetcrj700','Bombardier''s 70 seat Canadair CRJ-700 is the first significant development of its fast selling 50 seat Canadair Regional Jet series. 

Definition and development work on the Series 700 commenced in 1995 when Bombardier began consultation with a 15 member airline advisory panel on what the airlines wanted in a 70 seat class regional jet. Prior to its January 1997 formal launch the Series 700 was dubbed the CRJ-X. 

Construction of the first prototype Series 700 began in late 1998 and first flight took place in May 1999. The CRJ-700 entered service in February 2001 with French airline Brit Air. 

Compared with the 50 seat CRJ Series 100/200, the Series 700 is stretched by 4.72m (15ft 6in) with plugs forward and aft of the wing, while the cabin is 6.02m (19ft 9in) longer, aided by moving the rear pressure bulkhead 1.29m (4ft 3in) aft. The cabin windows are raised by 12cm (5in), the cabin floor is lowered slightly and the ceiling raised to provide 1.90m (6ft 3in) headroom, and an underfloor baggage compartment under the forward fuselage is added. Other changes include relocating the APU to the rear fuselage and redesigned overhead stowage bins. 

The wing too comes in for attention, with span increased by a 1.83m (6ft 0in) wing root plug, while the leading edge is extended and high lift devices added. The main undercarriage units are lengthened and fitted with new wheels, tyres and brakes. 

Power is from two FADEC equipped General Electric CF-34-8C1 turbofans (which were selected in February 1995), while the flightdeck is based on that in the earlier CRJs and features six CRT displays presenting information from the Collins Pro Line 4 EFIS avionics suite. 

Like other Bombardier aircraft, the CRJ Series 700 is the product of a joint manufacturing effort. Canadair manufactures the wing and flightdeck and is responsible for final assembly, Mitsubishi builds the aft fuselage, Shorts is responsible for the fuselage and engine nacelles Avcorp the tail, and Westland the tailcone.',NULL,'Operational'),
('capaviationcap102021230231232','The successful CAP series of aerobatic aircraft dates back to the Piel CP-30 Emeraude of the early 1960s. 

Claude Piel designed the two seat Emeraude in France in the early 1960s for kit builders, but more than 200 were built in four different factories across Europe. The Emeraude first flew in 1962 and was built in basic 50kW (65hp) Continental A65 power CP-30 form and 65kW (90hp) Continental C90 CP-301 Super Emeraude form. 

One of the companies to build the Emeraude was CAARP, a company owned by Auguste Mudry. CAARP used the basic Emeraude design as the basis for the CAP-10, which was a similar aircraft other than its 135kW (180hp) Lycoming IO-360 engine and stressing for aerobatic flight. The prototype CAP-10 first flew in August 1968. CAARP built 30 CAP-10s for the French air force before Mudry started production for civil orders in 1972 at his other aviation company, Avions Mudry. 

The CAP-10 remains in production today in 10B form with an enlarged tail. The CAP-20 meanwhile was a single seat development with a 150kW (200hp) AIO-360 engine. 

The updated CAP-21 replaced the CAP-20 in 1981. The CAP-21 combined the fuselage of the CAP-20 with an all new wing and new undercarriage, and forms the basis for the similar CAP-231, CAP-231EX (with a carbon fibre wing) and latest CAP-232. 

Following Mudry''s bankruptcy in 1996, Akrotech Europe took over the CAP series in May 1997, and in January 1999 changed name to CAP Aviation.',NULL,'Operational'),
('casac212aviocar','Initially conceived as a light STOL transport for the Spanish air force, the CASA C212 has found a handy market niche and is highly regarded for its utility in underdeveloped regions. 

Designed to replace the Spanish air force''s mixed transport fleet of Douglas C47 Dakotas, CASA Azors and Junkers Ju 52s still in service in the 1960s, the C212 was also developed with the intention of offering a civil variant. Design work began in the late 1960s, the first prototype made the type''s first flight on March 26 1971. Preproduction examples followed, then the type entered air force service in 1974. The first commercial version was delivered in July 1975. 

The basic civil version was designated the C212C, the military version the C2125. Production of these models ceased in 1978, CASA switching to the Series 200 with more powerful engines and higher operating weights. The first Series 200, a converted C212C prototype, flew for the first time in its new configuration on April 30 1978. A third development of the Aviocar is the Series 300 which first flew in 1984 and was certificated in late 1987. Improvements to this model are newer engines and winglets. 

The latest development is the C212-400, which was launched at the 1997 Paris Airshow (after its first flight on April 4 that year). It features TPE331-12JR engines which maintain their power output to a higher altitude for improved hot and high performance and an EFIS flightdeck.',NULL,'Operational'),
('casaiptncn235','The CN235 regional airline and military tactical transport was developed and manufactured jointly by CASA from Spain and IPTN from Indonesia (the latter initially as Nurtanio, and as of October 1985 as Nusantara). A new company Airtech was formed to manage the program, but Airtech was not an aircraft manufacturer and never owned or operated any factories.

Each country built one prototype, and these rolled out simultaneously on 10 September 1983. The Spanish prototype flew first, on 11 November 1983, with the Indonesian-built aircraft following on 30 December 1983. Certification by both Spanish and Indonesian authorities and first deliveries (from the Indonesian line) occurred in December 1986. Entry into commercial service was in March 1988. 

Final assembly lines for the CN235 are in Spain and Indonesia, but all other construction is not duplicated. CASA is responsible for the centre and forward fuselage, wing centre section and inboard flaps, and engine nacelles. IPTN builds outer wings and flaps, ailerons, the rear fuselage and the tail unit. 

The initial production CN235-10 was soon replaced by the CASA-built CN235-100 and IPTN''s CN235-110, incorporating CT7-9C engines in place of CT7-7As, and new composite engine nacelles. Further improvements led to the CASA CN235-200 and similar IPTN CN235-220 with increased operating weights, better field performance and greater range, with structural improvements and improved leading edge flaps and rudder. The CN235-220 was certificated in March 1992. CASA and IPTN now develop their own CN235 variants independently. 

Other variants on the CN235 theme are the CN235 QC quick change capable of carrying passengers or freight or both; IPTN''s CN235 MPA maritime patrol aircraft and CASA''s CN235MP Persuader (which while primarily aimed at military customers, have customs and boarder patrol applications); and the widely ordered CN235 M multirole military freighter. CASA later developed the stretched C-295, primarily for military use. 

The CN235 has succeeded in achieving only a small number of commercial orders, mostly from Indonesian and Spanish operators. In contrast the CN235''s spacious interior and rear loading ramp has helped it win a significant number of military orders.',NULL,'Operational'),
('cessna150152','The introduction of the Cessna 150 marked Cessna''s return to the two seat trainer market after a six year absence and resulted in the most prolific and successful two seat trainer line in history. 

Development of the original 150 began in the mid 1950s, resulting in a first flight in September 1957. This modern, all new aircraft followed the Cessna conventions then gaining favour of a strut braced high wing, all metal construction and tricycle undercarriage. Production began in September 1958. 

What followed was a continuous process of product improvement, although throughout the 150 model life the Continental O-200A powerplant remained unchanged. One of the most significant model changes was the 150D of 1964 which introduced the wraparound rear window. Most versions were built in Standard, Commuter and Trainer forms with differing equipment levels, while licence production was undertaken in France by Reims and in Argentina by DINFIA. Aerobat versions were stressed for limited aerobatic work. 

The 152 was a response to availability problems with 80/87 octane fuel, and used the 150''s fuselage coupled with a Lycoming O-235 running on 100 Octane. The 152 replaced the 150 from 1977 and remained in production until late 1985. It too was progressively updated, offered in A152 Aerobat form, and also built in France.',NULL,'Operational'),
('cessna170','A larger four seat development of the earlier Cessna Model 120 and 140, the four seat 170 was in production for almost a decade, and is the predecessor to the successful and long running 172 series. 

The prototype Cessna 170 (NX41691) flew for the first time in September 1947. Notable features included the six cylinder 110kW (145hp) Continental C145 engine, extensive metal construction and the characteristic Cessna braced high wing. 

The first production Cessna 170s were delivered from March 1948, but this model was soon replaced by the improved 170A. The primary improvement with the 170A was metal instead of fabric covered wings, but it also featured increased tail area. 

The third and final major variant appeared in 1952. The Cessna 170B featured the most significant revisions to the line, including the large wing flaps (first developed for the military L-19 Bird Dog) that were to become characteristic of later single engine Cessna models, revised tail wheel steering, larger rear windows and revised and lengthened engine cowling. 

The 170 remained in production until 1957, by which stage its popularity had waned and sales of the 172 had taken off. The early 172 was a direct development of the 170, but introduced tricycle undercarriage and squared up vertical tail surfaces. 

It is interesting to note that the 170 laid the foundation for Cessna''s two most successful single engine light aircraft lines, the 172 and 182, as well as the 180 and 185. Apart from the 172 tricycle undercarriage development the 180 was developed as a more powerful, higher performance version of the 170, while the subsequent 182 was originally a tricycle undercarriage evolution of the 180.',NULL,'Operational'),
('cessna172skyhawkearlymodels175skylark','The Cessna 172 is without doubt the most successful mass produced light aircraft in history. From 1955 through to 1967 the 172 was powered by the six cylinder Continental O-300, before this engine was replaced by the four cylinder Lycoming O-320. 

The Cessna 172 started life as a relatively simple tricycle undercarriage development of the taildragger 170, with a fairly basic level of standard equipment. First flight was in November 1955. The 172 became an overnight sales success and over 1400 were built in 1956, its first full year of production. 

The basic 172 remained in production until replaced by the 172A of early 1960. The 172A introduced a swept back tail and rudder, while the 172B of late 1960 introduced a shorter undercarriage, equipment changes and for the first time the Skyhawk name for the Deluxe option. 

The 172D of 1963 introduced the cut down rear fuselage with wraparound rear window. The 172F introduced electric flaps and was built in France by Reims Cessna as the F172 through to 1971. It also formed the basis for the US Air Force''s T-41A Mescalero primary trainer. The 172G of 1966 introduced a more pointed spinner, while the 172H was the last Continental powered 172. 

The 175 (Skylark for the Deluxe option) meanwhile was powered by a 130kW (175hp) geared GO-300, the GO-300 powered P172D Powermatic of 1963 had a constant speed prop. The 1966 R172E had a Continental IO-360 and a constant speed prop. It was built in France as the FR172 Reims Rocket.',NULL,'Operational'),
('cessna172skyhawklatermodels','In the late 1960s Cessna re-engined its already highly successful 172 four seater with the four cylinder Lycoming O-320. These O-320 powered models were the most successful to bear the 172 model number (and the Skyhawk name for the Deluxe option), as they were in production during GA''s golden years, the 1970s. 

Cessna re-engined the 172 with the Lycoming O-320-E as compared with the O-300 it had two less cylinders (and thus lower overhaul costs), a 200 hour greater TBO, improved fuel efficiency and more power. Even so, Cessna thought 172 production would be shortlived as the similarly powered but more modern 177 Cardinal was released at the same time. In spite of the Cardinal, the Lycoming powered 172 was a runaway success and easily outsold and outlived its intended replacement. 

The first O-320 Skyhawk was the 172I introduced in 1968. The 1969 172K introduced a redesigned fin, reshaped rear windows and optional increased fuel capacity, while 1970''s 172K sported conical camber wingtips and a wider track undercarriage. The 172L in production in the 1971/72 model years was the first to feature the enlarged dorsal fin fillet. 

The 172M of 1973/76 gained a drooped wing leading edge for improved low speed handling. The 172M was also the first to introduce the optional `II'' package of higher standard equipment. Also in 1976 Cessna stopped marketing the aircraft as the 172. 

The 172N was powered by a 120kW (160hp) O-320-H designed to run on 100 octane fuel, but the engine proved troublesome and was replaced by the similarly rated O-320-D in the 172P of 1981. The P was the last basic 172 model, remaining in production until 1985. 

Higher performance 172s include the R172 Hawk XP, powered by a 145kW (195hp) Continental IO-360 and the 135kW (180hp) Lycoming O-360 powered, retractable undercarriage 172RG Cutlass. The 172 was also produced under licence by Reims in France as the F172 and FR172.',NULL,'Operational'),
('cessna172rsskyhawk','The Cessna 172R Skyhawk is possibly the most important light aircraft to enter production in the 1990s as it is the modern day development of the most popular GA aircraft in history. 

Recession and crippling product liability laws in the USA forced Cessna to stop production of light aircraft, including the 172, altogether in 1985. It was not until the signing of the General Aviation Revitalisation Act by the US President in August 1994 that Cessna announced it would resume light aircraft production. 

The new 172R Skyhawk is based on the 172N (the previous major Skyhawk production model), but features a fuel injected Textron Lycoming IO-360-L2A engine. Cessna says it is significantly quieter than the O-320 it replaced as it produces its max power at only 2400rpm. 

Other changes include a new interior with contoured front seats which adjust vertically and recline, an all new multi level ventilation system, standard four point intercom, interior soundproofing, and energy absorbing 26g seats with inertia reel harnesses. 

The 172R features epoxy corrosion proofing, stainless steel control cables, a dual vacuum pump system, tinted windows, long range fuel tanks, backlit instruments with non glare glass and an annunciator panel. 172R options include two avionics packages (one with GPS, the other with IFR GPS and a single axis autopilot) and wheel fairings. 

An engineering prototype 172R (a converted 1978 172N) powered by an IO-360 first flew in April 1995, while the first new build pilot production 172R first flew on April 16 1996. This aircraft was built at Wichita, while production 172Rs are built at an all new factory in Independence, Kansas. 

The higher performance 172S Skyhawk SP is pitched at `owner-users''. Delivered from July 1998 it features a IO-360-L2A (as on the 172R) but rated at 135kW (180hp) by increasing rpm. It also features a 45kg (100lb) increase in useful payload, a new prop and standard leather',NULL,'Operational'),
('cessna177cardinal','The Cessna 177 (Cardinal for the Deluxe option) was developed in the mid 1960s as an all new replacement for the ubiquitous 172 family. 

Announced in late 1967, this new aircraft featured a wide and fairly spacious cabin, a rear set flush riveted high wing which offered good visibility in turns, a single piece all moving tailplane, a high level of standard equipment and the 110kW (150hp) O-320-E recently installed on the 172 driving a fixed pitch prop. Offered in two versions, the standard 177 and upspec Cardinal (wheelspats, overall paint, etc.), it entered the marketplace priced around 10% more than the then current 172 model. 

While not a failure, the 177 failed to attract anywhere near the sales volume of the 172 (in its first full year - 1968 - 601 were built, about half the number of 172s built that year). A perceived shortcoming of the initial model was a lack of power, this was addressed with the 135kW (180hp) O-360-A powered 177A introduced in late 1968. The increase in engine power and hence performance lifted the 177 into a more upmarket four seater market niche between the 172 and 182. 

The 1970 model 177B introduced a revised aerofoil, conical camber wingtips, cowl flaps and a constant speed propeller. An up market version of the 177B known as the Cardinal Classic appeared in 1978 with full IFR instrumentation and luxury interior fittings. 

The 177RG was announced in December 1970, and, as its designation suggests, featured hydraulically actuated retractable undercarriage, plus a 150kW (200hp) fuel injected IO-360-A engine and a constant speed prop. 

Both the 177B and 177RG remained in production until 1978.',NULL,'Operational'),
('cessna180185skywagon','The 180 started life as a more powerful development of the 170, and evolved into a family of useful utility aircraft that was in production for over three decades. 

The first 180s were essentially Model 170s with a more powerful 170kW (225hp) O-470-A engine. The first of the type flew in 1952 and deliveries began in February the following year. The 180''s career as a high performance single was short lived due to the arrival of the tricycle 180 based 182 in 1956, but by then the type had established itself a useful niche as a utility aircraft. 

Progressive updating of the line led to a range of updated models including the 170kW (230hp) 180A, and 1964''s 180G with a third cabin window which from 1966 was offered as a six seater, by then having the same fuselage as the more powerful 185 Skywagon. The Skywagon name was applied to the 180 in 1969. The 180 remained in production until 1981. 

The first 185 Skywagon flew in July 1960. It differed from the 180 in having a more powerful engine (195kW/260hp) and larger cabin, allowing six seats. Updated models include the 225kW (300hp) A185E from 1967 and the AgCarryall capable of chemical spraying.',NULL,'Operational'),
('cessna182skylane','The popular, relatively high performance Cessna 182 began life as a tricycle development of the 180. 

The first Model 182 appeared in 1956 while the Skylane name was first introduced with the 182A development to denote an optional higher level of equipment. Major changes were introduced with the 182C, including a third window on each side of the cabin and a swept vertical tail. Other improvements introduced over the 182''s lifespan included shorter undercarriage, reprofiled cowling, wrap around rear cabin window, progressively higher takeoff weights and improved wing root, fintip, and rudder fairings. 

The retractable undercarriage Skylane RG arrived in 1977, giving a significant speed increase. A further performance boost came with the introduction of the turbocharged 175kW (235hp) Lycoming O-540-L engine on the T182RG, which became available from 1979. The AiResearch turbocharger meant that maximum power could be delivered right up to the 182''s service ceiling of 20,000ft. A turbocharged fixed gear model was also offered for a time, but only small numbers were built. 

The 182 was also produced by Reims in France as the F182, and by DINFIA in Argentina as the A-182. Cessna 182 production initially ceased in 1985. 

In 1994 Cessna announced plans to return the 182 to production, following the success of product liability law reforms in the USA. The new 182S prototype first flew on July 15 1996, the first was delivered in April 1997. Improvements include a IO-540-AB1A5 engine, new interior and avionics panel.',NULL,'Operational'),
('cessna188agwagonseries','The successful 188 Agwagon agricultural aircraft were Cessna''s only purpose designed agplanes. 

Cessna''s Model 188 resulted from extensive research and consultation with agricultural aircraft operators conducted in the early 1960s. The design Cessna settled upon was of the conventional agricultural aircraft arrangement with a braced low wing (unique among Cessna singles) with seating for the pilot only. Like other ag aircraft the chemical hopper is of fibreglass and the rear fuselage is of semi monocoque construction and sealed to reduce the potential for damage from chemical contamination. 

The prototype Cessna 188 Agwagon flew for the first time on February 19 1965, and type approval was awarded the following February. The 188 was initially offered in two forms, the 170kW (230hp) Continental O-470-R powered 188 (which was named the AgPickup from 1972) and the 250kW (300hp) Continental IO-520-D powered 188A Agwagon. 

The 1972 model year also saw the introduction of the most successful 188 model, the AgTruck. The AgTruck has the same powerplant as the Agwagon, but a larger hopper and a higher max takeoff weight. The ultimate 188 model is the AgHusky, which was introduced in 1979. It features a turbocharged TSIO-520-T and a further increased max takeoff weight. 

Production of the AgPickup was suspended in 1976, the Agwagon in 1981 and the AgTruck and AgHusky in 1985, when all Cessna light aircraft production ceased.',NULL,'Operational'),
('cessna205206207','The popular 205/206/207 line began life as a four seat utility aircraft, stretched from the 182 Skylane.

In its initial form the 205 (originally 210-5) was essentially a fixed undercarriage derivative of the 210 Centurion, optimised for utility roles, giving more baggage space. Introduced to the Cessna lineup in 1962, the 205 was powered by the same IO-470 engine as the 210B and featured an additional small cargo door on the left side of the fuselage. It later gained it''s 6th seat.

The 205 lasted in production until 1964 when it was replaced by the more powerful 206, which came in 2 options, the P206 Super Skylane and the U206 Super Skywagon, which respectively meant Passenger and Utility, the U206 featuring larger double cargo doors on the right fuselage side. Continuous improvement followed, including introduction of turbocharged and fuel injected models. The ''Super'' prefix for the Super Skywagon was dropped in 1969 and the Stationair name was adopted in 1971. Production originally ceased in 1985. 

The 207 Skywagon meanwhile featured a 1.07m (3ft 6in) fuselage stretch (allowing seating for seven) and became available from 1969. Known as the Stationair 7 from 1978, it was replaced by the 207A Stationair 8 from 1979 which had seating for an eighth occupant. Production ended in 1984. A few were built in France by Reims as the F207. Several 206 and 207 aircraft have been converted to turbine power by Soloy as the Turbine 206 and 207. 

The 206 is the third Cessna single to be returned to production at the company''s new Independence plant in Kansas. Two versions are offered, the normally aspirated 206H and turbo T206H. The T206H first flew on August 6 1996, powered by a TIO-580, while the normally aspirated 206H, powered by an IO-580, followed on November 6. A decision to switch to the TIO-540 and IO-540 because of reliability concerns pushed back production by about 10 months. The 206H was certificated on September 9 1998, the T206H on October 1.',NULL,'Operational'),
('cessna208caravanigrandcaravancargomaster','With sales exceeding the 1000 mark the useful Caravan is a popular utility workhorse worldwide.

Design work for the Caravan dates back to the early eighties. First flight of a prototype occurred on December 9 1982 and certification was granted in October 1984. When production began the following year it became the first all new single engine turboprop powered aircraft to achieve production status.

The Caravan I has had a close association with US package freight specialist Federal Express (FedEx), on whose request Cessna especially developed two pure freight versions. The first of these was the 208A Cargomaster (40 delivered), the second was the stretched 208B Super Cargomaster (260 delivered). The first Super Cargomaster flew in 1986 and features a 1.22m (4ft) stretch and greater payload capacity, including an under fuselage cargo pannier. FedEx''s aircraft lack cabin windows.

The 208B Grand Caravan first flew in 1990 and like the Super Cargomaster is a stretched version of the basic Caravan powered by a 505kW (675shp) PT6A-114. It can seat up to 14 passengers.

Announced at the 1997 NBAA convention, the 208-675 has replaced the basic 208. It combines the standard length airframe of the 208 with the more powerful PT6A-114 of the 208B.

Underbelly cargo pods, floats and skis are offered as options on the Caravan I family, and the type is easily converted from freight to passenger configurations. 

A military/special missions version of the 208A, dubbed the U-27A, is also on offer. The Brazilian Air Force designation is C-98. 

Soloy is offering a dual-engine conversion of the 208B, named Pathfinder 21. This version is powered by a 991kW (1329shp) Pratt & Whitney Canada/Soloy Dual Pac powerplant, consisting of two PT6D-114A engines driving a single propeller. Other distinguishing features of the Pathfinder 21 include a 72in cabin stretch behind the wing and a large integral cargo pod.',NULL,'Operational'),
('cessna210centurion','During its production life the Cessna 210 was at the top of the Cessna single piston engine model lineup, positioned between the 182 and the 310 twin. 

First flight of the 210 occurred in January 1957. This new aircraft featured for the first time on a Cessna aircraft retractable undercarriage and swept back vertical tail surfaces. The 210 entered production in late 1959, and from that time the line was constantly updated. 

Notable early upgrades include the 210B which introduced the wraparound rear windows, the 210D with a more powerful (210kW/285hp) engine and introduced the Centurion name, and the turbocharged T210F. The 210G introduced a new strutless cantilever wing, increased fuel capacity, restyled rear windows and enlarged tail surfaces. Continual development of the 210 and T210 range continued through until production ceased in 1985. 

A significant development of the T210 was the high performance, pressurised P210 which first appeared in 1978. The pressurisation system meant that the cabin''s internal altitude was equivalent to 8000ft when flying at 17,350ft. 

In 1998 Cessna was considering returning the 210 to production.',NULL,'Operational'),
('cessna310320','The sleek Cessna 310 was the first twin engine design from Cessna to enter production after WW2. 

The 310 first flew on January 3 1953. The modern rakish lines of the new twin were backed up by innovative features such as engine exhaust thrust augmentor tubes and the storage of all fuel in tip tanks. Deliveries commenced in late 1954. 

The first significant upgrade to the 310 line came with the 310C of 1959, which introduced more powerful 195kW (260hp) IO-470-D engines. The 310D of 1960 featured swept back vertical tail surfaces. An extra cabin window was added with the 310F. A development of the 310F was the turbocharged 320 Skyknight, with TSIO-470-B engines and a fourth cabin side-window. The Skyknight was in production between 1961 and 1969 (the 320D, E and F were named Executive Skyknight), when it was replaced by the similar Turbo 310. 

The 310G introduced the ''stabila-tip'' tip tanks, while the 310K replaced the rear two windows on each side with a single unit. Subsequent significant developments include the 310Q and turbocharged T310Q with redesigned rear cabin with a skylight window, and the final 310R and T310R, identifiable for their lengthened noses. Production ended in 1980.

USAF military versions were the L-27A (310A) and L-27B (310M) Blue Canoe, later redesignated U-3A and U-3B.',NULL,'Operational'),
('cessna336337skymaster','Through their pushpull engine configuration the twin boom Cessna 336 and 337 were designed to overcome conventional twins'' problems of poor engine out asymmetric flight handling characteristics. 

Cessna called the layout concept Centre Line Thrust, as the nose mounted tractor and rear fuselage mounted pusher engine eliminated asymmetric handling problems normally experienced when one of a twin''s engines fails. The concept was recognised by the US FAA which created a new centre thrust rating for pilots to be rated on the type. 

The Model 336 Skymaster first flew on February 18 1961, but significant improvements to the design were made before production aircraft were delivered. Changes included more powerful engines, a larger fuselage with seating for six, and revised wing, tail and rear engine cowling. The 336 was delivered from mid 1963 and production lasted until late 1964 when it was replaced by the 337 Super Skymaster (''Super'' was later dropped) which was released in February 1965. 

The improved 337 introduced retractable undercarriage, more powerful 160kW (210hp) engines, a dorsal air intake for the rear engine, variable cowl flaps, repositioned forward engine and cowl for improved visibility, and higher weights. 

Subsequent development resulted in the turbocharged T337 (first released in the 1967 model year, dropped in 1972 and relaunched in 1978), while the ultimate 337 was the T337G Pressurized Skymaster, introduced from August 1972. 

Development of the 337 continued in France by Reims after Cessna production ended in 1980, resulting in the FTB337 Milirole, a military STOL version with underwing hardpoints. Cessna also built more than 500 337s as O-2s for the US Air Force, used largely in the Forward Air Control role.',NULL,'Operational'),
('cessna340335','When released, the Cessna 340 joined the Beechcraft Duke as the only other six seat pressurised piston twin from a major manufacturer, positioned in Cessna''s product line between the 310 and the eight seat 414 and 421. 

Development of the 340 began in 1969, but the loss of the prototype early in 1970 set back the development program so that production deliveries did not begin until early 1971. The resulting aircraft borrowed heavily from other Cessna twins of the time including the wings from the 414 and the 310''s undercarriage and a similar tail unit. Design features of the new aircraft included a pressurisation system with a differential of 0.29bars (4.2psi) that kept the cabin''s internal altitude at 8000ft while the aircraft was at 20,000ft, an all new fail safe fuselage and an integral airstair door. 

Initial production 340s were powered by two 210kW (285hp) turbocharged Continental TSIO-520-K engines, but these were replaced on the improved 340A, which was first introduced in 1976. Power for the 340A was supplied by two 230kW (310hp) TSIO-520-NBs, while other improvements included reduced diameter props and a slight increase in weights. The 340A was offered in optional 340A II and 340A III forms with various levels of IFR avionics fitted. 

The Cessna 335 is an unpressurised, lighter weight and thus lower cost development of the 340. Available from 1979, aside from being unpressurised it differed in having 225kW (300hp) TSIO-520-EB engines. Although claimed by Cessna as the lowest priced cabin class business twin on the market, just 64 335s were built before production was terminated in 1980. 

Production of the 340 continued until 1984.',NULL,'Operational'),
('cessna404titan','In July 1975 Cessna announced it was developing a new piston twin suitable for airline, freight and corporate work, capable of taking off with a 1560kg (3500lb) payload from a 770m (2530ft) strip, similar in concept to the successful 402, but larger overall. 

The resulting aircraft was the Model 404 Titan, Cessna''s largest piston engined twin developed thus far. It shares the same basic fuselage as the turbine powered 441 Conquest which was developed concurrently, but differs in having geared 280kW (375hp) piston engines and it is unpressurised. Other features include a bonded wet wing (then appearing on a number of 400 series Cessna twins) and the trailing link main undercarriage design shared with the Conquest. 

The prototype Titan first flew on February 26 1975, production deliveries got underway in October the following year. Throughout the Titan''s model life it was offered in three major versions, each differing in internal equipment fit. 

The base aircraft was the Titan Ambassador, configured for passenger operations, while the Titan Courier was convertible from passenger to freight configurations, and the Titan Freighter was a pure cargo aircraft. The Titan Freighter was specially equipped for freight operations with a strengthened floor, cargo doors and walls and a ceiling made from impact resistant material. All were offered with II and III avionics equipment levels (as with other Cessna twins). 

The Titan underwent minor modifications from 1980 when the wing span was increased and the wingtips redesigned, but production was to last for only another two years until 1982, by which time 378 had been built.',NULL,'Operational'),
('cessna411401402','The 411 was Cessna''s entry into the eight seat cabin class twin market that had previously been dominated by the Beech Queen Air. 

Much more modern than the Queen Air, the 411 was lighter, smaller and faster. The prototype first flew in July 1962 and differed from the following production aircraft in having two blade props and direct drive engines (as opposed to the geared GTSIO-520-C engines of production aircraft). Production deliveries commenced in October 1964. Optional features for corporate configured aircraft included folding tables, a toilet and refreshment centre. The 411 was followed up by the 411A from 1967 with lighter and more efficient props and optional extra fuel capacity. 

The 411 was soon after replaced by the 401 and 402, which had first been introduced in late 1966. These developments of the 411 were lighter, less powerful and had direct drive engines, and thus were less costly to operate. While the 401 and 402 were essentially the same aircraft, the 401 was optimised for corporate transport and was fitted with fewer seats than the 402, which was configured for commuter and freighter work. A number of versions of both models were developed with minor refinements, including the 402A, which had a lengthened nose, square windows and an optional 10th seat. 

The 402 replaced the 401 from mid 1972, and, as the 402B, was offered in Businessliner corporate configuration, and Utililiner convertible passenger or freighter aircraft. The 402C appeared in late 1978 and featured the longer span wings from the 414A and 421C and more powerful engines. It remained in production until 1985.',NULL,'Operational'),
('cessna421414','The lineage of the 421 and 414 traces back to the 411, the 421 beginning life as a pressurised development of the 411. 

The prototype 421 took to the skies for the first time in October 1965 (three years after the 411). In comparison to the 411 on which it was based, the 421 introduced a cabin pressurisation system, more powerful geared and turbocharged GTSIO-520-D engines and a higher max takeoff weight. Deliveries of production 421s began in May 1967, Cessna at the time claiming it as the cheapest pressurised twin on the market. 

First improvements to the 421 were offered with the 421A of 1969, but the 421B Golden Eagle of 1970 featured a number of significant improvements including lengthened nose and wing span, while the engines retained their power to higher altitudes than before. The final expression of the 421 was the 421C available from late 1975, with a bonded wet wing and no tip tanks, higher vertical tail, more efficient props and new trailing link undercarriage. 

The 414 was developed as a less powerful, lighter, simpler and lower cost 421. First flown in 1968, it entered production in 1969. It features the wings and fuselage of the 401 and 402 (themselves lighter developments of the 411), plus direct drive, rather than geared engines. The improved 414A Chancellor appeared in 1978, introducing the bonded wet wing without tip tanks. It remained in production until 1985.',NULL,'Operational'),
('cessna500501citationcitationicitationisp','The highly popular Cessna 500 Citation and 500 Citation I pioneered the entry level light business jet market, and their success formed the basis for the world''s largest family of corporate jets. 

Cessna became the first of the big three American manufacturers (Piper, Beech and Cessna) to develop a jet powered transport. In October 1968 Cessna announced its plans to build a new eight place jet powered business aircraft that would be capable of operating into airfields already served by light and medium twins. Dubbed the Fanjet 500, the prototype flew for the first time on September 15 1969. Soon after the new little jet was named the Citation. 

A relatively long development program followed, during which time a number of key changes were made to the design including a longer forward fuselage, repositioned engine nacelles, greater tail area and added dihedral to the horizontal tail. In this definitive form the Citation was granted FAA certification on September 9 1971. 

Improvements including higher gross weights and thrust reversers were added to the line in early 1976, followed shortly after by the introduction of the enhanced Citation I later that same year. Features of the Citation I were higher weights, JT15D-1A engines and an increased span wing. A further model to appear was the 501 Citation I/SP, which is certificated for single pilot operation. The I/SP was delivered in early 1977. 

Production of the Citation I ceased in 1985, its place in the Citation line left vacant until the arrival of the CitationJet (described separately) some years later. 

Direct developments of the Citation were the Citation II (now Citation Bravo) and Citation V (now Citation Ultra Encore).',NULL,'Operational'),
('cessna560citationvultraultraencore','The Citation V, Citation Ultra and Ultra Encore are the largest straight wing members of Cessna''s highly successful Citation family. 

Cessna publicly announced it was developing a stretched development of the Citation II at the annual NBAA convention in New Orleans in 1987. Earlier in August that year the first engineering prototype Model 560 Citation V had successfully completed the type''s maiden flight. A preproduction prototype flew in early 1986, while US certification was granted on December 9 1988. Deliveries began the following April. 

The Citation V was based on the Citation II/SP, but differences over the smaller jet include more powerful Pratt & Whitney Canada JT15D5A turbofans and a slight fuselage stretch, allowing seating in a standard configuration for eight passengers. The Citation V proved quite popular, with 262 built through to mid 1994 before production switched to the modernised Ultra. 

Cessna announced development of the upgraded Citation V Ultra in September 1993. FAA certification was granted in June 1994, allowing for deliveries of production aircraft to commence soon after. Compared with the Citation V, the Ultra features more powerful 13.6kN (3045lb) Pratt & Whitney Canada JT15D5D engines and Honeywell Primus 1000 EFIS avionics with three CRT displays (two primary flight displays and one multifunction display). 

The Citation Ultra Encore is a new development announced at the 1998 NBAA convention. Compared with the Ultra the Encore introduces new Pratt & Whitney Canada PW535 engines, plus trailing link main undercarriage, more fuel payload, updated interior and improved systems. The Ultra''s Honeywell Primus 1000 EFIS avionics suite is retained. 

 

 International Directory of Civil Aircraft',NULL,'Operational'),
('cessna560xlcitationexcel','One of the latest members of Cessna''s extensive line of Citation business jets, the Citation Excel combines the cabin width and standup headroom comfort of the Citation X in a new small/medium size package. 

The new Excel resulted from customer consultation over what they wanted in a light corporate jet plus advances in engine and airframe technology. The basis of the Excel is a shortened Citation X fuselage (the same fuselage cross section as was used in the Citation III, VI and VII), combined with a modified unswept supercritical wing based on the Citation V Ultra''s, the V''s cruciform tail configuration and new Pratt & Whitney Canada PW-545A series turbofans. 

Other design features include trailing link main undercarriage units and a standard Honeywell Primus 1000 three 20 x 18cm (8 x 7in) screen EFIS avionics package (two Primary Flight Displays, one for each pilot, and a multifunction display). 

Cessna claims the Citation Excel''s cabin is the largest of any light business jet. It features standup headroom and a dropped aisle that runs the length of the main cabin. Seated head and elbow room is greater than that in the Citation II and V, while the cabin length is similar to the Citation I, II, VI and VII. 

The Excel was one of the first applications for the new generation PW-500 series engines. The Excel''s 16.9kN (3804lb) PW-545As (derated from 19.9kN/4450lb, with a TBO of 5000 hours) are fitted with Nordam thrust reversers as standard and the engines allow it to cruise at 801km/h (432kt). 

Cessna announced it was developing the Excel at the NBAA convention in October 1994. Prototype construction began in February 1995 and it flew for the first time on February 29 1996. The first production Excel rolled out in November 1997 and the type was certificated in April 1998, with first deliveries beginning mid that year at which stage over 200 were on order. 

Cesna delivered the 100th Excel in August 2000, at which time the company was building one every three days. Cessna says this is the fastest ramp-up of production of any Citation jet yet.',NULL,'Operational'),
('cessna680citationsovereign','Cessna is developing the new Citation Sovereign mid size corporate jet to meet what it sees as a large replacement market for ageing business aircraft such as the Falcon 10, Westwind and Sabreliner. 

Cessna market research showed that of the 1760 or so mid sized corporate jets in service worldwide almost half are early generation aircraft which it felt would come up for replacement in the coming years. Its answer to this emerging market is to develop the Citation Excel based Model 680 Citation Sovereign, which it revealed at the October 1998 NBAA exhibition in Las Vegas. Certification is planned for late 2003 with customer deliveries getting underway in the first quarter of 2004. 

The Sovereign is based on the Excel''s fuselage and shares some common systems but features an all new wing and numerous other differences. Cessna looked at an all new fuselage cross section for the Sovereign but opted instead to stretch the Excel fuselage (by 1.5m/4.9ft) to keep down costs and reduce development time. Even so Cessna claims the Sovereign''s eight seat cabin is the largest in its class with 40% more volume than the Bombardier Learjet 60 and 18% more than the Raytheon Hawker 800XP. 

Power for the Sovereign will be from two FADEC equipped 25.3kN (5690lb) Pratt & Whitney Canada PW-306Cs. The PW-306 was selected in part as it also powers the 328JET regional airliner which should give maintenance and reliability benefits because of the airline industry''s more rigorous operating demands. 

The mildly swept wing is an all new, supercritical design, based on Cessna''s experience with the Citation III/VII, V and X. The horizontal stabiliser is also slightly swept. The Sovereign will enjoy good field performance, being able to operate from 1220m (4000ft) runways at max takeoff weight. Another feature is trailing link main undercarriage. 

The Sovereign will be equipped with a Honeywell Epic CDS avionics suite, with four 20 x 25cm (8 x 10in) colour flat panel liquid crystal displays, a digital dual channel autopilot and flight director, dual long range navigation systems and dual attitude/heading reference systems. Other standard equipment will include TCAS and an EGPWS (enhanced ground proximity warning system).

The first flight of the prototype was made on February 27, 2002. The first production model is scheduled to fly by July 2002',NULL,'Operational'),
('cessnacitationiibravo','The early success of the original Citation led Cessna to develop a larger capacity Citation model in the mid 1970s. <p>Cessna announced the stretched Citation in September 1976. The fuselage was extended by 1.14m (3ft 9in) to increase maximum seating capacity to 10, while more powerful Pratt & Whitney Canada JT15D4 engines and greater fuel tankage meant higher cruise speeds and longer range. Increased baggage capacity and increased span wings were also added. <p>The new Model 550 Citation II first flew on January 31 1977 and FAA certification for two pilot operation was awarded in March 1978. The II/SP is the single pilot version. <p>Major improvements were made to the design with the arrival of the Model S550 Citation S/II. Announced in October 1983, this improved version first flew on February 14 1984. Certification, including an exemption for single pilot operation, was granted that July. Improvements were mainly aerodynamic, including a new wing designed using supercritical technology developed for the Citation III (described separately), plus JT15D4B turbofans. The S/II initially replaced the II in production from 1984, but the II returned to the lineup from late 1985, and both variants remained in production until the introduction of the Bravo. <p>The Bravo features new P&WC PW530A turbofans, modern Honeywell Primus EFIS avionics suite, a revised interior based on that introduced in the Citation Ultra and other improvements such as trailing link main undercarriage. The Bravo first flew on April 25 1995 and was granted certification in August 1996. First delivery was in February 1997. <p>',NULL,'Operational'),
('cessnacitationiiivivii','The all new Cessna Model 650 Citation III was designed as a high performance, mid size long range corporate jet to supplement the much smaller Citation I and II. <p>Development of this very different Citation began in 1978. As it evolved, the III had little in common with the previous Citation models other than the name. The new design featured a swept supercritical wing optimised for high speed long range flight, new Garrett TFE731 turbofans, a Ttail, and a new fuselage. <p>The new jet made its first flight on May 30 1979 with a second prototype flying on May 2 1980. Certification was granted on April 30 1982, first customer deliveries occurring the following year. The Citation III set two time to height records for its class in 1983 and a class speed record by flying from Gander to Le Bourget in 5hr 13min. <p>Production improvements to the Citation III were first proposed in the cancelled Citation IV. This model was announced in 1989 and was to feature longer range through greater fuel tankage, and better short field performance. In its place instead Cessna developed the Citation VI and VII. The Citation VI was offered as a low cost development of the III with a different avionics package and a standard interior layout, with customised interiors unavailable. First flight of the Citation VI took place in 1991 but only 39 were built when production was wound up in May 1995. <p>The Citation VII meanwhile features a number of improvements including more powerful engines for improved hot and high performance. The first Citation VII prototype flew in February 1991 and the type was certificated in January 1992. The Citation VII remains in production as the only member of the Citation III/VI/VII currently available new build. <p>A recent significant customer for the Citation VII was Executive Jet Aviation which ordered 20 for its NetJets fractional ownership scheme for delivery from 1997. <p> <p>',NULL,'Operational'),
('cessnacitationx','The Citation X is Cessna''s largest, fastest and longest range aircraft yet, and Cessna claims it to be the fastest civil transport in service other than the supersonic Concorde.

The Citation X (as in the Roman numeral, not the letter, and Cessna''s Model 750) is also the largest member of business aviation''s biggest corporate jet family, the Citation series.

The design objectives behind the Citation X included transcontinental USA and trans Atlantic range in a mid size package that cruises faster than any other business jet available. This high speed cruise capability, which Cessna says is 105 to 210km/h (55 to 113kt) faster than other mid size corporate jet, means the X can save up to one hour''s flight time on transcontinental US flights, flying from Los Angeles to New York with normal wind conditions in 4 hours 10 minutes. Because of its ability to cruise at high speed at high altitudes, Cessna also says the Citation X will consume less fuel than current jets on such a transcontinental flight. 

The X''s FADEC equipped Allison AE 3007A turbofans are very powerful for an aircraft of the X''s size, while the highly swept (37°) wings are also long in span.

Other design features of the Citation X include the fuselage cross section of the Citation III, VI and VII but with more efficient use of internal space that allows greater head and shoulder room, an area ruled, waisted rear fuselage, trailing link main undercarriage units and a modern Honeywell Primus 2000 EFIS avionics suite with five colour CRT displays.

Cessna announced that it was developing the Citation X in October 1990 at that year''s NBAA conference. The prototype was publicly rolled out in September 1993 and flew for the first time on December 21 that year. Certification was granted on June 3 1996, with the first customer delivery (to golfer Arnold Palmer) that month.

A Citation X was the 2500th Citation to be delivered, handed over on September 10 1997. The USA''s National Aeronautics Association awarded its prestigious Collier Trophy to the Citation X design team in February 1997.',NULL,'Operational'),
('cessnacitationjetcj1cj2','The highly successful CitationJet was developed as a replacement for the Citation and Citation I. Improved and stretched developments, the CJ1 and CJ2 respectively, are under development. 

Cessna launched the new Model 525 CitationJet at the annual US National Business Aircraft Association convention in 1989. First flight occurred on April 29 1991, FAA certification was awarded on October 16 1992 and the first delivery was on March 30 1993. 

The CitationJet is effectively an all new aircraft. The same basic Citation forward fuselage is mounted to a new T-tail configured tailplane and a new supercritical laminar flow wing, and it features Williams Rolls FJ44 turbofans (with paddle thrust reversers) and trailing link main undercarriage. The CitationJet''s fuselage is 27cm (11in) shorter than the Citation/Citation I''s, while cabin height is increased courtesy of a lowered centre aisle. It features EFIS avionics and is certificated for single pilot operation. 

At the 1998 NBAA convention Cessna revealed it was developing the improved CJ1 and stretched CJ2. The CJ1 will replace the CitationJet and will introduce a Collins Pro Line 21 EFIS avionics suite and a moderate increase in maximum takeoff weight. The CJ1 will be delivered from the first quarter of 2000. 

The CJ2 meanwhile is a stretched, faster and more powerful development. Due to fly in the second quarter of 1999 and be certificated 12 months later, the CJ2 will feature a 89cm (35in) cabin and 43cm (17in) tailcone stretch allowing standard seating for six in the main cabin. Like the CJ1 it will feature Collins Pro Line 21 EFIS avionics, plus uprated FJ44-2C engines, increased span wings, larger area tail, six cabin windows per side and greater range. It will be certificated for single pilot operation.',NULL,'Operational'),
('cessnacorsairconquestiiicaravanii','The Corsair and Conquest I, and the 441 Conquest II are the turboprop powered equivalents of the 421 Golden Eagle and 404 Titan respectively. <p>The Model 441 Conquest was the first to be developed, it was designed concurrently with the piston engined 404 Titan in the mid 1970s. Development was announced in November 1974, and the first flight occurred in August 1976. First customer deliveries were from September 1977. The 441 shares a common fuselage with the Titan, but has a longer span (bonded and wet) wing, a pressurised fuselage, and most significantly, Garrett TPE331 turboprop engines. A PT6A powered 441, designated the 435, flew during 1986, but it did not enter production. <p>The 425 Corsair meanwhile was introduced to the Cessna model lineup from 1980. Based on the Model 421 Golden Eagle, it differs from its donor aircraft in having turboprop engines (in this case PT6As). Design work on the Corsair began in 1977, first flight was on September 12 1978 and first production deliveries took place in November 1980. <p>From 1983 Cessna renamed the Corsair the Conquest I, while the Conquest became the Conquest II. Production of both ceased in 1986. <p>The French built Reims Cessna F406 Caravan II meanwhile is something of a hybrid, incorporating 373kW (500shp) PT6A112s, the unpressurised fuselage of the Titan and the Conquest II''s wings. First delivered in late 1984, the Caravan II is the only Cessna turboprop twin currently in production. <p>',NULL,'Operational'),
('cessnat303crusader','Cessna''s Model 303 started life as a four seat twin, intended for the hotly contested light transport and training role. <p>One four seat 303 was flown for a time from February 14 1978. Powered by two 120kW (160hp) Lycoming O320 engines it would have competed against the Beech Duchess, Grumman GA7 (Cougar) and Piper Seminole. However, a reappraisal of market demand for aircraft in this already crowded class led to Cessna rethinking the 303 design, and the outcome was a larger aircraft. Instead the resulting six seater aircraft was intended to replace Cessna''s 310, then nearing the end of its production life. <p>The new model, designated the T303 for its turbocharged (and fuel injected) Continental TSIO520 engines, flew for the first time on October 17 1979. Certification was granted in August 1981, and first production deliveries commenced in October 1981. For a time the T303 was named the Clipper, but this was changed to Crusader as PanAm held the rights to the Clipper name. <p>In its definitive form the T303 incorporated a number of advanced features, being the first entirely new piston twin from Cessna in over a decade. Features included bonded structures around the integral fuel tank, a supercritical wing section and counter rotating propellers, while standard equipment included integral airstairs and a full IFR avionics suite (Cessna claimed the latter as a first for its class). <p>Only minor changes were introduced during production, including the addition of anti ice equipment as an option in 1982, and in 1983 the rear cabin bulkhead was moved aft slightly which increased baggage space and allowed the addition of a cargo door. <p>Production of the Crusader wound up in 1985 as part of the general decline in light aircraft sales during that period, terminating prematurely what looked to be a successful program. The cancellation also put paid to rumours that Cessna planned to develop more powerful, pressurised, and turboprop powered versions of the aircraft. <p>',NULL,'Operational'),
('chichestermilesleopard','The sleek Leopard is arguably the most advanced high performance light aircraft yet designed and flown. <p>Despite this advancement, the Leopard dates back to the early 1980s when Ian ChichesterMiles, a former Chief Research Engineer at BAe Hatfield, established ChichesterMiles Consultants. CMC completed construction of a Leopard mockup in early 1982 and then contracted Designability Ltd to perform detail design work and build a prototype. <p>CMC originally hoped that the prototype Leopard would fly for the first time in early 1987, however various delays meant that it did not fly for the first time until December 12 1988. Since then development has progressed fairly slowly. <p>The program suffered a setback when the Leopard''s engine supplier Noel Penny ceased trading, and all flying stopped while a preproduction aircraft powered by Williams International FJX turbofans was designed and built. This aircraft was displayed at the 1996 Farnborough Airshow and flew for the first time on April 9 1997. <p>Production Leopards will incorporate a number of advanced design features including all composite construction; supercritical, laminar flow, swept wings; liquid deicing and decontamination system along the wings and tailplane; and EFIS avionics (the prototype features simpler avionics and pressurisation systems and liquid deicing on the tailplane only). The preproduction Leopard incorporates most of these features bar the FJX-2 engines. The Leopard also does not feature spoilers or ailerons, instead roll, pitch and yaw control is provided by the all moving fin and differentially actuated tailplanes. <p>The first production standard Leopard is due to fly in 2000, with certification and production planned for 2002. <p>',NULL,'Operational'),
('cirrussr2022','Cirrus Design Corporation''s SR-20 is an all new, modern high performance four seat light aircraft. 

Cirrus began life as a designer and manufacturer of kit aircraft. The company''s piston or turbine powered kit built VK-30 four seater in fact forms the basis of the SR-20 design, although the two aircraft are very different, particularly as the VK-30 features a pusher engine. The VK-30 first flew in February 1988 but kit production ceased in 1993 to allow Cirrus to relocate its manufacturing facilities to Duluth, Minnesota, and to concentrate on designing and manufacturing a family of fully certificated and factory built GA aircraft. 

Details of the SR-20 were publicly revealed at the Oshkosh EAA Convention in July 1994. What was revealed is one of the most advanced four seaters in production or under serious development. The SR-20 features composite construction, advanced avionics including a large colour multifunction display, side mounted control yokes and a 150kW (200hp) Teledyne Continental IO-360 flat six piston engine with a single lever operating both mixture and throttle. 

The SR-20 will also be fitted standard with a Ballistic Recovery System (BRS) parachute (a first for a certificated production aircraft), while various energy absorbing features have been designed into the airframe to reduce deceleration loads and increase its ability to absorb energy in the event of an impact. 

Apart from its high levels of technology, Cirrus claims that the SR-20 offers significant improvements over current four seaters in the areas of performance, interior cabin space and internal noise levels. The cockpit interior is based on modern automotive designs. 

The SR-20 prototype made its first flight on March 31 1995. Full FAA FAR Part 23 certification was awarded on October 23 1998, with first deliveries planned for that December (certification was delayed somewhat because Cirrus sought to lower the stall speed and improve lateral control). Cirrus aims to build up to 400 SR-20s a year once full production is achieved. 

A number of developments of the SR-20 have been considered including a more basic version optimised for flying training powered by a 120kW (160hp) engine.  In the fall of 2000, Cirrus Design received FAA certification for the 310 hp SR-22.  With a longer wingspan, increased payload and higher cruise speeds, it promises to fill a market niche for those desiring these attributes.',NULL,'Operational'),
('commander114b','The Commander 114B is a new build, modernised development of the original Rockwell Commander 114. <p>The Rockwell Commander 114 was itself a more powerful development of the Commander 112 of 1970, one of only two new GA designs from Rockwell. Unfortunately for Rockwell, the 150kW (200hp) powered 112 was widely regarded as underpowered. To address concerns with the 112, Rockwell developed the 114 which incorporated a number of improvements plus most importantly a 195kW (260hp) six cylinder engine. <p>The 112 and 114 remained in production with Rockwell until 1979. In 1981 Rockwell''s General Aviation Division was sold to Gulfstream Aerospace. Gulfstream held the manufacturing rights for the Commander family but never built the 112 or 114, instead selling the rights to the newly formed Commander Aircraft Company in 1988. <p>Under the Commander Aircraft Company''s stewardship, the basic 114 design was improved and updated considerably. The main changes to the Commander 114B over the original 114 include a restyled engine cowling to reduce drag and other aerodynamic improvements, a quieter and more efficient three blade McCauley Black Mac propeller, and a new luxury leather and wool interior. <p>The revised Commander 114B was issued a new Type Certificate on May 4 1992 and production aircraft were delivered from later that year. <p>Apart from the 114B, Commander also offers the 114AT optimised for pilot training and the turbocharged 200kW (270hp) TIO540 powered 114TC, which entered service in 1995. A long range option for the 114B was announced in 1998. <p>',NULL,'Operational'),
('convair2403404405405806006405800','The Convair 240, 340 and 440 was one of the closest designs to come near to being a Douglas DC-3 replacement as despite a glut of cheap DC-3s in the postwar years this family of airliners achieved considerable sales success. 

Design of the original 110 was initiated in response to an American Airlines request for a DC-3 replacement. American found the 110 (which first flew on July 8 1946) to be too small and asked that the 110 be scaled up in size, and this resulted in the 240 ConvairLiner. The 240 was arguably the most advanced short haul airliner of its day, and first flew on March 16 1947 and entered service on June 1 1948. 

The success of the 240 led to the 1.37m (4ft 6in) stretched 340, which first flew on October 5 1951, and the improved 440 Metropolitan which incorporated extra cabin sound-proofing, new rectangular exhaust outlets, tighter engine cowlings, and some other aerodynamic improvements and first flew on October 6 1955. Most of the 440s were also delivered with weather radar in an elongated nose, which had been an option on the 340. 

The 240, 340 and 440 sold in large numbers, mainly to airlines in North America, and formed the backbone of many airlines'' short to medium haul fleets. Today the small number of piston Convairs that remain in service are mainly used as freighters.

Many of the Convairs were also built for the US Air Force as the C-131 and T-29 in many versions, and for the US Navy as the R4Y which were redesignated too as C-131 in 1962. 

However, the original piston Convairs have been the subject of a number of turboprop modification programs, the line''s inherent strength and reliability making it a popular choice for conversions.  

As early as 1950 the potential of turboprop powered 240s was recognised, leading to the first flight and development of the 240-21 Turboliner, while an Allison 501D powered YC-131C military conversion first flew on June 19 1954. One other early conversion occurred in 1954 when D Napier and Sons in Britain converted 340s with that company''s 2280kW (3060hp) Eland N.El.1 turboprops as the 540. Six such aircraft were converted for Allegheny Airlines in the USA, although these aircraft were later converted back to piston power. Canadair meanwhile built 10 new aircraft with Eland engines as the CL-66 for the Royal Canadian Air Force, where they were designated CC-109 Cosmopolitan. 

The most popular Convair conversions were those done by PacAero in California for Allison, and this involved converting 340s and 440s to 580s with Allison 501D turboprops, plus modified tail control surfaces and a larger tail area. The first such conversion flew on January 19 1960, although it was not until June 1964 that a converted aircraft entered service. 

Convair''s own conversion program involved Rolls Royce Darts, and the first of these flew on May 2 1965. Thus converted 240s became 600s, while 340s and 440s became 640s. 

Super 580 Aircraft Company, a division of Flight Trails Inc., replaced the Allison 501-D13D engines by -D22Gs and incorporated some further improvements on two or three 580s which were redesignated Super 580.

Kelowna Flightcraft in Canada however has offered the most ambitious Convair conversion program, the 5800, having stretched the 580 by 4.34m (14ft 3in) and reverting to the 440''s original tail unit. Production conversions have a new freight door and digital avionics with EFIS.

Most of the remaining Convairs are now used as cargo transports.',NULL,'Operational'),
('curtissc46commando','The Curtiss Commando came into widespread civilian service as both an airliner and a freighter after a large number were built as transports for the US military during World War 2, although the original Curtiss design was intended as an airliner. <p>Originally intended as a competitor to the highly successful Douglas DC-3, which was the preeminent airliner of the time, the Curtiss CW20 was designed to operate on routes of up to 1000km (540nm), which at the time accounted for 90% of the US domestic airline system. The CW-20 featured two 1270kW (1700hp) Wright R2600 Twin Cyclone radial engines, twin vertical tails and a pressurised double lobe, or `double bubble'' fuselage. Accommodation would have been for 36 passengers plus four crew. <p>Later in timing than the DC-3, the CW20 first flew on March 26 1940. In July that year an impressed US Army Air Force ordered 20 unpressurised CW20s, which it named the C46 Commando. The first production aircraft was completed in May 1942, by which time the powerplant choice had been switched to P&W R2800s, and the first deliveries to the US Army occurred that July. <p>Initially the C46 was troubled with reliability problems in military service, but these were soon overcome and the Commando proved to be a useful transport with its relatively cavernous freight hold. <p>A proposed postwar commercial version was the CW20E, but it failed to attract customer interest and thus all Commandos to enter civilian service were ex military aircraft. Most were purchased by American operators for freight work. One postwar version though was the Riddles Airlines C46R which had more powerful engines and better performance. Thirty or so were converted. <p>In late 1998 five Commandos were believed to be operational in Alaska, four in Canada, and as many as seven in Bolivia. <p>',NULL,'Operational'),
('dassaultfalcon2000','The Falcon 2000 is the latest member of the Falcon business jet line, and is a transcontinental range, slightly smaller development of the Falcon 900 trijet <p>The Falcon 2000 shares the 900''s wing and forward fuselage, but there are a number of design changes. From the start the Falcon 2000 was designed with a range of 5560km (3000nm) in mind, which is less than the transcontinental 900''s range. This design range removed the need for the redundancy of three engines for long range overwater flights, allowing the two new CFE738 engines to be fitted, which offer considerable maintenance and operating economics benefits. The CFE738 engine was developed specifically for the Falcon 2000 by a partnership of General Electric and AlliedSignal, known as CFE. Meanwhile, the 2000''s fuselage is 1.98m (6ft 6in) shorter than the 900''s and so houses less fuel, passengers and baggage. <p>Another noticeable design change between the 900 and 2000 is the area ruled rear fuselage. Dassault engineers found that the three engine layout of the 900 to be aerodynamically efficient, whereas the twin engine design of the 2000 originally would have been comparatively draggy. To combat this and reduce drag to desired levels Dassault designed an area ruled (or Coke bottle) rear fuselage, using its Catia three dimensional computer aided design program. <p>Changes to the wing include a modified leading edge and the inboard slats have been removed, while the cockpit features a Collins four screen EFIS avionics system with optional Flight Dynamics head-up displays (allowing hand flown approaches in Cat II and Cat IIIa conditions). <p>Dassault has a number of industry partners in the Falcon 2000 program, foremost of these being Alenia, which is a 25% risk sharing partner. Alenia in turn has subcontracted some work to Dee Howard and Piaggio. <p>Dassault announced it was developing the Falcon 2000, then known as the Falcon X, in June 1989. First flight occurred on March 4 1993 and certification was awarded in November 1994. The first customer delivery occurred in March 1995. <p>',NULL,'Operational'),
('dassaultfalcon50','The trijet Falcon 50 is a very substantial long range upgrade based on the earlier twinjet Mystère/Falcon 20 and 200 family. <p>The Dassault Falcon 50 was developed for long range trans Atlantic and transcontinental flight sectors, using the Falcon 20 as the design basis. However, to meet the 6440km (3475nm) range requirement significant changes mean that the Falcon 50 is for all intents and purposes an all new aircraft. <p>Key new features include three 16.6kN (3700lb) Garrett TFE731 turbofans, in place of the Falcon 20''s two General Electric CF700s, mounted on a new area ruled tail section, plus a new supercritical wing of greater area than that on the 20 and 200. Falcon 20 components retained include the nose and fuselage cross section. <p>The first flight of the prototype Falcon 50 occurred in November 1976, although it wasn''t until March 7 1979 that FAA certification was granted. In the meantime the design had been changed to incorporate the supercritical wing, although the original wing''s basic planform was retained. A second prototype first flew on February 18 1978, the first preproduction aircraft following on June 13 1978. First customer deliveries began in July 1979. <p>In April 1995 Dassault announced the long range Falcon 50EX with more fuel efficient TFE73140 turbofans, 740km (400nm) greater range (at Mach 0.80) than the base Falcon 50 and a new EFIS flightdeck based on the Falcon 2000''s with Collins Pro Line 4 avionics. The 50EX also features as standard equipment items offered as options only on the standard Falcon 50. <p>The Falcon 50EX''s maiden flight was on April 10 1996, with French and US certification in November and December 1996 respectively. First delivery (to Volkswagen) was in the following January. <p>The Surmar is a maritime patrol version of the 50 ordered by the French navy (fitted with a FLIR and search radar). <p>',NULL,'Operational'),
('dassaultfalcon900','The Falcon 900 intercontinental range trijet is a substantially revised development of the Falcon 50. 

Dassault announced it was developing a new intercontinental range large size business jet based on the Falcon 50 on May 27 1983 at the Paris Airshow. The prototype, "Spirit of Lafayette", flew for the first time on September 21 1984. A second prototype flew on August 30 1985, and this aircraft demonstrated the type''s long range potential by flying nonstop from Paris to Little Rock, Arkansas in the USA for a demonstration tour. French certification was awarded on March 14 1986, FAA certification followed on March 21, and first customer deliveries occurred in December that year. 

While of similar overall configuration to the Falcon 50, the Falcon 900 intoduced an all new wider and longer fuselage which can seat three passengers abreast. The main commonality with the Falcon 50 is the wing, which despite being designed for a considerably lighter aircraft, was adapted almost directly unchanged. In designing the Falcon 900 Dassault made use of computer aided modelling, while the aircraft''s structure incorporates a degree of composite materials. 

Two Falcon 900s entered service with the Japanese Maritime Safety Agency for the long-range maritime surveillance role as the Falcon 900MSA, equipped with search radar, special communications equipment, observation windows, a control station, and a drop hatch.

From 1991 the standard production model was the Falcon 900B, which differs from the earlier 900 in having more powerful engines, increased range, the ability to operate from unprepared strips and Category II visibility approach clearance. Earlier production 900s can be retrofitted to 900B standard. 

The Falcon 900EX is a longer range development launched in October 1994. It features TFE731-60 engines, a Honeywell Primus 2000 EFIS avionics suite, optional Flight Dynamics head-up displays, increased fuel capacity and greater range. Its first flight was on June 1 1995 and first delivery was in May 1996. 

The latest Falcon 900 model is the 900C. Revealed in 1998, the C is a development of the B but incorporates the advanced Honeywell Primus avionics of the 900EX, but without autothrottles. The 900C replaced the 900B in the Falcon product line with first deliveries in early 2000.

From 2003 the 900EX will introduce Dassault''s EASy avionics operating system with four colour displays, cursor control devices and multifunction keyboards.',NULL,'Operational'),
('dassaultmystrefalcon10100','The baby of Dassault''s corporate jet lineup, the Falcon 10 and Falcon 100 series (Mystère 10 and Mystère 100 in France) sold in good numbers during a production run that lasted almost two decades. <p>In concept a scaled down Falcon/Mystère 20, the Falcon 10/100 was an all new design except for similar wing high lift devices. Conceived in the late 1960s, the Falcon 10 was the second member of the Dassault Falcon family to be developed. Dassault originally intended the Falcon 10 be powered by two General Electric CJ610 turbojets, and a CJ610 powered prototype first flew on December 1 1970. <p>Flight testing was delayed until May 1971 while changes were made to the wing design, including increasing the wing sweepback angle. The second prototype was the first to be powered by Garrett TFE731 turbofans, and it completed its first flight on October 15 1971. Flight testing was completed with the aid of a third prototype, and French and US certification was awarded in September 1973. Deliveries of production aircraft began that November. <p>While almost all Falcon 10 production was for civil customers, the French navy ordered seven, designated the Mystère 10 MER, as multi purpose pilot trainers. Missions include simulation of targets for Super Etendard pilots and instrument training. <p>The improved Falcon 100 replaced the Falcon 10 in production in the mid 1980s. Certificated in December 1986, changes include an optional early EFIS glass cockpit, a higher maximum takeoff weight, a fourth cabin window on the right side and a larger unpressurised rear baggage compartment. <p>Production of the Falcon 100 ceased in 1990 with the last delivered that September. <p>',NULL,'Operational'),
('dassaultmystrefalcon20200','The Mystère or Falcon 20 and 200 family remains Dassault''s most successful business jet program thus far, with more than 500 built. <p>Development of the original Mystère 20 traces back to a joint collaboration between Sud Aviation (which later merged into Aerospatiale) and Dassault in the late 1950s. Prototype construction began in January 1962, leading to a first flight on May 4 1963. This first prototype shared the production aircraft''s overall configuration, but differed in the powerplant. The prototype was initially powered by 14.7kN (3300lb) Pratt & Whitney JT12A8 turbojets, whereas production Mystère 20s (or Falcon 20s outside France) were powered with General Electric CF700s. The first GE powered 20 flew on New Year''s Day 1965. Throughout the type''s production life Aerospatiale remained responsible for building the tail and rear fuselage. <p>The Falcon 200 is a re-engined development of the 20 which Dassault first publicly announced at the 1979 Paris Airshow. A converted Falcon 20 served as the prototype, and first flew with the new Garrett ATF 3-6A-4C engines on April 30 1980. French DGAC certification was awarded in June 1981. <p>Apart from the Garrett engines, the Falcon 200 (initially the 20H) introduced greater fuel tankage and much longer range, redesigned wing root fairings and some systems and equipment changes. The 200 remained in production until 1988. <p>The Guardian is a maritime surveillance variant of the Falcon 200 sold the French navy (as the Gardian) and the US Coast Guard (HU-2J). <p>AlliedSignal offers a Falcon 20 re-engine program with its TFE731 turbofan. More than 100 Falcon 20s have now been re-engined with 21.1kN (4750lb) TFE731-5ARs or -5BRs. <p>',NULL,'Operational'),
('dehavillandcanadadash7','Despite being out of production for some years now, the four engine de Havilland Canada Dash 7 remains unrivalled because of its impressive STOL and low noise capabilities. 

The Dash 7 (or DHC7) was designed as a STOL (short takeoff and landing) 50 seat regional airliner capable of operating from strips as short as 915m (3000ft) in length. The main design features to achieve such a capability were an advanced wing and four Pratt & Whitney PT6A turboprops. Double slotted trailing edge flaps run the entire span of the high mounted wing, dramatically increasing the lifting surface available for takeoff. Extra lift is also generated by the airflow over the wing from the relatively slow turning propellers. The wings also feature two pairs of spoilers each - the inboard pair also operate as lift dumpers, the outboard pair can act differentially in conjunction with the ailerons to boost roll control. 

Financial backing from the Canadian Government allowed the launch of the DHC7 program in the early 1970s, resulting in the maiden flight of the first of two development aircraft on March 27 1975. The first production Dash 7 flew on March 3 1977, the type was certificated on May 2 1977 and it entered service with Rocky Mountain Airways on February 3 1978. 

The standard passenger carrying Dash 7 is the Series 100, while the type was also offered in pure freighter form as the Series 101. The only major development of the Dash 7 was the Series 150, which featured a higher max takeoff weight and greater fuel capacity, boosting range. The Series 151 was the equivalent freighter. Production of the Dash 7 ended in 1988, following Boeing''s takeover of de Havilland Canada.',NULL,'Operational'),
('dehavillandcanadadhc1chipmunk','Affectionately known as the Chippie, De Havilland Canada''s Chipmunk was designed in response to a growing need to replace the Royal Air Force''s ageing Tiger Moth two seat basic trainer biplane (described separately). 

With a full design workload (courtesy of the revolutionary Comet jet airliner project among others) De Havilland decided to hand design responsibility for the new trainer to its Canadian subsidiary, De Havilland Canada. Design leadership for DHC''s first aircraft was the responsibility of W J Jakimiuk who had emigrated to Canada from Poland in 1940 and was previously responsible for the design of the PZL P-24 and PZL P-50 Jastrzab fighters and the DH-95 Flamingo airliner. 

His new aircraft was designated the DHC-1 Chipmunk and flew for the first time on May 22 1946. Features of the design included a De Havilland Gipsy Major engine and all metal construction (but with fabric covered control surfaces). First deliveries took place the following year. Main Chipmunk models included the Canadian built DHC-1A-1 and DHC-1B-2 (Mk1 and Mk2 in the RCAF), and many featured clear view blown canopies, while main British production models included the initial T10 for the RAF, the Mk20 for foreign military users and the civilian Mk21. OGMA built 60 Mk20 under licence in Portugal. 

Civilianised versions of RAF aircraft became available in large numbers from the late 1950s, and the T10 became the Mk22 in civil service, while the Mk22A was a Mk22 with greater fuel capacity. Farm Aviation Services in the UK heavily modified Chipmunks with a hopper tank in place of the forward cockpit for spraying duties, these aircraft were designated Mk23s. Three similar conversions were performed in Australia by Sasin/Aerostructures as the SA-29 Spraymaster. The Masefield Chipmunk was a conversion available for ex RAF T10s with a blown canopy, wheel pants, luggage space in the wing and increased fuel capacity.

In 1999 a kit version became available for the homebuilt market, developed by Gilles Leger in Montreal, Canada. Leger’s version is called the Super Chipmunk. It has a new more spacious fuselage while using original Chipmunk wings and tail unit, and is powered by a 156kW (210hp) Continental IO-360 engine.

Today the Chipmunk remains a very popular sport and private aircraft, while a small number are still used for pilot training and tailwheel endorsements. Some have also been extensively modified with the installation of Lycoming or Continental engines, e.g. the two Super Chipmunks of famous airshow performer Art Scholl.',NULL,'Operational'),
('dehavillandcanadadhc3otter','Another in de Havilland Canada''s successful line of rugged and useful STOL utility transports, the Otter was conceived to be capable of performing the same roles as the earlier and highly successful Beaver, but was bigger. 

Using the same overall configuration of the earlier and highly successful DHC-2 Beaver, the Otter is much larger overall. The Otter began life as the King Beaver, but compared to the Beaver is longer, has greater span wings and is much heavier. Seating in the main cabin is for 10 or 11, whereas the Beaver could seat six. Power is supplied by a 450kW (600hp) Pratt & Whitney R1340 Wasp radial. Like the Beaver the Otter can be fitted with skis and floats. The amphibious floatplane Otter features a unique four unit retractable undercarriage, with the wheels retracting into the floats. 

De Havilland Canada began design work on the DHC-3 Otter in January 1951, the company''s design efforts culminating in the type''s first flight on December 12 1951. Canadian certification was awarded in November 1952. 

De Havilland Canada demonstrated the Otter to the US Army, and subsequently that service went on to become the largest DHC-3 operator (as the U-1). Other military users included Australia, Canada and India. 

Small numbers of Otters were converted to turbine power by Cox Air Services of Alberta, Canada. Changes included a Pratt & Whitney Canada PT6A turboprop, a lower empty weight of 1692kg (3703lb) and a higher maximum speed of 267km/h (144kt). It was called the Cox Turbo Single Otter. A number of other after market PT6 conversions have also been offered. 

The Otter found a significant niche as a bush aircraft and today it remains highly sought after.',NULL,'Operational'),
('dehavillandcanadadhc4caribou','De Havilland Canada''s fourth design was a big step up in size compared with its earlier products, and was the first powered by two engines, but the Caribou was similar in that it is a rugged STOL utility. The Caribou was primarily a military tactical transport that in commercial service found itself a small niche. 

De Havilland Canada designed the DHC-4 in response to a US Army requirement for a tactical airlifter to supply the battlefront with troops and supplies and evacuate casualties on the return journey. With assistance from Canada''s Department of Defence Production, DHC built a prototype demonstrator that flew for the first time on July 30 1958. 

Impressed with the DHC4''s STOL capabilities and potential, the US Army ordered five for evaluation as YAC-1s and went on to become the largest Caribou operator, taking delivery of 159. The AC-1 designation was changed in 1962 to CV-2, and then C-7 when the US Army''s CV-2s were transferred to the US Air Force in 1967. US and Australian Caribou saw extensive service during the Vietnam conflict. In addition some US Caribou were captured by North Vietnamese forces and remained in service with that country through to the late 1970s. Other notable military operators included Canada, Malaysia, India and Spain. 

The majority of Caribou production was for military operators, but the type''s ruggedness and excellent STOL capabilities also appealed to a select group of commercial users. US certification was awarded on December 23 1960. AnsettMAL, which operated a single example in the New Guinea highlands, and AMOCO Ecuador were early customers, as was Air America (a CIA front in South East Asia during the Vietnam War era for covert operations). Other Caribou entered commercial service after being retired from their military users. 

Today only a handful are in civil use as the Caribou''s thirsty twin row radial engines make commercial operations uneconomic where its STOL performance is not a factor. 

Interest in the Caribou could be revived however, as Pen Turbo from Cape May, NJ has made a conversion with Pratt & Whitney PT6A-67T turbine engines with 5-bladed Hartzell propellers, named the DHC-4A Turbo Caribou, and is now offering this modification on the market under a STC (Supplemental Type Certificate). Apart from the engines, several upgrade possibilities are available.',NULL,'Operational'),
('dehavillandcanadadhc6twinotter','Still Canada''s most successful commercial aircraft program with more than 800 built, the Twin Otter remains popular for its rugged construction and useful STOL performance. 

Development of the Twin Otter dates back to January 1964 when De Havilland Canada started design work on a new STOL twin turboprop commuter airliner (seating between 13 and 18) and utility transport. The new aircraft was designated the DHC-6 and prototype construction began in November that year, resulting in the type''s first flight on May 20 1965. After receiving certification in mid 1966, the first Twin Otter entered service with long time De Havilland Canada supporter the Ontario Department of Lands in Canada. 

The first production aircraft were Series 100s. Design features included double slotted trailing edge flaps and ailerons that can act in unison to boost STOL performance. Compared with the later Series 200s and 300s, the 100s are distinguishable by their shorter, blunter noses. 

The main addition to the Series 200, which was introduced in April 1968, was the extended nose, which, together with a reconfigured storage compartment in the rear cabin, greatly increased baggage stowage area. 

The Series 300 was introduced from the 231st production aircraft in 1969. It too featured the lengthened nose, but also introduced more powerful engines, thus allowing a 450kg (1000lb) increase in takeoff weight and a 20 seat interior. Production ceased in late 1988. In addition, six 300S enhanced STOL performance DHC-6-300s were built in the mid 1970s. 

All models have been fitted with skis and floats.',NULL,'Operational'),
('dehavillandcanadadhc8100200dash8','Bombardier''s de Havilland Dash 8 has proven to be a popular player in the regional turboprop airliner market. 

De Havilland Canada began development of the Dash 8 in the late 1970s in response to what it saw as a considerable market demand for a new generation 30 to 40 seat commuter airliner. The first flight of the first of two preproduction aircraft was on June 20 1983, while Canadian certification was awarded on September 28 1984. The first customer delivery was to norOntair of Canada on October 23 1984. 

Like the Dash 7, the Dash 8 features a high mounted wing and Ttail, and has an advanced flight control system and large full length trailing edge flaps. Power meanwhile is supplied by two Pratt & Whitney Canada PW120 series (originally designated PT7A) turboprops. 

Initial Dash 8 production was of the Series 100, which was followed by the Series 100A in 1990. The 100A introduced a revised interior with extra headroom and PW120A turboprops. The Series 100B was offered from 1992 with more powerful PW121s for better climb and airfield performance. 

Production since switched to the improved performance Dash 8-200. Announced in 1992 and delivered from April 1995 the -200 features more powerful PW123C engines which give a 56km/h (30kt) increase in cruising speed, as well as greater commonality with the stretched Dash 8300. The 200B derivative has PW123Bs for better hot and high performance. 

From the second quarter of 1996 all Dash 8s delivered have been fitted with a computer controlled noise and vibration suppression system (or NVS). To reflect this the designation was changed to Dash 8Q (Q for `quiet''). In 1998 that was changed again to Dash 8 Q200 when a new interior was introduced.',NULL,'Operational'),
('dehavillandcanadadhc8300dash8','With the success of the Dash 8-100 series, a stretched version with greater capacity was a logical development. 

De Havilland Canada (now part of Bombardier) launched full scale development of a 50 seat stretched version of its Dash 8 regional airliner during 1986, approximately two years after the standard fuselage length aircraft had entered service. The first series 300 aircraft was in fact the prototype Dash 8 converted to the new length, and it flew for the first time in its new configuration on May 15 1987. Flight testing culminated in the awarding of Canadian certification in February 1989, with the first delivery to Time Air following late that same month. US certification was awarded in June 1989. 

The stretch comprises fuselage plugs forward and aft of the wing, increasing length by 3.43m (11ft 3in). In addition, the wings are greater in span. The fuselage stretch increases typical seating capacity to 50 (at 81cm/32in pitch), or for up to 56 (at 74cm/29in pitch). Other changes compared with the Dash 8-100 were minor, but included a larger, repositioned galley, larger toilet, additional wardrobe, dual air conditioning packs, a new galley service door and optional APU. 

The Dash 8-300 has been offered in a number of variants. The standard 300 was followed in 1990 by the 300A which introduced optional higher gross weights, interior improvements (as on the Dash 8-100A), and standard PW123A engines (with PW123Bs optional). The 300B was introduced in 1992 and has 1865kW (2500shp) PW123Bs as standard, as is the optional high gross weight of the 300A. The 300E has 1775kW (2380shp) PW123Es rated to 40 degrees, thus improving hot and high performance. 

Like the Dash 8Q-200, all Dash 8-300s built since the second quarter of 1996 have been fitted with a computer controlled noise and vibration suppression system (or NVS) and so from then all models were designated Dash 8Q-300s. In 1998 the aircraft was again renamed, this time to Dash 8-Q300 when a new interior was also introduced.',NULL,'Operational'),
('dehavillandcanadadhc8400dash8','Bombardier''s 70 seat de Havilland Dash 8 Series Q400 (or Q400 for short) is the latest and longest member of the successful Dash 8 family, but with new engines, avionics and systems, a modified wing and stretched fuselage is essentially an all new aeroplane. 

De Havilland was already working on a further stretch of the Dash 8 when Bombardier acquired the company from Boeing in 1992, although the program was not formally launched until June 1995. Rolled out on November 21 1997, the Q400 made its first flight on January 31 1998. Five Q400s were used in the 1900 flying hour flight test program, culminating in Canadian certification being awarded on June 14, 1999, and US certification on February 8, 2000.  The first delivery, to launch customer SAS Commuter, was on January 20, 2000, about 10 months later than originally planned.

The Q400 is pitched at the short haul regional airliner market for stage lengths of 550km (300nm) or less. Despite the recent proliferation of regional jets, Bombardier notes that regional jets have created their own market niche and are not replacing turboprops, which remain more economical over shorter stage lengths. Bombardier says the Q400''s breakeven load factor for a 360km (195nm) stage length will be just 29 passengers. 

The Q400 features a new fuselage stretched 6.83m (22ft 5in) compared with the Q300 mated with the familiar Dash 8 nose section and vertical tail, while the horizontal tail is new. The fuselage''s cross section and structure is based on the earlier Dash 8''s but with two entry doors at the forward and aft ends of the fuselage on the left side, with emergency exit doors opposite them on the right side. 

The Q400''s inner wing section and wing fuselage wing join are new, while the outer wing has been strengthened. Power is from two FADEC equipped 3410kW (4573shp) Pratt & Whitney Canada PW150As. 

The Q400 is fitted with Bombardier''s NVS active noise and vibration system which reduces cabin noise to levels comparable to the CRJ jet airliner. This is achieved through the use of computer controlled active tuned vibration absorbers (ATVAs) mounted on the airframe. 

The flightdeck features five large Sextant LCD colour displays which present information to the pilots in a similar format to earlier Dash 8s, allowing a common type rating.',NULL,'Operational'),
('dehavillandcanadadhc2beaver','De Havilland Canada''s first purpose designed bush aircraft, the Beaver was that company''s most successful program sales wise (both military or civil), with almost 1700 built in a production run lasting two decades. <p>Beaver development work began in 1946 and the Ontario Department of Lands and Forests had considerable input into the final design and configuration of this rugged and versatile utility. A prototype flew on August 16 1947, with seating for five or six, although the production Beaver grew slightly to seat an extra two passengers by the time civil certification was awarded in March 1948. <p>The only major development of the Beaver (aside from a one off powered by a 410kW/550hp Alvis Leonides 502/4 radial engine) was the Turbo Beaver. First flown in December 1963 it featured a Pratt & Whitney PT6A6 turboprop, which offered lower empty and higher takeoff weights, and even better STOL performance. The Turbo Beaver''s cabin was also longer, allowing maximum accommodation for 11, including the pilot. Externally, the Turbo Beaver had a much longer and reprofiled nose, and squared off vertical tail. DHC also offered conversion kits enabling piston powered Beavers to be upgraded to Turbo standard. Other conversions have been performed. <p>',NULL,'Operational'),
('dehavillanddh104dove','The Dove was Britain''s first successful postwar civil aircraft, and one of the few successful Brabazon Committee projects.

The Brabazon Committee was established during WW2 to define requirements for British postwar civil aircraft. While the government established committee was responsible for a number of failures such as the Bristol Brabazon, its studies also resulted in the highly successful Vickers Viscount (described elsewhere) and the de Havilland Dove.

The Dove was developed in response to a requirement for a small feederliner for UK and Commonwealth domestic services. The resulting aircraft featured new versions of the Gipsy Queen engine, a raised flightdeck and separate passenger cabin and all metal construction. The first DH.104 Dove flew for the first time on September 25 1945.

Steady sales success as a regional airliner and corporate transport (particularly in the US) was boosted by significant military orders (RAF versions were known as the Devon, Royal Navy aircraft the Sea Devon).

The Dove remained in production until the mid 1960s (by which time it was a Hawker Siddeley product), and a number of variants were built. These were the initial Series 1, the executive interior Series 2, the military Series 4, the Series 5 with greater range and more powerful engines, the Series 6 (and 6A for the US) executive version of the Series 5, Series 6BA with more powerful engines, Series 7 (Series 7A for the US) with more powerful engines and raised Heron style flightdeck, and Series 8 (8A or Custom 800 in the US) with five seat interior.

In the USA Riley Aeronautics offered conversions of the Dove with two 300kW (400hp) Lycoming IO720 flat eight piston engines. The conversion is known as the Riley 400, and aside from the engines, customers could fit a swept back tail, a new instrument panel and a steel spar crapped wing. The first Riley 400 flew in 1963.',NULL,'Operational'),
('dehavillanddh114heron','The DH.114 Heron is a stretched, four engined development of de Havilland''s successful DH.104 Dove. 

Only a few years later in development than the Dove on which it was based, design work on the Heron began in the late 1940s, resulting in the prototype''s first flight on May 10 1950 (the Dove first flew in 1945). In designing the Heron, de Havilland made as much use of Dove componentry as possible, and so both types feature the distinctive slightly raised cockpit and separate main cabin and metal construction. Initial Heron production aircraft also featured fixed undercarriage (unlike the retractable gear Dove). Major differences include the four 185kW (250hp) Gipsy Queen engines (as opposed to two 255 to 300kW/340 to 400hp Gipsy Queen 70s), greater span wings, a longer and taller fuselage and greater seating capacity. The first Series 1 production Herons were delivered to New Zealand National Airways in 1952. 

Also in 1952 the first Series 2 Heron first flew on December 14. The 2''s main improvement over the 1 was retractable undercarriage, which for a weight penalty of 75kg (165lb) increased cruising speed by 32km/h (17kt), while other standard and optional improvements were minor in nature. The Heron 2A was certificated for use in the USA, and an equivalent 2B executive version was also offered. The 2C and equivalent executive 2D have greater weights. 

The Heron has been the subject of numerous conversion programs. In the USA Riley converted 20 to be powered by Lycoming IO540s (eight more were converted in Australia), while Prinair converted a further 29 to Lycoming power. 

The most ambitious Heron conversions were performed by Saunders, whose ST27 conversions feature two Pratt & Whitney Canada PT6 turboprops and a stretched fuselage. In addition, Tawron converted six Series 1 Herons with Continental engines.',NULL,'Operational'),
('dehavillanddh82tigermoth','One of the most famous biplanes in the world, the much loved Tiger Moth was produced in large numbers for WW2 service as a basic pilot trainer, and today is a highly sought after private aircraft. <p>The DH.82 Tiger Moth is a development of de Havilland''s successful and famous Moth line of biplanes. Based on the DH.60T Moth Trainer, the Tiger Moth first flew on October 26 1931. Like the earlier Moth and Gipsy Moth the new aircraft was a two place biplane and featured a Gipsy Major engine and wooden and metal construction. Difficulty bailing out in an emergency was a problem with the earlier aircraft, and this was addressed through repositioning the struts forward of the front cockpit. To counter centre of gravity problems that would have resulted, the wings were given a modest sweepback angle. <p>The DH.82 attracted the interest of Britain''s Royal Air Force, and the first of what would ultimately be several thousand Tiger Moths entered service with the RAF in 1932. Initial production DH.82s were powered by 80kW (120hp) engines, while the DH.82A introduced in 1937 featured a 97kW (130hp) engine, and was the most produced version. Most prewar production was against military orders, although some civil machines were built. <p>As Britain''s standard basic pilot training aircraft, production of the Tiger Moth increased greatly during WW2, and some 4000 were built in the UK. During the war large numbers were also built in Canada (as the DH.82C with a Gipsy Major IC or 120kW/160hp Pirate D.4 engine), Australia and New Zealand. <p>Postwar, surplus military Tiger Moths proved extremely popular with private owners. Many examples were converted for agricultural work, particularly in Australia and New Zealand, while small numbers of the four seat Jackaroo conversion were built from 1957. <p>Today the Tiger Moth remains very popular, and in some countries the Tiger Moth populations are in fact growing as retired machines are restored and returned to the air. <p>',NULL,'Operational'),
('diamondda40diamondstar','The DA-40 Diamond Star is a composite construction four place light single now offered in avgas and jet fuel burning forms.

Diamond Aircraft was formed in 1981 as Hoffmann Flugzeugbau, and following bankruptcy reformed as Hoffmann Aircraft in 1984. The company was renamed HOAC Austria Flugzeugwerk in 1990 and Diamond Aircraft in 1996. The DA-40 is its first FAR/JAR Pt23 certificated aircraft, its earlier products include the H-36 Dimona, HK-36 Super Dimona (Katana Xtreme) and the Rotax 912 and Continental IO-240 powered DV-20/DA-20 Katana two seater. The DA-20 is built in Canada.

Diamond formally launched the DA-40 on April 23 1997 at the Aero 97 airshow in Friedrichshafen, Germany. The Rotax 914 powered proof of concept DA-40V-1 first flew on November 5 1997, the second prototype DA-40V-2 with a IO-240 followed shortly after. The third prototype, with a Textron Lycoming IO-360, the production powerplant, flew in 1998. Four further prototypes followed, with JAA JAR 23 certification awarded on October 25 2000. FAA and JAR certification was awarded in April 2001.

The DA-40-180 is based loosely on the DA-20 but features a larger fuselage with seating for four and a slightly longer span wing. The airframe is made from glassfibre reinforced plastics with carbonfibre reinforcement in some areas. Power is from a Lycoming IO-360 with Lasar electronic fuel injection. Standard fuel capacity is 155 litres, optional fuel capacity is 200 litres.

The turbo diesel Thielert Centurion 1.7 powered DA-40D TDI flew on November 28 2001. Despite "only" producing 100kW (135hp) the Centurion 1.7 gives the DA-40D TDI cruise performance comparable to the DA-40-180 and even better range, while burning just 17 litres of fuel (either jet fuel or diesel) an hour. Deliveries of this version started in early 2003.',NULL,'Operational'),
('diamondda42twinstar','The Diamond DA-42 Twin Star is an all new four place carbonfibre construction light twin powered by jet fuel burning turbo diesel engines.

Austria''s Diamond Aircraft unveiled the DA-42 at the May 2002 Berlin Airshow. The new aircraft flew on December 9 2002, leading to European JAA certification in late 2003 and US FAA certification and first deliveries in mid 2004.

The Twin Star''s design objectives include high speed cruise at very low throttle settings and good low speed handling. It is loosely modelled on Diamond''s DA-40 Diamond Star single engine four place (see separate entry), and features an all composite airframe with a high aspect ratio wing with winglets.

The heart of the Twin Star is its two Thielert Centurion 1.7 (formerly TAE-125) turbo diesel four cylinder engines, which are designed to run on either diesel or Jet-A1/jet fuel. Germany based Thielert''s Centurion turbo diesel engine was certificated in early 2002 and is based on a Mercedes-Benz automotive design. Diamond expects the DA-42''s two engines will burn just 45 litres an hour while cruising at a very fast 333km/h (180kt). Standard fuel capacity is 200 litres, while optional long range tanks take maximum fuel capacity to 280 litres.

The engines drive slow turning three blade constant speed propellers, which combined with the engines'' low noise emissions and the DA-42''s fast climb rate will result in a low ground noise signature. The engines also feature electronic fuel management, automatic prop controls and auto feather.

The Twin Star will feature dual controls and an optional EFIS glass cockpit with three vertical format colour LCDs. The basic aircraft will be equipped with conventional IFR avionics.

Diamond Aircraft says the DA-42 will be suitable for flight training as well as private and business use.

Embry-Riddle Aeronautical University was the launch customer with an order for 10, and Lufthansa ordered 40 for its pilot training school. Another customer is PureFlight of the UK which ordered the Twin Star for its fractional ownership programme.',NULL,'Operational'),
('dornier228','In terms of civil sales the 228 series was Dornier''s most successful postwar design. 

The Dornier 228 incorporates the fuselage cross section of the earlier Do 28 and 128 combined with an all new high technology supercritical wing and TPE331 turboprops. Two fuselage length versions, the 100 and 200, were developed concurrently, the 100 offering better range, the 200 more payload. The 100 was the first to fly taking to the skies for the first time on March 28 1981, the first 200 followed on May 9 that year. The first 228 entered service in August 1982. 

Composites were used in a number of secondary structure areas on the 228 including upper wing skins, nose and tail. At one stage Dornier also planned to offer the Pratt & Whitney Canada PT6A as an optional powerplant, but this never eventuated. 

228 developments include the 228-101 with reinforced structure and landing gear for higher weights, the corresponding 228-201 version of the 200, the 228-202 version built under licence production in India with HAL to meet that country''s Light Transport Aircraft requirement, and the 228-212. 

The 212 is the last Dornier (now Fairchild Aerospace) production aircraft, its improvements include higher operating weights, structural strengthening and a lower empty weight, improvements to enhance STOL performance and modern avionics. The last of 238 Dornier built 228s was completed in 1999.  HAL licence production continues.',NULL,'Operational'),
('dornier328','The 30 seat Dornier 328 is a modern regional turboprop airliner that offers high cruising speeds and advanced systems. 

Development of the 328 traces back to Dornier''s mid 1980s market research that indicated there existed a substantial market for regional airliners in the 30 seat class through to 2005. Firm 328 development work began in December 1988, culminating in the first development aircraft''s first flight on December 6 1991. 

The 328 was awarded certification in October 1993. First customer deliveries also occurred in October 1993. 

The 328 design incorporates an all new fuselage section for three abreast seating (offering more width per passenger than the 727/737) combined with the same basic supercritical wing of the earlier Dornier 228. Clean aerodynamics give the 328 excellent high speed cruise and climb performance. Composite materials are used in a number of areas (particularly the tail) to reduce weight and the blades on the Hartzell props are composite. The flightdeck features a five screen Honeywell Primus 2000 EFIS avionics system, while with heads-up displays the 328 can be qualified for Cat IIIa landings. 

Industrial partners on the 328 include Daewoo Heavy Industries (fuselage), Aermacchi (nose), Westland (nacelles) and Israel Aircraft Industries (wing), accounting for 40% of the aircraft''s construction. 

Variants of the 328 are the initial production standard 328-100, the standard 328-110 with a larger dorsal fin, heavier weights and greater range, the 328-120 with PW119C engines and improved short field performance and the 328-130 with progressive rudder authority reduction with increasing airspeed. 

At various times Dornier studied 50 seat stretches of the 328, but all were abandoned. Dornier also studied building a 328 demonstrator powered by hydrogen. The liquid hydrogen fuel would have been stored in two external tanks under the wings and outboard of the engines.

The last 328 was delivered to Air Alps Aviation in Austria in October 1999. The 328JET regional jet development is described separately.

Fairchild Aerospace acquired 80% of Dornier in early June 1996 to form Fairchild Dornier GmbH, but production of the 328 had stopped already before the Fairchild Dornier name became effective August 8, 2000.',NULL,'Operational'),
('dornierdo27','The Dornier Do 27 was the first military aircraft to be manufactured in quantity in what was West Germany since World War 2, and it was also built in limited numbers for civil customers. <p>The Do 27 traces back to the Do 25, which Professor Claude Dornier (Dornier was responsible for the Do 17 medium bomber in WW2) designed in Spain for a Spanish military requirement for a light general purpose utility aircraft. Two prototype Do 25s were built, the first was powered by a 110kW (150hp) ENMA Tigre GIVB engine and flew for the first time on June 25 1954. Subsequently CASA built 50 production aircraft as Do 27As for the Spanish air force (Spain designated the type C127). <p>Following this success the German military ordered the Do 27 in large numbers. Some 428 were delivered to Germany''s armed forces from the mid 1950s to 1960, although these aircraft have since been retired. Small numbers were built for other military customers, and others for commercial use. <p>Features of the Do 27 design include a flat six Lycoming engine, a wide and relatively roomy cabin, wide track undercarriage and excellent STOL performance. The STOL performance in particular suited the Do 27 for use in undeveloped countries, and several have seen service in Africa and Papua New Guinea. <p>Do 27 models include the initial Do 27A and dual control Do 27B for Germany; the Do 27H series that was based on the A4 but with a more powerful engine and three blade prop; and the Do 27Q series, equivalent to the Do 27A. <p>',NULL,'Operational'),
('dornierdo28128','The Do 28 Skyservant was the second aircraft to bear the Do 28 designation, but is similar only in overall configuration to the first Do 28. 

Dornier''s original Do 28 first flew in 1959 and was a twin engined development of the high wing single engine Do 27 utility. The Do 28 Skyservant first flew on February 23 1966, and while it retained the earlier Do 28''s high wing and unique side mounted engine configuration, was a completely new aircraft. Other design features of this unusual looking aircraft were the fixed tailwheel undercarriage, with the faired mainwheels mounted under the engines. FAA certification was granted on April 19 1968. 

The Do 28 was developed into a number of progressively improved variants, from the original D, through the D1 and D2, to the 1282, introduced in 1980. Each variant introduced a number of detail changes. Most Do 28 production was for military customers, notably Germany, although a small number were delivered to commercial operators. 

An initial turboprop version of the Do 28, designated the Do 28D5X, first flew in April 1978, fitted with two Avco Lycoming LTP 1016001As derated to 300kW (400shp). 

However production turboprop Dornier 1286s feature Pratt & Whitney Canada PT6As, with the first such configured aircraft flying in March 1980. Only a small number were built between then and 1986, when production ceased, and again most aircraft were for military customers.',NULL,'Operational'),
('douglasdc3','No greater accolade for the DC-3 exists than the fact that over six decades after its first flight more than 400 remain in commercial service worldwide. Durability, longevity and profitability are but three of this outstanding aircraft''s virtues. <p>Development of the DC-3 traces back to the earlier oneoff Douglas Commercial 1 (DC1) and subsequent DC2 which made their first flights in 1933 and 1934 respectively. In 1934 American Airlines requested that Douglas develop a larger more capable version of the DC2 for transcontinental US sleeper flights. The resulting DC-3 (or DST - Douglas Sleeper Transport as it then was) flew for the first time on December 17 1935. <p>An almost instant sales success, the DC-3 became the mainstay of the US domestic airline network in the years prior to World War 2. Aside from passenger comfort and appeal, the DC-3 offered that most important of virtues, profitability, with the result that over 400 had been sold to airlines prior to late 1941. <p>The entry of the United States into WW2 in December 1941 had a profound effect on the fortunes of the already successful DC-3. The US Army Air Force''s requirements for transport aircraft were admirably met by the inproduction DC-3, with the result that as the C47 Skytrain it became the standard USAAF transport during the war. More than 10,000 were built for service with US and allied air arms. <p>After the war many of these aircraft became surplus to requirements and were sold off at bargain prices. The result was that demilitarised C47s became the standard postwar aircraft of almost all the world''s airlines and the backbone of the world airline industry well into the 1950s. Its availability and reliability meant it proved extremely popular. Even today hundreds remain in service. <p>A postwar update of the DC-3, the Super DC-3, involving a stretched airframe and more powerful engines, was commercially unsuccessful. This aircraft first flew in June 1949. A small number were built for the US Navy as the R4D8 and for a US domestic airline, and a few remain in service. <p>',NULL,'Operational'),
('douglasdc4','The history of the DC-4 dates back to when United Airlines devised a requirement for a four engine long range airliner. <p>United looked to Douglas to fulfil the requirement, who devised the highly ambitious DC-4E (where the E stood for experimental). This four engined behemoth was flight tested in 1939. It was roughly three times the size of the DC-3 (its wingspan was 42.17m/138ft 3in, and length 29.76m/97ft 7in), had triple tail surfaces, tricycle undercarriage, was pressurised and potentially could fly nonstop from Chicago to San Francisco. <p>However all the ground breaking new technology on the DC-4E meant that it was costly, complex and had higher than anticipated operating costs, so Douglas thoroughly revised the design, resulting in the smaller and simpler definitive DC-4. <p>The new DC-4 was developed under the darkening clouds of WW2, and upon the USA''s entry into war all DC-4s then on the production line were requisitioned for the US military. The result was that the first DC-4 flew for the first time on February 14 1942 in military markings (as the C-54 Skymaster). The DC-4 was found to admirably suit the USAAF''s requirement for a long range cargo transport, and 1162 were built through the war years. <p>As was the case with the DC-3, the end of war meant that much of that number were surplus and sold to the world''s airlines. Further to this Douglas built an additional 78 DC-4s to new orders. Over the years the survivors have been passed down to charter and freight airlines, and today small numbers survive in service as freighters. <p>Notable developments of the DC-4 include Aviation Trader''s much modified Carvair freighter (described separately) while Canadair built a number with RollsRoyce Merlin engines and pressurised fuselages. The DC-4 also formed the basis for the larger DC-6 and DC-7 which are described separately (the DC-4 was the first airliner to introduce a circular section, constant diameter fuselage which made stretching the basic aircraft relatively simple). <p>',NULL,'Operational'),
('douglasdc6','While the DC-3''s and DC-4''s civilian careers were interrupted by WW2, the opposite applies to the DC-6, which started off in response to a military airlift requirement, and went on to become Douglas'' most successful four engined piston airliner. 

During the latter stages of WW2 Douglas began work on a developed DC-4 for postwar commercial use. However the improved DC-4 (which would feature a 2.11m/6ft 11in fuselage stretch and P&W R-2800 Double Wasp engines) soon attracted the attention of the US Army Air Force, which devised a requirement which the new transport was developed against. A prototype was built, designated XC-112, but it did not fly until February 15 1946, by which time the war was over and the military requirement no longer stood.

Instead Douglas continued development of the type as a long range airliner, resulting in the DC-6. The XC-112 served as the prototype for the DC-6 program. US airlines had already shown strong interest in the new transport, with launch orders for the DC-6 placed in September 1944. The first production DC-6 first flew in June 1946 and service entry, with United Air Lines, occurred on April 27 1947. However early service was not smooth with the fleet grounded for four months from November that year after two internal fuselage fires in flight, one being fatal, caused by fuel venting entering the cabin heater ram air intake. 

The availability of the more powerful R-2800 engines with water/methanol injection prompted Douglas to develop the further stretched DC-6A Liftmaster freighter (first flight September 29 1949) and the equivalent passenger DC-6B (first flight February 2 1951). The DC-6C, the last DC-6 model to be developed, was a convertible passenger/freight version of the DC-6A.

Meanwhile renewed military interest in the DC-6 was sparked by the Korean War, with the result that large numbers of USAF C-118s and USN R6D-1s were built. Many of these were later sold to civilian operators.',NULL,'Operational'),
('douglasdc7','Douglas'' largest and last piston engined airliner, the DC-7 was one of the first airliners capable of nonstop trans Atlantic crossings between New York and London. 

Previously the DC-7 designation had applied to a commercial development of the C74 Globemaster I that PanAm had ordered. As it emerged though the DC-7 arose from an American Airlines requirement for a stretched longer range development of the DC-6. The resulting aircraft was based on the same wing of the DC-6 (also the same basic wing designed for the DC-4), with a stretched DC-6 fuselage, more powerful Wright Turbo Compound engines and extra fuel allowing Douglas to guarantee it could offer nonstop transcontinental US range in both directions. 

The prototype DC-7 flew for the first time on May 18 1953, and the type entered service with American that November. Production of the initial DC-7 was solely for US domestic operators. The improved DC-7B had the same dimensions as the DC-7, but carried extra fuel, allowing PanAm to inaugurate nonstop New York/London services from June 1955. 

While the DC-7B could fly New York/London nonstop, weather conditions often forced reverse services to make a refuelling stop at Gander. This operational hurdle gave Douglas the impetus to develop the ultimate DC-7 model, the DC-7C `Seven Seas''. The DC-7C featured extra fuel capacity, a 3.05m (10ft) fuselage stretch and more powerful engines, and could cross the North Atlantic nonstop in either direction. It entered service in April 1956, although sales were restricted by the coming availability of jets. 

Today a small number DC-7s survive, mainly as freighters. Douglas offered DC-7F conversions from 1959 (the DC-7F described above is based on the DC-7B). Others are used for firebombing.',NULL,'Operational'),
('douglasdc81020304050','The popular DC-8 was Douglas'' first jet powered airliner, and the USA''s second successful jet powered transport behind the Boeing 707. 

Despite its strong hold on the world airliner market in the early 1950s, and the appearance of the jet powered De Havilland Comet in 1949, Douglas moved cautiously into the field of jet powered transports, a decision which was to cost it dearly in lost potential sales over the following decades. 

Douglas announced it was developing the jet powered DC-8 airliner in June 1955, a year after the first flight of the Boeing Model 367-80, the 707 predecessor. The first DC-8 flew on May 30 1958, five months before the 707 entered service with Pan Am. A concerted flight test program involving nine aircraft led to certification being awarded on August 31 1959. Entry into commercial service with launch customers United and Delta was on September 18 that year. 

Unfortunately for Douglas, the earlier availability of the 707 meant that initial sales of the DC-8 were relatively slow. However, the emergence of Douglas'' design had already forced Boeing to widen the fuselage width of the 707, and unlike the Boeing the DC-8 was offered in domestic and intercontinental versions from the start. 

Versions of the initial short fuselage DC-8 were: the Series 10, the initial domestic version with 60.1kN (13,500lb) P&W JT3C-6 turbojets - 28 were built for Delta and United; the similar Series 20 but with more powerful 74.7kN (16,800lb) JT4A-9 turbojets; the intercontinental Series 30 and Series 40, powered by JT4A-11s or Rolls-Royce Conways respectively; and the Series 50, perhaps the definitive short fuselage model and a direct competitor to the 707-320B/C, with 80.1kN (18,000lb) JT3D-3 turbofans. Convertible 50CF and pure freight 50AF Jet Trader versions were also offered, while others were subsequently converted to freighters. 

The short fuselage DC-8s were replaced in production by the substantially larger stretched DC-8 Super Sixty series.',NULL,'Operational'),
('douglasdc86070','The successful DC-8 Super 60 airliners are stretched developments of the DC-8 Series 50. The Super 70s are Super 60s re-engined with CFM56 high bypass turbofans.

Douglas announced the DC-8 Super Sixty series in April 1965. The first, a DC-8-61, took to the skies for the first time on March 14 1966, followed by the first flights of the DC-8-62 on August 29 1966 and the DC-8-63 on April 10 1967. The DC-8-61 differed from the earlier DC-8-50 in having two fuselage plugs which increased length by 11.18m (36ft 8in), increasing max seating capacity to 259 (the largest of any single aisle airliner prior to the 757-300) and underfloor freight capacity by 80%. Intended for domestic operations, its max takeoff weight was identical to the DC-8-50. 

The Super 62 was intended for long range operations and featured only a modest 2.04m (6ft 8in) stretch compared to the Series 50, greater wing span, revised engine nacelles and pylons and significantly increased fuel capacity. The Super 63 meanwhile combined the DC-8-61''s fuselage with the DC-8-62''s wings. It was the final DC-8 variant in production, and the last was delivered in May 1972.

McDonnell Douglas initiated a re-engining program of Super 60 series aircraft with CFM International CFM56 engines in the early 1980s, known as the Super 70 Series. The first converted airframe flew in August 1981. The Super 70 aircraft are considerably quieter than their predecessors, with better fuel economy and greater range.',NULL,'Operational'),
('ehindustrieseh101','EH Industries offers commercial developments of its EH 101 aimed at offshore oil rig support, airport/city centre shuttle and utility operations. <p>EH Industries is a collaborative venture between Westland of the UK and Agusta of Italy (in 1998 both companies agreed to merge) which was formed to develop an anti submarine warfare helicopter for the Royal Navy and Italian navy. The partnership was formed in 1980, and both companies have a 50% holding. From the outset both companies intended to develop civil and commercial models of the EH 101. Westland has design responsibility for the Heliliner, the anti submarine warfare variant is being developed jointly, while Agusta heads development of military and utility transport versions with a rear loading ramp. <p>EH 101 full scale development began in March 1984. The first flight of an EH 101 (the Westland built PP1) was on October 9 1987, while the first civil configured EH 101, PP3, first flew on September 30 1988. The first production EH 101 (a Merlin for the Royal Navy) first flew in December 1995. <p>While the Royal Navy''s EH 101 Merlin ASW helicopters and the Royal Air Force''s Merlin HC.3 tactical transports will have RollsRoyce Turboméca RTM322 engines, Italian and civil EH 101s will have General Electric CT7 engines. <p>The 30 seat Heliliner is optimised either for offshore oil rig or airport to city centre transfers, and the rear freight door is offered as an option, while the civil utility version has the rear ramp fitted as standard. Canada''s military has ordered 15 similar AW320 Cormorants for search and rescue work. <p>So far Tokyo''s police is the only civil EH 101 customer. In late 1998, two preproduction machines - PP3 and PP9 - began a program of simulated commercial and military operations in the North Sea based from Aberdeen in Scotland, part of efforts to validate reliability and maintainability. <p>',NULL,'Operational'),
('embraeremb110bandeirante','The Embraer EMB-110 Bandeirante, or `Bandit'', remains Embraer''s most successful commercial aircraft program. 

Design of the EMB-110 was undertaken in response to a Brazilian Ministry of Aeronautics specification for a general purpose light transport suitable for military and civilian duties. The new design was developed with the assistance of well known French designer Max Holste, and the first of three YC-95 prototypes flew for the first time on October 26 1968. 

Embraer (or Empresa Brasilera de Aeronautica SA) was established the following year, and development and production of the C95 became one of the company''s first responsibilities. The first production standard EMB-110 Bandeirante (Portuguese for Pioneer) flew on August 9 1972, and the first entered airline service in April 1973. 

Bandeirante models include the 12 seat transport EMB-110, the aerial photography EMB-110B and maritime patrol EMB-111 for the Brazilian air force; the initial airline version, the 15 seat EMB-110C; the seven seat EMB110E executive transport; 18 seat enlarged EMB-110P; convertible passenger/freight EMB110P1 with larger rear door; the EMB-110PA which replaced the 110P as the standard passenger aircraft from 1983 and introduced dihedral to the tailplane among other minor improvements; the EMB-110P1K and EMB-110K SAR military equivalents to the P1A; the EMB-110P2 commuter with seating for up to 21; the EMB-110P2A which replaced the P2 and introduced the same changes as the P1A; and the EMB-110P1A/41 and EMBP2A/41 versions of the P1A and P2A recertificated to US FAA SFAR41 standards with higher weights. 

Production of the Bandeirante ceased in May 1990, the final aircraft being delivered to the Brazilian Air Force. Today the Bandeirante''s virtues of reliability and good operating economics means that it remains popular with its operators.',NULL,'Operational'),
('embraeremb120brasilia','The Brasilia has proved to be a popular, relatively high speed yet comparatively inexpensive to operate and purchase regional airliner. 

Embraer first began design work on a new regional turboprop airliner in the late 1970s when the company studied stretching its EMB121 Xingu corporate turboprop to a 25 seat regional airliner. While this was the first aircraft to bear the EMB120 designation (it was named the Araguia), the production EMB120 is an all new aircraft. Design studies of the definitive EMB120 began in September 1979, first flight of a PW115 powered prototype took place on July 27 1983, and entry into service was in October 1985. 

Versions of the EMB120 include: the initial production EMB120; the Reduced Takeoff weight EMB120RT; the Extended Range EMB120ER; the EMB120 Cargo freighter; mixed passenger/freight EMB120 Combi; and EMB120 Convertible. Hot and high versions of these models have PW118A engines, which retain their power ratings to a higher altitude. 

The current production model is the EMB120ER Advanced, which incorporates a range of external and interior improvements. The fuselage of the EMB120 also forms the basis for the ERJ145 50 seat regional jet.',NULL,'Operational'),
('embraeremb121xingu','The sleek looking Xingu coupled the Bandeirante''s wing and engines with an all new fuselage, but was only produced in modest numbers. 

The Xingu flew for the first time on October 10 1976, with a production aircraft following on May 20 1977. The first customer delivery occurred later that same year (to the CopersucarFittipaldi Formula One racing team). 

The major customer for the Xingu I was the French military, with a total order for 41 (for aircrew training and liaison duties for the air force and navy), which accounted for almost half of all EMB121 production. 

Several derivatives of the Xingu design were proposed, including the original EMB120, the Araguia, a commuter airliner which would have seated 25, and the EMB123 Tapajós. The Tapajós would have had more powerful 835kW (1120shp) PT6A45 engines (which also would have powered the Araguia), increased wing span and a lengthened fuselage. 

A more modest development did enter production, the EMB121B Xingu II. This introduced more powerful engines, four blade props, increased fuel tankage and greater seating capacity courtesy of a slightly stretched fuselage. Similar in size, powerplant and performance to the Raytheon Beech King Air B200, the Xingu II made its first flight on September 4 1981. 

Production ceased in August 1987 after 105 had been built.',NULL,'Operational'),
('embraererj135140legacy','The ERJ-135 and more recent ERJ-140 are shortened developments of the 50 seat ERJ-145, while the Legacy is a corporate development of the ERJ-135. 

Embraer launched the ERJ-135 on September 16 1997. Just nine and a half months passed before first flight on July 4 1998 (following rollout on May 12 that year). A second prototype first flew in October 1998, US FAA certification was awarded on July 16 1999 and first delivery was to Continental Express on July 23 1999. 

The speed of the development program illustrates that the ERJ-135 is a fairly straightfoward development of the 145. Both 135 prototypes were converted from ERJ-145 prototypes, requiring little modification other than the removal of two fuselage plugs totalling 3.50m (11ft 6in) in length. 

Other changes compared with the -145 are minor. Both are powered by Rolls-Royce (Allison) AE-3007 turbofans but the ERJ-135''s are derated by around 5%, achieved by a slight software change to the engines'' FADEC system. The only other notable change is new valves in the air-conditioning system. 

Like the ERJ-145 therefore, the 135 also features a Honeywell Primus 1000 avionics suite with five large multifunction displays in the cockpit, a Sundstrand APU and three abreast seating in the main cabin. 

Also in common with the ERJ-145, the 135 is offered in standard ERJ-135ER and extended range ERJ-135LR forms. The LR features an additional fuel tank and slightly more powerful AE-3007A4 turbofans. 

Few new airliners have sold as quickly from their launch as the ERJ-135. Building on the success of the 145, the 135''s order book stood at 145 at late 1998, barely a year after launch. The aircraft''s two biggest customers were American Eagle which ordered 75 and optioned 75 at the 1998 Farnborough Airshow to join 42 firm ordered ERJ-145s, and Continental Express with 25 firm and 50 optioned to complement 75 ERJ-145s it had on order.

In September 1999 Embraer launched the third member of its regional jet family, the 44 seat ERJ-140. The ERJ-140 is also a minimum change development, and differs from the 135 and 145 only in its fuselage length and seating capacity. First flight was on June 27 2000 and deliveries began in late July 2001.

The 140 is largely aimed at US airlines who have to contend with pilot labour agreement restrictions on the numbers of 50 seater jets they can operate. American Eagle was the launch customer.

Meanwhile at Farborough 2000 Embraer launched development of the ERJ-135 based Legacy corporate jet. First flight (of a converted ERJ-135) was on March 2001. The Legacy features additional fuel giving a range with 10 passengers of 5930km (3200nm).

Although the marketing designations are ERJ-135, ERJ-140 and Legacy, the certification designations remain as EMB-135ER/LR for the ERJ-135ER/LR, EMB-135KL for the ERJ-140LR and EMB-135BJ for the Legacy.',NULL,'Operational'),
('embraererj145','Despite a chequered early development history, the 50 seat ERJ-145 has become a runaway sales success. 

Embraer began working on 50 seat regional jet concepts in the late 1980s. The original EMB-145 (the marketing designation later became ERJ-145) was launched in mid 1989 and would have been a stretched and jet engined EMB-120 Brasilia. Features of this design included a straight wing with winglets and the two turbofans mounted forward of the wing as on most low wing turboprops. This design would have seated 45 to 50 passengers and featured 75% commonality with the Brasilia. In that configuration cruising speed would have been 740km/h (400kt) and range with a 4500kg (9920lb) payload 2500km (1350nm). 

But by 1990 Embraer was studying a modified design with less commonality to the Brasilia as wind tunnel testing revealed that the original configuration would not reach its design performance objectives. Changes to this interim design included a mildly swept wing with winglets (wing sweep of 22.3°) and conventional below wing mounted engines. Wind tunnel testing proved that this configuration met design objectives however it had a major drawback in that it would have needed an unusually high undercarriage.

Thus in late 1991 Embraer froze the ERJ-145 design with rear fuselage mounted engines and T-tail, and no winglets. Other features include Rolls-Royce (Allison) AE-3007A turbofans and a Honeywell Primus 1000 EFIS avionics suite with five colour CRT screens in the flightdeck. The Brasilia''s three abreast fuselage cross section was retained. 

The ERJ-145''s first flight took place on August 11 1995 with first deliveries from December 1996 to Continental Express. Continental''s initial order for 25 was a major fillup for the program and opened the floodgates for a number of major sales. 

Embraer has developed several versions of the ERJ-145, the initial ERJ-145ER, the higher max takeoff weight longer range ERJ-145LR introduced in 1998 and most recently the ERJ-145XR (Extra Long Range). The 145XR first flew on June 29 2001 and entered service in October 2002. It features uprated yet more fuel efficient 36kN (8110lb) engines, winglets, 24,100kg (53,131lb) max takeoff weight, a max cruising speed of Mach 0.8 (852km/h/460kt) and increased fuel capacity for a 3705km (2000nm) range. The ERJ-145EP and -EU are -ERs with different max takeoff weights, and the ERJ-145LU and -MP are -LRs with different max takeoff weights.

Other EMB-145 developments are the AEW&C (Airborne Early Warning and Control) EMB-145SA with an Erieye radar on top of the fuselage (serving with the Brazilian Air Force as R-99A), the EMB-145AEW which is the export variant of the EMB-145SA (for Greece and Mexico), the EMB-145RS, a remote sensing variant (serving with the Brazilian Air Force as the R-99B and with the Mexican Air Force) and the maritime patrol and ASW EMB-145MP/ASW which will serve with the Brazilian Air Force as P-99. The standard EMB-145ER serves as the C-99A in the Brazilian Air Force.

Since mid 2004, the ERJ-145 is also assembled in China by Harbin Embraer.

The shorter fuselage ERJ-135 and ERJ-140 and the corporate transport EMB-135BJ Legacy are described separately.',NULL,'Operational'),
('embraererj170175190195','The Embraer ERJ-170 and ERJ-190 series are all new entrants into the top end of the regional jet airliner market, with seating capacities spanning from 70 to 108.

Embraer announced the ERJ-170 and ERJ-190 in February 1999, and formally launched the program on June 14 that year at the Paris Airshow.

The first member of the family is the 70 seat Embraer 170, which rolled out on October 29 2001 (when the ERJ prefix was dropped for the marketing designation) and first flew on February 19 2002. Six aircraft were being used in the flight test program.

The public debut was at the Regional Airline Association convention at Nashville, Tennessee in May 2002, followed by its European debut at the Farnborough International Air Show in July the same year. The 170 was certificated in February 2004 and deliveries started in March 2004 to LOT Polish Airlines, US Airways and Alitalia Express.

Embraer is also building the Embraer 175, stretched by 1.77m (5ft 10in) over the Embraer 170. The first flight was made on June 14 2003.

The 6.25m (8ft 5in) stretched Embraer 190 seats 98 passengers, the further stretched Embraer 195, 2.41m (7ft 11in) longer than the 190, will seat 108. The Embraer 190 made the first flight in March 2004, followed by the 195 in December the same year. 

All three variants are offered in standard and LR (long range) variants. A corporate jet version of the 170 is also proposed.

Features of the family include new FADEC equipped GE CF34 engines (the most powerful CF34 variants), a new four abreast "double bubble" fuselage cross section, a moderately swept wing with winglets (added to the design in mid 2000), fly-by-wire flight controls, and Honeywell Primus Epic EFIS avionics.

Although Embraer 170/175/190/195 are the marketing designations, the official type certificate designations remain ERJ prefixed as ERJ-170/175/190/195.',NULL,'Operational'),
('enstromf28280480','This long running line of three, four and five place light helicopters dates back to the late 1950s and remains in production. 

The Enstrom Helicopter Corporation was first formed in 1959, and the three place F-28 was its first product. The first F-28 prototype made its maiden flight on November 12 1960, with the production prototype of the F-28 flying in May 1962. Since that time numerous developments of the basic design have been built. These include the F-28A which appeared in 1968; the T-28 powered by a Garrett AiResearch TSE36-1 turbine engine, which flew in 1968, but was not taken into production, the Model 280 Shark from 1973, an improved version with a reprofiled airframe which supplemented the F-28A in production; and the turbocharged F-28C and 280C, which were certificated in 1975. 

The prototype for the Allison (now Rolls-Royce) 250 turboshaft powered 480 five seater and TH-28 three seat trainer first flew in 1989 after a proof of concept 280FX testbed powered by an Allison 250-C20W began test flying the previous year. The 480 was certificated in June 1993, the TH-28, which Enstrom unsuccessfully entered into a recent US Army competition for a new pilot training helicopter, was certificated in 1992 and is aimed at training and light patrol work. 

Current Enstrom production models are the F-28F Falcon which first appeared in 1981; the FLIR pod equipped F-28F-P Sentinel which is optimised for police work; the three seat 280FX Shark which was certificated in early 1988; and the turbine powered 480 and TH-28.',NULL,'Operational'),
('ercoercoupeandderivatives','In 1937, Fred Weick of Erco (The Engineering and Research Corp) developed the model 310, which was the basis for the distinctive Ercoupe.

The first flight was made on October 1, 1937 with a 37hp Continental A-40 engine, which was later replaced by a 55hp Erco IL-116. Fred Weick''s research into safe airplanes was employed in the design. The rudder controls were eliminated and the aircraft was handled by the control wheel only, making it easy to fly and making stalls and spins almost impossible. Later models reverted to conventional rudder bars, as existing pilots tended to be confused by the system. A novel fixed tricycle landing gear for better ground handling was installed, and the cockpit was designed to have allround visibility.
  
The aircraft was a low-wing cabin monoplane with side-by-side seating for two, and had an all-metal fuselage with fabric-covered wings, but later production had all-metal wings. The 310 was originally flown with a single fin, but during development this was replaced by twin tailfins. After three years of exhaustive testing, on March 25, 1940, the type certificate was issued to the production model, the 415C, which was powered by a 65hp Continental A-65-8 engine. Production was halted in 1941 after 112 aircraft had been built, as all aluminum was needed for the war effort. One 415C was evaluated by the Air Force as an observation aircraft, designated YO-55, and two more were tested as target drones, designated XPQ-13, but the aircraft was not found suitable for military service.

In August 1945 production of the 415C was resumed, with some improvements and a 75hp Continental C-75-12 engine. In February 1946, Fred Weick received the Fawcett Aviation Award for the greatest contribution to the scientific advancement of private flying. Post-war, Erco built 4,408 model 415C, 77 model 415D, and 275 model 415CD. In 1950, they ceased production of the Ercoupe because light aircraft production became uneconomic for them.

Production of the Ercoupe was handed over to Sanders, who completed 209 aircraft from Erco parts as the 415E (85hp Continental C-85-12 engine), 415F (90hp C-90), 415G ClubAir (85hp C-85-12 with an additional rear kid''s seat), and 415H (75hp C-75). In 1954 the type certificate was sold to Vest aircraft, who did not built any aircraft, but sold it on to Forney in April 1955.

Forney produced 139 aircraft as the F-1 and F-1A Aircoupe with many details improved, and powered by a 90hp Continental C-90-12F engine. Forney changed name to Fornaire in 1959, and the F-1 was now available with differing standards of equipment as the Execta, Expediter, and Explorer. 

Air Products took over production in 1960 and built another 26 as the F-1A Aircoupe until 1962. In 1964 Alon started to build the design as the A-2 and A-2A Aircoupe with a 90hp Continental C-90-16F engine, a sliding bubble canopy, and other changes. Alon merged with Mooney in 1967, who continued to build the A-2A, but in 1969 they redesigned the aircraft with a single fin as the M-10 Cadet. In 1970 the last ones were produced.',NULL,'Operational'),
('eurocopteras332superpuma','A larger development of the Puma (described under Aerospatiale), the Super Puma is a practical and proven medium lift twin helicopter, particularly popular for offshore oil rig support work. 

The original SA 330 Puma, on which the Super Puma is based, flew for the first time in April 1965. The first Super Puma first flew in September 1978 and was essentially a more powerful version of the Puma, featuring 1270kW (1700shp) Turboméca Makila turboshafts, new avionics, composite rotor blades and an enlarged fuselage. For a time Aerospatiale planned to fit the Super Puma with a Fenestron shrouded tail rotor, but testing revealed no significant performance benefits. Commercial versions were designated AS 332Cs. 

The AS 332L (or SA 332L before 1980) Super Puma introduced a stretched fuselage (by 76.5cm/2.5ft), first flew on October 10 1980 and was certificated in 1983. The updated AS 332L1 with Makila 1A1 engines appeared in 1986. Bristow Helicopters ordered 31 specially customised AS 332Ls for its North Sea offshore oil rig work, and these are named Tiger. 

The AS 332L remains in production but is progressively being replaced by the AS 332L2. The L2 Super Puma Mk II (known as the Cougar in military guise) features a further fuselage stretch permitting a further row of seats, EFIS flight instrumentation, spheriflex rotor heads and longer main rotor blades with parabolic tips. It was certificated in 1992.',NULL,'Operational');

COMMIT;
