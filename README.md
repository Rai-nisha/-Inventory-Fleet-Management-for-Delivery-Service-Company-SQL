
# 🚚 Inventory & Fleet Management System (MySQL Project)

## 📘 Overview
This project focuses on designing and implementing a **MySQL database** for a **Delivery Service Company’s Inventory & Fleet Management System**.  
It manages the company’s **vehicles, drivers, warehouses, inventory, and deliveries**, and provides **reports and performance insights** through structured queries and optimizations.

---

## 🧩 Objectives
- Build a normalized database schema to manage fleet and inventory operations.  
- Perform **basic operations** such as data insertion, updates, and retrieval.  
- Develop **advanced SQL queries**, **transactions**, and **stored procedures**.  
- Apply **performance optimization** techniques for efficient data handling.

---

## 🗂️ Database Schema Design

### **Tables and Relationships**
| Table | Description |
|--------|--------------|
| **Vehicles** | Stores vehicle details (type, capacity, status). |
| **Drivers** | Maintains driver info and their assigned vehicles. |
| **Warehouses** | Tracks warehouse locations and capacities. |
| **Inventory** | Lists stock items per warehouse. |
| **Deliveries** | Records delivery assignments and statuses. |
| **Delivery_Items** | Links items with deliveries and quantities. |

### **Schema Diagram**
```
Vehicles (vehicle_id) 1 --- * Drivers (assigned_vehicle_id)
Vehicles (vehicle_id) 1 --- * Deliveries (vehicle_id)
Drivers (driver_id) 1 --- * Deliveries (driver_id)
Warehouses (warehouse_id) 1 --- * Inventory (warehouse_id)
Warehouses (warehouse_id) 1 --- * Deliveries (warehouse_id)
Deliveries (delivery_id) 1 --- * Delivery_Items (delivery_id)
Inventory (item_id) 1 --- * Delivery_Items (item_id)
```

---

## ⚙️ Key SQL Components

### **1️⃣ Basic Operations**

#### Create Database:
```sql
CREATE DATABASE Inventory_and_fleet;
USE Inventory_and_fleet;
```

#### Create Tables:
Includes all constraints:
- Primary keys  
- Foreign keys  
- Unique license plates  

Example:
```sql
CREATE TABLE Vehicles(
  vehicle_id INT PRIMARY KEY,
  vehicle_type VARCHAR(50),
  capacity INT,
  license_plate VARCHAR(20) UNIQUE,
  status ENUM('available','in-service') DEFAULT 'available'
);
```

#### Update Vehicle and Inventory:
```sql
UPDATE Vehicles SET status = 'in-service' WHERE vehicle_id = 101;
UPDATE Inventory SET stock_quantity = stock_quantity - 5 WHERE item_id = 314;
```

#### Retrieve Information:
```sql
SELECT * FROM Vehicles WHERE status = 'in-service';
SELECT * FROM Inventory WHERE stock_quantity < 10;
SELECT * FROM Deliveries WHERE delivery_date = '2024-10-16' AND status = 'pending';
```

---

### **2️⃣ Advanced Queries**

#### Completed Deliveries:
```sql
SELECT d.delivery_id, COUNT(di.item_id) AS total_items
FROM Deliveries d
JOIN Delivery_Items di ON d.delivery_id = di.delivery_id
WHERE d.status = 'completed'
GROUP BY d.delivery_id;
```

#### Driver Performance:
```sql
SELECT d.driver_id, d.name, COUNT(dl.delivery_id) AS completed_deliveries
FROM Drivers d
LEFT JOIN Deliveries dl ON d.driver_id = dl.driver_id AND dl.status = 'completed'
GROUP BY d.driver_id, d.name
ORDER BY d.driver_id;
```

#### Identify Overloaded Deliveries:
```sql
SELECT d.delivery_id
FROM Deliveries d
JOIN Delivery_Items di ON d.delivery_id = di.delivery_id
JOIN Vehicles v ON d.vehicle_id = v.vehicle_id
GROUP BY d.delivery_id, v.capacity
HAVING SUM(di.quantity) > v.capacity;
```

---

### **3️⃣ Transactions and Error Handling**

```sql
START TRANSACTION;

UPDATE Inventory i
JOIN Delivery_Items di ON i.item_id = di.item_id
JOIN Deliveries d ON d.delivery_id = di.delivery_id
SET i.stock_quantity = i.stock_quantity - di.quantity
WHERE d.delivery_id = 411
AND i.stock_quantity >= di.quantity;

UPDATE Deliveries
SET status = 'in-progress'
WHERE delivery_id = 411;

COMMIT;
```

If any stock is insufficient, the transaction is **rolled back** to maintain data integrity.

---

### **4️⃣ Stored Procedure**

```sql
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
```

**Example Call:**
```sql
CALL AssignDelivery(413, 101, 3, @result);
SELECT @result;
```

---

### **5️⃣ Performance Optimization**

- **Indexes on frequently used columns:**
  ```sql
  CREATE INDEX idx_delivery_date ON Deliveries(delivery_date);
  CREATE INDEX idx_delivery_items ON Delivery_Items(delivery_id);
  CREATE INDEX idx_vehicle_id ON Deliveries(vehicle_id);
  ```

- Optimized joins and date range queries using `EXPLAIN` plans.

---

## 📊 Project Deliverables
✅ SQL scripts for table creation, data insertion, and advanced queries.  
✅ Transaction handling and stored procedure scripts.  
✅ Documentation explaining schema, relationships, and optimizations.  
✅ Report with query results and performance comparisons.

---

## 📁 Folder Structure
```
Inventory_Fleet_Management/
│
├── 1-MySQL_Problem_statement.pdf
├── 3-MySQL_Project_Report.pdf
├── SQL_Scripts/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── advanced_queries.sql
│   ├── stored_procedure.sql
│   └── optimization.sql
└── README.md
```

---

## 📸 Example Output Previews

### 🚗 Vehicle and Delivery Tables
*(Screenshots or query result images can be added here)*  
```
Deliveries Table:
| delivery_id | vehicle_id | driver_id | status     |
|--------------|-------------|------------|-------------|
| 411          | 101         | 3          | in-progress |

Vehicles Table:
| vehicle_id | status      |
|-------------|-------------|
| 101         | in-service  |
```

---

## 🧠 Key Learnings
- Implementation of **relational integrity** through foreign keys.  
- Handling **real-world delivery workflows** using transactions.  
- Improving **query performance** with indexing.  
- Writing **modular SQL procedures** for operational automation.

---

## 👩‍💻 Author
**Nisha Rai**  
Data Analytics & SQL Projects  
