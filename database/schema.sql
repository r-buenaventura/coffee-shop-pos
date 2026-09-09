-- ============================================
-- Coffee Shop POS Database Schema
-- ============================================
CREATE DATABASE IF NOT EXISTS coffee_shop_pos;

USE coffee_shop_pos;

-- Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('Manager', 'Barista') NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE
);

-- Category
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- Customization Group
CREATE TABLE CustomizationGroup (
    CustomizationGroupID INT PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(50) NOT NULL UNIQUE,
    SelectionType ENUM('Single', 'Multiple') NOT NULL,
    MinimumSelections INT NOT NULL DEFAULT 0,
    MaximumSelections INT NOT NULL DEFAULT 1,
    DisplayOrder INT NOT NULL DEFAULT 0
);

-- Customization Option
CREATE TABLE CustomizationOption (
    CustomizationOptionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomizationGroupID INT NOT NULL,
    OptionName VARCHAR(50) NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE
);

-- Product
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Product Customization
CREATE TABLE ProductCustomization (
    ProductCustomizationID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    CustomizationOptionID INT NOT NULL,
    PriceAdjustment DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomizationOptionID) REFERENCES CustomizationOption(CustomizationOptionID)
);

-- Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    OrderDateTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    OrderStatus ENUM('Open', 'Pending', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Open',
    Subtotal DECIMAL(10, 2) NOT NULL,
    Tax DECIMAL(10, 2) NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Order Item
CREATE TABLE OrderItem (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Order Item Customization
CREATE TABLE OrderItemCustomization (
    OrderItemCustomizationID INT PRIMARY KEY AUTO_INCREMENT,
    OrderItemID INT NOT NULL,
    CustomizationOptionID INT NOT NULL,
    PriceAdjustment DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (OrderItemID) REFERENCES OrderItem(OrderItemID),
    FOREIGN KEY (CustomizationOptionID) REFERENCES CustomizationOption(CustomizationOptionID)
);

-- Payment
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    PaymentMethod ENUM('Cash', 'Credit Card', 'Mobile Payment') NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDateTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus ENUM('Pending', 'Completed', 'Failed', 'Refunded') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inventory Item
CREATE TABLE InventoryItem (
    InventoryItemID INT PRIMARY KEY AUTO_INCREMENT,
    ItemName VARCHAR(100) NOT NULL,
    UnitOfMeasure VARCHAR(20) NOT NULL,
    CurrentQuantity DECIMAL(10, 2) NOT NULL,
    ReorderLevel DECIMAL(10, 2) NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE
);