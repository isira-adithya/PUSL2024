/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  @isira_adithya
 * Created: Dec 7, 2023
 */

-- This is a very simple and minimal database structure, this should be modified in the future.
-- As of 07/12/23, I am gonna use the following structure to build the API
-- @isira_adithya
USE greensupermarket;

DROP TABLE IF EXISTS ShoppingCart;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    userid INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    phone VARCHAR(20), /* Should contain the country code, for ex: +94123456789 */
    street_address VARCHAR(1000), /* For ex: No 74, Sundara Mawatha */
    city VARCHAR(1000), /* Gampaha */
    state VARCHAR(1000), /* Western Province */
    country VARCHAR(1000), /* Sri Lanka */
    postalcode VARCHAR(100), /* 11870 */
    role VARCHAR(100) /* USER, ADMIN */
);
CREATE TABLE Products (
    productid INT PRIMARY KEY,
    productname VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);
CREATE TABLE Orders (
    orderid INT PRIMARY KEY,
    userid INT,
    orderdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE
);
CREATE TABLE OrderDetails (
    orderdetailid INT PRIMARY KEY,
    orderid INT,
    productid INT,
    quantity INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orderid) REFERENCES Orders(orderid) ON DELETE CASCADE,
    FOREIGN KEY (productid) REFERENCES Products(productid) ON DELETE CASCADE
);
CREATE TABLE ShoppingCart (
    shoppingcartid INT PRIMARY KEY,
    userid INT,
    productid INT,
    quantity INT NOT NULL,
    FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE,
    FOREIGN KEY (productid) REFERENCES Products(productid) ON DELETE CASCADE
);

-- Sample Data
INSERT INTO Users (userid, email, password, firstname, lastname, phone, street_address, city, state, country, postalcode, role) VALUES
(1, 'john.doe@example.com', 'password123', 'John', 'Doe', '+94123456789', 'No 74, Sundara Mawatha', 'Gampaha', 'Western Province', 'Sri Lanka', '11870', 'USER'),
(2, 'alice.smith@example.com', 'securepass', 'Alice', 'Smith', '+94123456790', 'Apt 12, Rose Gardens', 'Colombo', 'Western Province', 'Sri Lanka', '10100', 'USER'),
(3, 'bob.jones@example.com', 'pass123', 'Bob', 'Jones', '+94123456791', 'Lot 5, Green Avenue', 'Kandy', 'Central Province', 'Sri Lanka', '20000', 'USER'),
(4, 'emma.wilson@example.com', 'emma_pass', 'Emma', 'Wilson', '+94123456792', 'House 8, Blue Street', 'Negombo', 'Western Province', 'Sri Lanka', '11500', 'USER'),
(5, 'mike.brown@example.com', 'mike_pass', 'Mike', 'Brown', '+94123456793', 'Villa 3, Palm Lane', 'Jaffna', 'Northern Province', 'Sri Lanka', '40000', 'USER'),
(6, 'linda.jackson@example.com', 'linda_pass', 'Linda', 'Jackson', '+94123456794', 'Block C, Sun City Apartments', 'Matara', 'Southern Province', 'Sri Lanka', '81000', 'USER'),
(7, 'alex.martin@example.com', 'alex_pass', 'Alex', 'Martin', '+94123456795', 'Unit 6, Hillside Residency', 'Anuradhapura', 'North Central Province', 'Sri Lanka', '50000', 'USER'),
(8, 'susan.white@example.com', 'susan_pass', 'Susan', 'White', '+94123456796', 'Lane 23, Meadow View', 'Batticaloa', 'Eastern Province', 'Sri Lanka', '30000', 'USER'),
(9, 'kevin.hill@example.com', 'kevin_pass', 'Kevin', 'Hill', '+94123456797', 'Flat 4B, Skyline Tower', 'Trincomalee', 'Eastern Province', 'Sri Lanka', '31000', 'USER'),
(10, 'natalie.adams@example.com', 'natalie_pass', 'Natalie', 'Adams', '+94123456798', 'No 17, Golden Lane', 'Galle', 'Southern Province', 'Sri Lanka', '80000', 'USER'),
(11, 'isira@greensupermarket.io', 'AdminPass123', 'Isira', 'Adithya', '+94123456798', 'No 17, Golden Lane', 'Colombo', 'Western Province', 'Sri Lanka', '42369', 'USER');

INSERT INTO Products (productid, productname, price, description) VALUES
(1, 'Laptop', 999.99, 'Powerful laptop for all your needs'),
(2, 'Smartphone', 599.99, 'Latest smartphone with advanced features'),
(3, 'Headphones', 79.99, 'High-quality over-ear headphones'),
(4, 'Tablet', 399.99, 'Compact tablet for on-the-go use'),
(5, 'Desktop Computer', 1499.99, 'High-performance desktop computer'),
(6, 'Camera', 299.99, 'Professional-grade digital camera'),
(7, 'Smartwatch', 199.99, 'Smartwatch with fitness tracking features'),
(8, 'Bluetooth Speaker', 49.99, 'Portable Bluetooth speaker with crisp sound'),
(9, 'Gaming Console', 499.99, 'Next-gen gaming console for immersive gaming'),
(10, 'Wireless Router', 79.99, 'High-speed wireless router for seamless connectivity');

INSERT INTO Orders (orderid, userid, amount) VALUES
(1, 1, 1249.98),
(2, 2, 1679.97),
(3, 3, 359.98),
(4, 4, 799.95),
(5, 5, 299.99),
(6, 6, 899.97),
(7, 7, 459.96),
(8, 8, 129.98),
(9, 9, 679.94),
(10, 10, 239.97);

INSERT INTO OrderDetails (orderdetailid, orderid, productid, quantity, subtotal) VALUES
(1, 1, 1, 2, 1999.98),
(2, 2, 2, 1, 599.99),
(3, 3, 3, 3, 239.97),
(4, 4, 4, 1, 399.99),
(5, 5, 5, 1, 1499.99),
(6, 6, 6, 2, 599.98),
(7, 7, 7, 4, 799.96),
(8, 8, 8, 1, 49.99),
(9, 9, 9, 3, 1499.97),
(10, 10, 10, 2, 159.98);

INSERT INTO ShoppingCart (shoppingcartid, userid, productid, quantity) VALUES
(1, 1, 2, 1),
(2, 2, 3, 2),
(3, 3, 1, 3),
(4, 4, 4, 1),
(5, 5, 5, 2),
(6, 6, 6, 1),
(7, 7, 7, 4),
(8, 8, 8, 2),
(9, 9, 9, 1),
(10, 10, 10, 3);

