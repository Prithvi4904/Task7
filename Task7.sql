-- Drop existing tables and views if needed
DROP VIEW IF EXISTS CustomerOrderSummary;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- Create base tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample data
INSERT INTO Customers VALUES
(1, 'Alice', 'Boston'),
(2, 'Bob', 'New York'),
(3, 'Charlie', 'Chicago');

INSERT INTO Orders VALUES
(101, 1, '2024-01-10', 250.00),
(102, 1, '2024-02-15', 300.00),
(103, 2, '2024-03-05', 150.00);

-- 1️⃣ Create a view summarizing customer orders
CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.CustomerID,
    c.Name,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Amount) AS TotalAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;

-- 2️⃣ Use the view: List customers who spent over $400
SELECT * FROM CustomerOrderSummary
WHERE TotalAmount > 400;

-- 3️⃣ Use the view: Show total orders for each customer
SELECT Name, TotalOrders FROM CustomerOrderSummary;
