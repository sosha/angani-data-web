<?php
function admin_metric(string $label, $value, string $note='', string $tone=''): string {
    return '<article class="admin-kpi '.$tone.'"><span>'.e($label).'</span><strong>'.e(nfmt($value)).'</strong>'.($note?'<small>'.e($note).'</small>':'').'</article>';
}
function admin_safe_count(string $sql, array $params=[]): int { try{return (int)scalar($sql,$params);}catch(Throwable $e){return 0;} }
function admin_empty_modules(): array { $out=[]; foreach(modules() as $k=>$c){ if(module_count($k)===0) $out[$k]=$c; } return $out; }
function admin_module_nav(string $current='airlines'): string {
    $html='<div class="admin-module-nav">';
    foreach(module_groups() as $group=>$keys){
        $open=in_array($current,$keys,true)?' open':'';
        $html.='<details'.$open.'><summary>'.e($group).'</summary>';
        foreach($keys as $k){ $c=module_config($k); if(!$c) continue; $html.='<a class="'.($k===$current?'active':'').'" href="?page=admin&tab=records&module='.e($k).'">'.e($c['label']).' <small>'.nfmt(module_count($k)).'</small></a>'; }
        $html.='</details>';
    }
    return $html.'</div>';
}
function admin_search_bar(string $module, array $cfg): string {
    return '<form method="get" class="toolbar admin-toolbar"><input type="hidden" name="page" value="admin"><input type="hidden" name="tab" value="records"><input type="hidden" name="module" value="'.e($module).'"><label class="searchbox"><span>Search records</span><input name="q" value="'.e(getv('q')).'" placeholder="Search '.e($cfg['label']).'"></label><label class="searchbox small"><span>Country</span>'.country_select('country',getv('country')).'</label><button class="btn ink">Apply filters</button><a class="btn ghost" href="?page=admin&tab=records&module='.e($module).'">Reset</a><a class="btn ghost" href="?page=export&module='.e($module).'&'.e(http_build_query(['q'=>getv('q'),'country'=>getv('country')])).'">Export filtered CSV</a></form>';
}
function render_admin_page(): void {
    $tab=getv('tab','overview'); $module=getv('module','airlines'); $cfg=module_config($module);
    $nav=[
        'overview'=>'Command Center',
        'records'=>'Records & CRUD',
        'pipeline'=>'Data Pipeline',
        'imports'=>'Imports / Exports',
        'quality'=>'Data Quality',
        'audit'=>'Data Audit',
        'reports'=>'Reports',
        'data_reports'=>'Data Reports',
        'email'=>'Email',
        'users'=>'Users',
        'plans'=>'Plans',
        'access'=>'Tier Visibility',
        'questions'=>'Preset Questions',
        'insights'=>'Homepage Insights',
        'pages'=>'Site Pages',
        'slides'=>'Homepage Slider',
        'tasks'=>'100% Tasks',
        'backup'=>'Backup & Restore',
        'mirror'=>'Mirror'
    ];
    echo '<section class="admin-layout"><aside class="admin-side"><div class="admin-logo"><span>AD</span><div><h2>Admin Console</h2><p>Operational backend</p></div></div><nav class="admin-side-nav">';
    foreach($nav as $key=>$label){ echo '<a class="'.($tab===$key?'active':'').'" href="?page=admin&tab='.e($key).($key==='records'?'&module=airlines':'').'">'.e($label).'</a>'; }
    echo '</nav><div class="admin-side-foot"><small>Public frontend is separate from this console. Admin screens expose actions; public screens expose aviation intelligence.</small></div></aside><section class="admin-main">';
    if($tab==='overview') render_admin_overview();
    elseif($tab==='users') render_admin_users();
    elseif($tab==='plans') render_admin_plans();
    elseif($tab==='access') render_admin_access_rules();
    elseif($tab==='questions') render_admin_questions();
    elseif($tab==='insights') render_admin_insights();
    elseif($tab==='pages') render_admin_pages();
    elseif($tab==='slides') render_admin_slides();
    elseif($tab==='imports') render_admin_imports();
    elseif($tab==='quality') render_admin_quality();
    elseif($tab==='tasks') render_admin_tasks();
    elseif($tab==='pipeline') render_admin_pipeline();
    elseif($tab==='audit') render_admin_data_audit();
    elseif($tab==='reports') render_admin_reports();
    elseif($tab==='data_reports') render_admin_data_reports();
    elseif($tab==='email') render_admin_email_providers();
    elseif($tab==='backup') render_admin_backup();
    elseif($tab==='mirror') render_admin_mirror();
    elseif($tab==='edit') render_admin_edit($module,getv('id'));
    else render_admin_records($module,$cfg);
    echo '</section></section>';
}
function render_admin_overview(): void {
    $s=get_stats(); $needs=admin_safe_count("SELECT COUNT(*) FROM staging_import_records WHERE status IN ('pending','needs_review','conflict')"); $bad=admin_safe_count("SELECT COUNT(*) FROM import_batches WHERE status IN ('failed','needs_review')"); $exports=admin_safe_count('SELECT COUNT(*) FROM export_logs'); $done=admin_safe_count("SELECT COUNT(*) FROM admin_tasks WHERE status='done'");
    echo '<div class="admin-head"><div><div class="eyebrow">Operations</div><h1>Admin Command Center</h1><p>Manage the data product, users, imports, quality review and homepage intelligence from one backend.</p></div><div class="hero-actions"><a class="btn primary" href="?page=admin&tab=records&module=airlines">Manage Records</a><a class="btn ghost" href="?page=admin&tab=imports">Import / Export</a></div></div>';
    echo '<div class="admin-kpi-grid">'.admin_metric('Airlines',$s['airlines'],nfmt($s['active_airlines']).' active','success').admin_metric('Airports',$s['airports'],'Infrastructure ready').admin_metric('Aircraft Types',$s['aircraft_types'],'Specs & type data').admin_metric('Users',$s['users'],'Accounts').admin_metric('Staging Review',$needs,'Rows needing attention',$needs?'warning':'success').admin_metric('Import Issues',$bad,'Batches to inspect',$bad?'danger':'success').admin_metric('Exports',$exports,'Logged downloads').admin_metric('Tasks Done',$done,'Readiness checklist').'</div>';
    echo '<div class="admin-action-grid"><article class="admin-action-card"><h3>Records</h3><p>Add, edit, preview and delete records across every configured aviation database.</p><a class="btn ink" href="?page=admin&tab=records&module=airlines">Open CRUD</a></article><article class="admin-action-card"><h3>Imports & Exports</h3><p>Append/truncate-import CSVs, export filtered module records, or export the whole database as CSV ZIP.</p><a class="btn ink" href="?page=admin&tab=imports">Open data ops</a></article><article class="admin-action-card"><h3>Data Quality</h3><p>Review staging rows, import batches, export logs and empty modules before launch.</p><a class="btn ink" href="?page=admin&tab=quality">Review quality</a></article><article class="admin-action-card"><h3>Users & Plans</h3><p>Manage users, roles, statuses and the simplified Free / Pro / Ultimate access model.</p><a class="btn ink" href="?page=admin&tab=users">Manage users</a></article><article class="admin-action-card"><h3>Tier Visibility</h3><p>Lock or unlock modules, drill-down tabs, reports and sensitive fields without editing PHP.</p><a class="btn ink" href="?page=admin&tab=access">Manage visibility</a></article></div>';
    echo '<section class="panel"><div class="topline"><h3>Database modules</h3><a class="btn mini ghost" href="?page=admin&tab=quality">View empty modules</a></div><div class="module-grid compact">';
    foreach(module_groups() as $group=>$keys){ echo '<article class="module-group"><h3>'.e($group).'</h3><div>'; foreach($keys as $k){ $c=module_config($k); if($c) echo '<a class="module-chip" href="?page=admin&tab=records&module='.e($k).'"><b>'.module_icon_html($k).'</b><span>'.e($c['label']).'</span><em>'.nfmt(module_count($k)).'</em></a>'; } echo '</div></article>'; }
    echo '</div></section>';
}
function render_admin_records(string $module, ?array $cfg): void {
    if(!$cfg){echo '<div class="empty-state"><h2>Unknown module</h2></div>';return;}
    [$records,$total]=query_module_records($cfg,30,(page_num()-1)*30);
    echo '<div class="admin-head"><div><div class="eyebrow">Records & CRUD</div><h1>'.e($cfg['label']).'</h1><p>'.nfmt($total).' records · table <code>'.e($cfg['table']).'</code></p></div><div class="hero-actions"><a class="btn primary" href="?page=admin&tab=edit&module='.e($module).'">Add record</a><a class="btn ghost" href="?page=admin&tab=imports&module='.e($module).'">Import CSV</a><a class="btn ghost" href="?page=export&module='.e($module).'&'.e(http_build_query(['q'=>getv('q'),'country'=>getv('country')])).'">Export CSV</a></div></div>';
    echo admin_module_nav($module).admin_search_bar($module,$cfg).'<div class="admin-note"><strong>Admin mode:</strong> record actions are explicit here. Public users see clean database pages with internal IDs/source/import fields hidden.</div>'.render_admin_record_table($records,$cfg['list'],$module).paginate($total,30);
}
function render_admin_edit(string $module,string $id=''): void {
    $cfg=module_config($module); if(!$cfg){echo '<div class="empty-state"><h2>Unknown module</h2></div>';return;} $pk=module_pk($module); $r=$id!==''?row('SELECT * FROM `'.$cfg['table'].'` WHERE `'.$pk.'`=?',[$id]):[];
    echo '<div class="admin-head"><div><div class="eyebrow">'.($id?'Edit record':'Add record').'</div><h1>'.e($cfg['label']).'</h1><p>Only the editable business fields are shown. Internal IDs and import/source fields remain system-managed.</p></div><div class="hero-actions"><a class="btn ghost" href="?page=admin&tab=records&module='.e($module).'">Back to records</a>'.($id?'<a class="btn ghost" href="'.e(detail_url($module,$id)).'">Preview public detail</a>':'').'</div></div>';
    echo '<form method="post" class="admin-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_record"><input type="hidden" name="module" value="'.e($module).'"><input type="hidden" name="id" value="'.e($id).'">';
    foreach($cfg['fields'] as $f){ $val=$r[$f] ?? ''; $isText=str_contains($f,'description')||str_contains($f,'notes')||str_contains($f,'story')||str_contains($f,'text')||str_contains($f,'summary')||str_contains($f,'requirements')||str_contains($f,'url')||str_contains($f,'source')||str_contains($f,'history')||str_contains($f,'milestones')||str_contains($f,'json'); echo '<label><span>'.e(labelize($f)).'</span>'; if($isText) echo '<textarea name="'.e($f).'" rows="4">'.e($val).'</textarea>'; else echo '<input name="'.e($f).'" value="'.e($val).'">'; echo '</label>'; }
    echo '<div class="form-actions"><button class="btn ink">Save record</button></div></form>';
    if($id!==''){ echo '<details class="admin-danger-zone"><summary>Danger zone</summary><form method="post" onsubmit="return confirm(\'Delete this record permanently?\')">'.csrf_field().'<input type="hidden" name="action" value="admin_delete_record"><input type="hidden" name="module" value="'.e($module).'"><input type="hidden" name="id" value="'.e($id).'"><button class="btn danger">Delete record</button></form></details>'; }
}
function render_admin_users(): void {
    $tiers=tier_cards(); $q=getv('q'); $params=[]; $where=''; if($q!==''){ $where='WHERE u.name LIKE ? OR u.email LIKE ? OR u.role LIKE ? OR u.status LIKE ?'; $params=['%'.$q.'%','%'.$q.'%','%'.$q.'%','%'.$q.'%']; }
    $users=rows('SELECT u.*, st.name tier_name FROM users u LEFT JOIN subscription_tiers st ON st.id=u.tier_id '.$where.' ORDER BY u.created_at DESC LIMIT 200',$params);
    echo '<div class="admin-head"><div><div class="eyebrow">Users</div><h1>Manage users</h1><p>Create accounts, assign Free/Pro/Ultimate, suspend access, and promote admins.</p></div></div>';
    echo '<div class="panel"><h3>Create user</h3><form method="post" class="admin-inline-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_user"><input name="name" placeholder="Name" required><input name="email" type="email" placeholder="Email" required><input name="password" placeholder="Password" value="Angani@2026"><select name="tier_id">'; foreach($tiers as $t) echo '<option value="'.(int)$t['id'].'">'.e($t['name']).'</option>'; echo '</select><select name="role"><option>user</option><option>admin</option></select><select name="status"><option>active</option><option>suspended</option></select><button class="btn ink">Create</button></form></div>';
    echo '<form method="get" class="toolbar admin-toolbar"><input type="hidden" name="page" value="admin"><input type="hidden" name="tab" value="users"><label class="searchbox"><span>Search users</span><input name="q" value="'.e($q).'" placeholder="Name, email, role, status"></label><button class="btn ink">Search</button><a class="btn ghost" href="?page=admin&tab=users">Reset</a></form>';
    echo '<div class="table-wrap"><table><thead><tr><th>Name</th><th>Email</th><th>Tier</th><th>Role</th><th>Status</th><th>Last login</th><th>Action</th></tr></thead><tbody>'; foreach($users as $u){ echo '<tr><form style="display:contents" method="post">'.csrf_field().'<input type="hidden" name="action" value="admin_save_user"><input type="hidden" name="user_id" value="'.(int)$u['id'].'"><td><input name="name" value="'.e($u['name']).'"></td><td><input name="email" value="'.e($u['email']).'"></td><td><select name="tier_id">'; foreach($tiers as $t) echo '<option value="'.(int)$t['id'].'" '.((int)$t['id']===(int)$u['tier_id']?'selected':'').'>'.e($t['name']).'</option>'; echo '</select></td><td><select name="role"><option '.($u['role']==='user'?'selected':'').'>user</option><option '.($u['role']==='admin'?'selected':'').'>admin</option></select></td><td><select name="status"><option '.($u['status']==='active'?'selected':'').'>active</option><option '.($u['status']==='suspended'?'selected':'').'>suspended</option><option '.($u['status']==='deleted'?'selected':'').'>deleted</option></select></td><td>'.e($u['last_login_at'] ?? '—').'</td><td><button class="btn mini">Save</button></td></form></tr>'; } echo '</tbody></table></div>';
}
function render_admin_plans(): void {
    $tiers=rows('SELECT * FROM subscription_tiers ORDER BY display_order');
    echo '<div class="admin-head"><div><div class="eyebrow">Plans & Access</div><h1>Free / Pro / Ultimate</h1><p>Edit pricing, limits and visible benefits. Use Tier Visibility to decide which modules, sections and fields each tier can see.</p></div></div><div class="pricing-grid admin-plan-grid">';
    foreach($tiers as $t){ echo '<article class="pricing-card"><form method="post" class="stack-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_tier"><input type="hidden" name="tier_id" value="'.(int)$t['id'].'"><label><span>Name</span><input name="name" value="'.e($t['name']).'"></label><label><span>Code</span><input name="code" value="'.e($t['code']).'"></label><label><span>Description</span><textarea name="description">'.e($t['description']).'</textarea></label><label><span>Monthly USD</span><input name="monthly_usd" value="'.e($t['monthly_usd']).'"></label><label><span>Annual USD</span><input name="annual_usd" value="'.e($t['annual_usd']).'"></label><label><span>Monthly exports</span><input name="export_limit_monthly" value="'.e($t['export_limit_monthly']).'"></label><label><span>API limit</span><input name="api_limit_monthly" value="'.e($t['api_limit_monthly']).'"></label><label><span>Order</span><input name="display_order" value="'.(int)$t['display_order'].'"></label><label><span>Active</span><select name="is_active"><option value="1" '.($t['is_active']?'selected':'').'>Yes</option><option value="0" '.(!$t['is_active']?'selected':'').'>No</option></select></label><button class="btn ink">Save plan</button></form><hr><h4>Benefits</h4><ul class="feature-list">'; foreach(rows('SELECT * FROM tier_features WHERE tier_id=? ORDER BY id',[(int)$t['id']]) as $f){ echo '<li>'.e($f['feature_label']).'<form method="post" class="inline-delete">'.csrf_field().'<input type="hidden" name="action" value="admin_delete_feature"><input type="hidden" name="feature_id" value="'.(int)$f['id'].'"><button class="btn mini danger">×</button></form></li>'; } echo '</ul><form method="post" class="inline-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_feature"><input type="hidden" name="tier_id" value="'.(int)$t['id'].'"><input name="feature_code" placeholder="feature_code" required><input name="feature_label" placeholder="Feature label" required><button class="btn mini ink">Add benefit</button></form></article>'; }
    echo '</div>';
}
function render_admin_access_rules(): void {
    $rules=access_rules_all();
    $moduleOptions=''; foreach(modules() as $k=>$cfg){ $moduleOptions.='<option value="'.e($k).'">'.e($k.' — '.$cfg['label']).'</option>'; }
    $tierOptions=function(string $selected): string {
        $selected=normalize_tier_code($selected);
        $out=''; foreach(['public'=>'Public visitor','free'=>'Free user','pro'=>'Pro','ultimate'=>'Ultimate'] as $code=>$label){ $out.='<option value="'.e($code).'" '.($selected===$code?'selected':'').'>'.e($label).'</option>'; }
        return $out;
    };
    $scopeOptions=function(string $selected): string {
        $out=''; foreach(['module'=>'Module listing','detail'=>'Full detail page','section'=>'Detail tab / related section','field'=>'Individual field','report'=>'Generated report','feature'=>'Named feature'] as $code=>$label){ $out.='<option value="'.e($code).'" '.($selected===$code?'selected':'').'>'.e($label).'</option>'; }
        return $out;
    };
    echo '<div class="admin-head"><div><div class="eyebrow">Access control</div><h1>Tier Visibility</h1><p>Control what visitors, Free users, Pro users and Ultimate clients can see. Examples: <code>countries</code>, <code>aircraft_types:economics</code>, <code>airlines:people</code>, or <code>aircraft_types:monthly_lease_rate_usd</code>.</p></div><div class="hero-actions"><a class="btn ghost" href="?page=pricing">Preview pricing</a><a class="btn ghost" href="?page=catalogue">Preview catalogue</a></div></div>';
    echo '<section class="panel"><h3>Add visibility rule</h3><p class="muted">Use <strong>module</strong> to lock a whole listing, <strong>detail</strong> to lock full record pages, <strong>section</strong> to lock a tab, or <strong>field</strong> to lock specific values inside details.</p><form method="post" class="admin-form compact-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_access_rule"><label><span>Scope</span><select name="scope_type">'.$scopeOptions('section').'</select></label><label><span>Scope key</span><input name="scope_key" list="moduleKeys" placeholder="aircraft_types:economics" required></label><label><span>Label</span><input name="label" placeholder="Aircraft economics"></label><label><span>Minimum tier</span><select name="min_tier">'.$tierOptions('pro').'</select></label><label><span>Active</span><select name="is_active"><option value="1">Yes</option><option value="0">No</option></select></label><label class="wide"><span>Admin note</span><textarea name="notes" rows="2" placeholder="Why this is locked or open"></textarea></label><button class="btn ink">Save rule</button></form><datalist id="moduleKeys">'.$moduleOptions.'<option value="aircraft_types:economics"><option value="airlines:commercial"><option value="airlines:people"><option value="countries:airlines"><option value="generated_reports"></datalist></section>';
    echo '<section class="panel"><div class="topline"><h3>Current rules</h3><span class="chip gold">'.nfmt(count($rules)).' rules</span></div><div class="table-wrap access-rules-table"><table><thead><tr><th>Scope</th><th>Key</th><th>Label & note</th><th>Minimum tier</th><th>Active</th><th>Save</th><th></th></tr></thead><tbody>';
    foreach($rules as $r){
        $id=(int)($r['id'] ?? 0); $scope=e($r['scope_type'] ?? 'module'); $key=e($r['scope_key'] ?? '');
        echo '<tr><form style="display:contents" method="post">'.csrf_field().'<input type="hidden" name="action" value="admin_save_access_rule"><input type="hidden" name="rule_id" value="'.$id.'"><td><select name="scope_type">'.$scopeOptions($r['scope_type'] ?? 'module').'</select></td><td><input name="scope_key" value="'.$key.'"></td><td><input name="label" value="'.e($r['label'] ?? '').'"><textarea name="notes" rows="2">'.e($r['notes'] ?? '').'</textarea></td><td><select name="min_tier">'.$tierOptions($r['min_tier'] ?? 'free').'</select></td><td><select name="is_active"><option value="1" '.(!empty($r['is_active'])?'selected':'').'>Yes</option><option value="0" '.(empty($r['is_active'])?'selected':'').'>No</option></select></td><td><button class="btn mini ink">Save</button></td></form><td>';
        if($id>0) echo '<form method="post" class="inline-delete">'.csrf_field().'<input type="hidden" name="action" value="admin_delete_access_rule"><input type="hidden" name="rule_id" value="'.$id.'"><button class="btn mini danger" onclick="return confirm(&quot;Remove this rule?&quot;)">×</button></form>';
        echo '</td></tr>';
    }
    echo '</tbody></table></div></section>';
}
function render_admin_questions(): void {
    $qs=rows('SELECT qp.*, st.name tier_name FROM question_presets qp LEFT JOIN subscription_tiers st ON st.id=qp.required_tier_id ORDER BY qp.display_order, qp.id'); $tiers=tier_cards();
    echo '<div class="admin-head"><div><div class="eyebrow">Preset Questions</div><h1>User intelligence prompts</h1><p>These drive the logged-in dashboard. Use them to guide users toward valuable dataset answers.</p></div></div>';
    echo '<div class="panel"><h3>Add question</h3><form method="post" class="admin-form compact-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_question"><label><span>Code</span><input name="code" required></label><label><span>Title</span><input name="title" required></label><label><span>Category</span><input name="category" required></label><label><span>Answer key</span><input name="answer_key" required></label><label><span>Required tier</span><select name="required_tier_id"><option value="">Free</option>'; foreach($tiers as $t) echo '<option value="'.(int)$t['id'].'">'.e($t['name']).'</option>'; echo '</select></label><label><span>Order</span><input name="display_order" value="50"></label><label class="wide"><span>Question text</span><textarea name="question_text" required></textarea></label><label><span>Active</span><select name="is_active"><option value="1">Yes</option><option value="0">No</option></select></label><button class="btn ink">Add question</button></form></div>';
    echo '<div class="table-wrap"><table><thead><tr><th>Question</th><th>Category</th><th>Answer key</th><th>Tier</th><th>Order</th><th>Active</th><th>Save</th></tr></thead><tbody>'; foreach($qs as $q){ echo '<tr><form style="display:contents" method="post">'.csrf_field().'<input type="hidden" name="action" value="admin_save_question"><input type="hidden" name="id" value="'.(int)$q['id'].'"><td><input name="code" value="'.e($q['code']).'"><input name="title" value="'.e($q['title']).'"><textarea name="question_text">'.e($q['question_text']).'</textarea></td><td><input name="category" value="'.e($q['category']).'"></td><td><input name="answer_key" value="'.e($q['answer_key']).'"></td><td><select name="required_tier_id"><option value="">Free</option>'; foreach($tiers as $t) echo '<option value="'.(int)$t['id'].'" '.((int)$q['required_tier_id']===(int)$t['id']?'selected':'').'>'.e($t['name']).'</option>'; echo '</select></td><td><input name="display_order" value="'.(int)$q['display_order'].'"></td><td><select name="is_active"><option value="1" '.($q['is_active']?'selected':'').'>Yes</option><option value="0" '.(!$q['is_active']?'selected':'').'>No</option></select></td><td><button class="btn mini">Save</button></td></form></tr>'; } echo '</tbody></table></div>';
}
function render_admin_insights(): void {
    $cards=rows('SELECT ic.*, st.name tier_name FROM insight_cards ic LEFT JOIN subscription_tiers st ON st.id=ic.required_tier_id ORDER BY ic.display_order'); $tiers=tier_cards(); $queries=available_insight_queries();
    echo '<div class="admin-head"><div><div class="eyebrow">Homepage</div><h1>Manage rotating insights</h1><p>Use these cards to keep the public homepage fresh and convert visitors into signups.</p></div></div>';
    echo '<div class="panel"><h3>Add homepage insight</h3><form method="post" class="admin-form compact-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_insight"><label><span>Title</span><input name="title" required></label><label><span>Metric label</span><input name="metric_label"></label><label><span>Query</span><select name="query_key">'; foreach($queries as $k=>$label) echo '<option value="'.e($k).'">'.e($label).'</option>'; echo '</select></label><label><span>Chart</span><input name="chart_type" value="ranked_bar"></label><label><span>Required tier</span><select name="required_tier_id"><option value="">Public</option>'; foreach($tiers as $t) echo '<option value="'.(int)$t['id'].'">'.e($t['name']).'</option>'; echo '</select></label><label><span>Order</span><input name="display_order" value="50"></label><label><span>Active</span><select name="is_active"><option value="1">Yes</option><option value="0">No</option></select></label><label class="wide"><span>Description</span><textarea name="description"></textarea></label><button class="btn ink">Add insight</button></form></div>';
    echo '<div class="table-wrap"><table><thead><tr><th>Title</th><th>Metric</th><th>Query</th><th>Tier</th><th>Order</th><th>Active</th><th>Save</th></tr></thead><tbody>'; foreach($cards as $c){ echo '<tr><form style="display:contents" method="post">'.csrf_field().'<input type="hidden" name="action" value="admin_save_insight"><input type="hidden" name="id" value="'.(int)$c['id'].'"><td><input name="title" value="'.e($c['title']).'"><textarea name="description">'.e($c['description']).'</textarea></td><td><input name="metric_label" value="'.e($c['metric_label']).'"></td><td><select name="query_key">'; foreach($queries as $k=>$label) echo '<option value="'.e($k).'" '.($c['query_key']===$k?'selected':'').'>'.e($label).'</option>'; echo '</select><input name="chart_type" value="'.e($c['chart_type']).'"></td><td><select name="required_tier_id"><option value="">Public</option>'; foreach($tiers as $t) echo '<option value="'.(int)$t['id'].'" '.((int)$c['required_tier_id']===(int)$t['id']?'selected':'').'>'.e($t['name']).'</option>'; echo '</select></td><td><input name="display_order" value="'.(int)$c['display_order'].'"></td><td><select name="is_active"><option value="1" '.($c['is_active']?'selected':'').'>Yes</option><option value="0" '.(!$c['is_active']?'selected':'').'>No</option></select></td><td><button class="btn mini">Save</button></td></form></tr>'; } echo '</tbody></table></div>';
}
function render_admin_imports(): void {
    $module=getv('module','airlines'); $cfg=module_config($module);
    echo '<div class="admin-head"><div><div class="eyebrow">Data Operations</div><h1>Imports / Exports</h1><p>Import selected modules, export filtered records, or export a full CSV ZIP backup.</p></div><div class="hero-actions"><a class="btn primary" href="?page=export_all">Export whole database ZIP</a></div></div>';
    echo '<div class="panel-grid"><article class="panel"><h3>Import CSV to module</h3><form method="post" enctype="multipart/form-data" class="stack-form">'.csrf_field().'<input type="hidden" name="action" value="admin_import_csv"><label>Module<select name="module">'; foreach(modules() as $k=>$c) echo '<option value="'.e($k).'" '.($k===$module?'selected':'').'>'.e($c['label']).' — '.e($k).'</option>'; echo '</select></label><label>Import mode<select name="import_mode"><option value="append">Append new records</option><option value="truncate_append">Clear module then import</option></select></label><label>CSV file<input type="file" name="csv_file" accept=".csv" required></label><label>Batch notes<textarea name="notes" placeholder="Source, assumptions, or cleanup notes"></textarea></label><button class="btn ink">Import CSV</button></form><p class="muted">Headers are matched to editable field names. Failed rows are sent to Data Quality → Staging Records.</p></article>';
    echo '<article class="panel"><h3>Export selected module</h3><form method="get" class="stack-form"><input type="hidden" name="page" value="export"><label>Module<select name="module">'; foreach(modules() as $k=>$c) echo '<option value="'.e($k).'" '.($k===$module?'selected':'').'>'.e($c['label']).'</option>'; echo '</select></label><label>Search filter<input name="q" placeholder="Optional keyword"></label><label>Country filter'.country_select('country').'</label><button class="btn ink">Export filtered CSV</button></form><p class="muted">Admin exports respect filters and are logged in <strong>Export Logs</strong>.</p></article></div>';
    echo '<section class="panel"><h3>Phase 4 source importers</h3><p class="muted">For large source folders and country ZIP imports, run the CLI importer so long-running jobs are not interrupted by the browser.</p><div class="code-grid"><code>php scripts/importers/phase4_import.php --group=all</code><code>php scripts/importers/phase4_import.php --group=country --country=KE</code><code>php scripts/importers/phase4_import.php --group=aircraft</code><code>php scripts/importers/phase4_import.php --group=reference</code><code>php scripts/importers/phase4_import.php --group=commercial</code><code>php scripts/importers/phase4_import.php --group=infrastructure</code></div><p class="muted">Groups available: global, country, aircraft, reference, commercial, iata-iosa, gds, infrastructure. Use <code>--dry-run</code>, <code>--mode=replace</code>, <code>--limit=1000</code> or <code>--store-raw=1</code> when needed.</p></section>';
    echo '<section class="panel"><h3>Module export shortcuts</h3><div class="module-grid compact">'; foreach(module_groups() as $group=>$keys){ echo '<article class="module-group"><h3>'.e($group).'</h3><div>'; foreach($keys as $k){ $c=module_config($k); if($c) echo '<a class="module-chip" href="?page=export&module='.e($k).'"><b>'.module_icon_html($k).'</b><span>'.e($c['label']).'</span><em>'.nfmt(module_count($k)).'</em></a>'; } echo '</div></article>'; } echo '</div></section>';
    $logs=rows('SELECT * FROM import_batches ORDER BY started_at DESC LIMIT 20'); echo '<h3>Recent import batches</h3>'.render_table($logs,$logs?array_keys($logs[0]):[],null);
}
function render_admin_quality(): void {
    $staging=rows('SELECT * FROM staging_import_records ORDER BY created_at DESC LIMIT 100'); $batches=rows('SELECT * FROM import_batches ORDER BY started_at DESC LIMIT 50'); $exports=rows('SELECT el.*, u.email FROM export_logs el LEFT JOIN users u ON u.id=el.user_id ORDER BY el.created_at DESC LIMIT 50'); $empty=admin_empty_modules();
    $needs=admin_safe_count("SELECT COUNT(*) FROM staging_import_records WHERE status IN ('pending','needs_review','conflict')"); $failed=admin_safe_count("SELECT COUNT(*) FROM import_batches WHERE status IN ('failed','needs_review')");
    echo '<div class="admin-head"><div><div class="eyebrow">Data Quality</div><h1>Review queue</h1><p>Imports should not blindly become trusted aviation intelligence. Review failed rows, empty modules and export usage.</p></div></div><div class="admin-kpi-grid">'.admin_metric('Rows needing review',$needs,'Staging queue',$needs?'warning':'success').admin_metric('Import issues',$failed,'Failed/needs-review batches',$failed?'danger':'success').admin_metric('Empty modules',count($empty),'Awaiting data').admin_metric('Export logs',count($exports),'Recent exports').'</div>';
    echo '<section class="panel"><h3>Empty / awaiting-data modules</h3>'; if(!$empty) echo '<p class="muted">No empty configured modules.</p>'; else { echo '<div class="admin-empty-list">'; foreach($empty as $k=>$c) echo '<a href="?page=admin&tab=records&module='.e($k).'"><strong>'.e($c['label']).'</strong><small>'.e($k).'</small></a>'; echo '</div>'; } echo '</section>';

    // Data completeness tracker
    echo '<section class="panel"><h3>Data completeness</h3><p class="muted">Column-level fill rates across primary tables. Shows how many records have a value vs total records.</p><div class="table-wrap"><table><thead><tr><th>Table</th><th>Total rows</th><th>Column</th><th>Filled</th><th>Empty</th><th>Fill %</th></tr></thead><tbody>';
    $tables = ['airlines','airports','airport_frequencies','navaids','countries','aircraft_types','airline_fleet_list','airport_runways','airline_hubs','airline_digital_properties','airline_key_personnel','airline_operational_stats','commercial_fares','regulatory_authorities'];
    $keyCols = ['airlines'=>['name','iata_code','icao_code','callsign','country','country_code','active','status','logo_url'],
        'airports'=>['ident','gps_code','iata_code','name','type','iso_country','municipality','elevation_ft','coordinates'],
        'airport_frequencies'=>['airport_ident','type','frequency_mhz','description'],
        'navaids'=>['ident','name','type','frequency_khz','iso_country'],
        'countries'=>['iso_alpha_2','iso_alpha_3','name_common','name_official','continent','un_region','flag','description'],
        'aircraft_types'=>['icao_code','iata_code','manufacturer','model','type'],
        'airline_fleet_list'=>['registration','aircraft_model','operator_airline','delivery_date','current_status'],
        'airport_runways'=>['airport_ident','runway_ident','length_ft','surface','lighting'],
        'airline_hubs'=>['airport_code','airline_name','hub_type','region_served'],
        'airline_digital_properties'=>['platform','url_or_handle','is_primary'],
        'airline_key_personnel'=>['person_name','title','category'],
        'airline_operational_stats'=>['stat_year','pax_count','cargo_volume','revenue'],
        'commercial_fares'=>['origin_iata','destination_iata','fare_amount','currency'],
        'regulatory_authorities'=>['name','abbreviation','country_code','website']
    ];
    foreach ($tables as $tbl) {
        try {
            $total = (int)scalar("SELECT COUNT(*) FROM `$tbl`");
            if (!$total) continue;
            $first = true;
            foreach (($keyCols[$tbl] ?? []) as $col) {
                try {
                    $filled = (int)scalar("SELECT COUNT(*) FROM `$tbl` WHERE `$col` IS NOT NULL AND `$col` != ''");
                    $emptyCount = $total - $filled;
                    $pct = $total > 0 ? round(($filled / $total) * 100) : 0;
                    $bar = '<div style="height:6px;background:rgba(7,21,34,.08);border-radius:99px;overflow:hidden"><div style="width:'.$pct.'%;height:100%;background:'.($pct>80?'#26c56b':($pct>50?'#c79b45':'#b04747')).';border-radius:inherit"></div></div>';
                    $cls = $pct > 80 ? ' success' : ($pct > 50 ? ' warning' : ' danger');
                    echo '<tr><td>'.($first ? '<strong>'.e($tbl).'</strong>' : '').'</td><td>'.($first ? nfmt($total) : '').'</td><td>'.e($col).'</td><td class="admin-kpi'.$cls.'" style="border-left:none;padding:4px 14px">'.nfmt($filled).'/'.nfmt($total).'</td><td>'.nfmt($emptyCount).'</td><td>'.$pct.'% '.$bar.'</td></tr>';
                    $first = false;
                } catch (Throwable $e) { continue; }
            }
        } catch (Throwable $e) { continue; }
    }
    echo '</tbody></table></div></section>';

    echo '<section class="panel"><h3>Staging records</h3>'; if(!$staging) echo '<p class="muted">No staged import issues.</p>'; else { echo '<div class="table-wrap"><table><thead><tr><th>Module</th><th>Row</th><th>Status</th><th>Issue</th><th>Action</th></tr></thead><tbody>'; foreach($staging as $r){ echo '<tr><form style="display:contents" method="post">'.csrf_field().'<input type="hidden" name="action" value="admin_update_staging"><input type="hidden" name="staging_id" value="'.(int)$r['id'].'"><td>'.e($r['module_key']).'</td><td>'.e($r['source_row_number']).'</td><td><select name="status">'; foreach(['pending','needs_review','accepted','rejected','duplicate','conflict'] as $st) echo '<option '.($r['status']===$st?'selected':'').'>'.$st.'</option>'; echo '</select></td><td>'.display_value($r['issue_summary']).'</td><td><button class="btn mini">Update</button></td></form></tr>'; } echo '</tbody></table></div>'; } echo '</section>';
    echo '<section class="panel"><h3>Import batches</h3>'.render_table($batches,$batches?array_keys($batches[0]):[],null).'</section><section class="panel"><h3>Export logs</h3>'.render_table($exports,$exports?array_keys($exports[0]):[],null).'</section>';
}
function render_admin_tasks(): void { $tasks=rows('SELECT * FROM admin_tasks ORDER BY sort_order,id'); echo '<div class="admin-head"><div><div class="eyebrow">Readiness</div><h1>100% implementation checklist</h1><p>Track launch readiness from inside the admin console.</p></div></div><div class="table-wrap"><table><thead><tr><th>Category</th><th>Task</th><th>Status</th><th>Priority</th><th>Action</th></tr></thead><tbody>'; foreach($tasks as $t){ echo '<tr><form style="display:contents" method="post">'.csrf_field().'<input type="hidden" name="action" value="admin_update_task"><input type="hidden" name="task_id" value="'.(int)$t['id'].'"><td>'.e($t['category']).'</td><td><strong>'.e($t['task_title']).'</strong><p>'.e($t['description']).'</p></td><td><select name="status">'; foreach(['pending','in_progress','done','blocked'] as $st) echo '<option '.($t['status']===$st?'selected':'').'>'.$st.'</option>'; echo '</select></td><td>'.e($t['priority']).'</td><td><button class="btn mini">Update</button></td></form></tr>'; } echo '</tbody></table></div>'; }
function render_admin_pipeline(): void {
    $sub=getv('section','sources');
    echo '<div class="admin-head"><div><div class="eyebrow">Data Pipeline</div><h1>Pipeline manager</h1><p>Fetch, validate, review and publish data from external sources through the 4-stage pipeline.</p></div></div>';
    echo '<nav class="admin-module-nav">';
    foreach(['sources'=>'Sources','pending'=>'Pending Reviews','history'=>'Run History'] as $k=>$l){
        echo '<a class="'.($sub===$k?'active':'').'" href="?page=admin&tab=pipeline&section='.e($k).'">'.e($l).'</a>';
    }
    echo '</nav>';
    if($sub==='sources') render_pipeline_sources();
    elseif($sub==='pending') render_pipeline_pending();
    elseif($sub==='history') render_pipeline_history();
}
function render_pipeline_sources(): void {
    $sources=rows('SELECT * FROM pipeline_sources ORDER BY module_key,source_name');
    echo '<section class="panel"><h3>Add source</h3><form method="post" class="admin-form compact-form">'.csrf_field().'<input type="hidden" name="action" value="pipeline_add_source"><label><span>Source name</span><input name="source_name" required></label><label><span>Type</span><select name="source_type"><option value="api">API</option><option value="scraper">Web scraper</option><option value="csv_upload">CSV file</option><option value="url_csv">URL CSV</option></select></label><label><span>Module key</span><input name="module_key" placeholder="countries, caas, country_transport_stats" required></label><label><span>URL (for API / URL CSV)</span><input name="url" placeholder="https://..."></label><label><span>Notes</span><textarea name="notes" rows="2"></textarea></label><button class="btn ink">Add source</button></form></section>';
    echo '<section class="panel"><h3>Sources</h3><div class="table-wrap"><table><thead><tr><th>Name</th><th>Type</th><th>Module</th><th>Status</th><th>Last run</th><th>Actions</th></tr></thead><tbody>';
    foreach($sources as $s){
        $status='<span class="chip '.($s['is_active']?'ok glow-green':'gold').'">'.($s['is_active']?'Active':'Inactive').'</span>';
        $lastRun=$s['last_run_at'] ? e($s['last_run_at']).' <small>'.e($s['last_run_status'] ?? '').'</small>' : '—';
        echo '<tr><td><strong>'.e($s['source_name']).'</strong></td><td><span class="chip">'.e($s['source_type']).'</span></td><td>'.e($s['module_key']).'</td><td>'.$status.'</td><td>'.$lastRun.'</td><td>';
        echo '<form method="post" style="display:inline">'.csrf_field().'<input type="hidden" name="action" value="pipeline_run_source"><input type="hidden" name="source_id" value="'.(int)$s['id'].'"><button class="btn mini ink">Run now</button></form>';
        echo '</td></tr>';
    }
    echo '</tbody></table></div></section>';
}
function render_pipeline_pending(): void {
    $runs=rows("SELECT pr.*, ps.source_name FROM pipeline_runs pr LEFT JOIN pipeline_sources ps ON ps.id=pr.pipeline_source_id WHERE pr.status='pending_review' ORDER BY pr.started_at DESC LIMIT 20");
    if(!$runs){ echo '<section class="panel"><h3>Pending reviews</h3><p class="muted">No runs pending review.</p></section>'; return; }
    foreach($runs as $run){
        $records=rows('SELECT * FROM staging_records WHERE pipeline_run_id=? ORDER BY id',[(int)$run['id']]);
        echo '<section class="panel"><div class="topline"><h3>'.e($run['source_name'] ?: 'Source #'.$run['pipeline_source_id']).'</h3><span class="chip gold">'.e($run['module_key']).'</span><span class="chip">'.nfmt($run['records_fetched']).' fetched</span></div>';
        echo '<p>Run #'.(int)$run['id'].' · '.e($run['started_at']).'</p>';
        echo '<form method="post" style="display:inline">'.csrf_field().'<input type="hidden" name="action" value="pipeline_approve_run"><input type="hidden" name="run_id" value="'.(int)$run['id'].'"><button class="btn ink">Approve all</button></form> ';
        echo '<form method="post" style="display:inline">'.csrf_field().'<input type="hidden" name="action" value="pipeline_reject_run"><input type="hidden" name="run_id" value="'.(int)$run['id'].'"><button class="btn ghost">Reject all</button></form>';
        if($records){
            echo '<div class="table-wrap"><table><thead><tr><th>Action</th><th>Key</th><th>Status</th><th>Actions</th></tr></thead><tbody>';
            foreach($records as $r){
                $data=json_decode($r['row_data'],true);
                $key=$data['iso_alpha_2'] ?? $data['country_code'] ?? $data['name'] ?? '(no key)';
                echo '<tr><td><span class="chip '.($r['action']==='insert'?'ok':($r['action']==='update'?'gold':($r['action']==='delete'?'danger':''))).'">'.e($r['action']).'</span></td><td>'.e($key).'</td><td><span class="chip '.($r['status']==='approved'?'ok glow-green':($r['status']==='rejected'?'danger':'gold')).'">'.e($r['status']).'</span></td><td>';
                echo '<form method="post" style="display:inline">'.csrf_field().'<input type="hidden" name="action" value="pipeline_approve_staging"><input type="hidden" name="record_ids[]" value="'.(int)$r['id'].'"><button class="btn mini ink">Approve</button></form> ';
                echo '<form method="post" style="display:inline">'.csrf_field().'<input type="hidden" name="action" value="pipeline_reject_staging"><input type="hidden" name="record_ids[]" value="'.(int)$r['id'].'"><button class="btn mini ghost">Reject</button></form>';
                echo '</td></tr>';
            }
            echo '</tbody></table></div>';
        }
        echo '</section>';
    }
}
function render_pipeline_history(): void {
    $runs=rows('SELECT pr.*, ps.source_name FROM pipeline_runs pr LEFT JOIN pipeline_sources ps ON ps.id=pr.pipeline_source_id ORDER BY pr.started_at DESC LIMIT 100');
    echo '<section class="panel"><h3>Run history</h3><div class="table-wrap"><table><thead><tr><th>ID</th><th>Source</th><th>Module</th><th>Status</th><th>Fetched</th><th>Ins</th><th>Upd</th><th>Started</th><th>Finished</th></tr></thead><tbody>';
    foreach($runs as $r){
        $status=$r['status'];
        $cls=$status==='approved'?'ok glow-green':($status==='failed'?'danger':($status==='pending_review'?'gold':''));
        echo '<tr><td>#'.(int)$r['id'].'</td><td>'.e($r['source_name'] ?: '—').'</td><td>'.e($r['module_key']).'</td><td><span class="chip '.$cls.'">'.e($status).'</span></td><td>'.nfmt($r['records_fetched']).'</td><td>'.nfmt($r['records_insert']).'</td><td>'.nfmt($r['records_update']).'</td><td>'.e($r['started_at'] ?: '—').'</td><td>'.e($r['finished_at'] ?: '—').'</td></tr>';
    }
    echo '</tbody></table></div></section>';
}

function render_admin_reports(): void {
    echo '<div class="admin-head"><div><div class="eyebrow">Data Reports</div><h1>Report Generator</h1><p>Pre-compute derived statistics from existing data. Reports are flagged for re-run when their source tables change.</p></div></div>';
    if (postv('action') === 'run_report') {
        $rk = postv('report_key');
        $pass = getenv('ANGANI_DB_PASS') ?: 'rootpassword';
        $scripts = [
            'country_air_transport_stats' => '/../scripts/reports/generate_country_stats.php',
            'country_time_series' => '/../scripts/populate_country_time_series.php',
        ];
        if (isset($scripts[$rk])) {
            $output = shell_exec('ANGANI_DB_PASS=' . escapeshellarg($pass) . ' php ' . escapeshellarg(__DIR__ . $scripts[$rk]) . ' 2>&1');
            flash('success', 'Report "' . e($rk) . '" generated.');
            redirect_to('?page=admin&tab=reports');
        } else {
            flash('error', 'Unknown report key.');
        }
    }
    $reports = rows('SELECT * FROM report_dependencies ORDER BY report_key');
    echo '<section class="panel"><h3>Report Status</h3><div class="table-wrap"><table><thead><tr><th>Report</th><th>Last Run</th><th>Status</th><th>Action</th></tr></thead><tbody>';
    foreach ($reports as $rpt) {
        $needsUpdate = (int)$rpt['needs_update'];
        $statusLabel = $needsUpdate ? '<span class="chip gold">Needs update</span>' : '<span class="chip ok glow-green">Up to date</span>';
        $lastRun = $rpt['last_run_at'] ? e($rpt['last_run_at']) : '<span class="muted">Never</span>';
        echo '<tr><td><strong>' . e($rpt['report_label']) . '</strong><br><small>' . e($rpt['report_key']) . '</small>';
        $tables = json_decode($rpt['dependent_tables'] ?? '[]', true);
        if ($tables) echo '<br><small class="muted">Depends on: ' . e(implode(', ', $tables)) . '</small>';
        echo '</td><td>' . $lastRun . '</td><td>' . $statusLabel . '</td><td>';
        echo '<form method="post" style="display:inline">' . csrf_field() . '<input type="hidden" name="action" value="run_report"><input type="hidden" name="report_key" value="' . e($rpt['report_key']) . '"><button class="btn ink mini">Run now</button></form>';
        echo '</td></tr>';
    }
    echo '</tbody></table></div></section>';
    echo '<section class="panel"><h3>Recent Database Changes Affecting Reports</h3>';
    try {
        $tableList = [];
        $allRpts = rows('SELECT dependent_tables FROM report_dependencies');
        foreach ($allRpts as $r) {
            $tbls = json_decode($r['dependent_tables'] ?? '[]', true);
            foreach ($tbls as $t) { if ($t && !in_array($t, $tableList, true)) $tableList[] = $t; }
        }
        if ($tableList) {
            $placeholders = implode(',', array_fill(0, count($tableList), '?'));
            $auditEntries = rows("SELECT table_name, action, record_id, changed_by, notes, created_at FROM data_audit_log WHERE table_name IN ($placeholders) ORDER BY created_at DESC LIMIT 50", $tableList);
            if ($auditEntries) {
                echo '<div class="table-wrap"><table><thead><tr><th>Table</th><th>Action</th><th>Record</th><th>Changed By</th><th>Notes</th><th>When</th></tr></thead><tbody>';
                foreach ($auditEntries as $ae) {
                    echo '<tr><td><code>' . e($ae['table_name']) . '</code></td><td><span class="chip ' . ($ae['action'] === 'INSERT' ? 'ok' : ($ae['action'] === 'DELETE' ? 'danger' : 'gold')) . '">' . e($ae['action']) . '</span></td><td>' . e($ae['record_id'] ?? '—') . '</td><td>' . e($ae['changed_by'] ?? '—') . '</td><td>' . e($ae['notes'] ?? '') . '</td><td><small>' . e($ae['created_at']) . '</small></td></tr>';
                }
                echo '</tbody></table></div>';
            } else { echo '<p class="muted">No recent changes to tracked tables.</p>'; }
        }
    } catch (Throwable $e) { echo '<p class="muted">Could not load change log.</p>'; }
    echo '</section>';
    echo '<section class="panel"><div class="topline"><h3>Pending Tasks</h3></div><ul>';
    echo '<li><strong>Foreign Airline Operations</strong> — Requires airline destinations data to be populated first. Skipped in current report generator.</li>';
    echo '<li><strong>Country Time Series</strong> — Data population requires external sources (World Bank, national statistics). Manual entry via Admin CRUD.</li>';
    echo '</ul></section>';
}

function render_admin_data_audit(): void {
    $selectedTable = getv('audit_table', 'airlines');
    $action = postv('action');
    $cfg = module_config($selectedTable);
    $actualTable = $cfg['table'] ?? $selectedTable;

    // Handle POST actions
    if ($action === 'audit_attach_license') {
        $auditId = (int)postv('audit_id');
        $licenseId = (int)postv('license_id');
        data_audit_update_license($auditId, $licenseId ?: null);
        flash('success', 'License attached to audit entry.');
        redirect_to('?page=admin&tab=audit&audit_table=' . e($selectedTable));
    }
    if ($action === 'audit_set_provenance') {
        $method = postv('collection_method');
        $url = postv('primary_source_url');
        $licenseId = (int)postv('primary_license_id');
        $notes = postv('provenance_notes');
        data_provenance_set($actualTable, $method, $url ?: null, $licenseId ?: null, $notes ?: null);
        flash('success', 'Table provenance updated.');
        redirect_to('?page=admin&tab=audit&audit_table=' . e($selectedTable));
    }

    echo '<div class="admin-head"><div><div class="eyebrow">Transparency</div><h1>Data Audit Trail</h1><p>Chronological history of every INSERT, UPDATE, DELETE and IMPORT operation across all database tables. Attach licenses and document provenance.</p></div></div>';

    // Module/table selector
    echo '<form method="get" class="toolbar admin-toolbar">';
    echo '<input type="hidden" name="page" value="admin"><input type="hidden" name="tab" value="audit">';
    echo '<label class="searchbox"><span>Database / Table</span><select name="audit_table" onchange="this.form.submit()">';
    echo '<option value="">— All tables —</option>';
    $seen = [];
    foreach (modules() as $k => $m) {
        $t = $m['table'] ?? $k;
        if (in_array($t, $seen, true)) continue;
        $seen[] = $t;
        echo '<option value="' . e($t) . '"' . ($t === $selectedTable ? ' selected' : '') . '>' . e($m['label']) . ' (' . e($t) . ')</option>';
    }
    echo '</select></label>';
    echo '<button class="btn ink">View history</button>';
    echo '<a class="btn ghost" href="?page=admin&tab=audit">Reset</a>';
    echo '</form>';

    // Table-level provenance card
    echo '<section class="panel"><div class="topline"><h3>📋 Table Provenance</h3></div>';
    $provenance = data_provenance_get($actualTable);
    if ($provenance) {
        echo '<div class="provenance-card"><p><strong>Collection method:</strong> ' . e($provenance['collection_method'] ?: 'Not documented') . '</p>';
        if ($provenance['primary_source_url']) echo '<p><strong>Source URL:</strong> <a href="' . e($provenance['primary_source_url']) . '" target="_blank">' . e($provenance['primary_source_url']) . '</a></p>';
        if ($provenance['primary_license_id']) {
            $lic = row('SELECT name, url FROM data_licenses WHERE id=?', [(int)$provenance['primary_license_id']]);
            if ($lic) echo '<p><strong>License:</strong> ' . e($lic['name']) . ($lic['url'] ? ' (<a href="' . e($lic['url']) . '" target="_blank">' . e($lic['url']) . '</a>)' : '') . '</p>';
        }
        if ($provenance['notes']) echo '<p><strong>Notes:</strong> ' . e($provenance['notes']) . '</p>';
        echo '<p class="muted">Updated ' . e($provenance['updated_at'] ?? '') . ' by ' . e($provenance['updated_by'] ?? '') . '</p>';
    } else {
        echo '<p class="muted">No provenance documented for this table yet.</p>';
    }
    echo '<details style="margin-top:12px"><summary>Update provenance</summary>';
    echo '<form method="post" class="stack-form">' . csrf_field() . '<input type="hidden" name="action" value="audit_set_provenance">';
    echo '<label><span>Collection method</span><textarea name="collection_method" rows="3" placeholder="How was this data collected? e.g. Scraped from OurAirports API, Wikipedia List of Airline Codes...">' . e($provenance['collection_method'] ?? '') . '</textarea></label>';
    echo '<label><span>Primary source URL</span><input name="primary_source_url" value="' . e($provenance['primary_source_url'] ?? '') . '" placeholder="https://..."></label>';
    echo '<label><span>Primary license</span>' . data_audit_license_select('primary_license_id', $provenance['primary_license_id'] ?? null) . '</label>';
    echo '<label><span>Notes</span><textarea name="provenance_notes" rows="2">' . e($provenance['notes'] ?? '') . '</textarea></label>';
    echo '<button class="btn ink">Save provenance</button></form></details></section>';

    // Audit log entries
    if ($selectedTable) {
        $entries = rows('SELECT al.*, l.name license_name, l.url license_url FROM data_audit_log al LEFT JOIN data_licenses l ON l.id=al.license_id WHERE al.table_name=? ORDER BY al.created_at DESC LIMIT 200', [$actualTable]);
    } else {
        $entries = rows('SELECT al.*, l.name license_name, l.url license_url FROM data_audit_log al LEFT JOIN data_licenses l ON l.id=al.license_id ORDER BY al.created_at DESC LIMIT 200');
    }

    echo '<section class="panel"><div class="topline"><h3>📜 Audit History</h3><span class="chip">' . count($entries) . ' entries</span></div>';
    if (!$entries) {
        echo '<p class="muted">No audit entries yet. Data modifications will be recorded here automatically.</p>';
    } else {
        echo '<div class="table-wrap"><table><thead><tr><th>When</th><th>Table</th><th>Action</th><th>Record</th><th>Changed by</th><th>Collection method</th><th>License</th><th>Notes</th><th>Attach license</th></tr></thead><tbody>';
        foreach ($entries as $e) {
            $actionClass = $e['action'] === 'INSERT' ? 'ok glow-green' : ($e['action'] === 'DELETE' ? 'danger' : ($e['action'] === 'TRUNCATE' ? 'gold' : ''));
            echo '<tr>';
            echo '<td><small>' . e($e['created_at']) . '</small></td>';
            echo '<td><code>' . e($e['table_name']) . '</code></td>';
            echo '<td><span class="chip ' . $actionClass . '">' . e($e['action']) . '</span></td>';
            echo '<td><small>' . e($e['record_id'] ?? '—') . '</small></td>';
            echo '<td><small>' . e($e['changed_by'] ?? '—') . '</small></td>';
            echo '<td style="max-width:300px;word-break:break-word"><small>' . e(mb_substr($e['collection_method'] ?? '', 0, 120)) . '</small></td>';
            echo '<td>';
            if ($e['license_name']) {
                echo '<span class="chip">' . e($e['license_name']) . '</span>';
            } else {
                echo '<span class="muted">—</span>';
            }
            echo '</td>';
            echo '<td style="max-width:200px"><small>' . e(mb_substr($e['notes'] ?? '', 0, 80)) . '</small></td>';
            echo '<td><form method="post" class="inline-form" style="display:flex;gap:4px">' . csrf_field() . '<input type="hidden" name="action" value="audit_attach_license"><input type="hidden" name="audit_id" value="' . (int)$e['id'] . '">';
            echo data_audit_license_select('license_id', $e['license_id'] ?? null);
            echo '<button class="btn mini">Set</button></form></td>';
            echo '</tr>';
            // Show old/new values expandable
            if ($e['old_values'] || $e['new_values']) {
                $old = json_decode($e['old_values'], true);
                $new = json_decode($e['new_values'], true);
                if ($old || $new) {
                    echo '<tr class="audit-diff-row"><td colspan="9"><details><summary>View data diff</summary><div style="display:grid;grid-template-columns:1fr 1fr;gap:12px">';
                    if ($old) echo '<div><strong>Previous values</strong><pre style="font-size:11px;max-height:200px;overflow:auto">' . e(json_encode($old, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)) . '</pre></div>';
                    if ($new) echo '<div><strong>New values</strong><pre style="font-size:11px;max-height:200px;overflow:auto">' . e(json_encode($new, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)) . '</pre></div>';
                    echo '</div></details></td></tr>';
                }
            }
        }
        echo '</tbody></table></div>';
    }
    echo '</section>';
}

function render_admin_backup(): void {
    $projectRoot = realpath(__DIR__ . '/..');
    $prefix = 'angani_backup_';
    $existingZips = glob($projectRoot . '/' . $prefix . '*.zip');
    $totalBackupSize = 0;
    foreach ($existingZips as $z) $totalBackupSize += filesize($z);

    // Handle POST actions
    if (postv('action') === 'run_backup') {
        $pass = getenv('ANGANI_DB_PASS') ?: 'rootpassword';
        $output = shell_exec('ANGANI_DB_PASS=' . escapeshellarg($pass) . ' php ' . escapeshellarg($projectRoot . '/scripts/backup_engine.php') . ' 2>&1');
        flash('success', 'Backup completed.');
        redirect_to('?page=admin&tab=backup');
    }

    if (postv('action') === 'delete_backups') {
        foreach ($existingZips as $z) unlink($z);
        flash('success', 'Backup files deleted.');
        redirect_to('?page=admin&tab=backup');
    }

    echo '<div class="admin-head"><div><div class="eyebrow">System Protection</div><h1>Backup & Restore</h1><p>Create or restore full system backups. Backups include all project files and the MySQL database, split into 100 MB volumes.</p></div></div>';

    // Stats
    echo '<div class="admin-kpi-grid">';
    echo admin_metric('Backup Volumes', count($existingZips), $totalBackupSize ? round($totalBackupSize/1024/1024,1).' MB total' : 'No backups');
    echo admin_metric('Restore Script', 'install.php', 'Available at root');
    echo admin_metric('Max Volume Size', '100 MB', 'Per zip file');
    echo '</div>';

    // Actions
    echo '<div class="admin-action-grid">';
    echo '<article class="admin-action-card"><h3>Create Backup</h3><p>Scan all project files and the MySQL database, then produce numbered zip volumes.</p><form method="post">' . csrf_field() . '<input type="hidden" name="action" value="run_backup"><button class="btn ink">Run Backup Now</button></form></article>';
    echo '<article class="admin-action-card"><h3>Download Backup Files</h3><p>Backup files are stored in the project root and included in git pushes. Download them individually below.</p></article>';
    if ($existingZips) {
        echo '<article class="admin-action-card"><h3>Delete Backups</h3><p>Remove all existing backup zip files from the project root.</p><form method="post" onsubmit="return confirm(\'Delete all backup files?\')">' . csrf_field() . '<input type="hidden" name="action" value="delete_backups"><button class="btn danger">Delete All Backups</button></form></article>';
    }
    echo '</div>';

    // Backup files list
    if ($existingZips) {
        echo '<section class="panel"><div class="topline"><h3>Backup Files</h3></div><div class="file-list" style="font-family:monospace;font-size:13px">';
        foreach ($existingZips as $z) {
            $basename = basename($z);
            $size = filesize($z);
            $href = '../' . $basename;
            echo '<div style="display:flex;justify-content:space-between;padding:8px 0;border-bottom:1px solid rgba(255,255,255,.05)"><a href="' . e($href) . '" download style="color:#64ffda">' . e($basename) . '</a><span>' . number_format($size) . ' bytes</span></div>';
        }
        echo '</div></section>';
    }

    // Restore instructions
    echo '<section class="panel"><div class="topline"><h3>Restore Instructions</h3></div>';
    echo '<div style="font-size:14px;line-height:1.8;color:#8892b0">';
    echo '<p><strong>To restore on a new server:</strong></p>';
    echo '<ol style="padding-left:20px;margin:12px 0">';
    echo '<li>Upload all <code>angani_backup_*.zip</code> files and <code>install.php</code> to the new server\'s document root.</li>';
    echo '<li>Open <code>http://YOUR_SERVER/install.php</code> in a browser.</li>';
    echo '<li>Follow the guided 3-step restore process (extract files, configure database, complete).</li>';
    echo '<li>The system will be fully restored and ready to use.</li>';
    echo '</ol>';
    echo '<p><strong>Via git:</strong> Since backup files are stored in the repo, a <code>git pull</code> on the new server will fetch them automatically.</p>';
    echo '</div></section>';
}

function render_admin_mirror(): void {
    echo '<div class="admin-head"><div><div class="eyebrow">Replication</div><h1>Mirror Status</h1><p>Real-time mirror to the secondary server is kept in sync automatically.</p></div></div>';

    $mirrorStateFile = __DIR__ . '/../backups/mirror_state.json';
    $state = ['last_sync' => 'Never', 'status' => 'unknown', 'files_synced' => 0, 'last_error' => ''];
    if (file_exists($mirrorStateFile)) {
        $state = array_merge($state, json_decode(file_get_contents($mirrorStateFile), true) ?: []);
    }

    $lastSync = $state['last_sync'] ?? 'Never';
    $status = $state['status'] ?? 'unknown';
    $filesSynced = (int)($state['files_synced'] ?? 0);
    $lastError = $state['last_error'] ?? '';

    $statusColor = 'gold';
    $statusLabel = 'Unknown';
    if ($status === 'ok') { $statusColor = 'ok glow-green'; $statusLabel = 'In Sync'; }
    elseif ($status === 'syncing') { $statusColor = 'gold'; $statusLabel = 'Syncing…'; }
    elseif ($status === 'error') { $statusColor = 'danger'; $statusLabel = 'Error'; }

    echo '<div class="admin-kpi-grid">';
    echo '<article class="admin-kpi ' . $statusColor . '" style="border-left:4px solid var(--c-'.($statusColor === 'ok glow-green' ? 'success':($statusColor === 'danger' ? 'danger':'warning')).',#c79b45)"><span>Mirror Status</span><strong>' . $statusLabel . '</strong><small>Last sync: ' . e($lastSync) . '</small></article>';
    echo admin_metric('Files Synced', $filesSynced, 'Total files transferred');
    echo '</div>';

    if ($lastError) {
        echo '<div class="panel" style="border-left:3px solid #b04747"><h3>Last Error</h3><p style="color:#ff6b6b;font-size:13px;font-family:monospace">' . e($lastError) . '</p></div>';
    }

    // Mirror configuration info
    echo '<section class="panel"><div class="topline"><h3>Mirror Configuration</h3></div>';
    echo '<div style="font-size:14px;line-height:1.8;color:#8892b0">';
    echo '<p><strong>Secondary server:</strong> <code>root@134.209.114.217</code></p>';
    echo '<p><strong>Sync mechanism:</strong> SSH + rsync (files) + MySQL dump piped via SSH (database)</p>';
    echo '<p><strong>Schedule:</strong> Every 5 minutes via cron</p>';
    echo '<p><strong>SSH Key:</strong> <code>data/mirror_key</code> (stored in repo for deployment)</p>';
    echo '</div></section>';

    // Manual sync button
    echo '<section class="panel"><div class="topline"><h3>Manual Sync</h3></div>';
    echo '<p class="muted">Trigger an immediate sync to the mirror server.</p>';
    echo '<form method="post">' . csrf_field() . '<input type="hidden" name="action" value="run_mirror_sync"><button class="btn ink">Run Mirror Sync Now</button></form>';
    echo '</section>';

    // Supabase sync section
    $supabaseStateFile = __DIR__ . '/../backups/supabase_sync_state.json';
    $sState = ['last_sync' => 'Never', 'status' => 'unknown', 'tables_synced' => 0, 'rows_synced' => 0, 'last_error' => ''];
    if (file_exists($supabaseStateFile)) {
        $sState = array_merge($sState, json_decode(file_get_contents($supabaseStateFile), true) ?: []);
    }
    echo '<section class="panel" style="border-left:3px solid #3ecf8e"><div class="topline"><h3>☁️ Sync to Supabase</h3><span class="chip ' . ($sState['status'] === 'ok' ? 'ok glow-green' : ($sState['status'] === 'error' ? 'danger' : 'gold')) . '">' . e(ucfirst($sState['status'] === 'ok' ? 'Synced' : ($sState['status'] === 'error' ? 'Error' : 'Unknown'))) . '</span></div>';
    echo '<p class="muted">Drop everything in Supabase and recreate from current MySQL schema + all data. Last sync: ' . e($sState['last_sync']) . ' · ' . nfmt((int)$sState['tables_synced']) . ' tables · ' . nfmt((int)$sState['rows_synced']) . ' rows</p>';
    if ($sState['last_error']) {
        echo '<p style="color:#ff6b6b;font-size:13px;font-family:monospace">Last error: ' . e($sState['last_error']) . '</p>';
    }
    echo '<form method="post" onsubmit="return confirm(\'This will DROP ALL tables in Supabase and recreate from MySQL. Continue?\')">' . csrf_field() . '<input type="hidden" name="action" value="sync_to_supabase"><button class="btn ink" style="background:#3ecf8e;color:#0a0a0a">Sync Full Database to Supabase</button></form>';
    echo '</section>';
}

function render_admin_data_reports(): void {
    $statusFilter=getv('rstatus','');
    $where=''; $params=[];
    if($statusFilter){ $where='WHERE dr.status=?'; $params=[$statusFilter]; }
    $reports=rows('SELECT dr.*, u.name resolved_by_name FROM data_reports dr LEFT JOIN users u ON u.id=dr.resolved_by '.$where.' ORDER BY dr.created_at DESC LIMIT 200',$params);
    echo '<div class="admin-head"><div><div class="eyebrow">Data Reports</div><h1>User Data Problem Reports</h1><p>Users submit reports from detail pages when they spot wrong, outdated, or missing data.</p></div></div>';
    echo '<form method="get" class="toolbar admin-toolbar"><input type="hidden" name="page" value="admin"><input type="hidden" name="tab" value="data_reports"><label class="searchbox tiny"><span>Status</span><select name="rstatus" onchange="this.form.submit()"><option value="">All statuses</option>';
    foreach(['open','in_progress','resolved','dismissed'] as $s) echo '<option value="'.e($s).'"'.($statusFilter===$s?' selected':'').'>'.e(ucfirst($s)).'</option>';
    echo '</select></label><a class="btn ghost" href="?page=admin&tab=data_reports">Reset</a></form>';
    if(!$reports){ echo '<section class="panel"><p class="muted">No reports yet.</p></section>'; return; }
    echo '<div class="table-wrap"><table><thead><tr><th>Date</th><th>Entity</th><th>Type</th><th>Description</th><th>Contact</th><th>Status</th><th>Admin notes</th><th>Update</th></tr></thead><tbody>';
    foreach($reports as $r){
        $entityLink=$r['entity_type'] && $r['entity_id'] ? ' (<a href="'.e(detail_url($r['entity_type'],$r['entity_id'])).'" class="linkish">view</a>)' : '';
        echo '<tr><td><small>'.e($r['created_at']).'</small></td><td>'.e($r['entity_type'] ?: '—').' '.$entityLink.'</td><td><span class="chip">'.e($r['report_type']).'</span></td><td style="max-width:300px"><small>'.e(mb_substr($r['description'],0,200)).'</small></td><td>'.e($r['contact_info'] ?: '—').'</td>';
        $sc=$r['status']==='resolved'?'ok glow-green':($r['status']==='dismissed'?'gold':($r['status']==='in_progress'?'':'danger'));
        echo '<td><span class="chip '.$sc.'">'.e(ucfirst($r['status'])).'</span></td>';
        echo '<td><form method="post" class="inline-form" style="display:flex;flex-direction:column;gap:4px">'.csrf_field().'<input type="hidden" name="action" value="admin_update_report"><input type="hidden" name="report_id" value="'.(int)$r['id'].'">';
        echo '<select name="status" style="margin-bottom:2px">';
        foreach(['open','in_progress','resolved','dismissed'] as $s) echo '<option value="'.e($s).'"'.($r['status']===$s?' selected':'').'>'.e(ucfirst($s)).'</option>';
        echo '</select>';
        echo '<input name="admin_notes" placeholder="Notes" value="'.e($r['admin_notes'] ?? '').'" style="font-size:12px">';
        echo '<label style="font-size:12px;display:flex;align-items:center;gap:4px"><input type="checkbox" name="notify_reporter" value="1"> Notify reporter</label>';
        echo '<button class="btn mini">Update</button></form></td></tr>';
    }
    echo '</tbody></table></div>';
}

function render_admin_email_providers(): void {
    $providers=rows('SELECT * FROM email_providers ORDER BY is_default DESC, is_active DESC, name ASC');
    echo '<div class="admin-head"><div><div class="eyebrow">Email</div><h1>Email Providers</h1><p>Configure email sending providers for report notifications, password resets, and all system outbound mail.</p></div></div>';
    echo '<section class="panel"><h3>Add / Edit Provider</h3>';
    $editId=(int)getv('edit_provider',0);
    $edit=null;
    if($editId) $edit=row('SELECT * FROM email_providers WHERE id=?',[$editId]);
    echo '<form method="post" class="admin-form compact-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_email_provider"><input type="hidden" name="provider_id" value="'.e($edit['id'] ?? '').'">';
    echo '<label><span>Name</span><input name="name" value="'.e($edit['name'] ?? '').'" placeholder="e.g. Main Sendpulse" required></label>';
    echo '<label><span>Provider type</span><select name="provider_type">';
    $types=['sendpulse'=>'Sendpulse','postmark'=>'Postmark','brevo'=>'Brevo (Sendinblue)','mailgun'=>'Mailgun','ses'=>'Amazon SES','zapier'=>'Zapier Webhook','mail'=>'PHP mail()'];
    foreach($types as $k=>$l) echo '<option value="'.e($k).'"'.(($edit['provider_type']??'')===$k?' selected':'').'>'.e($l).'</option>';
    echo '</select></label>';
    echo '<label><span>API Key / Token / Webhook URL</span><input name="api_key" value="'.e($edit['api_key'] ?? '').'" placeholder="API key or webhook URL"></label>';
    echo '<label><span>API Secret (if applicable)</span><input name="api_secret" value="'.e($edit['api_secret'] ?? '').'" placeholder="Secret key"></label>';
    echo '<label><span>Extra config (JSON)</span><textarea name="config_json" rows="3" placeholder=\'{"from_email":"noreply@angani.co.uk","from_name":"Angani Data","domain":"mg.angani.co.uk"}\'>'.e($edit['config_json'] ?? '').'</textarea></label>';
    echo '<label><span>Active</span><select name="is_active"><option value="1"'.(($edit['is_active']??'')=='1'?' selected':'').'>Yes</option><option value="0"'.((($edit['is_active']??'')=='1'||!$edit)?'':' selected').'>No</option></select></label>';
    echo '<label><span>Default (used first)</span><select name="is_default"><option value="1"'.(($edit['is_default']??'')=='1'?' selected':'').'>Yes</option><option value="0"'.((($edit['is_default']??'')=='1'||!$edit)?'':' selected').'>No</option></select></label>';
    echo '<button class="btn ink">Save provider</button></form></section>';
    echo '<section class="panel"><h3>Test Email</h3><form method="post" class="inline-form">'.csrf_field().'<input type="hidden" name="action" value="admin_test_email"><input name="test_email" type="email" placeholder="your@email.com" required style="min-width:250px"><button class="btn ink">Send test email</button></form></section>';
    echo '<section class="panel"><h3>Configured Providers</h3><div class="table-wrap"><table><thead><tr><th>Name</th><th>Type</th><th>Active</th><th>Default</th><th>Actions</th></tr></thead><tbody>';
    foreach($providers as $p){
        echo '<tr><td><strong>'.e($p['name']).'</strong></td><td><span class="chip">'.e($p['provider_type']).'</span></td><td>'.($p['is_active']?'<span class="chip ok glow-green">Active</span>':'<span class="chip">Inactive</span>').'</td><td>'.($p['is_default']?'<span class="chip ok">Yes</span>':'—').'</td><td>';
        echo '<a class="btn mini" href="?page=admin&tab=email&edit_provider='.(int)$p['id'].'">Edit</a> ';
        echo '<form method="post" style="display:inline" onsubmit="return confirm(\'Delete this provider?\')">'.csrf_field().'<input type="hidden" name="action" value="admin_delete_email_provider"><input type="hidden" name="provider_id" value="'.(int)$p['id'].'"><button class="btn mini ghost">Delete</button></form>';
        echo '</td></tr>';
    }
    echo '</tbody></table></div></section>';
}
function render_admin_pages(): void {
    echo '<section class="admin-head"><h1>Site Pages</h1><p>Edit editable page content (Terms, Privacy, Beta Status).</p></section>';
    $pages=rows('SELECT * FROM site_pages ORDER BY page_key ASC');
    foreach($pages as $p){
        echo '<section class="panel" style="margin-bottom:16px"><h3>'.e($p['title']).'</h3>';
        echo '<form method="post" class="stack-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_page"><input type="hidden" name="page_key" value="'.e($p['page_key']).'">';
        echo '<label><span>Title</span><input name="title" value="'.e($p['title']).'"></label>';
        echo '<label><span>Content (HTML allowed)</span><textarea name="content" rows="12" style="font-family:monospace;font-size:13px">'.e($p['content']).'</textarea></label>';
        echo '<button class="btn ink">Save</button></form></section>';
    }
}
function render_admin_slides(): void {
    echo '<section class="admin-head"><h1>Homepage Slider</h1><p>Manage slides that appear in the hero panel. The slider auto-rotates on the homepage.</p></section>';
    $slides=rows('SELECT * FROM site_slides ORDER BY display_order ASC');
    echo '<section class="panel"><h3>Add Slide</h3><form method="post" class="stack-form">'.csrf_field().'<input type="hidden" name="action" value="admin_save_slide">';
    echo '<label><span>Title</span><input name="title" required></label>';
    echo '<label><span>Subtitle</span><input name="subtitle"></label>';
    echo '<label><span>Image URL</span><input name="image_url" placeholder="http://..."></label>';
    echo '<label><span>Stat Label</span><input name="stat_label" placeholder="e.g. Active Airlines"></label>';
    echo '<label><span>Stat Value</span><input name="stat_value" placeholder="e.g. 9210"></label>';
    echo '<label><span>Link URL</span><input name="link_url" placeholder="?page=catalogue"></label>';
    echo '<label><span>Display Order</span><input type="number" name="display_order" value="1"></label>';
    echo '<label><span>Active</span><select name="is_active"><option value="1">Yes</option><option value="0">No</option></select></label>';
    echo '<button class="btn ink">Add Slide</button></form></section>';
    echo '<div class="table-wrap"><table><thead><tr><th>Order</th><th>Title</th><th>Image</th><th>Active</th><th>Actions</th></tr></thead><tbody>';
    foreach($slides as $s){
        echo '<tr><td>'.(int)$s['display_order'].'</td><td><strong>'.e($s['title']).'</strong><br><small>'.e($s['subtitle']??'').'</small></td><td>'.($s['image_url']?'<img src="'.e($s['image_url']).'" style="height:40px;border-radius:4px">':'').'</td><td>'.($s['is_active']?'<span class="chip ok">Yes</span>':'<span class="chip">No</span>').'</td><td>';
        echo '<form method="post" style="display:inline" onsubmit="return confirm(\'Delete this slide?\')">'.csrf_field().'<input type="hidden" name="action" value="admin_delete_slide"><input type="hidden" name="slide_id" value="'.(int)$s['id'].'"><button class="btn mini ghost">Delete</button></form>';
        echo '</td></tr>';
    }
    echo '</tbody></table></div>';
}
