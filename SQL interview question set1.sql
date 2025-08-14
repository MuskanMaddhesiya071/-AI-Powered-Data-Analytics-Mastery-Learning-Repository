-- Q1) DELETING DUPLICATES


-- Create a sample employees table
create database interview_question_sets
use interview_question_sets

CREATE TABLE Employees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Department VARCHAR(50),
    HireDate DATE
);

-- Insert sample data with some duplicates
INSERT INTO Employees VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 'IT', '2020-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'HR', '2019-05-20'),
(3, 'Robert', 'Johnson', 'robert.j@example.com', 'Finance', '2021-03-10'),
(1, 'John', 'Doe', 'john.doe@example.com', 'IT', '2020-01-15'), -- Duplicate of ID 1
(4, 'Emily', 'Davis', 'emily.d@example.com', 'Marketing', '2022-02-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'HR', '2019-05-20'), -- Duplicate of ID 2
(5, 'Michael', 'Brown', 'michael.b@example.com', 'IT', '2021-07-30'),
(3, 'Robert', 'Johnson', 'robert.j@example.com', 'Finance', '2021-03-10'); -- Duplicate of ID 3

select * from employees

-- Delete duplicates using ROW_NUMBER()
select * into table1
from Employees

WITH CTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY EmployeeID) AS RowNum
    FROM table1
)
DELETE FROM CTE WHERE RowNum > 1;

select * from table1

-- USING TEMPORARY TABLE 
-- Create a temp table with distinct records
SELECT DISTINCT * INTO TempEmployees FROM Employees;

-- Delete all records from original table
TRUNCATE TABLE Employees;

-- Insert distinct records back
INSERT INTO Employees SELECT * FROM TempEmployees;

-- Drop the temp table
DROP TABLE TempEmployees;

SELECT * from Employees


-- VERIFY RESULTS
-- Check all records
SELECT * FROM Employees ORDER BY EmployeeID;

-- Verify no duplicates exist
SELECT EmployeeID, COUNT(*) AS Count
FROM Employees
GROUP BY EmployeeID
HAVING COUNT(*) > 1;

-- IF ID IS UNIQUE AND REST ARE DUPLICATED
DELETE FROM Employees
WHERE EmployeeID NOT IN (
    SELECT MIN(EmployeeID) 
    FROM Employees 
    GROUP BY FirstName, LastName, Email
);


-- Q2) Nth highest salary
-- Create a sample employees table with salary information
CREATE TABLE Employees2 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Insert sample employee data with varying salaries
INSERT INTO Employees2 VALUES
(1, 'John', 'Doe', 'IT', 75000.00),
(2, 'Jane', 'Smith', 'HR', 68000.00),
(3, 'Robert', 'Johnson', 'Finance', 92000.00),
(4, 'Emily', 'Davis', 'Marketing', 82000.00),
(5, 'Michael', 'Brown', 'IT', 75000.00),
(6, 'Sarah', 'Wilson', 'Finance', 105000.00),
(7, 'David', 'Taylor', 'HR', 68000.00),
(8, 'Jessica', 'Anderson', 'Marketing', 88000.00);

-- method 1 : Subquery with max function
select max(salary) from Employees2
where Salary < (select max(salary) from Employees2);

-- method 2 : Dense rank function
WITH RankedSalaries AS (
    SELECT 
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM Employees2
)
SELECT salary AS SecondHighestSalary
FROM RankedSalaries
WHERE rnk = 2;

-- method 3: offset function
SELECT firstname, Salary AS SecondHighestSalary
FROM Employees2
ORDER BY Salary DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

-- method 4 : using top with subquery
select  top 1 salary
from (select top 2 salary from Employees2 order by salary desc) as topTwoSalary
order by salary asc







