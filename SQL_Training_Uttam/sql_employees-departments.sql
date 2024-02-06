-- 1. Data Definition Language (DDL)
-- Create Tables

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

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

CREATE TABLE OfficeLocations (
    LocationID INT PRIMARY KEY,
    Location VARCHAR(255) NOT NULL
);



ALTER TABLE Employees ADD Email VARCHAR(255);
-- Example: Renaming Email to EmailAddress
ALTER TABLE Employees CHANGE COLUMN Email EmailAddresses VARCHAR(255);
ALTER TABLE Employees DROP COLUMN EmailAddresses;
DESCRIBE Employees;
select * from Employees;

-- 1. Data Manipulation Language (DML) Operations 
INSERT INTO Departments (DepartmentID, DepartmentName, Location) VALUES
(1, 'Human Resources', 'New York'),
(2, 'Finance', 'London'),
(3, 'IT', 'San Francisco');

select * from Departments ;

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, DepartmentID, Salary, EmailAddress) VALUES
(1, 'John', 'Doe', '1990-01-01', 1, 60000, 'johndoe@example.com'),
(2, 'Jane', 'Smith', '1985-05-05', 2, 65000, 'janesmith@example.com'),
(3, 'Mike', 'Johnson', '1978-07-07', 3, 70000, 'mikejohnson@example.com');


INSERT INTO OfficeLocations (LocationID, Location) VALUES
(1, 'New York'),
(2, 'San Francisco'),
(3, 'Berlin');



select * from Employees ;
select * from OfficeLocations ;


-- Updating Data (Suppose you want to give everyone in the IT department a 10% raise) 
UPDATE Employees SET Salary = Salary * 1.10 WHERE DepartmentID = 3;
select * from Employees ;

-- Deleting Data (If an employee leaves the company (let's say EmployeeID 3))
DELETE FROM Employees WHERE EmployeeID = 3;
select * from Employees ;


-- Data Query Language (DQL) Operations
-- Now, let's extract some information from our database.
-- Select all employees in the IT department:
SELECT * FROM Employees WHERE DepartmentID = 3;

-- Calculate average salary by department:
SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM Employees GROUP BY DepartmentID;

-- Implementing Joins
-- To see employees along with their department information:
SELECT Employees.*, Departments.DepartmentName
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

SELECT * FROM Employees ;
SELECT * FROM Departments ;
describe Departments;
describe Employees;
DESCRIBE OfficeLocations;


-- 4. Set Operations
-- Suppose you want to find all department locations that are also listed in a table of office locations (for simplicity, let's assume an OfficeLocations table exists):
-- Union (find all unique locations in both Departments and OfficeLocations):
SELECT Location FROM Departments
UNION
SELECT Location FROM OfficeLocations;


-- The error "Error Code: 1146. Table 'test_db.officelocations' doesn't exist" indicates that the SQL query is attempting to select data from a table named OfficeLocations in your database (test_db), but no table with that name exists in the database. This was part of the hypothetical scenario to demonstrate the use of SQL set operations like UNION.
-- To proceed with this part of the exercise and demonstrate the UNION operation, you'll need to first create the OfficeLocations table and insert some data into it. Let's create this table and add a few entries so that you can successfully execute the UNION operation.
-- Step 1: Create the OfficeLocations Table
-- sql
-- Copy code

CREATE TABLE OfficeLocations (
    LocationID INT PRIMARY KEY,
    Location VARCHAR(255) NOT NULL
);
-- Step 2: Insert Data into OfficeLocations
-- Insert some data into the OfficeLocations table. Include some locations that match the Departments table and some that are unique to ensure the UNION operation has interesting results.

-- sql
-- Copy code
INSERT INTO OfficeLocations (LocationID, Location) VALUES
(1, 'New York'),
(2, 'San Francisco'),
(3, 'Berlin');
-- Assuming the Departments table has locations like 'New York', 'London', and 'San Francisco', this setup will allow you to see how UNION combines and removes duplicates from both tables.

-- Step 3: Execute the UNION Operation Again
-- Now that the OfficeLocations table exists and contains data, you can execute the UNION operation without encountering the error.

-- sql
-- Copy code
SELECT Location FROM Departments
UNION
SELECT Location FROM OfficeLocations;
-- This query will select all unique locations from both the Departments and OfficeLocations tables, demonstrating how UNION works by combining results from two queries and removing duplicates.


-- ----------------------------------------------------- 
-- 5. Transaction Control Language (TCL) Operations
-- Having demonstrated basic operations, let's delve deeper into transactions, which are crucial for ensuring data integrity in operations that should be executed as a single unit.
-- Demonstrate a Transaction with Savepoint
START TRANSACTION;
-- Assuming you want to update the salary of all employees in a specific department
UPDATE Employees SET Salary = Salary * 1.10 WHERE DepartmentID = 2;
-- Create a savepoint in case you need to rollback this specific operation
SAVEPOINT salary_increase;

-- Further operations, for example, deleting an employee record
DELETE FROM Employees WHERE EmployeeID = 2;

-- If you decide the deletion was a mistake, you can rollback to the savepoint
ROLLBACK TO salary_increase;

-- If everything else is fine, commit the transaction
COMMIT;

-- ----------------------------------------------------- 

-- 6. Data Definition Language (DDL) Advanced Operations
-- After manipulating data, you might want to further refine your database structure. Let's explore altering tables and managing constraints.

-- Add a New Column with a Default Value
-- Suppose you decide to track whether employees are full-time or part-time:
ALTER TABLE Employees ADD COLUMN EmploymentType VARCHAR(10) NOT NULL DEFAULT 'Full-Time';
SELECT * FROM Employees;


-- Modify Constraints
-- To ensure data integrity, you might need to add or modify constraints. For example, ensuring EmailAddress is unique among employees:
ALTER TABLE Employees ADD UNIQUE (EmailAddress);
SELECT * FROM Employees;

-- 7. Complex Queries Using Joins, Aggregation, and Subqueries
-- Let's construct a query that involves a join, aggregation functions, and possibly a subquery, to extract meaningful information from our database.
-- Find the Highest Salary in Each Department
SELECT d.DepartmentName, MAX(e.Salary) AS HighestSalary
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;
-- This query joins the Departments and Employees tables to find the maximum salary in each department.



-- 8. Set Operations Continued
-- Assuming you have more than one table from which you want to extract unified information, here's how to use UNION ALL to include all entries, including duplicates.
-- Combine Locations from Departments and OfficeLocations
SELECT Location FROM Departments
UNION ALL
SELECT Location FROM OfficeLocations;
-- This will list all locations, including duplicates, from both tables.




-- 9. Final Cleanup
-- Once you've practiced all necessary operations and are ready to clean up:
-- Drop Tables
-- If you decide to remove the tables and data to start fresh or conclude your exercise:
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS OfficeLocations;



-- Wrapping Up
-- This comprehensive exercise covered a wide range of SQL operations, from basic data manipulation and querying to more advanced concepts like transactions, joins, aggregation, and set operations. By implementing these examples, you'll have practiced key SQL skills essential for data engineering and database management.
