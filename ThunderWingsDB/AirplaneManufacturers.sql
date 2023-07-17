CREATE TABLE [dbo].[AirplaneManufacturers]
(
	[ID] INT IDENTITY(1,1) CONSTRAINT pk_AirplaneManufacturers PRIMARY KEY,
	[AirplaneID] INT NOT NULL CONSTRAINT fk_AirplaneManufacturers_AirplaneID FOREIGN KEY REFERENCES Airplanes(ID),
	[ManufacturerID] INT NOT NULL CONSTRAINT fk_AirplaneManufacturers_ManufacturerID FOREIGN KEY REFERENCES Manufacturers(ID)
)
