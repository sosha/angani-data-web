-- =============================================================================
-- Migration: Site content management & data quality tracking
-- site_pages – editable static pages (terms, privacy, beta-status, etc.)
-- site_slides – homepage hero slider configuration
-- record_verifications – user completeness/accuracy markings per record
-- =============================================================================

CREATE TABLE IF NOT EXISTS site_pages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  page_key VARCHAR(80) NOT NULL UNIQUE,
  title VARCHAR(255) NOT NULL,
  content LONGTEXT DEFAULT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO site_pages (page_key, title, content) VALUES
('terms','Terms and Conditions','<h2>Terms and Conditions</h2><p>The data provided through the Aviation Intelligence Atlas is furnished on an "as is" basis. Angani Solutions makes no warranties, express or implied, regarding the accuracy, completeness, reliability, or timeliness of any data presented. Users rely on the data at their own risk. Angani Solutions shall not be held liable for any inaccuracies, omissions, errors, or any damages arising from the use of this platform.</p><p>By accessing this platform, you agree to these terms. All data is for informational purposes only and should not be used as the sole basis for operational, financial, or safety-critical decisions. Always cross-reference with official sources and national aviation authorities.</p>'),
('privacy','Privacy Policy','<h2>Privacy Policy</h2><p>Angani Solutions is committed to protecting your privacy. Any personal data you provide to us — including your name, email address, and organisation details — will be stored securely and processed in accordance with the UK General Data Protection Regulation (UK GDPR) and the Data Protection Act 2018.</p><p>We collect only the information necessary to provide you with access to the Aviation Intelligence Atlas platform. Your data will not be sold, traded, or shared with third parties for marketing purposes. We implement appropriate technical and organisational measures to safeguard your information against unauthorised access, alteration, disclosure, or destruction.</p><p>You have the right to request access to, correction of, or deletion of your personal data at any time by contacting us. We retain your data only as long as necessary to provide our services or as required by law.</p>'),
('beta-status','Beta Status','<h2>Beta Status — Aviation Intelligence Atlas</h2><p>The Aviation Intelligence Atlas is currently in beta. This means the platform is still a work in progress and may contain errors, omissions, incomplete datasets, and unverified information. We are actively working to improve data quality and expand coverage.</p><p>While we strive for accuracy, some records may be incomplete or based on sources that have not yet been fully validated. We encourage users to check the <a href="?page=data-quality">Data Quality page</a> for the current verification and completeness status of individual datasets before relying on any specific data point.</p><p>Your feedback is invaluable. If you encounter any issues or have suggestions, please use the "Report Data Problem" feature available on every record or contact our support team directly.</p><p>Thank you for being part of our beta programme.</p>');

CREATE TABLE IF NOT EXISTS site_slides (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  slide_key VARCHAR(80) DEFAULT NULL,
  title VARCHAR(255) NOT NULL,
  subtitle VARCHAR(255) DEFAULT NULL,
  image_url VARCHAR(500) DEFAULT NULL,
  stat_label VARCHAR(120) DEFAULT NULL,
  stat_value VARCHAR(40) DEFAULT NULL,
  link_url VARCHAR(500) DEFAULT NULL,
  display_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_slides_order (display_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO site_slides (slide_key, title, subtitle, image_url, stat_label, link_url, display_order) VALUES
('airlines','Active Airlines','Browse our comprehensive airline registry with fleet details and operational status.','http://43.134.34.14/assets/site_images/airlines.webp','airlines','?page=catalogue&module=airlines',1),
('aircraft_types','Aircraft Types','Explore detailed specifications for aircraft models across all manufacturers.','http://43.134.34.14/assets/site_images/plane.gif','aircraft_types','?page=catalogue&module=aircraft_types',2),
('airport_aips','Airport AIPs','Access aerodrome information publications with full AD 2.x data.','http://43.134.34.14/assets/site_images/navigation.gif','airports','?page=catalogue&module=airports',3);

CREATE TABLE IF NOT EXISTS record_verifications (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  entity_type VARCHAR(80) NOT NULL,
  entity_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED DEFAULT NULL,
  completeness ENUM('complete','incomplete') DEFAULT NULL,
  accuracy ENUM('accurate','inaccurate','unverified') DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_verification (entity_type, entity_id, user_id),
  INDEX idx_verification_type (entity_type, entity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
