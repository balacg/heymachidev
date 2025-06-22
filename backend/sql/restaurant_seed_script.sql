
-- Insert Categories
INSERT INTO categories (id, name, gst_id, business_id) VALUES
('CAT-BIZ-RES-0001', 'Chicken-Appetizers', 1, 'BIZ-RES-0001'),
('CAT-BIZ-RES-0002', 'Veg-Appetizers', 1, 'BIZ-RES-0001'),
('CAT-BIZ-RES-0003', 'Curries (Chicken)', 1, 'BIZ-RES-0001'),
('CAT-BIZ-RES-0004', 'Curries (Veg & Egg)', 1, 'BIZ-RES-0001'),
('CAT-BIZ-RES-0005', 'Rice & Noodles', 1, 'BIZ-RES-0001');

-- Insert Subcategories
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001', '65', 'CAT-BIZ-RES-0001', 1, 'BIZ-RES-0001'),
('SUBCAT-BIZ-RES-0002', 'Chilli', 'CAT-BIZ-RES-0001', 1, 'BIZ-RES-0001'),
('SUBCAT-BIZ-RES-0003', 'Tikka', 'CAT-BIZ-RES-0001', 1, 'BIZ-RES-0001');

-- Insert Products
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001', 'Chicken 65', 180.0, 'CAT-BIZ-RES-0001', 'SUBCAT-BIZ-RES-0001', 1, 1, true, 'BIZ-RES-0001'),
('PRD-BIZ-RES-0002', 'Babycorn 65', 170.0, 'CAT-BIZ-RES-0002', 'SUBCAT-BIZ-RES-0001', 1, 1, true, 'BIZ-RES-0001'),
('PRD-BIZ-RES-0003', 'Chilli Chicken', 190.0, 'CAT-BIZ-RES-0001', 'SUBCAT-BIZ-RES-0002', 1, 1, true, 'BIZ-RES-0001'),
('PRD-BIZ-RES-0004', 'Chilli Paneer', 180.0, 'CAT-BIZ-RES-0002', 'SUBCAT-BIZ-RES-0002', 1, 1, true, 'BIZ-RES-0001');
