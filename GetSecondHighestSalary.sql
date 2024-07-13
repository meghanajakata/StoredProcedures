
GO
CREATE PROCEDURE GetSecondHighestSalary (
	@SecondHighestSalary DECIMAL(18, 2) OUT 
)
AS
BEGIN
    SELECT @SecondHighestSalary = MAX(Salary) 
	FROM Employees
	WHERE Salary < (SELECT MAX(Salary) FROM Employees);
END
GO

DECLARE @SecondHighestSalary DECIMAL(18, 2);
EXEC GetSecondHighestSalary @SecondHighestSalary = @SecondHighestSalary OUTPUT
 
SELECT @SecondHighestSalary AS SecondHighestSalary;

select * from Employees