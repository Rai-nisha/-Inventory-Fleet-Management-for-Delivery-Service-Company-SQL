CREATE DATABASE Inventory_and_fleet;
USE Inventory_and_fleet;

CREATE TABLE Vehicles(
vehicle_id INT PRIMARY KEY,
vehicle_type VARCHAR(50),
capacity INT,
license_plate VARCHAR(20) UNIQUE,
status ENUM('available','in-service') DEFAULT 'available'
);
desc Vehicles;

CREATE TABLE Drivers (
driver_id INT PRIMARY KEY,
name VARCHAR(90),
license_number VARCHAR(50),
assigned_vehicle_id INT,
FOREIGN KEY (assigned_vehicle_id) REFERENCES Vehicles(vehicle_id)
);
desc Drivers;

CREATE TABLE Warehouses(
warehouse_id INT PRIMARY KEY,
location VARCHAR(100),
capacity INT
);
desc Warehouses;

CREATE TABLE Inventory(
item_id INT PRIMARY KEY AUTO_INCREMENT,
item_name VARCHAR(100),
stock_quantity INT,
warehouse_id INT,
FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);
desc Inventory;

CREATE TABLE Deliveries(
delivery_id INT PRIMARY KEY,
vehicle_id INT,
driver_id INT,
warehouse_id INT,
delivery_date DATE,
status ENUM('pending', 'in-progress', 'completed') DEFAULT 'pending'
);
desc Deliveries;

CREATE TABLE Delivery_Items(
delivery_id INT,
item_id INT,
quantity INT
);
desc Delivery_Items;


INSERT INTO Vehicles (vehicle_id, vehicle_type, capacity, license_plate, status) VALUES
(101,'Truck', 50, 'ABC123', 'available'),
(102,'Van', 20, 'DEF456', 'available'),
(103,'Motorcycle', 1, 'GHI789', 'available'),
(104,'Van', 15, 'MNO345', 'available'),
(105,'Truck', 20, 'JKL012', 'available');


INSERT INTO Drivers (driver_id, name, license_number, assigned_vehicle_id) VALUES
(1,'John Doe', 'LIC123456', 101),
(2,'Jane Smith', 'LIC789101', 102),
(3,'Tom Brown', 'LIC112131', 103),
(4,'Lucy Green', 'LIC415161', 104),
(5,'Emma White', 'LIC718192', 105);

INSERT INTO Warehouses (warehouse_id, location, capacity) VALUES
(3021,'Mumbai', 5000),
(3022,'Delhi', 4000),
(3023,'Hyderabad', 3500);

INSERT INTO Inventory (item_id,item_name, stock_quantity, warehouse_id) VALUES
(311,'Laptop', 50, 3022),
(312,'Phone', 100, 3023),
(313,'Tablet', 50, 3023),
(314,'Headphones', 100, 3021),
(315,'Monitor', 70, 3021),
(316,'Keyboard', 100, 3023),
(317,'Mouse', 100, 3022),
(318,'Charger', 100, 3022),
(319,'Webcam', 150, 3023),
(320,'Speakers', 90, 3021);



INSERT INTO Deliveries (delivery_id, vehicle_id, driver_id, warehouse_id, delivery_date, status) VALUES
(411, 101, 1, 3021, '2024-10-14', 'in-progress'),
(412, 102, 2, 3023, '2024-10-15', 'in-progress'),
(413, 103, 3, 3023, '2024-10-16', 'pending'),
(414, 104, 4, 3021, '2024-10-17', 'in-progress'),
(415, 105, 5, 3022, '2024-10-18', 'pending');


INSERT INTO Delivery_Items (delivery_id, item_id, quantity) VALUES
(411, 312, 12),
(411, 315, 20),
(411, 316, 15),
(412, 311, 9),
(412, 312, 12),
(412, 313, 7),
(413, 317, 10),
(413, 318, 15),
(413, 319, 12),
(414, 314, 5),
(414, 320, 7),
(414, 312, 15),
(415, 313, 6),
(415, 311, 19),
(415, 312, 19);


