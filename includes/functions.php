<?php
function e($v): string { return htmlspecialchars((string)($v ?? ''), ENT_QUOTES, 'UTF-8'); }
function getv(string $key, $default = ''): string { return trim((string)($_GET[$key] ?? $default)); }
function postv(string $key, $default = ''): string { return trim((string)($_POST[$key] ?? $default)); }
function nfmt($v): string { return number_format((float)($v ?? 0)); }
function fmt($v): string { return ($v === null || $v === '' || $v == 0) ? '—' : number_format((float)$v); }
function hue(string $v): int { return (int)(crc32($v) % 360); }
function active_page(string $current, string $target): string { return $current === $target ? 'active' : ''; }
function csrf_token(): string { if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32)); return $_SESSION['csrf']; }
function csrf_field(): string { return '<input type="hidden" name="csrf" value="' . e(csrf_token()) . '">'; }
function verify_csrf(): void { if ($_SERVER['REQUEST_METHOD'] === 'POST' && !hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) { throw new RuntimeException('Security token expired. Refresh the page and try again.'); } }
function redirect_to(string $url): never { header('Location: ' . $url); exit; }
function flash(string $type, string $message): void { $_SESSION['flash'][] = ['type'=>$type, 'message'=>$message]; }
function flash_html(): string { $out=''; foreach($_SESSION['flash'] ?? [] as $f){ $out.='<div class="flash '.e($f['type']).'">'.e($f['message']).'</div>'; } unset($_SESSION['flash']); return $out; }

function page_num(): int { return max(1, (int)($_GET['p'] ?? 1)); }
function query_string(array $override = []): string { $q = array_merge($_GET, $override); foreach ($q as $k=>$v) if ($v === '' || $v === null) unset($q[$k]); return http_build_query($q); }
function paginate(int $total, int $per): string { if ($total <= $per) return ''; $p = page_num(); $pages = (int)ceil($total / $per); $prev = max(1, $p - 1); $next = min($pages, $p + 1); return '<div class="pager"><a class="btn ghost" href="?' . e(query_string(['p'=>$prev])) . '">← Previous</a><span>Page ' . e($p) . ' of ' . e($pages) . '</span><a class="btn ghost" href="?' . e(query_string(['p'=>$next])) . '">Next →</a></div>'; }
function option_tags(array $items, string $selected, string $label = 'All'): string { $html='<option value="all">'.e($label).'</option>'; foreach($items as $it){ $value=is_array($it)?($it['value']??''):$it; $lab=is_array($it)?($it['label']??$value):$value; $html.='<option value="'.e($value).'" '.($selected===(string)$value?'selected':'').'>'.e($lab).'</option>'; } return $html; }
function metric_card(string $number, string $label, string $note=''): string { return '<div class="stat-card"><strong>'.e($number).'</strong><span>'.e($label).'</span>'.($note?'<small>'.e($note).'</small>':'').'</div>'; }
function status_chip(?string $status): string { $s = $status ?: 'unknown'; $class = $s === 'active' ? 'ok' : ($s === 'defunct' ? 'danger' : 'gold'); return '<span class="chip '.$class.'">'.e(ucfirst($s)).'</span>'; }
function initials(string $name): string { preg_match_all('/\b[A-Za-z]/', $name, $m); $letters = implode('', array_slice($m[0] ?? [], 0, 2)); return strtoupper($letters ?: substr($name,0,2)); }

function current_user(): ?array {
    if (empty($_SESSION['user_id'])) return null;
    static $user = null;
    if ($user !== null) return $user;
    try {
        $user = row('SELECT u.*, st.code tier_code, st.name tier_name, st.display_order tier_order, st.monthly_usd FROM users u LEFT JOIN subscription_tiers st ON st.id=u.tier_id WHERE u.id=? AND u.status="active"', [(int)$_SESSION['user_id']]);
    } catch (Throwable $e) { $user = null; }
    return $user;
}
function is_logged_in(): bool { return current_user() !== null; }
function is_admin(): bool { $u=current_user(); return $u && ($u['role'] ?? '') === 'admin'; }
function tier_order_for(?array $user = null): int { $u=$user ?: current_user(); return (int)($u['tier_order'] ?? 0); }
function tier_by_code(string $code): ?array { return row('SELECT * FROM subscription_tiers WHERE code=?', [$code]); }
function feature_allowed(string $feature): bool {
    if (is_admin()) return true;
    $u = current_user();
    if (!$u) return in_array($feature, ['public_view','public_teaser'], true);
    return (bool) scalar('SELECT COUNT(*) FROM tier_features WHERE tier_id=? AND feature_code=?', [(int)$u['tier_id'], $feature]);
}
function meets_tier(?int $requiredTierId): bool {
    if (!$requiredTierId || is_admin()) return true;
    $req = row('SELECT display_order FROM subscription_tiers WHERE id=?', [$requiredTierId]);
    return tier_order_for() >= (int)($req['display_order'] ?? 999);
}
function access_gate(string $title, string $text, string $cta = 'Sign in or upgrade'): string {
    return '<div class="lock-panel"><div class="lock-icon">LOCK</div><h3>'.e($title).'</h3><p>'.e($text).'</p><div class="hero-actions"><a class="btn primary" href="?page=pricing">'.e($cta).'</a><a class="btn ghost" href="?page=login">Log in</a></div></div>';
}
function country_options(): array { return rows("SELECT code AS value, CONCAT(name, ' (', code, ')') AS label FROM countries WHERE code <> 'GLOBAL' ORDER BY name"); }
function country_name(?string $code): string { if(!$code) return 'Unknown'; $r = row('SELECT name FROM countries WHERE code=?', [$code]); return $r['name'] ?? $code; }
function get_stats(): array {
    return [
        'airlines'=>(int)scalar('SELECT COUNT(*) FROM airlines'),
        'active_airlines'=>(int)scalar("SELECT COUNT(*) FROM airlines WHERE status_bucket='active'"),
        'defunct_airlines'=>(int)scalar("SELECT COUNT(*) FROM airlines WHERE status_bucket='defunct'"),
        'airports'=>(int)scalar('SELECT COUNT(*) FROM airports'),
        'aircraft'=>(int)scalar('SELECT COUNT(*) FROM aircraft_registrations'),
        'aircraft_types'=>(int)scalar('SELECT COUNT(*) FROM aircraft_types'),
        'regulatory'=>(int)scalar('SELECT COUNT(*) FROM regulatory_records'),
        'countries'=>(int)scalar("SELECT COUNT(*) FROM countries WHERE code <> 'GLOBAL'"),
        'dataset_files'=>(int)scalar('SELECT COUNT(*) FROM dataset_files'),
        'raw_records'=>(int)scalar('SELECT COUNT(*) FROM dataset_records'),
        'routes'=>(int)scalar('SELECT COUNT(*) FROM airline_route_services'),
        'users'=>(int)scalar('SELECT COUNT(*) FROM users'),
    ];
}
function airline_summary(array $a): string { $bits=[]; $bits[] = ($a['name'] ?? 'This airline') . ' is recorded as ' . (($a['status_bucket'] ?? '') === 'active' ? 'an active' : (($a['status_bucket'] ?? '') === 'defunct' ? 'a defunct or inactive' : 'an')) . ' airline record'; if(!empty($a['country_code']) && $a['country_code'] !== 'GLOBAL') $bits[]='associated with '.country_name($a['country_code']); $codes=[]; if(!empty($a['iata_code'])) $codes[]='IATA '.$a['iata_code']; if(!empty($a['icao_code'])) $codes[]='ICAO '.$a['icao_code']; if($codes) $bits[]='with '.implode(' and ',$codes); if(!empty($a['fleet_size'])) $bits[]='and a recorded fleet size of '.number_format((int)$a['fleet_size']); return implode(' ', $bits).'.'; }

function login_user(string $email, string $password): bool {
    $user = row('SELECT * FROM users WHERE email=? AND status="active"', [$email]);
    if (!$user || !password_verify($password, $user['password_hash'])) return false;
    $_SESSION['user_id'] = (int)$user['id'];
    exec_sql('UPDATE users SET last_login_at=NOW(), updated_at=NOW() WHERE id=?', [(int)$user['id']]);
    return true;
}
function register_user(string $name, string $email, string $password): array {
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) return [false, 'Enter a valid email address.'];
    if (strlen($password) < 8) return [false, 'Use at least 8 characters for the password.'];
    if ((int)scalar('SELECT COUNT(*) FROM users WHERE email=?', [$email]) > 0) return [false, 'An account with that email already exists.'];
    $tier = tier_by_code('free');
    exec_sql('INSERT INTO users (name,email,password_hash,tier_id,role,status,created_at,updated_at) VALUES (?,?,?,?,"user","active",NOW(),NOW())', [$name, $email, password_hash($password, PASSWORD_DEFAULT), (int)$tier['id']]);
    $_SESSION['user_id'] = (int)db()->lastInsertId();
    return [true, 'Account created.'];
}
function logout_user(): void { $_SESSION = []; if (ini_get('session.use_cookies')) { $p=session_get_cookie_params(); setcookie(session_name(), '', time()-42000, $p['path'], $p['domain'], $p['secure'], $p['httponly']); } session_destroy(); }

function tier_badge(?array $u = null): string { $u = $u ?: current_user(); if(!$u) return '<span class="tier-badge">Guest</span>'; return '<span class="tier-badge">'.e($u['tier_name'] ?: 'Free').'</span>'; }
function tier_cards(): array { return rows('SELECT * FROM subscription_tiers WHERE is_active=1 ORDER BY display_order'); }
function tier_features(int $tierId): array { return rows('SELECT feature_label FROM tier_features WHERE tier_id=? ORDER BY id', [$tierId]); }

function run_insight_query(string $key): array {
    switch ($key) {
        case 'oldest_aircraft':
            return rows("SELECT registration label, CONCAT(COALESCE(aircraft_type,'Unknown'),' · ',COALESCE(operator_name,operator_icao,'Unknown operator')) detail, ROUND(age,1) value FROM aircraft_registrations WHERE age IS NOT NULL AND age > 0 ORDER BY age DESC LIMIT 8");
        case 'highest_airports':
            return rows("SELECT airport_name label, CONCAT(COALESCE(city_name,''),' · ',COALESCE(country_code,'')) detail, elevation_ft value FROM airports WHERE elevation_ft IS NOT NULL ORDER BY elevation_ft DESC LIMIT 8");
        case 'smallest_airlines_capacity':
            return rows("SELECT name label, CONCAT(COALESCE(country_code,''),' · fleet ',COALESCE(fleet_size,0)) detail, COALESCE(fleet_size,0) value FROM airlines WHERE status_bucket='active' AND fleet_size IS NOT NULL AND fleet_size > 0 ORDER BY fleet_size ASC LIMIT 8");
        case 'routes_with_competition':
            return rows("SELECT CONCAT(o.iata_code,'–',d.iata_code) label, CONCAT(o.city_name,' to ',d.city_name) detail, COUNT(*) value FROM airline_route_services ars JOIN route_markets rm ON rm.id=ars.route_market_id JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id WHERE ars.status IN ('active','seasonal') GROUP BY rm.id HAVING COUNT(*) > 1 ORDER BY value DESC LIMIT 8");
        case 'dataset_coverage':
            return rows("SELECT COALESCE(category,'Other') label, CONCAT(COUNT(*) ,' CSV files') detail, COALESCE(SUM(row_count),0) value FROM dataset_files GROUP BY category ORDER BY value DESC LIMIT 8");
        case 'regulatory_depth':
            return rows("SELECT COALESCE(c.name,r.country_code) label, COUNT(*) detail, COUNT(*) value FROM regulatory_records r LEFT JOIN countries c ON c.code=r.country_code GROUP BY r.country_code,c.name ORDER BY value DESC LIMIT 8");
        default:
            return [];
    }
}
function chart_bars(array $rows, string $suffix = ''): string {
    if (!$rows) return '<p class="muted">No records yet.</p>';
    $max = max(array_map(fn($r)=>(float)($r['value'] ?? 0), $rows)) ?: 1;
    $html='<div class="chart-bars">';
    foreach($rows as $r){ $width=max(3, ((float)$r['value']/$max)*100); $html.='<div class="chart-row"><div><b>'.e($r['label']).'</b><small>'.e($r['detail'] ?? '').'</small></div><div class="bar-track"><i style="width:'.$width.'%"></i></div><strong>'.e(nfmt($r['value'] ?? 0)).e($suffix).'</strong></div>'; }
    return $html.'</div>';
}
function render_result_table(array $rows): string {
    if (!$rows) return '<div class="empty-state"><h3>No matching records yet</h3><p>The schema is ready, but this dataset needs more seeded or scraped data.</p></div>';
    $cols = array_keys($rows[0]); $html='<div class="table-wrap"><table><thead><tr>'; foreach($cols as $c) $html.='<th>'.e(str_replace('_',' ',ucfirst($c))).'</th>'; $html.='</tr></thead><tbody>'; foreach($rows as $r){ $html.='<tr>'; foreach($cols as $c) $html.='<td>'.e($r[$c] ?? '').'</td>'; $html.='</tr>'; } return $html.'</tbody></table></div>';
}
function run_preset_query(string $key): array {
    switch ($key) {
        case 'route_competitors':
            return rows("SELECT CONCAT(o.iata_code,'-',d.iata_code) route, a.name airline, ars.flight_number_prefix flight_prefix, ars.status, GROUP_CONCAT(DISTINCT atp.icao_code ORDER BY atp.icao_code SEPARATOR ', ') equipment, COUNT(DISTINCT competitor.id) competitors FROM airline_route_services ars JOIN route_markets rm ON rm.id=ars.route_market_id JOIN airports o ON o.id=rm.origin_airport_id JOIN airports d ON d.id=rm.destination_airport_id JOIN airlines a ON a.id=ars.airline_id LEFT JOIN route_service_equipment rse ON rse.airline_route_service_id=ars.id LEFT JOIN aircraft_types atp ON atp.id=rse.aircraft_type_id LEFT JOIN airline_route_services competitor ON competitor.route_market_id=ars.route_market_id AND competitor.airline_id<>ars.airline_id AND competitor.status IN ('active','seasonal') WHERE ars.status IN ('active','seasonal') GROUP BY ars.id,o.iata_code,d.iata_code,a.name,ars.flight_number_prefix,ars.status ORDER BY competitors DESC, route LIMIT 30");
        case 'oldest_aircraft':
            return run_insight_query('oldest_aircraft');
        case 'highest_airports':
            return run_insight_query('highest_airports');
        case 'smallest_airlines_capacity':
            return run_insight_query('smallest_airlines_capacity');
        case 'fleet_by_country':
            return rows("SELECT COALESCE(c.name,a.country_code) country, COUNT(*) aircraft_records, ROUND(AVG(ar.age),1) avg_age FROM aircraft_registrations ar LEFT JOIN countries c ON c.code=ar.country_code LEFT JOIN airlines a ON a.icao_code=ar.operator_icao GROUP BY COALESCE(c.name,a.country_code) ORDER BY aircraft_records DESC LIMIT 30");
        case 'regulatory_by_country':
            return rows("SELECT COALESCE(c.name,r.country_code) country, COUNT(*) regulatory_records, GROUP_CONCAT(DISTINCT r.type ORDER BY r.type SEPARATOR ', ') record_types FROM regulatory_records r LEFT JOIN countries c ON c.code=r.country_code GROUP BY r.country_code,c.name ORDER BY regulatory_records DESC LIMIT 30");
        case 'hub_airlines':
            return rows("SELECT ap.airport_name airport, a.name airline, aar.role_type, aar.valid_from, aar.valid_to FROM airport_airline_roles aar JOIN airports ap ON ap.id=aar.airport_id JOIN airlines a ON a.id=aar.airline_id ORDER BY ap.airport_name,a.name LIMIT 30");
        case 'aircraft_history':
            return rows("SELECT ar.registration, a.name operator, aoh.start_date, aoh.end_date, aoh.operation_type, aoh.remarks FROM aircraft_operator_history aoh JOIN aircraft_registrations ar ON ar.id=aoh.aircraft_id JOIN airlines a ON a.id=aoh.airline_id ORDER BY ar.registration,aoh.start_date DESC LIMIT 30");
        case 'sources_to_review':
            return rows("SELECT entity_type, entity_id, field_name, old_value, new_value, changed_at, change_source FROM entity_change_log ORDER BY changed_at DESC LIMIT 30");
        default:
            return [];
    }
}
function question_presets(): array { return rows('SELECT qp.*, st.code required_tier_code, st.name required_tier_name, st.display_order required_tier_order FROM question_presets qp LEFT JOIN subscription_tiers st ON st.id=qp.required_tier_id WHERE qp.is_active=1 ORDER BY qp.display_order, qp.id'); }
function active_insight_cards(): array { return rows('SELECT ic.*, st.code required_tier_code, st.name required_tier_name FROM insight_cards ic LEFT JOIN subscription_tiers st ON st.id=ic.required_tier_id WHERE ic.is_active=1 ORDER BY ic.display_order, ic.updated_at DESC LIMIT 8'); }

function handle_post_actions(): void {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') return;
    verify_csrf();
    $action = postv('action');
    if ($action === 'login') {
        if (login_user(postv('email'), postv('password'))) { flash('success','Logged in.'); redirect_to('?page=dashboard'); }
        flash('error','Invalid email or password.'); redirect_to('?page=login');
    }
    if ($action === 'register') {
        [$ok,$message] = register_user(postv('name'), postv('email'), postv('password'));
        flash($ok?'success':'error',$message); redirect_to($ok?'?page=dashboard':'?page=register');
    }
    if ($action === 'update_account' && is_logged_in()) {
        exec_sql('UPDATE users SET name=?, updated_at=NOW() WHERE id=?', [postv('name'), (int)current_user()['id']]);
        flash('success','Account updated.'); redirect_to('?page=account');
    }
    if ($action === 'admin_update_user_tier' && is_admin()) {
        exec_sql('UPDATE users SET tier_id=?, updated_at=NOW() WHERE id=?', [(int)postv('tier_id'), (int)postv('user_id')]);
        flash('success','User tier updated.'); redirect_to('?page=admin&tab=users');
    }
    if ($action === 'admin_save_insight' && is_admin()) {
        $id = (int)postv('id');
        $params = [postv('title'), postv('metric_label'), postv('description'), postv('query_key'), postv('chart_type'), (int)postv('required_tier_id') ?: null, (int)postv('display_order'), postv('is_active') === '1' ? 1 : 0];
        if ($id > 0) {
            $params[] = $id;
            exec_sql('UPDATE insight_cards SET title=?, metric_label=?, description=?, query_key=?, chart_type=?, required_tier_id=?, display_order=?, is_active=?, updated_at=NOW() WHERE id=?', $params);
        } else {
            exec_sql('INSERT INTO insight_cards (title,metric_label,description,query_key,chart_type,required_tier_id,display_order,is_active,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?,NOW(),NOW())', $params);
        }
        flash('success','Homepage insight saved.'); redirect_to('?page=admin&tab=insights');
    }
}
