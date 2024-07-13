select * from employees

CREATE PROCEDURE UpdateEmployeeDepartment
    @EmployeeID INT,
    @DepartmentID INT,
    @StatusMessage NVARCHAR(100) OUTPUT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID)
        BEGIN
            IF EXISTS (SELECT 1 FROM Departments WHERE ID = @DepartmentID)
            BEGIN
                UPDATE Employees
                SET DepartmentID = @DepartmentID
                WHERE ID = @EmployeeID;

                IF @@ROWCOUNT > 0
                BEGIN
                    SET @StatusMessage = 'Update successful.';
                END
                ELSE
                BEGIN
                    SET @StatusMessage = 'Update failed.';
                END
            END
            ELSE
            BEGIN
                SET @StatusMessage = 'Invalid DepartmentID.';
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

EXEC UpdateEmployeeDepartment @EmployeeID = 2, @DepartmentID = 3, @StatusMessage = @StatusMessage OUTPUT;

PRINT @StatusMessage;

