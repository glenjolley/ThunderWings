CREATE PROCEDURE [dbo].[GetAllProducts]
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
