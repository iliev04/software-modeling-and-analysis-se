USE AboutYouDb
GO

--- N best selling products (most selled quantity)
CREATE PROCEDURE sp_GetTopSellingProducts
    @TopN INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@TopN)
        p.ProductID,
        p.Name AS ProductName,
        SUM(oi.Quantity) AS TotalQuantitySold
    FROM
        Products p
    INNER JOIN
        Order_Items oi ON p.ProductID = oi.ProductID
    GROUP BY
        p.ProductID, p.Name
    ORDER BY
        TotalQuantitySold DESC;
END
GO

--- Update order and status
CREATE PROCEDURE sp_UpdateOrderStatus
    @OrderID INT,
    @NewStatus NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    IF @NewStatus NOT IN ('Pending', 'Processing', 'Shipped', 'Completed', 'Cancelled')
    BEGIN
        RAISERROR('Invalid status provided. Must be Pending, Processing, Shipped, Completed, or Cancelled.', 16, 1)
        RETURN
    END

    UPDATE Orders
    SET Status = @NewStatus
    WHERE OrderID = @OrderID;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('Order with the specified ID does not exist.', 16, 1)
        RETURN
    END
END
GO

--- Average rating of a product
CREATE FUNCTION fn_CalculateAverageRating
(
    @ProductID INT
)
RETURNS DECIMAL(3, 2)
AS
BEGIN
    DECLARE @AvgRating DECIMAL(3, 2);

    SELECT @AvgRating = AVG(CAST(Rating AS DECIMAL(3, 2)))
    FROM Reviews
    WHERE ProductID = @ProductID;

    IF @AvgRating IS NULL
        SET @AvgRating = 0.00;

    RETURN @AvgRating;
END
GO

--- Trigger for updating quantity
CREATE TRIGGER trg_UpdateStockQuantity
ON Order_Items
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE p
    SET StockQuantity = p.StockQuantity - (i.Quantity - ISNULL(d.Quantity, 0))
    FROM Products p
    INNER JOIN inserted i ON p.ProductID = i.ProductID
    LEFT JOIN deleted d ON i.OrderID = d.OrderID AND i.ProductID = d.ProductID;

    IF EXISTS (
        SELECT 1
        FROM Products p
        INNER JOIN inserted i ON p.ProductID = i.ProductID
        WHERE p.StockQuantity < 0
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Insufficient stock quantity for one or more products.', 16, 1);
        RETURN;
    END
END
GO

-- Test sp1
EXEC sp_GetTopSellingProducts @TopN = 3;
GO
-- Test sp2
EXEC sp_UpdateOrderStatus @OrderID = 6, @NewStatus = 'Shipped';
GO
-- Test function
SELECT
    p.Name,
    dbo.fn_CalculateAverageRating(p.ProductID) AS AverageRating
FROM Products p
WHERE p.ProductID = 1;
GO