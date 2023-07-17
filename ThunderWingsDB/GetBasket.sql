CREATE PROCEDURE [dbo].[GetBasket]
	@basketUID UNIQUEIDENTIFIER
AS

DECLARE @basketID INT = (SELECT ID FROM Baskets WHERE [UID] = @basketUID);	

	SELECT
		b.[UID],
		b.[CreatedAt]
	FROM
		Baskets AS b
	WHERE
		b.ID = @basketID
