-- 10_airline_logos.sql
-- Add logo_url to v2 airlines table and copy from legacy

SET @exist := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='airlines' AND column_name='logo_url');
SET @sql := IF(@exist=0,
  'ALTER TABLE airlines ADD COLUMN logo_url TEXT DEFAULT NULL AFTER active',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

UPDATE airlines a
  JOIN legacy_airlines l ON l.icao_code = a.icao_code
  SET a.logo_url = l.logo_url
  WHERE l.logo_url IS NOT NULL AND l.logo_url != '';

SET @exist2 := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='airlines' AND column_name='status');
SET @sql2 := IF(@exist2=0,
  'ALTER TABLE airlines ADD COLUMN status VARCHAR(80) DEFAULT NULL AFTER active',
  'SELECT 1');
PREPARE stmt2 FROM @sql2; EXECUTE stmt2; DEALLOCATE PREPARE stmt2;

UPDATE airlines a
  JOIN legacy_airlines l ON l.icao_code = a.icao_code
  SET a.status = l.status_bucket
  WHERE l.status_bucket IS NOT NULL;
