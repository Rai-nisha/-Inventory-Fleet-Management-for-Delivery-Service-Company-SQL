/* List all completed deliveries, including the total number of items delivered.  */
SELECT d.delivery_id, COUNT(di.item_id) AS total_items FROM Deliveries d
JOIN Delivery_Items di ON d.delivery_id = di.delivery_id
WHERE d.status = 'completed'
GROUP BY d.delivery_id;

/* Get a report showing the current stock levels in each warehouse */
SELECT w.location, i.item_name, i.stock_quantity FROM Warehouses w
JOIN Inventory i ON w.warehouse_id = i.warehouse_id;

/* Generate a report of all drivers and the number of deliveries they've completed.  */
SELECT d.driver_id, d.name, COUNT(dl.delivery_id) AS completed_deliveries
FROM Drivers d
LEFT JOIN Deliveries dl ON d.driver_id = dl.driver_id AND dl.status = 'completed'
GROUP BY d.driver_id, d.name
ORDER BY d.driver_id;

/* Show all deliveries that were in progress or completed within a given time range.  */
SELECT * FROM Deliveries 
WHERE delivery_date BETWEEN '2024-10-01' AND '2024-10-31' 
AND (status = 'in-progress' OR status = 'completed');

/* Identify any deliveries where the total item quantity exceeds the vehicle's capacity 
(requires a JOIN between Deliveries, Vehicles, and Delivery_Items). */
SELECT d.delivery_id FROM Deliveries d
JOIN Delivery_Items di ON d.delivery_id = di.delivery_id
JOIN Vehicles v ON d.vehicle_id = v.vehicle_id
GROUP BY d.delivery_id, v.capacity
HAVING SUM(di.quantity) > v.capacity;


