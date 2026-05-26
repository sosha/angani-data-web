<?php
function db(): PDO { static $pdo=null; if($pdo instanceof PDO) return $pdo; $c=require __DIR__.'/config.php'; $dsn=sprintf('mysql:host=%s;port=%s;dbname=%s;charset=%s',$c['host'],$c['port'],$c['database'],$c['charset']); $pdo=new PDO($dsn,$c['username'],$c['password'],[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,PDO::ATTR_EMULATE_PREPARES=>false]); return $pdo; }
function rows(string $sql,array $params=[]):array{$s=db()->prepare($sql);$s->execute($params);return $s->fetchAll();}
function row(string $sql,array $params=[]):?array{$s=db()->prepare($sql);$s->execute($params);$r=$s->fetch();return $r===false?null:$r;}
function scalar(string $sql,array $params=[]){$s=db()->prepare($sql);$s->execute($params);return $s->fetchColumn();}
