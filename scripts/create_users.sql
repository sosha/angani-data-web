CREATE TABLE IF NOT EXISTS subscription_tiers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(40) NOT NULL UNIQUE,
  name VARCHAR(80) NOT NULL,
  description TEXT DEFAULT NULL,
  monthly_usd DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  annual_usd DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  search_limit_daily INT NOT NULL DEFAULT 0,
  export_limit_monthly INT NOT NULL DEFAULT 0,
  api_limit_monthly INT NOT NULL DEFAULT 0,
  display_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_tier_order (display_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO subscription_tiers (id, code, name, description, monthly_usd, annual_usd, search_limit_daily, export_limit_monthly, api_limit_monthly, display_order, is_active) VALUES
(1, 'free', 'Free', 'Basic access to aviation data', 0, 0, 50, 5, 0, 1, 1),
(2, 'pro', 'Pro', 'Professional aviation data access', 29, 290, 500, 100, 1000, 2, 1),
(3, 'ultimate', 'Ultimate', 'Full unlimited access to all aviation data', 99, 990, 999999, 999999, 50000, 3, 1);

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(190) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  tier_id INT UNSIGNED NOT NULL,
  role ENUM('user','admin') NOT NULL DEFAULT 'user',
  status ENUM('active','suspended','deleted') NOT NULL DEFAULT 'active',
  email_verified_at DATETIME DEFAULT NULL,
  last_login_at DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_users_tier (tier_id),
  CONSTRAINT fk_users_tier FOREIGN KEY (tier_id) REFERENCES subscription_tiers(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO users (id, name, email, password_hash, tier_id, role, status)
SELECT 1, username, email, password_hash, 1, 'admin', IF(is_active, 'active', 'suspended')
FROM admin_users WHERE username = 'admin';
