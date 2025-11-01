/* Index on delivery date for filtering by date ranges */
CREATE INDEX idx_delivery_date ON Deliveries(delivery_date);

EXPLAIN SELECT * FROM Deliveries 
WHERE delivery_date = '2024-10-15' AND status = 'completed';

/* Indexes for joins between Deliveries and Delivery_Items. */
CREATE INDEX idx_delivery_id ON Delivery_Items(delivery_id);
CREATE INDEX idx_vehicle_id ON Deliveries(vehicle_id);

EXPLAIN SELECT d.delivery_id, COUNT(di.item_id) AS total_items FROM Deliveries d
JOIN Delivery_Items di ON d.delivery_id = di.delivery_id
WHERE d.status = 'completed'
GROUP BY d.delivery_id;










