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
    ('16oz', 3);

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
            6.00);

    -- Cold Espresso Beverages
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Iced Latte',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Cold Espresso Beverages'), 5.75),
        ('Iced Americano',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Cold Espresso Beverages'), 4.50),
        ('Iced Mocha',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Cold Espresso Beverages'), 6.25);

    -- Brewed Coffee
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Drip Coffee',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Brewed Coffee'), 3.50),
        ('Pour Over',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Brewed Coffee'), 5.50);

    -- Tea
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Hot Tea',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Tea'), 4.50),
        ('Iced Tea',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Tea'), 4.50);

    -- Hot Beverages
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Chai Latte',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Hot Beverages'), 5.50),
        ('Hot Chocolate',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Hot Beverages'), 4.50),
        ('Steamer',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Hot Beverages'), 3.00);

    -- Cold Beverages
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Chai Latte',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Cold Beverages'), 5.50),
        ('Italian Soda',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Cold Beverages'), 4.50),
        ('Lemonade',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Cold Beverages'), 5.00);

    -- Hot Breakfast
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Breakfast Sandwich',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Hot Breakfast'), 7.50);

    -- Pastries
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Croissant',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Pastries'), 4.50),
        ('Muffin',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Pastries'), 4.25);

    -- Sweet Treats
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Cookie',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Sweet Treats'), 3.50),
        ('Brownie',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Sweet Treats'), 4.25);

    -- Merchandise
    INSERT INTO Product (ProductName, CategoryID, Price)
    VALUES
        ('Travel Mug',
            (SELECT CategoryID FROM Category
            WHERE CategoryName = 'Merchandise'), 18.00);

-- Product Sizes

    -- Hot Espresso Beverages
    INSERT INTO ProductSize (ProductID, SizeID, PriceAdjustment)
    VALUES
        -- Latte
        ((SELECT ProductID FROM Product WHERE ProductName = 'Latte'),
        (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Latte'),
        (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.50),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Latte'),
        (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 1.00),
        
        -- Cappuccino
        ((SELECT ProductID FROM Product WHERE ProductName = 'Cappuccino'),
        (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
        
        -- Americano
        ((SELECT ProductID FROM Product WHERE ProductName = 'Americano'),
        (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Americano'),
        (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.50),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Americano'),
        (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 1.00),

        -- Mocha
        ((SELECT ProductID FROM Product WHERE ProductName = 'Mocha'),
        (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Mocha'),
        (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.50),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Mocha'),
        (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 1.00);

    -- Cold Espresso Beverages

        -- Iced Latte
        INSERT INTO ProductSize (ProductID, SizeID, PriceAdjustment)
        VALUES
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Latte'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Latte'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.50),

            -- Iced Americano
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Americano'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Americano'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.50),

            -- Iced Mocha
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Mocha'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Mocha'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.50);

    -- Brewed Coffee

        -- Drip Coffee
        INSERT INTO ProductSize (ProductID, SizeID, PriceAdjustment)
        VALUES
            ((SELECT ProductID FROM Product WHERE ProductName = 'Drip Coffee'),
            (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Drip Coffee'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.50),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Drip Coffee'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 1.00),

        -- Pour Over
            ((SELECT ProductID FROM Product WHERE ProductName = 'Pour Over'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00);

    -- Tea

        -- Hot Tea
        INSERT INTO ProductSize (ProductID, SizeID, PriceAdjustment)
        VALUES
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Tea'),
            (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Tea'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Tea'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.00),

        -- Iced Tea
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Tea'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Tea'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.00),

    -- Hot Beverages

        INSERT INTO ProductSize (ProductID, SizeID, PriceAdjustment)
        VALUES
            -- Hot Chai Latte
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Chai Latte'),
            (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Chai Latte'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.50),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Chai Latte'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 1.00),

            -- Hot Chocolate
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Chocolate'),
            (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Chocolate'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.50),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Hot Chocolate'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 1.00),

            -- Steamer
            ((SELECT ProductID FROM Product WHERE ProductName = 'Steamer'),
            (SELECT SizeID FROM Size WHERE SizeName = '8 oz'), 0.00),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Steamer'),
            (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.50),
            ((SELECT ProductID FROM Product WHERE ProductName = 'Steamer'),
            (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 1.00);

    -- Cold Beverages

        -- Iced Chai Latte
        ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Chai Latte'),
        (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Iced Chai Latte'),
        (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.50);

        -- Italian Soda
        ((SELECT ProductID FROM Product WHERE ProductName = 'Italian Soda'),
        (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Italian Soda'),
        (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.50),

        -- Lemonade
        ((SELECT ProductID FROM Product WHERE ProductName = 'Lemonade'),
        (SELECT SizeID FROM Size WHERE SizeName = '12 oz'), 0.00),
        ((SELECT ProductID FROM Product WHERE ProductName = 'Lemonade'),
        (SELECT SizeID FROM Size WHERE SizeName = '16 oz'), 0.50);


-- Customization Groups

    INSERT INTO CustomizationGroup (
        GroupName,
        SelectionType,
        MinimumSelections,
        MaximumSelections,
        DisplayOrder
    )
    VALUES
        ('Milk', 'Single', 0, 1, 1);

    -- Milk Addition
        INSERT INTO CustomizationGroup (
            GroupName,
            SelectionType,
            MinimumSelections,
            MaximumSelections,
            DisplayOrder
        )
        VALUES (
            'Milk Addition',
            'Single',
            0,
            1,
            2
        );

    -- Temperature
        INSERT INTO CustomizationGroup (
            GroupName,
            SelectionType,
            MinimumSelections,
            MaximumSelections,
            DisplayOrder
        )
        VALUES (
            'Temperature',
            'Single',
            0,
            1,
            3
        );

-- Customization Options

    -- Milk
        INSERT INTO CustomizationOption (
            CustomizationGroupID,
            OptionName
        )
        VALUES
            ((SELECT CustomizationGroupID
            FROM CustomizationGroup
            WHERE GroupName = 'Milk'), 'Whole'),

            ((SELECT CustomizationGroupID
            FROM CustomizationGroup
            WHERE GroupName = 'Milk'), 'NonFat'),

            ((SELECT CustomizationGroupID
            FROM CustomizationGroup
            WHERE GroupName = 'Milk'), 'Half & Half'),

            ((SELECT CustomizationGroupID
            FROM CustomizationGroup
            WHERE GroupName = 'Milk'), 'Oat'),

            ((SELECT CustomizationGroupID
            FROM CustomizationGroup
            WHERE GroupName = 'Milk'), 'Almond'),

            ((SELECT CustomizationGroupID
            FROM CustomizationGroup
            WHERE GroupName = 'Milk'), 'Soy');

        -- Milk Addition Options
            INSERT INTO CustomizationOption (
                CustomizationGroupID,
                OptionName
            )
            VALUES
                ((SELECT CustomizationGroupID
                FROM CustomizationGroup
                WHERE GroupName = 'Milk Addition'), 'Room'),

                ((SELECT CustomizationGroupID
                FROM CustomizationGroup
                WHERE GroupName = 'Milk Addition'), 'Splash'),

                ((SELECT CustomizationGroupID
                FROM CustomizationGroup
                WHERE GroupName = 'Milk Addition'), 'Add Milk');

        -- Temperature Options
            INSERT INTO CustomizationOption (
                CustomizationGroupID,
                OptionName
            )
            VALUES
                (
                    (SELECT CustomizationGroupID
                    FROM CustomizationGroup
                    WHERE GroupName = 'Temperature'),
                    'Less Hot'
                ),
                (
                    (SELECT CustomizationGroupID
                    FROM CustomizationGroup
                    WHERE GroupName = 'Temperature'),
                    'Extra Hot'
                );

    -- Customization Dependencies

        -- Milk Addition Dependencies
            INSERT INTO CustomizationDependency (
            TriggerOptionID,
            DependentGroupID
            )
            VALUES
                ((SELECT CustomizationOptionID
                FROM CustomizationOption
                WHERE OptionName = 'Splash'
                AND CustomizationGroupID = (
                    SELECT CustomizationGroupID
                    FROM CustomizationGroup
                    WHERE GroupName = 'Milk Addition'
                )),
                (SELECT CustomizationGroupID
                FROM CustomizationGroup
                WHERE GroupName = 'Milk')
                ),
                (
                (SELECT CustomizationOptionID
                FROM CustomizationOption
                WHERE OptionName = 'Add Milk'
                AND CustomizationGroupID = (
                    SELECT CustomizationGroupID
                    FROM CustomizationGroup
                    WHERE GroupName = 'Milk Addition'
                )),
                (SELECT CustomizationGroupID
                FROM CustomizationGroup
                WHERE GroupName = 'Milk')
                );

-- Product Customizations

    -- Milk Customizations
        INSERT INTO ProductCustomization (
            ProductID,
            CustomizationOptionID,
            PriceAdjustment
            )
            SELECT
                p.ProductID,
                co.CustomizationOptionID,
                CASE
                    WHEN co.OptionName IN ('Half & Half', 'Oat', 'Almond', 'Soy')
                        THEN 1.00
                    ELSE 0.00
                END
            FROM Product p
            CROSS JOIN CustomizationOption co
            JOIN CustomizationGroup cg
                ON co.CustomizationGroupID = cg.CustomizationGroupID
            WHERE p.ProductName IN (
                'Latte',
                'Cappuccino',
                'Mocha',
                'Iced Latte',
                'Iced Mocha',
                'Hot Chai Latte',
                'Iced Chai Latte',
                'Hot Chocolate',
                'Steamer'
            )
            AND cg.GroupName = 'Milk';

    -- Milk Addition Customizations
        INSERT INTO ProductCustomization (
            ProductID,
            CustomizationOptionID,
            PriceAdjustment
        )
        SELECT
            p.ProductID,
            co.CustomizationOptionID,
            CASE
                WHEN co.OptionName = 'Add Milk'
                    THEN 0.50
                ELSE 0.00
            END
        FROM Product p
        CROSS JOIN CustomizationOption co
        JOIN CustomizationGroup cg
            ON co.CustomizationGroupID = cg.CustomizationGroupID
        WHERE p.ProductName IN (
            'Americano',
            'Iced Americano',
            'Hot Tea',
            'Iced Tea'
        )
        AND cg.GroupName = 'Milk Addition';

    -- Milk Options for Conditional Milk Additions
        INSERT INTO ProductCustomization (
            ProductID,
            CustomizationOptionID,
            PriceAdjustment
        )
        SELECT
            p.ProductID,
            co.CustomizationOptionID,
            0.00
        FROM Product p
        CROSS JOIN CustomizationOption co
        JOIN CustomizationGroup cg
            ON co.CustomizationGroupID = cg.CustomizationGroupID
        WHERE p.ProductName IN (
            'Americano',
            'Iced Americano',
            'Hot Tea',
            'Iced Tea'
        )
        AND cg.GroupName = 'Milk';

    -- Temperature Customizations
        INSERT INTO ProductCustomization (
            ProductID,
            CustomizationOptionID,
            PriceAdjustment
        )
        SELECT
            p.ProductID,
            co.CustomizationOptionID,
            0.00
        FROM Product p
        CROSS JOIN CustomizationOption co
        JOIN CustomizationGroup cg
            ON co.CustomizationGroupID = cg.CustomizationGroupID
        WHERE p.ProductName IN (
            'Latte',
            'Cappuccino',
            'Americano',
            'Mocha',
            'Hot Chai Latte',
            'Hot Chocolate',
            'Steamer'
        )
        AND cg.GroupName = 'Temperature';
