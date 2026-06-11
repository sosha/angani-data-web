<?php
require_once __DIR__ . '/modules.php';



function e($v): string { return htmlspecialchars((string)($v ?? ''), ENT_QUOTES, 'UTF-8'); }
function getv(string $key, $default = ''): string { return trim((string)($_GET[$key] ?? $default)); }
function postv(string $key, $default = ''): string { return trim((string)($_POST[$key] ?? $default)); }
function postv_array(string $key): array { $v=$_POST[$key] ?? []; return is_array($v) ? array_values($v) : []; }
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
function paginate(int $total, int $per): string {
    if($total <= $per) return '';
    $p=page_num(); $pages=(int)ceil($total/$per); $start=(($p-1)*$per)+1; $end=min($total,$p*$per);
    $html='<nav class="pager" aria-label="Pagination"><span class="pager-summary">Showing '.nfmt($start).'–'.nfmt($end).' of '.nfmt($total).'</span>';
    $html .= $p>1 ? '<a class="btn ghost" href="?'.e(query_string(['p'=>$p-1])).'">← Previous</a>' : '<span class="btn ghost disabled" aria-disabled="true">← Previous</span>';
    $from=max(1,$p-2); $to=min($pages,$p+2);
    if($from>1) $html.='<a class="pager-num" href="?'.e(query_string(['p'=>1])).'">1</a><span class="pager-gap">…</span>';
    for($i=$from;$i<=$to;$i++) $html .= $i===$p ? '<span class="pager-num active">'.e($i).'</span>' : '<a class="pager-num" href="?'.e(query_string(['p'=>$i])).'">'.e($i).'</a>';
    if($to<$pages) $html.='<span class="pager-gap">…</span><a class="pager-num" href="?'.e(query_string(['p'=>$pages])).'">'.e($pages).'</a>';
    $html .= $p<$pages ? '<a class="btn ghost" href="?'.e(query_string(['p'=>$p+1])).'">Next →</a>' : '<span class="btn ghost disabled" aria-disabled="true">Next →</span>';
    return $html.'</nav>';
}
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
function normalize_tier_code(string $code): string { $code=strtolower(trim($code)); return $code==='enterprise' ? 'ultimate' : $code; }
function tier_by_code(string $code): ?array {
    $code=normalize_tier_code($code); $alts=$code==='ultimate' ? ['ultimate','enterprise'] : [$code];
    try {
        $placeholders=implode(',',array_fill(0,count($alts),'?'));
        $r=row('SELECT * FROM subscription_tiers WHERE code IN ('.$placeholders.') ORDER BY display_order DESC LIMIT 1', $alts);
        if($r) return $r;
    } catch (Throwable $e) {}
    foreach (fallback_tiers() as $tier) if (normalize_tier_code($tier['code'] ?? '') === $code) return $tier;
    return null;
}
function tier_order_by_code(string $code): int { $r=tier_by_code($code); return (int)($r['display_order'] ?? 0); }
function has_tier(string $code): bool { return is_admin() || tier_order_for() >= tier_order_by_code(normalize_tier_code($code)); }
function feature_allowed(string $feature): bool {
    if(is_admin()) return true;
    $u=current_user();
    if(!$u) return in_array($feature, ['public_view','reference_view','limited_detail'], true);
    try { return (bool)scalar('SELECT COUNT(*) FROM tier_features WHERE tier_id=? AND feature_code=?', [(int)$u['tier_id'], $feature]); }
    catch(Throwable $e){ return false; }
}
function fallback_tiers(): array {
    return [
        ['id'=>1,'code'=>'free','name'=>'Free','description'=>'Create an account to open standard drill-downs for core aviation databases. Some premium fields, reports and specialist intelligence remain locked.','monthly_usd'=>'0.00','annual_usd'=>'0.00','display_order'=>10,'export_limit_monthly'=>0],
        ['id'=>2,'code'=>'pro','name'=>'Pro','description'=>'Unlock premium aviation intelligence, generated reports, advanced related tables, filtered exports and analyst-ready views.','monthly_usd'=>'49.00','annual_usd'=>'499.00','display_order'=>20,'export_limit_monthly'=>50],
        ['id'=>3,'code'=>'ultimate','name'=>'Ultimate','description'=>'Everything in Pro plus bulk/API access, private dashboards, custom data services and advisory support configured around the client’s needs.','monthly_usd'=>'0.00','annual_usd'=>'0.00','display_order'=>30,'export_limit_monthly'=>0],
    ];
}
function tier_cards(): array {
    try { ensure_access_rules_schema(); return rows('SELECT * FROM subscription_tiers WHERE is_active=1 ORDER BY display_order'); }
    catch (Throwable $e) { return fallback_tiers(); }
}
function tier_features(int $tierId): array {
    try { return rows('SELECT feature_label FROM tier_features WHERE tier_id=? ORDER BY id', [$tierId]); }
    catch (Throwable $e) {
        $fallback = [
            1 => ['Core database browsing','Free account drill-downs','Public previews before login','No CSV exports'],
            2 => ['Premium fields and reports','Full standard drill-downs','Preset intelligence questions','Filtered CSV exports','Saved searches'],
            3 => ['Bulk exports','API access','Team accounts','Custom datasets','Private dashboards and advisory services'],
        ];
        return array_map(fn($label)=>['feature_label'=>$label], $fallback[$tierId] ?? []);
    }
}
function access_tier_order(string $code): int {
    $code=normalize_tier_code($code);
    if($code==='' || $code==='public' || $code==='guest') return 0;
    if($code==='free') return max(1, tier_order_by_code('free') ?: 10);
    if($code==='pro') return tier_order_by_code('pro') ?: 20;
    if($code==='ultimate') return tier_order_by_code('ultimate') ?: 30;
    return tier_order_by_code($code) ?: 999;
}
function viewer_access_order(): int { return is_admin() ? 9999 : (is_logged_in() ? tier_order_for() : 0); }
function default_access_rules(): array {
    return [
        ['module','countries','Countries listing','public','Visitors can browse and expand country cards before signing in.'],
        ['module','airlines','Airlines listing','public','Visitors can browse and expand airline cards before signing in.'],
        ['module','airports','Airports listing','public','Visitors can browse and expand airport cards before signing in.'],
        ['module','aircraft','Aircraft registry listing','public','Visitors can preview aircraft cards; full records require an account.'],
        ['module','aircraft_types','Aircraft Types listing','public','Visitors can browse and expand type cards before signing in.'],
        ['detail','countries','Country full detail','free','A free account can open standard country detail pages.'],
        ['detail','airlines','Airline full detail','free','A free account can open standard airline detail pages.'],
        ['detail','airports','Airport full detail','free','A free account can open standard airport detail pages.'],
        ['detail','aircraft','Aircraft registry full detail','free','A free account can open aircraft registry detail pages unless upgraded by admin.'],
        ['detail','aircraft_types','Aircraft Type full detail','free','A free account can open standard aircraft type detail pages.'],
        ['section','aircraft_types:economics','Aircraft monthly lease rates / economics','pro','Protect lease rates, operating costs and residual-value intelligence.'],
        ['section','airlines:commercial','Airline commercial intelligence','pro','Protect loyalty, commercial and revenue-related analysis.'],
        ['section','airlines:people','Airline careers / key personnel','pro','Protect airline people, careers and contact-style intelligence.'],
        ['module','aircraft_economic_data','Aircraft economic data module','pro','Protect lease-rate and operating-cost datasets.'],
        ['module','airline_people','Airline people / careers module','pro','Protect staff, people and career-related datasets.'],
        ['module','source_records','Source records','pro','Protect raw source material and screenshots.'],
        ['module','change_log','Change log','pro','Protect data-change intelligence.'],
        ['module','import_batches','Import batches','ultimate','Operational/admin-style metadata.'],
        ['module','staging_records','Staging records','ultimate','Operational/admin-style metadata.'],
        ['module','export_logs','Export logs','ultimate','Operational/admin-style metadata.'],
        ['report','generated_reports','Generated reports','pro','Generated reports are premium intelligence by default.'],
    ];
}
function ensure_access_rules_schema(): void {
    static $done=false; if($done) return; $done=true;
    try {
        exec_sql("CREATE TABLE IF NOT EXISTS access_rules (
            id INT AUTO_INCREMENT PRIMARY KEY,
            scope_type VARCHAR(40) NOT NULL,
            scope_key VARCHAR(191) NOT NULL,
            label VARCHAR(255) NOT NULL,
            min_tier VARCHAR(40) NOT NULL DEFAULT 'free',
            is_active TINYINT(1) NOT NULL DEFAULT 1,
            notes TEXT NULL,
            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME NULL DEFAULT NULL,
            UNIQUE KEY uniq_scope (scope_type, scope_key)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        try { exec_sql("UPDATE subscription_tiers SET code='ultimate', name='Ultimate', description='Everything in Pro plus bulk/API access, private dashboards, custom data services and advisory support configured around the client’s needs.', updated_at=NOW() WHERE code='enterprise'"); } catch(Throwable $e) {}
        foreach(default_access_rules() as $r){
            exec_sql('INSERT IGNORE INTO access_rules (scope_type,scope_key,label,min_tier,is_active,notes,created_at) VALUES (?,?,?,?,1,?,NOW())', [$r[0],$r[1],$r[2],normalize_tier_code($r[3]),$r[4] ?? null]);
        }
    } catch (Throwable $e) {}
}
function access_rules_all(): array {
    ensure_access_rules_schema();
    try { return rows("SELECT * FROM access_rules ORDER BY FIELD(scope_type,'module','detail','section','field','report','feature'), scope_key"); }
    catch(Throwable $e){
        return array_map(fn($r)=>['scope_type'=>$r[0],'scope_key'=>$r[1],'label'=>$r[2],'min_tier'=>$r[3],'is_active'=>1,'notes'=>$r[4] ?? ''], default_access_rules());
    }
}
function access_rule(string $scopeType, string $scopeKey, string $fallbackTier='free'): array {
    ensure_access_rules_schema();
    try { $r=row('SELECT * FROM access_rules WHERE scope_type=? AND scope_key=? AND is_active=1 LIMIT 1', [$scopeType,$scopeKey]); if($r) return $r; } catch(Throwable $e) {}
    foreach(default_access_rules() as $d) if($d[0]===$scopeType && $d[1]===$scopeKey) return ['scope_type'=>$d[0],'scope_key'=>$d[1],'label'=>$d[2],'min_tier'=>$d[3],'is_active'=>1,'notes'=>$d[4] ?? ''];
    return ['scope_type'=>$scopeType,'scope_key'=>$scopeKey,'label'=>labelize($scopeKey),'min_tier'=>$fallbackTier,'is_active'=>1,'notes'=>''];
}
function access_allowed(string $scopeType, string $scopeKey, string $fallbackTier='free'): bool {
    if(is_admin()) return true;
    $rule=access_rule($scopeType,$scopeKey,$fallbackTier);
    return viewer_access_order() >= access_tier_order($rule['min_tier'] ?? $fallbackTier);
}
function module_key_for_cfg(array $cfg): ?string { foreach(modules() as $k=>$c){ if(($c['table']??null)===($cfg['table']??null) && ($c['label']??null)===($cfg['label']??null)) return $k; } return null; }
function module_allowed(array $cfg): bool {
    $key=module_key_for_cfg($cfg); $fallback=normalize_tier_code($cfg['tier'] ?? 'free');
    return $key ? access_allowed('module',$key,$fallback) : access_allowed('module',$cfg['table'] ?? 'module',$fallback);
}
function detail_allowed(string $key, array $cfg): bool { return access_allowed('detail',$key,normalize_tier_code($cfg['tier'] ?? 'free')); }
function section_allowed(string $key, string $section, string $fallbackTier='free'): bool { return access_allowed('section',$key.':'.$section,$fallbackTier); }
function field_allowed(string $key, string $field, string $fallbackTier='free'): bool { return access_allowed('field',$key.':'.$field,$fallbackTier); }
function access_gate(string $title, string $text, string $cta='See pricing'): string {
    $ctaLower=strtolower($cta);
    if(str_contains($ctaLower,'log')) $primary='?page=login';
    elseif(str_contains($ctaLower,'back')) $primary='?page=home';
    elseif(!is_logged_in()) $primary='?page=login';
    else $primary='?page=pricing';
    $secondary=is_logged_in()?'<a class="btn ghost" href="?page=catalogue">Browse open data</a>':'<a class="btn ghost" href="?page=register">Create free account</a>';
    return '<div class="lock-panel"><div class="lock-icon"><i class="fas fa-lock"></i></div><h3>'.e($title).'</h3><p>'.e($text).'</p><div class="hero-actions"><a class="btn primary" href="'.e($primary).'">'.e($cta).'</a>'.$secondary.'</div></div>';
}
function tier_badge(?array $u=null): string { $u=$u ?: current_user(); return '<span class="tier-badge">'.e($u['tier_name'] ?? 'Guest').'</span>'; }

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
        'airlines'=>$safe('SELECT COUNT(*) FROM airlines'), 'active_airlines'=>$safe("SELECT COUNT(*) FROM airlines WHERE status_bucket='active'"), 'airports'=>$safe('SELECT COUNT(*) FROM airports'), 'aircraft'=>$safe('SELECT COUNT(*) FROM aircraft_registrations'), 'aircraft_types'=>$safe('SELECT COUNT(*) FROM aircraft_types'), 'lessors'=>$safe('SELECT COUNT(*) FROM lessors'), 'navaids'=>$safe('SELECT COUNT(*) FROM navaids'), 'frequencies'=>$safe('SELECT COUNT(*) FROM airport_frequencies'),         'countries'=>$safe("SELECT COUNT(*) FROM countries WHERE iso_alpha_2 NOT IN ('GB-ENG','GB-SCT','GB-NIR','GB-WLS')"), 'regulatory'=>$safe('SELECT COUNT(*) FROM regulatory_records') + $safe('SELECT COUNT(*) FROM regulatory_authorities'), 'routes'=>$safe('SELECT COUNT(*) FROM airline_route_services'), 'users'=>$safe('SELECT COUNT(*) FROM users'), 'dataset_files'=>$safe('SELECT COUNT(*) FROM dataset_files')
    ];
}
function country_name(?string $code): string { if(!$code) return 'Unknown'; try{$r=row('SELECT name_common FROM countries WHERE iso_alpha_2=?', [$code]); return $r['name_common'] ?? $code;}catch(Throwable $e){return $code;} }
function flag_emoji(?string $code): string { $code=strtoupper((string)$code); if(strlen($code)!==2) return ''; $out=''; for($i=0;$i<2;$i++) $out .= html_entity_decode('&#'.(127462 + ord($code[$i]) - ord('A')).';', ENT_NOQUOTES, 'UTF-8'); return $out; }
function status_chip(?string $status): string { $s=strtolower((string)($status ?: 'unknown')); $class = str_contains($s,'active') ? 'ok glow-green' : (str_contains($s,'defunct') || str_contains($s,'closed') ? 'danger' : 'gold'); return '<span class="chip '.$class.'">'.e(ucfirst($status ?: 'Unknown')).'</span>'; }
function module_icon_html(string $key): string { static $map=['countries'=>'<i class="fas fa-globe"></i>','airlines'=>'<i class="fas fa-plane-departure"></i>','airports'=>'<i class="fas fa-map-location"></i>','aircraft'=>'<i class="fas fa-plane"></i>','aircraft_types'=>'<i class="fas fa-tag"></i>','lessors'=>'<i class="fas fa-building"></i>','routes'=>'<i class="fas fa-route"></i>','airline_digital'=>'<i class="fas fa-laptop"></i>','frequent_flyer'=>'<i class="fas fa-star"></i>','airline_fleet_list'=>'<i class="fas fa-list"></i>','airline_fleet_summary'=>'<i class="fas fa-chart-bar"></i>','airline_hubs'=>'<i class="fas fa-code-branch"></i>','airline_it'=>'<i class="fas fa-server"></i>','airline_people'=>'<i class="fas fa-users"></i>','airline_stats'=>'<i class="fas fa-chart-line"></i>','airport_frequencies'=>'<i class="fas fa-broadcast-tower"></i>','airport_runways'=>'<i class="fas fa-road"></i>','airport_terminals'=>'<i class="fas fa-door-open"></i>','airport_services'=>'<i class="fas fa-concierge-bell"></i>','airport_hubs'=>'<i class="fas fa-code-branch"></i>','airport_financial'=>'<i class="fas fa-chart-pie"></i>','airport_ground_handling'=>'<i class="fas fa-truck"></i>','airport_ground_transport'=>'<i class="fas fa-bus"></i>','airport_it'=>'<i class="fas fa-server"></i>','airport_people'=>'<i class="fas fa-users"></i>','navaids'=>'<i class="fas fa-map-marker-alt"></i>','navaid_technical'=>'<i class="fas fa-wrench"></i>','navaid_operational'=>'<i class="fas fa-cogs"></i>','navaid_connectivity'=>'<i class="fas fa-network-wired"></i>','navaid_references'=>'<i class="fas fa-book"></i>','notam_sources'=>'<i class="fas fa-database"></i>','notams'=>'<i class="fas fa-exclamation-triangle"></i>','notam_classification'=>'<i class="fas fa-filter"></i>','notam_content'=>'<i class="fas fa-file-alt"></i>','notam_schedule'=>'<i class="fas fa-calendar-alt"></i>','notam_connectivity'=>'<i class="fas fa-network-wired"></i>','notam_references'=>'<i class="fas fa-book"></i>','regulatory'=>'<i class="fas fa-gavel"></i>','regulatory_authorities'=>'<i class="fas fa-university"></i>','regulatory_economic'=>'<i class="fas fa-file-invoice-dollar"></i>','regulatory_operational'=>'<i class="fas fa-certificate"></i>','regulatory_licensing'=>'<i class="fas fa-id-card"></i>','iata_membership'=>'<i class="fas fa-handshake"></i>','iosa_registration'=>'<i class="fas fa-clipboard-list"></i>','airline_iata'=>'<i class="fas fa-handshake"></i>','airline_iosa'=>'<i class="fas fa-clipboard-list"></i>','commercial_fares'=>'<i class="fas fa-dollar-sign"></i>','commercial_inventory'=>'<i class="fas fa-warehouse"></i>','commercial_rules'=>'<i class="fas fa-ruler"></i>','commercial_taxes'=>'<i class="fas fa-receipt"></i>','commercial_yield'=>'<i class="fas fa-chart-line"></i>','country_fare_policies'=>'<i class="fas fa-file-contract"></i>','gds'=>'<i class="fas fa-globe-americas"></i>','aircraft_profile'=>'<i class="fas fa-info-circle"></i>','aircraft_assets'=>'<i class="fas fa-images"></i>','aircraft_cabin_payload'=>'<i class="fas fa-weight-hanging"></i>','aircraft_engine_data'=>'<i class="fas fa-cog"></i>','aircraft_economic_data'=>'<i class="fas fa-chart-bar"></i>','aircraft_environmental'=>'<i class="fas fa-leaf"></i>','aircraft_manufacturer_support'=>'<i class="fas fa-tools"></i>','aircraft_performance'=>'<i class="fas fa-tachometer-alt"></i>','aircraft_runways'=>'<i class="fas fa-road"></i>','aircraft_technical_specs'=>'<i class="fas fa-microchip"></i>','aircraft_models'=>'<i class="fas fa-book"></i>','aircraft_model_history'=>'<i class="fas fa-history"></i>','aircraft_model_capacity'=>'<i class="fas fa-chair"></i>','aircraft_model_specs'=>'<i class="fas fa-cogs"></i>','aircraft_model_production'=>'<i class="fas fa-industry"></i>','aircraft_model_sources'=>'<i class="fas fa-link"></i>','ref_country_codes'=>'<i class="fas fa-globe"></i>','ref_service_types'=>'<i class="fas fa-tags"></i>','ref_meal_codes'=>'<i class="fas fa-utensils"></i>','ref_booking_classes'=>'<i class="fas fa-chair"></i>','ref_terminal_codes'=>'<i class="fas fa-door-closed"></i>','ref_reject_reasons'=>'<i class="fas fa-times-circle"></i>','ref_phonetic'=>'<i class="fas fa-font"></i>','dataset_files'=>'<i class="fas fa-file-csv"></i>','source_records'=>'<i class="fas fa-link"></i>','change_log'=>'<i class="fas fa-history"></i>','import_batches'=>'<i class="fas fa-upload"></i>','staging_records'=>'<i class="fas fa-database"></i>','export_logs'=>'<i class="fas fa-download"></i>','regulatory_environmental'=>'<i class="fas fa-leaf"></i>','regulatory_references'=>'<i class="fas fa-book"></i>','regulatory_safety'=>'<i class="fas fa-shield-alt"></i>']; return $map[$key] ?? '<i class="fas fa-database"></i>'; }

function module_count(string $key): int { $cfg=module_config($key); if(!$cfg || !table_exists($cfg['table'])) return 0; try{return (int)scalar('SELECT COUNT(*) FROM '.$cfg['table']);}catch(Throwable $e){return 0;} }

function manufacturer_logo_url(?string $manufacturer): string { if(!$manufacturer) return ''; try{$r=row('SELECT logo_url FROM aircraft_manufacturers WHERE is_active IN(\'Yes\',\'Unknown\') AND logo_url IS NOT NULL AND logo_url!=\'\' AND (name=? OR name LIKE CONCAT(?,\'%\') OR ? LIKE CONCAT(name,\'%\')) LIMIT 1',[$manufacturer,$manufacturer,$manufacturer]); if($r && $r['logo_url']) return 'assets/manufacturer_logos/'.$r['logo_url'];}catch(Throwable $e){} $map=['AgustaWestland'=>'AgustaWestland_Logo.svg.png','Agusta'=>'AgustaWestland_Logo.svg.png','Airbus'=>'Airbus_Logo_2017.svg.png','Boeing'=>'Boeing_full_logo.svg.png','Cessna'=>'Cessna_Logo.svg.png','Comac'=>'Comac_logo.svg.png','De Havilland'=>'De_Havilland_Canada_logo.svg.png','Eclipse'=>'Eclipse_Aerospace_Logo.png','Embraer'=>'Embraer_logo.svg.png','Fokker'=>'Fokker_logo.png','GippsAero'=>'GippsAero_logo.png','Gulfstream'=>'Gulfstream_Aerospace_logo.svg.png','MD'=>'MD_Helicopters_logo.svg.png','Mitsubishi'=>'Mitsubishi-Aircraft-Corporation-Logo.png','Pilatus'=>'Pilatus_Aircraft_logo.svg.png','Piper'=>'Piper_logo.svg.png','Sikorsky'=>'Sikorsky_Aircraft_Logo.svg.png']; $key=ucwords(strtolower(trim($manufacturer))); foreach($map as $k=>$f){ if(str_contains($key, $k) || str_contains($k, $key)) return 'assets/manufacturer_logos/'.$f; } return ''; }

function data_audit_log(string $tableName, string $action, ?string $recordId = null, ?array $oldValues = null, ?array $newValues = null, ?string $notes = null, ?string $collectionMethod = null, ?int $licenseId = null): void {
    static $skipTables = ['data_audit_log','data_licenses','data_table_provenance','admin_action_log','entity_change_log','sessions','pipeline_runs','staging_records','archived_records','staging_import_records','import_batches','export_logs'];
    if (in_array($tableName, $skipTables, true)) return;
    $user = current_user();
    try {
        exec_sql('INSERT INTO data_audit_log (table_name,record_id,action,collection_method,old_values,new_values,changed_by,notes,license_id) VALUES (?,?,?,?,?,?,?,?,?)',
            [$tableName, $recordId, $action, $collectionMethod,
             $oldValues ? json_encode($oldValues) : null,
             $newValues ? json_encode($newValues) : null,
             $user['name'] ?? 'system', $notes, $licenseId]);
    } catch (Throwable $e) {}
}

function data_audit_license_select(string $name = 'license_id', ?int $selected = null): string {
    $out = '<select name="'.e($name).'"><option value="">— None —</option>';
    try {
        foreach (rows('SELECT id, name FROM data_licenses ORDER BY name') as $l) {
            $out .= '<option value="'.(int)$l['id'].'"'.((int)$selected === (int)$l['id'] ? ' selected' : '').'>'.e($l['name']).'</option>';
        }
    } catch (Throwable $e) {}
    return $out . '</select>';
}

function data_audit_update_license(int $auditId, int $licenseId): void {
    try { exec_sql('UPDATE data_audit_log SET license_id=? WHERE id=?', [$licenseId, $auditId]); } catch (Throwable $e) {}
}

function data_provenance_get(string $tableName): ?array {
    try { return row('SELECT * FROM data_table_provenance WHERE table_name=?', [$tableName]); } catch (Throwable $e) { return null; }
}

function data_provenance_set(string $tableName, string $collectionMethod, ?string $primarySourceUrl = null, ?int $licenseId = null, ?string $notes = null): void {
    try {
        exec_sql('INSERT INTO data_table_provenance (table_name,collection_method,primary_source_url,primary_license_id,notes,updated_by) VALUES (?,?,?,?,?,?) ON DUPLICATE KEY UPDATE collection_method=VALUES(collection_method), primary_source_url=VALUES(primary_source_url), primary_license_id=VALUES(primary_license_id), notes=VALUES(notes), updated_by=VALUES(updated_by)',
            [$tableName, $collectionMethod, $primarySourceUrl, $licenseId, $notes, current_user()['name'] ?? 'system']);
    } catch (Throwable $e) {}
}
function public_url_prefix(): string { return defined('ANGANI_ADMIN_CONTEXT') ? '../' : ''; }
function module_url(string $key): string { return public_url_prefix().'?page=module&module='.urlencode($key); }
function detail_url(string $key,$id): string { $pk=module_pk($key); $s=in_array($pk,['icao_code','ident','iso_alpha_2','code'],true)?(string)$id:(int)$id; return public_url_prefix().'?page=detail&module='.urlencode($key).'&id='.urlencode($s); }
function iso2_continent(string $iso2): string {
    static $map=['AF'=>'asia','AL'=>'europe','DZ'=>'africa','AD'=>'europe','AO'=>'africa','AG'=>'north america','AR'=>'south america','AM'=>'asia','AU'=>'oceania','AT'=>'europe','AZ'=>'asia','BS'=>'north america','BH'=>'asia','BD'=>'asia','BB'=>'north america','BY'=>'europe','BE'=>'europe','BZ'=>'north america','BJ'=>'africa','BT'=>'asia','BO'=>'south america','BA'=>'europe','BW'=>'africa','BR'=>'south america','BN'=>'asia','BG'=>'europe','BF'=>'africa','BI'=>'africa','KH'=>'asia','CM'=>'africa','CA'=>'north america','CV'=>'africa','CF'=>'africa','TD'=>'africa','CL'=>'south america','CN'=>'asia','CO'=>'south america','KM'=>'africa','CG'=>'africa','CD'=>'africa','CR'=>'north america','HR'=>'europe','CU'=>'north america','CY'=>'asia','CZ'=>'europe','DK'=>'europe','DJ'=>'africa','DM'=>'north america','DO'=>'north america','EC'=>'south america','EG'=>'africa','SV'=>'north america','GQ'=>'africa','ER'=>'africa','EE'=>'europe','SZ'=>'africa','ET'=>'africa','FJ'=>'oceania','FI'=>'europe','FR'=>'europe','GA'=>'africa','GM'=>'africa','GE'=>'asia','DE'=>'europe','GH'=>'africa','GR'=>'europe','GD'=>'north america','GT'=>'north america','GN'=>'africa','GW'=>'africa','GY'=>'south america','HT'=>'north america','HN'=>'north america','HK'=>'asia','HU'=>'europe','IS'=>'europe','IN'=>'asia','ID'=>'asia','IR'=>'asia','IQ'=>'asia','IE'=>'europe','IL'=>'asia','IT'=>'europe','CI'=>'africa','JM'=>'north america','JP'=>'asia','JO'=>'asia','KZ'=>'asia','KE'=>'africa','KI'=>'oceania','KP'=>'asia','KR'=>'asia','KW'=>'asia','KG'=>'asia','LA'=>'asia','LV'=>'europe','LB'=>'asia','LS'=>'africa','LR'=>'africa','LY'=>'africa','LI'=>'europe','LT'=>'europe','LU'=>'europe','MG'=>'africa','MW'=>'africa','MY'=>'asia','MV'=>'asia','ML'=>'africa','MT'=>'europe','MH'=>'oceania','MR'=>'africa','MU'=>'africa','MX'=>'north america','FM'=>'oceania','MD'=>'europe','MC'=>'europe','MN'=>'asia','ME'=>'europe','MA'=>'africa','MZ'=>'africa','MM'=>'asia','NA'=>'africa','NR'=>'oceania','NP'=>'asia','NL'=>'europe','NZ'=>'oceania','NI'=>'north america','NE'=>'africa','NG'=>'africa','NO'=>'europe','OM'=>'asia','PK'=>'asia','PW'=>'oceania','PA'=>'north america','PG'=>'oceania','PY'=>'south america','PE'=>'south america','PH'=>'asia','PL'=>'europe','PT'=>'europe','QA'=>'asia','RO'=>'europe','RU'=>'asia','RW'=>'africa','KN'=>'north america','LC'=>'north america','VC'=>'north america','WS'=>'oceania','SM'=>'europe','ST'=>'africa','SA'=>'asia','SN'=>'africa','RS'=>'europe','SC'=>'africa','SL'=>'africa','SG'=>'asia','SK'=>'europe','SI'=>'europe','SB'=>'oceania','SO'=>'africa','ZA'=>'africa','SS'=>'africa','ES'=>'europe','LK'=>'asia','SD'=>'africa','SR'=>'south america','SE'=>'europe','CH'=>'europe','SY'=>'asia','TW'=>'asia','TJ'=>'asia','TZ'=>'africa','TH'=>'asia','TL'=>'oceania','TG'=>'africa','TO'=>'oceania','TT'=>'north america','TN'=>'africa','TR'=>'asia','TM'=>'asia','TV'=>'oceania','UG'=>'africa','UA'=>'europe','AE'=>'asia','GB'=>'europe','US'=>'north america','UY'=>'south america','UZ'=>'asia','VU'=>'oceania','VE'=>'south america','VN'=>'asia','YE'=>'asia','ZM'=>'africa','ZW'=>'africa'];
    return $map[strtoupper($iso2)] ?? '';
}

function query_module_records(array $cfg, int $limit=24, int $offset=0, bool $forExport=false, ?string $orderBy=null): array {
    $table=$cfg['table']; if(!table_exists($table)) return [[],0];
    $cols=table_columns($table);
    $q=getv('q'); $where=[]; $params=[];
    if($q!=='') {
        $parts=[]; foreach(($cfg['search'] ?? []) as $c){ if(in_array($c,$cols,true)){ $parts[]="`$c` LIKE ?"; $params[]='%'.$q.'%'; } }
        if($parts) $where[]='('.implode(' OR ',$parts).')';
    }
    $country=getv('country'); if($country!=='' && in_array('country_code',$cols,true)) { $where[]='country_code=?'; $params[]=$country; }
    $status=getv('status'); if($status!==''){ $scol=in_array('status_bucket',$cols,true)?'status_bucket':(in_array('status',$cols,true)?'status':null); if($scol){ $where[]="`$scol`=?"; $params[]=$status; } elseif(in_array('active',$cols,true)){ if($status==='active'){ $where[]='`active`=?'; $params[]='Y'; } elseif($status==='defunct'){ $where[]='`active`=?'; $params[]='N'; } } }
    $sql=' FROM `'.$table.'`'.($where?' WHERE '.implode(' AND ',$where):'');
    $total=(int)scalar('SELECT COUNT(*)'.$sql,$params);
    if($orderBy){
        $order=' ORDER BY '.$orderBy;
    } else {
        $sort=getv('sort','default'); $dir=str_starts_with($sort,'-')?'DESC':'ASC'; $sort=ltrim($sort,'-');
        if($sort==='default'){
            $order=in_array('last_modified',$cols,true)?' ORDER BY last_modified DESC':(in_array('updated_at',$cols,true)?' ORDER BY updated_at DESC':(in_array('id',$cols,true)?' ORDER BY id DESC':(in_array('code',$cols,true)?' ORDER BY code ASC':(count($cols)?' ORDER BY '.$cols[0].' ASC':''))));
        } elseif(in_array($sort,$cols,true)){
            $order=' ORDER BY `'.str_replace('`','',$sort).'` '.$dir;
        } else {
            $order=in_array('id',$cols,true)?' ORDER BY id DESC':(in_array('code',$cols,true)?' ORDER BY code ASC':(count($cols)?' ORDER BY '.$cols[0].' ASC':''));
        }
    }
    if($forExport){ $data=rows('SELECT *'.$sql.$order.' LIMIT 5000',$params); }
    else { $data=rows('SELECT *'.$sql.$order.' LIMIT '.(int)$limit.' OFFSET '.(int)$offset,$params); }
    return [$data,$total];
}

function country_select(string $name='country', string $selected=''): string {
    $html='<select name="'.e($name).'"><option value="">All countries</option>';
    try{
        $rows=rows('SELECT iso_alpha_2,name_common FROM countries ORDER BY name_common ASC');
        foreach($rows as $r) {
            $sel = ($r['iso_alpha_2']===$selected || $r['name_common']===$selected) ? ' selected' : '';
            $html .= '<option value="'.e($r['iso_alpha_2']).'"'.$sel.'>'.e($r['name_common']).' ('.e($r['iso_alpha_2']).')</option>';
        }
    }catch(Throwable $e){}
    return $html.'</select>';
}

function render_search_bar(string $key, array $cfg): string {
    $cols=table_columns($cfg['table']??'');
    $sortOpts=[['default','Default']]; $nameCols=['name','airport_name','full_designation','airline_name','country_name','title','model_name','program_name','company']; foreach($nameCols as $n){ if(in_array($n,$cols,true)){ $sortOpts[]=[$n,$n]; $sortOpts[]=['-'.$n,$n.' ↓']; break; } }
    if(in_array('country_code',$cols,true)){ $sortOpts[]=['country_code','Country']; $sortOpts[]=['-country_code','Country ↓']; }
    if(in_array('status_bucket',$cols,true)||in_array('status',$cols,true)){ $sortOpts[]=['status','Status']; }
    if(in_array('fleet_size',$cols,true)){ $sortOpts[]=['-fleet_size','Fleet size']; }
    if(in_array('elevation_ft',$cols,true)){ $sortOpts[]=['-elevation_ft','Elevation']; }
    $sops=''; $sv=getv('sort','default'); foreach($sortOpts as $o){ $sops.='<option value="'.e($o[0]).'"'.($sv===$o[0]?' selected':'').'>'.e($o[1]).'</option>'; }
    $hasStatus=in_array('status_bucket',$cols,true)||in_array('status',$cols,true)||in_array('active',$cols,true);
    $statusOpts='<option value="">All</option>'; $curS=getv('status');
    if($hasStatus){
        if(in_array('active',$cols,true)){ $statuses=['active','defunct']; }
        elseif(in_array('status_bucket',$cols,true)){ $statuses=['active','defunct','closed','unknown']; }
        else { $statuses=['active','inactive','closed','unknown']; }
        foreach($statuses as $s){ $statusOpts.='<option value="'.e($s).'"'.($curS===$s?' selected':'').'>'.e(ucfirst($s)).'</option>'; }
    }
    return '<form method="get" class="toolbar"><input type="hidden" name="page" value="module"><input type="hidden" name="module" value="'.e($key).'"><label class="searchbox"><span>Search</span><input name="q" value="'.e(getv('q')).'" placeholder="Search '.e($cfg['label']).'"></label><label class="searchbox small"><span>Country</span>'.country_select('country',getv('country')).'</label>'.($hasStatus?'<label class="searchbox tiny"><span>Status</span><select name="status">'.$statusOpts.'</select></label>':'').'<label class="searchbox tiny"><span>Sort</span><select name="sort">'.$sops.'</select></label><button class="btn ink">Filter</button><a class="btn ghost" href="'.e(module_url($key)).'">Reset</a>'.(can_export_module($key)?'<a class="btn ghost" href="?page=export&module='.e($key).'&'.e(http_build_query(['q'=>getv('q'),'country'=>getv('country'),'status'=>getv('status')])).'">Export CSV</a>':'').'</form>'; }
function can_export_module(string $key): bool { return is_admin() || (is_logged_in() && (feature_allowed('csv_exports') || has_tier('pro'))); }

function render_module_cards(string $key, array $rows): string {
    if(!$rows) return '<div class="empty-state"><h3>No records yet</h3><p>The database is ready. Use Admin → Import or Add record to populate it.</p></div>';
    $cfg=module_config($key); $html='<div class="record-grid">';
    foreach($rows as $r){ $html .= render_record_card($key,$cfg,$r); }
    return $html.'</div>';
}
function render_record_card(string $key,array $cfg,array $r): string {
    $title=$r[$cfg['title']] ?? ($r['name'] ?? 'Record'); $sub=$r[$cfg['subtitle']] ?? '';
    $pk=module_pk($key); $id=$r[$pk] ?? $r['id'] ?? $r['code'] ?? 0; $url=detail_url($key,$id); $card=$cfg['card'] ?? 'generic';
    $logged=is_logged_in();
    $canOpen=detail_allowed($key,$cfg);
    if($canOpen){
        $detailLink='<div class="detail-link-row"><span>Preview expanded. Open the full page for charts, related tables and source-level detail.</span><a class="btn small ink xcard-detail-btn" href="'.e($url).'">View More &rarr;</a></div>';
    } elseif(!$logged){
        $detailLink='<div class="detail-link-row"><span>Free preview. Create an account to drill into the full record.</span><a class="btn small ghost xcard-detail-btn" href="?page=login">Log in to View More &rarr;</a></div>';
    } else {
        $detailLink='<div class="detail-link-row"><span>This deeper view is limited by the current tier settings.</span><a class="btn small ghost xcard-detail-btn" href="?page=pricing">Upgrade to View More &rarr;</a></div>';
    }
    if($card==='airline'){
        static $fleetCache=[], $hubCache=[], $destCache=[], $destNamesCache=[], $countryNameCache=[];
        if(!$fleetCache){
            try{ $fr=rows('SELECT icao_code,SUM(aircraft_count) AS total FROM airline_fleet_summary GROUP BY icao_code'); foreach($fr as $f) $fleetCache[$f['icao_code']]=(int)$f['total']; }catch(Throwable $e){}
            try{ $hr=rows('SELECT icao_code,COUNT(*) AS hubs FROM airline_hubs GROUP BY icao_code'); foreach($hr as $h) $hubCache[$h['icao_code']]=(int)$h['hubs']; }catch(Throwable $e){}
            try{ $dr=rows('SELECT airline_icao,COUNT(*) AS cnt FROM airline_destinations GROUP BY airline_icao'); foreach($dr as $d) $destCache[$d['airline_icao']]=(int)$d['cnt']; }catch(Throwable $e){}
            try{ $dnr=rows('SELECT airline_icao,airport_name FROM airline_destinations WHERE airport_name IS NOT NULL AND airport_name!="" ORDER BY airline_icao,airport_name'); foreach($dnr as $d) $destNamesCache[$d['airline_icao']][]=e($d['airport_name']); }catch(Throwable $e){}
            try{ $cr=rows('SELECT iso_alpha_2,name_common FROM countries'); foreach($cr as $c) $countryNameCache[strtolower($c['iso_alpha_2'])]=e($c['name_common']); }catch(Throwable $e){}
        }
        $cc=strtolower($r['country_code']??'');
        $flagHtml=$cc?((file_exists(__DIR__.'/../assets/country_flag_icons/'.$cc.'.svg')?'<img class="xcard-img" src="assets/country_flag_icons/'.$cc.'.svg" alt="">':'<span style="font-size:28px">'.flag_emoji($cc).'</span>')):'';
        $logo=($r['logo_url']??'')?'<img class="xcard-img" src="'.e($r['logo_url']).'" alt="'.e($title).' logo" loading="lazy">':'';
        $sb=$r['status_bucket']??''; $statusChip=$sb==='active'?'<span class="chip ok">Active</span>':($sb==='defunct'?'<span class="chip danger">Defunct</span>':'<span class="chip gold">'.e(ucfirst($sb)?:'Unknown').'</span>');
        $icao=e($r['icao_code']??''); $iata=e($r['iata_code']??''); $callsign=e($r['callsign']??'');
        $fleet=$icao?($fleetCache[$icao]??0):0; $hubs=$icao?($hubCache[$icao]??0):0;
        $destinations=$icao?($destCache[$icao]??0):0;
        $countryName=$cc?($countryNameCache[$cc]??''):'';
        if(!$countryName) $countryName=e($r['country']??$r['country_code']??'');
        $countryFlagHtml=$cc?((file_exists(__DIR__.'/../assets/country_flag_icons/'.$cc.'.svg')?'<img class="flag-svg" src="assets/country_flag_icons/'.$cc.'.svg" alt="" style="width:18px;height:18px;vertical-align:middle;margin-right:6px">':'<span style="font-size:18px;vertical-align:middle;margin-right:6px">'.flag_emoji($cc).'</span>')):'';
        $codes=trim("$iata / $icao",' /'); $name=e($title); $alias=e($r['alias']??'');
        $destNames=($icao && isset($destNamesCache[$icao]))?array_slice($destNamesCache[$icao],0,3):[];
        $destHtml='';
        foreach($destNames as $dn) $destHtml.='<div style="font-size:.78rem;line-height:1.5;padding-left:4px">&bull; '.$dn.'</div>';
        if(!$destHtml&&$destinations) $destHtml='<div style="font-size:.78rem;color:var(--muted);padding-left:4px">'.$destinations.' destinations listed in database</div>';
        return '<article class="xcard" data-xs="'.strtolower($name.' '.$iata.' '.$icao.' '.$callsign).'" data-xf="'.e($sb).'"><div class="xcard-top">'.($logo?:$flagHtml).$statusChip.'</div><h3 class="xcard-name">'.$name.'</h3><div class="xcard-summary"><div class="xcard-stat"><span class="xcard-stat-l">CODES</span><strong class="xcard-stat-v">'.$codes.'</strong></div>'.($countryName?'<div class="xcard-stat"><span class="xcard-stat-l">COUNTRY</span><strong class="xcard-stat-v">'.$countryFlagHtml.$countryName.'</strong></div>':'').($fleet?'<div class="xcard-stat"><span class="xcard-stat-l">FLEET</span><strong class="xcard-stat-v">'.nfmt($fleet).'</strong></div>':'').($hubs?'<div class="xcard-stat"><span class="xcard-stat-l">HUBS</span><strong class="xcard-stat-v">'.nfmt($hubs).'</strong></div>':'').($destinations?'<div class="xcard-stat"><span class="xcard-stat-l">DESTINATIONS</span><strong class="xcard-stat-v">'.nfmt($destinations).'</strong></div>':'').'</div><div class="xcard-expand" style="display:none"><div class="xcard-sections"><div class="xcard-sec"><div class="xcard-sec-title">IDENTITY</div><div class="xcard-row"><span class="xcard-row-k">Name</span><span class="xcard-row-v">'.$name.'</span></div>'.($alias?'<div class="xcard-row"><span class="xcard-row-k">Alias</span><span class="xcard-row-v">'.$alias.'</span></div>':'').($iata?'<div class="xcard-row"><span class="xcard-row-k">IATA</span><span class="xcard-row-v">'.$iata.'</span></div>':'').($icao?'<div class="xcard-row"><span class="xcard-row-k">ICAO</span><span class="xcard-row-v">'.$icao.'</span></div>':'').($callsign?'<div class="xcard-row"><span class="xcard-row-k">Callsign</span><span class="xcard-row-v">'.$callsign.'</span></div>':'').'</div><div class="xcard-sec"><div class="xcard-sec-title">LOCATION</div><div class="xcard-row"><span class="xcard-row-k">Country</span><span class="xcard-row-v">'.$countryFlagHtml.$countryName.'</span></div>'.($cc?'<div class="xcard-row"><span class="xcard-row-k">Code</span><span class="xcard-row-v">'.e(strtoupper($cc)).'</span></div>':'').'</div><div class="xcard-sec"><div class="xcard-sec-title">OPERATIONS</div><div class="xcard-row"><span class="xcard-row-k">Status</span><span class="xcard-row-v">'.(ucfirst(e($sb))?:'Unknown').'</span></div>'.($fleet?'<div class="xcard-row"><span class="xcard-row-k">Fleet</span><span class="xcard-row-v">'.nfmt($fleet).' aircraft</span></div>':'').($hubs?'<div class="xcard-row"><span class="xcard-row-k">Hubs</span><span class="xcard-row-v">'.nfmt($hubs).'</span></div>':'').($destinations?'<div class="xcard-row"><span class="xcard-row-k">Destinations</span><span class="xcard-row-v">'.nfmt($destinations).'</span></div>':'').($destHtml?'<div style="margin-top:4px;border-top:1px solid var(--line);padding-top:6px">'.$destHtml.'</div>':'').'</div></div>'.$detailLink.'</div><div class="xcard-footer"><span class="xcard-hint">Click to expand</span><button class="xcard-expand-btn">+ Expand</button></div></article>';
    }
    if($card==='airport'){
        static $rwCache=[], $freqCache=[];
        if(!$rwCache){ try{ $rr=rows('SELECT icao_code,COUNT(*) AS cnt,MAX(length_ft) AS mx FROM airport_runways GROUP BY icao_code'); foreach($rr as $r2) $rwCache[$r2['icao_code']]=$r2; }catch(Throwable $e){} try{ $fr=rows('SELECT airport_ident,COUNT(*) AS cnt FROM airport_frequencies GROUP BY airport_ident'); foreach($fr as $f2) $freqCache[$f2['airport_ident']]=(int)$f2['cnt']; }catch(Throwable $e){} }
        $cc=strtolower($r['iso_country']??''); $flagHtml=$cc?((file_exists(__DIR__.'/../assets/country_flag_icons/'.$cc.'.svg')?'<img class="xcard-img" src="assets/country_flag_icons/'.$cc.'.svg" alt="">':'<span style="font-size:28px">'.flag_emoji($cc).'</span>')):'';
        $ident=e($r['ident']??''); $gps=e($r['gps_code']??'');
        $rw=$ident?($rwCache[$ident]??[]):[]; $rwCnt=(int)($rw['cnt']??0); $rwMx=$rw['mx']??null; $rwMxF=$rwMx?nfmt($rwMx).'ft':'';
        $freqCnt=$ident?($freqCache[$ident]??0):0;
        $iata=e($r['iata_code']??''); $type=e($r['type']??'Airport'); $muni=e($r['municipality']??''); $elev=$r['elevation_ft']??''; $elevF=$elev!==''?nfmt($elev).' ft':'';
        $continent=e($r['continent']??''); $name=e($title);
        return '<article class="xcard" data-xs="'.strtolower($name.' '.$iata.' '.$gps.' '.$ident.' '.$muni).'" data-xf="'.e($r['type']??'').'"><div class="xcard-top">'.$flagHtml.'<span class="chip">'.$type.'</span></div><h3 class="xcard-name">'.$name.'</h3><div class="xcard-summary"><div class="xcard-stat"><span class="xcard-stat-l">CODES</span><strong class="xcard-stat-v">'.trim("$iata / $gps / $ident",' /').'</strong></div>'.($muni?'<div class="xcard-stat"><span class="xcard-stat-l">LOCATION</span><strong class="xcard-stat-v">'.$muni.'</strong></div>':'').($elevF?'<div class="xcard-stat"><span class="xcard-stat-l">ELEVATION</span><strong class="xcard-stat-v">'.$elevF.'</strong></div>':'').($rwCnt?'<div class="xcard-stat"><span class="xcard-stat-l">RUNWAYS</span><strong class="xcard-stat-v">'.nfmt($rwCnt).($rwMxF?' <span class="xcard-def-note">(longest: '.$rwMxF.')</span>':'').'</strong></div>':'').'</div><div class="xcard-expand" style="display:none"><div class="xcard-sections"><div class="xcard-sec"><div class="xcard-sec-title">IDENTITY</div><div class="xcard-row"><span class="xcard-row-k">Name</span><span class="xcard-row-v">'.$name.'</span></div>'.($iata?'<div class="xcard-row"><span class="xcard-row-k">IATA</span><span class="xcard-row-v">'.$iata.'</span></div>':'').($gps?'<div class="xcard-row"><span class="xcard-row-k">GPS</span><span class="xcard-row-v">'.$gps.'</span></div>':'').($ident?'<div class="xcard-row"><span class="xcard-row-k">Ident</span><span class="xcard-row-v">'.$ident.'</span></div>':'').'<div class="xcard-row"><span class="xcard-row-k">Type</span><span class="xcard-row-v">'.e($r['type']??'—').'</span></div></div><div class="xcard-sec"><div class="xcard-sec-title">LOCATION</div><div class="xcard-row"><span class="xcard-row-k">Country</span><span class="xcard-row-v">'.e($r['iso_country']??'—').'</span></div>'.($muni?'<div class="xcard-row"><span class="xcard-row-k">Municipality</span><span class="xcard-row-v">'.$muni.'</span></div>':'').($continent?'<div class="xcard-row"><span class="xcard-row-k">Continent</span><span class="xcard-row-v">'.$continent.'</span></div>':'').($elevF?'<div class="xcard-row"><span class="xcard-row-k">Elevation</span><span class="xcard-row-v">'.$elevF.'</span></div>':'').'</div>'.($rwCnt||$freqCnt?'<div class="xcard-sec"><div class="xcard-sec-title">FACILITIES</div>'.($rwCnt?'<div class="xcard-row"><span class="xcard-row-k">Runways</span><span class="xcard-row-v">'.nfmt($rwCnt).($rwMxF?' (longest: '.$rwMxF.')':'').'</span></div>':'').($freqCnt?'<div class="xcard-row"><span class="xcard-row-k">Frequencies</span><span class="xcard-row-v">'.nfmt($freqCnt).'</span></div>':'').'</div>':'').'</div>'.$detailLink.'</div><div class="xcard-footer"><span class="xcard-hint">Click to expand</span><button class="xcard-expand-btn">+ Expand</button></div></article>';
    }
    if($card==='aircraft_type'){
        $model=e($r['model'] ?? $title ?? 'Aircraft Type'); $maker=e($r['manufacturer'] ?? ''); $type=e($r['type'] ?? 'Type');
        $iata=e($r['iata_code'] ?? ''); $icao=e($r['icao_code'] ?? ''); $engine=e($r['engine_type'] ?? ''); $wtc=e($r['wtc'] ?? '');
        $codes=trim(($iata?'IATA '.$iata:'').' '.($icao?'ICAO '.$icao:''));
        $acCardImg='';
        $mfrLogo=e(manufacturer_logo_url($r['manufacturer']??''));
        if($mfrLogo) $acCardImg='<img class="xcard-img" src="'.$mfrLogo.'" alt="'.$maker.'" loading="lazy" style="object-fit:contain;width:44px;height:44px">';
        else {
            static $acCardImgCache=[];
            if(!$acCardImgCache){ try{$acir=rows('SELECT icao_code,iata_code,primary_livery_url FROM aircraft_type_assets WHERE primary_livery_url IS NOT NULL AND primary_livery_url!=""'); foreach($acir as $aci){ $k=$aci['icao_code']?:$aci['iata_code']; if($k) $acCardImgCache[$k]=e($aci['primary_livery_url']); }}catch(Throwable $e){} }
            $imgUrl=$acCardImgCache[$icao]??$acCardImgCache[$iata]??'';
            if($imgUrl) $acCardImg='<img class="xcard-img" src="'.$imgUrl.'" alt="'.$model.'" loading="lazy" style="object-fit:cover;width:44px;height:44px">';
        }
        return '<article class="xcard" data-xs="'.strtolower($model.' '.$maker.' '.$iata.' '.$icao.' '.$type.' '.$engine).'" data-xf="'.strtolower($type).'"><div class="xcard-top">'.($acCardImg?:'<span class="iata-box">'.($icao?:($iata?:'TYPE')).'</span>').'<span class="chip gold">'.$type.'</span></div><h3 class="xcard-name">'.$model.'</h3><div class="xcard-summary"><div class="xcard-stat"><span class="xcard-stat-l">MAKER</span><strong class="xcard-stat-v">'.($maker?:'—').'</strong></div>'.($codes?'<div class="xcard-stat"><span class="xcard-stat-l">CODES</span><strong class="xcard-stat-v">'.$codes.'</strong></div>':'').($engine?'<div class="xcard-stat"><span class="xcard-stat-l">ENGINE</span><strong class="xcard-stat-v">'.$engine.'</strong></div>':'').($wtc?'<div class="xcard-stat"><span class="xcard-stat-l">WTC</span><strong class="xcard-stat-v">'.$wtc.'</strong></div>':'').'</div><div class="xcard-expand" style="display:none"><div class="xcard-sections"><div class="xcard-sec"><div class="xcard-sec-title">IDENTITY</div><div class="xcard-row"><span class="xcard-row-k">Model</span><span class="xcard-row-v">'.$model.'</span></div>'.($maker?'<div class="xcard-row"><span class="xcard-row-k">Manufacturer</span><span class="xcard-row-v">'.$maker.'</span></div>':'').($iata?'<div class="xcard-row"><span class="xcard-row-k">IATA</span><span class="xcard-row-v">'.$iata.'</span></div>':'').($icao?'<div class="xcard-row"><span class="xcard-row-k">ICAO</span><span class="xcard-row-v">'.$icao.'</span></div>':'').'</div><div class="xcard-sec"><div class="xcard-sec-title">TECHNICAL SNAPSHOT</div>'.($engine?'<div class="xcard-row"><span class="xcard-row-k">Engine</span><span class="xcard-row-v">'.$engine.'</span></div>':'').(($r['engine_count']??'')?'<div class="xcard-row"><span class="xcard-row-k">Engines</span><span class="xcard-row-v">'.e($r['engine_count']).'</span></div>':'').($wtc?'<div class="xcard-row"><span class="xcard-row-k">Wake</span><span class="xcard-row-v">'.$wtc.'</span></div>':'').'</div>'.(($r['description']??'')?'<div class="xcard-sec"><div class="xcard-sec-title">DESCRIPTION</div><div class="xcard-row"><span class="xcard-row-v xcard-desc">'.e($r['description']).'</span></div></div>':'').'</div>'.$detailLink.'</div><div class="xcard-footer"><span class="xcard-hint">Click to expand</span><button type="button" class="xcard-expand-btn">+ Expand</button></div></article>';
    }
    if($card==='country'){
        static $statsCache=[], $tsCache=[];
        if(!$statsCache){
            try{ $sr=rows('SELECT * FROM country_air_transport_stats'); foreach($sr as $s) $statsCache[$s['iso_alpha_2']]=$s; }catch(Throwable $e){}
            try{ $tr=rows('SELECT cts.* FROM country_time_series cts INNER JOIN (SELECT iso_alpha_2,MAX(year) my FROM country_time_series GROUP BY iso_alpha_2) lat ON lat.iso_alpha_2=cts.iso_alpha_2 AND lat.my=cts.year'); foreach($tr as $t) $tsCache[$t['iso_alpha_2']]=$t; }catch(Throwable $e){}
        }
        $cc=strtolower($r['iso_alpha_2']??''); $flagHtml=$cc?((file_exists(__DIR__.'/../assets/country_flag_icons/'.$cc.'.svg')?'<img class="xcard-img" src="assets/country_flag_icons/'.$cc.'.svg" alt="">':'<span style="font-size:28px">'.flag_emoji($cc).'</span>')):'';
        $s=$statsCache[$r['iso_alpha_2']??'']??[]; $t=$tsCache[$r['iso_alpha_2']??'']??[];
        $totalAirps=(int)($s['international_airports']??0)+(int)($s['domestic_airports']??0);
        $actAl=(int)($s['airlines_active']??0); $defAl=(int)($s['airlines_defunct']??0); $totalAl=(int)($s['airlines']??0);
        $regionRaw=$r['un_region']??$r['continent']??iso2_continent($r['iso_alpha_2']??''); $region=e(ucwords($regionRaw)); $capital=e($t['capital']??''); $lang=e($t['official_languages']??'');
        $currency=e(($t['currency_code']??'').($t['currency_name']?' ('.e($t['currency_name']).')':''));
        $gdp=$t['gdp_usd']??null; $gdpF=$gdp?'$'.nfmt($gdp):''; $pop=$t['population']??null; $popF=$pop?nfmt($pop):'';
        $area=$t['area_sq_km']??null; $areaF=$area?nfmt($area).' km²':'';
        $desc=e($r['description']??''); $iso2=e($r['iso_alpha_2']??''); $iso3=e($r['iso_alpha_3']??'');
        $dbCont=$r['continent']??''; $name=e($title?:$cfg['label']); $cont=strtolower(e($dbCont?:iso2_continent($r['iso_alpha_2']??'')));
        $emi=$cc?'<span style="font-size:22px;vertical-align:middle;margin-left:6px">'.flag_emoji($cc).'</span>':'';
        return '<article class="xcard" data-xs="'.strtolower($name.' '.$iso2.' '.$iso3.' '.$region.' '.$cont).'" data-xf="'.$cont.'"><div class="xcard-top">'.$flagHtml.'<span class="chip gold">'.$region.'</span></div><h3 class="xcard-name">'.$name.$emi.'</h3><div class="xcard-summary"><div class="xcard-stat"><span class="xcard-stat-l">ISO</span><strong class="xcard-stat-v">'.$iso2.' / '.$iso3.'</strong></div>'.($popF?'<div class="xcard-stat"><span class="xcard-stat-l">POPULATION</span><strong class="xcard-stat-v">'.$popF.'</strong></div>':'').($gdpF?'<div class="xcard-stat"><span class="xcard-stat-l">GDP</span><strong class="xcard-stat-v">'.$gdpF.'</strong></div>':'').($totalAirps?'<div class="xcard-stat"><span class="xcard-stat-l">AIRPORTS</span><strong class="xcard-stat-v">'.nfmt($totalAirps).'</strong></div>':'').($totalAl?'<div class="xcard-stat"><span class="xcard-stat-l">AIRLINES</span><strong class="xcard-stat-v">'.nfmt($actAl).($defAl?' <span class="xcard-def-note">(+'.nfmt($defAl).' defunct)</span>':'').'</strong></div>':'').'</div><div class="xcard-expand" style="display:none"><div class="xcard-sections">'.($region||$areaF||$capital?'<div class="xcard-sec"><div class="xcard-sec-title">GEOGRAPHY</div>'.($region?'<div class="xcard-row"><span class="xcard-row-k">Region</span><span class="xcard-row-v">'.$region.'</span></div>':'').($capital?'<div class="xcard-row"><span class="xcard-row-k">Capital</span><span class="xcard-row-v">'.$capital.'</span></div>':'').($areaF?'<div class="xcard-row"><span class="xcard-row-k">Area</span><span class="xcard-row-v">'.$areaF.'</span></div>':'').'</div>':'').($popF||$lang?'<div class="xcard-sec"><div class="xcard-sec-title">DEMOGRAPHICS</div>'.($popF?'<div class="xcard-row"><span class="xcard-row-k">Population</span><span class="xcard-row-v">'.$popF.'</span></div>':'').($lang?'<div class="xcard-row"><span class="xcard-row-k">Languages</span><span class="xcard-row-v">'.$lang.'</span></div>':'').'</div>':'').($gdpF||$currency?'<div class="xcard-sec"><div class="xcard-sec-title">ECONOMY</div>'.($gdpF?'<div class="xcard-row"><span class="xcard-row-k">GDP</span><span class="xcard-row-v">'.$gdpF.'</span></div>':'').($currency?'<div class="xcard-row"><span class="xcard-row-k">Currency</span><span class="xcard-row-v">'.$currency.'</span></div>':'').'</div>':'').($totalAirps||$totalAl?'<div class="xcard-sec"><div class="xcard-sec-title">AIR TRANSPORT</div>'.($totalAirps?'<div class="xcard-row"><span class="xcard-row-k">Airports</span><span class="xcard-row-v">International: '.nfmt((int)($s['international_airports']??0)).' · Domestic: '.nfmt((int)($s['domestic_airports']??0)).'</span></div>':'').($totalAl?'<div class="xcard-row"><span class="xcard-row-k">Airlines</span><span class="xcard-row-v">Active: '.nfmt($actAl).($defAl?' · Defunct: '.nfmt($defAl):'').'</span></div>':'').'</div>':'').($desc?'<div class="xcard-sec"><div class="xcard-sec-title">ABOUT</div><div class="xcard-row"><span class="xcard-row-v xcard-desc">'.$desc.'</span></div></div>':'').'</div>'.$detailLink.'</div><div class="xcard-footer"><span class="xcard-hint">Click to expand</span><button class="xcard-expand-btn">+ Expand</button></div></article>';
    }
    if($card==='aircraft'){
        $cc=strtolower($r['country_code']??''); $flagHtml=$cc?((file_exists(__DIR__.'/../assets/country_flag_icons/'.$cc.'.svg')?'<img class="xcard-img" src="assets/country_flag_icons/'.$cc.'.svg" alt="">':'<span style="font-size:28px">'.flag_emoji($cc).'</span>')):'';
        $stat=e($r['record_status']??''); $statusChip=$stat?'<span class="chip">'.$stat.'</span>':'';
        $reg=e($r['registration']??''); $acType=e($r['aircraft_type']??''); $tc=e($r['type_code']??'');
        $icao=e($r['icao_code']??''); $opName=e($r['operator_name']??''); $opIcao=e($r['operator_icao']??'');
        $cnum=e($r['construction_number']??''); $adshex=e($r['adshex']??''); $age=e($r['age']??''); $ageF=$age!==''?$age:'';
        $name=$reg;
        return '<article class="xcard" data-xs="'.strtolower($reg.' '.$acType.' '.$tc.' '.$icao.' '.$opName.' '.$opIcao).'" data-xf="'.strtolower($stat).'"><div class="xcard-top">'.$flagHtml.$statusChip.'</div><h3 class="xcard-name">'.$name.'</h3><div class="xcard-summary"><div class="xcard-stat"><span class="xcard-stat-l">TYPE</span><strong class="xcard-stat-v">'.$acType.($tc?' ('.$tc.')':'').'</strong></div>'.($opName?'<div class="xcard-stat"><span class="xcard-stat-l">OPERATOR</span><strong class="xcard-stat-v">'.$opName.'</strong></div>':'').($age?'<div class="xcard-stat"><span class="xcard-stat-l">AGE</span><strong class="xcard-stat-v">'.$ageF.' yrs</strong></div>':'').($icao?'<div class="xcard-stat"><span class="xcard-stat-l">ICAO TYPE</span><strong class="xcard-stat-v">'.$icao.'</strong></div>':'').'</div><div class="xcard-expand" style="display:none"><div class="xcard-sections"><div class="xcard-sec"><div class="xcard-sec-title">IDENTITY</div><div class="xcard-row"><span class="xcard-row-k">Registration</span><span class="xcard-row-v">'.$reg.'</span></div>'.($icao?'<div class="xcard-row"><span class="xcard-row-k">ICAO</span><span class="xcard-row-v">'.$icao.'</span></div>':'').($acType?'<div class="xcard-row"><span class="xcard-row-k">Type</span><span class="xcard-row-v">'.$acType.'</span></div>':'').($tc?'<div class="xcard-row"><span class="xcard-row-k">Type Code</span><span class="xcard-row-v">'.$tc.'</span></div>':'').'</div><div class="xcard-sec"><div class="xcard-sec-title">DETAILS</div>'.($cnum?'<div class="xcard-row"><span class="xcard-row-k">MSN/CN</span><span class="xcard-row-v">'.$cnum.'</span></div>':'').($adshex?'<div class="xcard-row"><span class="xcard-row-k">ADS-B Hex</span><span class="xcard-row-v">'.$adshex.'</span></div>':'').($ageF?'<div class="xcard-row"><span class="xcard-row-k">Age</span><span class="xcard-row-v">'.$ageF.' years</span></div>':'').'</div>'.($opName||$opIcao?'<div class="xcard-sec"><div class="xcard-sec-title">OPERATOR</div>'.($opName?'<div class="xcard-row"><span class="xcard-row-k">Name</span><span class="xcard-row-v">'.$opName.'</span></div>':'').($opIcao?'<div class="xcard-row"><span class="xcard-row-k">ICAO</span><span class="xcard-row-v">'.$opIcao.'</span></div>':'').'<div class="xcard-row"><span class="xcard-row-k">Country</span><span class="xcard-row-v">'.e($r['country_code']??'—').'</span></div></div>':'').($stat?'<div class="xcard-sec"><div class="xcard-sec-title">STATUS</div><div class="xcard-row"><span class="xcard-row-v">'.$stat.'</span></div></div>':'').'</div>'.$detailLink.'</div><div class="xcard-footer"><span class="xcard-hint">Click to expand</span><button class="xcard-expand-btn">+ Expand</button></div></article>';
    }
    return '<article class="record-card" onclick="location.href=\''.e($url).'\'"><div class="record-top"><span class="chip">'.e($cfg['label']).'</span></div><h3>'.e($title ?: $cfg['label']).'</h3><p>'.e($sub).'</p><a class="btn small primary" href="'.e($url).'">View Record</a></article>';
}
function module_page_copy(string $key, array $cfg, int $total): array {
    $copy=[
        'countries'=>['Countries','Compare aviation markets by geography, economy and air-transport footprint.','Search or filter the cards, click a country to reveal a structured preview, then log in to open the full detail page.'],
        'airlines'=>['Airlines','Browse operators, codes, status, country and operational clues in one consistent airline profile grid.','Click any airline card to expand the preview. Logged-in users can continue into full fleet, route, commercial and regulatory tabs.'],
        'airports'=>['Airports','Explore airport records by code, city, type, elevation and linked infrastructure.','Start with search/filter, expand a card for a quick briefing, then open the record for runways, terminals, frequencies and hub data.'],
        'aircraft'=>['Aircraft Registry','Preview aircraft registrations, operators, type codes and age signals.','Visitors can inspect the card preview; full aircraft registry detail opens after login or as configured by Admin.'],
        'aircraft_types'=>['Aircraft Types','Scan models, manufacturers, IATA/ICAO codes and technical hints using the same card experience as airlines and countries.','Expand a type for a technical preview. Economics, lease rates and generated reports can be locked to Pro from Admin.'],
    ];
    $fallback=[$cfg['label'] ?? 'Dataset','Browse this aviation dataset through searchable cards and clean table views.','Use search and filters first. Expand a card or open a record when you need deeper detail.'];
    return $copy[$key] ?? $fallback;
}
function render_xcard_page(string $key, array $cfg, array $records, int $total, array $filterOpts = [], string $extraToolbarHtml = ''): string {
    [$title,$sub,$hint]=module_page_copy($key,$cfg,$total);
    $label = strtolower((string)($cfg['label'] ?? 'records'));
    $countLabel = nfmt($total).' '.$label;
    $tierRule = access_rule('module',$key,normalize_tier_code($cfg['tier'] ?? 'free'));
    $html  = '<section class="dataset-hero dataset-hero--'.e($key).'"><div><div class="eyebrow">'.e($cfg['tier']==='free'?'Open aviation database':'Controlled aviation database').'</div><h1>'.e($title).'</h1><p>'.e($sub).'</p><div class="page-nudge"><i class="fas fa-hand-pointer"></i><span>'.e($hint).'</span></div></div><aside><span class="dataset-total">'.e($countLabel).'</span><small>Current access: '.e(ucfirst(normalize_tier_code($tierRule['min_tier'] ?? 'free'))).'</small></aside></section>';
    $isCountries=$key==='countries';
    $isAirlines=$key==='airlines';
    $html .= '<div class="xcard-controls">';
    if($extraToolbarHtml){
        $html .= $extraToolbarHtml;
    } elseif($isCountries){
        try{
            $allCountries=rows('SELECT iso_alpha_2,name_common FROM countries ORDER BY name_common ASC');
            $html .= '<div class="xcard-search-wrap">'
                   . '<select class="xcard-search xcard-jump" onchange="if(this.value)location.href=\'?page=detail&amp;module=countries&amp;id=\'+this.value">'
                   . '<option value="">Jump to country...</option>';
            foreach($allCountries as $c) $html .= '<option value="'.e($c['iso_alpha_2']).'">'.e($c['name_common']).'</option>';
            $html .= '</select></div>';
        }catch(Throwable $e){}
    } else {
        $html .= '<div class="xcard-search-wrap">'
               . '<svg style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:var(--muted);pointer-events:none" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>'
               . '<input type="text" class="xcard-search" placeholder="Search '.e($cfg['label']).'..." autocomplete="off"></div>';
    }
    if($filterOpts && !$extraToolbarHtml){
        $html .= '<div class="xcard-filter-row">'
               . '<button type="button" class="xcard-filter active" data-f="all">ALL</button>';
        foreach($filterOpts as $val => $text) $html .= '<button type="button" class="xcard-filter" data-f="'.e($val).'">'.e($text).'</button>';
        $html .= '</div>';
    }
    $html .= '<span class="xcard-count" data-total="'.(int)$total.'">'.e($countLabel).'</span></div>'
           . '<div class="xgrid">'.render_module_cards($key,$records).'</div>'
           . '<div class="xcard-empty">No '.e($label).' match your '.($extraToolbarHtml||$isCountries?'filter':'search').'. Try a broader keyword or reset filters.</div>';
    if($extraToolbarHtml){
        $html .= '<script>
(function(){var g=document.querySelector(".xgrid"),e=document.querySelector(".xcard-empty"),c=document.querySelector(".xcard-count"),ca=g?g.querySelectorAll(".xcard"):[],total=c?c.dataset.total:"0",label="'.addslashes($label).'";
function rt(cd){var b=cd.querySelector(".xcard-expand-btn");if(b)b.textContent="+ Expand";var h=cd.querySelector(".xcard-hint");if(h)h.textContent="Click to expand"}
function cl(){ca.forEach(function(x){x.classList.remove("expanded");rt(x)})}
ca.forEach(function(cd){cd.addEventListener("click",function(ev){if(ev.target.closest("a"))return;if(ev.target.closest(".xcard-expand-btn"))ev.preventDefault();var w=this.classList.contains("expanded");cl();if(!w){this.classList.add("expanded");var b=this.querySelector(".xcard-expand-btn");if(b)b.textContent="- Collapse";var h=this.querySelector(".xcard-hint");if(h)h.textContent="Preview open";this.scrollIntoView({behavior:"smooth",block:"nearest"})}})});
})();
</script>';
    } elseif($isCountries){
        $html .= '<script>
(function(){var g=document.querySelector(".xgrid"),e=document.querySelector(".xcard-empty"),c=document.querySelector(".xcard-count"),ca=g?g.querySelectorAll(".xcard"):[],f=document.querySelectorAll(".xcard-filter"),total=c?c.dataset.total:"0",label="'.addslashes($label).'";
function rt(cd){var b=cd.querySelector(".xcard-expand-btn");if(b)b.textContent="+ Expand";var h=cd.querySelector(".xcard-hint");if(h)h.textContent="Click to expand"}
function cl(){ca.forEach(function(x){x.classList.remove("expanded");rt(x)})}
ca.forEach(function(cd){cd.addEventListener("click",function(ev){if(ev.target.closest("a"))return;if(ev.target.closest(".xcard-expand-btn"))ev.preventDefault();var w=this.classList.contains("expanded");cl();if(!w){this.classList.add("expanded");var b=this.querySelector(".xcard-expand-btn");if(b)b.textContent="- Collapse";var h=this.querySelector(".xcard-hint");if(h)h.textContent="Preview open";this.scrollIntoView({behavior:"smooth",block:"nearest"})}})});
function u(){var v=0;ca.forEach(function(cd){if(cd.style.display!=="none")v++});if(c)c.textContent=v+" shown of "+total+" "+label;if(e)e.style.display=v===0?"block":"none"}
f.forEach(function(b){b.addEventListener("click",function(){f.forEach(function(x){x.classList.remove("active")});this.classList.add("active");var ff=this.dataset.f;cl();ca.forEach(function(cd){cd.style.display=(ff==="all"||!cd.dataset.xf||(cd.dataset.xf||"").toLowerCase()===ff)?"":"none"});u()})});
})();
</script>';
    } else {
        $html .= '<script>
(function(){var g=document.querySelector(".xgrid"),s=document.querySelector(".xcard-search"),e=document.querySelector(".xcard-empty"),c=document.querySelector(".xcard-count"),ca=g?g.querySelectorAll(".xcard"):[],f=document.querySelectorAll(".xcard-filter"),t,total=c?c.dataset.total:"0",label="'.addslashes($label).'";
function rt(cd){var b=cd.querySelector(".xcard-expand-btn");if(b)b.textContent="+ Expand";var h=cd.querySelector(".xcard-hint");if(h)h.textContent="Click to expand"}
function cl(){ca.forEach(function(x){x.classList.remove("expanded");rt(x)})}
ca.forEach(function(cd){cd.addEventListener("click",function(ev){if(ev.target.closest("a"))return;if(ev.target.closest(".xcard-expand-btn"))ev.preventDefault();var w=this.classList.contains("expanded");cl();if(!w){this.classList.add("expanded");var b=this.querySelector(".xcard-expand-btn");if(b)b.textContent="- Collapse";var h=this.querySelector(".xcard-hint");if(h)h.textContent="Preview open";this.scrollIntoView({behavior:"smooth",block:"nearest"})}})});
function u(){var v=0;ca.forEach(function(cd){if(cd.style.display!=="none")v++});if(c)c.textContent=v+" shown of "+total+" "+label;if(e)e.style.display=v===0?"block":"none"}
f.forEach(function(b){b.addEventListener("click",function(){f.forEach(function(x){x.classList.remove("active")});this.classList.add("active");var ff=this.dataset.f;cl();ca.forEach(function(cd){cd.style.display=(ff==="all"||!cd.dataset.xf||(cd.dataset.xf||"").toLowerCase()===ff)?"":"none"});u()})});
if(s)s.addEventListener("input",function(){clearTimeout(t);t=setTimeout(function(){var q=this.value.trim().toLowerCase();cl();ca.forEach(function(cd){cd.style.display=(cd.dataset.xs&&cd.dataset.xs.indexOf(q)!==-1)?"":"none"});u()}.bind(this),150)});
})();
</script>';
    }
    return $html;
}
function render_table(array $rows, array $columns, ?string $moduleKey=null): string {
    if(!$rows) return '<div class="empty-state"><h3>No matching records</h3><p>Try another search or add records from Admin.</p></div>';
    $pk=$moduleKey?module_pk($moduleKey):'id'; $html='<div class="table-wrap"><table><thead><tr>'; foreach($columns as $c) $html.='<th>'.e(public_field_label($c)).'</th>'; if($moduleKey) $html.='<th>Action</th>'; $html.='</tr></thead><tbody>';
    foreach($rows as $r){ $id=$r[$pk] ?? $r['id'] ?? $r['code'] ?? 0; $html.='<tr>'; foreach($columns as $c) $html.='<td>'.display_value($r[$c] ?? null).'</td>'; if($moduleKey) $html.='<td><a class="btn mini" href="'.e(detail_url($moduleKey,$id)).'">Open</a></td>'; $html.='</tr>'; }
    return $html.'</tbody></table></div>';
}

function render_admin_record_table(array $rows, array $columns, string $moduleKey): string {
    if(!$rows) return '<div class="empty-state"><h3>No matching records</h3><p>Use Add record or Import CSV to populate this module.</p></div>';
    $pk=module_pk($moduleKey); $html='<div class="table-wrap"><table><thead><tr>'; foreach($columns as $c) $html.='<th>'.e(public_field_label($c)).'</th>'; $html.='<th>Admin actions</th></tr></thead><tbody>';
    foreach($rows as $r){ $id=$r[$pk] ?? $r['id'] ?? $r['code'] ?? 0; $html.='<tr>'; foreach($columns as $c) $html.='<td>'.display_value($r[$c] ?? null).'</td>'; $html.='<td><a class="btn mini" href="?page=admin&tab=edit&module='.e($moduleKey).'&id='.e((string)$id).'">Edit</a> <a class="btn mini ghost" href="'.e(detail_url($moduleKey,$id)).'">Preview</a></td></tr>'; }
    return $html.'</tbody></table></div>';
}

function render_detail_fields(array $cfg,array $r,bool $admin=false): string {
    $fields=$cfg['detail'] ?? array_keys($r); $explicit=isset($cfg['detail']); $html='<div class="detail-grid">';
    $moduleKey=module_key_for_cfg($cfg) ?: '';
    foreach($fields as $f){
        if(!$admin && !$explicit && is_internal_field($f)) continue;
        $locked=(!$admin && $moduleKey && !field_allowed($moduleKey,$f,'free'));
        $html.='<div class="detail-item '.($locked?'locked-field':'').'"><small>'.e(public_field_label($f)).'</small>';
        if($locked) $html.='<strong><i class="fas fa-lock"></i> Pro field</strong><em>Admin controls this field from Tier Visibility.</em>';
        else $html.='<strong>'.display_value($r[$f] ?? null).'</strong>';
        $html.='</div>';
    }
    return $html.'</div>';
}
function render_related_sections(string $key,array $r): string {
    $html='';
    if($key==='airlines'){
        $iata=$r['iata_code'] ?? ''; $icao=$r['icao_code'] ?? ''; $name=$r['name'] ?? '';
        $cc=$r['country_code'] ?? '';
        $html.=related_table('Digital properties', 'SELECT category,platform,url_or_handle,is_primary FROM airline_digital_properties WHERE iata_code=? OR icao_code=? OR airline_name=? LIMIT 20', [$iata,$icao,$name]);
        $html.=related_table('Fleet list', "SELECT registration,aircraft_model,aircraft_subtype,delivery_date,current_status FROM airline_fleet_list WHERE operator_airline=? OR operator_airline LIKE ? LIMIT 20", [$name,"%$name%"]);
        $html.=related_table('Fleet summary', 'SELECT aircraft_type,aircraft_count,configuration_lopa,average_age,engine_type FROM airline_fleet_summary WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('Hubs and bases', 'SELECT airport_code,hub_type,region_served,description FROM airline_hubs WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('IT infrastructure', "SELECT system_category,system_name,provider,description FROM airline_it_infrastructure WHERE iata_code=? OR icao_code=? LIMIT 20", [$iata,$icao]);
        $html.=related_table('Key personnel', "SELECT person_name,title,category,email FROM airline_key_personnel WHERE iata_code=? OR icao_code=? LIMIT 20", [$iata,$icao]);
        $html.=related_table('Operational stats', "SELECT stat_year,pax_count,cargo_volume,revenue,staff_count FROM airline_operational_stats WHERE iata_code=? OR icao_code=? ORDER BY stat_year DESC LIMIT 10", [$iata,$icao]);
        $html.=related_table('Frequent flyer', 'SELECT program_name,points_unit,notes FROM frequent_flyer_programs WHERE airline_code=? OR iata_code=? OR icao_code=? OR airline_name=? LIMIT 10', [$iata,$iata,$icao,$name]);
        $html.=related_table('IATA membership', "SELECT membership_status,membership_type,joined_date,ended_date FROM airline_iata_membership WHERE iata_code=? OR icao_code=? OR airline_name=? LIMIT 5", [$iata,$icao,$name]);
        $html.=related_table('IOSA registration', "SELECT iosa_status,registration_number,valid_from,valid_until FROM airline_iosa_registration WHERE iata_code=? OR icao_code=? OR airline_name=? LIMIT 5", [$iata,$icao,$name]);
        $html.=related_table('Routes & schedules', "SELECT flight_number_prefix,service_type,status,start_date,end_date FROM airline_route_services WHERE airline_id IN (SELECT id FROM legacy_airlines WHERE icao_code=?) LIMIT 20", [$icao]);
        $html.=related_table('Destinations', "SELECT DISTINCT a.name, cf.destination_iata, a.municipality, a.iso_country FROM commercial_fares cf LEFT JOIN airports a ON a.iata_code=cf.destination_iata WHERE cf.airline_code=? OR cf.airline_code=? LIMIT 50", [$iata,$icao]);
        if ($cc) {
            $html.=related_table('Regulatory', 'SELECT name,abbreviation,website FROM regulatory_authorities WHERE country_code=? LIMIT 10', [$cc]);
        }
    }
    if($key==='airports'){
        $iata=$r['iata_code'] ?? ''; $icao=$r['gps_code'] ?? $r['ident'] ?? '';
        $html.=related_table('Frequencies', 'SELECT frequency_type,frequency_mhz,description FROM airport_frequencies WHERE iata_code=? OR icao_code=? LIMIT 25', [$iata,$icao]);
        $html.=related_table('Runways', 'SELECT runway_ident,length_ft,width_ft,surface,lighting,ils_frequency FROM airport_runways WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('Terminals', 'SELECT terminal_type,terminal_name,capacity,facilities,gates_count FROM airport_terminals WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $html.=related_table('Hub/base airlines', 'SELECT airline_name,relation,destinations_served FROM airport_hubs_and_airlines WHERE iata_code=? OR icao_code=? LIMIT 20', [$iata,$icao]);
        $cc=$r['iso_country'] ?? $r['country_code'] ?? '';
        $html.=related_table('Navaids in country', 'SELECT ident,name,type,iso_country FROM navaids WHERE iso_country=? LIMIT 20', [$cc]);
        $html.=related_table('Connected navaids', "SELECT associated_airports,associated_airways,system_integration,interoperability_notes FROM navaid_connectivity WHERE associated_airports LIKE ? OR associated_airports LIKE ? LIMIT 20", ["%$iata%","%$icao%"]);
    }
    if($key==='aircraft_types'){
        $iata=$r['iata_code'] ?? ''; $icao=$r['icao_code'] ?? ''; $model=$r['model'] ?? '';
        $html.=related_table('Aircraft type profile', 'SELECT aircraft_name,country_of_origin,aircraft_role,powerplants,performance,weights,dimensions,capacity,production,history FROM aircraft_type_profile_data WHERE aircraft_name=? OR aircraft_name LIKE ? LIMIT 5', [$model,"%$model%"]);
        $html.=related_table('Cabin & payload', 'SELECT typical_c_seats,typical_y_seats,max_capacity,cargo_volume_m3,max_payload_kg FROM aircraft_type_cabin_payload WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Engine data', 'SELECT engine_variants,engine_type,engine_count,thrust_per_engine_kn,fuel_burn_rate,saf_compatible FROM aircraft_type_engine_data WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Runway requirements', 'SELECT min_takeoff_length_ft,min_landing_length_ft,surface_compatibility FROM aircraft_type_runway_requirements WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Technical specs', 'SELECT mtow_kg,mzfw_kg,empty_weight_kg,wingspan_m,length_m,height_m FROM aircraft_type_technical_specs WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Economics', 'SELECT list_price_usd,op_cost_per_hour,lease_rate_monthly,residual_value_trend FROM aircraft_type_economic_data WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
        $html.=related_table('Environmental data', 'SELECT carbon_intensity,noise_chapter,fuel_type FROM aircraft_type_environmental_data WHERE iata_code=? OR icao_code=? LIMIT 5', [$iata,$icao]);
    }
    if($key==='countries'){
        $cc=$r['iso_alpha_2'] ?? '';
        try{$airlines=rows('SELECT name,iata_code,icao_code,active FROM airlines WHERE country_code=? LIMIT 20',[$cc]);}catch(Throwable $e){$airlines=[];}
        if($airlines){
            $html.='<section class="related"><h3>Airlines in country</h3><div class="table-wrap"><table><thead><tr><th>Name</th><th>IATA</th><th>ICAO</th><th>Status</th></tr></thead><tbody>';
            foreach($airlines as $a){
                $icao=$a['icao_code']??'';
                $nameLink=$icao?'<a href="?page=detail&module=airlines&id='.e($icao).'">'.e($a['name']??'').'</a>':e($a['name']??'');
                $status=$a['active']==='Y'?'<span class="chip ok">Active</span>':($a['active']==='N'?'<span class="chip danger">Defunct</span>':e($a['active']??'—'));
                $html.='<tr><td>'.$nameLink.'</td><td>'.e($a['iata_code']??'—').'</td><td>'.e($icao).'</td><td>'.$status.'</td></tr>';
            }
            $html.='</tbody></table></div></section>';
        }
        $html.=related_table('Airports in country', 'SELECT name,iata_code,gps_code,type,elevation_ft FROM airports WHERE iso_country=? LIMIT 20', [$cc]);
        $html.=related_table('Regulatory authorities', 'SELECT name,abbreviation,website,icao_caa_link,wikipedia_url,official_register_link FROM regulatory_authorities WHERE country_code=? LIMIT 20', [$cc]);
        $html.=related_table('Aircraft registry', "SELECT registration,aircraft_type,type_code,operator_name,age FROM aircraft_registrations WHERE country_code=? LIMIT 20", [$cc]);
        $html.=related_table('Navaids', 'SELECT ident,name,type,iso_country FROM navaids WHERE iso_country=? LIMIT 20', [$cc]);
    }
    return $html;
}
function related_table(string $title,string $sql,array $params): string { try{$rs=rows($sql,$params);}catch(Throwable $e){return '';} if(!$rs) return ''; return '<section class="related"><h3>'.e($title).'</h3>'.render_table($rs,array_keys($rs[0]),null).'</section>'; }

function run_insight_query(string $key): array {
    try {
    switch($key){
        case 'oldest_aircraft': return rows("SELECT registration label, CONCAT(COALESCE(aircraft_type,'Unknown'),' · ',COALESCE(operator_name,operator_icao,'Unknown')) detail, ROUND(age,1) value FROM aircraft_registrations WHERE age IS NOT NULL AND age>0 ORDER BY age DESC LIMIT 8");
        case 'highest_airports': return rows("SELECT name label, CONCAT(COALESCE(municipality,''),' · ',COALESCE(iso_country,'')) detail, elevation_ft value FROM airports WHERE elevation_ft IS NOT NULL ORDER BY elevation_ft DESC LIMIT 8");
        case 'smallest_airlines_capacity': return rows("SELECT name label, CONCAT(COALESCE(country_code,''),' · ',COALESCE(callsign,'')) detail, 1 value FROM airlines WHERE status_bucket='active' ORDER BY name ASC LIMIT 8");
        case 'routes_with_competition': return rows("SELECT COALESCE(flight_number_prefix,'Route') label, COALESCE(service_type,'Service') detail, COUNT(*) value FROM airline_route_services GROUP BY route_market_id HAVING COUNT(*)>1 ORDER BY value DESC LIMIT 8");
        case 'dataset_coverage': return rows("SELECT COALESCE(category,'Other') label, CONCAT(COUNT(*),' files') detail, COALESCE(SUM(row_count),0) value FROM dataset_files GROUP BY category ORDER BY value DESC LIMIT 8");
        case 'regulatory_depth': return rows("SELECT COALESCE(c.name_common,r.country_code) label, 'Regulatory records' detail, COUNT(*) value FROM regulatory_authorities r LEFT JOIN countries c ON c.iso_alpha_2=r.country_code GROUP BY r.country_code,c.name_common ORDER BY value DESC LIMIT 8");
        case 'short_runway_aircraft': return rows("SELECT COALESCE(at.model, rr.icao_code) label, CONCAT('Landing ', COALESCE(rr.min_landing_length_ft,'—'), ' ft') detail, rr.min_takeoff_length_ft value FROM aircraft_type_runway_requirements rr LEFT JOIN legacy_aircraft_types at ON at.icao_code=rr.icao_code WHERE rr.min_takeoff_length_ft IS NOT NULL AND rr.min_takeoff_length_ft>0 ORDER BY rr.min_takeoff_length_ft ASC LIMIT 8");
        case 'navaid_coverage': return rows("SELECT COALESCE(c.name_common,n.iso_country) label, 'Navaids' detail, COUNT(*) value FROM navaids n LEFT JOIN countries c ON c.iso_alpha_2=n.iso_country GROUP BY n.iso_country,c.name_common ORDER BY value DESC LIMIT 8");
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
        case 'regulatory_by_country': return rows("SELECT COALESCE(c.name_common,r.country_code) country, COUNT(*) regulatory_authorities FROM regulatory_authorities r LEFT JOIN countries c ON c.iso_alpha_2=r.country_code GROUP BY r.country_code,c.name_common ORDER BY regulatory_authorities DESC LIMIT 30");
        case 'hub_airlines': return rows("SELECT airport_code, iata_code, icao_code, hub_type, region_served FROM airline_hubs ORDER BY airport_code LIMIT 30");
        case 'short_runway_aircraft': return rows("SELECT at.model, rr.iata_code, rr.icao_code, rr.min_takeoff_length_ft, rr.min_landing_length_ft, rr.surface_compatibility FROM aircraft_type_runway_requirements rr LEFT JOIN legacy_aircraft_types at ON at.icao_code=rr.icao_code WHERE rr.min_takeoff_length_ft IS NOT NULL ORDER BY rr.min_takeoff_length_ft ASC LIMIT 30");
        case 'saf_compatible_aircraft': return rows("SELECT at.model, ed.iata_code, ed.icao_code, ed.engine_type, ed.engine_variants, ed.saf_compatible FROM aircraft_type_engine_data ed LEFT JOIN legacy_aircraft_types at ON at.icao_code=ed.icao_code WHERE LOWER(COALESCE(ed.saf_compatible,'')) LIKE '%yes%' OR LOWER(COALESCE(ed.saf_compatible,'')) LIKE '%true%' LIMIT 30");
        case 'sources_to_review': return rows("SELECT entity_type, entity_id, field_name, old_value, new_value, changed_at, change_source FROM entity_change_log ORDER BY changed_at DESC LIMIT 30");
    }} catch(Throwable $e){ return []; }
    return [];
}

function handle_post_actions(): void {
    if(($_SERVER['REQUEST_METHOD'] ?? 'GET') !== 'POST') return; verify_csrf(); $action=postv('action');
    if($action==='login'){ $attempts=(int)($_SESSION['login_attempts'] ?? 0); if($attempts>5) { usleep(3000000); flash('error','Too many attempts. Try again later.'); redirect_to('?page=login'); } if($attempts>0) usleep($attempts*200000); if(login_user(postv('email'),postv('password'))){$_SESSION['login_attempts']=0;flash('success','Logged in.'); redirect_to('?page=dashboard');} $_SESSION['login_attempts']=$attempts+1; flash('error','Invalid email or password.'); redirect_to('?page=login'); }
    if($action==='register'){ [$ok,$msg]=register_user(postv('name'),postv('email'),postv('password')); flash($ok?'success':'error',$msg); redirect_to($ok?'?page=dashboard':'?page=register'); }
    if($action==='update_account' && is_logged_in()){ exec_sql('UPDATE users SET name=?, updated_at=NOW() WHERE id=?',[postv('name'),(int)current_user()['id']]); flash('success','Account updated.'); redirect_to('?page=account'); }
    if($action==='submit_report'){ handle_submit_report(); return; }
    if(!is_admin()) return;
    if($action==='admin_save_record') { admin_save_record(); }
    if($action==='admin_delete_record') { admin_delete_record(); }
    if($action==='admin_save_user') { admin_save_user(); }
    if($action==='admin_save_tier') { admin_save_tier(); }
    if($action==='admin_save_feature') { admin_save_feature(); }
    if($action==='admin_save_access_rule') { admin_save_access_rule(); }
    if($action==='admin_delete_access_rule') { admin_delete_access_rule(); }
    if($action==='admin_delete_feature') { admin_delete_feature(); }
    if($action==='admin_save_question') { admin_save_question(); }
    if($action==='admin_save_insight') { admin_save_insight(); }
    if($action==='admin_update_staging') { admin_update_staging(); }
    if($action==='admin_update_task') { exec_sql('UPDATE admin_tasks SET status=?, updated_at=NOW() WHERE id=?',[postv('status'),(int)postv('task_id')]); flash('success','Task updated.'); redirect_to('?page=admin&tab=tasks'); }
    if($action==='admin_import_csv') { admin_import_csv(); }
    if($action==='pipeline_add_source') { pipeline_add_source(); }
    if($action==='pipeline_run_source') { pipeline_run_source(); }
    if($action==='pipeline_approve_run') { pipeline_approve_run(); }
    if($action==='pipeline_reject_run') { pipeline_reject_run(); }
    if($action==='pipeline_approve_staging') { pipeline_approve_staging(); }
    if($action==='pipeline_reject_staging') { pipeline_reject_staging(); }
    if($action==='run_backup') {
        $pass = getenv('ANGANI_DB_PASS') ?: 'rootpassword';
        $root = realpath(__DIR__ . '/..');
        $output = shell_exec('ANGANI_DB_PASS=' . escapeshellarg($pass) . ' php ' . escapeshellarg($root . '/scripts/backup_engine.php') . ' 2>&1');
        flash('success', 'Backup completed.');
        redirect_to('?page=admin&tab=backup');
    }
    if($action==='delete_backups') {
        $root = realpath(__DIR__ . '/..');
        foreach (glob($root . '/angani_backup_*.zip') as $z) unlink($z);
        flash('success', 'Backup files deleted.');
        redirect_to('?page=admin&tab=backup');
    }
    if($action==='run_mirror_sync') {
        $pass = getenv('ANGANI_DB_PASS') ?: 'rootpassword';
        $root = realpath(__DIR__ . '/..');
        $output = shell_exec('ANGANI_DB_PASS=' . escapeshellarg($pass) . ' php ' . escapeshellarg($root . '/scripts/mirror_sync.php') . ' 2>&1');
        flash('success', 'Mirror sync triggered.');
        redirect_to('?page=admin&tab=mirror');
    }
    if($action==='sync_to_supabase') {
        $root = realpath(__DIR__ . '/..');
        $pass = getenv('ANGANI_DB_PASS') ?: 'rootpassword';
        $output = shell_exec('ANGANI_DB_PASS=' . escapeshellarg($pass) . ' php ' . escapeshellarg($root . '/scripts/sync_to_supabase.php') . ' 2>&1');
        // Parse output for state
        $state = ['last_sync' => date('Y-m-d H:i:s'), 'status' => 'ok', 'tables_synced' => 0, 'rows_synced' => 0, 'last_error' => ''];
        if (preg_match('/Created (\d+)\/\d+ tables/', $output, $m)) $state['tables_synced'] = (int)$m[1];
        if (preg_match('/(\d+) total rows/', $output, $m)) $state['rows_synced'] = (int)$m[1];
        if (preg_match('/FAIL/', $output)) { $state['status'] = 'error'; $state['last_error'] = 'Some tables failed. Check script output.'; }
        $stateDir = dirname($root . '/backups/supabase_sync_state.json');
        if (!is_dir($stateDir)) @mkdir($stateDir, 0755, true);
        file_put_contents($root . '/backups/supabase_sync_state.json', json_encode($state, JSON_PRETTY_PRINT));
        flash('success', 'Supabase sync completed: ' . $state['tables_synced'] . ' tables, ' . $state['rows_synced'] . ' rows.');
        redirect_to('?page=admin&tab=mirror');
    }
    if($action==='admin_update_report') {
        $id=(int)postv('report_id'); $status=postv('status'); $notes=postv('admin_notes'); $notify=(int)postv('notify_reporter');
        if(!in_array($status,['open','in_progress','resolved','dismissed'],true)) $status='open';
        exec_sql('UPDATE data_reports SET status=?, admin_notes=?, resolved_by=?, resolved_at=?, updated_at=NOW() WHERE id=?',[$status,$notes?:null,(int)current_user()['id'],$status==='resolved'||$status==='dismissed'?date('Y-m-d H:i:s'):null,$id]);
        if($notify){
            $r=row('SELECT * FROM data_reports WHERE id=?',[$id]);
            if($r && $r['contact_info']){
                $entityLabel=e($r['entity_type'] ?: 'data record');
                $subject='Angani Data — Your report about '.$entityLabel;
                $body="Hi,\n\nYour report about ".$entityLabel." has been marked as: ".strtoupper($status).".\n\n";
                if($notes) $body.="Admin notes: ".$notes."\n\n";
                $body.="Thank you for helping improve Angani Data.\n\n— Angani Team";
                send_email($r['contact_info'],$subject,$body);
            }
        }
        flash('success','Report updated.'); redirect_to('?page=admin&tab=data_reports');
    }
    if($action==='admin_save_email_provider') {
        $id=(int)postv('provider_id'); $name=postv('name'); $type=postv('provider_type'); $key=postv('api_key'); $secret=postv('api_secret'); $cfg=postv('config_json');
        $isActive=postv('is_active')==='1'?1:0; $isDefault=postv('is_default')==='1'?1:0;
        if($id>0) exec_sql('UPDATE email_providers SET name=?, provider_type=?, api_key=?, api_secret=?, config_json=?, is_active=?, is_default=?, updated_at=NOW() WHERE id=?',[$name,$type,$key?:null,$secret?:null,$cfg?:null,$isActive,$isDefault,$id]);
        else exec_sql('INSERT INTO email_providers (name,provider_type,api_key,api_secret,config_json,is_active,is_default) VALUES (?,?,?,?,?,?,?)',[$name,$type,$key?:null,$secret?:null,$cfg?:null,$isActive,$isDefault]);
        flash('success','Email provider saved.'); redirect_to('?page=admin&tab=email');
    }
    if($action==='admin_delete_email_provider') {
        exec_sql('DELETE FROM email_providers WHERE id=?',[(int)postv('provider_id')]);
        flash('success','Email provider deleted.'); redirect_to('?page=admin&tab=email');
    }
    if($action==='admin_test_email') {
        $to=postv('test_email'); if(!filter_var($to,FILTER_VALIDATE_EMAIL)){ flash('error','Enter a valid email address.'); redirect_to('?page=admin&tab=email'); }
        $ok=send_email($to,'Angani Data Test Email','This is a test message from Angani Data. If you received this, the email provider is working correctly.');
        flash($ok?'success':'error',$ok?'Test email sent. Check your inbox.':'Test email failed. Check provider configuration.');
        redirect_to('?page=admin&tab=email');
    }
}
function admin_save_record(): void {
    $key=postv('module'); $cfg=module_config($key); if(!$cfg) throw new RuntimeException('Unknown module.'); $table=$cfg['table']; $cols=table_columns($table); $pk=module_pk($key); $id=postv('id'); $fields=array_values(array_filter($cfg['fields'], fn($f)=>in_array($f,$cols,true) && $f!==$pk));
    $data=[]; foreach($fields as $f){ $data[$f]=postv($f); }
    if($id!==''){
        $old=row('SELECT * FROM `'.$table.'` WHERE `'.$pk.'`=?',[$id]);
        $sets=[]; $params=[]; foreach($data as $f=>$v){ $sets[]="`$f`=?"; $params[]=$v; } $params[]=$id; exec_sql('UPDATE `'.$table.'` SET '.implode(',',$sets).' WHERE `'.$pk.'`=?',$params);
        data_audit_log($table, 'UPDATE', $id, $old ?? [], $data, 'Admin edit via CRUD');
        flash('success','Record updated.'); redirect_to('?page=admin&tab=records&module='.$key);
    } else {
        $names=array_keys($data); $vals=array_values($data); exec_sql('INSERT INTO `'.$table.'` (`'.implode('`,`',$names).'`) VALUES ('.implode(',',array_fill(0,count($names),'?')).')',$vals);
        data_audit_log($table, 'INSERT', $data[$pk] ?? null, null, $data, 'Admin add via CRUD');
        flash('success','Record added.'); redirect_to('?page=admin&tab=records&module='.$key);
    }
}
function admin_delete_record(): void { $key=postv('module'); $id=postv('id'); $cfg=module_config($key); if(!$cfg) throw new RuntimeException('Unknown module.'); $pk=module_pk($key); $old=row('SELECT * FROM `'.$cfg['table'].'` WHERE `'.$pk.'`=?',[$id]); exec_sql('DELETE FROM `'.$cfg['table'].'` WHERE `'.$pk.'`=?',[$id]); data_audit_log($cfg['table'], 'DELETE', $id, $old, null, 'Admin delete via CRUD'); flash('success','Record deleted.'); redirect_to('?page=admin&tab=records&module='.$key); }
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
function admin_save_access_rule(): void {
    ensure_access_rules_schema();
    $id=(int)postv('rule_id');
    $scopeType=strtolower(postv('scope_type'));
    $scopeKey=trim(postv('scope_key'));
    $label=postv('label');
    $minTier=normalize_tier_code(postv('min_tier','free'));
    $notes=postv('notes');
    $active=postv('is_active','1')==='1'?1:0;
    $validScopes=['module','detail','section','field','report','feature'];
    $validTiers=['public','free','pro','ultimate'];
    if(!in_array($scopeType,$validScopes,true)) throw new RuntimeException('Invalid access rule scope.');
    if($scopeKey==='') throw new RuntimeException('Scope key is required, for example countries or aircraft_types:economics.');
    if($label==='') $label=labelize($scopeKey);
    if(!in_array($minTier,$validTiers,true)) throw new RuntimeException('Invalid minimum tier.');
    if($id>0){
        exec_sql('UPDATE access_rules SET scope_type=?, scope_key=?, label=?, min_tier=?, is_active=?, notes=?, updated_at=NOW() WHERE id=?',[$scopeType,$scopeKey,$label,$minTier,$active,$notes?:null,$id]);
    } else {
        exec_sql('INSERT INTO access_rules (scope_type,scope_key,label,min_tier,is_active,notes,created_at,updated_at) VALUES (?,?,?,?,?,?,NOW(),NOW()) ON DUPLICATE KEY UPDATE label=VALUES(label), min_tier=VALUES(min_tier), is_active=VALUES(is_active), notes=VALUES(notes), updated_at=NOW()',[$scopeType,$scopeKey,$label,$minTier,$active,$notes?:null]);
    }
    flash('success','Tier visibility rule saved.'); redirect_to('?page=admin&tab=access');
}
function admin_delete_access_rule(): void {
    ensure_access_rules_schema();
    $id=(int)postv('rule_id'); if($id>0) exec_sql('DELETE FROM access_rules WHERE id=?',[$id]);
    flash('success','Tier visibility rule removed.'); redirect_to('?page=admin&tab=access');
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
    if($mode==='truncate_append') { data_audit_log($table, 'TRUNCATE', null, null, null, 'CSV import truncate mode'); exec_sql('DELETE FROM `'.$table.'`'); }
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
            data_audit_log($table, 'INSERT', $data[$cfg['title'] ?? null] ?? null, null, $data, 'CSV import', postv('notes'));
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
        $pk=module_pk($key);
        $selectCols=array_values(array_unique(array_filter([$pk,$cfg['title'] ?? null,$cfg['subtitle'] ?? null,...($cfg['list'] ?? [])], fn($c)=>$c && in_array($c,$cols,true))));
        if(!in_array($pk,$selectCols,true)) array_unshift($selectCols,$pk);
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
                    'record_id'=>$r[$pk] ?? 0,
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

function pipeline_add_source(): void {
    $name=postv('source_name'); $type=postv('source_type'); $module=postv('module_key'); $url=postv('url'); $notes=postv('notes');
    if(!$name||!$type||!$module) { flash('error','Name, type and module key are required.'); redirect_to('?page=admin&tab=pipeline&section=sources'); }
    exec_sql('INSERT INTO pipeline_sources (source_name,source_type,module_key,url,notes,is_active) VALUES (?,?,?,?,?,1)',[$name,$type,$module,$url?:null,$notes?:null]);
    flash('success','Pipeline source added.'); redirect_to('?page=admin&tab=pipeline&section=sources');
}
function pipeline_run_source(): void {
    require_once __DIR__ . '/../scripts/pipeline/PipelineEngine.php';
    $id=(int)postv('source_id'); if(!$id) { flash('error','Invalid source ID.'); redirect_to('?page=admin&tab=pipeline&section=sources'); }
    try {
        $engine=new PipelineEngine((int)current_user()['id']);
        $result=$engine->run($id);
        flash('success',"Source run complete: {$result['fetched']} fetched, {$result['valid']} valid, {$result['inserts']} inserts, {$result['updates']} updates — pending review.");
    } catch(Throwable $e){
        flash('error','Pipeline run failed: '.$e->getMessage());
    }
    redirect_to('?page=admin&tab=pipeline&section=pending');
}
function pipeline_approve_run(): void {
    require_once __DIR__ . '/../scripts/pipeline/PipelineEngine.php';
    $id=(int)postv('run_id'); if(!$id) { flash('error','Invalid run ID.'); redirect_to('?page=admin&tab=pipeline&section=pending'); }
    try {
        $engine=new PipelineEngine((int)current_user()['id']);
        $result=$engine->approveRun($id);
        flash('success',"Run approved: {$result['inserted']} inserted, {$result['updated']} updated, {$result['deleted']} deleted.");
    } catch(Throwable $e){
        flash('error','Approval failed: '.$e->getMessage());
    }
    redirect_to('?page=admin&tab=pipeline&section=pending');
}
function pipeline_reject_run(): void {
    require_once __DIR__ . '/../scripts/pipeline/PipelineEngine.php';
    $id=(int)postv('run_id'); if(!$id) { flash('error','Invalid run ID.'); redirect_to('?page=admin&tab=pipeline&section=pending'); }
    try {
        $engine=new PipelineEngine((int)current_user()['id']);
        $engine->rejectRun($id);
        flash('success','Run rejected.');
    } catch(Throwable $e){
        flash('error',$e->getMessage());
    }
    redirect_to('?page=admin&tab=pipeline&section=pending');
}
function pipeline_approve_staging(): void {
    require_once __DIR__ . '/../scripts/pipeline/PipelineEngine.php';
    $ids=postv_array('record_ids'); if(!$ids) { flash('error','No records selected.'); redirect_to('?page=admin&tab=pipeline&section=pending'); }
    $ids=array_map('intval',$ids);
    try {
        $engine=new PipelineEngine((int)current_user()['id']);
        $engine->approveStagingRecords($ids);
        flash('success','Records approved.');
    } catch(Throwable $e){
        flash('error',$e->getMessage());
    }
    redirect_to('?page=admin&tab=pipeline&section=pending');
}
function pipeline_reject_staging(): void {
    require_once __DIR__ . '/../scripts/pipeline/PipelineEngine.php';
    $ids=postv_array('record_ids'); if(!$ids) { flash('error','No records selected.'); redirect_to('?page=admin&tab=pipeline&section=pending'); }
    $ids=array_map('intval',$ids);
    try {
        $engine=new PipelineEngine((int)current_user()['id']);
        $engine->rejectStagingRecords($ids);
        flash('success','Records rejected.');
    } catch(Throwable $e){
        flash('error',$e->getMessage());
    }
    redirect_to('?page=admin&tab=pipeline&section=pending');
}

// -----------------------------------------------------------------------------
// Data report / feedback system
// -----------------------------------------------------------------------------
function handle_submit_report(): void {
    $type=postv('report_type','other'); if(!in_array($type,['wrong','old','other'],true)) $type='other';
    $desc=postv('description'); if($desc===''){ flash('error','Please describe the problem.'); return; }
    $entityType=postv('entity_type','');
    $entityId=postv('entity_id','');
    $pageUrl=postv('page_url','');
    $contact=postv('contact_info','');
    $ip=$_SERVER['REMOTE_ADDR'] ?? '';
    exec_sql('INSERT INTO data_reports (entity_type,entity_id,page_url,report_type,description,contact_info,reporter_ip,status) VALUES (?,?,?,?,?,?,?,"open")',
        [$entityType?:null,$entityId?:null,$pageUrl?:null,$type,$desc,$contact?:null,$ip]);
    flash('success','Report submitted. Thank you for helping improve the data.');
    redirect_to($_SERVER['REQUEST_URI']);
}

function render_report_modal(string $entityType, string $entityId): string {
    $url='https://'.($_SERVER['HTTP_HOST'] ?? 'angani.co.uk').($_SERVER['REQUEST_URI'] ?? '');
    return '<div class="modal-overlay" id="reportModal" onclick="if(event.target===this)this.classList.remove(\'open\')"><div class="modal-panel"><button type="button" class="modal-close" onclick="this.closest(\'.modal-overlay\').classList.remove(\'open\')">&times;</button>
    <h3>Report a data problem</h3><p class="muted">Help us improve — tell us what is wrong with this record.</p>
    <form method="post" class="stack-form">'.csrf_field().'<input type="hidden" name="action" value="submit_report">
    <input type="hidden" name="entity_type" value="'.e($entityType).'"><input type="hidden" name="entity_id" value="'.e($entityId).'"><input type="hidden" name="page_url" value="'.e($url).'">
    <label><span>What is the issue?</span><select name="report_type"><option value="wrong">The data is wrong</option><option value="old">The data is outdated</option><option value="other">Something else</option></select></label>
    <label><span>Describe the problem</span><textarea name="description" rows="4" required></textarea></label>
    <label><span>Your email (optional)</span><input name="contact_info" type="email" placeholder="So we can follow up"></label>
    <button class="btn ink" type="submit">Submit report</button></form></div></div>';
}

// -----------------------------------------------------------------------------
// Email sending abstraction
// -----------------------------------------------------------------------------
function send_email(string $to, string $subject, string $body): bool {
    try {
        $provider=row('SELECT * FROM email_providers WHERE is_active=1 AND is_default=1 LIMIT 1');
        if(!$provider) $provider=row('SELECT * FROM email_providers WHERE is_active=1 LIMIT 1');
        if(!$provider) return send_email_fallback($to,$subject,$body);
        switch($provider['provider_type']){
            case 'sendpulse': return send_email_sendpulse($provider,$to,$subject,$body);
            case 'postmark': return send_email_postmark($provider,$to,$subject,$body);
            case 'brevo': return send_email_brevo($provider,$to,$subject,$body);
            case 'mailgun': return send_email_mailgun($provider,$to,$subject,$body);
            case 'ses': return send_email_ses($provider,$to,$subject,$body);
            case 'zapier': return send_email_zapier($provider,$to,$subject,$body);
            default: return send_email_fallback($to,$subject,$body);
        }
    } catch(Throwable $e){
        exec_sql('INSERT INTO email_queue (recipient_email,subject,body,status,error_message) VALUES (?,?,?,"failed",?)',[$to,$subject,$body,$e->getMessage()]);
        return false;
    }
}

function send_email_fallback(string $to, string $subject, string $body): bool {
    $headers='From: Angani Data <noreply@angani.co.uk>'."\r\n".'Content-Type: text/plain; charset=utf-8'."\r\n".'Reply-To: noreply@angani.co.uk';
    $ok=mail($to,'=?UTF-8?B?'.base64_encode($subject).'?=',wordwrap($body,70),$headers);
    exec_sql('INSERT INTO email_queue (recipient_email,subject,body,status,provider_used,sent_at) VALUES (?,?,?,?,?,NOW())',[$to,$subject,$body,$ok?'sent':'failed','mail']);
    return $ok;
}

function send_email_sendpulse(array $p, string $to, string $subject, string $body): bool {
    $cfg=json_decode($p['config_json']?:'{}',true);
    $from=$cfg['from_email'] ?? 'noreply@angani.co.uk'; $fromName=$cfg['from_name'] ?? 'Angani Data';
    $ch=curl_init('https://api.sendpulse.com/smtp/emails');
    curl_setopt_array($ch,[CURLOPT_POST=>1,CURLOPT_RETURNTRANSFER=>1,CURLOPT_HTTPHEADER=>['Authorization: Bearer '.$p['api_key'],'Content-Type: application/json'],CURLOPT_POSTFIELDS=>json_encode(['email'=>['from_email'=>$from,'from_name'=>$fromName,'to'=>[['email'=>$to]],'subject'=>$subject,'text'=>$body]])]);
    $res=curl_exec($ch); $http=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    $ok=$http>=200&&$http<300;
    exec_sql('INSERT INTO email_queue (recipient_email,subject,body,status,provider_used,sent_at) VALUES (?,?,?,?,?,NOW())',[$to,$subject,$body,$ok?'sent':'failed','sendpulse']);
    return $ok;
}

function send_email_postmark(array $p, string $to, string $subject, string $body): bool {
    $cfg=json_decode($p['config_json']?:'{}',true);
    $from=$cfg['from_email'] ?? 'noreply@angani.co.uk';
    $ch=curl_init('https://api.postmarkapp.com/email');
    curl_setopt_array($ch,[CURLOPT_POST=>1,CURLOPT_RETURNTRANSFER=>1,CURLOPT_HTTPHEADER=>['X-Postmark-Server-Token: '.$p['api_key'],'Content-Type: application/json','Accept: application/json'],CURLOPT_POSTFIELDS=>json_encode(['From'=>$from,'To'=>$to,'Subject'=>$subject,'TextBody'=>$body])]);
    $res=curl_exec($ch); $http=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    $ok=$http>=200&&$http<300;
    exec_sql('INSERT INTO email_queue (recipient_email,subject,body,status,provider_used,sent_at) VALUES (?,?,?,?,?,NOW())',[$to,$subject,$body,$ok?'sent':'failed','postmark']);
    return $ok;
}

function send_email_brevo(array $p, string $to, string $subject, string $body): bool {
    $cfg=json_decode($p['config_json']?:'{}',true);
    $from=$cfg['from_email'] ?? 'noreply@angani.co.uk'; $fromName=$cfg['from_name'] ?? 'Angani Data';
    $ch=curl_init('https://api.brevo.com/v3/smtp/email');
    curl_setopt_array($ch,[CURLOPT_POST=>1,CURLOPT_RETURNTRANSFER=>1,CURLOPT_HTTPHEADER=>['api-key: '.$p['api_key'],'Content-Type: application/json'],CURLOPT_POSTFIELDS=>json_encode(['sender'=>['email'=>$from,'name'=>$fromName],'to'=>[['email'=>$to]],'subject'=>$subject,'textContent'=>$body])]);
    $res=curl_exec($ch); $http=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    $ok=$http>=200&&$http<300;
    exec_sql('INSERT INTO email_queue (recipient_email,subject,body,status,provider_used,sent_at) VALUES (?,?,?,?,?,NOW())',[$to,$subject,$body,$ok?'sent':'failed','brevo']);
    return $ok;
}

function send_email_mailgun(array $p, string $to, string $subject, string $body): bool {
    $cfg=json_decode($p['config_json']?:'{}',true);
    $domain=$cfg['domain'] ?? '';
    $from=$cfg['from_email'] ?? 'noreply@angani.co.uk';
    if(!$domain) return send_email_fallback($to,$subject,$body);
    $ch=curl_init("https://api.mailgun.net/v3/$domain/messages");
    curl_setopt_array($ch,[CURLOPT_POST=>1,CURLOPT_RETURNTRANSFER=>1,CURLOPT_USERPWD=>'api:'.$p['api_key'],CURLOPT_POSTFIELDS=>['from'=>$from,'to'=>$to,'subject'=>$subject,'text'=>$body]]);
    $res=curl_exec($ch); $http=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    $ok=$http>=200&&$http<300;
    exec_sql('INSERT INTO email_queue (recipient_email,subject,body,status,provider_used,sent_at) VALUES (?,?,?,?,?,NOW())',[$to,$subject,$body,$ok?'sent':'failed','mailgun']);
    return $ok;
}

function send_email_ses(array $p, string $to, string $subject, string $body): bool {
    return send_email_fallback($to,$subject,$body);
}

function send_email_zapier(array $p, string $to, string $subject, string $body): bool {
    $cfg=json_decode($p['config_json']?:'{}',true);
    $webhookUrl=$cfg['webhook_url'] ?? $p['api_key'];
    if(!$webhookUrl) return send_email_fallback($to,$subject,$body);
    $ch=curl_init($webhookUrl);
    curl_setopt_array($ch,[CURLOPT_POST=>1,CURLOPT_RETURNTRANSFER=>1,CURLOPT_TIMEOUT=>10,CURLOPT_HTTPHEADER=>['Content-Type: application/json'],CURLOPT_POSTFIELDS=>json_encode(['to'=>$to,'subject'=>$subject,'body'=>$body])]);
    $res=curl_exec($ch); $http=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    $ok=$http>=200&&$http<300;
    exec_sql('INSERT INTO email_queue (recipient_email,subject,body,status,provider_used,sent_at) VALUES (?,?,?,?,?,NOW())',[$to,$subject,$body,$ok?'sent':'failed','zapier']);
    return $ok;
}
