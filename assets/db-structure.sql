 /**
 * Author:  @isira_adithya
 * Created: Dec 7, 2023
 */

-- This is a very simple and minimal database structure, this should be modified in the future.
-- As of 07/12/23, I am going to use the following structure to build the API
-- @isira_adithya
DROP DATABASE IF EXISTS greensupermarket;
CREATE DATABASE greensupermarket;
USE greensupermarket;

DROP TABLE IF EXISTS ShoppingCart CASCADE;
DROP TABLE IF EXISTS OrderDetails CASCADE;
DROP TABLE IF EXISTS Comments CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

CREATE TABLE Users (
    userid INT AUTO_INCREMENT PRIMARY KEY,
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
    role VARCHAR(100), /* USER, ADMIN */
    passwordresettoken VARCHAR(32), /* Default: NULL (Keep in mind, there should be a check in the backend if the value if NULL if not this would be exploitable to account takeovers) */
    is_email_verified BOOLEAN,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Products (
    productid INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    description VARCHAR(8196),
    short_description VARCHAR(512),
    image VARCHAR(1024),
    visibility BOOLEAN,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    orderid INT AUTO_INCREMENT PRIMARY KEY,
    userid INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    additionalCharges DECIMAL(10, 2),
    status VARCHAR(32), /* PENDING, COMPLETED, CANCELLED */
    delivery_status VARCHAR(32), /* N/A, PENDING, COMPLETED, CANCELLED */
    payment_status VARCHAR(32), /* PENDING, COMPLETED, ERROR */
    FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE
);
CREATE TABLE OrderDetails (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    orderid INT,
    productid INT,
    productname VARCHAR(256) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (orderid) REFERENCES Orders(orderid) ON DELETE CASCADE,
    FOREIGN KEY (productid) REFERENCES Products(productid) ON DELETE SET NULL
);
CREATE TABLE Comments (
      commentid INT AUTO_INCREMENT PRIMARY KEY,
      userid INT,
      productid INT,
      content VARCHAR(256),
      starcount INT,
      createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE,
      FOREIGN KEY (productid) REFERENCES Products(productid) ON DELETE CASCADE
);
 CREATE TABLE Wishlists (
     wishlistid INT AUTO_INCREMENT PRIMARY KEY,
     userid INT UNIQUE,
     createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE
 );
 CREATE TABLE WishlistDetails (
       wishlistdetailid INT AUTO_INCREMENT PRIMARY KEY,
       wishlistid INT,
       productid INT,
       FOREIGN KEY (wishlistid) REFERENCES Wishlists(wishlistid) ON DELETE CASCADE,
       FOREIGN KEY (productid) REFERENCES Products(productid) ON DELETE CASCADE,
       CONSTRAINT wishlist_product_key UNIQUE (wishlistid, productid)
 );
CREATE TABLE SupportTickets (
    ticketid INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(256),
    email VARCHAR(128),
    title VARCHAR(1024),
    subject VARCHAR(4096),
    markedAsRead BOOLEAN DEFAULT false,
    createdAt TIMESTAMP
);

-- Sample Data
INSERT INTO Users (userid, email, password, firstname, lastname, phone, street_address, city, state, country, postalcode, role, passwordresettoken, is_email_verified, createdAt) VALUES
(1, 'john.doe@example.com', 'password123', 'John', 'Doe', '+94123456789', 'No 74, Sundara Mawatha', 'Gampaha', 'Western Province', 'Sri Lanka', '11870', 'USER', 'NULL', true, TIMESTAMP('2023-07-12', '12:10:48')),
(2, 'alice.smith@example.com', 'securepass', 'Alice', 'Smith', '+94123456790', 'Apt 12, Rose Gardens', 'Colombo', 'Western Province', 'Sri Lanka', '10100', 'USER', 'NULL', false, TIMESTAMP('2023-12-20', '10:20:34')),
(3, 'bob.jones@example.com', 'pass123', 'Bob', 'Jones', '+94123456791', 'Lot 5, Green Avenue', 'Kandy', 'Central Province', 'Sri Lanka', '20000', 'USER', 'NULL', false, TIMESTAMP('2023-07-16', '11:08:45')),
(4, 'emma.wilson@example.com', 'emma_pass', 'Emma', 'Wilson', '+94123456792', 'House 8, Blue Street', 'Negombo', 'Western Province', 'Sri Lanka', '11500', 'USER', 'NULL', false, TIMESTAMP('2023-08-01', '13:12:50')),
(5, 'mike.brown@example.com', 'mike_pass', 'Mike', 'Brown', '+94123456793', 'Villa 3, Palm Lane', 'Jaffna', 'Northern Province', 'Sri Lanka', '40000', 'USER', 'NULL', false, TIMESTAMP('2023-08-12', '11:12:00')),
(6, 'linda.jackson@example.com', 'linda_pass', 'Linda', 'Jackson', '+94123456794', 'Block C, Sun City Apartments', 'Matara', 'Southern Province', 'Sri Lanka', '81000', 'USER', 'NULL', false, TIMESTAMP('2023-07-16', '09:13:40')),
(7, 'alex.martin@example.com', 'alex_pass', 'Alex', 'Martin', '+94123456795', 'Unit 6, Hillside Residency', 'Anuradhapura', 'North Central Province', 'Sri Lanka', '50000', 'USER', 'NULL', false, TIMESTAMP('2023-08-14', '18:10:50')),
(8, 'susan.white@example.com', 'susan_pass', 'Susan', 'White', '+94123456796', 'Lane 23, Meadow View', 'Batticaloa', 'Eastern Province', 'Sri Lanka', '30000', 'USER', 'NULL', false, TIMESTAMP('2023-12-28', '14:10:20')),
(9, 'kevin.hill@example.com', 'kevin_pass', 'Kevin', 'Hill', '+94123456797', 'Flat 4B, Skyline Tower', 'Trincomalee', 'Eastern Province', 'Sri Lanka', '31000', 'USER', 'NULL', false, TIMESTAMP('2023-07-06', '13:11:24')),
(10, 'natalie.adams@example.com', 'natalie_pass', 'Natalie', 'Adams', '+94123456798', 'No 17, Golden Lane', 'Galle', 'Southern Province', 'Sri Lanka', '80000', 'USER', 'NULL', false, TIMESTAMP('2023-09-01', '12:14:54')),
(11, 'isira@greensupermarket.io', 'AdminPass123', 'Isira', 'Adithya', '+94123456798', 'No 17, Golden Lane', 'Colombo', 'Western Province', 'Sri Lanka', '42369', 'ADMIN', 'NULL', true, TIMESTAMP('2023-06-15', '11:24:51')),
(12, 'lilla63@wireconnected.com', '$2a$10$ncecBp9mdwHy1h85qGX.u.SlrJ8E.qZzzs/eGNViFQ82E5/lUqAYC', 'Lilla', 'Louseee', '+9474032566', 'No 74, Sundara Mawatha123', 'Colombo', 'Western Province', 'Sri Lanka', '42669', 'USER', 'NULL', true, TIMESTAMP('2023-07-15', '09:12:55'));

INSERT INTO Products (productid, name, price, quantity, short_description, description, visibility, image, createdAt) VALUES
(1, 'Extra Virgin Olive Oil', 9.99, 16, 'Essential, pure, adds rich flavor to dishes', '', true, '', TIMESTAMP('2023-06-15', '11:10:58')),
(2, 'Exotic Mangoes', 2.9, 55, 'Transport yourself with the tropical allure of Exotic Mangoes', '', true, '',TIMESTAMP('2023-06-16', '12:05:30')),
(3, 'Organic Baby Spinach', 79.99, 93, 'Nourish your body with nutrient-packed Organic Baby Spinach leaves', '', true, '',TIMESTAMP('2023-06-16', '13:06:09')),
(4, 'Exotic Dragon Fruit', 3.99, 30, 'Experience the extraordinary flavors of Exotic Dragon Fruit today', '', true, '',TIMESTAMP('2023-06-17', '08:10:11')),
(5, 'Organic Tomatoes', 1.79, 15, 'Enjoy the freshness and richness of locally sourced Organic Tomatoes', '', true, '',TIMESTAMP('2023-06-17', '14:10:30')),
(6, 'Organic Bell Pepper', 2.39, 25, 'Add vibrancy and taste to your dishes with Organic Bell Pepper', '', true, '',TIMESTAMP('2023-06-19', '15:02:24')),
(7, 'Organic Beet', 2.29, 50, 'Discover the earthy sweetness and health benefits of Organic Beet', '', true, '',TIMESTAMP('2023-06-21', '13:38:19')),
(8, 'Green Beans', 4.99, 154, 'Crisp, tender Green Beans, a staple for every healthy plate', '', true, '',TIMESTAMP('2023-06-21', '11:07:27')),
(9, 'Organic Carrots', 1.99, 43, 'Snack on the satisfying crunch of Organic Carrots', '', true, '',TIMESTAMP('2023-06-22', '12:05:12')),
(10, 'Organic Red Grapes', 3.29, 34, 'Elevate your palate with the succulent sweetness of Organic Red Grapes', '', true, '',TIMESTAMP('2023-06-14', '19:25:52'));


INSERT INTO Orders (orderid, userid, createdAt, amount, additionalCharges, status, delivery_status, payment_status) VALUES
(1, 1, '2023-12-12 06:45:55', 1249.98, 23.99, 'CANCELLED', 'N/A', 'COMPLETED'),
(2, 1, '2023-07-15 07:41:44', 1679.97, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(3, 3, '2023-07-16 05:50:15', 359.98, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(4, 4, '2023-08-01 07:48:40', 799.95, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(5, 5, '2023-08-12 05:49:30', 299.99, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(6, 6, '2023-07-16 03:50:43', 899.97, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(7, 7, '2023-08-14 12:49:12', 459.96, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(8, 8, '2023-12-28 09:41:21', 129.98, 23.99, 'COMPLETED', 'PENDING', 'COMPLETED'),
(9, 9, '2023-07-06 07:49:23', 679.94, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(10, 10, '2023-09-01 06:53:45', 239.97, 23.99, 'COMPLETED', 'COMPLETED', 'COMPLETED'),
(11, 11, '2023-12-28 23:26:52', 2739.91, 23.99, 'COMPLETED', 'PENDING', 'COMPLETED'),
(12, 11, '2023-12-28 23:55:38', 5799.71, 23.99, 'COMPLETED', 'PENDING', 'COMPLETED');

INSERT INTO OrderDetails (orderdetailid, orderid, productid, quantity, productname, subtotal) VALUES
(1, 1, 1, 2, 'Extra Virgin Olive Oil', 1999.98),
(2, 1, 2, 1, 'Exotic Mangoes', 599.99),
(3, 3, 3, 3, 'Organic Baby Spinach', 239.97),
(4, 2, 4, 1, 'Exotic Dragon Fruit', 399.99),
(5, 5, 5, 1, 'Organic Tomatoes', 1499.99),
(6, 6, 6, 2, 'Organic Bell Pepper', 599.98),
(7, 1, 7, 4, 'Organic Beet', 799.96),
(8, 1, 8, 1, 'Organic Beans', 49.99),
(9, 2, 9, 3, 'Organic Carrots', 1499.97),
(10, 2, 10, 2, 'Organic Red Grapes', 159.98);

INSERT INTO Comments (commentid, userid, productid, content, starcount, createdAt) VALUES
    (1, 2, 1, 'Outstanding product quality! The attention to detail and craftsmanship are truly impressive.', 4, TIMESTAMP('2023-07-17', '12:13:41')),
    (2, 3, 1, 'Highly recommend this store! The user interface is intuitive, making the shopping experience enjoyable.', 5,  TIMESTAMP('2023-07-17', '11:23:42')),
    (3, 5, 5, 'Exceptional value for money. Comparable products on other sites are much more expensive', 3, TIMESTAMP('2023-08-15', '12:23:45')),
    (4, 6, 4, 'The customer support team is fantastic. They promptly addressed my queries and provided helpful assistance.', 4, TIMESTAMP('2023-07-19', '12:30:52')),
    (5, 7, 3, 'I love the design of this product. It''s not only functional but also aesthetically pleasing.', 2, TIMESTAMP('2023-08-15', '14:29:42')),
    (6, 1, 1, 'Fast and reliable shipping. Received my order sooner than expected. Great service!', 3, TIMESTAMP('2023-07-13', '10:25:22'))


