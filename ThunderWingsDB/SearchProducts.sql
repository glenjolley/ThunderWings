CREATE PROCEDURE [dbo].[SearchProducts]
	@searchQuery NVARCHAR(255)
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
	WHERE
		v.[SearchColumn] LIKE CONCAT('%',@searchQuery,'%')
