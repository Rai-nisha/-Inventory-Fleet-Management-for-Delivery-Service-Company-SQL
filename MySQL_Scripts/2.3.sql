/* This procedure checks if the vehicle is available. 
If it is, the delivery is assigned to the driver and vehicle, and the vehicle status is updated. 
If not, an error message is returned. */

DELIMITER $$

CREATE PROCEDURE AssignDelivery (
    IN p_delivery_id INT,
    IN p_vehicle_id INT,
    IN p_driver_id INT,
    OUT p_status VARCHAR(50)
)
BEGIN
    DECLARE v_status ENUM('available', 'in-service');

    SELECT status INTO v_status FROM Vehicles WHERE vehicle_id = p_vehicle_id;

    IF v_status = 'available' THEN
        
        UPDATE Deliveries
        SET vehicle_id = p_vehicle_id,
            driver_id = p_driver_id,
            status = 'in-progress'
        WHERE delivery_id = p_delivery_id;

        UPDATE Vehicles
        SET status = 'in-service'
        WHERE vehicle_id = p_vehicle_id;

        SET p_status = 'Success: Delivery assigned.';
    ELSE
        SET p_status = 'Failure: Vehicle is not available.';
    END IF;
END$$

DELIMITER ;


CALL AssignDelivery(411, 101, 3, @result);
SELECT @result;

