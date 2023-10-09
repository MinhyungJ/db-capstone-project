-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LittleLemonDB` ;

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Menus` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` INT NOT NULL,
  `Cuisine` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`MenuItems` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemsID` INT NOT NULL,
  `Course_Name` VARCHAR(45) NULL,
  `Starter_Name` VARCHAR(45) NULL,
  `Desert_Name` VARCHAR(45) NULL,
  `Drink` VARCHAR(45) NULL,
  `Sides` VARCHAR(45) NULL,
  `MenuID` INT NULL,
  PRIMARY KEY (`MenuItemsID`),
  INDEX `fk_MenuItems_Menus1_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `fk_MenuItems_Menus1`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Customer` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `CustomerID` INT NOT NULL,
  `Customer_name` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `County` VARCHAR(45) NULL,
  `Postal_Code` VARCHAR(45) NULL,
  `Country_Code` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `MenuItemsID` INT NOT NULL,
  `Order_date` DATE NULL,
  `Quantity` INT NULL,
  `Cost` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_MenuItems1_idx` (`MenuItemsID` ASC) VISIBLE,
  INDEX `fk_Orders_Customer1_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_MenuItems1`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Employees` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT NOT NULL,
  `Employee_Name` VARCHAR(45) NULL,
  `Role` VARCHAR(45) NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order_delivery_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Order_delivery_status` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order_delivery_status` (
  `OrderID` INT NOT NULL,
  `Delivery_Date` DATE NULL,
  `Delivery_Status` VARCHAR(45) NULL,
  `Delivery_Cost` INT NULL,
  `EmployeeID` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Order_delivery_status_Orders1_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_Order_delivery_status_Employees1_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_delivery_status_Orders1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_delivery_status_Employees1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingsID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL,
  `Table_number` INT NULL,
  `Booking_Date` DATE NULL,
  PRIMARY KEY (`BookingsID`),
  INDEX `fk_Bookings_Customer1_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `Cuisine`) VALUES (1, 'Greek');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `Cuisine`) VALUES (2, 'Italian');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `Cuisine`) VALUES (3, 'Turkish');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemsID`, `Course_Name`, `Starter_Name`, `Desert_Name`, `Drink`, `Sides`, `MenuID`) VALUES (1, 'Greek salad', 'Olives', 'Greek yogurt', 'Athens White wine', 'Tapas', 1);
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemsID`, `Course_Name`, `Starter_Name`, `Desert_Name`, `Drink`, `Sides`, `MenuID`) VALUES (2, 'Pizza', 'Minestrone', 'Cheesecake', 'Italian Coffee', 'Bruschetta', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Customer` (`CustomerID`, `Customer_name`, `City`, `County`, `Postal_Code`, `Country_Code`) VALUES (1, 'Jim Beam', 'Tallahassee', 'leon', '32333', 'US');
INSERT INTO `LittleLemonDB`.`Customer` (`CustomerID`, `Customer_name`, `City`, `County`, `Postal_Code`, `Country_Code`) VALUES (2, 'Minsung Kim', 'Seoul', 'Gangnam', '08182', 'KR');
INSERT INTO `LittleLemonDB`.`Customer` (`CustomerID`, `Customer_name`, `City`, `County`, `Postal_Code`, `Country_Code`) VALUES (3, 'Misaki Ogura', 'Tokyo', 'Kimi', '56456', 'JP');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `CustomerID`, `MenuItemsID`, `Order_date`, `Quantity`, `Cost`) VALUES (1, 1, 1, '2023-10-08', 1, 50);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `CustomerID`, `MenuItemsID`, `Order_date`, `Quantity`, `Cost`) VALUES (2, 3, 2, '2023-10-07', 5, 40);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Employee_Name`, `Role`, `Salary`) VALUES (1, 'Minhyung Jo', 'Manager', 100000);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Employee_Name`, `Role`, `Salary`) VALUES (2, 'Ring Xie', 'Advisor', 60000);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Employee_Name`, `Role`, `Salary`) VALUES (3, 'Michael King', 'Staff', 50000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Order_delivery_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Order_delivery_status` (`OrderID`, `Delivery_Date`, `Delivery_Status`, `Delivery_Cost`, `EmployeeID`) VALUES (1, '2023-10-07', 'Pending', 15, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingsID`, `CustomerID`, `Table_number`, `Booking_Date`) VALUES (1, 1, 1, '2023-10-02');

COMMIT;

