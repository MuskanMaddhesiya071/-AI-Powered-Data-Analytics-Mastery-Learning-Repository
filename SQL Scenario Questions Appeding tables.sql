create database Append;

-- Creating first table with three columns
CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Creating second table with three shared columns and one additional column
CREATE TABLE Departments1 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentName VARCHAR(100)
);

-- Insert statements for Employees table
INSERT INTO Employees1 (EmployeeID, FirstName, LastName) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Bob', 'Johnson');

-- Insert statements for Departments table
INSERT INTO Departments1 (EmployeeID, FirstName, LastName, DepartmentName) VALUES
(1, 'John', 'Doe', 'IT'),
(2, 'Jane', 'Smith', 'HR'),
(3, 'Bob', 'Johnson', 'Finance');

select * from employees1
select * from Departments1

-- NOW WE WANT TO APPEND THIS TWO TABLES INTO A SINGLE TABLE WITH HAVING SAME COLUMNS AND DATATYPES

select employeeID,firstName, LastName into TableCombined
from Employees1
Union All
select employeeID,firstName, LastName from Departments1

select * from TableCombined

-- IF WE WANT TO ADD THE EXTRA COLUMNS
alter table employees1
add  DepartmentName varchar(255) null;

select employeeID,firstName, LastName, DepartmentName into TableCombined
from Employees1
Union All
select employeeID,firstName, LastName, DepartmentName from Departments1

select * from TableCombined
