CREATE DATABASE TransportManagementSystem;
USE TransportManagementSystem;
CREATE TABLE Admin (
    admin_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);
INSERT INTO Admin VALUES
(1, 'admin01', 'admin123');
SELECT * FROM Admin;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    password VARCHAR(100) NOT NULL
);
INSERT INTO Users VALUES
(101, 'Nafisa Tasfia', '01711111111', 'nafisa@gmail.com', 'Chattogram', 'pass123'),
(102, 'Rahim Uddin', '01822222222', 'rahim@gmail.com', 'Dhaka', 'pass456'),
(103, 'Nusrat Jahan', '01933333333', 'nusrat@gmail.com', 'Sylhet', 'pass789');
SELECT * FROM Users;

CREATE TABLE Drivers (
    driver_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    experience_years INT,
    availability_status VARCHAR(20)
);
INSERT INTO Drivers VALUES
(201, 'Abdul Karim', 'LIC001', '01744444444', 5, 'Available'),
(202, 'Jamal Uddin', 'LIC002', '01855555555', 8, 'Unavailable'),
(203, 'Rashid Khan', 'LIC003', '01966666666', 6, 'Available');

SELECT * FROM Drivers;
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY,
    vehicle_type VARCHAR(50) NOT NULL,
    vehicle_number VARCHAR(30) NOT NULL UNIQUE,
    capacity INT NOT NULL,
    status VARCHAR(20)
);
INSERT INTO Vehicles VALUES
(301, 'AC Bus', 'DHA-1234', 40, 'Active'),
(302, 'Non-AC Bus', 'CTG-5678', 36, 'Active'),
(303, 'Mini Bus', 'SYL-9012', 25, 'Maintenance');

SELECT * FROM Vehicles;
CREATE TABLE Routes (
    route_id INT PRIMARY KEY,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    distance DECIMAL(8,2),
    estimated_time VARCHAR(50)
);
INSERT INTO Routes VALUES
(401, 'Chattogram', 'Dhaka', 264.50, '6 Hours'),
(402, 'Chattogram', 'Cox''s Bazar', 149.00, '4 Hours'),
(403, 'Dhaka', 'Sylhet', 241.00, '5 Hours');

SELECT * FROM Routes;
CREATE TABLE Trips (
    trip_id INT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    driver_id INT NOT NULL,
    route_id INT NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    travel_date DATE NOT NULL,

    FOREIGN KEY (vehicle_id)
        REFERENCES Vehicles(vehicle_id),

    FOREIGN KEY (driver_id)
        REFERENCES Drivers(driver_id),

    FOREIGN KEY (route_id)
        REFERENCES Routes(route_id)
);
INSERT INTO Trips VALUES
(501, 301, 201, 401, '08:00:00', '14:00:00', '2026-06-20'),
(502, 302, 202, 402, '09:00:00', '13:00:00', '2026-06-21'),
(503, 303, 203, 403, '07:00:00', '12:00:00', '2026-06-22');

SELECT * FROM Trips;
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    trip_id INT NOT NULL,
    seat_number VARCHAR(10),
    booking_date DATE,
    status VARCHAR(20),

    FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY (trip_id)
        REFERENCES Trips(trip_id)
);
INSERT INTO Bookings VALUES
(601, 101, 501, 'A1', '2026-06-15', 'Confirmed'),
(602, 102, 502, 'B2', '2026-06-16', 'Confirmed'),
(603, 103, 503, 'C3', '2026-06-17', 'Pending');

SELECT * FROM Bookings;
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    payment_date DATE,

    FOREIGN KEY (booking_id)
        REFERENCES Bookings(booking_id)
);
INSERT INTO Payments VALUES
(701, 601, 1200.00, 'bKash', 'Paid', '2026-06-15'),
(702, 602, 850.00, 'Cash', 'Paid', '2026-06-16'),
(703, 603, 1000.00, 'Card', 'Pending', '2026-06-17');

SELECT * FROM Payments;
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    trip_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(255),
    feedback_date DATE,

    FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY (trip_id)
        REFERENCES Trips(trip_id)
);
INSERT INTO Feedback VALUES
(801, 101, 501, 5, 'Excellent service', '2026-06-21'),
(802, 102, 502, 4, 'Comfortable journey', '2026-06-22');

SELECT * FROM Feedback;
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    trip_id INT,
    message VARCHAR(255) NOT NULL,
    notification_type VARCHAR(20),
    sent_time DATETIME,
    status VARCHAR(20),

    FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY (trip_id)
        REFERENCES Trips(trip_id)
);
INSERT INTO Notifications VALUES
(901, 101, 501, 'Your booking has been confirmed.', 'SMS', GETDATE(), 'Delivered'),
(902, 102, 502, 'Trip departure reminder.', 'Email', GETDATE(), 'Sent'),
(903, 103, NULL, 'Payment is pending.', 'App', GETDATE(), 'Read');

SELECT * FROM Notifications;
SELECT * FROM Users;
SELECT * FROM Trips;
SELECT 
    U.name,
    B.seat_number,
    B.status
FROM Users U
JOIN Bookings B
ON U.user_id = B.user_id;

SELECT 
    T.trip_id,
    R.source,
    R.destination,
    V.vehicle_number,
    D.name AS Driver_Name
FROM Trips T
JOIN Routes R ON T.route_id = R.route_id
JOIN Vehicles V ON T.vehicle_id = V.vehicle_id
JOIN Drivers D ON T.driver_id = D.driver_id;

SELECT SUM(amount) AS Total_Revenue
FROM Payments
WHERE payment_status = 'Paid';

SELECT AVG(rating) AS Average_Rating
FROM Feedback;