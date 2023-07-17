CREATE PROCEDURE [dbo].[RemoveFromBasket]
	@itemID INT,
	@basketUID UNIQUEIDENTIFIER
AS

DECLARE @basketID INT = (SELECT ID FROM Baskets WHERE [UID] = @basketUID);
	
	WITH LatestItem AS (
		SELECT TOP 1
			bc.ID
		FROM
			BasketContents AS bc
		INNER JOIN
			Baskets AS b ON b.ID = bc.BasketID
		WHERE
			bc.AirplaneID = @itemID
		AND
			b.ID = @basketID
		ORDER BY
			bc.ID DESC
		)

	DELETE
		bc
	FROM
		BasketContents AS bc
	INNER JOIN
		LatestItem AS l ON l.ID = bc.ID

	SELECT
		b.[UID],
		b.[CreatedAt]
	FROM
		Baskets AS b
	WHERE
		b.ID = @basketID
