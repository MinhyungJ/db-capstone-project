use littlelemondb;
## Virtual Table 1 -- Orders
CREATE VIEW OrdersView AS SELECT OrderID, Quantity, Cost FROM Orders;
SELECT * FROM OrdersView;

## Virtual Table 2 -- JOINS
CREATE VIEW OrderSummary AS SELECT C.CustomerID, C.Customer_name, M.Course_Name, o.Cost, o.OrderID  FROM Customer AS C
LEFT JOIN Orders AS O ON O.CustomerID = C.CustomerID
LEFT JOIN MenuItems AS M ON M.MenuItemsID = O.MenuItemsID;

## Subquery -- ANY
SELECT OrderID FROM Orders
WHERE Quantity >= ANY (SELECT Quantity FROM Orders WHERE Quantity = 1);

## Insert records to the Bookings Table: Practice
SELECT * FROM Bookings;
INSERT INTO Bookings (BookingsID, CustomerID, Table_number, Booking_Date)
VALUES 
(2, 1, 5, "2023-11-11"),
(3, 3, 3, "2023-07-11"),
(4, 2, 4, "2023-09-11"),
(5, 1, 1, "2023-10-11"); 
