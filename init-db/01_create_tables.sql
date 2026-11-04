--User Table
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100),
    user_pw VARCHAR(100),
    user_role VARCHAR(100)
);

--Master Product Catalog Table
CREATE TABLE Products (
    product_id INT GENERATED ALWAYS AS IDENTITY,
    upc_barcode VARCHAR(50) NOT NULL UNIQUE,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(100),
    unit_price DECIMAL(10, 2) NOT NULL,
    default_shelf_life_days INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_products PRIMARY KEY (product_id)
);

--Physical Inventory Batches (Tracks Expiration Dates)
CREATE TABLE Inventory_Items (
    inventory_id INT GENERATED ALWAYS AS IDENTITY,
    product_id INT NOT NULL,
    batch_number VARCHAR(50),
    expiration_date DATE NOT NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    store_location VARCHAR(100), -- Examples: 'Aisle 3', 'Backroom Freezer'
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Discounted', 'Expired', 'Discarded')),
    received_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT pk_inventory_items PRIMARY KEY (inventory_id),
    CONSTRAINT fk_inventory_products FOREIGN KEY (product_id) 
        REFERENCES Products(product_id) ON DELETE CASCADE
);

--Automated Expiration Alerts Table
CREATE TABLE Expiration_Alerts (
    alert_id INT GENERATED ALWAYS AS IDENTITY,
    inventory_id INT NOT NULL,
    alert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    days_until_expiration INT NOT NULL,
    alert_status VARCHAR(20) DEFAULT 'Pending' CHECK (alert_status IN ('Pending', 'Acknowledged', 'Action Taken', 'Dismissed')),
    action_taken VARCHAR(100), -- Examples: 'Discounted 50%', 'Removed from shelf'
    resolved_at TIMESTAMP,
    CONSTRAINT pk_expiration_alerts PRIMARY KEY (alert_id),
    CONSTRAINT fk_alerts_inventory FOREIGN KEY (inventory_id) 
        REFERENCES Inventory_Items(inventory_id) ON DELETE CASCADE
);

--Audit & Expiration Reports Table
CREATE TABLE Expiration_Reports (
    report_id INT GENERATED ALWAYS AS IDENTITY,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    report_type VARCHAR(50) NOT NULL CHECK (report_type IN ('Daily Expiry Warning', 'Shrinkage & Waste', 'Monthly Summary')),
    generated_by_user VARCHAR(100) NOT NULL,
    total_items_flagged INT DEFAULT 0,
    total_waste_cost DECIMAL(10, 2) DEFAULT 0.00,
    notes TEXT,
    CONSTRAINT pk_expiration_reports PRIMARY KEY (report_id)
);