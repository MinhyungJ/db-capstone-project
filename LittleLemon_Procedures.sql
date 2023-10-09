## Procedure -- Max Quantity
DROP PROCEDURE IF EXISTS GetMaxQuantity;
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(Quantity) FROM Orders;
END //
DELIMITER ;
CALL GetMaxQuantity();


## Prepared Statement -- Order Detail
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, Cost FROM Orders WHERE CustomerID = ?';
SET @id =3;
EXECUTE GetOrderDetail USING @id;


## Procedure -- Cancel Order
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder (id INT)
	BEGIN
		DECLARE Confirmation VARCHAR(255);
        DELETE FROM Orders WHERE OrderID = id;
        SET Confirmation = CONCAT("Order", id, "is cancelled");
	SELECT Confirmation;
END//
DELIMITER ;
CALL CancelOrder (2);


## Procedure -- Booking check
DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking (IN booking_date DATE, IN table_num INT)
	BEGIN
    DECLARE booking_count INT;
    DECLARE booking_status VARCHAR(255);
    SELECT COUNT(*) INTO booking_count FROM Bookings
    WHERE Table_number = table_num AND Booking_Date = booking_date;
    
    IF booking_count > 0 THEN
		SET booking_status = CONCAT('Table', " "table_num, '  is already assigned.');
        SELECT booking_status;
	END IF;
END//
DELIMITER ;
Call CheckBooking ("2023-11-11", 5);

## Procedure -- Add valid bookings
DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking (IN booking_id INT, IN customer_id INT, IN booking_date DATE, IN table_num INT)
	BEGIN
    DECLARE Booking_status  VARCHAR(255);
    DECLARE booking_count INT;
    
    START TRANSACTION;
    SELECT COUNT(*) INTO booking_count FROM Bookings
    WHERE Booking_Date = booking_date AND Table_number = table_num;
    IF booking_count = 0 THEN
		INSERT INTO Bookings (BookingsID, CustomerID, Booking_Date, Table_number)
        VALUES (booking_id, customer_id, booking_date, table_num);
        SET Booking_status = CONCAT('New booking added');
        SELECT Booking_status;
        COMMIT;
	ELSE 
		ROLLBACK;
        SET Booking_status = CONCAT('Booking already exists');
        SELECT Booking_status;
	END IF;
END//
DELIMITER ;

CALL AddValidBooking(5, 1, "2021-11-12", 4);
SELECT * FROM Bookings;

## Procedure -- Update booking
DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking (IN booking_id INT, IN booking_date DATE)
BEGIN
	DECLARE Confirmation VARCHAR(255);
    UPDATE Bookings
    SET Booking_Date = booking_date
    WHERE BookingsID = booking_id;
    
    SET Confirmation = CONCAT("Booking", booking_id, "  updated.");
    SELECT Confirmation;
END//
DELIMITER ;
CALL UpdateBOoking(1, "2021-01-11");


## Procedure -- Cancel booking
DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking (IN booking_id INT)
BEGIN
	DECLARE Confirmation VARCHAR(255);
    DELETE FROM Bookings
    WHERE BookingsID = booking_id;
    
    SET Confirmation = CONCAT("Booking", booking_id, "  cancelled.");
    SELECT Confirmation;
END//
DELIMITER ;
CALL CancelBooking(2);