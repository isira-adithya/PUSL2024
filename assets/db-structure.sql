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

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS ShoppingCart;

CREATE TABLE Users (
    userid INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
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
INSERT INTO Users (userid, username, password, email) VALUES
(1, 'john_doe', 'password123', 'john.doe@example.com'),
(2, 'alice_smith', 'securepass', 'alice.smith@example.com'),
(3, 'bob_jones', 'pass123', 'bob.jones@example.com'),
(4, 'emma_wilson', 'emma_pass', 'emma.wilson@example.com'),
(5, 'mike_brown', 'mike_pass', 'mike.brown@example.com'),
(6, 'linda_jackson', 'linda_pass', 'linda.jackson@example.com'),
(7, 'alex_martin', 'alex_pass', 'alex.martin@example.com'),
(8, 'susan_white', 'susan_pass', 'susan.white@example.com'),
(9, 'kevin_hill', 'kevin_pass', 'kevin.hill@example.com'),
(10, 'natalie_adams', 'natalie_pass', 'natalie.adams@example.com');

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

