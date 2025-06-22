-- ─────────────────────────────────────────
-- INDUSTRY + BUSINESS ACCOUNT SEED SCRIPT
-- Author: MachiGPT
-- ─────────────────────────────────────────

-- Clean existing records in FK order
DELETE FROM products;
DELETE FROM subcategories;
DELETE FROM categories;
DELETE FROM taxes;
DELETE FROM branches;
DELETE FROM business_accounts;
DELETE FROM industries;

-- Insert Industries
INSERT INTO industries (id, name, code) VALUES
  ('RES-0001', 'Restaurant', 'industry_rest'),
  ('CLI-0001', 'Clinic', 'industry_clinic'),
  ('SAL-0001', 'Salon', 'industry_salon'),
  ('AUT-0001', 'Automobile', 'industry_auto'),
  ('ELC-0001', 'Electronics Store', 'industry_elc');

-- Insert Business Accounts (replace owner_id later if needed)
INSERT INTO business_accounts (id, name, industry_id, owner_id, features_enabled) VALUES
  ('BIZ-RES-0001', 'KickGrass Restaurant', 'RES-0001', 'USR-0001', '{}'),
  ('BIZ-CLI-0001', 'DrCare Clinic',        'CLI-0001', 'USR-0001', '{}'),
  ('BIZ-SAL-0001', 'GlowUp Salon',         'SAL-0001', 'USR-0001', '{}'),
  ('BIZ-AUT-0001', 'AutoHub Garage',       'AUT-0001', 'USR-0001', '{}'),
  ('BIZ-ELC-0001', 'ElectroWorld Store',   'ELC-0001', 'USR-0001', '{}');

-- (Optional) Insert default Branch for each business (if needed)
INSERT INTO branches (id, business_id, name, address, state, phone, email, gst_number) VALUES
  ('BR-RES-001', 'BIZ-RES-0001', 'Kick Grass Restaurant Main', '173, Lakeview Ave, Munnar Road, Udumalpet', 'Tamil Nadu', '+91 98867 98832', 'kickgrass@food.com', '33JKLG7645N1J'),
  ('BR-CLI-001', 'BIZ-CLI-0001', 'DrCare Clinic Main', '51, Aishwarya Nagar, Udumalpet', 'Tamil Nadu', '+91 98867 98822', 'drcare@health.com', '33UHLG7645N1K'),
  ('BR-SAL-001', 'BIZ-SAL-0001', 'GlowUp Salon Main', '82, Gandhi Nagar, Udumalpet', 'Tamil Nadu', '+91 98867 98811', 'glowup@salon.com', '32GSKJ7265N2M'),
  ('BR-AUT-001', 'BIZ-AUT-0001', 'AutoHub Garage Main', '186, Periyakottai Pirivu, Udumalpet', 'Tamil Nadu', '+91 98867 98844', 'autohub@garage.com', '31DGLF5134R3H'),
  ('BR-ELC-001', 'BIZ-ELC-0001', 'ElectroWorld Store Main', '67, Pollachi Road, Udumalpet', 'Tamil Nadu', '+91 98867 98855', 'electroworld@store.com', '23DKFF6434L3M');

-- (Optional) Insert default Tax for Restaurant
INSERT INTO taxes (type, business_id, name, rate) VALUES
  ('GST', 'BIZ-RES-0001', 'GST 5%', 5.0),
  ('GST', 'BIZ-RES-0001', 'GST 12%', 12.0),
  ('GST', 'BIZ-RES-0001', 'GST 18%', 18.0),
  ('GST', 'BIZ-RES-0001', 'GST 28%', 28.0);
