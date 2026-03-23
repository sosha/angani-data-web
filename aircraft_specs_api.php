<?php
require_once 'db.php';

$icao = isset($_GET['icao']) ? $_GET['icao'] : '';
$tail = isset($_GET['tail']) ? $_GET['tail'] : '';

header('Content-Type: application/json');

// Get API Key from DB
$stmt = $pdo->prepare("SELECT setting_value FROM settings WHERE setting_key = 'rapidapi_key'");
$stmt->execute();
$apiKey = $stmt->fetchColumn();

if (!$apiKey) {
    // Return sample data for demo if no key is set
    echo json_encode([
        'demo' => true,
        'message' => 'Set a RapidAPI key in Administration to see real technical specs.',
        'data' => [
            'model' => 'Boeing 737-800',
            'max_pax' => 189,
            'range_km' => 5435,
            'cruise_speed_kmh' => 842,
            'engine_type' => 'Jet',
            'engine_count' => 2
        ]
    ]);
    exit;
}

// AeroDataBox Aircraft by Registration URL
// https://rapidapi.com/aero-data-box/api/aerodatabox/
$url = "https://aerodatabox.p.rapidapi.com/aircrafts/registration/$tail";

if (!$tail && $icao) {
    // You could also search by ICAO hex if supported by the API
}

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    "X-RapidAPI-Key: $apiKey",
    "X-RapidAPI-Host: aerodatabox.p.rapidapi.com"
]);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($httpCode === 200) {
    echo $response;
} else {
    echo json_encode(['error' => 'API Error or Rate Limit', 'code' => $httpCode]);
}
