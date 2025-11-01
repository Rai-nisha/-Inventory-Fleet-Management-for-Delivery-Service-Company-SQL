/* Basic Data Manipulation */

/*Update stock quantities as items are assigned for delivery. 
For each delivery, reduce the stock in the warehouse for the respective items being delivered */
UPDATE Inventory
SET stock_quantity = stock_quantity - 5
WHERE item_id = 314 AND warehouse_id = 3021;

/*Update Vehicle Status: After assigning a delivery, update the vehicle status to "in-service" */
UPDATE Vehicles
SET status = 'in-service'
WHERE vehicle_id = 101;


/* Once the delivery is complete, setting the vehicle status back to "available": */
UPDATE Vehicles
SET status = 'available'
WHERE vehicle_id = 101;

/* List of vehicles currently in service. */
SELECT * FROM Vehicles 
WHERE status = 'in-service';

/* Get all items that are low in stock (stock quantity < 10) */
SELECT * FROM inventory
WHERE stock_quantity < 10;

/* Get all items that are low in stock (stock quantity < 60).  */
SELECT * FROM inventory
WHERE stock_quantity < 60;

/* List all pending deliveries for a specific day. */
SELECT * FROM deliveries
WHERE delivery_date = '2024-10-16' AND status = 'pending';

/* Add foreign key constraints to the Deliveries and Delivery_Items tables 
to ensure proper relationships between tables. */
ALTER TABLE Deliveries
ADD CONSTRAINT fk_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
ADD CONSTRAINT fk_driver FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id),
ADD CONSTRAINT fk_warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id);
desc Deliveries;

ALTER TABLE Delivery_Items
ADD CONSTRAINT fk_delivery FOREIGN KEY (delivery_id) REFERENCES Deliveries(delivery_id),
ADD CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES Inventory(item_id);
desc Delivery_items;







