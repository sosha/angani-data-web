<?php
session_start();
require __DIR__ . '/includes/db.php';
require __DIR__ . '/includes/functions.php';

try { handle_post_actions(); } catch (Throwable $e) { flash('error', $e->getMessage()); }
if (getv('page') === 'logout') { if(!hash_equals(csrf_token(),getv('csrf'))) { flash('error','Invalid logout link.'); redirect_to('?page=home'); } logout_user(); redirect_to('?page=home'); }
if (getv('page') === 'export') { export_module_csv(getv('module')); }
if (getv('page') === 'export_all') { export_database_zip(); }

$page = getv('page','home');
$moduleFromPage = module_key_from_page($page);
if ($moduleFromPage) { $_GET['module'] = $moduleFromPage; $page='module'; }
$valid = ['home','search','catalogue','module','detail','pricing','login','register','dashboard','answer','account','admin','contact'];
if (!in_array($page,$valid,true)) $page='home';
if ($page === 'admin' && !defined('ANGANI_ADMIN_CONTEXT')) { redirect_to('admin/?' . ($_SERVER['QUERY_STRING'] ?? '')); }
if (in_array($page, ['dashboard','answer','account'], true) && !is_logged_in()) { redirect_to('?page=login'); }
$user=current_user(); $dbError=null; $stats=[];
try { $stats=get_stats(); } catch(Throwable $e) { $dbError=$e->getMessage(); }
?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Angani Data — Aviation Intelligence Atlas</title><meta name="description" content="A PHP/MySQL aviation data platform for airlines, airports, aircraft, routes, infrastructure, regulatory and commercial datasets."><link rel="icon" href="assets/favicon.png" type="image/png"><link rel="stylesheet" href="css/styles.css"><script src="https://kit.fontawesome.com/c0adf715c1.js" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.7/dist/chart.umd.min.js"></script></head>
<body class="<?= $page==='admin'?'admin-shell-page':'' ?>"><div class="flight-grid" aria-hidden="true"></div>
<header class="site-header"><div class="header-bar"><a class="brand-lockup" href="?page=home"><img src="assets/angani-logo-white.png" alt="Angani" class="brand-logo"><span><strong>Angani Data</strong><small>Aviation Intelligence Atlas</small></span></a><div class="header-actions"><button class="menu-toggle" id="menuToggle" aria-expanded="false" aria-controls="mainNav"><i class="fas fa-bars"></i> Menu</button><button class="search-toggle" id="searchToggle" aria-label="Search" aria-expanded="false"><i class="fas fa-search"></i></button></div></div><nav class="main-nav" id="mainNav"><a class="<?=active_page($page,'home')?>" href="?page=home"><i class="fas fa-home"></i>Overview</a><a href="?page=countries"><i class="fas fa-globe"></i>Countries</a><a href="?page=airlines"><i class="fas fa-plane-departure"></i>Airlines</a><a href="?page=airports"><i class="fas fa-map-location"></i>Airports</a><a href="?page=aircraft"><i class="fas fa-plane"></i>Aircraft</a><a class="<?=active_page($page,'catalogue')?>" href="?page=catalogue"><i class="fas fa-database"></i>All Datasets</a><a class="<?=active_page($page,'pricing')?>" href="?page=pricing"><i class="fas fa-credit-card"></i>Pricing</a><?php if($user): ?><a class="<?=active_page($page,'dashboard')?>" href="?page=dashboard"><i class="fas fa-chart-bar"></i>Dashboard</a><?php if(is_admin()): ?><a class="<?=active_page($page,'admin')?>" href="admin/"><i class="fas fa-shield-alt"></i>Admin</a><?php endif; ?><a href="?page=account"><?=tier_badge($user)?></a><?php else: ?><a class="<?=active_page($page,'login')?>" href="?page=login"><i class="fas fa-sign-in-alt"></i>Log in</a><?php endif; ?></nav></header><div class="search-overlay" id="searchOverlay" hidden><form class="search-overlay-form" method="get"><input type="hidden" name="page" value="search"><input class="search-overlay-input" name="q" placeholder="Search airlines, airports, aircraft types, codes..." autocomplete="off"><button class="btn ink">Search</button></form></div>
<main id="app"><?=flash_html()?>
<?php if($dbError): ?>
<section class="view"><div class="empty-state"><h2>Database connection required</h2><p><?=e($dbError)?></p><p>Import <code>database/00_create_database.sql</code>, then <code>database/01_schema.sql</code>, then run <code>php database/import_all_seeds.php</code>.</p></div></section>
<?php elseif($page==='home'): $insights=active_insight_cards(); ?>
<section class="view home-view"><div class="hero premium-hero"><div><div class="kicker">Angani Solutions · Aviation Data Product</div><h1>Static aviation intelligence arranged for decisions.</h1><p class="lead">A serious PHP/MySQL aviation data platform for countries, airlines, airports, infrastructure, aircraft types, lessors, commercial reference, IATA/IOSA, regulatory and route intelligence.</p><div class="hero-actions"><a class="btn primary" href="?page=register">Create account</a><a class="btn secondary" href="?page=catalogue">Browse databases</a><a class="btn secondary" href="?page=pricing">View access</a></div></div><aside class="hero-panel cockpit-panel"><div class="cockpit-line"><span>ACTIVE AIRLINES</span><b class="active-pill"><?=nfmt($stats['active_airlines'])?></b></div><h2>Data product, not just CSVs.</h2><p>Admin CRUD, import/export, user tiers, drill-down pages, reference codes and source/change controls are built into the platform.</p></aside></div>
<form class="global-search-panel" method="get"><input type="hidden" name="page" value="search"><label><span>Search aviation datasets</span><input name="q" placeholder="Try: Kenya Airways, Nairobi, A320, IOSA, NDB, fare rules..."></label><button class="btn ink">Search Angani Data</button></form>
<div class="stats-grid"><?=metric_card(nfmt($stats['active_airlines']),'Active airlines',nfmt($stats['airlines']).' total')?><?=metric_card(nfmt($stats['airports']),'Airport records','Infrastructure-ready')?><?=metric_card(nfmt($stats['aircraft_types']),'Aircraft types','Specs, engines, payload')?><?=metric_card(nfmt($stats['navaids']),'Navaids','Infrastructure & AIM')?></div>
<section class="section-head"><div><div class="eyebrow">Rotating homepage intelligence</div><h2>Interesting titbits that encourage signups</h2></div><p>These cards are controlled from Admin → Homepage Insights and can be rotated without editing code.</p></section><div class="insight-grid"><?php foreach($insights as $card): $rows=run_insight_query($card['query_key']); $locked=!empty($card['required_tier_id']) && !is_logged_in(); ?><article class="insight-card <?=$locked?'locked':''?>"><div class="topline"><span class="chip gold"><?=e($card['metric_label'])?></span><?php if($locked): ?><span class="chip danger">Pro preview</span><?php endif; ?></div><h3><?=e($card['title'])?></h3><p><?=e($card['description'])?></p><?=$locked?access_gate('Sign in to unlock the detail','This card previews a paid intelligence query.','See plans'):chart_bars($rows)?></article><?php endforeach; ?></div>
<section class="section-head"><div><div class="eyebrow">Product modules</div><h2>Designed around aviation workflows</h2></div><p>Each module supports search, filtering, drill-downs, admin CRUD and CSV import/export.</p></section><div class="module-grid"><?php foreach(module_groups() as $group=>$keys): ?><article class="module-group"><h3><?=e($group)?></h3><div><?php foreach($keys as $k): $c=module_config($k); if(!$c) continue; ?><a class="module-chip" href="<?=e(module_url($k))?>"><b><?=module_icon_html($k)?></b><span><?=e($c['label'])?></span><em><?=nfmt(module_count($k))?></em></a><?php endforeach; ?></div></article><?php endforeach; ?></div></section>
<?php elseif($page==='search'): $q=getv('q'); if($q==='') redirect_to('?page=home'); $results=global_search($q); ?>
<section class="view"><section class="section-head"><div><div class="eyebrow">Global search</div><h1>Search across Angani Data</h1></div><p>Search airlines, airports, aircraft types, reference tables, infrastructure, regulatory and commercial records from one place. Pro-only records show access gates when opened.</p></section><div class="result-summary"><strong><?=nfmt(count($results))?></strong> results for <b><?=e($q)?></b></div><?=render_global_search_results($results)?></section>
<?php elseif($page==='catalogue'): ?>
<section class="view"><section class="section-head"><div><div class="eyebrow">Database catalogue</div><h1>Angani Data modules</h1></div><p>Free users see public/reference data. Pro users unlock full drill-downs and exports. Enterprise is for bulk/API access.</p></section><div class="module-grid"><?php foreach(module_groups() as $group=>$keys): ?><article class="module-group"><h3><?=e($group)?></h3><div><?php foreach($keys as $k): $c=module_config($k); if(!$c) continue; ?><a class="module-chip" href="<?=e(module_url($k))?>"><b><?=module_icon_html($k)?></b><span><?=e($c['label'])?></span><em><?=nfmt(module_count($k))?></em></a><?php endforeach; ?></div></article><?php endforeach; ?></div></section>
<?php elseif($page==='module'): $key=getv('module','airlines'); $cfg=module_config($key); ?>
<section class="view"><?php if(!$cfg): ?><div class="empty-state"><h2>Unknown database</h2></div><?php elseif(!module_allowed($cfg)): ?><?=access_gate($cfg['label'].' is a Pro dataset','Create or upgrade your account to access this database.','View pricing')?><?php else: $expandable = in_array($cfg['card']??'', ['country','airline','airport','aircraft'], true); if($expandable){ [$records,$total]=query_module_records($cfg,500,0); $fo=[]; if($key==='countries') $fo=['africa'=>'Africa','asia'=>'Asia','europe'=>'Europe','north america'=>'N America','south america'=>'S America','oceania'=>'Oceania']; elseif($key==='airlines') $fo=['active'=>'Active','defunct'=>'Defunct']; elseif($key==='airports') $fo=['large_airport'=>'Large','medium_airport'=>'Medium','small_airport'=>'Small','heliport'=>'Heliport','closed'=>'Closed','seaplane_base'=>'Seaplane']; echo render_xcard_page($key,$cfg,$records,$total,$fo); } else { [$records,$total]=query_module_records($cfg,24,(page_num()-1)*24); ?><section class="section-head"><div><div class="eyebrow"><?=e($cfg['tier']==='free'?'Open database':'Pro database')?></div><h1><?=e($cfg['label'])?></h1></div><p><?=nfmt($total)?> records. Admin can add/edit/import; logged-in Pro users can export filtered data.</p></section><?=render_search_bar($key,$cfg)?><?php if(in_array($cfg['card']??'', ['airline','airport','aircraft_type','lessor','country','aircraft'], true)): ?><?=render_module_cards($key,$records)?><?php else: ?><?=render_table($records,$cfg['list'],$key)?><?php endif; ?><?=paginate($total,24)?><?php } endif; ?></section>
<?php elseif($page==='detail'): $key=getv('module'); $cfg=module_config($key); $id=getv('id'); $tabParam=getv('dtab','overview');
if(!$cfg || !$id){ echo '<section class="view"><div class="empty-state"><h2>Record not found</h2></div></section>'; }
elseif(!module_allowed($cfg)){ echo '<section class="view">'.access_gate('Pro detail locked','Upgrade to open full records in this database.','View pricing').'</section>'; }
else{ $pkCol=module_pk($key); $r=row('SELECT * FROM `'.$cfg['table'].'` WHERE `'.$pkCol.'`=?',[$id]);
if(!$r){ echo '<section class="view"><div class="empty-state"><h2>Record not found</h2></div></section>'; }
else{
echo '<section class="view"><a class="linkish" href="'.e(module_url($key)).'">← Back to '.e($cfg['label']).'</a><section class="record-hero"><div><div class="eyebrow">'.e($cfg['label']).($key==='countries' && ($r['un_region']??'') ? ' — '.e($r['un_region']) : '').'</div>';
if($key==='countries'){
    $cc=strtolower($r['iso_alpha_2']??'');
    $flagImgHtml='';
    if($r['flag']??'') {
        $flagImgHtml='<img class="flag-svg" src="'.e($r['flag']).'" alt="'.e($r['name_common'] ?? '').' flag" style="height:32px;vertical-align:middle;margin-right:10px">';
    } elseif($cc && file_exists(__DIR__.'/assets/country_flag_icons/'.$cc.'.svg')) {
        $flagImgHtml='<img class="flag-svg" src="assets/country_flag_icons/'.e($cc).'.svg" alt="'.e($r['name_common'] ?? '').' flag" style="height:32px;vertical-align:middle;margin-right:10px">';
    }
    $flagEmojiHtml=$cc?' <span class="flag" style="font-size:28px;vertical-align:middle;margin-left:8px">'.flag_emoji($cc).'</span>':'';
    echo '<h1>'.$flagImgHtml.e($r[$cfg['title']] ?? 'Record').$flagEmojiHtml.'</h1>';
    if($r['description']??'') echo '<p style="margin-top:8px;max-width:700px;line-height:1.6">'.e($r['description']).'</p>';
} elseif($key==='airlines'){
    $logoHtml='';
    if($r['logo_url']??''){
        $src=e($r['logo_url']);
        $logoHtml='<img class="hero-logo" src="'.$src.'" alt="'.e($r[$cfg['title']] ?? '').' logo">';
    }
    $statusChip='';
    if($r['active']==='Y') $statusChip='<span class="chip ok glow-green" style="vertical-align:middle;margin-left:8px">Active</span>';
    elseif($r['active']==='N') $statusChip='<span class="chip danger" style="vertical-align:middle;margin-left:8px">Defunct</span>';
    $alIcao=e($r['icao_code']??''); $alIata=e($r['iata_code']??'');
    $codeBoxes='';
    if($alIata) $codeBoxes.='<span class="iata-box">'.$alIata.'</span>';
    if($alIcao) $codeBoxes.='<span class="iata-box icao">'.$alIcao.'</span>';
    echo '<h1>'.$logoHtml.e($r[$cfg['title']] ?? 'Record').' <sub style="font-size:0.5em;font-weight:400;color:var(--ink-muted)">'.e($r[$cfg['subtitle']] ?? '').'</sub>'.$statusChip.'</h1>';
    if($codeBoxes) echo '<div style="display:flex;gap:8px;margin:10px 0 4px">'.$codeBoxes.'</div>';
    $alCc=strtolower($r['country_code']??'');
    if($alCc){
        $alFlag=$alCc?((file_exists(__DIR__.'/assets/country_flag_icons/'.$alCc.'.svg')
            ?'<img class="flag-svg small" src="assets/country_flag_icons/'.$alCc.'.svg" alt="" style="vertical-align:middle;margin-right:6px">'
            :'<span class="flag" style="font-size:18px;vertical-align:middle;margin-right:6px">'.flag_emoji($alCc).'</span>')):'';
        echo '<p style="margin-top:8px">'.$alFlag.e($r['country'] ?? $r['country_code'] ?? '').'</p>';
    }
    if($r['alias']??'') echo '<p style="margin-top:4px;max-width:700px;line-height:1.6;color:var(--ink-muted)">'.e($r['alias']).'</p>';
    $stIcao=$r['icao_code']??'';
    $stFleet=0; $stHubs=0;
    if($stIcao){
        try{$stFleet=(int)scalar('SELECT COALESCE(SUM(aircraft_count),0) FROM airline_fleet_summary WHERE icao_code=?',[$stIcao]);}catch(Throwable $e){}
        try{$stHubs=(int)scalar('SELECT COUNT(*) FROM airline_hubs WHERE icao_code=?',[$stIcao]);}catch(Throwable $e){}
    }
    $statsHtml='';
    if($stFleet) $statsHtml.='<div class="hero-stat"><span class="hero-stat-l">Fleet</span><span class="hero-stat-v">'.nfmt($stFleet).'</span></div>';
    if($stHubs) $statsHtml.='<div class="hero-stat"><span class="hero-stat-l">Hubs</span><span class="hero-stat-v">'.nfmt($stHubs).'</span></div>';
    if($r['callsign']??'') $statsHtml.='<div class="hero-stat"><span class="hero-stat-l">Callsign</span><span class="hero-stat-v">'.e($r['callsign']).'</span></div>';
    if($statsHtml) echo '<div class="hero-stats">'.$statsHtml.'</div>';
} else {
    echo '<h1>'.e($r[$cfg['title']] ?? 'Record').'</h1><p>'.e($r[$cfg['subtitle']] ?? '').'</p>';
}
echo '</div>';
if(is_admin()) echo '<a class="btn ink" href="?page=admin&tab=edit&module='.e($key).'&id='.e($id).'">Edit in Admin</a>';
echo render_report_modal($key,$id);
echo '</section>';
$dtabs=['overview'=>'Overview','fields'=>'Details'];
if($key==='airlines'){$dtabs['digital']='Digital';$dtabs['fleet']='Fleet';$dtabs['hubs']='Hubs';$dtabs['operations']='Operations';$dtabs['commercial']='Commercial';$dtabs['regulatory']='Regulatory';}
if($key==='airports'){$dtabs['frequencies']='Frequencies';$dtabs['runways']='Runways';$dtabs['terminals']='Terminals';$dtabs['hubs']='Hubs';}
if($key==='aircraft'){$dtabs['same_type']='Same Type';}
if($key==='countries'){
    $dtabs['airlines']='Airlines';
    $dtabs['airports']='Airports';
    $dtabs['regulatory']='Regulatory';
    $dtabs['registry']='Registry';
    $dtabs['navaids']='Navaids';
    $dtabs['timeseries']='Statistics';
}
if($key==='aircraft_types'){$dtabs['registry']='Registry';$dtabs['cabin']='Cabin';$dtabs['engine']='Engine';$dtabs['specs']='Specs';$dtabs['economics']='Economics';}
echo '<nav class="detail-tabs">';
foreach($dtabs as $tk=>$tl){ $active=$tabParam===$tk?' active':''; echo '<a class="tab'.$active.'" href="?page=detail&module='.e($key).'&id='.e($id).'&dtab='.e($tk).'">'.e($tl).'</a>'; }
echo '</nav><div class="detail-content">';
// Country overview: hide flag/desc/iso fields, show inline stats
if($key==='countries' && $tabParam==='overview'){
    $hideFields = ['iso_alpha_2','iso_alpha_3','description','flag'];
    $detailFields = $cfg['detail'] ?? [];
    $filteredDetail = array_values(array_filter($detailFields, fn($f) => !in_array($f, $hideFields)));
    echo render_detail_fields(array_merge($cfg, ['detail' => $filteredDetail]), $r, false);
    // Inline Air Transport Stats
    try {
        $sr = row('SELECT * FROM country_air_transport_stats WHERE iso_alpha_2=?', [$id]);
        if($sr){
            echo '<section class="panel"><h3>Air Transport Statistics</h3><div class="stats-grid">';
            if($sr['international_airports'] !== null) echo '<div class="stat-card"><strong>'.nfmt($sr['international_airports']).'</strong><span>International Airports</span></div>';
            if($sr['domestic_airports'] !== null) echo '<div class="stat-card"><strong>'.nfmt($sr['domestic_airports']).'</strong><span>Domestic Airports</span></div>';
            if($sr['airlines'] !== null) echo '<div class="stat-card"><strong>'.nfmt($sr['airlines']).'</strong><span>National Airlines</span></div>';
            if(($sr['airlines_active']??null) !== null || ($sr['airlines_defunct']??null) !== null){
                $act = (int)($sr['airlines_active']??0);
                $def = (int)($sr['airlines_defunct']??0);
                echo '<div class="stat-card"><strong>'.nfmt($act).'</strong><span>Active Airlines'.($def ? ' <sup class="muted" style="cursor:help" title="'.nfmt($def).' defunct/inactive">(*'.nfmt($def).')</sup>' : '').'</span></div>';
            }
            echo '<div class="stat-card"><strong>'.nfmt($sr['airlines_with_international']??0).'</strong><span>With International Services</span></div>';
            echo '</div><p class="muted">Last updated: '.e($sr['updated_at'] ?? '—').'</p></section>';
        }
    } catch(Throwable $e){}
}
// Default overview/fields for non-countries, with airline-specific filtering
if($tabParam==='overview' && $key==='airlines'){
    $alIcao=$r['icao_code']??''; $alIata=$r['iata_code']??''; $alName=$r['name']??'';
    $rFleet=0; $rHubs=0; $rFleetList=0; $rDigital=0;
    if($alIcao){
        try{$rFleet=(int)scalar('SELECT COALESCE(SUM(aircraft_count),0) FROM airline_fleet_summary WHERE icao_code=?',[$alIcao]);}catch(Throwable $e){}
        try{$rHubs=(int)scalar('SELECT COUNT(*) FROM airline_hubs WHERE icao_code=?',[$alIcao]);}catch(Throwable $e){}
        try{$rFleetList=(int)scalar('SELECT COUNT(*) FROM airline_fleet_list WHERE operator_airline=? OR operator_airline LIKE ?',[$alName,'%'.$alName.'%']);}catch(Throwable $e){}
        try{$rDigital=(int)scalar('SELECT COUNT(*) FROM airline_digital_properties WHERE iata_code=? OR icao_code=?',[$alIata?:'',$alIcao]);}catch(Throwable $e){}
    }
    $rIata='—'; $rIosa='—';
    try{$ri=row('SELECT membership_status FROM airline_iata_membership WHERE iata_code=? OR icao_code=? LIMIT 1',[$alIata?:'',$alIcao]); if($ri) $rIata=e($ri['membership_status']);}catch(Throwable $e){}
    try{$ri2=row('SELECT iosa_status FROM airline_iosa_registration WHERE iata_code=? OR icao_code=? LIMIT 1',[$alIata?:'',$alIcao]); if($ri2) $rIosa=e($ri2['iosa_status']);}catch(Throwable $e){}
    echo '<div class="detail-sections">';
    echo '<div class="xcard-sec"><div class="xcard-sec-title">IDENTITY</div>';
    echo '<div class="xcard-row"><span class="xcard-row-k">Name</span><span class="xcard-row-v">'.e($r['name']??'').'</span></div>';
    if($r['alias']??'') echo '<div class="xcard-row"><span class="xcard-row-k">Alias</span><span class="xcard-row-v">'.e($r['alias']).'</span></div>';
    echo '<div class="xcard-row"><span class="xcard-row-k">IATA</span><span class="xcard-row-v">'.e($r['iata_code']??'—').'</span></div>';
    echo '<div class="xcard-row"><span class="xcard-row-k">ICAO</span><span class="xcard-row-v">'.e($r['icao_code']??'—').'</span></div>';
    if($r['callsign']??'') echo '<div class="xcard-row"><span class="xcard-row-k">Callsign</span><span class="xcard-row-v">'.e($r['callsign']).'</span></div>';
    echo '</div>';
    echo '<div class="xcard-sec"><div class="xcard-sec-title">LOCATION</div>';
    echo '<div class="xcard-row"><span class="xcard-row-k">Country</span><span class="xcard-row-v">'.e($r['country']??$r['country_code']??'—').'</span></div>';
    if($r['country_code']??'') echo '<div class="xcard-row"><span class="xcard-row-k">Code</span><span class="xcard-row-v">'.e(strtoupper($r['country_code'])).'</span></div>';
    echo '</div>';
    echo '<div class="xcard-sec"><div class="xcard-sec-title">OPERATIONS</div>';
    echo '<div class="xcard-row"><span class="xcard-row-k">Status</span><span class="xcard-row-v">'.status_chip($r['active']==='Y'?'active':($r['active']==='N'?'defunct':$r['active']??'')).'</span></div>';
    if($rFleet) echo '<div class="xcard-row"><span class="xcard-row-k">Fleet</span><span class="xcard-row-v">'.nfmt($rFleet).' aircraft</span></div>';
    if($rHubs) echo '<div class="xcard-row"><span class="xcard-row-k">Hubs</span><span class="xcard-row-v">'.nfmt($rHubs).' bases</span></div>';
    if($rFleetList) echo '<div class="xcard-row"><span class="xcard-row-k">Registry</span><span class="xcard-row-v">'.nfmt($rFleetList).' tail records</span></div>';
    echo '</div>';
    echo '<div class="xcard-sec"><div class="xcard-sec-title">MEMBERSHIPS</div>';
    echo '<div class="xcard-row"><span class="xcard-row-k">IATA</span><span class="xcard-row-v">'.$rIata.'</span></div>';
    echo '<div class="xcard-row"><span class="xcard-row-k">IOSA</span><span class="xcard-row-v">'.$rIosa.'</span></div>';
    echo '</div>';
    echo '</div>';
    $hideFields = ['active','updated_at','country_code','logo_url','icao_code','alias','name','iata_code','callsign','country'];
    $detailFields = $cfg['detail'] ?? [];
    $filteredDetail = array_values(array_filter($detailFields, fn($f) => !in_array($f, $hideFields)));
    if($filteredDetail) echo '<div style="margin-top:12px">'.render_detail_fields(array_merge($cfg, ['detail' => $filteredDetail]), $r, false).'</div>';
} elseif($tabParam==='overview' || $tabParam==='fields'){
    if($key!=='countries') echo render_detail_fields($cfg,$r,false);
}
$related=render_related_sections($key,$r);
$relatedSections=explode('<section class="related">',$related);
$sectionMap=[]; foreach($relatedSections as $sec){ if(!trim($sec)) continue; if(preg_match('/<h3>(.+?)<\/h3>/',$sec,$m)){ $secKey=strtolower(preg_replace('/[^a-z0-9]/','',$m[1])); $sectionMap[$secKey]='<section class="related">'.$sec; } }
$tabSections=[
    'airlines'=>['digital'=>'Digital properties','fleet'=>'Fleet list','fleet'=>'Fleet summary','hubs'=>'Hubs and bases','operations'=>'Operational stats','commercial'=>'Frequent flyer','regulatory'=>'IATA membership','regulatory'=>'IOSA registration','regulatory'=>'Regulatory'],
    'airports'=>['frequencies'=>'Frequencies','runways'=>'Runways','terminals'=>'Terminals','hubs'=>'Hub/base airlines'],
    'countries'=>['airlines'=>'Airlines in country','airports'=>'Airports in country','regulatory'=>'Regulatory authorities','registry'=>'Aircraft registry','navaids'=>'Navaids'],
    'aircraft_types'=>['cabin'=>'Cabin & payload','engine'=>'Engine data','specs'=>'Technical specs','economics'=>'Economics']
];
$shown=[]; $mappings=$tabSections[$key]??[];
foreach($mappings as $tk=>$searchTitle){
    if($tabParam!==$tk) continue;
    foreach($sectionMap as $sk=>$sectionHtml){
        if(str_contains(strip_tags($sectionHtml),$searchTitle) && !isset($shown[$sk])){ echo $sectionHtml; $shown[$sk]=true; }
    }
}
if($tabParam==='overview'){
    foreach($sectionMap as $sk=>$sectionHtml){
        if(!isset($shown[$sk])){ $matched=false; foreach(($mappings) as $st){ if(str_contains(strip_tags($sectionHtml),$st)){ $matched=true; break; } } if(!$matched) echo $sectionHtml; }
    }
}
// Country-specific tabs: stats and time series
if($key==='countries'){
    if($tabParam==='stats'){
        $statsRow = null;
        try { $statsRow = row('SELECT cs.*, COALESCE(c.description, c.name_common) country_desc FROM country_air_transport_stats cs LEFT JOIN countries c ON c.iso_alpha_2=cs.iso_alpha_2 WHERE cs.iso_alpha_2=?', [$id]); } catch(Throwable $e){}
        if($statsRow){
            echo '<section class="panel"><h3>Air Transport Statistics</h3><div class="stats-grid">';
            if($statsRow['international_airports'] !== null) echo '<div class="stat-card"><strong>'.nfmt($statsRow['international_airports']).'</strong><span>International Airports</span></div>';
            if($statsRow['domestic_airports'] !== null) echo '<div class="stat-card"><strong>'.nfmt($statsRow['domestic_airports']).'</strong><span>Domestic Airports</span></div>';
            if($statsRow['airlines'] !== null) echo '<div class="stat-card"><strong>'.nfmt($statsRow['airlines']).'</strong><span>National Airlines</span></div>';
            if(($statsRow['airlines_active']??null) !== null || ($statsRow['airlines_defunct']??null) !== null){
                $act = (int)($statsRow['airlines_active']??0);
                $def = (int)($statsRow['airlines_defunct']??0);
                echo '<div class="stat-card"><strong>'.nfmt($act).'</strong><span>Active Airlines'.($def ? ' <sup class="muted" style="cursor:help" title="'.nfmt($def).' defunct/inactive">(*'.nfmt($def).')</sup>' : '').'</span></div>';
            }
            if($statsRow['airlines_with_international'] !== null) echo '<div class="stat-card"><strong>'.nfmt($statsRow['airlines_with_international']).'</strong><span>Airlines with International Services</span></div>';
            if($statsRow['foreign_airline_operations'] !== null) echo '<div class="stat-card"><strong>'.nfmt($statsRow['foreign_airline_operations']).'</strong><span>Foreign Airline Operations</span></div>';
            echo '</div><p class="muted">Last updated: '.e($statsRow['updated_at'] ?? '—').'</p></section>';
        } else {
            echo '<p class="muted">Air transport statistics not yet computed for this country. Run Reports in Admin to generate.</p>';
        }
    }
    if($tabParam==='timeseries'){
        $tsRows = [];
        try { $tsRows = rows('SELECT * FROM country_time_series WHERE iso_alpha_2=? ORDER BY year ASC', [$id]); } catch(Throwable $e){}
        if($tsRows){
            $labels = []; $gdp = []; $pop = []; $pax = []; $cargo = [];
            foreach($tsRows as $ts){
                $labels[] = $ts['year'];
                $gdp[] = $ts['gdp_usd'] ? round($ts['gdp_usd']/1e9, 1) : null;
                $pop[] = $ts['population'] ? round($ts['population']/1e6, 1) : null;
                $pax[] = $ts['international_traffic_passengers'] ? round($ts['international_traffic_passengers']/1e6, 1) : null;
                $cargo[] = $ts['international_cargo_tonnes'] ? round($ts['international_cargo_tonnes']/1e3, 1) : null;
            }
            $chartId = 'chart_'.$id;
            echo '<section class="panel"><h3>Economic &amp; Traffic Trends</h3><div style="position:relative;height:350px"><canvas id="'.$chartId.'"></canvas></div></section>';
            echo '<script>document.addEventListener("DOMContentLoaded",function(){new Chart(document.getElementById("'.$chartId.'"),{type:"bar",data:{labels:'.json_encode($labels).',datasets:[{label:"GDP (US$ bn)",data:'.json_encode($gdp).',backgroundColor:"rgba(38,197,107,0.7)",borderColor:"#26c56b",borderWidth:1,order:2,yAxisID:"y"},{label:"Population (millions)",data:'.json_encode($pop).',type:"line",borderColor:"#c79b45",backgroundColor:"rgba(199,155,69,0.1)",borderWidth:2,pointRadius:3,fill:false,order:1,yAxisID:"y1"},{label:"Intl Passengers (millions)",data:'.json_encode($pax).',backgroundColor:"rgba(66,133,244,0.6)",borderColor:"#4285f4",borderWidth:1,order:3,yAxisID:"y"},{label:"Intl Cargo (thousand tonnes)",data:'.json_encode($cargo).',backgroundColor:"rgba(219,68,55,0.5)",borderColor:"#db4437",borderWidth:1,order:4,yAxisID:"y"}]},options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{position:"bottom",labels:{boxWidth:12,font:{size:11}}}},scales:{y:{beginAtZero:true,position:"left",title:{display:true,text:"Value"}},y1:{beginAtZero:true,position:"right",grid:{drawOnChartArea:false},title:{display:true,text:"Population (millions)"}}}}}});});</script>';
            // Also show data table below chart
            echo '<div class="table-wrap" style="margin-top:16px"><table><thead><tr><th>Year</th><th>GDP (US$)</th><th>Population</th><th>Intl Passengers</th><th>Intl Cargo (tonnes)</th></tr></thead><tbody>';
            foreach(array_reverse($tsRows) as $ts){
                echo '<tr><td>'.e($ts['year']).'</td><td>'.($ts['gdp_usd'] ? 'US$ '.nfmt(round($ts['gdp_usd'])) : '—').'</td><td>'.($ts['population'] ? nfmt($ts['population']) : '—').'</td><td>'.($ts['international_traffic_passengers'] ? nfmt($ts['international_traffic_passengers']).' pax' : '—').'</td><td>'.($ts['international_cargo_tonnes'] ? nfmt($ts['international_cargo_tonnes']).' t' : '—').'</td></tr>';
            }
            echo '</tbody></table></div>';
        } else {
            echo '<p class="muted">No statistics data available for this country yet.</p>';
        }
    }
}
// Aircraft type registry tab
if($key==='aircraft_types' && $tabParam==='registry'){
    $icao=$r['icao_code']??''; $iata=$r['iata_code']??'';
    $regRows=[];
    if($icao || $iata){
        try{
            $regSql='SELECT * FROM aircraft_registrations WHERE ';
            $regParts=[]; $regParams=[];
            if($icao){ $regParts[]='icao_code=?'; $regParams[]=$icao; }
            if($iata){ $regParts[]='type_code=?'; $regParams[]=$iata; }
            $regRows=rows($regSql.implode(' OR ',$regParts).' LIMIT 100',$regParams);
        }catch(Throwable $e){}
    }
    if($regRows){
        echo '<section class="panel"><h3>Aircraft in Registry ('.count($regRows).')</h3><div class="table-wrap"><table><thead><tr><th>Registration</th><th>Operator</th><th>Country</th><th>Age</th><th>Status</th></tr></thead><tbody>';
        foreach($regRows as $ar){
            echo '<tr><td>'.e($ar['registration']??'').'</td><td>'.e($ar['operator_name']??'').'</td><td>'.e($ar['country_code']??'').'</td><td>'.e($ar['age']??'—').'</td><td>'.e($ar['record_status']??'').'</td></tr>';
        }
        echo '</tbody></table></div></section>';
    } else {
        echo '<p class="muted">No aircraft found in registry for this type.</p>';
    }
}
// Aircraft same type tab
if($key==='aircraft' && $tabParam==='same_type'){
    $aircraftType=$r['aircraft_type']??''; $typeCode=$r['type_code']??''; $icao=$r['icao_code']??'';
    $sameRows=[];
    if($aircraftType || $typeCode || $icao){
        try{
            $sameSql='SELECT * FROM aircraft_registrations WHERE ';
            $sameParts=[]; $sameParams=[];
            if($aircraftType){ $sameParts[]='aircraft_type=?'; $sameParams[]=$aircraftType; }
            if($typeCode){ $sameParts[]='type_code=?'; $sameParams[]=$typeCode; }
            if($icao){ $sameParts[]='icao_code=?'; $sameParams[]=$icao; }
            $sameRows=rows($sameSql.implode(' OR ',$sameParts).' ORDER BY registration LIMIT 100',$sameParams);
        }catch(Throwable $e){}
    }
    if($sameRows){
        echo '<section class="panel"><h3>Aircraft in Our Registry — '.e($aircraftType ?: $typeCode).' ('.count($sameRows).')</h3><div class="table-wrap"><table><thead><tr><th>Registration</th><th>Operator</th><th>Country</th><th>Age</th><th>Status</th></tr></thead><tbody>';
        foreach($sameRows as $ar){
            echo '<tr><td>'.e($ar['registration']??'').'</td><td>'.e($ar['operator_name']??'').'</td><td>'.e($ar['country_code']??'').'</td><td>'.e($ar['age']??'—').'</td><td>'.e($ar['record_status']??'').'</td></tr>';
        }
        echo '</tbody></table></div></section>';
    } else {
        echo '<p class="muted">No other aircraft of this type found in registry.</p>';
    }
}
echo '</div></section>';
}} // close if(!$r), close else branch of detail
?>
<?php elseif($page==='pricing'): $tiers=tier_cards(); ?>
<section class="view"><section class="section-head"><div><div class="eyebrow">Simple access model</div><h1>Three tiers only</h1></div><p>Free for discovery, Pro for paid intelligence, Enterprise for custom/API/bulk work.</p></section><div class="pricing-grid"><?php foreach($tiers as $tier): ?><article class="pricing-card <?=$tier['code']==='pro'?'featured':''?>"><div class="topline"><span class="chip gold"><?=e($tier['name'])?></span><span class="chip"><?= $tier['code']==='enterprise'?'Contact us':'$'.e($tier['monthly_usd']).'/mo' ?></span></div><h3><?=e($tier['name'])?></h3><p><?=e($tier['description'])?></p><div class="price"><?= $tier['code']==='enterprise'?'Custom':'$'.e($tier['monthly_usd']).'<small>/month</small>' ?></div><ul><?php foreach(tier_features((int)$tier['id']) as $f): ?><li><?=e($f['feature_label'])?></li><?php endforeach; ?></ul><a class="btn <?=$tier['code']==='pro'?'primary':'ghost'?>" href="<?=$tier['code']==='enterprise'?'?page=contact':'?page=register'?>"><?=$tier['code']==='enterprise'?'Contact us':'Start '.$tier['name']?></a></article><?php endforeach; ?></div></section>
<?php elseif($page==='login'): ?>
<section class="auth-shell"><div class="panel auth-card"><div class="eyebrow">Member access</div><h1>Log in</h1><p class="muted">Demo admin: <code>admin@angani.co.uk</code> / <code>Angani@2026</code></p><form method="post" class="stack-form"><?=csrf_field()?><input type="hidden" name="action" value="login"><label>Email<input name="email" type="email" required></label><label>Password<input name="password" type="password" required></label><button class="btn ink" type="submit">Log in</button></form><p>New user? <a class="linkish" href="?page=register">Create account</a></p></div></section>
<?php elseif($page==='register'): ?>
<section class="auth-shell"><div class="panel auth-card"><div class="eyebrow">Create account</div><h1>Start exploring</h1><form method="post" class="stack-form"><?=csrf_field()?><input type="hidden" name="action" value="register"><label>Name<input name="name" required></label><label>Email<input name="email" type="email" required></label><label>Password<input name="password" type="password" minlength="8" required></label><button class="btn ink" type="submit">Create account</button></form></div></section>
<?php elseif($page==='account'): if(!$user) redirect_to('?page=login'); ?>
<section class="view"><section class="section-head"><div><div class="eyebrow">Account</div><h1><?=e($user['name'])?></h1></div><?=tier_badge($user)?></section><div class="panel-grid"><div class="panel"><h3>Profile</h3><form method="post" class="stack-form"><?=csrf_field()?><input type="hidden" name="action" value="update_account"><label>Name<input name="name" value="<?=e($user['name'])?>"></label><label>Email<input value="<?=e($user['email'])?>" disabled></label><button class="btn ink">Save</button></form></div><div class="panel"><h3>Access</h3><p>Your current tier is <strong><?=e($user['tier_name'])?></strong>.</p><p>CSV exports and full drilldowns are available on Pro and Enterprise.</p><a class="btn primary" href="?page=pricing">Compare plans</a></div></div></section>
<?php elseif($page==='dashboard'): if(!$user) redirect_to('?page=login'); $presets=question_presets(); $dashInsights=active_insight_cards(); ?>
<section class="view"><section class="dashboard-hero panel dark"><div><div class="eyebrow">Member cockpit</div><h1>Welcome, <?=e($user['name'])?></h1><p>Use preset questions, global search and database drill-downs to turn the aviation datasets into answers.</p></div><div class="stats-grid compact"><?=metric_card(nfmt($stats['airlines']),'Airlines',nfmt($stats['active_airlines']).' active')?><?=metric_card(nfmt($stats['airports']),'Airports','global coverage')?><?=metric_card(nfmt($stats['aircraft_types']),'Aircraft types','technical intelligence')?><?=metric_card(nfmt($stats['dataset_files']),'Dataset files','source warehouse')?></div></section><form class="global-search-panel standalone" method="get"><input type="hidden" name="page" value="search"><label><span>Search your aviation data</span><input name="q" placeholder="Search across airlines, airports, aircraft types, routes, standards..."></label><button class="btn ink">Search</button><a class="btn ghost" href="?page=catalogue">Browse catalogue</a></form><section class="section-head"><div><div class="eyebrow">Preset intelligence questions</div><h1>Ask the dataset</h1></div><p>These are controlled from Admin → Preset Questions and are designed to guide logged-in users toward useful answers.</p></section><div class="question-grid"><?php foreach($presets as $q): $locked=!empty($q['required_tier_order']) && tier_order_for()< (int)$q['required_tier_order'] && !is_admin(); ?><article class="question-card"><span class="chip"><?=e($q['category'])?></span><h3><?=e($q['title'])?></h3><p><?=e($q['question_text'])?></p><?php if($locked): ?><a class="btn ghost" href="?page=pricing">Upgrade to <?=e($q['required_tier_name'])?></a><?php else: ?><a class="btn primary" href="?page=answer&q=<?=e($q['answer_key'])?>">Run question</a><?php endif; ?></article><?php endforeach; ?></div><section class="section-head"><div><div class="eyebrow">Live titbits</div><h2>Charts from current data</h2></div><p>The same insight engine powers public teasers and logged-in analysis cards.</p></section><div class="insight-grid"><?php foreach(array_slice($dashInsights,0,6) as $card): $rows=run_insight_query($card['query_key']); ?><article class="insight-card"><div class="topline"><span class="chip gold"><?=e($card['metric_label'])?></span></div><h3><?=e($card['title'])?></h3><p><?=e($card['description'])?></p><?=chart_bars($rows)?></article><?php endforeach; ?></div></section>
<?php elseif($page==='answer'): if(!$user) redirect_to('?page=login'); $answerKey=getv('q'); $preset=preset_for_answer_key($answerKey); if($preset && !preset_allowed($preset)): ?><?=access_gate('Pro question locked','Upgrade to run this preset intelligence question.','View pricing')?><?php else: $rows=run_preset_query($answerKey); ?>
<section class="view"><a class="linkish" href="?page=dashboard">← Back to questions</a><section class="section-head"><div><div class="eyebrow">Preset answer</div><h1><?=e($preset['title'] ?? labelize($answerKey))?></h1></div><a class="btn ghost" href="?page=catalogue">Open datasets</a></section><?=render_answer_visual($answerKey,$rows)?><?=render_table($rows,$rows?array_keys($rows[0]):[],null)?></section><?php endif; ?>
<?php elseif($page==='admin'): if(!is_admin()): ?><?=access_gate('Admin access required','Log in with an administrator account to manage records, imports, exports and users.','Log in')?><?php else: render_admin_page(); endif; ?>
<?php elseif($page==='contact'): ?>
<section class="view"><div class="panel contact-panel"><div class="eyebrow">Enterprise package</div><h1>Contact Angani Solutions</h1><p>For bulk exports, API access, private dashboards, custom aviation datasets and advisory work.</p><p><strong>Silas Savali</strong><br>Angani Solutions<br><a href="mailto:info@angani.co.uk">info@angani.co.uk</a><br><a href="https://www.angani.co.uk">www.angani.co.uk</a></p></div></section>
<?php endif; ?></main><footer class="site-footer"><span>Angani Data</span><span>Built for aviation professionals, consultants, airports, airlines and regulators.</span></footer><script src="js/app.js"></script></body></html>
<?php
require_once __DIR__ . '/includes/admin_render.php';
?>
