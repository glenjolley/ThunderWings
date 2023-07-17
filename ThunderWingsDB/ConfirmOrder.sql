CREATE PROCEDURE [dbo].[ConfirmOrder]
	@basketUID UNIQUEIDENTIFIER,
	@customerName NVARCHAR(255),
	@deliveryAddress NVARCHAR(1000),
	@result INT OUTPUT
AS

DECLARE @basketID INT = (SELECT ID FROM Baskets WHERE [UID] = @basketUID);

IF NOT EXISTS (SELECT ID FROM Orders WHERE BasketID = @basketID)
	BEGIN

		INSERT INTO Orders (BasketID, CustomerName, DeliveryAddress, CreatedAt)
		VALUES (@basketID, @customerName, @deliveryAddress, GETDATE());

		DECLARE @orderID INT = SCOPE_IDENTITY();

		INSERT INTO OrderItems (OrderID, AirplaneID, OrderPrice)
		SELECT
			o.ID,
			v.ID,
			v.Price
		FROM
			AirplanesView AS v
		INNER JOIN
			BasketContents AS bc ON bc.AirplaneID = v.ID
		INNER JOIN
			Orders AS o ON o.BasketID = bc.BasketID
		WHERE
			bc.BasketID = @basketID;

		SET @result = 1;

		SELECT
			o.ID
			,o.CustomerName
			,o.DeliveryAddress
			,o.CreatedAt
			,SUM(oi.OrderPrice) AS [TotalCost]
		FROM
			Orders AS o
		INNER JOIN
			OrderItems AS oi ON oi.OrderID = o.ID
		WHERE
			o.ID = @orderID
		GROUP BY
			o.ID,
			o.CustomerName,
			o.DeliveryAddress,
			o.CreatedAt;

	END
ELSE
	BEGIN
		
		SET @result = 2;

		SELECT
			o.ID
			,o.CustomerName
			,o.DeliveryAddress
			,o.CreatedAt
			,SUM(oi.OrderPrice) AS [TotalCost]
		FROM
			Orders AS o
		INNER JOIN
			OrderItems AS oi ON oi.OrderID = o.ID
		WHERE
			o.BasketID = @basketID
		GROUP BY
			o.ID,
			o.CustomerName,
			o.DeliveryAddress,
			o.CreatedAt;

	END
	
	
