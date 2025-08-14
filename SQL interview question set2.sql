-- DYNAMIC SQL 

DECLARE @TableName NVARCHAR(128) = 'Employees';
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = 'SELECT * FROM ' + @TableName;
EXEC sp_executesql @SQL;


-- Parameterized Example (Safe from SQL injection)
DECLARE @Department NVARCHAR(50) = 'IT';
DECLARE @MinSalary DECIMAL(10,2) = 70000;
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = 'SELECT * FROM Employees WHERE Department = @Dept ';
EXEC sp_executesql @SQL, 
                   N'@Dept NVARCHAR(50), @Sal DECIMAL(10,2)',
                   @Dept = @Department, @Sal = @MinSalary;






