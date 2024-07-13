GO
CREATE PROCEDURE GetTotalSalesAmount (
    @customer_id INT,
    @total_amount DECIMAL(10, 2) OUTPUT
)
AS
BEGIN
    SELECT @total_amount = SUM(p.Price * s.Quantity)
    FROM Sales s
    INNER JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.CustomerID = @customer_id;
END
GO
DECLARE @SaleAmount DECIMAL(18, 2);
EXEC GetTotalSalesAmount @customer_id = 1, @total_amount = @SaleAmount OUTPUT;
 
SELECT @SaleAmount AS TotalSalesAmount;

