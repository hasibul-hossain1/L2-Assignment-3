# Vehicle Rental System SQL Project

## Project Overview

This project demonstrates SQL queries and solutions for a **Vehicle Rental System** database.  
The system includes three main entities:

1. **Users** – Stores user information.
2. **Vehicles** – Stores vehicle information.
3. **Bookings** – Stores vehicle booking information and connects users with vehicles.

The purpose of this project is to practice **SQL querying, joins, aggregation, and filtering**.

---

## Database Tables

### **Users**

| Column Name | Data Type | Description      |
| ----------- | --------- | ---------------- |
| user_id     | SERIAL    | Primary Key      |
| username    | VARCHAR   | Name of the user |

### **Vehicles**

| Column Name | Data Type | Description         |
| ----------- | --------- | ------------------- |
| vehicle_id  | SERIAL    | Primary Key         |
| name        | VARCHAR   | Name of the vehicle |

### **Bookings**

| Column Name  | Data Type | Description                      |
| ------------ | --------- | -------------------------------- |
| booking_id   | SERIAL    | Primary Key                      |
| user_id      | INT       | Foreign Key referencing Users    |
| vehicle_id   | INT       | Foreign Key referencing Vehicles |
| booking_date | DATE      | Date of booking                  |

---

## Queries and Solutions

All SQL queries with explanations are in **`queries.sql`**.

### Example Queries:

1. **Retrieve booking information along with customer name and vehicle name**

```sql
SELECT
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
FROM
  bookings AS b
  JOIN users AS u ON b.booking_id = u.user_id
  JOIN vehicles AS v ON b.vehicle_id = b.booking_id
```

2. **Find all vehicles that have never been booked.**

```sql
SELECT
  *
FROM
  vehicles AS v
WHERE
  NOT EXISTS (
    SELECT
      *
    FROM
      bookings AS b
    WHERE
      v.vehicle_id = b.vehicle_id
  )
```

3. **Retrieve all available vehicles of a specific type (e.g. cars).**

```sql
SELECT
  *
FROM
  vehicles
WHERE
  STATUS = 'available'
  AND TYPE = 'car'
```

4. **Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.**

```sql
SELECT
  v.name AS vehicle_name,
  count(*) AS total_bookings
FROM
  vehicles AS v
  join bookings AS b ON v.vehicle_id = b.vehicle_id
GROUP BY
  v.name
HAVING
  count(*) > 2;
```
