# Coffee Shop POS — Database Design

## 1. Database Overview

The Coffee Shop POS database will store and organize the information required to operate the point-of-sale system. The database will support employee authentication, product and category management, drink customization, order processing, payments, production ticket generation, inventory management, and sales reporting.

The database will be designed as a relational database, with related information separated into appropriate entities to reduce duplicate data and maintain data integrity.

The database must support the following core requirements:

Store employee and role information.
Store products and their categories.
Store product customization groups and available customization options.
Define which customization groups and options are available for individual products.
Store customer orders and the products included in each order.
Preserve the specific customizations selected for each ordered item.
Store payment information associated with completed orders.
Store inventory quantities and product availability separately.
Support sales reporting and analysis.
Preserve historical order information even when products, prices, or customization availability change in the future.

The database design will prioritize flexibility so that new products, customization options, and categories can be added without requiring major changes to the underlying database structure.

## 2. Core Entities

The database will be organized around the following core entities:

### Employee

Represents employees who use the POS system. Employees will have different roles and permissions, such as barista or manager.

### Category

Represents the categories used to organize products in the POS, such as espresso drinks, brewed coffee, tea, or other menu categories.

### Product

Represents a drink or other item that can be sold through the POS. Products will belong to a category and have a price and availability status.

### Customization Group

Represents a category of customization choices that can be applied to a product, such as Milk, Ice, Temperature, Foam, Syrups, or Add-ons.

Each customization group will define rules for how many options can be selected.

### Customization Option

Represents an individual choice within a customization group, such as Oat Milk, Light Ice, Vanilla Syrup, or Extra Foam.

### Product Customization

Represents the relationship between a product and the customization options that are available for that product.

This allows different products to have different customization choices.

### Order

Represents a customer's transaction. An order will contain one or more items, the employee who processed the order, the date and time of the transaction, and the order's financial information.

### Order Item

Represents an individual product included in an order. An order may contain multiple order items, and each item will store the quantity and price information associated with the purchase.

### Order Item Customization

Represents the specific customization options selected for an individual order item.

This entity is necessary to preserve the exact configuration of a product at the time it was ordered.

### Payment

Represents a payment associated with an order. The system will record information such as the payment method, amount, status, and transaction date and time.

### Inventory Item

Represents an item tracked by the coffee shop's inventory system, such as milk, espresso beans, syrups, cups, or other supplies.

Inventory items will have quantities and tracking status information that can be adjusted by managers.

## 3. Entity Relationships

The database entities will be connected through relationships that represent how the coffee shop operates.

### Employee and Order

An employee can process many orders, while each order is processed by one employee.

**Relationship:**

`Employee → Order`

### Category and Product

A category can contain many products, while each product belongs to one category.

**Relationship:**

`Category → Product`

### Product and Customization Option

A product can have multiple customization options, and a customization option can be available for multiple products.

**Relationship:**

`Product ↔ Customization Option`

This many-to-many relationship is implemented through the Product Customization table. Because each customization option belongs to a customization group, the POS can determine both which options are available for a product and which customization group each option belongs to.

### Customization Group and Customization Option

A customization group can contain multiple customization options, while each customization option belongs to a customization group.

**Relationship:**

`Customization Group → Customization Option`

For example, the "Ice" customization group could contain Regular, Light, and Extra Ice options.

### Order and Order Item

An order can contain multiple order items, while each order item belongs to one order.

**Relationship:**

`Order → Order Item`

This allows a single order to contain multiple products and quantities.

### Product and Order Item

A product can appear in many order items, while each order item represents one product being purchased.

**Relationship:**

`Product → Order Item`

### Order Item and Customization Option

An order item can have multiple selected customization options, and a customization option can be selected on many different order items.

**Relationship:**

`Order Item ↔ Customization Option`

This many-to-many relationship will be used to preserve the specific customization choices made for each ordered product.

### Order and Payment

An order can have one or more payment records, while each payment record belongs to one order.

**Relationship:**

`Order → Payment`

The initial system will primarily use one payment per completed order, but the database structure should allow for additional payment records if the system is expanded in the future.

### Inventory Item and Product

A future version may connect products to one or more inventory items, and an inventory item may be used by multiple products.

**Future Relationship:**

`Product ↔ Inventory Item`

This relationship is outside the MVP. A future product recipe structure could use it to determine which inventory items are affected when products are sold.

### Overall Relationship

The core relationships can be represented conceptually as:

Employee
→ Order
→ Order Item
→ Product
→ Category

Product
→ Product Customization
→ Customization Option
→ Customization Group

Order Item
→ Order Item Customization
→ Customization Option
→ Customization Group

Order
→ Payment

Product
→ Inventory Item (future)

## 4. Table Definitions

### Employee

The Employee table will store information about employees who use the POS system.

| Field | Purpose |
|---|---|
| EmployeeID | Unique identifier for the employee |
| FirstName | Employee's first name |
| LastName | Employee's last name |
| Username | Username used to log into the POS |
| PasswordHash | Securely stored password hash |
| Role | Determines the employee's permissions |
| IsActive | Indicates whether the employee is currently active |

The EmployeeID will uniquely identify each employee.

Passwords will not be stored as plain text. The system will store a securely generated password hash instead.

The Role field will determine the employee's permissions. The initial roles will be Barista and Manager.

The IsActive field will allow an employee to be deactivated without deleting their historical association with previously processed orders.

### Category

The Category table will organize products into groups that can be displayed and selected within the POS.

| Field        | Purpose                                                          |
| ------------ | ---------------------------------------------------------------- |
| CategoryID   | Unique identifier for the category                               |
| CategoryName | Name of the product category                                     |

The initial categories will include:

* Espresso Drinks
* Brewed Coffee
* Tea
* Cold Drinks
* Hot Drinks
* Hot Breakfast
* Pastries
* Desserts
* Merchandise

Each product will belong to one category, while a category can contain multiple products.

Categories will not have an availability status in the MVP. Product availability will be managed at the individual product level rather than disabling entire categories.

### Product Customization

The Product Customization table will define which customization options are available for each product and any product-specific information associated with those options.

This table will allow the same customization option to be used by multiple products while allowing each product to determine whether the option is available and how much it changes the product's price.

| Field | Purpose |
|---|---|
| ProductCustomizationID | Unique identifier for the product customization relationship |
| ProductID | Identifies the product that can use the customization |
| CustomizationOptionID | Identifies the customization option available for the product |
| PriceAdjustment | Additional amount added to or subtracted from the product price when the option is selected |
| IsActive | Indicates whether the customization is currently available for this specific product |

Each record will associate one product with one customization option. A product can have many customization options, and a customization option can be available for many products.

The IsActive field allows managers to disable a customization for a specific product without disabling the option globally. For example, Oat Milk could remain available for lattes while temporarily being unavailable for a particular drink.

The PriceAdjustment field will store the current price adjustment for the option on that specific product. This allows the same customization to have different prices depending on the product.

For example:

| Product | Customization | Price Adjustment |
|---|---|---:|
| Americano | Room | $0.00 |
| Americano | Steamed Milk | $0.50 |
| Latte | Oat Milk | $0.80 |
| Latte | Almond Milk | $0.80 |

The Product Customization table will also allow the POS to determine which customization options should be displayed when a specific product is selected.

A product does not need to have any customization options. For example, a merchandise product can simply have no associated Product Customization records.

### Order

The Order table will store information about each customer transaction processed through the POS.

An order represents the overall transaction, while the individual products purchased as part of the transaction will be stored in the Order Item table.

| Field | Purpose |
|---|---|
| OrderID | Unique identifier for the order |
| EmployeeID | Identifies the employee who processed the order |
| OrderDateTime | Date and time the order was created |
| OrderStatus | Indicates the current status of the order |
| Subtotal | Total cost of the products and customizations before tax |
| Tax | Tax amount applied to the order |
| Total | Final amount charged to the customer |

Each order will be associated with one employee, while an employee can process many orders.

Each order can contain multiple Order Item records. This allows a single transaction to contain multiple products, such as a latte, a breakfast sandwich, and a pastry.

The OrderStatus field will allow the system to track the state of an order. Possible statuses may include:

- Open
- Paid
- Completed
- Cancelled

The Subtotal, Tax, and Total fields will preserve the financial values associated with the transaction at the time it was processed. These values will not depend on the current prices stored in the Product table.

Orders will not be physically deleted from the database after they have been processed. This preserves historical sales information and allows completed orders to be used for reporting.

### Order Item

The Order Item table will store the individual products included in an order.

Each Order Item represents one product purchased as part of a customer transaction. An order can contain multiple Order Item records, and the same product may appear multiple times within different orders.

| Field | Purpose |
|---|---|
| OrderItemID | Unique identifier for the order item |
| OrderID | Identifies the order containing the item |
| ProductID | Identifies the product that was purchased |
| Quantity | Number of units of the product purchased |
| UnitPrice | Product price at the time the order was created |
| Subtotal | Total price for this item before tax |

Each Order Item will belong to one Order, while an Order can contain multiple Order Items.

Each Order Item will reference one Product, while a Product can appear in many Order Items over time.

The UnitPrice field will preserve the product's price at the time it was added to the order. This is necessary because the current price stored in the Product table may change in the future.

For example, if a latte costs $6.00 when an order is placed and the price is later increased to $6.50, the historical Order Item will continue to store the original $6.00 price.

The Subtotal will represent the cost of the item based on its quantity and applicable customization price adjustments.

For example:

- Product price: $6.00
- Quantity: 2
- Customization adjustments: $0.80 per drink
- Item subtotal: $13.60

Order Item records will not be physically deleted from completed orders so that historical sales information remains accurate.

### Order Item Customization

The Order Item Customization table will store the specific customization options selected for each individual item in an order.

This table will preserve the customer's selections at the time the order was placed. This is important because the available customization options and their prices may change in the future.

| Field | Purpose |
|---|---|
| OrderItemCustomizationID | Unique identifier for the order item customization |
| OrderItemID | Identifies the specific item being customized |
| CustomizationOptionID | Identifies the customization option selected |
| PriceAdjustment | Price adjustment for the customization at the time of the order |

Each Order Item Customization record will belong to one Order Item, while an Order Item can have multiple customization selections.

Each customization selection will reference one Customization Option. The option's current availability or price will not be used to modify historical orders.

The PriceAdjustment field will preserve the price adjustment associated with the customization when the order was created. This prevents future changes to customization pricing from altering historical order totals.

For example:

**Order #1042**

1 × Large Iced Latte

| Customization | Price Adjustment |
|---|---:|
| Oat Milk | +$0.80 |
| Light Ice | $0.00 |
| Vanilla Syrup | +$0.60 |

The Order Item Customization records will allow the POS to reconstruct the customer's exact selections for production tickets, order history, and reporting.

Customization selections will not be physically deleted from completed orders, even if the corresponding customization option is later disabled or removed from the active menu.

### Payment

The Payment table will store payment information associated with customer orders.

A payment record will identify how an order was paid and the amount processed. Payment information will be stored separately from the Order table so that the database can support different payment methods and, if needed in the future, multiple payments for a single order.

| Field | Purpose |
|---|---|
| PaymentID | Unique identifier for the payment |
| OrderID | Identifies the order associated with the payment |
| PaymentMethod | Identifies how the customer paid |
| Amount | Amount processed for the payment |
| PaymentDateTime | Date and time the payment was processed |
| PaymentStatus | Indicates the status of the payment |

The PaymentMethod field will support payment methods such as:

- Cash
- Credit/Debit Card
- Mobile Payment

The PaymentStatus field can be used to track the result of a payment. Possible statuses may include:

- Pending
- Completed
- Failed
- Refunded

For the MVP, most completed orders will have one completed payment associated with the order. The database structure will allow multiple payment records for an order if this functionality is needed in the future.

Payment records will not store sensitive payment information such as full card numbers, security codes, or other payment credentials. The POS will only record the information necessary to identify and report the payment.

Completed payment records will be retained so that historical sales and payment information remains accurate.

### Inventory Item

The Inventory Item table will store the ingredients and supplies that are tracked by the coffee shop.

Inventory items may include ingredients used to prepare products as well as supplies needed for normal operations.

Examples include:

- Espresso beans
- Drip coffee
- Whole milk
- Oat milk
- Almond milk
- Vanilla syrup
- Caramel syrup
- Whipped cream
- Cups
- Lids
- Food packaging

| Field | Purpose |
|---|---|
| InventoryItemID | Unique identifier for the inventory item |
| ItemName | Name of the inventory item |
| UnitOfMeasure | Unit used to measure the inventory item |
| CurrentQuantity | Current quantity available |
| ReorderLevel | Quantity at which the item should be considered low |
| IsActive | Indicates whether the inventory item is currently being tracked |

The CurrentQuantity field will store the current amount of an inventory item available to the coffee shop.

The UnitOfMeasure field will identify how the quantity is measured. Depending on the item, units may include ounces, pounds, gallons, liters, individual units, or other appropriate measurements.

The ReorderLevel field will establish a threshold that can later be used for low-stock warnings or inventory management features.

The IsActive field will allow inventory items to be deactivated without deleting them from the database. Historical records can therefore continue to reference inventory items that are no longer actively used.

Inventory quantities may be adjusted by managers through the POS. Automatic inventory deduction based on product recipes will be considered a future feature.

## 5. Order and Customization Design

### Production Tickets

A production ticket is an instruction for preparing an order item rather than a separate source of transaction data.

For the MVP, production tickets will not be stored in a separate database table. Instead, the POS application will generate a production ticket from the Order, Order Item, and Order Item Customization records.

For example:

**ORDER #1042**

1 × LARGE ICED LATTE

- Milk: Oat
- Flavor: Vanilla
- Shots: 2
- Whipped Cream: No
- Cold Foam: Yes

This approach avoids storing duplicate order information while still allowing the application to display or print the exact preparation instructions associated with an order item.

Customization groups will support both single-selection and multi-selection behavior.

Each customization group will define selection rules that determine how many options may be selected.

Examples include:

- Ice: single selection
  - Regular
  - Light
  - Extra

- Milk: single selection
  - Whole
  - 2%
  - Oat
  - Almond

- Syrups: multiple selection
  - Vanilla
  - Caramel
  - Hazelnut
  - Mocha

Customization groups may also define minimum and maximum selection limits. This allows the system to support groups where no selection is required, groups requiring exactly one selection, and groups allowing multiple selections up to a defined limit.

### Product

The Product table will store the individual drinks, food items, and merchandise that can be sold through the POS.

| Field       | Purpose                                                       |
| ----------- | ------------------------------------------------------------- |
| ProductID   | Unique identifier for the product                             |
| ProductName | Name displayed for the product                                |
| CategoryID  | Identifies the category the product belongs to                |
| Price       | Current selling price of the product                          |
| IsActive    | Indicates whether the product is currently available for sale |

Each product will belong to one category, while a category can contain multiple products.

The IsActive field will allow managers to temporarily disable a product when it is unavailable. Disabling a product will prevent it from being selected for new orders without deleting it from the database.

Product records will be retained even when a product is no longer active so that historical orders can continue to reference products that were previously sold.

The Price field represents the product's current selling price. The price associated with an order item will be preserved separately when an order is created so that changes to a product's current price do not alter historical orders.

Products may have customization groups when applicable. Customizations will not be required for every product. For example, beverages may have customization groups for size, milk, ice, foam, or syrups, while merchandise items will not have customization options.

### Customization Group

The Customization Group table will define categories of customization choices that can be applied to products.

Examples of customization groups include:

* Size
* Temperature
* Milk
* Ice
* Foam
* Syrups
* Add-ons

Each customization group will define how many options a customer may select. This will allow the POS to support both single-selection and multi-selection customization groups.

| Field                |Purpose                                                          |
| -------------------- | ---------------------------------------------------------------- |
| CustomizationGroupID | Unique identifier for the customization group                    |
| GroupName            | Name of the customization group                                  |
| SelectionType        | Defines whether the group allows single or multiple selections   |
| MinimumSelections    | Minimum number of options that must be selected                  |
| MaximumSelections    | Maximum number of options that may be selected                   |
| DisplayOrder         | Determines the order in which the group is presented in the POS  |

### Selection Rules

The SelectionType field will identify whether a customization group allows a single option or multiple options.

For example:

* **Ice:** Single selection

  * Regular
  * Light
  * Extra

* **Milk:** Single selection

  * Whole
  * 2%
  * Oat
  * Almond

* **Temperature:** Single selection

  * Hot
  * Iced

* **Syrups:** Multiple selection

  * Vanilla
  * Caramel
  * Hazelnut
  * Mocha

The MinimumSelections and MaximumSelections fields will allow additional rules to be defined for each group.

For example, a Milk group could require exactly one selection, while a Syrups group could allow between zero and three selections.

The DisplayOrder field will allow the POS to present customization groups in a consistent progression when a product is selected. For example, a beverage customization flow may present Size first, followed by Temperature, Milk, Ice or Foam, and then Flavor or Add-ons. Individual customization options can still be disabled when they are unavailable.

### Customization Option

The Customization Option table will store the individual choices available within a customization group.

Examples of customization options include:

* Whole Milk
* Oat Milk
* Almond Milk
* Regular Ice
* Light Ice
* Extra Ice
* Vanilla Syrup
* Caramel Syrup
* Extra Foam
* Less Foam
* No Foam
* Room
* Steamed Milk

| Field                 | Purpose                                                  |
| --------------------- | -------------------------------------------------------- |
| CustomizationOptionID | Unique identifier for the customization option           |
| CustomizationGroupID  | Identifies the customization group the option belongs to |
| OptionName            | Name displayed for the option                            |
| IsActive              | Indicates whether the option is currently available      |

Each customization option will belong to one customization group, while a customization group can contain multiple options.

The IsActive field will allow managers to temporarily disable individual customization options without deleting them from the database. This can be used when an ingredient, preparation method, or other customization is temporarily unavailable.

Customization options will remain in the database when disabled so that historical orders can continue to reference options that were previously selected.

### Nested Customization Flow

The POS will present customization groups as a guided progression rather than displaying every possible customization at once.

The DisplayOrder field on Customization Group will determine the normal sequence in which applicable groups are presented. The application can then determine which groups and options apply to the selected product and, where appropriate, continue to the next relevant customization step.

For example, a latte customization flow may follow a sequence such as:

1. Size
2. Temperature
3. Milk
4. Ice for iced drinks or Foam for hot drinks
5. Flavor
6. Add-ons

The database will store the available groups and options, while the frontend will control the user-facing navigation between customization steps.

Customization options will not have a fixed price associated with them. Price adjustments will instead be determined by the relationship between a product and its available customization options. This allows the same customization option to have different prices depending on the product.


## 6. Product Availability

## 6. Product Availability

The POS will allow managers to temporarily make products and customization options unavailable without deleting their database records.

### Product Availability

Product availability will be controlled using the `IsActive` field in the Product table.

When a product is active, it can be selected and added to new orders. When a product is inactive, it will not be available for new orders.

For example, if a particular pastry is sold out, a manager can deactivate the product until it becomes available again.

Deactivating a product will not delete it from the database. Existing orders that contain the product will continue to reference the original product record.

### Customization Availability

Customization options will also have an `IsActive` field. This allows managers to temporarily disable an option when it is unavailable.

For example, if the coffee shop runs out of Oat Milk, the manager can deactivate the Oat Milk customization option. Oat Milk will no longer be offered for products using that option, but the option will remain in the database.

Customization options can also be disabled for a specific product through the Product Customization table.

This allows the system to distinguish between:

- A customization option that is unavailable for all products.
- A customization option that is unavailable for one specific product.
- A customization option that is currently available.

For example, Oat Milk could be generally available but temporarily disabled for one particular drink.

### Availability and Historical Orders

Availability changes will only affect new orders.

Existing and completed orders will retain their original products and customization selections even if those products or options are later deactivated.

The system will not delete historical product or customization records simply because they are no longer available for new orders.

This approach preserves accurate order history and allows previously sold products to remain available for sales reporting.

### Inventory and Availability

For the MVP, inventory quantities will not automatically control product availability.

Managers will be responsible for adjusting inventory quantities and manually disabling products or customization options when necessary.

Automatic availability based on inventory levels may be added as a future feature.

## 7. Inventory Design

## 7. Inventory Design

The inventory system will track the quantities of ingredients and supplies currently available to the coffee shop.

For the MVP, inventory management will focus on allowing managers to view and manually adjust inventory quantities. The system will not automatically deduct inventory when products are sold.

### Inventory Quantities

Each Inventory Item will have a CurrentQuantity representing the amount currently available.

The UnitOfMeasure field will identify how the inventory item is measured. The unit will depend on the type of item being tracked.

Examples include:

| Inventory Item | Unit of Measure |
|---|---|
| Espresso Beans | pounds |
| Whole Milk | gallons |
| Oat Milk | gallons |
| Vanilla Syrup | fluid ounces |
| Cups | individual units |
| Lids | individual units |

The database will store the quantity as a numeric value so that partial quantities can be represented when appropriate. For example, an inventory item measured in gallons could have a CurrentQuantity of 1.5.

### Manual Inventory Adjustments

Managers will be able to adjust inventory quantities through the POS.

Manual adjustments may be used when:

- New inventory is received.
- Inventory is damaged or discarded.
- A physical inventory count differs from the recorded quantity.
- An inventory item is used or removed outside of a customer transaction.

The MVP will store the current quantity but will not require a complete inventory transaction history.

### Product and Inventory Relationships

The MVP will not automatically connect products to the quantities of inventory they consume.

For example, the database will not initially define that:

- A latte uses a specific amount of espresso.
- A latte uses a specific amount of milk.
- A vanilla latte uses a specific amount of vanilla syrup.

This type of relationship would require a product recipe structure that defines which inventory items are used by each product and how much of each item is consumed.

A product-to-inventory relationship may be added as a future database expansion.

### Inventory and Product Availability

Inventory quantities will not automatically determine whether a product or customization option is available in the MVP.

Managers will manually control product and customization availability using the availability fields defined in the Product, Customization Option, and Product Customization tables.

Future versions may use inventory quantities and product recipes to automatically determine when products or customization options should be disabled.

### Inventory and Reporting

Inventory quantities will be separate from sales reporting.

Sales reports will be based on completed orders and their associated Order Items and Order Item Customizations.

Inventory information may be incorporated into future reports to help managers compare product sales with ingredient usage and make purchasing decisions.

## 8. Historical Data Integrity

## 8. Historical Data Integrity

The database will preserve historical order information independently from the current product and customization configuration.

Products, customization options, prices, and availability may change over time. These changes must not alter the information associated with orders that have already been processed.

### Historical Product Prices

The Order Item table will store the UnitPrice of a product at the time it was added to an order.

This prevents changes to the current Product price from affecting historical orders.

For example, if a latte costs $6.00 when an order is placed and the price is later changed to $6.50, the original Order Item will continue to store the $6.00 price.

### Historical Customization Prices

The Order Item Customization table will store the PriceAdjustment for each customization at the time the order was created.

This prevents future changes to customization pricing from altering historical order totals.

For example, if Oat Milk costs an additional $0.80 when an order is placed and the price is later changed to $1.00, previously completed orders will continue to show the original $0.80 adjustment.

### Deactivated Products and Customizations

Products and customization options will not be physically deleted when they become unavailable.

Instead, the appropriate availability field will be changed to inactive.

This allows historical orders to continue referencing the original product and customization records.

For example, if a product is removed from the active menu, an old order containing that product will still be able to display the product's name and associated information.

### Preserving Order Information

Completed orders will retain their associated Order Items and Order Item Customizations.

The database will not modify historical order information when current menu configuration changes.

Historical order information will be used for:

- Sales reporting
- Order history
- Production ticket generation
- Revenue calculations
- Product popularity analysis

### Data Deletion

The MVP will avoid physically deleting products, customization options, and completed orders when doing so could compromise historical data.

Records that are no longer active will generally be deactivated rather than deleted.

This approach preserves referential integrity and ensures that historical sales information remains accurate over time.

## 9. Design Decisions

## 9. Design Decisions

The database design decisions below were made to support the requirements of the MVP while keeping the system flexible for future expansion.

### Relational Database Structure

The database will use a relational structure with separate tables for employees, products, orders, customizations, payments, and inventory.

Related information will be connected through primary and foreign keys rather than storing repeated information in a single table.

This structure reduces duplicate data and makes the database easier to maintain and expand.

### Product Availability Instead of Deletion

Products and customization options will be deactivated rather than physically deleted when they are no longer available.

This preserves historical references and prevents past orders from losing information when the active menu changes.

### Product-Specific Customization Pricing

Customization prices will be stored in the Product Customization relationship rather than in the Customization Option table.

This allows the same customization to have different prices depending on the product.

For example, Steamed Milk may have one price when added to an Americano and a different price when added to another beverage.

### Historical Price Preservation

Product prices and customization price adjustments will be copied into the appropriate order records when a transaction is created.

This ensures that historical orders retain the prices that were actually charged, even if current menu prices change.

### Product-Specific Customization Availability

Customization options can be available for some products but unavailable for others.

The Product Customization table will allow managers to control whether an individual customization is available for a specific product without disabling the customization globally.

### Flexible Customization Selection Rules

Customization Groups will define selection rules so that the POS can support both single-selection and multiple-selection customizations.

For example, a customer may select only one milk option but may select multiple syrup options.

Minimum and maximum selection values will allow the system to enforce the appropriate number of choices.

The DisplayOrder value will allow the POS to present applicable customization groups in a predictable sequence for guided, nested customization flows.

### Manual Inventory Management for the MVP

The MVP will allow managers to view and manually adjust inventory quantities.

Automatic inventory deduction based on product recipes will not be required for the initial version.

This keeps the MVP focused on the core POS workflow while leaving room for a more advanced inventory system in the future.

### Limited Employee Roles

The MVP will use two employee roles: Barista and Manager.

A separate role table will not be required initially because the number of roles is small and well defined.

A future version could introduce a separate role and permission system if more detailed access control becomes necessary.

### No Customer Accounts in the MVP

The POS will not require customer accounts for the MVP.

Orders will represent individual transactions without requiring customers to create accounts or provide personal information.

Customer accounts, loyalty programs, and related functionality may be considered for future expansion.

### Sales Reporting Based on Historical Transactions

Sales reports will be generated from completed orders, Order Items, and their associated payment information.

Reports will use the historical transaction values stored when orders were processed rather than current product prices.

This will allow the system to accurately analyze sales over selected date ranges and identify popular products.

## 10. Future Database Expansion

## 10. Future Database Expansion

The initial database design will focus on the core functionality required for the MVP. The following features may be added in future versions as the POS system becomes more advanced.

### Product Recipes and Inventory Usage

A future version may create a product recipe relationship between products and inventory items to define the ingredients and quantities required to produce each product.

For example:

- A latte may require a specific amount of espresso and milk.
- A vanilla latte may require espresso, milk, and vanilla syrup.
- Selecting an alternative milk may change which inventory item is consumed.

This would allow the system to automatically deduct inventory when products are sold.

### Automatic Inventory Deduction

Once product recipes are supported, inventory quantities could be automatically updated when an order is completed.

The system could account for both the base product and customer customizations.

For example, ordering a latte with oat milk could automatically deduct the appropriate amounts of espresso, oat milk, and other ingredients from inventory.

### Inventory Transaction History

A future version could store a history of inventory changes rather than only maintaining the current quantity.

Inventory transactions could record:

- Inventory received
- Inventory used
- Inventory discarded
- Manual adjustments
- Inventory corrections

This would allow managers to review how inventory quantities changed over time.

### Low-Stock Alerts

The ReorderLevel field will allow the system to support low-stock alerts in the future.

The POS could notify managers when an inventory item's CurrentQuantity falls below its ReorderLevel.

### Receiving and Purchasing

Future versions may include functionality for recording incoming inventory shipments and purchases.

This could allow managers to track when inventory was ordered, received, and added to the available quantity.

### Expanded Employee Management

The MVP will include Barista and Manager roles, but future versions could allow managers to create, edit, deactivate, and manage employee accounts directly through the POS.

A more advanced permission system could also be introduced if different levels of access are needed.

### Advanced Reporting

Future reports could expand beyond basic sales and product popularity to include:

- Sales by employee
- Sales by payment method
- Inventory usage
- Product profitability
- Customization popularity
- Waste and inventory loss
- Sales comparisons across different time periods

### Customer Accounts and Loyalty

Customer accounts may be added in a future version to support features such as:

- Customer profiles
- Order history
- Loyalty points
- Rewards
- Saved preferences

These features are outside the scope of the MVP and will not be required for the initial database implementation.