-- Begin the transaction
START TRANSACTION;

-- Step 1: Check if there is sufficient stock for each item in the delivery
-- This query will fail if any stock quantity is insufficient, causing the transaction to roll back

UPDATE Inventory i
JOIN Delivery_Items di ON i.item_id = di.item_id
JOIN Deliveries d ON d.delivery_id = di.delivery_id
SET i.stock_quantity = i.stock_quantity - di.quantity
WHERE d.delivery_id = 412 -- specify the delivery_id
AND i.stock_quantity >= di.quantity;

-- Step 2: Update delivery status to 'in-progress'
-- If the above query doesn't fail, update the delivery status

UPDATE Deliveries
SET status = 'in-progress'
WHERE delivery_id = 412;

-- Step 3: Commit the transaction if everything is successful
COMMIT;

/* If any part fails, the stock update will be rolled back automatically, 
and the delivery status won't be updated. */

