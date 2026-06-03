-- Angani Data tier visibility rules
-- Run after the main schema if your database does not already have access_rules.
-- The application also creates/seeds this table lazily at runtime through ensure_access_rules_schema().

CREATE TABLE IF NOT EXISTS access_rules (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

UPDATE subscription_tiers
SET code='ultimate',
    name='Ultimate',
    description='Everything in Pro plus bulk/API access, private dashboards, custom data services and advisory support configured around the client’s needs.',
    updated_at=NOW()
WHERE code='enterprise';

INSERT INTO access_rules (scope_type,scope_key,label,min_tier,is_active,notes,created_at)
VALUES
('module','countries','Countries listing','public',1,'Visitors can browse and expand country cards before signing in.',NOW()),
('module','airlines','Airlines listing','public',1,'Visitors can browse and expand airline cards before signing in.',NOW()),
('module','airports','Airports listing','public',1,'Visitors can browse and expand airport cards before signing in.',NOW()),
('module','aircraft','Aircraft registry listing','public',1,'Visitors can preview aircraft cards; full records require an account.',NOW()),
('module','aircraft_types','Aircraft Types listing','public',1,'Visitors can browse and expand type cards before signing in.',NOW()),
('detail','countries','Country full detail','free',1,'A free account can open standard country detail pages.',NOW()),
('detail','airlines','Airline full detail','free',1,'A free account can open standard airline detail pages.',NOW()),
('detail','airports','Airport full detail','free',1,'A free account can open standard airport detail pages.',NOW()),
('detail','aircraft','Aircraft registry full detail','free',1,'A free account can open aircraft registry detail pages unless upgraded by admin.',NOW()),
('detail','aircraft_types','Aircraft Type full detail','free',1,'A free account can open standard aircraft type detail pages.',NOW()),
('section','aircraft_types:economics','Aircraft monthly lease rates / economics','pro',1,'Protect lease rates, operating costs and residual-value intelligence.',NOW()),
('section','airlines:commercial','Airline commercial intelligence','pro',1,'Protect loyalty, commercial and revenue-related analysis.',NOW()),
('section','airlines:people','Airline careers / key personnel','pro',1,'Protect airline people, careers and contact-style intelligence.',NOW()),
('module','aircraft_economic_data','Aircraft economic data module','pro',1,'Protect lease-rate and operating-cost datasets.',NOW()),
('module','airline_people','Airline people / careers module','pro',1,'Protect staff, people and career-related datasets.',NOW()),
('module','source_records','Source records','pro',1,'Protect raw source material and screenshots.',NOW()),
('module','change_log','Change log','pro',1,'Protect data-change intelligence.',NOW()),
('module','import_batches','Import batches','ultimate',1,'Operational/admin-style metadata.',NOW()),
('module','staging_records','Staging records','ultimate',1,'Operational/admin-style metadata.',NOW()),
('module','export_logs','Export logs','ultimate',1,'Operational/admin-style metadata.',NOW()),
('report','generated_reports','Generated reports','pro',1,'Generated reports are premium intelligence by default.',NOW())
ON DUPLICATE KEY UPDATE
  label=VALUES(label),
  min_tier=VALUES(min_tier),
  is_active=VALUES(is_active),
  notes=VALUES(notes),
  updated_at=NOW();
