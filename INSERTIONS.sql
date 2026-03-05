USE restaurantdb;

DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN p_BookingID INT,
    IN p_BookingDate DATE
)
BEGIN
    UPDATE booking
    SET BookingDate = p_BookingDate
    WHERE BookingID = p_BookingID;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN p_BookingID INT
)
BEGIN
    DELETE FROM booking
    WHERE BookingID = p_BookingID;
END //

DELIMITER ;
