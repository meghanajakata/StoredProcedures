CREATE PROCEDURE UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(18, 2),
    @StatusMessage NVARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @OldSalary DECIMAL(18, 2);

    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID)
        BEGIN
            SELECT @OldSalary = Salary FROM Employees WHERE ID = @EmployeeID;

            UPDATE Employees
            SET Salary = @NewSalary
            WHERE ID = @EmployeeID;

            IF @@ROWCOUNT > 0
            BEGIN
                INSERT INTO SalaryLog (EmployeeID, OldSalary, NewSalary, ChangeDate)
                VALUES (@EmployeeID, @OldSalary, @NewSalary, GETDATE());

                SET @StatusMessage = 'Update and log successful.';
            END
            ELSE
            BEGIN
                SET @StatusMessage = 'Update failed.';
            END
        END
        ELSE
        BEGIN
            SET @StatusMessage = 'Invalid EmployeeID.';
        END
    END TRY
    BEGIN CATCH
        SET @StatusMessage = 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END

DECLARE @StatusMessage NVARCHAR(100);

EXEC UpdateEmployeeSalary @EmployeeID = 2, @NewSalary = 80000.00, @StatusMessage = @StatusMessage OUTPUT;

PRINT @StatusMessage;

select * from employees
select * from salarylog