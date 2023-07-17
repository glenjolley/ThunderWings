CREATE PROCEDURE [dbo].[GetBasketContents]
	@basketUID UNIQUEIDENTIFIER
AS
	SELECT
		 v.[ID]
		,v.[Name]
		,v.[TopSpeed]
		,v.[Price]
		,v.[Country]
		,v.[Role]
		,v.[Manufacturer]
	FROM
		AirplanesView AS v
	INNER JOIN
		BasketContents AS bc ON bc.AirplaneID = v.ID
	INNER JOIN
		Baskets AS b ON b.ID = bc.BasketID
	WHERE
		b.UID = @basketUID