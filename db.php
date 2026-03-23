<?php
// Database Configuration
if (!defined('DB_TYPE')) {
    define('DB_TYPE', 'sqlite'); // Set to 'mysql' or 'sqlite'
}

class AnganiDB {
    private static $pdo = null;

    public static function getInstance() {
        if (self::$pdo !== null) return self::$pdo;

        $host = 'localhost';
        $user = 'root';
        $pass = '';
        $dbname = 'angani_data';
        $sqlite_file = 'angani_data.db';

        try {
            if (DB_TYPE === 'mysql') {
                $pdo_init = new PDO("mysql:host=$host", $user, $pass);
                $pdo_init->exec("CREATE DATABASE IF NOT EXISTS $dbname");
                $pdo_init = null;
                self::$pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
            } else {
                self::$pdo = new PDO("sqlite:" . __DIR__ . "/" . $sqlite_file);
            }
            self::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return self::$pdo;
        } catch (PDOException $e) {
            die("Database Connection Error: " . $e->getMessage());
        }
    }
}

// Global variable for backward compatibility
$pdo = AnganiDB::getInstance();
$GLOBALS['pdo'] = $pdo;

$is_mysql = (DB_TYPE === 'mysql');
$pk_int = $is_mysql ? "INT PRIMARY KEY" : "INTEGER PRIMARY KEY";
$pk_ai = $is_mysql ? "INT AUTO_INCREMENT PRIMARY KEY" : "INTEGER PRIMARY KEY AUTOINCREMENT";
$ts_default = $is_mysql ? "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" : "DATETIME DEFAULT CURRENT_TIMESTAMP";

// Only run table creation once per request to save resources
if (!defined('TABLES_INITIALIZED')) {
    $db = AnganiDB::getInstance();
    // Define table creation queries
    $queries = [
        "CREATE TABLE IF NOT EXISTS airports (id $pk_int, ident TEXT UNIQUE NOT NULL, type TEXT, name TEXT, latitude_deg REAL, longitude_deg REAL, elevation_ft INT, continent TEXT, iso_country TEXT, iso_region TEXT, municipality TEXT, scheduled_service TEXT, gps_code TEXT, iata_code TEXT, icao_code TEXT, local_code TEXT, home_link TEXT, wikipedia_link TEXT, keywords TEXT, last_updated $ts_default)",
        "CREATE TABLE IF NOT EXISTS airlines (airline_id $pk_int, name TEXT, alias TEXT, iata TEXT, icao TEXT, callsign TEXT, country TEXT, active TEXT, last_updated $ts_default)",
        "CREATE TABLE IF NOT EXISTS aircraft (id $pk_ai, model_name TEXT, iata_code TEXT, icao_code TEXT, type TEXT, engine_type TEXT, engine_count INT, max_pax INT, last_updated $ts_default)",
        "CREATE TABLE IF NOT EXISTS navaids (id $pk_int, filename TEXT, ident TEXT, name TEXT, type TEXT, frequency_khz REAL, latitude_deg REAL, longitude_deg REAL, elevation_ft INT, iso_country TEXT, dme_frequency_khz REAL, dme_channel TEXT, dme_latitude_deg REAL, dme_longitude_deg REAL, dme_elevation_ft INT, slaved_variation_deg REAL, magnetic_variation_deg REAL, usageType TEXT, power TEXT, associated_airport TEXT, last_updated $ts_default)",
        "CREATE TABLE IF NOT EXISTS frequencies (id $pk_int, airport_ref INT, airport_ident TEXT, type TEXT, description TEXT, frequency_mhz REAL, last_updated $ts_default)",
        "CREATE TABLE IF NOT EXISTS audit_logs (id $pk_ai, action_type TEXT, table_name TEXT, record_id INT, old_data TEXT, new_data TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP )",
        "CREATE TABLE IF NOT EXISTS settings (setting_key TEXT PRIMARY KEY, setting_value TEXT)",
        "CREATE TABLE IF NOT EXISTS notam_sources (
            id $pk_ai,
            iso_country TEXT UNIQUE,
            country_name TEXT,
            official_source_name TEXT,
            notam_portal_url TEXT,
            icao_nof_code TEXT,
            notes TEXT,
            last_updated $ts_default
        )",
        "CREATE TABLE IF NOT EXISTS license_categories (id $pk_ai, name TEXT UNIQUE)",
        "CREATE TABLE IF NOT EXISTS licenses (
            id $pk_ai,
            category_id INT,
            iso_country TEXT,
            name TEXT,
            validity TEXT,
            cost TEXT,
            requirements TEXT,
            description TEXT,
            last_updated $ts_default
        )"
    ];

    foreach ($queries as $query) {
        $db->exec($query);
    }
    define('TABLES_INITIALIZED', true);
}
?>
