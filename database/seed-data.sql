-- ============================================
-- Coffee Shop POS Seed Data
-- ============================================

USE coffee_shop_pos;

-- Categories

INSERT INTO Category (CategoryName) 
VALUES
    ('Hot Espresso Beverages'),
    ('Cold Espresso Beverages'),
    ('Brewed Coffee'),
    ('Tea'),
    ('Hot Beverages'),
    ('Cold Beverages'),
    ('Hot Breakfast'),
    ('Pastries'),
    ('Sweet Treats'),
    ('Merchandise');

INSERT INTO Size (SizeName, DisplayOrder)
VALUES
    ('8oz', 1),
    ('12oz', 2),
    ('16oz', 3),
    ('20oz', 4);

-- Products

-- Hot Espresso Beverages
INSERT INTO Product (ProductName, CategoryID, Price)
VALUES
    ('Latte',
        (SELECT CategoryID FROM Category
        WHERE CategoryName = 'Hot Espresso Beverages'),
        5.50),

    ('Cappuccino',
        (SELECT CategoryID FROM Category
        WHERE CategoryName = 'Hot Espresso Beverages'),
        5.25),

    ('Americano',
        (SELECT CategoryID FROM Category
        WHERE CategoryName = 'Hot Espresso Beverages'),
        4.25),

    ('Mocha',
        (SELECT CategoryID FROM Category
        WHERE CategoryName = 'Hot Espresso Beverages'),
        6.00),
