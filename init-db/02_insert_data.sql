--Populate Users
INSERT INTO Users (username, user_pw, user_role)
VALUES 
    ('alex_admin', 'Pass1234!', 'Admin'),
    ('sarah_manager', 'Manager321#', 'Store Manager'),
    ('john_clerk', 'ClerkStock88', 'Inventory Clerk'),
    ('emily_clerk', 'SecurePass99!', 'Inventory Clerk');

--Products Catalog
INSERT INTO Products (upc_barcode, product_name, category, brand, unit_price, default_shelf_life_days)
VALUES 
    ('012345678901', 'Whole Milk 1 Gal', 'Dairy', 'FarmFresh', 3.99, 14),
    ('012345678902', 'Organic Greek Yogurt 32oz', 'Dairy', 'GreekGoodness', 5.49, 30),
    ('012345678903', 'Sourdough Bread', 'Bakery', 'ArtisanBake', 4.29, 7);

--Populate Physical Inventory Batches
INSERT INTO Inventory_Items (product_id, batch_number, expiration_date, quantity_in_stock, store_location, status)
VALUES 
    (1, 'BATCH-101', CURRENT_DATE + INTERVAL '3 days', 12, 'Dairy Cooler 1', 'Active'),
    (1, 'BATCH-102', CURRENT_DATE + INTERVAL '12 days', 24, 'Backroom Refrigerator', 'Active'),
    (2, 'BATCH-201', CURRENT_DATE + INTERVAL '2 days', 5, 'Dairy Cooler 2', 'Active'),
    (3, 'BATCH-301', CURRENT_DATE - INTERVAL '1 day', 2, 'Bakery Shelf A', 'Expired');

--Populate Expiration Alerts (for items expiring soon)
INSERT INTO Expiration_Alerts (inventory_id, days_until_expiration, alert_status, action_taken)
VALUES 
    (1, 3, 'Pending', NULL),
    (3, 2, 'Action Taken', 'Discounted 50%'),
    (4, -1, 'Acknowledged', 'Scheduled for disposal');

--Populate an Expiration Log Report
INSERT INTO Expiration_Reports (report_type, generated_by_user, total_items_flagged, total_waste_cost, notes)
VALUES 
    ('Daily Expiry Warning', 'manager_alex', 3, 8.58, 'Flagged sourdough bread past expiry and milk expiring in 3 days.');