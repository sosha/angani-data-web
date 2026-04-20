<?php
require_once 'db.php';
$pdo = AnganiDB::getInstance();
$stmt = $pdo->prepare("SELECT setting_value FROM settings WHERE setting_key = 'meta_access_token'");
$stmt->execute();
$token = $stmt->fetchColumn();

$url = "https://graph.facebook.com/v20.0/ads_archive?";
$params = [
    'access_token' => $token,
    'search_terms' => 'jambojet',
    'ad_reached_countries' => '["GB"]',
    'ad_type' => 'ALL',
    'ad_active_status' => 'ALL',
    'fields' => 'id,page_name,ad_snapshot_url'
];
$ch = curl_init($url . http_build_query($params));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
echo curl_exec($ch);
