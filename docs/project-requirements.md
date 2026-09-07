# Coffee Shop POS — Project Requirements

## 1. Project Overview

The Coffee Shop POS is a portfolio-grade, full-stack point-of-sale system designed for a coffee shop environment. The system will allow employees to create and process customer orders while providing functionality for managing products, employees, payments, and other operational data.

The project is being developed as an independent software development project inspired by real-world barista and coffee shop workflows. It will be designed from the ground up rather than attempting to reproduce an existing commercial POS system.

The project will begin with database design and development before expanding into backend and frontend development.

## 2. Project Goals

The primary goals of this project are to:

- Design and implement a relational database for a coffee shop POS system.
- Develop a functional backend capable of interacting with the database.
- Build a user-friendly POS interface for processing orders.
- Practice full-stack software development using technologies relevant to the developer's career goals.
- Apply software engineering concepts such as database normalization, API design, authentication, testing, version control, and documentation.
- Create a substantial portfolio project that demonstrates the ability to design and develop a software system from the ground up.
- Maintain clear documentation throughout development to track design decisions, progress, challenges, and future improvements.

## 3. Target Users

### Barista

The primary user of the POS system. Baristas will use the system to log in, create customer orders, customize products, finalize transactions, and generate order tickets.

### Manager

A user with elevated permissions who may eventually manage products, employees, inventory, and sales reports.

### Customer

The customer does not directly interact with the POS in the initial version. Their role is to provide the order details and payment to the barista.

## 4. Primary Transaction Workflow

The primary POS transaction will follow this sequence:

1. **Customer Arrives**
   - A customer approaches the register and is ready to place an order.

2. **Employee Login**
   - The barista logs into the POS using their employee credentials.
   - The system identifies the employee processing the transaction.

3. **Order Creation**
   - The barista begins a new customer order.

4. **Product Selection**
   - The barista selects the appropriate main product category.
   - The POS presents the products available within that category.

5. **Product Customization**
   - The barista progresses through a nested customization workflow based on the selected product.
   - Available customization options may include size, temperature, milk type, flavors, toppings, add-ons, and other product-specific options.
   - The system should only present customization options that are applicable to the selected product.

6. **Order Finalization**
   - The barista reviews the completed order.
   - The POS calculates the applicable subtotal, taxes, discounts, and final total.
   - The barista confirms the order.

7. **Payment**
   - The customer provides payment.
   - The barista records the appropriate payment method.
   - The system records the payment against the order.

8. **Ticket Creation**
   - Once the transaction is successfully completed, the system creates an order ticket containing the information necessary to fulfill the customer's order.

## 5. Production Tickets

The POS will generate a production ticket after an order has been successfully finalized and payment has been recorded.

The production ticket will serve as instructions for the barista preparing the order. It must contain the selected product and all relevant customizations required to prepare the item.

Production tickets must preserve the product configuration selected at the time the order was placed. Subsequent changes to product availability, customization options, or inventory must not alter previously completed tickets.

## 6. Product Availability

The POS will support temporary availability controls for products and product customization options.

Managers will be able to disable products or customization options when an ingredient or product is unavailable. Disabling an item will prevent it from being selected for new orders without removing the underlying item from the database.

Product availability may eventually be connected to inventory levels so that items can be automatically disabled when required inventory reaches an unavailable state.

Managers will also be able to restore availability when products or ingredients become available again.

## 7. Manager Functionality

Managers will have elevated permissions within the POS system. The MVP will include the following management capabilities:

* Add products to the menu.
* Remove products from the menu.
* Change product prices.
* Disable or re-enable individual products.
* Disable or re-enable individual customization options.
* Control which customization options are available for a particular product.
* Adjust inventory quantities.
* View sales reports.

Products and customization options should not be permanently deleted when they become unavailable. Instead, their availability should be changed so that they cannot be selected for new orders while historical order data remains intact.

### Future Manager Features

The following features are outside the scope of the initial MVP but may be implemented in future versions:

* Receiving and recording shipments.
* Automated low-stock alerts.
* Creating and editing employee accounts through the manager interface.

## 8. Sales Reporting

The POS will provide sales reports focused on information that can help managers make purchasing, inventory, and business decisions.

### MVP Sales Reports

#### Total Sales

Managers will be able to view:

* Total sales for a selected date range.
* Total number of orders for a selected date range.
* Average order value.

#### Product Sales

Managers will be able to view sales information for individual products, including:

* Quantity sold.
* Revenue generated.
* Ranking of products by quantity sold.
* Ranking of products by revenue.

The product sales report is intended to help managers identify which products are most popular and use that information to make purchasing and inventory decisions.

#### Sales Trends

Managers will be able to view sales totals over time, such as:

* Daily sales.
* Weekly sales.
* Monthly sales.

Sales by employee and sales by payment method are not considered priorities for the MVP but may be added in a future version.

## 9. Functional Requirements

### Employee Authentication

- The system must require an employee to log in before processing an order.
- The system must identify the employee responsible for each order.
- The system must support different permission levels for employees and managers.

### Order Processing

- The system must allow a barista to create a new order.
- The system must organize products into categories.
- The system must allow the barista to select a product and customize it.
- The system must only display customization options that apply to the selected product.
- The system must prevent unavailable products and customizations from being added to new orders.
- The system must calculate the order subtotal, applicable taxes, discounts, and final total.
- The system must allow the barista to finalize an order and record payment.

### Production Tickets

- The system must generate a production ticket after an order is successfully completed.
- The production ticket must contain the product and its selected customizations.
- Completed production tickets must preserve the selections made when the order was placed.

### Product and Inventory Management

- The system must allow managers to add products.
- The system must allow managers to remove products from the active menu.
- The system must allow managers to change product prices.
- The system must allow managers to disable or re-enable products.
- The system must allow managers to disable or re-enable individual customization options.
- The system must allow managers to control which customizations are available for individual products.
- The system must allow managers to adjust inventory quantities.

### Sales Reporting

- The system must allow managers to view total sales for a selected date range.
- The system must allow managers to view the number of orders for a selected date range.
- The system must allow managers to view average order value.
- The system must provide product sales information, including quantity sold and revenue generated.
- The system must allow product sales to be sorted or ranked by popularity.
- The system must provide sales totals over time, such as daily, weekly, or monthly sales.

## 10. Data Requirements

The system will need to store information about employees, products, orders, customizations, payments, and inventory.

### Employees

The system should store:

- Employee ID
- Employee name
- Login credentials
- Employee role
- Active/inactive status

### Products

The system should store:

- Product ID
- Product name
- Product category
- Product price
- Active/inactive status

### Categories

The system should store:

- Category ID
- Category name

### Orders

The system should store:

- Order ID
- Employee responsible for the order
- Order date and time
- Order status
- Items included in the order
- Quantity of each item
- Price information
- Order total

### Customizations

The system should store:

- Customization ID
- Customization name
- Customization type
- Price adjustment
- Active/inactive status
- Products that allow the customization

### Payments

The system should store:

- Payment ID
- Associated order
- Payment method
- Payment amount
- Payment status
- Payment date and time

The system must not store sensitive payment information such as credit card numbers.

### Inventory

The system should store:

- Inventory item ID
- Inventory item name
- Quantity on hand
- Unit of measurement
- Availability/status
- Reorder level

## 11. MVP Scope

The initial version of the system will focus on the core functionality required to process orders and provide basic management capabilities.

### Included in MVP

- Employee login
- Product and category management
- Product customization
- Order creation and processing
- Payment recording
- Production ticket generation
- Product availability controls
- Inventory quantity adjustments
- Total sales reporting
- Product sales reporting
- Basic sales trends

### Outside MVP

The following features will be considered for future versions:

- Receiving shipments
- Automated low-stock alerts
- Manager creation/editing of employee accounts
- Advanced inventory automation
- Customer accounts and loyalty programs