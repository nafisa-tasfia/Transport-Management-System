# Transport Management System

## Project Overview

The **Transport Management System** is a relational database project developed using Microsoft SQL Server and Transact-SQL (T-SQL). It demonstrates how transport related information can be organized, stored, and retrieved through a structured relational database.

The database consists of 10 related tables covering administrator accounts, users, drivers, vehicles, routes, trips, bookings, payments, feedback, and notifications. The project applies fundamental database concepts, including relational design, integrity constraints, table relationships, joins, and aggregate functions.

## Project Objectives

- Design a relational database for managing transport related information.
- Establish relationships between tables using primary and foreign keys.
- Maintain data integrity through appropriate constraints.
- Retrieve related information using SQL queries and joins.
- Analyze payment records and customer ratings using aggregate functions.

## Database Structure

The project consists of the following 10 tables:

 Table Name                     Description 

Admin:                Stores administrator account information.
Users:                Stores user details, contact information, addresses, and passwords. 
Drivers:              Stores driver details, license numbers, experience, and availability status. 
Vehicles:             Stores vehicle types, registration numbers, capacities, and statuses. 
Routes:               Stores route sources, destinations, distances, and estimated travel times. 
Trips:                Associates vehicles, drivers, and routes with trip schedules. 
Bookings:             Records user bookings, seat numbers, booking dates, and statuses. 
Payments:             Stores payment amounts, methods, statuses, and payment dates. 
Feedback:             Records user ratings, comments, and feedback dates for trips. 
Notifications:        Stores notification messages, types, timestamps, statuses, and related user and trip references. 

## Key Features

- **Relational database design:** Organizes transport information across 10 related tables.
- **Data integrity:** Uses primary keys, foreign keys, `NOT NULL`, `UNIQUE`, and `CHECK` constraints.
- **Trip information retrieval:** Combines trip, route, vehicle, and driver information through joins.
- **Booking information retrieval:** Retrieves booking details associated with individual users.
- **Payment analysis:** Calculates total revenue from payment records marked as `Paid`.
- **Feedback analysis:** Calculates the average rating recorded in the Feedback table.
- **Sample data:** Inserts sample records to demonstrate the database structure and queries.
- **Timestamp generation:** Uses SQL Server's `GETDATE()` function to generate notification timestamps.

## Database Relationships

The database uses foreign keys to establish the following relationships:

- Each trip references a vehicle, a driver, and a route.
- Each booking references a user and a trip.
- Each payment record references a booking.
- Each feedback record references a user and a trip.
- Each notification references a user and may optionally reference a trip.

These relationships connect transport operations and related records across the database.

## SQL Concepts Applied

 **Data Definition Language (DDL):** `CREATE DATABASE`, `CREATE TABLE`
 **Data Manipulation Language (DML):** `INSERT INTO`
 **Data retrieval:** `SELECT`, `WHERE`
 **Relational operations:** `JOIN`
 **Aggregate functions:** `SUM()`, `AVG()`
 **Integrity constraints:** `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `CHECK`
 **SQL Server function:** `GETDATE()`

## Sample Queries

### 1. Retrieve User Booking Details

Retrieves user names alongside their booked seat numbers and booking statuses.

```sql
SELECT
    U.name,
    B.seat_number,
    B.status
FROM Users U
JOIN Bookings B
    ON U.user_id = B.user_id;
```

### 2. Retrieve Trip Information

Combines data from the Trips, Routes, Vehicles, and Drivers tables.

```sql
SELECT
    T.trip_id,
    R.source,
    R.destination,
    V.vehicle_number,
    D.name AS Driver_Name
FROM Trips T
JOIN Routes R
    ON T.route_id = R.route_id
JOIN Vehicles V
    ON T.vehicle_id = V.vehicle_id
JOIN Drivers D
    ON T.driver_id = D.driver_id;
```

### 3. Calculate Total Paid Revenue

Calculates the sum of payment amounts for records with a `Paid` status.

```sql
SELECT SUM(amount) AS Total_Revenue
FROM Payments
WHERE payment_status = 'Paid';
```

### 4. Calculate Average Customer Rating

Calculates the average of the ratings stored in the Feedback table.

```sql
SELECT AVG(rating) AS Average_Rating
FROM Feedback;
```

## Technology Stack

- **Database Management System:** Microsoft SQL Server
- **Query Language:** Transact-SQL (T-SQL)
- **Database Tool:** SQL Server Management Studio (SSMS)

## How to Run

1. Install Microsoft SQL Server and SQL Server Management Studio (SSMS).
2. Open SSMS and connect to your SQL Server instance.
3. Open the `transport_management_system.sql` file.
4. Execute the script to create the database and tables, insert sample data, and run the included queries.
5. Review the query results to explore booking information, trip details, total paid revenue, and average customer ratings.

## Future Improvements

**Spatial Data Integration:** Integration of SQL Server spatial data types, such as `GEOGRAPHY`, for location-based transport tracking and route analysis.
**Automated Maintenance Monitoring:** Implementation of database triggers to flag vehicles for maintenance based on predefined trip or mileage thresholds.
**Immutable Audit Trail:** An append-only historical record system for tracking driver assignments and trip history to support auditing and fraud detection.
**Advanced SQL Analytics:** More comprehensive queries and reports for transport operations, bookings, and payment analysis.
**Enhanced Booking Validation:** Duplicate-booking prevention and seat availability tracking.
**Improved Data Security:** Secure password storage and stronger authentication practices.
**Application Integration:** A user interface connected to the SQL Server database.

## References

1. Elmasri, R., & Navathe, S. B. (2015). *Fundamentals of Database Systems* (7th ed.). Pearson.
2. Celko, J. (2014). *Joe Celko's SQL for Smarties: Advanced SQL Programming and Tuning*. Morgan Kaufmann.
3. International Organization for Standardization (ISO) & International Electrotechnical Commission (IEC). *ISO/IEC 9075: Information technology — Database languages — SQL*.
