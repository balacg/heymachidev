-- Insert Categories
INSERT INTO categories (id, name, gst_id, business_id) VALUES
('CAT-BIZ-RES-0001-0001', 'Veg-Appetizers', 1, 'BIZ-RES-0001');
INSERT INTO categories (id, name, gst_id, business_id) VALUES
('CAT-BIZ-RES-0001-0002', 'Chicken-Appetizers', 1, 'BIZ-RES-0001');
INSERT INTO categories (id, name, gst_id, business_id) VALUES
('CAT-BIZ-RES-0001-0003', 'Seafood-Appetizers', 1, 'BIZ-RES-0001');
INSERT INTO categories (id, name, gst_id, business_id) VALUES
('CAT-BIZ-RES-0001-0004', 'Common', 1, 'BIZ-RES-0001');
INSERT INTO categories (id, name, gst_id, business_id) VALUES
('CAT-BIZ-RES-0001-0005', 'Mutton-Appetizers', 1, 'BIZ-RES-0001');

-- Insert Subcategories
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0001', '65', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0002', '99 Non', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0003', 'General', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0004', 'American Chopsey', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0005', 'Arabian Delight', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0006', 'Authentic Soup', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0007', 'BBQ Chicken Pizza', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0008', 'Bhurji', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0009', 'Blackcurrent', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0010', 'Boiled Egg', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0011', 'Breads', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0012', 'Butterscotch', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0013', 'Chefs Delight Atta Roll', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0014', 'Chettinadu Fry', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0015', 'Chicken Burger', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0016', 'Chicken Classic', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0017', 'Chicken Kola Urundai', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0018', 'Chicken Lollypop', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0019', 'Chicken Pasta', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0020', 'Chicken Pizza', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0021', 'Chicken Supreme Pizza', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0022', 'Chicken Tangri Kebab', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0023', 'Chilli', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0024', 'Chinese Chopsey', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0025', 'Chocolate', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0026', 'Clear Soup', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0027', 'Coconut Oil', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0028', 'Coffee Brazillia', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0029', 'Combo Meal', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0030', 'Crab', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0031', 'Cream of Soup', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0032', 'Dirty Sandwich Sizzler', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0033', 'Double Patty', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0034', 'Drums of Heaven', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0035', 'Egg', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0036', 'Fire Cooked', 'CAT-BIZ-RES-0001-0003', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0037', 'Fried', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0038', 'Fried Rice', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0039', 'Fusion Burger', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0040', 'Green Tea', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0041', 'Grilled Fish', 'CAT-BIZ-RES-0001-0003', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0042', 'Hariyali Smoked', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0043', 'Hariyali Tikka', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0044', 'Hot n Sour Soup', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0045', 'Karaikudi thokku', 'CAT-BIZ-RES-0001-0003', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0046', 'Large Size', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0047', 'Lasagna', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0048', 'Lime Juice', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0049', 'Lime Soda', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0050', 'Lollypop 5 pcs', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0051', 'Malai Kebab', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0052', 'Manchow Soup', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0053', 'Manchurian', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0054', 'Mango', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0055', 'Margherita Pizza', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0056', 'Masala Fried Fish', 'CAT-BIZ-RES-0001-0003', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0057', 'Matar', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0058', 'Mint Lime Juice', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0059', 'Mint Lime Soda', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0060', 'Mixed Fried Rice', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0061', 'Mixed Non', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0062', 'Mixed Noodles', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0063', 'Mushroom Pizza', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0064', 'Mushroom', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0065', 'Non', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0066', 'Noodle', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0067', 'Noodles', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0068', 'Organic Small Bee Honey', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0069', 'Pallipalayam', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0070', 'Paneer Pizza', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0071', 'Paneer', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0072', 'Pepper Fry', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0073', 'Peppy Paneer, Babycorn & Mushroom', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0074', 'Pepsi', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0075', 'Peri Peri Chicken Pizza', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0076', 'Pesto Pasta', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0077', 'Pink Pasta', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0078', 'Pistanut', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0079', 'Pita Half Pocket', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0080', 'Platter', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0081', 'Royal Buffet', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0082', 'Salt & Pepper', 'CAT-BIZ-RES-0001-0001', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0083', 'Schezwan Fried Rice', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0084', 'Schezwan Noodles', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0085', 'Seafood Pizza', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0086', 'Sheek Kebab', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0087', 'Shorba', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0088', 'Smoked', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0089', 'Smoked Chicken & Pineapple Pizza', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0090', 'Strawberry', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0091', 'Sukka', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0092', 'Sweetcorn Soup', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0093', 'Tandoori Chicken', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0094', 'Tandoori Grilled', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0095', 'Tawa Chicken', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0096', 'Tawa Toasted Chicken', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0097', 'Thai Basil Fried Rice', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0098', 'Thai Basil Noodles', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0099', 'Tikka', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0100', 'Tikkis', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0101', 'V'Day Special', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0102', 'Vanilla', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0103', 'Veg Buffet', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0104', 'Veg Pasta', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0105', 'Veg Supreme Pizza', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0106', 'Veggie Classic', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0107', 'Veggie Cloud 9', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0108', 'Water Bottle', 'CAT-BIZ-RES-0001-0004', 1, 'BIZ-RES-0001');
INSERT INTO subcategories (id, name, category_id, gst_id, business_id) VALUES
('SUBCAT-BIZ-RES-0001-0109', 'Wheat Kothu Parotta', 'CAT-BIZ-RES-0001-0002', 1, 'BIZ-RES-0001');

-- For Curries
INSERT INTO subcategories (id, name, category_id, business_id)
VALUES 
('SUBCAT-VEG-CURRIES', 'Veg', 'CAT-CURRIES', 'BIZ-RES-0001'),
('SUBCAT-NON_VEG-CURRIES', 'Non Veg', 'CAT-CURRIES', 'BIZ-RES-0001');

-- For Noodles
INSERT INTO subcategories (id, name, category_id, business_id)
VALUES 
('SUBCAT-VEG-NOODLES', 'Veg', 'CAT-NOODLES', 'BIZ-RES-0001'),
('SUBCAT-NON_VEG-NOODLES', 'Non Veg', 'CAT-NOODLES', 'BIZ-RES-0001');

-- For Soups
INSERT INTO subcategories (id, name, category_id, business_id)
VALUES 
('SUBCAT-VEG-SOUPS', 'Veg', 'CAT-SOUPS', 'BIZ-RES-0001'),
('SUBCAT-NON_VEG-SOUPS', 'Non Veg', 'CAT-SOUPS', 'BIZ-RES-0001');

-- For Sandwiches
INSERT INTO subcategories (id, name, category_id, business_id)
VALUES 
('SUBCAT-VEG-SANDWICHES', 'Veg', 'CAT-SANDWICHES', 'BIZ-RES-0001'),
('SUBCAT-NON_VEG-SANDWICHES', 'Non Veg', 'CAT-SANDWICHES', 'BIZ-RES-0001');

-- For Pizzas
INSERT INTO subcategories (id, name, category_id, business_id)
VALUES 
('SUBCAT-VEG-PIZZAS', 'Veg', 'CAT-PIZZAS', 'BIZ-RES-0001'),
('SUBCAT-NON_VEG-PIZZAS', 'Non Veg', 'CAT-PIZZAS', 'BIZ-RES-0001');


-- Insert Products
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0001', '65 - Babycorn', 170.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0002', '65 - Chicken', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0003', '65 - Egg', 100.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0004', '65 - Fish', 270.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0005', '65 - Gobi', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0006', '65 - Mushroom', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0007', '65 - Paneer', 170.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0008', '65 - Prawn', 270.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0001', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0009', '99 Non-Veg Combo', 99.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0002', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0010', 'Aloo Capsicum', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0011', 'Aloo Gobi Masala', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0012', 'Aloo Jeera', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0013', 'Aloo Matar', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0014', 'Aloo Paneer Masala', 210.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0015', 'American Chopsey - Chicken', 290.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0004', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0016', 'American Chopsey - Veg', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0004', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0017', 'American Chopsey - Veg  - old', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0004', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0018', 'Apple Juice', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0019', 'Apple Pie', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0020', 'Apple Pie with Icecream', 125.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0021', 'Appuchi Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0022', 'Arabian Delight - I/C - Regular', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0005', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0023', 'Arabian Delight - I/C - Single', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0005', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0024', 'Arabian Delight M/S', 150.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0025', 'Assorted Veg Platter', 380.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0026', 'Authentic Soup - Chicken', 100.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0006', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0027', 'Authentic Soup - Mutton', 120.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0006', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0028', 'Authentic Soup - Tomato', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0006', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0029', 'Authentic Soup - Veg', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0006', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0030', 'Baked Vegetables', 160.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0031', 'BBQ Chicken Grilled Sandwich', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0032', 'BBQ Chicken Pizza - Large', 380.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0007', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0033', 'BBQ Chicken Pizza - Regular', 280.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0007', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0034', 'BBQ Prawns with Roast Chilli Salsa', 200.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0035', 'Bengali Fish Gravy', 190.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0036', 'Bhurji - Egg', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0008', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0037', 'Bhurji - Paneer', 130.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0008', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0038', 'Bindi Kadai', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0039', 'Bindi Masala', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0040', 'Black Coffee', 15.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0041', 'Black Tea', 15.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0042', 'Blackcurrent - I/C - Regular', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0009', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0043', 'Blackcurrent - I/C - Single', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0009', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0044', 'Blackcurrent M/S', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0045', 'Boiled Egg - 2 Pieces', 30.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0010', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0046', 'Bone Chicken', 140.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0047', 'Bread Butter Jam Toast', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0048', 'Bread Omlette', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0049', 'Breads - Aloo Kulcha', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0050', 'Breads - Aloo Paratha', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0051', 'Breads - Butter Kulcha', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0052', 'Breads - Butter Naan', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0053', 'Breads - Butter Roti', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0054', 'Breads - Garlic Naan', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0055', 'Breads - Gobi Paratha', 120.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0056', 'Breads - Kulcha', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0057', 'Breads - Naan', 45.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0058', 'Breads - Paneer Kulcha', 140.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0059', 'Breads - Paneer Paratha', 140.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0060', 'Breads - Tandoori Roti', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0011', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0061', 'Brownie', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0062', 'Brownie Sizzlers', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0063', 'Brownie with Icecream', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0064', 'Bruschetta', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0065', 'Butter Chicken Masala', 270.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0066', 'Buttermilk', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0067', 'Butterscotch - I/C - Regular', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0012', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0068', 'Butterscotch - I/C - Single', 45.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0012', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0069', 'Butterscotch M/S', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0070', 'Caramel Blast', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0071', 'Caribbean Chicken', 170.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0072', 'Cashew Pulao', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0073', 'Channa Masala', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0074', 'Chapati', 25.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0075', 'Cheese Garlic Bread', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0076', 'Chef''s Delight Atta Roll - Chicken', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0013', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0077', 'Chef''s Delight Atta Roll - Veg', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0013', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0078', 'Chettinadu Chicken Masala', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0079', 'Chettinadu Fry', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0080', 'Chettinadu Fry - Chicken', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0014', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0081', 'Chettinadu Fry - Fish', 180.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0014', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0082', 'Chettinadu Fry - Nandu Vadai', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0014', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0083', 'Chettinadu Fry - Prawn', 180.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0014', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0084', 'Chettinadu Kari Varuval', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0085', 'Chettinadu Muttai Kulambu', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0086', 'Chicken', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0087', 'Chicken Biryani', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0088', 'Chicken Burger', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0089', 'Chicken Burger - Double Patty', 300.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0015', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0090', 'Chicken Cheese Sandwich', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0091', 'Chicken Classic - Large', 340.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0016', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0092', 'Chicken Classic - Large', 360.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0016', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0093', 'Chicken Classic - Medium', 200.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0016', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0094', 'Chicken Classic - Regular', 260.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0016', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0095', 'Chicken Club Sandwich', 140.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0096', 'Chicken Fried Rice', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0097', 'Chicken Kalmi Kebab', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0098', 'Chicken Keema Dosa', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0099', 'Chicken Kola Urundai - 5 Pieces', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0017', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0100', 'Chicken Koththu Kari Dosa', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0101', 'Chicken Kurma', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0102', 'Chicken Lasagna', 170.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0103', 'Chicken Lollypop - 5 Pieces', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0018', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0104', 'Chicken Makhani', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0105', 'Chicken Mushroom Pie', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0106', 'Chicken Nesamani', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0107', 'Chicken Nizam', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0108', 'Chicken Noodles', 155.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0109', 'Chicken Pallipalayam', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0110', 'Chicken Pasta - Red', 290.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0019', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0111', 'Chicken Pasta - Red & White', 290.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0019', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0112', 'Chicken Pasta - White', 290.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0019', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0113', 'Chicken Pizza - Large', 340.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0020', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0114', 'Chicken Pizza - Large', 360.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0020', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0115', 'Chicken Pizza - Regular', 260.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0020', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0116', 'Chicken Pizza - Regular', 220.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0020', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0117', 'Chicken Pulao', 220.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0118', 'Chicken Roll', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0119', 'Chicken Salt & Pepper', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0120', 'Chicken Sandwich', 170.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0121', 'Chicken Schezwan Fried Rice', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0122', 'Chicken Schezwan Noodles', 165.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0123', 'Chicken Sheek Roll', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0124', 'Chicken Sizzlers', 350.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0125', 'Chicken Spring Roll', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0126', 'Chicken Sticks', 250.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0127', 'Chicken Suicide Bombs', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0128', 'Chicken Supreme Pizza - Large', 520.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0021', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0129', 'Chicken Supreme Pizza - Regular', 280.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0021', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0130', 'Chicken Supreme Pizza - Small', 380.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0021', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0131', 'Chicken Tangri Kebab - 1 Piece', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0022', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0132', 'Chicken Thai Basil Fried Rice', 170.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0133', 'Chicken Thai Basil Noodles', 175.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0134', 'Chicken Tikka', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0135', 'Chicken Tikka Biryani', 250.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0136', 'Chicken Tikka Dosa', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0137', 'Chicken Tikka Masala', 260.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0138', 'Chicken Tikka Roll', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0139', 'Chilli - Babycorn', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0140', 'Chilli - Chicken', 210.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0141', 'Chilli - Crab Podimas', 280.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0142', 'Chilli - Egg', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0143', 'Chilli - Fish', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0144', 'Chilli - Gobi', 180.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0145', 'Chilli - Mushroom', 180.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0146', 'Chilli - old', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0147', 'Chilli - Paneer', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0148', 'Chilli - Prawn', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0023', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0149', 'Chilli Cheese Toast', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0150', 'Chilli Chicken', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0151', 'Chilli Garlic Chicken Roll', 195.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0152', 'Chilli Garlic Potato', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0153', 'Chilli Mutton Roll', 140.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0154', 'Chinese Chopsey - Chicken', 185.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0024', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0155', 'Chinese Chopsey - Non-Veg', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0024', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0156', 'Chinese Chopsey - Veg', 175.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0024', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0157', 'Chipotle Chilaquiles', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0158', 'Chipotle Mango Barbecue Chicken', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0159', 'Choco Chip Cookie Shake', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0160', 'Chocolate - I/C - Regular', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0025', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0161', 'Chocolate - I/C - Single', 45.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0025', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0162', 'Chocolate M/S', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0163', 'Clear Soup - Chicken', 90.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0026', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0164', 'Clear Soup - Veg', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0026', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0165', 'Coconut Oil - Farm fresh', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0027', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0166', 'Coconut Pancakes', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0167', 'Coffee', 25.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0168', 'Coffee Brazillia - I/C - Regular', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0028', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0169', 'Coffee Brazillia - I/C - Single', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0028', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0170', 'Coffee Brazillia M/S', 150.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0171', 'Cold Coffee', 150.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0172', 'Coleslaw Salad', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0173', 'Combo Meal - Non-Veg', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0029', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0174', 'Combo Meal - Veg', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0029', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0175', 'Crab - Balls', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0030', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0176', 'Crab Lollypop', 280.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0177', 'Crab Podimas', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0178', 'Cream of Soup - Chicken', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0031', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0179', 'Cream of Soup - Roasted Pumpkin', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0031', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0180', 'Cream of Soup - Tomato', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0031', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0181', 'Cream of Soup - Veg', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0031', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0182', 'Curd', 25.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0183', 'Curd Rice', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0184', 'Death by Chocolate', 240.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0185', 'Devil''s Drink', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0186', 'Deviled Egg Prawn Dippers', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0187', 'Deviled Egg Salad', 110.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0188', 'Dhal Fry', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0189', 'Dhal Makhani', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0190', 'Dhal Palak', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0191', 'Dhal Tadka', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0192', 'Dirty Sandwich Sizzler - Chicken', 260.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0032', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0193', 'Dirty Sandwich Sizzler - Veg', 250.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0032', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0194', 'Double Patty - Chicken Burger', 300.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0033', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0195', 'Double Patty - Veg Burger', 270.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0033', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0196', 'Dragon Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0197', 'Drink the Pan', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0198', 'Drums of Heaven - 5 Pieces', 250.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0034', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0199', 'Egg', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0200', 'Egg - Half Boil', 15.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0035', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0201', 'Egg & Chicken Roll', 170.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0202', 'Egg Biryani', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0203', 'Egg Dosa', 60.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0204', 'Egg Masala', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0205', 'Egg Roll', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0206', 'Egg Sandwich', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0207', 'Egg Schezwan Fried Rice', 145.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0208', 'Egg Schezwan Noodles', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0209', 'Eral Thokku', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0210', 'Extra Cheese', 20.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0211', 'Fire Cooked - Fish', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0036', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0212', 'Fire Cooked - Prawn', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0036', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0213', 'Fish Biryani', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0214', 'Fish Fingers', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0215', 'Fish Fry Masala', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0216', 'Fish in Banana Leaf', 180.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0217', 'Fish n Chips', 180.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0218', 'French Fries', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0219', 'French Toast', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0220', 'Fried', 150.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0221', 'Fried - Chicken', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0037', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0222', 'Fried - Fish', 200.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0037', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0223', 'Fried - Mushroom', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0037', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0224', 'Fried - old', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0037', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0225', 'Fried - Paneer', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0037', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0226', 'Fried - Prawns', 200.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0037', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0227', 'Fried Chicken', 200.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0228', 'Fried Prawns', 190.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0229', 'Fried Rice - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0038', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0230', 'Fried Rice - Egg', 210.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0038', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0231', 'Fried Rice - Mushroom', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0038', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0232', 'Fried Rice - Paneer', 200.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0038', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0233', 'Fried Rice - Veg', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0038', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0234', 'Fruit Bowl', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0235', 'Fruit Bowl with Icecream', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0236', 'Fruit Honey Sandwich', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0237', 'Fruity Pebble', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0238', 'Fusion Burger - Barbecue Chicken', 200.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0239', 'Fusion Burger - Chipotle Chicken', 200.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0240', 'Fusion Burger - Chipotle Veg', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0241', 'Fusion Burger - Liquid Cheese Chicken', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0242', 'Fusion Burger - Liquid Cheese Veg', 160.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0243', 'Fusion Burger - Shredded Chicken', 170.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0244', 'Fusion Burger - Tandoori Chicken', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0245', 'Fusion Burger - Zesty Chicken', 200.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0246', 'Fusion Burger - Zesty Veg', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0039', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0247', 'Garlic Bread', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0248', 'Ghee Rice', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0249', 'Ginger Chicken', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0250', 'Ginger Tea', 25.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0251', 'Goan Fish Curry', 190.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0252', 'Golden Fried Babycorn', 120.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0253', 'Gramathu Mutton Kuzhambu', 290.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0254', 'Green Apple Mojito', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0255', 'Green Peas Masala', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0256', 'Green Peas Pulao', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0257', 'Green Salad', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0258', 'Green Tea - Ginger, Lemon & Honey', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0040', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0259', 'Green Tea - Honey', 35.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0040', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0260', 'Grilled Cheese Soup Dippers', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0261', 'Grilled Chickpea Cakes with Olive Oil & Lemon', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0262', 'Grilled Corn Skewers with Coriander Butter', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0263', 'Grilled Fish - Large', 320.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0041', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0264', 'Grilled Fish - Small', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0041', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0265', 'Grilled Paneer Slabs', 210.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0266', 'Grilled Pasta Sandwich', 150.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0267', 'Grilled Pineapple with BBQ Salsa', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0268', 'Grilled Prawns', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0269', 'Grilled Prawns with Garlic sauce', 200.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0270', 'Grilled Tuscan Chicken', 150.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0271', 'Gulab Jamoon', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0272', 'Guntur Chicken Masala', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0273', 'Hariyali Smoked - old', 160.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0042', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0274', 'Hariyali Smoked Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0275', 'Hariyali Smoked Paneer', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0276', 'Hariyali Smoked Prawn', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0277', 'Hariyali Tikka - Chicken', 260.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0043', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0278', 'Hariyali Tikka - Fish', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0043', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0279', 'Hariyali Tikka - Gobi', 170.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0043', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0280', 'Hariyali Tikka - Mushroom', 210.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0043', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0281', 'Hariyali Tikka - Paneer', 230.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0043', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0282', 'Hariyali Tikka - Prawn', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0043', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0283', 'Hawaiian Grilled Sandwich', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0284', 'High on Sky', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0285', 'Home Style Chicken Curry', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0286', 'Hot n Sour Soup - Chicken', 90.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0044', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0287', 'Hot n Sour Soup - Veg', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0044', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0288', 'Hot n Spicy Fish Toast', 260.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0289', 'Hyderabadi Chicken Masala', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0290', 'Ice Tea', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0291', 'Italian Cheesy Baked Chicken', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0292', 'Jeera Rice', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0293', 'Kadai Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0294', 'Kadai Mutton', 220.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0295', 'Kadai Paneer', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0296', 'Kal Dosa', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0297', 'Kalakki', 20.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0298', 'Kanyakumari Nandu Masala', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0299', 'Karaikudi Chicken Dry', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0300', 'Karaikudi Masala', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0301', 'Karaikudi thokku - Fish', 190.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0045', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0302', 'Karaikudi thokku - Prawn', 190.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0045', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0303', 'Kashmiri Dum Aloo Masala', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0304', 'Kernel Corn Vada', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0305', 'Kick Grass Sandwich', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0306', 'Kongunadu Mutton Kuzhambu', 220.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0307', 'Konju Varutharaccha Curry', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0308', 'Kulcha', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0309', 'Large Size', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0310', 'Large Size - Medium Size', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0046', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0311', 'Large Size - Small Size', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0046', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0312', 'Lasagna - Meat', 280.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0047', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0313', 'Lasagna - Veg', 270.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0047', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0314', 'Lassi', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0315', 'Lemon Pepper Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0316', 'Lemon Rice', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0317', 'Lemon Tea', 25.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0318', 'Lime Juice', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0319', 'Lime Juice - S & S', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0048', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0320', 'Lime Juice - Salt', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0048', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0321', 'Lime Juice - Sweet', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0048', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0322', 'Lime Soda - S & S', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0049', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0323', 'Lime Soda - Salt', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0049', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0324', 'Lime Soda - Sweet', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0049', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0325', 'Lollypop 5 pcs - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0050', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0326', 'Lollypop 5 pcs - Corn', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0050', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0327', 'Lollypop 5 pcs - Crab', 280.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0050', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0328', 'Lollypop 5 pcs - Veg', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0050', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0329', 'Malai Chicken', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0330', 'Malai Kebab - Chicken', 260.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0051', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0331', 'Malai Kebab - Fish', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0051', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0332', 'Malai Kebab - Gobi', 150.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0051', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0333', 'Malai Kebab - Mushroom Tikka', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0051', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0334', 'Malai Kebab - Paneer', 230.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0051', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0335', 'Malai Kebab - Prawn', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0051', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0336', 'Manchow Soup - Chicken', 100.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0052', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0337', 'Manchow Soup - Chicken', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0052', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0338', 'Manchow Soup - Veg', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0052', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0339', 'Manchurian - Babycorn', 210.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0340', 'Manchurian - Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0341', 'Manchurian - Fish', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0342', 'Manchurian - Gobi', 140.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0343', 'Manchurian - Gobi', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0344', 'Manchurian - Mushroom', 140.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0345', 'Manchurian - Mushroom', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0346', 'Manchurian - old', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0347', 'Manchurian - Paneer', 140.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0348', 'Manchurian - Paneer', 210.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0349', 'Manchurian - Prawn', 200.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0350', 'Manchurian - Prawn', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0351', 'Manchurian - Veg Balls', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0053', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0352', 'Manchurian old2', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0353', 'Mango - I/C - Regular', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0054', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0354', 'Mango - I/C - Single', 45.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0054', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0355', 'Mango Lassi', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0356', 'Mango M/S', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0357', 'Mango Mousse', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0358', 'Mango Mule', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0359', 'Margherita Pizza - Large', 340.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0055', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0360', 'Margherita Pizza - Small', 240.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0055', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0361', 'Margherita Sandwich', 150.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0362', 'Masala Dosa', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0363', 'Masala Fried Fish - Large', 180.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0056', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0364', 'Masala Fried Fish - Medium', 160.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0056', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0365', 'Masala Fried Fish - Small', 150.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0056', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0366', 'Masala Omlette', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0367', 'Masala Papad', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0368', 'Masala Tea', 25.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0369', 'Masala Uthappam', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0370', 'Matar - Mushroom', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0057', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0371', 'Matar - Paneer', 220.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0057', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0372', 'Meen Podimas', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0373', 'Milk', 20.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0374', 'Minced Mutton', 150.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0375', 'Minestrone', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0376', 'Mini Lamb Satay Sticks', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0377', 'Mint Lime Juice - S & S', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0058', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0378', 'Mint Lime Juice - Salt', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0058', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0379', 'Mint Lime Juice - Sweet', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0058', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0380', 'Mint Lime Soda - S & S', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0059', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0381', 'Mint Lime Soda - Salt', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0059', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0382', 'Mint Lime Soda - Sweet', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0059', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0383', 'Mint Mayo Chicken Roll', 195.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0384', 'Mint Mojito', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0385', 'Mixed Fried Rice - Non-Veg', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0060', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0386', 'Mixed Fried Rice - Veg', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0060', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0387', 'Mixed Non-Veg Fried Rice', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0061', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0388', 'Mixed Non-Veg Noodles', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0061', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0389', 'Mixed Noodles - Non-Veg', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0062', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0390', 'Mixed Noodles - Veg', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0062', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0391', 'Mixed Veg Fried Rice', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0392', 'Mixed Veg Masala', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0393', 'Mixed Veg Noodles', 185.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0394', 'Mushroom Biryani', 130.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0395', 'Mushroom Dosa', 60.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0396', 'Mushroom Masala', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0397', 'Mushroom Noodles', 145.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0398', 'Mushroom Omlette', 100.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0399', 'Mushroom Pizza - Large', 260.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0063', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0400', 'Mushroom Pizza - Large', 440.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0063', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0401', 'Mushroom Pizza - Regular', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0063', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0402', 'Mushroom Pizza - Small', 290.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0063', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0403', 'Mushroom Pulao', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0404', 'Mushroom Roll', 120.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0405', 'Mushroom-65', 110.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0064', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0406', 'Muskmelon Juice', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0407', 'Mutton Biryani', 280.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0408', 'Mutton Ghee Roast', 280.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0409', 'Mutton Keema', 190.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0410', 'Mutton Keema Dosa', 150.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0411', 'Mutton Kola Urundai 5 pcs', 200.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0412', 'Mutton Kudal Curry', 220.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0413', 'Mutton Kudal Pepper Fry', 200.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0414', 'Mutton Kurma', 220.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0415', 'Mutton Liver Fry', 180.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0416', 'Mutton Milagu Kuzhambu', 220.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0417', 'Mutton Pepper Fry', 190.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0418', 'Mutton Peratal', 200.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0419', 'Mutton Pulao', 270.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0420', 'Mutton Raththa Poriyal', 200.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0421', 'Mutton Sheek Roll', 140.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0422', 'Mutton Sukka', 190.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0423', 'Mutton Varutha Curry', 220.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0424', 'Naatu Kozhi Kulambu', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0425', 'Nandu Rasam', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0426', 'Nasi Goreng Prawn Fried Rice', 190.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0427', 'Nasi Goreng Prawn Fried Rice', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0428', 'Nasi Goreng Prawn Noodles', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0429', 'Nasi Goreng Prawn Noodles', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0430', 'Non-Veg Tandoori Platter', 590.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0065', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0431', 'Noodle - Chicken Soup', 100.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0066', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0432', 'Noodle - Veg Soup', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0066', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0433', 'Noodles - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0067', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0434', 'Noodles - Egg', 210.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0067', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0435', 'Noodles - Mushroom', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0067', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0436', 'Noodles - Paneer', 200.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0067', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0437', 'Noodles - Veg', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0067', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0438', 'Nutella Hazelnut Sandwich', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0439', 'Nutty Challenge', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0440', 'Oats Chicken', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0441', 'Onion Dosa', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0442', 'Onion Salad', 30.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0443', 'Onion Uthappam', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0444', 'Orange Chicken', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0445', 'Orange Juice', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0446', 'Organic Small Bee Honey - 1kg', 420.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0068', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0447', 'Pallipalayam - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0069', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0448', 'Pallipalayam - Mutton', 280.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0069', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0449', 'Pan Climax M/S', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0450', 'Pan Lassi', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0451', 'Paneer Biryani', 140.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0452', 'Paneer Bread Roll', 110.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0453', 'Paneer Butter Masala', 220.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0454', 'Paneer Frankie', 100.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0455', 'Paneer Keema Dosa', 70.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0456', 'Paneer Pizza - Large', 260.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0070', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0457', 'Paneer Pizza - Large', 440.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0070', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0458', 'Paneer Pizza - Regular', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0070', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0459', 'Paneer Pizza - Small', 300.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0070', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0460', 'Paneer Pulao', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0461', 'Paneer Sandwich', 150.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0462', 'Paneer Tikka Masala', 220.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0463', 'Paneer Tikka Roll', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0464', 'Paneer-65', 110.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0071', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0465', 'Party Poppers', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0466', 'Peanut Butter Brownie Shake', 230.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0467', 'Pepper Chicken Dry', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0468', 'Pepper Chicken Masala', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0469', 'Pepper Fry - Babycorn', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0072', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0470', 'Pepper Fry - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0072', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0471', 'Pepper Fry - Fish', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0072', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0472', 'Pepper Fry - Mushroom', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0072', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0473', 'Pepper Fry - Mutton', 280.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0072', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0474', 'Pepper Fry - old', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0072', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0475', 'Pepper Fry - Prawn', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0072', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0476', 'Peppy Paneer, Babycorn & Mushroom - Large', 300.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0073', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0477', 'Peppy Paneer, Babycorn & Mushroom - Large', 320.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0073', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0478', 'Peppy Paneer, Babycorn & Mushroom - Medium', 200.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0073', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0479', 'Peppy Paneer, Babycorn & Mushroom - Regular', 220.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0073', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0480', 'Pepsi - Large', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0074', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0481', 'Peri Peri Chicken Kebab', 250.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0482', 'Peri Peri Chicken Pizza - Large', 380.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0075', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0483', 'Peri Peri Chicken Pizza - Regular', 280.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0075', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0484', 'Peri Peri Chicken Roll', 195.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0485', 'Peri Peri Fries', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0486', 'Pesto Pasta - Chicken', 320.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0076', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0487', 'Pesto Pasta - Veg', 290.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0076', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0488', 'Pineapple Juice', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0489', 'Pink Lips', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0490', 'Pink Pasta - Chicken', 290.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0077', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0491', 'Pink Pasta - Veg', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0077', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0492', 'Pistanut - I/C - Regular', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0078', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0493', 'Pistanut - I/C - Single', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0078', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0494', 'Pistanut M/S', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0495', 'Pita Half Pocket - Chicken', 140.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0079', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0496', 'Pita Half Pocket - Combo - Chicken, Fries & Mojito', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0079', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0497', 'Pita Half Pocket - Combo - Mutton, Fries & Mojito', 260.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0079', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0498', 'Pita Half Pocket - Combo - Paneer, Fries & Mojito', 200.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0079', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0499', 'Pita Half Pocket - Mutton', 170.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0079', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0500', 'Pita Half Pocket - Paneer', 120.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0079', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0501', 'Pitchupotta Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0502', 'Plain Biryani', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0503', 'Plain Dosa', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0504', 'Plain Omlette', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0505', 'Plain Rice', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0506', 'Plain Uthappam', 40.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0507', 'Platter - Non-Veg', 430.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0080', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0508', 'Podi Dosa', 50.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0509', 'Pomfret Fish Fry', 180.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0510', 'Popcorn Chicken', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0511', 'Prawn Biryani', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0512', 'Prawn Cocktail Salad', 140.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0513', 'Prawn Fry Masala', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0514', 'Prawn Toast', 180.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0515', 'Pulka', 30.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0516', 'Rava Dosa', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0517', 'Red Diesel', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0518', 'Reshmi Kebab', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0519', 'Roasted Chicken Salad', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0520', 'Roasted Chicken Slices', 120.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0521', 'Royal Buffet - Adult', 550.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0081', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0522', 'Royal Buffet - Kids', 275.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0081', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0523', 'Rumali Roti', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0524', 'Russian Salad', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0525', 'Salmon Steak with Hoisin BBQ Sauce', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0526', 'Salt & Pepper - Babycorn', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0082', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0527', 'Salt & Pepper - Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0082', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0528', 'Salt & Pepper - Mushroom', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0082', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0529', 'Salt & Pepper - Prawn', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0082', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0530', 'Sambar Rice', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0531', 'Schezwan Chicken', 160.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0532', 'Schezwan Fried Rice - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0083', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0533', 'Schezwan Fried Rice - Egg', 220.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0083', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0534', 'Schezwan Fried Rice - Veg', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0083', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0535', 'Schezwan Noodles - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0084', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0536', 'Schezwan Noodles - Egg', 220.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0084', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0537', 'Schezwan Noodles - Veg', 190.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0084', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0538', 'Scrambled Egg', 60.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0539', 'Seafood Lasagna', 320.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0540', 'Seafood Pizza - Large', 590.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0085', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0541', 'Seafood Pizza - Small', 480.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0085', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0542', 'Seafood Sizzlers', 460.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0543', 'Seasonal fruits', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0544', 'Set Dosa', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0545', 'Sheek Kebab - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0086', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0546', 'Sheek Kebab - Fish', 290.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0086', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0547', 'Sheek Kebab - Mutton', 290.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0086', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0548', 'Shorba - Chicken Soup', 100.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0087', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0549', 'Shorba - Veg Soup', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0087', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0550', 'Shredded Chicken', 220.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0551', 'Smoked - Chicken on the Flame', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0088', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0552', 'Smoked - Mushroom', 210.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0088', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0553', 'Smoked - Paneer', 210.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0088', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0554', 'Smoked Chicken & Pineapple Pizza - Large', 360.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0089', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0555', 'Smoked Chicken & Pineapple Pizza - Regular', 260.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0089', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0556', 'Spanish Omlette', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0557', 'Spicy Paprika Sandwich', 160.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0558', 'Strawberry - I/C - Regular', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0090', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0559', 'Strawberry - I/C - Single', 35.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0090', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0560', 'Strawberry M/S', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0561', 'Stuffed Bell Peppers', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0562', 'Stuffed Kulcha', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0563', 'Stuffed Mushroom', 120.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0564', 'Stuffed Paratha', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0565', 'Sukka - Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0091', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0566', 'Sukka - Fish', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0091', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0567', 'Sukka - Mutton', 280.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0091', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0568', 'Sukka - Prawn', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0091', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0569', 'Sundae of the day', 280.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0570', 'Sunset Surprise', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0571', 'Sweet of the day', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0572', 'Sweetcorn Soup - Chicken', 100.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0092', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0573', 'Sweetcorn Soup - Veg', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0092', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0574', 'Tamarind Fish Gravy', 220.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0575', 'Tandoori Chicken - Full', 580.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0093', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0576', 'Tandoori Chicken - Half', 290.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0093', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0577', 'Tandoori Grilled - Chicken Sandwich', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0094', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0578', 'Tawa Chicken-Rice/Salad', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0095', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0579', 'Tawa Toasted Chicken - Rice/Salad', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0096', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0580', 'Tea', 20.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0581', 'Thai Basil Fried Rice - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0097', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0582', 'Thai Basil Fried Rice - Veg', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0097', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0583', 'Thai Basil Noodles - Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0098', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0584', 'Thai Basil Noodles - Veg', 200.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0098', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0585', 'Thai Sizzlers', 270.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0586', 'Thalluvandi Chicken', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0587', 'Thoothukudi Chicken Dry', 230.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0588', 'Tikka - Chicken', 240.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0099', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0589', 'Tikka - Fish', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0099', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0590', 'Tikka - Mushroom', 190.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0099', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0591', 'Tikka - Paneer', 220.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0099', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0592', 'Tikka - Prawn', 280.0, 'CAT-BIZ-RES-0001-0003', 'SUBCAT-BIZ-RES-0001-0099', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0593', 'Tikkis - 6 Pieces - Chicken', 180.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0100', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0594', 'Tikkis - 6 Pieces - Paneer', 160.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0100', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0595', 'Tomato', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0596', 'Tomato Rice', 80.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0597', 'Tornado Potatoes', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0598', 'Tossed Salad', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0599', 'Twisted Lamb Kebabs', 240.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0600', 'V''Day Special - Corn Capsicum S/W & Sunset Glory Drink', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0101', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0601', 'V''Day Special - Mutton Burger & Rumble Red Drink', 160.0, 'CAT-BIZ-RES-0001-0005', 'SUBCAT-BIZ-RES-0001-0101', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0602', 'V''Day Special - Tomato Cheese S/w & Mint Cooler', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0101', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0603', 'Vanilla - I/C - Regular', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0102', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0604', 'Vanilla - I/C - Single', 35.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0102', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0605', 'Vanilla M/S', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0606', 'Vanilla Wonders', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0607', 'Veg', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0608', 'Veg  Biryani', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0609', 'Veg Achar', 90.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0610', 'Veg Buffet - Lunch', 333.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0103', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0611', 'Veg Buffet - Party Order', 450.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0103', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0612', 'Veg Burger', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0613', 'Veg Cheese Balls', 220.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0614', 'Veg Cheese Sandwich', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0615', 'Veg Chettinadu Masala', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0616', 'Veg Club Sandwich', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0617', 'Veg Falafel', 100.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0618', 'Veg Fried Rice', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0619', 'Veg Gold Coin', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0620', 'Veg Kadai', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0621', 'Veg Kari Dosa', 70.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0622', 'Veg Keema Dosa', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0623', 'Veg Lasagna', 150.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0624', 'Veg Lollypop', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0625', 'Veg Noodles', 135.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0626', 'Veg Pasta - Red', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0104', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0627', 'Veg Pasta - Red & White', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0104', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0628', 'Veg Pasta - White', 260.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0104', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0629', 'Veg Pulao', 170.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0630', 'Veg Roll', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0631', 'Veg Sandwich', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0632', 'Veg Schezwan Fried Rice', 140.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0633', 'Veg Schezwan Noodles', 145.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0634', 'Veg Sheek Kebab', 130.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0635', 'Veg Sizzlers', 280.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0636', 'Veg Spring Roll', 120.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0637', 'Veg Supreme Pizza - Large', 280.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0105', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0638', 'Veg Supreme Pizza - Large', 440.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0105', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0639', 'Veg Supreme Pizza - Regular', 180.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0105', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0640', 'Veg Supreme Pizza - Small', 290.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0105', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0641', 'Veg Thai Basil Fried Rice', 160.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0642', 'Veg Thai Basil Noodles', 165.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0643', 'Veggie Classic - Large', 290.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0106', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0644', 'Veggie Classic - Regular', 190.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0106', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0645', 'Veggie Cloud 9 - Large', 300.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0107', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0646', 'Veggie Cloud 9 - Regular', 200.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0107', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0647', 'Water Bottle - 1ltr', 25.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0108', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0648', 'Watermelon Juice', 60.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0649', 'Wheat Kothu Parotta - Chicken', 140.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0109', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0650', 'Wheat Kothu Parotta - Egg', 130.0, 'CAT-BIZ-RES-0001-0002', 'SUBCAT-BIZ-RES-0001-0109', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0651', 'Wheat Kothu Parotta - Paneer', 130.0, 'CAT-BIZ-RES-0001-0001', 'SUBCAT-BIZ-RES-0001-0109', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0652', 'Wheat Kothu Parotta - Veg', 110.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0109', 1, 1, true, 'BIZ-RES-0001');
INSERT INTO products (id, name, price, category_id, subcategory_id, gst_id, unit_id, is_active, business_id) VALUES
('PRD-BIZ-RES-0001-0653', 'Wheat Paratha', 45.0, 'CAT-BIZ-RES-0001-0004', 'SUBCAT-BIZ-RES-0001-0003', 1, 1, true, 'BIZ-RES-0001');