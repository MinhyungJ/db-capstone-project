
## Virtual Table -- Orders
CREATE VIEW OrdersView AS SELECT OrderID, Quantity, Cost FROM Orders;
SELECT * FROM OrdersView;

## Statements -- JOINS
SELECT C.CustomerID, C.Customer_name, M.Course_Name, o.Cost, o.OrderID  FROM Customer AS C
LEFT JOIN Orders AS O ON O.CustomerID = C.CustomerID
LEFT JOIN MenuItems AS M ON M.MenuItemsID = O.MenuItemsID;

## Subquery -- ANY
SELECT OrderID FROM Orders
WHERE Quantity >= ANY (SELECT Quantity FROM Orders WHERE Quantity = 1);

## Procedure -- Max Quantity
DELIMITER //
CREATE PROCEDURE GetMaxQuantity_1()
BEGIN
SELECT MAX(Quantity) FROM Orders;
END //
DELIMITER ;

CALL GetMaxQuantity_1();

## Procedure -- Order Detail
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, Cost FROM Orders WHERE CustomerID = ?';
SET @id =3;
EXECUTE GetOrderDetail USING @id;


## Procedure -- Cancel Order
DELIMITER //
CREATE PROCEDURE CancelOrder (id INT)
	BEGIN
		DECLARE message VARCHAR(255);
        DELETE FROM Orders WHERE OrderID = id;
        SET message = CONCAT("Order", id, "is cancelled");
	SELECT message;
END//
DELIMITER ;
CALL CancelOrder (2);
