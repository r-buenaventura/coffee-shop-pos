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