USE littlelemondb;

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN ID INT, IN inputDate DATE, IN inputTableNo INT, IN StaffID INT)
BEGIN
    DECLARE bookingCount INT;

    START TRANSACTION;

    -- Check if the table is already booked
    SELECT COUNT(*) INTO bookingCount
    FROM `littlelemondb`.`Booking`
    WHERE BookingDate = inputDate
      AND TableNo = inputTableNo;

    IF bookingCount > 0 THEN
        -- Table already booked → rollback
        ROLLBACK;
        SELECT CONCAT('Booking declined: Table ', inputTableNo, ' on ', inputDate, ' is already reserved.') AS StatusMessage;
    ELSE
        -- Table free → insert and commit
        INSERT INTO `littlelemondb`.`Booking` (BookingID,BookingDate, TableNo, StaffID)
        VALUES (ID, inputDate, inputTableNo, StaffID);

        COMMIT;
        SELECT CONCAT('Booking confirmed: Table ', inputTableNo, ' on ', inputDate, ' reserved for ', inputCustomerName) AS StatusMessage;
    END IF;
END //

DELIMITER ;

CALL AddValidBooking(5,'2022-11-12', 3, 3);

