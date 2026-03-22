<?php
// Database Configuration
$host = 'localhost';
$user = 'root';
$pass = '';
$dbname = 'angani_data';

try {
    // Initial connection to create database if not exists
    $pdo_init = new PDO("mysql:host=$host", $user, $pass);
    $pdo_init->exec("CREATE DATABASE IF NOT EXISTS $dbname");
    $pdo_init = null;

    // Create a new PDO instance for the specific database
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Define table creation queries
    $queries = [
        "CREATE TABLE IF NOT EXISTS airports (
            id INT PRIMARY KEY,
            ident VARCHAR(20) UNIQUE NOT NULL,
            type VARCHAR(50),
            name VARCHAR(255),
            latitude_deg DOUBLE,
            longitude_deg DOUBLE,
            elevation_ft INT,
            continent VARCHAR(5),
            iso_country VARCHAR(5),
            iso_region VARCHAR(10),
            municipality VARCHAR(255),
            scheduled_service VARCHAR(5),
            gps_code VARCHAR(20),
            iata_code VARCHAR(20),
            icao_code VARCHAR(20),
            local_code VARCHAR(20),
            home_link TEXT,
            wikipedia_link TEXT,
            keywords TEXT,
            last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )",
        "CREATE TABLE IF NOT EXISTS airlines (
            airline_id INT PRIMARY KEY,
            name VARCHAR(255),
            alias VARCHAR(50),
            iata VARCHAR(5),
            icao VARCHAR(10),
            callsign VARCHAR(100),
            country VARCHAR(100),
            active VARCHAR(5),
            last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )",
        "CREATE TABLE IF NOT EXISTS aircraft (
            id INT AUTO_INCREMENT PRIMARY KEY,
            model_name VARCHAR(255),
            iata_code VARCHAR(20),
            icao_code VARCHAR(20),
            type VARCHAR(100),
            engine_type VARCHAR(100),
            engine_count INT,
            max_pax INT,
            last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )",
        "CREATE TABLE IF NOT EXISTS navaids (
            id INT PRIMARY KEY,
            filename VARCHAR(255),
            ident VARCHAR(20),
            name VARCHAR(255),
            type VARCHAR(50),
            frequency_khz DOUBLE,
            latitude_deg DOUBLE,
            longitude_deg DOUBLE,
            elevation_ft INT,
            iso_country VARCHAR(5),
            dme_frequency_khz DOUBLE,
            dme_channel VARCHAR(10),
            dme_latitude_deg DOUBLE,
            dme_longitude_deg DOUBLE,
            dme_elevation_ft INT,
            slaved_variation_deg DOUBLE,
            magnetic_variation_deg DOUBLE,
            usageType VARCHAR(50),
            power VARCHAR(50),
            associated_airport VARCHAR(20),
            last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )",
        "CREATE TABLE IF NOT EXISTS frequencies (
            id INT PRIMARY KEY,
            airport_ref INT,
            airport_ident VARCHAR(20),
            type VARCHAR(50),
            description VARCHAR(255),
            frequency_mhz DOUBLE,
            last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )"
    ];

    foreach ($queries as $query) {
        $pdo->exec($query);
    }

} catch (PDOException $e) {
    die("Database Connection Error: " . $e->getMessage());
}
?>
