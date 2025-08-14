-- Create table and insert sample data
CREATE TABLE SalesData (
    SalesPerson VARCHAR(50),
    ProductCategory VARCHAR(50),
    Quarter VARCHAR(10),
    Amount DECIMAL(10,2)
);

INSERT INTO SalesData VALUES
('John', 'Electronics', 'Q1', 1200.00),
('John', 'Furniture', 'Q1', 800.00),
('John', 'Electronics', 'Q2', 1500.00),
('John', 'Furniture', 'Q2', 950.00),
('Sarah', 'Electronics', 'Q1', 900.00),
('Sarah', 'Clothing', 'Q1', 1200.00),
('Sarah', 'Clothing', 'Q2', 1400.00),
('Sarah', 'Furniture', 'Q2', 1100.00),
('Mike', 'Electronics', 'Q1', 750.00),
('Mike', 'Electronics', 'Q2', 1300.00),
('Mike', 'Clothing', 'Q2', 850.00);

-- PIVOT QUERY EXAMPLE
-- Pivot query to show sales by category per quarter
SELECT SalesPerson, [Electronics], [Clothing], [Furniture]
FROM 
(
    SELECT SalesPerson, ProductCategory, Amount
    FROM SalesData
) AS SourceTable
PIVOT
(
    SUM(Amount)
    FOR ProductCategory IN ([Electronics], [Clothing], [Furniture])
) AS PivotTable;

select * from SalesData

-- UNPIVOT the data
-- Create a pivoted sales table
CREATE TABLE PivotedSales (
    SalesPerson VARCHAR(50),
    Electronics DECIMAL(10,2),
    Clothing DECIMAL(10,2),
    Furniture DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO PivotedSales VALUES
('John', 2700.00, NULL, 1750.00),
('Sarah', 900.00, 2600.00, 1100.00),
('Mike', 2050.00, 850.00, NULL);

select * from PivotedSales

-- UNPIVOT the data
SELECT SalesPerson, ProductCategory, Amount
FROM 
(
    SELECT SalesPerson, Electronics, Clothing, Furniture
    FROM PivotedSales
) AS SourceTable
UNPIVOT
(
    Amount FOR ProductCategory IN (Electronics, Clothing, Furniture)
) AS UnpivotTable;
