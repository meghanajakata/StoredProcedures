GO
CREATE PROCEDURE GetHighLowAverage (
    @CustomerID INT,
    @HighestAmount DECIMAL(10, 2) OUTPUT,
	@LowestAmount DECIMAL(10, 2) OUTPUT,
	@AverageAmount DECIMAL(10, 2) OUTPUT
)
AS
BEGIN
    SELECT @HighestAmount = MAX(OrderAmount), @LowestAmount = MIN(OrderAmount), @AverageAmount = AVG(OrderAmount)
    FROM Orders 
    WHERE CustomerID = @CustomerID;
END
GO
DECLARE @High DECIMAL(10, 2);
DECLARE @Low DECIMAL(10, 2);
DECLARE @Average DECIMAL(10, 2);
EXEC GetHighLowAverage @CustomerID = 1, @HighestAmount = @High OUTPUT, @LowestAmount = @Low OUTPUT, @AverageAmount = @Average OUTPUT;
 
-- Display the result
SELECT @High AS Highest_Order_Amount, @Low AS Lowest_Order_Amount, @Average  AS Average_Amount;