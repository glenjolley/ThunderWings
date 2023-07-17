CREATE TABLE [dbo].[Manufacturers]
(
	[ID] INT IDENTITY(1,1) CONSTRAINT pk_Manufacturers PRIMARY KEY,
	[Name] NVARCHAR(255) NOT NULL
)
