-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `StaffID` INT NOT NULL,
  `StaffName` VARCHAR(45) NULL,
  `StaffAddress` VARCHAR(45) NULL,
  `StaffRole` VARCHAR(45) NULL,
  `StaffSalary` DECIMAL NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE INDEX `StaffID_UNIQUE` (`StaffID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BOOKING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BOOKING` (
  `BookingID` INT NOT NULL,
  `BookingDate` DATE NULL,
  `TableNo` INT NULL,
  `Staff_StaffID` INT NOT NULL,
  UNIQUE INDEX `BookingID_UNIQUE` (`BookingID` ASC) VISIBLE,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_BOOKING_Staff1_idx` (`Staff_StaffID` ASC) VISIBLE,
  CONSTRAINT `fk_BOOKING_Staff1`
    FOREIGN KEY (`Staff_StaffID`)
    REFERENCES `mydb`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderDeliveryStatus` (
  `DeliveryID` INT NULL,
  `DeliveryDate` DATE NULL,
  `Status` BIT NULL,
  PRIMARY KEY (`DeliveryID`),
  UNIQUE INDEX `DeliveryID_UNIQUE` (`DeliveryID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NULL,
  `Quantity` INT NULL,
  `TotalCost` DECIMAL NULL,
  `Staff_StaffID` INT NOT NULL,
  `OrderDeliveryStatus_DeliveryID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Staff1_idx` (`Staff_StaffID` ASC) VISIBLE,
  INDEX `fk_Orders_OrderDeliveryStatus1_idx` (`OrderDeliveryStatus_DeliveryID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Staff1`
    FOREIGN KEY (`Staff_StaffID`)
    REFERENCES `mydb`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_OrderDeliveryStatus1`
    FOREIGN KEY (`OrderDeliveryStatus_DeliveryID`)
    REFERENCES `mydb`.`OrderDeliveryStatus` (`DeliveryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `MenuID` INT NOT NULL,
  `Cuisines` VARCHAR(45) NULL,
  `Starters` VARCHAR(45) NULL,
  `Courses` VARCHAR(45) NULL,
  `Drinks` VARCHAR(45) NULL,
  `Desert` VARCHAR(45) NULL,
  `Orders_OrderID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  UNIQUE INDEX `MenuID_UNIQUE` (`MenuID` ASC) VISIBLE,
  INDEX `fk_Menu_Orders1_idx` (`Orders_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Orders1`
    FOREIGN KEY (`Orders_OrderID`)
    REFERENCES `mydb`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(45) NULL,
  `CustomerAddress` VARCHAR(45) NULL,
  `CustomerContact` VARCHAR(45) NULL,
  `Orders_OrderID` INT NOT NULL,
  `BOOKING_BookingID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerContact_UNIQUE` (`CustomerContact` ASC) VISIBLE,
  INDEX `fk_Customers_Orders_idx` (`Orders_OrderID` ASC) VISIBLE,
  INDEX `fk_Customers_BOOKING1_idx` (`BOOKING_BookingID` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_Orders`
    FOREIGN KEY (`Orders_OrderID`)
    REFERENCES `mydb`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_BOOKING1`
    FOREIGN KEY (`BOOKING_BookingID`)
    REFERENCES `mydb`.`BOOKING` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
