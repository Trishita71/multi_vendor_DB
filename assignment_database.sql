-- Active: 1755360383003@@127.0.0.1@3306@multi_vendors_database
SET sql_mode = 'STRICT_ALL_TABLES';

-------------Part A: ERD & Database Design -> completed
-- -- -- Part B: SQL DDL (Table Creation):

CREATE DATABASE multi_vendors_databases;

CREATE TABLE subscriptionPlans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration INT NOT NULL,
    features TEXT
);
CREATE TABLE Vendor (
    vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    business_name VARCHAR(100) NOT NULL,  
    contact_person VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(11) NOT NULL UNIQUE,
    business_address TEXT NOT NULL,
    subscription_id INT NOT NULL,
    Foreign Key (subscription_id) REFERENCES subscriptionPlans(plan_id)
);
CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    status ENUM('active','inactive') DEFAULT 'active',
    vendor_id INT NOT NULL,
    Foreign Key (vendor_id) REFERENCES Vendor(vendor_id)
);

CREATE TABLE ProductCategory (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id,category_id),
    Foreign Key (product_id) REFERENCES Product(product_id) ON DELETE CASCADE,
    Foreign Key (category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(11) NOT NULL UNIQUE,
    address TEXT NOT NULL
);
CREATE TABLE Orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK(total_amount >= 0),
    order_status ENUM('pending','processing','shipping','cancelled','delivered') DEFAULT 'pending',
    customer_id INT NOT NULL,
    Foreign Key (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE OrderItem (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL CHECK(quantity >= 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK(unit_price >= 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK(subtotal >= 0) ,
    product_id INT NOT NULL,
    Foreign Key (product_id) REFERENCES Product(product_id),
    order_id INT NOT NULL,
    Foreign Key (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    method ENUM('Card','Bkash','PayPal','Cash on Delivery') NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_date DATE NOT NULL,
    payment_status ENUM('pending','success','failed','refunded') NOT NULL DEFAULT 'pending',
    order_id INT NOT NULL UNIQUE,
    Foreign Key (order_id) REFERENCES Orders(order_id)
);

-------------------------Inserting data to each table-----------------------------------

------ subscriptionPlans---------
INSERT INTO subscriptionPlans(plan_name, price, duration, features)
VALUES
    ('Basic', 1000.00, 15, 'Up to 50 products, Basic analytics'),
    ('Premium', 2000.00, 20, 'Up to 200 products, Advanced analytics, Priority support'),
    ('Enterprise', 3000.00, 25, 'Unlimited products, Full analytics suite, Dedicated support');

--------------Category---------------
INSERT INTO Category(category_name, description)
VALUES
    ('Electronics', 'Electronic devices and gadgets'),
    ('Clothing', 'Apparel and fashion items'),
    ('Books', 'Books and educational materials'),
    ('Shoes', 'Bata and Apex items');

-------------------Vendor--------------
INSERT INTO Vendor (business_name, contact_person, email, phone_number, business_address,subscription_id) 
VALUES
    ('ClothStore Ltd.', 'Jeneva Samual', 'jeneva@cloth.com', '0181234567', 'Barishal, Bangladesh', 2),
    ('BookStore Ltd.', 'Dev Jhon', 'dev@books.com', '0191234567', 'Rajshahi, Bangladesh', 3);

----------------------Product------------------------
INSERT INTO Product(product_name,description,price,stock_quantity,status,vendor_id)
VALUES
('Freeze', 'preserve foods safely', 40000.00, 20, 'active',1),
('Lehenga','Exclusive and gorgeous', 30000.00, 15, 'active', 2),
('Learn_Python', 'An informative book',600.00, 50,'active',3),
('Saree', 'designed with jamdani motive', 8000.00, 20, 'active',2);

-----------------------ProductCategory -----------------------
INSERT INTO ProductCategory (product_id, category_id) 
VALUES
    (2, 1), 
    (3, 2), 
    (4, 3), 
    (5, 2);

---------------------Customer-----------------
INSERT INTO Customer(name, email, phone_number, address)
VALUES
('Karim Uddin', 'karim@gmail.com', '01738467532', 'CDA avenue, Chittagong'),
('Rohit Shorma', 'rohit@gmail.com', '01782563872', 'Bonani, Dhaka'),
('Sawstika Roy', 'sawstika@gmail.com', '01789276354', 'Jalalabad, Cumilla');

--------------------------Orders--------------------------
INSERT INTO Orders(order_date, total_amount, order_status, customer_id)
VALUES
('2025-02-10', 50000.00, 'delivered', 2),
('2025-04-18', 60000.00, 'shipping', 3),
('2025-02-25', 5000.00, 'processing', 2);

------------------orderitem-----------------
INSERT INTO orderitem(quantity, unit_price, subtotal, product_id, order_id)
VALUES
(1, 40000.00, 40000.00, 2, 1),
(5, 600.00, 3000.00, 4, 1),
(1, 30000.00, 30000.00, 3, 2),
(3, 8000.00, 24000.00, 5, 2),
(7, 600.00, 4200.00, 4, 3);

-----------------------Payment----------------------
INSERT INTO Payment(method, amount, payment_date, payment_status, order_id) 
VALUES
('Card', 50000.00, '2025-02-10', 'success', 1),
('Bkash', 60000.00, '2025-04-18', 'success', 2),
('PayPal', 5000.00, '2025-02-25', 'pending', 3);

--------------------------Part C: SQL DML (Insert/Update/Delete)----------------

--6. Insert a new vendor named "SmartTech Ltd.", with contact person Rahim Khan, email rahim@smarttech.com, phone 017XXXXXXXX, address Dhaka, Bangladesh, under the Basic plan.

INSERT INTO Vendor(business_name, contact_person,email, phone_number,business_address,subscription_id)
VALUES
('SmartTech Ltd.', 'Rahim Khan', 'rahim@smarttech.com', '017XXXXXXXX', 'Dhaka,Bangladesh',1);

--7.Insert a product called "Laptop" under the Electronics category, price 75,000, stock 10,status active, belonging to SmartTech Ltd.

INSERT INTO Product(product_name, description, price, stock_quantity, status, vendor_id)
VALUES
('Laptop', 'core i3 8GB RAM', 75000, 10, 'active', 1);
INSERT INTO productcategory(category_id,product_id)
VALUES (1,1);

-- 8. Update the stock quantity of "Laptop" product to 15.
UPDATE Product SET stock_quantity = 15 WHERE product_name = 'Laptop';

-- 9. Delete a customer whose email is "oldcustomer@gmail.com".

INSERT INTO customer(name,email, phone_number,address)
VALUES
('Tom','oldcustomer@gmail.com','01879826346','Old Chittagong');
DELETE FROM customer WHERE email = 'oldcustomer@gmail.com';

---------------------------------- Part D: SQL Queries (DQL) --------------------

-- 10. Write a query to display all vendors along with their subscription plan name and price.

SELECT 
    v.vendor_id,v.business_name,v.contact_person,v.email,s.plan_name,s.price
FROM vendor v
JOIN subscriptionplans s ON v.subscription_id = s.plan_id;

-- 11. Find all products under the category "Electronics" with their name, price, and stock quantity.

SELECT p.product_name, p.price,p.stock_quantity
FROM Product p
JOIN ProductCategory pc ON pc.product_id = p.product_id
JOIN Category c ON pc.category_id = c.category_id
WHERE category_name = "Electronics";

-- 12. List all orders placed by customer "Karim Uddin", showing order_id, date, total_amount and status.

SELECT o.order_id, o.order_date, o.total_amount, o.order_status
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE c.name = 'Karim Uddin';

-- 13. Show the payment details (method, amount, status) for order_id = 1.

SELECT p.method, p.amount, p.payment_status
FROM payment p 
WHERE p.order_id = 1;

-- 14. Find the top 5 best-selling products based on total quantity sold.

SELECT p.product_id, p.product_name AS product_name, SUM(oi.quantity) AS total_qty_sold
FROM orderitem oi
JOIN product p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_qty_sold DESC
LIMIT 5;

--------------------------- Part E: Advanced SQL----------------------

-- 15. Write a query to calculate the total sales amount per vendor.

SELECT v.vendor_id, v.business_name, SUM(o.total_amount) AS total_sales
FROM vendor v
JOIN product p ON v.vendor_id = p.vendor_id
JOIN orderitem oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
JOIN payment pm ON pm.order_id = o.order_id
WHERE pm.payment_status = 'success'
GROUP BY v.vendor_id
ORDER BY total_sales DESC;

-- 16. Find the names of customers who have not placed any orders.

SELECT c.name
FROM customer c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.customer_id is NULL;

-- 17. Show the total number of active products available in the platform.

SELECT COUNT(p.status) AS total_number_of_active_product
FROM product p
WHERE p.status = 'active';

-- 18. Retrieve the details of vendors who are subscribed to the Enterprise plan.

SELECT v.vendor_id, v.business_name, v.contact_person, v.email, v.phone_number, v.business_address,s.plan_name
FROM vendor v
JOIN subscriptionplans s ON s.plan_id = v.subscription_id
WHERE s.plan_name = 'Enterprise';

-- 19. Write a query to calculate the average order amount per customer.

SELECT c.customer_id, AVG(o.total_amount) AS avg_order, COUNT(o.customer_id) AS total_order
FROM customer c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id;

-- 20. Display the list of customers who purchased products from more than one vendor.

SELECT c.name, COUNT (DISTINCT p.vendor_id) AS vendor_count 
FROM customer c 
JOIN orders o ON o.customer_id = c.customer_id
JOIN orderitem oi ON oi.order_id = o.order_id
JOIN product p ON oi.product_id = p.product_id
GROUP BY c.customer_id
HAVING vendor_count > 1;





