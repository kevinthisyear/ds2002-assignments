-- world
-- 1
SELECT Name FROM country WHERE Continent = 'South America';

-- 2
SELECT Population FROM country WHERE Name = 'Germany';

-- 3
SELECT city.Name FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'Japan';

-- 4
SELECT Name, Population FROM country WHERE Continent = 'Africa' ORDER BY Population DESC LIMIT 3;

-- 5
SELECT Name, LifeExpectancy FROM country WHERE Population BETWEEN 1000000 AND 5000000;

-- 6
SELECT Name FROM country
JOIN countrylanguage ON country.code = countrylanguage.CountryCode
WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T";

-- chinook
-- 7
SELECT Album.Title FROM Album 
JOIN Artist ON Album.ArtistId = Artist.ArtistId 
WHERE Artist.Name = 'AC/DC';

-- 8
SELECT FirstName, LastName, Email FROM Customer WHERE Country = 'Brazil';

-- 9
SELECT Name FROM Playlist;

-- 10
SELECT COUNT(*) AS TotalRockTracks FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId 
WHERE Genre.Name = 'Rock';


-- 11
SELECT Employee.FirstName, Employee.LastName FROM Employee
JOIN Employee AS Manager ON Employee.ReportsTo = Manager.EmployeeId
WHERE Manager.FirstName = 'Nancy' AND Manager.LastName = 'Edwards';

-- 12
SELECT CustomerId, SUM(Total) AS TotalSales 
FROM Invoice 
GROUP BY CustomerId;

-- Part 2 - this is a small chinese restaurant

-- customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

-- menu table
CREATE TABLE Menu (
    MenuItemID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);

-- orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- order details table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    MenuItemID INT,
    Quantity INT,
    SubTotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (MenuItemID) REFERENCES Menu(MenuItemID)
);

-- customer data
INSERT INTO Customers (CustomerID, FirstName, LastName, Phone, Email)
VALUES
(1, 'Albert', 'Huang', '123-456-7890', 'ablerthuang@gmail.com'),
(2, 'Rex', 'Wang', '098-765-4321', 'rexwang@gmail.com'),
(3, 'Kenny', 'Tran', '555-666-7777', 'kennytran@gmail.com'),
(4, 'Kyle', 'Chau', '444-555-6666', 'kylechau@gmail.com'),
(5, 'Tristan', 'Huyen', '111-222-3333', 'tristanhuyen@gmail.com');

-- menu data
INSERT INTO Menu (MenuItemID, ItemName, Description, Price)
VALUES
(1, 'Kung Pao Chicken', 'Spicy chicken stir-fry with peanuts', 12.99),
(2, 'Sweet and Sour Pork', 'Pork in sweet and sour sauce with vegetables', 10.99),
(3, 'Fried Rice', 'Rice stir-fried with vegetables and egg', 8.50),
(4, 'Spring Rolls', 'Crispy rolls filled with vegetables', 5.00),
(5, 'Wonton Soup', 'Soup with wonton dumplings', 6.50);

-- order data
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(1, 1, '2024-09-01', 25.49),
(2, 2, '2024-09-02', 18.99),
(3, 3, '2024-09-03', 12.50),
(4, 4, '2024-09-04', 20.99),
(5, 5, '2024-09-05', 16.50),
(6, 1, '2024-09-06', 19.99),
(7, 2, '2024-09-06', 15.50),
(8, 3, '2024-09-07', 22.99),
(9, 4, '2024-09-07', 18.99),
(10, 5, '2024-09-08', 27.49);

-- order details data
INSERT INTO OrderDetails (OrderDetailID, OrderID, MenuItemID, Quantity, SubTotal)
VALUES
(1, 1, 1, 1, 12.99),
(2, 1, 3, 1, 8.50),
(3, 2, 2, 1, 10.99),
(4, 2, 4, 2, 10.00),
(5, 3, 5, 2, 12.50),
(6, 4, 1, 1, 12.99),
(7, 4, 4, 2, 10.00),
(8, 5, 3, 2, 16.50),
(9, 6, 1, 1, 12.99),
(10, 6, 4, 1, 5.00),
(11, 7, 3, 2, 16.50),
(12, 8, 2, 1, 10.99),
(13, 8, 5, 2, 12.00),
(14, 9, 1, 1, 12.99),
(15, 9, 4, 2, 10.00),
(16, 10, 2, 1, 10.99),
(17, 10, 5, 3, 19.50);

-- get all menu items and their prices
SELECT ItemName, Price FROM Menu;

--  get the total amount spent by each customer
SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID;

--  get the total number of orders placed
SELECT COUNT(*) AS TotalOrders
FROM Orders;
