CREATE PROCEDURE [dbo].[AddToBasket]
	@itemID INT,
	@basketUID UNIQUEIDENTIFIER = null
AS

DECLARE @basketID INT = (SELECT ID FROM Baskets WHERE [UID] = @basketUID);

	IF @basketID IS NULL
		BEGIN

			INSERT INTO Baskets ([UID], CreatedAt)
			VALUES (@basketUID, GETDATE())

			SET @basketID = SCOPE_IDENTITY();
		END

	INSERT INTO BasketContents (BasketID, AirplaneID, AddedAt)
	VALUES (@basketID, @itemID, GETDATE())

	SELECT
		b.[UID],
		b.[CreatedAt]
	FROM
		Baskets AS b
	WHERE
		b.ID = @basketID
