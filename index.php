<?php
// AnganiData Dashboard — CSV-native, no database required

function renderMarkdown($content) {
    // Headers
    $content = preg_replace('/^# (.*)$/m', '<h1>$1</h1>', $content);
    $content = preg_replace('/^## (.*)$/m', '<h2>$1</h2>', $content);
    $content = preg_replace('/^### (.*)$/m', '<h3>$1</h3>', $content);
    
    // Bold
    $content = preg_replace('/\*\*(.*?)\*\*/', '<strong>$1</strong>', $content);
    
    // Links [text](url)
    $content = preg_replace('/\[(.*?)\]\((.*?)\)/', '<a href="$2">$1</a>', $content);
    
    // Inline Code
    $content = preg_replace('/`(.*?)`/', '<code>$1</code>', $content);
    
    // Logic for Lists and Tasks
    $lines = explode("\n", $content);
    $html = "";
    $inList = false;
    
    foreach ($lines as $line) {
        $trimmed = trim($line);
        if (empty($trimmed)) {
            if ($inList) { $html .= "</ul>"; $inList = false; }
            continue;
        }

        // Check for Tasks/Lists
        if (preg_match('/^([-*]) \[(.)]\s(.*)/', $trimmed, $matches)) {
            if (!$inList) { $html .= "<ul class='todo-list'>"; $inList = true; }
            $checked = ($matches[2] === 'x') ? 'checked' : '';
            $statusClass = ($matches[2] === 'x') ? 'done' : (($matches[2] === '/') ? 'in-progress' : '');
            $html .= "<li class='$statusClass'><input type='checkbox' $checked disabled> " . $matches[3] . "</li>";
        } elseif (preg_match('/^    ([-*]) \[(.)]\s(.*)/', $line, $matches)) {
            if (!$inList) { $html .= "<ul class='todo-list'>"; $inList = true; }
            $checked = ($matches[2] === 'x') ? 'checked' : '';
            $statusClass = ($matches[2] === 'x') ? 'done' : (($matches[2] === '/') ? 'in-progress' : '');
            $html .= "<li class='$statusClass' style='margin-left: 20px;'><input type='checkbox' $checked disabled> " . $matches[3] . "</li>";
        } elseif (preg_match('/^([-*]) (.*)/', $trimmed, $matches)) {
            if (!$inList) { $html .= "<ul>"; $inList = true; }
            $html .= "<li>" . $matches[2] . "</li>";
        } else {
            if ($inList && !str_starts_with($line, "    ")) { $html .= "</ul>"; $inList = false; }
            
            // If it's not a block element already, wrap in P
            if (!preg_match('/^<(h1|h2|h3|ul|li|p|div|section)/', $line)) {
                $html .= "<p>" . $line . "</p>";
            } else {
                $html .= $line;
            }
        }
    }
    if ($inList) $html .= "</ul>";
    
    return $html;
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .dashboard-grid { display: grid; grid-template-columns: 1.6fr 1fr; gap: 2.5rem; margin-top: 1rem; }
        @media (max-width: 900px) { .dashboard-grid { grid-template-columns: 1fr; } }
        
        /* GitHub-style Markdown */
        .markdown-body { 
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            line-height: 1.6;
            word-wrap: break-word;
            color: var(--text-color);
        }
        .markdown-body h1, .markdown-body h2, .markdown-body h3 { 
            border-bottom: 1px solid var(--border-color); 
            padding-bottom: 0.3em; 
            margin-top: 1.5rem; 
            margin-bottom: 1rem;
            font-weight: 600;
        }
        .markdown-body p { margin-bottom: 1rem; }
        .markdown-body code { 
            padding: 0.2rem 0.4rem; 
            background: rgba(175, 184, 193, 0.2); 
            border-radius: 6px; 
            font-size: 85%;
            font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace;
        }
        .markdown-body ul { padding-left: 2rem; margin-bottom: 1rem; }
        .markdown-body a { color: var(--primary-color); text-decoration: none; }
        .markdown-body a:hover { text-decoration: underline; }
        
        /* Stats cards */
        .stats-row { display: flex; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap; }
        .stat-card {
            flex: 1; min-width: 120px;
            background: var(--card-bg); border: 1px solid var(--border-color);
            border-radius: 0.75rem; padding: 1.25rem; text-align: center;
        }
        .stat-card .val {
            font-size: 1.8rem; font-weight: 800;
            background: linear-gradient(135deg, #818cf8, #c084fc);
            -webkit-background-clip: text; background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .stat-card .lbl {
            font-size: 0.7rem; text-transform: uppercase;
            letter-spacing: 0.08em; color: var(--text-muted); margin-top: 0.2rem;
        }

        /* Todo */
        .todo-list { padding-left: 0 !important; }
        .todo-list li { 
            list-style: none; padding: 0.5rem;
            border-left: 3px solid transparent;
            margin-bottom: 2px; display: flex;
            align-items: center; gap: 10px;
        }
        .todo-list li:hover { background: rgba(255,255,255,0.02); }
        .todo-list li.in-progress { 
            border-left-color: var(--primary-color); 
            background: rgba(99, 102, 241, 0.05); font-weight: 500;
        }
        .todo-list input[type="checkbox"] { width: 16px; height: 16px; cursor: default; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'home'; include 'header.php'; ?>
        </header>

        <main>
            <!-- Live Stats -->
            <div class="stats-row" id="stats-row">
                <div class="stat-card"><div class="val" id="d-folders">—</div><div class="lbl">Folders</div></div>
                <div class="stat-card"><div class="val" id="d-files">—</div><div class="lbl">CSV Files</div></div>
                <div class="stat-card"><div class="val" id="d-records">—</div><div class="lbl">Total Records</div></div>
                <div class="stat-card"><div class="val" id="d-countries">—</div><div class="lbl">Countries</div></div>
            </div>

            <div class="dashboard-grid">
                <section class="card markdown-body">
                    <div class="content">
                        <?php 
                        $readme = @file_get_contents('README.md');
                        echo $readme ? renderMarkdown($readme) : '<p>README.md not found.</p>';
                        ?>
                    </div>
                </section>

                <section class="card">
                    <h2>Mission Status (To-Do)</h2>
                    <div class="todo-viewer markdown-body">
                        <?php 
                        $todo = @file_get_contents('todo.md');
                        echo $todo ? renderMarkdown($todo) : '<p>No active tasks.</p>';
                        ?>
                    </div>
                    <div style="margin-top: 1.5rem; border-top: 1px solid var(--border-color); padding-top: 1rem;">
                        <h3>Quick Actions</h3>
                        <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                            <a href="datasets.php" class="btn" style="background: linear-gradient(135deg, #6366f1, #8b5cf6); font-weight: 700;">📂 Browse & Edit Datasets</a>
                            <a href="batch_import.php" class="btn btn-secondary">📥 Batch Import Data</a>
                            <a href="manage.php" class="btn btn-secondary">⚙️ Create / Upload / Delete CSVs</a>
                            <a href="tracking.php" class="btn btn-secondary">📡 Launch Live Tracker</a>
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>

    <script>
    // Load live stats from the CSV tree API
    fetch('api_datasets.php?action=tree')
        .then(r => r.json())
        .then(tree => {
            let folders = 0, files = 0, records = 0, countries = 0;
            function walk(items, depth) {
                items.forEach(i => {
                    if (i.type === 'file') { files++; records += i.records || 0; }
                    else {
                        folders++;
                        if (depth === 1 && i.name === 'Countries' && i.children) {
                            countries = i.children.filter(c => c.type === 'folder').length;
                        }
                        if (i.children) walk(i.children, depth + 1);
                    }
                });
            }
            walk(tree, 0);
            document.getElementById('d-folders').textContent = folders.toLocaleString();
            document.getElementById('d-files').textContent = files.toLocaleString();
            document.getElementById('d-records').textContent = records.toLocaleString();
            document.getElementById('d-countries').textContent = countries || '249';
        })
        .catch(() => {});
    </script>
</body>
</html>
