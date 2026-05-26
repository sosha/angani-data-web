SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION;

INSERT INTO `airports` (`id`, `country_code`, `iata_code`, `icao_code`, `airport_name`, `city_name`, `latitude`, `longitude`, `elevation_ft`, `slot_coordination_level`, `status`, `last_updated`) VALUES
(1, 'GB', 'LHR', 'EGLL', 'Heathrow Airport Limited', '', 51.470748, -0.459909, 83, '', 'active', '2024-01'),
(2, 'GB', 'LGW', 'EGKK', 'Gatwick Airport Limited', '', 51.148744, -0.185739, 202, '', 'active', '2024-01'),
(3, 'GB', 'STN', 'EGSS', 'Manchester Airport Plc', '', 51.884998, 0.235, 348, '', 'active', '2024-01'),
(4, 'GB', 'LTN', 'EGGW', 'London Luton Airport Operations Ltd', '', 51.874699, -0.368333, 526, '', 'active', '2024-01'),
(5, 'GB', 'MAN', 'EGCC', 'Manchester Airport Plc', '', 53.349375, -2.279521, 257, '', 'active', '2024-01'),
(6, 'GB', 'LCY', 'EGLC', 'London City Airport Ltd', '', 51.505299, 0.055278, 19, '', 'active', '2024-01'),
(7, 'GB', 'BHX', 'EGBB', 'Birmingham Airport Ltd', '', 52.453899, -1.74803, 327, '', 'active', '2024-01'),
(8, 'GB', 'BRS', 'EGGD', 'Bristol Airport Ltd', '', 51.382326, -2.716453, 622, '', 'active', '2024-01'),
(9, 'GB', 'LPL', 'EGGP', 'Liverpool John Lennon Airport Ltd', '', 53.334863, -2.849637, 80, '', 'active', '2024-01'),
(10, 'GB', 'EDI', 'EGPH', 'Edinburgh Airport Ltd', '', 55.950145, -3.372288, 135, '', 'active', '2024-01'),
(11, 'GB', 'GLA', 'EGPF', 'AGS Airports Ltd', '', 55.871899, -4.43306, 26, '', 'active', '2024-01'),
(12, 'GB', 'CWL', 'EGFF', 'Cardiff International Airport Ltd', '', 51.396702, -3.34333, 220, '', 'active', '2024-01'),
(13, 'GB', 'BFS', 'EGAA', 'Belfast International Airport Ltd', '', 54.657501, -6.21583, 268, '', 'active', '2024-01'),
(14, 'GB', 'BHD', 'EGAC', 'George Best Belfast City Airport Ltd', '', 54.618099, -5.8725, 15, '', 'active', '2024-01'),
(15, 'GB', 'LBA', 'EGNM', 'Leeds Bradford Airport Ltd', '', 53.865898, -1.66057, 681, '', 'active', '2024-01'),
(16, 'GB', 'NCL', 'EGNT', 'Newcastle International Airport Ltd', '', 55.037958, -1.689577, 266, '', 'active', '2024-01'),
(17, 'GB', 'EMA', 'EGNX', 'East Midlands Airport Ltd', '', 52.8311, -1.32806, 306, '', 'active', '2024-01'),
(18, 'GB', 'EXT', 'EGTE', 'Exeter Airport Ltd', '', 50.734261, -3.413984, 102, '', 'active', '2024-01'),
(19, 'GB', 'SOU', 'EGHI', 'Southampton Airport Ltd', '', 50.950298, -1.3568, 44, '', 'active', '2024-01'),
(20, 'GB', 'NWI', 'EGSH', 'Norwich Airport Ltd', '', 52.6758, 1.28278, 117, '', 'active', '2024-01'),
(21, 'GB', 'SEN', 'EGMC', 'London Southend Airport', '', 51.570562, 0.693627, 49, '', 'active', '2024-01'),
(22, 'GB', 'ABZ', 'EGPD', 'AGS Airports Ltd', '', 57.2019, -2.19778, 215, '', 'active', '2024-01'),
(23, 'GB', 'INV', 'EGPE', 'Highlands and Islands Airports Ltd', '', 57.5425, -4.0475, 31, '', 'active', '2024-01'),
(24, 'GB', '', 'EGFJ', 'RAF Coningsby', '', 53.092999, -0.166014, 25, '', 'active', '2024-01'),
(25, 'GB', 'FAB', 'EGLF', 'Farnborough Airport', '', 51.275799, -0.776333, 238, '', 'active', '2024-01'),
(26, 'GB', 'BQH', 'EGKB', 'Biggin Hill Airport Ltd', '', 51.330799, 0.0325, 598, '', 'active', '2024-01'),
(27, 'GB', 'ESH', 'EGKA', 'Brighton City Airport Ltd', '', 50.835602, -0.297222, 7, '', 'active', '2024-01'),
(28, 'GB', 'CAX', 'EGNC', 'Carlisle Lake District Airport Ltd', '', 54.9375, -2.80917, 190, '', 'active', '2024-01'),
(29, 'GB', 'BLK', 'EGNH', 'Blackpool Airport Ltd', '', 53.771702, -3.02861, 34, '', 'active', '2024-01'),
(30, 'GB', 'HUY', 'EGNJ', 'Humberside Airport', '', 53.576152, -0.34954, 121, '', 'active', '2024-01'),
(31, 'GB', 'CEG', 'EGNR', 'Hawarden Airport (Chester Airport)', '', 53.178101, -2.97778, 45, '', 'active', '2024-01'),
(32, 'GB', 'MME', 'EGNV', 'Tees Valley Airport Ltd', '', 54.509201, -1.42941, 120, '', 'active', '2024-01'),
(33, 'GB', 'VLY', 'EGOV', 'Anglesey Airport Ltd', '', 53.2481, -4.53534, 37, '', 'active', '2024-01'),
(34, 'GB', 'KOI', 'EGPA', 'Highlands and Islands Airports Ltd', '', 58.957903, -2.905077, 50, '', 'active', '2024-01'),
(35, 'GB', 'LSI', 'EGPB', 'Highlands and Islands Airports Ltd', '', 59.878899, -1.29556, 20, '', 'active', '2024-01'),
(36, 'GB', 'PIK', 'EGPK', 'Glasgow Prestwick International Airport Ltd', '', 55.501499, -4.577182, 65, '', 'active', '2024-01'),
(37, 'GB', 'SYY', 'EGPO', 'Highlands and Islands Airports Ltd', '', 58.215599, -6.33111, 26, '', 'active', '2024-01'),
(38, 'GB', 'BRR', 'EGPR', 'Highlands and Islands Airports Ltd', '', 57.0228, -7.44306, 5, '', 'active', '2024-01'),
(39, 'GB', '', 'EGTC', 'Cranfield Airport', '', 52.072201, -0.616667, 360, '', 'active', '2024-01'),
(40, 'GB', 'OXF', 'EGTK', 'Oxford Airport Holdings Ltd', '', 51.836899, -1.32, 270, '', 'active', '2024-01');

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
