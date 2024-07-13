CREATE PROCEDURE GetDistinctColumnValues
    @TableName NVARCHAR(128),
    @ColumnName NVARCHAR(128)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    
    SET @SQL = N'SELECT DISTINCT ' + QUOTENAME(@ColumnName) + ' FROM ' + QUOTENAME(@TableName);
    
    EXEC sp_executesql @SQL;
END;

EXEC GetDistinctColumnValues @TableName = 'Employees', @ColumnName = 'DepartmentID';