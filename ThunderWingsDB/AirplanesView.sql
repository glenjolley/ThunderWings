CREATE VIEW [dbo].[AirplanesView]
	AS 
	
	SELECT
		 a.[ID]
		,a.[Name]
		,a.[TopSpeed]
		,a.[Price]
		,c.[Name] AS [Country]
		,r.[Name] AS [Role]
		,m.[Name] AS [Manufacturer]
		,CONCAT(a.[Name],r.[Name],m.[Name],c.[name]) AS [SearchColumn]
	FROM
		Airplanes AS a
	INNER JOIN
		AirplaneRoles AS ar ON ar.AirplaneID = a.ID
	INNER JOIN
		AirplaneManufacturers AS am ON am.AirplaneID = a.ID
	INNER JOIN
		AirplaneCountries AS ac ON ac.AirplaneID = a.ID
	INNER JOIN
		Countries AS c ON c.ID = ac.CountryID
	INNER JOIN
		Manufacturers AS m ON m.ID = am.ManufacturerID
	INNER JOIN
		Roles AS r ON r.ID = ar.RoleID
