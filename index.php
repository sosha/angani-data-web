<?php
require_once 'db.php';

function renderMarkdown($content) {
    // Basic Markdown Rendering with Regex
    
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
        if (preg_match('/^([-*]) \[(.)\] (.*)/', $trimmed, $matches)) {
            if (!$inList) { $html .= "<ul class='todo-list'>"; $inList = true; }
            $checked = ($matches[2] === 'x') ? 'checked' : '';
            $statusClass = ($matches[2] === 'x') ? 'done' : (($matches[2] === '/') ? 'in-progress' : '');
            $html .= "<li class='$statusClass'><input type='checkbox' $checked disabled> " . $matches[3] . "</li>";
        } elseif (preg_match('/^    ([-*]) \[(.)\] (.*)/', $line, $matches)) {
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
    <style>
        .dashboard-grid { display: grid; grid-template-columns: 1.6fr 1fr; gap: 2.5rem; margin-top: 1rem; }
        
        /* GitHub-style Markdown */
        .markdown-body { 
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            line-height: 1.6;
            word-wrap: break-word;
            color: var(--text);
        }
        .markdown-body h1, .markdown-body h2, .markdown-body h3 { 
            border-bottom: 1px solid var(--border); 
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
            font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace;
        }
        .markdown-body ul { padding-left: 2rem; margin-bottom: 1rem; }
        .markdown-body a { color: var(--accent-color); text-decoration: none; }
        .markdown-body a:hover { text-decoration: underline; }
        
        /* Mission Status Styling */
        .todo-list { padding-left: 0 !important; }
        .todo-list li { 
            list-style: none; 
            padding: 0.5rem;
            border-left: 3px solid transparent;
            margin-bottom: 2px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .todo-list li:hover { background: rgba(255,255,255,0.02); }
        .todo-list li.in-progress { 
            border-left-color: var(--accent-color); 
            background: rgba(99, 102, 241, 0.05);
            font-weight: 500;
        }
        .todo-list input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: default;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'home'; include 'header.php'; ?>
        </header>

        <main>
            <div class="dashboard-grid">
                <section class="card markdown-body">
                    <div class="content">
                        <?php 
                        $readme = file_get_contents('README.md');
                        echo renderMarkdown($readme);
                        ?>
                    </div>
                </section>

                <section class="card">
                    <h2>Mission Status (To-Do)</h2>
                    <div class="todo-viewer markdown-body">
                        <?php 
                        $todo = file_get_contents('todo.md');
                        echo renderMarkdown($todo);
                        ?>
                    </div>
                    <div style="margin-top: 1.5rem; border-top: 1px solid var(--border); padding-top: 1rem;">
                        <h3>Quick Actions</h3>
                        <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                            <a href="tracking.php" class="btn" style="background: var(--accent-color);">📡 Launch Live Tracker</a>
                            <a href="viewer.php" class="btn btn-secondary">Browse Aircraft & Airports</a>
                            <a href="import.php" class="btn btn-secondary">Import New Datasets</a>
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>
</body>
</html>
