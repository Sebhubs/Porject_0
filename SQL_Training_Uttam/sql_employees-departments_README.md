# SQL Exercise Comprehensive Review

This document provides a comprehensive review of the SQL exercise I've worked through, covering the essential concepts and operations across **DDL (Data Definition Language)**, **DML (Data Manipulation Language)**, **DQL (Data Query Language)**, **DCL (Data Control Language)**, **TCL (Transaction Control Language)**, as well as advanced SQL features like joins, set operations, and aggregation functions. This review will include the structured queries and operations we discussed for a fictional company database scenario involving Employees and Departments.

## 1. Data Definition Language (DDL)

### Create Tables

- **Departments Table**

```sql
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);
```

- **Employees Table**

```sql
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    BirthDate DATE NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    EmailAddress VARCHAR(255),
    CONSTRAINT fk_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
```

### Alter Table

- **Rename a Column**

```sql
ALTER TABLE Employees CHANGE COLUMN Email EmailAddress VARCHAR(255);
```

- **Add a New Column with Default Value**

```sql
ALTER TABLE Employees ADD COLUMN EmploymentType VARCHAR(10) NOT NULL DEFAULT 'Full-Time';
```

- **Add Unique Constraint**

```sql
ALTER TABLE Employees ADD UNIQUE (EmailAddress);
```

## 2. Data Manipulation Language (DML)

### Insert Data

```sql
INSERT INTO Departments (DepartmentID, DepartmentName, Location) VALUES
(1, 'Human Resources', 'New York'),
(2, 'Finance', 'London'),
(3, 'IT', 'San Francisco');
```

```sql
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, DepartmentID, Salary, EmailAddress) VALUES
(1, 'Assad', 'KomplecatedLastName', '1994-01-01', 1, 60000, 'assadkardanameh@example.com'),
(2, 'Sanket', 'Smith', '1994-05-05', 2, 65000, 'sanket@example.com'),
(3, 'Parvith', 'Johnson', '1994-07-07', 3, 70000, 'parvith@example.com'),
(4, 'Elaheh', 'Wright', '1994-07-07', 3, 71000, 'elaheh@example.com'),
(5, 'Anu', 'Tamila', '1994-07-07', 3, 71000, 'anu@example.com');
```

### Update Data

```sql
UPDATE Employees SET Salary = Salary * 1.10 WHERE DepartmentID = 3;
```

### Delete Data

```sql
DELETE FROM Employees WHERE EmployeeID = 3;
```

## 3. Data Query Language (DQL)

### Select Data

```sql
SELECT * FROM Employees WHERE DepartmentID = 3;
```

### Aggregation

```sql
SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM Employees GROUP BY DepartmentID;
```

## 4. Joins

### Inner Join

```sql
SELECT Employees.*, Departments.DepartmentName
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;
```

## 5. Set Operations

### Union

```sql
SELECT Location FROM Departments
UNION
SELECT Location FROM OfficeLocations;
```

## 6. Transaction Control Language (TCL)

### Transaction with Savepoint

```sql
START TRANSACTION;
UPDATE Employees SET Salary = Salary * 1.10 WHERE DepartmentID = 2;
SAVEPOINT salary_increase;
DELETE FROM Employees WHERE EmployeeID = 2;
ROLLBACK TO salary_increase;
COMMIT;
```

## 7. Cleanup

### Drop Tables

```sql
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS OfficeLocations;
```

This exercise provided a thorough overview of SQL operations, from creating and modifying table structures to manipulating and querying data, managing transactions, and ensuring data integrity with constraints.
