<?php
require_once 'db.php';

require_once 'logger.php';

header('Content-Type: application/json');

$pdo = AnganiDB::getInstance();
$stmt = $pdo->prepare("SELECT setting_value FROM settings WHERE setting_key = 'rapidapi_key'");
$stmt->execute();
$apiKey = $stmt->fetchColumn();

if (!$apiKey) {
    echo json_encode(['success' => false, 'message' => 'No API key found in settings.']);
    exit;
}

// Test with a generic registration (N172SJ - a common Cessna 172)
$tail = 'N172SJ';
$url = "https://aerodatabox.p.rapidapi.com/aircrafts/reg/$tail";

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 10);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    "X-RapidAPI-Key: $apiKey",
    "X-RapidAPI-Host: aerodatabox.p.rapidapi.com"
]);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

$logData = [
    'url' => $url,
    'http_code' => $httpCode,
    'curl_error' => $error,
    'response' => $response ? json_decode($response, true) : null
];

if ($httpCode === 200) {
    logAction($pdo, 'API_TEST', 'settings', 0, null, ['status' => 'SUCCESS', 'details' => $logData]);
    echo json_encode(['success' => true, 'message' => 'Connection successful! API is active.']);
} else {
    logAction($pdo, 'API_TEST', 'settings', 0, null, ['status' => 'FAILURE', 'details' => $logData]);
    $msg = "API Error (HTTP $httpCode). " . ($error ?: ($response ?: 'Check Logs for details.'));
    echo json_encode(['success' => false, 'message' => $msg]);
}
