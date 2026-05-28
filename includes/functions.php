<?php
require_once __DIR__ . '/modules.php';



function e($v): string { return htmlspecialchars((string)($v ?? ''), ENT_QUOTES, 'UTF-8'); }
function getv(string $key, $default = ''): string { return trim((string)($_GET[$key] ?? $default)); }
function postv(string $key, $default = ''): string { return trim((string)($_POST[$key] ?? $default)); }
function nfmt($v): string { return number_format((float)($v ?? 0)); }
function fmt($v): string { return ($v === null || $v === '' || $v == 0) ? '—' : number_format((float)$v); }
function labelize(string $s): string { return ucwords(str_replace(['_','-'], ' ', $s)); }
function active_page(string $current, string $target): string { return $current === $target ? 'active' : ''; }
function page_num(): int { return max(1, (int)($_GET['p'] ?? 1)); }
function redirect_to(string $url): never { header('Location: ' . $url); exit; }
function csrf_token(): string { if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32)); return $_SESSION['csrf']; }
function csrf_field(): string { return '<input type="hidden" name="csrf" value="' . e(csrf_token()) . '">'; }
function verify_csrf(): void { if ($_SERVER['REQUEST_METHOD'] === 'POST' && !hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) throw new RuntimeException('Security token expired. Refresh the page and try again.'); }
function flash(string $type, string $message): void { $_SESSION['flash'][] = ['type'=>$type, 'message'=>$message]; }
function flash_html(): string { $out=''; foreach($_SESSION['flash'] ?? [] as $f) $out.='<div class="flash '.e($f['type']).'">'.e($f['message']).'</div>'; unset($_SESSION['flash']); return $out; }
function query_string(array $override = []): string { $q=array_merge($_GET,$override); foreach($q as $k=>$v) if($v===''||$v===null) unset($q[$k]); return http_build_query($q); }
function paginate(int $total, int $per): string { if($total <= $per) return ''; $p=page_num(); $pages=(int)ceil($total/$per); return '<div class="pager"><a class="btn ghost" href="?'.e(query_string(['p'=>max(1,$p-1)])).'">← Previous</a><span>Page '.e($p).' of '.e($pages).'</span><a class="btn ghost" href="?'.e(query_string(['p'=>min($pages,$p+1)])).'">Next →</a></div>'; }
function metric_card(string $number, string $label, string $note=''): string { return '<div class="stat-card"><strong>'.e($number).'</strong><span>'.e($label).'</span>'.($note?'<small>'.e($note).'</small>':'').'</div>'; }
function initials(string $name): string { preg_match_all('/\b[A-Za-z]/', $name, $m); return strtoupper(implode('', array_slice($m[0] ?? [], 0, 2)) ?: substr($name,0,2)); }
function str_starts(string $haystack,string $needle): bool { return substr($haystack,0,strlen($needle))===$needle; }

function current_user(): ?array {
    if (empty($_SESSION['user_id'])) return null;
    static $user = null;
    if ($user !== null) return $user;
    try { $user = row('SELECT u.*, st.code tier_code, st.name tier_name, st.display_order tier_order, st.monthly_usd, st.export_limit_monthly FROM users u LEFT JOIN subscription_tiers st ON st.id=u.tier_id WHERE u.id=? AND u.status="active"', [(int)$_SESSION['user_id']]); }
    catch (Throwable $e) { $user = null; }
    return $user ?: null;
}
function is_logged_in(): bool { return current_user() !== null; }
function is_admin(): bool { $u=current_user(); return $u && ($u['role'] ?? '') === 'admin'; }
function tier_order_for(?array $u=null): int { $u=$u ?: current_user(); return (int)($u['tier_order'] ?? 0); }
function tier_by_code(string $code): ?array {
    try { $r=row('SELECT * FROM subscription_tiers WHERE code=?', [$code]); if($r) return $r; } catch (Throwable $e) {}
    foreach (fallback_tiers() as $tier) if (($tier['code'] ?? '') === $code) return $tier;
    return null;
}
function tier_order_by_code(string $code): int { $r=tier_by_code($code); return (int)($r['display_order'] ?? 0); }
function has_tier(string $code): bool { return is_admin() || tier_order_for() >= tier_order_by_code($code); }
function feature_allowed(string $feature): bool {
    if(is_admin()) return true;
    $u=current_user();
    if(!$u) return in_array($feature, ['public_view','reference_view','limited_detail'], true);
    return (bool)scalar('SELECT COUNT(*) FROM tier_features WHERE tier_id=? AND feature_code=?', [(int)$u['tier_id'], $feature]);
}
function module_allowed(array $cfg): bool {
    $tier=$cfg['tier'] ?? 'free';
    if($tier==='free') return true;
    if($tier==='pro') return has_tier('pro');
    if($tier==='enterprise') return has_tier('enterprise');
    return true;
}
function access_gate(string $title, string $text, string $cta='See pricing'): string { return '<div class="lock-panel"><div class="lock-icon">LOCK</div><h3>'.e($title).'</h3><p>'.e($text).'</p><div class="hero-actions"><a class="btn primary" href="?page=pricing">'.e($cta).'</a><a class="btn ghost" href="?page=login">Log in</a></div></div>'; }
function tier_badge(?array $u=null): string { $u=$u ?: current_user(); return '<span class="tier-badge">'.e($u['tier_name'] ?? 'Guest').'</span>'; }
function fallback_tiers(): array {
    return [
        ['id'=>1,'code'=>'free','name'=>'Free','description'=>'Browse open aviation reference data, public database cards and rotating public insight previews.','monthly_usd'=>'0.00','annual_usd'=>'0.00','display_order'=>10,'export_limit_monthly'=>0],
        ['id'=>2,'code'=>'pro','name'=>'Pro','description'=>'Unlock full aviation intelligence, drill-down records, preset questions and filtered CSV exports.','monthly_usd'=>'49.00','annual_usd'=>'499.00','display_order'=>20,'export_limit_monthly'=>50],
        ['id'=>3,'code'=>'enterprise','name'=>'Enterprise','description'=>'Contact Angani for API access, bulk exports, custom dashboards and private aviation datasets.','monthly_usd'=>'0.00','annual_usd'=>'0.00','display_order'=>30,'export_limit_monthly'=>0],
    ];
}
function tier_cards(): array { try { return rows('SELECT * FROM subscription_tiers WHERE is_active=1 ORDER BY display_order'); } catch (Throwable $e) { return fallback_tiers(); } }
function tier_features(int $tierId): array {
    try { return rows('SELECT feature_label FROM tier_features WHERE tier_id=? ORDER BY id', [$tierId]); }
    catch (Throwable $e) {
        $fallback = [
            1 => ['Public database previews','Reference codes','Limited public insights','No CSV exports'],
            2 => ['Full standard databases','Record drill-downs','Preset intelligence questions','Filtered CSV exports','Saved searches'],
            3 => ['Bulk exports','API access','Team accounts','Custom datasets','Private dashboards'],
        ];
        return array_map(fn($label)=>['feature_label'=>$label], $fallback[$tierId] ?? []);
    }
}

function login_user(string $email, string $password): bool {
    $user=row('SELECT * FROM users WHERE email=? AND status="active"', [$email]);
    if(!$user || !password_verify($password, $user['password_hash'])) return false;
    $_SESSION['user_id']=(int)$user['id'];
    exec_sql('UPDATE users SET last_login_at=NOW(), updated_at=NOW() WHERE id=?', [(int)$user['id']]);
    return true;
}
function register_user(string $name,string $email,string $password): array {
    if(!filter_var($email, FILTER_VALIDATE_EMAIL)) return [false,'Enter a valid email address.'];
    if(strlen($password)<8) return [false,'Use at least 8 characters for the password.'];
    if((int)scalar('SELECT COUNT(*) FROM users WHERE email=?', [$email])>0) return [false,'An account with that email already exists.'];
    $tier=tier_by_code('free');
    if(!$tier) return [false,'Registration is not available right now (Free tier not configured). Contact the administrator.'];
    exec_sql('INSERT INTO users (name,email,password_hash,tier_id,role,status,created_at,updated_at) VALUES (?,?,?,?,"user","active",NOW(),NOW())', [$name,$email,password_hash($password,PASSWORD_DEFAULT),(int)$tier['id']]);
    $_SESSION['user_id']=(int)db()->lastInsertId();
    return [true,'Account created.'];
}
function logout_user(): void { $_SESSION=[]; if(ini_get('session.use_cookies')){ $p=session_get_cookie_params(); setcookie(session_name(),'',time()-42000,$p['path'],$p['domain'],$p['secure'],$p['httponly']); } session_destroy(); }

function table_columns(string $table): array {
    static $cache=[]; if(isset($cache[$table])) return $cache[$table];
    try { $cols=rows('SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=? ORDER BY ORDINAL_POSITION', [$table]); return $cache[$table]=array_map(fn($r)=>$r['COLUMN_NAME'],$cols); }
    catch(Throwable $e){ return $cache[$table]=[]; }
}
function internal_fields(): array { return ['id','uuid','source_id','source_record_id','source_scope','fields_json','row_json','headers_json','raw_text','raw_hash','import_batch_id','dataset_file_id','created_at','updated_at','deleted_at','date_added','date_modified','data_source','record_status','source_file','source_url','last_updated','created_by','screenshot_path']; }
function is_internal_field(string $f): bool { $publicBusinessIds=['fare_id','source_notam_id']; return in_array($f, internal_fields(), true) || (str_ends_with($f, '_id') && !in_array($f, $publicBusinessIds, true)); }
function public_field_label(string $f): string { if(in_array($f,['updated_at','last_modified','date_modified'],true)) return 'Last modified'; if(in_array($f,['created_at','date_added'],true)) return 'Date added'; return labelize($f); }
function display_value($v): string { if($v===null || $v==='') return '—'; $s=(string)$v; if(strlen($s)>180) return e(substr($s,0,180)).'…'; if(preg_match('~^https?://~i',$s)) return '<a href="'.e($s).'" target="_blank" rel="noopener">Open link</a>'; return e($s); }

function get_stats(): array {
    $safe=function($sql){ try{return (int)scalar($sql);}catch(Throwable $e){return 0;} };
    return [
        'airlines'=>$safe('SELECT COUNT(*) FROM airlines'), 'active_airlines'=>$safe("SELECT COUNT(*) FROM airlines WHERE status_bucket='active' OR LOWER(status)='active'"), 'airports'=>$safe('SELECT COUNT(*) FROM airports'), 'aircraft'=>$safe('SELECT COUNT(*) FROM aircraft_registrations'), 'aircraft_types'=>$safe('SELECT COUNT(*) FROM aircraft_types'), 'lessors'=>$safe('SELECT COUNT(*) FROM lessors'), 'navaids'=>$safe('SELECT COUNT(*) FROM navaids'), 'frequencies'=>$safe('SELECT COUNT(*) FROM airport_frequencies'), 'countries'=>$safe("SELECT COUNT(*) FROM countries WHERE code <> 'GLOBAL'"), 'regulatory'=>$safe('SELECT COUNT(*) FROM regulatory_records') + $safe('SELECT COUNT(*) FROM regulatory_authorities'), 'routes'=>$safe('SELECT COUNT(*) FROM airline_route_services'), 'users'=>$safe('SELECT COUNT(*) FROM users'), 'dataset_files'=>$safe('SELECT COUNT(*) FROM dataset_files')
    ];
}
function country_name(?string $code): string { if(!$code) return 'Unknown'; try{$r=row('SELECT name FROM countries WHERE code=?', [$code]); return $r['name'] ?? $code;}catch(Throwable $e){return $code;} }
function flag_emoji(?string $code): string { $code=strtoupper((string)$code); if(strlen($code)!==2) return '▧'; $out=''; for($i=0;$i<2;$i++) $out .= html_entity_decode('&#'.(127462 + ord($code[$i]) - ord('A')).';', ENT_NOQUOTES, 'UTF-8'); return $out; }
function status_chip(?string $status): string { $s=strtolower((string)($status ?: 'unknown')); $class = str_contains($s,'active') ? 'ok glow-green' : (str_contains($s,'defunct') || str_contains($s,'closed') ? 'danger' : 'gold'); return '<span class="chip '.$class.'">'.e(ucfirst($status ?: 'Unknown')).'</span>'; }

function module_count(string $key): int { $cfg=module_config($key); if(!$cfg || !table_exists($cfg['table'])) return 0; try{return (int)scalar('SELECT COUNT(*) FROM '.$cfg['table']);}catch(Throwable $e){return 0;} }
function public_url_prefix(): string { return defined('ANGANI_ADMIN_CONTEXT') ? '../' : ''; }
function module_url(string $key): string { return public_url_prefix().'?page=module&module='.urlencode($key); }
function detail_url(string $key,$id): string { return public_url_prefix().'?page=detail&module='.urlencode($key).'&id='.(int)$id; }

function query_module_records(array $cfg, int $limit=24, int $offset=0, bool $forExport=false): array {
    $table=$cfg['table']; if(!table_exists($table)) return [[],0];
    $cols=table_columns($table);
    $q=getv('q'); $where=[]; $params=[];
    if($q!=='') {
        $parts=[]; foreach(($cfg['search'] ?? []) as $c){ if(in_array($c,$cols,true)){ $parts[]="`$c` LIKE ?"; $params[]='%'.$q.'%'; } }
        if($parts) $where[]='('.implode(' OR ',$parts).')';
    }
    $country=getv('country'); if($country!=='' && in_array('country_code',$cols,true)) { $where[]='country_code=?'; $params[]=$country; }
    $sql=' FROM `'.$table.'`'.($where?' WHERE '.implode(' AND ',$where):'');
    $total=(int)scalar('SELECT COUNT(*)'.$sql,$params);
    $order=in_array('last_modified',$cols,true)?' ORDER BY last_modified DESC':(in_array('updated_at',$cols,true)?' ORDER BY updated_at DESC':' ORDER BY id DESC');
    if($forExport){ $data=rows('SELECT *'.$sql.$order.' LIMIT 5000',$params); }
    else { $data=rows('SELECT *'.$sql.$order.' LIMIT '.(int)$limit.' OFFSET '.(int)$offset,$params); }
    return [$data,$total];
}

function render_search_bar(string $key, array $cfg): string {
    return '<form method="get" class="toolbar"><input type="hidden" name="page" value="module"><input type="hidden" name="module" value="'.e($key).'"><label class="searchbox"><span>Search</span><input name="q" value="'.e(getv('q')).'" placeholder="Search '.e($cfg['label']).'"></label><label class="searchbox small"><span>Country</span><input name="country" value="'.e(getv('country')).'" placeholder="KE"></label><button class="btn ink">Search</button><a class="btn ghost" href="'.e(module_url($key)).'">Reset</a>'.(can_export_module($key)?'<a class="btn ghost" href="?page=export&module='.e($key).'&'.e(http_build_query(['q'=>getv('q'),'country'=>getv('country')])).'">Export CSV</a>':'').'</form>'; }
function can_export_module(string $key): bool { return is_admin() || (is_logged_in() && (feature_allowed('csv_exports') || has_tier('pro'))); }

function render_module_cards(string $key, array $rows): string {
    if(!$rows) return '<div class="empty-state"><h3>No records yet</h3><p>The database is ready. Use Admin → Import or Add record to populate it.</p></div>';
    $cfg=module_config($key); $html='<div class="record-grid">';
    foreach($rows as $r){ $html .= render_record_card($key,$cfg,$r); }
    return $html.'</div>';
}
function render_record_card(string $key,array $cfg,array $r): string {
    $title=$r[$cfg['title']] ?? ($r['name'] ?? 'Record'); $sub=$r[$cfg['subtitle']] ?? '';
    $url=detail_url($key,$r['id'] ?? 0); $card=$cfg['card'] ?? 'generic';
    if($card==='airline'){
        $logo=trim((string)($r['logo_url'] ?? '')); $mark=$logo?'<img class="card-logo" src="'.e($logo).'" alt="">':'<div class="avatar">'.e(initials($title)).'</div>';
        return '<article class="record-card airline-card" onclick="location.href=\''.e($url).'\'"><div class="record-top"><div class="flag">'.flag_emoji($r['country_code'] ?? '').'</div>'.$mark.status_chip($r['status_bucket'] ?? $r['status'] ?? '').'</div><h3>'.e($title).'</h3><p>'.e(trim(($r['iata_code'] ?? '').' / '.($r['icao_code'] ?? '').' / '.($r['callsign'] ?? ''),' /')).'</p><div class="mini-metrics"><span>Fleet '.e($r['fleet_size'] ?? '—').'</span><span>'.e($r['alliance'] ?? 'No alliance').'</span></div><a class="btn small primary" href="'.e($url).'">View Airline</a></article>';
    }
    if($card==='airport'){
        return '<article class="record-card" onclick="location.href=\''.e($url).'\'"><div class="record-top"><div class="flag">'.flag_emoji($r['country_code'] ?? '').'</div>'.status_chip($r['status'] ?? '').'</div><h3>'.e($title).'</h3><p>'.e(trim(($r['iata_code'] ?? '').' / '.($r['icao_code'] ?? '').' · '.($r['city_name'] ?? ''),' / ·')).'</p><div class="mini-metrics"><span>'.e($r['airport_type'] ?? 'Airport').'</span><span>'.e($r['elevation_ft'] ?? '—').' ft</span></div><a class="btn small primary" href="'.e($url).'">View Airport</a></article>';
    }
    if($card==='aircraft_type'){
        return '<article class="record-card" onclick="location.href=\''.e($url).'\'"><div class="record-top"><div class="avatar">'.e($r['icao_code'] ?? 'AC').'</div><span class="chip gold">'.e($r['category'] ?? 'Type').'</span></div><h3>'.e($title ?: ($r['common_name'] ?? 'Aircraft Type')).'</h3><p>'.e(($r['manufacturer'] ?? '').' · '.($r['model'] ?? '')).'</p><div class="mini-metrics"><span>IATA '.e($r['iata_code'] ?? '—').'</span><span>ICAO '.e($r['icao_code'] ?? '—').'</span></div><a class="btn small primary" href="'.e($url).'">View Type</a></article>';
    }
    if($card==='country'){
        $cc=strtolower($r['code'] ?? '');
        $flagPath=__DIR__.'/../assets/country_flag_icons/'.$cc.'.svg';
        $flag=file_exists($flagPath) ? '<img class="flag-svg" src="assets/country_flag_icons/'.$cc.'.svg" alt="">' : '<div class="flag">'.flag_emoji($r['code'] ?? '').'</div>';
        return '<article class="record-card" onclick="location.href=\''.e($url).'\'"><div class="record-top">'.$flag.'<span class="chip">'.e($cfg['label']).'</span></div><h3>'.e($title ?: $cfg['label']).'</h3><p>'.e($sub).'</p><a class="btn small primary" href="'.e($url).'">View Country</a></article>';
    }
    return '<article class="record-card" onclick="location.href=\''.e($url).'\'"><div class="record-top"><div class="avatar">'.e($cfg['icon'] ?? 'DB').'</div><span class="chip">'.e($cfg['label']).'</span></div><h3>'.e($title ?: $cfg['label']).'</h3><p>'.e($sub).'</p><a class="btn small primary" href="'.e($url).'">View Record</a></article>';
}
function render_table(array $rows, array $columns, ?string $moduleKey=null): string {
    if(!$rows) return '<div class="empty-state"><h3>No matching records</h3><p>Try another search or add records from Admin.</p></div>';
    $html='<div class="table-wrap"><table><thead><tr>'; foreach($columns as $c) $html.='<th>'.e(public_field_label($c)).'</th>'; if($moduleKey) $html.='<th>Action</th>'; $html.='</tr></thead><tbody>';
    foreach($rows as $r){ $html.='<tr>'; foreach($columns as $c) $html.='<td>'.display_value($r[$c] ?? null).'</td>'; if($moduleKey) $html.='<td><a class="btn mini" href="'.e(detail_url($moduleKey,$r['id'] ?? 0)).'">Open</a></td>'; $html.='</tr>'; }
    return $html.'</tbody></table></div>';
}

function render_admin_record_table(array $rows, array $columns, string $moduleKey): string {
    if(!$rows) return '<div class="empty-state"><h3>No matching records</h3><p>Use Add record or Import CSV to populate this module.</p></div>';
    $html='<div class="table-wrap"><table><thead><tr>'; foreach($columns as $c) $html.='<th>'.e(public_field_label($c)).'</th>'; $html.='<th>Admin actions</th></tr></thead><tbody>';
    foreach($rows as $r){ $html.='<tr>'; foreach($columns as $c) $html.='<td>'.display_value($r[$c] ?? null).'</td>'; $html.='<td><a class="btn mini" href="?page=admin&tab=edit&module='.e($moduleKey).'&id='.(int)($r['id'] ?? 0).'">Edit</a> <a class="btn mini ghost" href="'.e(detail_url($moduleKey,$r['id'] ?? 0)).'">Preview</a></td></tr>'; }
    return $html.'</tbody></table></div>';
}

function render_detail_fields(array $cfg,array $r,bool $admin=false): string {
    $fields=$cfg['detail'] ?? array_keys($r); $explicit=isset($cfg['detail']); $html='<div class="detail-grid">';
    foreach($fields as $f){ if(!$admin && !$explicit && is_internal_field($f)) continue; $html.='<div class="detail-item"><small>'.e(public_field_label($f)).'</small><strong>'.display_value($r[$f] ?? null).'</strong></div>'; }
    return $html.'</div>';
}
function render_related_sections(string $key,array $r): string {
    $html='';
    if($key==='airlines'){
        $iata=$r['iata_code'] ?? ''; $icao=$r['icao_code'] ?? ''; $name=$r['name'] ?? '';
        $html.=related_table('Digital properties', 'SELECT category,platform,url_or_handle,is_primary FROM airline_digital_properties WHERE iata_code=? OR icao_code=? OR airline_name=? LIMIT 20', [$iata,$icao,$name]);
        $html.=related_table('Fleet summary', 'SELECT aircraft_type,aircraft_count,configuration_lopa,average_age,engine_type FROM airline_fleet_summary WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('Hubs and bases', 'SELECT airport_code,hub_type,region_served,description FROM airline_hubs WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('Frequent flyer', 'SELECT program_name,points_unit,notes FROM frequent_flyer_programs WHERE airline_code=? OR iata_code=? OR icao_code=? OR airline_name=? LIMIT 10', [$iata,$iata,$icao,$name]);
    }
    if($key==='airports'){
        $iata=$r['iata_code'] ?? ''; $icao=$r['icao_code'] ?? '';
        $html.=related_table('Frequencies', 'SELECT frequency_type,frequency_mhz,description FROM airport_frequencies WHERE iata_code=? OR icao_code=? LIMIT 25', [$iata,$icao]);
        $html.=related_table('Runways', 'SELECT runway_ident,length_ft,width_ft,surface,lighting,ils_frequency FROM airport_runways WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('Terminals', 'SELECT terminal_type,terminal_name,capacity,facilities,gates_count FROM airport_terminals WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('Hub/base airlines', 'SELECT airline_name,relation,destinations_served FROM airport_hubs_and_airlines WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
    }
    if($key==='aircraft_types'){
        $iata=$r['iata_code'] ?? ''; $icao=$r['icao_code'] ?? '';
        $html.=related_table('Cabin & payload', 'SELECT typical_c_seats,typical_y_seats,max_capacity,cargo_volume_m3,max_payload_kg FROM aircraft_type_cabin_payload WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Engine data', 'SELECT engine_variants,engine_type,engine_count,thrust_per_engine_kn,fuel_burn_rate,saf_compatible FROM aircraft_type_engine_data WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Runway requirements', 'SELECT min_takeoff_length_ft,min_landing_length_ft,surface_compatibility FROM aircraft_type_runway_requirements WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Technical specs', 'SELECT mtow_kg,mzfw_kg,empty_weight_kg,wingspan_m,length_m,height_m FROM aircraft_type_technical_specs WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Economics', 'SELECT list_price_usd,op_cost_per_hour,lease_rate_monthly,residual_value_trend FROM aircraft_type_economic_data WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
    }
    if($key==='countries'){
        $cc=$r['code'] ?? '';
        $html.=related_table('Airlines in country', 'SELECT name,iata_code,icao_code,status_bucket,fleet_size FROM airlines WHERE country_code=? LIMIT 20', [$cc]);
        $html.=related_table('Airports in country', 'SELECT airport_name,iata_code,icao_code,airport_type,elevation_ft FROM airports WHERE country_code=? LIMIT 20', [$cc]);
        $html.=related_table('Regulatory authorities', 'SELECT name,abbreviation,website FROM regulatory_authorities WHERE country_code=? LIMIT 20', [$cc]);
        $html.=related_table('Navaids', 'SELECT identifier_code,navaid_name,navaid_type,region_fir FROM navaids WHERE country_code=? LIMIT 20', [$cc]);
    }
    return $html;
}
function related_table(string $title,string $sql,array $params): string { try{$rs=rows($sql,$params);}catch(Throwable $e){return '';} if(!$rs) return ''; return '<section class="related"><h3>'.e($title).'</h3>'.render_table($rs,array_keys($rs[0]),null).'</section>'; }

function run_insight_query(string $key): array {
    try {
    switch($key){
        case 'oldest_aircraft': return rows("SELECT registration label, CONCAT(COALESCE(aircraft_type,'Unknown'),' · ',COALESCE(operator_name,operator_icao,'Unknown')) detail, ROUND(age,1) value FROM aircraft_registrations WHERE age IS NOT NULL AND age>0 ORDER BY age DESC LIMIT 8");
        case 'highest_airports': return rows("SELECT airport_name label, CONCAT(COALESCE(city_name,municipality,''),' · ',COALESCE(country_code,'')) detail, elevation_ft value FROM airports WHERE elevation_ft IS NOT NULL ORDER BY elevation_ft DESC LIMIT 8");
        case 'smallest_airlines_capacity': return rows("SELECT name label, CONCAT(COALESCE(country_code,''),' · fleet ',COALESCE(fleet_size,0)) detail, COALESCE(fleet_size,0) value FROM airlines WHERE (status_bucket='active' OR LOWER(status)='active') AND fleet_size IS NOT NULL AND fleet_size>0 ORDER BY fleet_size ASC LIMIT 8");
        case 'routes_with_competition': return rows("SELECT COALESCE(flight_number_prefix,'Route') label, COALESCE(service_type,'Service') detail, COUNT(*) value FROM airline_route_services GROUP BY route_market_id HAVING COUNT(*)>1 ORDER BY value DESC LIMIT 8");
        case 'dataset_coverage': return rows("SELECT COALESCE(category,'Other') label, CONCAT(COUNT(*),' files') detail, COALESCE(SUM(row_count),0) value FROM dataset_files GROUP BY category ORDER BY value DESC LIMIT 8");
        case 'regulatory_depth': return rows("SELECT COALESCE(c.name,r.country_code) label, 'Regulatory records' detail, COUNT(*) value FROM regulatory_authorities r LEFT JOIN countries c ON c.code=r.country_code GROUP BY r.country_code,c.name ORDER BY value DESC LIMIT 8");
        case 'short_runway_aircraft': return rows("SELECT COALESCE(at.full_designation, rr.icao_code) label, CONCAT('Landing ', COALESCE(rr.min_landing_length_ft,'—'), ' ft') detail, rr.min_takeoff_length_ft value FROM aircraft_type_runway_requirements rr LEFT JOIN aircraft_types at ON at.icao_code=rr.icao_code WHERE rr.min_takeoff_length_ft IS NOT NULL AND rr.min_takeoff_length_ft>0 ORDER BY rr.min_takeoff_length_ft ASC LIMIT 8");
        case 'navaid_coverage': return rows("SELECT COALESCE(c.name,n.country_code) label, 'Navaids' detail, COUNT(*) value FROM navaids n LEFT JOIN countries c ON c.code=n.country_code GROUP BY n.country_code,c.name ORDER BY value DESC LIMIT 8");
    }} catch(Throwable $e){ return []; }
    return [];
}
function chart_bars(array $rows,string $suffix=''): string { if(!$rows) return '<p class="muted">No records yet.</p>'; $max=max(array_map(fn($r)=>(float)($r['value'] ?? 0),$rows)) ?: 1; $html='<div class="chart-bars">'; foreach($rows as $r){ $w=max(3,((float)($r['value'] ?? 0)/$max)*100); $html.='<div class="chart-row"><div><b>'.e($r['label'] ?? '').'</b><small>'.e($r['detail'] ?? '').'</small></div><div class="bar-track"><i style="width:'.$w.'%"></i></div><strong>'.e(nfmt($r['value'] ?? 0)).e($suffix).'</strong></div>'; } return $html.'</div>'; }
function active_insight_cards(): array { try{return rows('SELECT * FROM insight_cards WHERE is_active=1 ORDER BY display_order, updated_at DESC LIMIT 8');}catch(Throwable $e){return [];} }
function question_presets(): array { try{return rows('SELECT qp.*, st.code required_tier_code, st.name required_tier_name, st.display_order required_tier_order FROM question_presets qp LEFT JOIN subscription_tiers st ON st.id=qp.required_tier_id WHERE qp.is_active=1 ORDER BY qp.display_order, qp.id');}catch(Throwable $e){return [];} }
function run_preset_query(string $key): array {
    try {
    switch($key){
        case 'route_competitors': return run_insight_query('routes_with_competition');
        case 'oldest_aircraft': return run_insight_query('oldest_aircraft');
        case 'highest_airports': return run_insight_query('highest_airports');
        case 'smallest_airlines_capacity': return run_insight_query('smallest_airlines_capacity');
        case 'fleet_by_country': return rows("SELECT COALESCE(country_code,'Unknown') country, COUNT(*) aircraft_records, ROUND(AVG(age),1) avg_age FROM aircraft_registrations GROUP BY country_code ORDER BY aircraft_records DESC LIMIT 30");
        case 'regulatory_by_country': return rows("SELECT COALESCE(c.name,r.country_code) country, COUNT(*) regulatory_authorities FROM regulatory_authorities r LEFT JOIN countries c ON c.code=r.country_code GROUP BY r.country_code,c.name ORDER BY regulatory_authorities DESC LIMIT 30");
        case 'hub_airlines': return rows("SELECT airport_code, iata_code, icao_code, hub_type, region_served FROM airline_hubs ORDER BY airport_code LIMIT 30");
        case 'short_runway_aircraft': return rows("SELECT at.full_designation, rr.iata_code, rr.icao_code, rr.min_takeoff_length_ft, rr.min_landing_length_ft, rr.surface_compatibility FROM aircraft_type_runway_requirements rr LEFT JOIN aircraft_types at ON at.icao_code=rr.icao_code WHERE rr.min_takeoff_length_ft IS NOT NULL ORDER BY rr.min_takeoff_length_ft ASC LIMIT 30");
        case 'saf_compatible_aircraft': return rows("SELECT at.full_designation, ed.iata_code, ed.icao_code, ed.engine_type, ed.engine_variants, ed.saf_compatible FROM aircraft_type_engine_data ed LEFT JOIN aircraft_types at ON at.icao_code=ed.icao_code WHERE LOWER(COALESCE(ed.saf_compatible,'')) LIKE '%yes%' OR LOWER(COALESCE(ed.saf_compatible,'')) LIKE '%true%' LIMIT 30");
        case 'sources_to_review': return rows("SELECT entity_type, entity_id, field_name, old_value, new_value, changed_at, change_source FROM entity_change_log ORDER BY changed_at DESC LIMIT 30");
    }} catch(Throwable $e){ return []; }
    return [];
}

function handle_post_actions(): void {
    if(($_SERVER['REQUEST_METHOD'] ?? 'GET') !== 'POST') return; verify_csrf(); $action=postv('action');
    if($action==='login'){ $attempts=(int)($_SESSION['login_attempts'] ?? 0); if($attempts>5) { usleep(3000000); flash('error','Too many attempts. Try again later.'); redirect_to('?page=login'); } if($attempts>0) usleep($attempts*200000); if(login_user(postv('email'),postv('password'))){$_SESSION['login_attempts']=0;flash('success','Logged in.'); redirect_to('?page=dashboard');} $_SESSION['login_attempts']=$attempts+1; flash('error','Invalid email or password.'); redirect_to('?page=login'); }
    if($action==='register'){ [$ok,$msg]=register_user(postv('name'),postv('email'),postv('password')); flash($ok?'success':'error',$msg); redirect_to($ok?'?page=dashboard':'?page=register'); }
    if($action==='update_account' && is_logged_in()){ exec_sql('UPDATE users SET name=?, updated_at=NOW() WHERE id=?',[postv('name'),(int)current_user()['id']]); flash('success','Account updated.'); redirect_to('?page=account'); }
    if(!is_admin()) return;
    if($action==='admin_save_record') { admin_save_record(); }
    if($action==='admin_delete_record') { admin_delete_record(); }
    if($action==='admin_save_user') { admin_save_user(); }
    if($action==='admin_save_tier') { admin_save_tier(); }
    if($action==='admin_save_feature') { admin_save_feature(); }
    if($action==='admin_delete_feature') { admin_delete_feature(); }
    if($action==='admin_save_question') { admin_save_question(); }
    if($action==='admin_save_insight') { admin_save_insight(); }
    if($action==='admin_update_staging') { admin_update_staging(); }
    if($action==='admin_update_task') { exec_sql('UPDATE admin_tasks SET status=?, updated_at=NOW() WHERE id=?',[postv('status'),(int)postv('task_id')]); flash('success','Task updated.'); redirect_to('?page=admin&tab=tasks'); }
    if($action==='admin_import_csv') { admin_import_csv(); }
}
function admin_save_record(): void {
    $key=postv('module'); $cfg=module_config($key); if(!$cfg) throw new RuntimeException('Unknown module.'); $table=$cfg['table']; $cols=table_columns($table); $id=(int)postv('id'); $fields=array_values(array_filter($cfg['fields'], fn($f)=>in_array($f,$cols,true) && $f!=='id'));
    $data=[]; foreach($fields as $f){ $data[$f]=postv($f); }
    if($id>0){ $sets=[]; $params=[]; foreach($data as $f=>$v){ $sets[]="`$f`=?"; $params[]=$v; } $params[]=$id; exec_sql('UPDATE `'.$table.'` SET '.implode(',',$sets).' WHERE id=?',$params); flash('success','Record updated.'); redirect_to('?page=admin&tab=records&module='.$key); }
    else { $names=array_keys($data); $vals=array_values($data); exec_sql('INSERT INTO `'.$table.'` (`'.implode('`,`',$names).'`) VALUES ('.implode(',',array_fill(0,count($names),'?')).')',$vals); flash('success','Record added.'); redirect_to('?page=admin&tab=records&module='.$key); }
}
function admin_delete_record(): void { $key=postv('module'); $id=(int)postv('id'); $cfg=module_config($key); if(!$cfg) throw new RuntimeException('Unknown module.'); exec_sql('DELETE FROM `'.$cfg['table'].'` WHERE id=?',[$id]); flash('success','Record deleted.'); redirect_to('?page=admin&tab=records&module='.$key); }
function admin_save_user(): void {
    $id=(int)postv('user_id'); $name=postv('name'); $email=postv('email'); $tier=(int)postv('tier_id'); $role=postv('role'); $status=postv('status');
    if($tier<=0) throw new RuntimeException('A valid tier/plan must be selected.');
    if($id>0) exec_sql('UPDATE users SET name=?, email=?, tier_id=?, role=?, status=?, updated_at=NOW() WHERE id=?',[$name,$email,$tier,$role,$status,$id]);
    else exec_sql('INSERT INTO users (name,email,password_hash,tier_id,role,status,created_at,updated_at) VALUES (?,?,?,?,?,?,NOW(),NOW())',[$name,$email,password_hash(postv('password','Angani@2026'),PASSWORD_DEFAULT),$tier,$role,$status]);
    flash('success','User saved.'); redirect_to('?page=admin&tab=users');
}

function admin_save_tier(): void {
    $id=(int)postv('tier_id'); if($id<=0) throw new RuntimeException('Missing tier.');
    exec_sql('UPDATE subscription_tiers SET code=?, name=?, description=?, monthly_usd=?, annual_usd=?, export_limit_monthly=?, api_limit_monthly=?, display_order=?, is_active=?, updated_at=NOW() WHERE id=?', [
        postv('code'), postv('name'), postv('description'), (float)postv('monthly_usd'), (float)postv('annual_usd'), (int)postv('export_limit_monthly'), (int)postv('api_limit_monthly'), (int)postv('display_order'), postv('is_active')==='1'?1:0, $id
    ]);
    flash('success','Plan updated.'); redirect_to('?page=admin&tab=plans');
}
function admin_save_feature(): void {
    $tier=(int)postv('tier_id'); if($tier<=0) throw new RuntimeException('Missing tier.');
    $code=postv('feature_code'); $label=postv('feature_label'); if($code===''||$label==='') throw new RuntimeException('Feature code and label are required.');
    $existing=row('SELECT id FROM tier_features WHERE tier_id=? AND feature_code=?',[$tier,$code]);
    if($existing) exec_sql('UPDATE tier_features SET feature_label=?, updated_at=NOW() WHERE id=?',[$label,(int)$existing['id']]);
    else exec_sql('INSERT INTO tier_features (tier_id,feature_code,feature_label,created_at) VALUES (?,?,?,NOW())',[$tier,$code,$label]);
    flash('success','Plan benefit saved.'); redirect_to('?page=admin&tab=plans');
}
function admin_delete_feature(): void {
    $id=(int)postv('feature_id'); if($id>0) exec_sql('DELETE FROM tier_features WHERE id=?',[$id]);
    flash('success','Plan benefit removed.'); redirect_to('?page=admin&tab=plans');
}
function admin_save_question(): void {
    $id=(int)postv('id');
    $params=[postv('code'),postv('title'),postv('question_text'),postv('category'),postv('answer_key'),(int)postv('required_tier_id')?:null,(int)postv('display_order'),postv('is_active')==='1'?1:0];
    if($id>0){ $params[]=$id; exec_sql('UPDATE question_presets SET code=?,title=?,question_text=?,category=?,answer_key=?,required_tier_id=?,display_order=?,is_active=?,updated_at=NOW() WHERE id=?',$params); }
    else { exec_sql('INSERT INTO question_presets (code,title,question_text,category,answer_key,required_tier_id,display_order,is_active,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?,NOW(),NOW())',$params); }
    flash('success','Preset question saved.'); redirect_to('?page=admin&tab=questions');
}
function available_insight_queries(): array {
    return [
        'oldest_aircraft'=>'Oldest aircraft in registry',
        'highest_airports'=>'Highest airports',
        'smallest_airlines_capacity'=>'Smallest active airlines by fleet',
        'routes_with_competition'=>'Competitive route markets',
        'dataset_coverage'=>'Dataset coverage by category',
        'regulatory_depth'=>'Regulatory depth by country',
        'short_runway_aircraft'=>'Shortest runway aircraft types',
        'navaid_coverage'=>'Navaid coverage by country'
    ];
}
function admin_update_staging(): void {
    $id=(int)postv('staging_id'); $status=postv('status');
    if($id<=0) throw new RuntimeException('Missing staging row.');
    if(!in_array($status,['pending','accepted','rejected','duplicate','conflict','needs_review'],true)) throw new RuntimeException('Invalid staging status.');
    exec_sql('UPDATE staging_import_records SET status=? WHERE id=?',[$status,$id]);
    flash('success','Staging status updated.'); redirect_to('?page=admin&tab=quality');
}
function admin_save_insight(): void {
    $id=(int)postv('id'); $params=[postv('title'),postv('metric_label'),postv('description'),postv('query_key'),postv('chart_type'),(int)postv('required_tier_id')?:null,(int)postv('display_order'),postv('is_active')==='1'?1:0];
    if($id>0){ $params[]=$id; exec_sql('UPDATE insight_cards SET title=?,metric_label=?,description=?,query_key=?,chart_type=?,required_tier_id=?,display_order=?,is_active=?,updated_at=NOW() WHERE id=?',$params); }
    else exec_sql('INSERT INTO insight_cards (title,metric_label,description,query_key,chart_type,required_tier_id,display_order,is_active,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?,NOW(),NOW())',$params);
    flash('success','Homepage insight saved.'); redirect_to('?page=admin&tab=insights');
}
function admin_import_csv(): void {
    $key=postv('module'); $cfg=module_config($key); if(!$cfg) throw new RuntimeException('Unknown module.');
    if(empty($_FILES['csv_file']['tmp_name'])) throw new RuntimeException('Choose a CSV file to import.');
    $mode=postv('import_mode','append'); if(!in_array($mode,['append','truncate_append'],true)) $mode='append';
    $table=$cfg['table']; $cols=table_columns($table); $fields=$cfg['fields'];
    if($mode==='truncate_append') exec_sql('DELETE FROM `'.$table.'`');
    $fh=fopen($_FILES['csv_file']['tmp_name'],'r'); if(!$fh) throw new RuntimeException('Could not read uploaded CSV.');
    $header=fgetcsv($fh); if(!$header) throw new RuntimeException('CSV has no header.');
    $map=[];
    foreach($header as $i=>$h){
        $clean=trim((string)$h);
        $norm=strtolower(trim(str_replace([' ','/','-','(',')','.'], '_', $clean)));
        foreach($fields as $f){
            $fNorm=strtolower($f);
            if($fNorm===$norm || strtolower(str_replace('_',' ',$f))===strtolower($clean)) $map[$i]=$f;
        }
    }
    if(!$map) throw new RuntimeException('No CSV headers matched editable fields for this module. Use headers such as: '.implode(', ', array_slice($fields,0,8)).'.');
    $safeFilename=mb_substr(basename($_FILES['csv_file']['name']),0,255);
    exec_sql('INSERT INTO import_batches (batch_name,source_file,module_key,status,started_at,created_by,notes) VALUES (?,?,?,"running",NOW(),?,?)',[$safeFilename,$safeFilename,$key,(int)current_user()['id'],postv('notes')]); $batch=(int)db()->lastInsertId();
    $imported=0; $failed=0; $rowNo=1;
    while(($row=fgetcsv($fh))!==false){
        $rowNo++;
        $data=[]; $nonEmpty=false;
        foreach($map as $i=>$f){ if(!in_array($f,$cols,true)) continue; $v=isset($row[$i]) ? trim((string)$row[$i]) : null; if($v!=='') $nonEmpty=true; $data[$f]=$v===''?null:$v; }
        if(!$data || !$nonEmpty) continue;
        try{
            $names=array_keys($data);
            exec_sql('INSERT INTO `'.$table.'` (`'.implode('`,`',$names).'`) VALUES ('.implode(',',array_fill(0,count($names),'?')).')',array_values($data));
            $imported++;
        } catch(Throwable $e){
            $failed++;
            exec_sql('INSERT INTO staging_import_records (import_batch_id,module_key,source_row_number,status,row_json,issue_summary) VALUES (?,?,?,?,?,?)',[$batch,$key,$rowNo,'needs_review',json_encode(array_combine($header,array_pad($row,count($header),'')),JSON_UNESCAPED_UNICODE),$e->getMessage()]);
        }
    }
    fclose($fh);
    exec_sql('UPDATE import_batches SET status=?, rows_total=?, rows_imported=?, rows_failed=?, finished_at=NOW() WHERE id=?',[$failed?'needs_review':'completed',$imported+$failed,$imported,$failed,$batch]);
    flash($failed?'warning':'success',"Imported {$imported} rows".($failed?"; {$failed} sent to staging.":'.'));
    redirect_to('?page=admin&tab=records&module='.$key);
}

function export_module_csv(string $key): never {
    $cfg=module_config($key); if(!$cfg) { http_response_code(404); exit('Unknown module'); }
    if(!module_allowed($cfg) || !can_export_module($key)) { http_response_code(403); exit('Export access denied'); }
    [$data,$total]=query_module_records($cfg,0,0,true); $cols=$cfg['list']; if(!$data) $cols=$cfg['fields'];
    header('Content-Type: text/csv; charset=utf-8'); header('Content-Disposition: attachment; filename="angani_'.$key.'_'.date('Ymd_His').'.csv"');
    $out=fopen('php://output','w'); fputcsv($out,$cols); foreach($data as $r) fputcsv($out,array_map(fn($c)=>$r[$c] ?? '',$cols));
    if(is_logged_in()) exec_sql('INSERT INTO export_logs (user_id,module_key,filters_json,rows_exported,created_at) VALUES (?,?,?,?,NOW())',[(int)current_user()['id'],$key,json_encode($_GET),count($data)]);
    exit;
}


function export_database_zip(): never {
    if(!is_admin()) { http_response_code(403); exit('Admin export access denied'); }
    if(!class_exists('ZipArchive')) { http_response_code(500); exit('PHP ZipArchive extension is required for whole-database ZIP export. Use module CSV exports if ZipArchive is unavailable.'); }
    $tmp=tempnam(sys_get_temp_dir(),'angani_export_');
    $zip=new ZipArchive();
    if($zip->open($tmp, ZipArchive::OVERWRITE)!==true) { http_response_code(500); exit('Could not create export ZIP.'); }
    $manifest=['generated_at'=>date('c'),'modules'=>[]];
    foreach(modules() as $key=>$cfg){
        if(!table_exists($cfg['table'])) continue;
        try { [$data,$total]=query_module_records($cfg,0,0,true); } catch(Throwable $e){ $manifest['modules'][$key]=['error'=>$e->getMessage()]; continue; }
        $cols=$cfg['list']; if(!$data) $cols=$cfg['fields'];
        $fp=fopen('php://temp','r+'); fputcsv($fp,$cols);
        foreach($data as $r) fputcsv($fp,array_map(fn($c)=>$r[$c] ?? '',$cols));
        rewind($fp); $csv=stream_get_contents($fp); fclose($fp);
        $zip->addFromString($key.'.csv',$csv);
        $manifest['modules'][$key]=['label'=>$cfg['label'],'table'=>$cfg['table'],'rows_exported'=>count($data),'rows_total'=>$total,'limit_note'=>'Module exports are capped at 5000 rows per configured module for browser safety.'];
        exec_sql('INSERT INTO export_logs (user_id,module_key,filters_json,rows_exported,created_at) VALUES (?,?,?,?,NOW())',[(int)current_user()['id'],$key,json_encode(['bulk_zip'=>true]),count($data)]);
    }
    $zip->addFromString('manifest.json', json_encode($manifest, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES));
    $zip->close();
    header('Content-Type: application/zip');
    header('Content-Disposition: attachment; filename="angani_data_full_export_'.date('Ymd_His').'.zip"');
    header('Content-Length: '.filesize($tmp));
    readfile($tmp); unlink($tmp); exit;
}

function preset_for_answer_key(string $answerKey): ?array {
    if($answerKey==='') return null;
    try { return row('SELECT qp.*, st.display_order required_tier_order, st.name required_tier_name FROM question_presets qp LEFT JOIN subscription_tiers st ON st.id=qp.required_tier_id WHERE qp.answer_key=? AND qp.is_active=1 LIMIT 1', [$answerKey]); }
    catch(Throwable $e){ return null; }
}
function preset_allowed(array $preset): bool {
    if(is_admin()) return true;
    $required=(int)($preset['required_tier_order'] ?? 0);
    return $required===0 || tier_order_for() >= $required;
}
function global_search(string $term, int $perModule=5): array {
    $term=trim($term); if($term==='') return [];
    $all=[]; $needle='%'.$term.'%';
    foreach(modules() as $key=>$cfg){
        if(!table_exists($cfg['table'])) continue;
        $cols=table_columns($cfg['table']);
        $searchCols=array_values(array_filter($cfg['search'] ?? [], fn($c)=>in_array($c,$cols,true)));
        if(!$searchCols) continue;
        $parts=[]; $params=[];
        foreach($searchCols as $c){ $parts[]='`'.$c.'` LIKE ?'; $params[]=$needle; }
        $selectCols=array_values(array_unique(array_filter(['id',$cfg['title'] ?? null,$cfg['subtitle'] ?? null,...($cfg['list'] ?? [])], fn($c)=>$c && in_array($c,$cols,true))));
        if(!in_array('id',$selectCols,true)) array_unshift($selectCols,'id');
        $sql='SELECT `'.implode('`,`',$selectCols).'` FROM `'.$cfg['table'].'` WHERE ('.implode(' OR ',$parts).') LIMIT '.(int)$perModule;
        try{
            foreach(rows($sql,$params) as $r){
                $all[]=[
                    'module_key'=>$key,
                    'module_label'=>$cfg['label'],
                    'tier'=>$cfg['tier'] ?? 'free',
                    'icon'=>$cfg['icon'] ?? 'DB',
                    'title'=>$r[$cfg['title']] ?? ($r['name'] ?? $cfg['label']),
                    'subtitle'=>$r[$cfg['subtitle']] ?? '',
                    'record_id'=>$r['id'] ?? 0,
                    'allowed'=>module_allowed($cfg),
                    'data'=>$r
                ];
            }
        } catch(Throwable $e){ continue; }
    }
    return $all;
}
function render_global_search_results(array $results): string {
    if(!$results) return '<div class="empty-state"><h3>No matching records</h3><p>Try a broader aviation term, code, country, airport, aircraft model, or reference code.</p></div>';
    $html='<div class="search-result-grid">';
    foreach($results as $r){
        $url=detail_url($r['module_key'],$r['record_id']);
        $locked=!$r['allowed'];
        $html.='<article class="search-result-card '.($locked?'locked':'').'"><div class="topline"><span class="chip gold">'.e($r['module_label']).'</span><span class="chip">'.e(strtoupper($r['tier'])).'</span></div><h3>'.e($r['title']).'</h3><p>'.e($r['subtitle']).'</p>';
        $preview=[]; foreach(($r['data'] ?? []) as $k=>$v){ if($k==='id'||is_internal_field($k)||$v===''||$v===null) continue; $preview[]='<span>'.e(public_field_label($k)).': '.strip_tags(display_value($v)).'</span>'; if(count($preview)>=3) break; }
        if($preview) $html.='<div class="search-preview">'.implode('',$preview).'</div>';
        $html.=$locked?'<a class="btn ghost" href="?page=pricing">Unlock with Pro</a>':'<a class="btn primary" href="'.e($url).'">Open record</a>';
        $html.='</article>';
    }
    return $html.'</div>';
}
function render_answer_visual(string $answerKey, array $rows): string {
    if(!$rows) return '<div class="empty-state"><h3>No answer rows yet</h3><p>The query is configured, but the underlying dataset has no matching records yet.</p></div>';
    $chartable=[];
    foreach($rows as $r){
        if(isset($r['label']) && isset($r['value'])) { $chartable=$rows; break; }
        $numKey=null; foreach($r as $k=>$v){ if(is_numeric($v)){ $numKey=$k; break; } }
        if($numKey){ $label=''; foreach($r as $k=>$v){ if($k!==$numKey && $v!=='' && $v!==null){ $label=(string)$v; break; } } $chartable[]=['label'=>$label ?: 'Record','detail'=>labelize($numKey),'value'=>$r[$numKey]]; }
    }
    if(!$chartable) return '';
    return '<section class="panel answer-chart"><h3>Visual summary</h3>'.chart_bars(array_slice($chartable,0,10)).'</section>';
}
