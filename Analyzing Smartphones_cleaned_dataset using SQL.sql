create database data1
use data1

select * from [dbo].[Smartphones_cleaned_dataset]

-- the dataset’s structure, summary statistics, data quality, and outliers.

-- how many tables we have
select table_name
from INFORMATION_SCHEMA.tables
where table_type='base table';

-- View Table Structure (Schema, Data Types, Nullability)
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Smartphones_cleaned_dataset';

-- top 10 rows
select top 10 * from  Smartphones_cleaned_dataset;

-- Count total rows
SELECT COUNT(*) AS TotalRows FROM Smartphones_cleaned_dataset;


-- Repeat for each column
SELECT COUNT(DISTINCT model) AS Distinct_Column1 FROM Smartphones_cleaned_dataset;

-- Find Null/Blank Values per Column
SELECT
  SUM(CASE WHEN model IS NULL THEN 1 ELSE 0 END) AS Null_Column1,
  SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS Null_Column2
FROM Smartphones_cleaned_dataset;

-- Summary Statistics for Numerical Columns
SELECT 
  MIN(price) AS MinValue,
  MAX(price) AS MaxValue,
  AVG(price) AS AverageValue,
  SUM(price) AS TotalValue,
  COUNT(price) AS NonNullCount
FROM Smartphones_cleaned_dataset;

-- Value Frequency/Distribution
SELECT brand_name, COUNT(*) AS Occurrences
FROM Smartphones_cleaned_dataset
GROUP BY brand_name
ORDER BY Occurrences DESC;

-- Detect Outliers (z-score method for Numeric Columns)
SELECT *,
    (rating - AVG(rating) OVER()) / 
    NULLIF(STDEVP(rating) OVER(), 0) AS ZScore
FROM Smartphones_cleaned_dataset;
-- You can filter for |ZScore| > 3 for typical outliers-- You can filter for |ZScore| > 3 for typical outliers

-- Duplicate Rows Detection
SELECT brand_name, model, COUNT(*) AS Repeats
FROM Smartphones_cleaned_dataset
GROUP BY brand_name, model
HAVING COUNT(*) > 1;

--  Cross-Tab/Group Analysis
SELECT brand_name, AVG(price) AS AvgValue
FROM Smartphones_cleaned_dataset
GROUP BY brand_name
ORDER BY AvgValue DESC;


-- WRITNG QUERIES TO SOLVE SPECIFIC COLUMNS

-- handling null values
select top 5 * from Smartphones_cleaned_dataset
where rating is null

select avg(rating) as avg_rating
from Smartphones_cleaned_dataset

update Smartphones_cleaned_dataset
set rating=78
where rating is null

-- Copy of the original table
select * into backup_smartphone
from Smartphones_cleaned_dataset 

-- now filling the null values with the avg value without hardcode using sub query
update backup_smartphone
set rating =(select avg(rating) as avg_rating
from backup_smartphone)
where rating is null

-- RESOLVING SPECIFIC DATA CLEANING ISSUE
-- filling the null values in fast_charge with the mode

with ModeCTE as(
     select top 1 fast_charging
     from Smartphones_cleaned_dataset
     where fast_charging is not null
     group by fast_charging
     order by count(*)desc)
select * from ModeCTE

update backup_smartphone
set fast_charging=33
where fast_charging is null














