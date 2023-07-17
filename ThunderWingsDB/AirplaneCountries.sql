CREATE TABLE [dbo].[AirplaneCountries]
(
	[ID] INT IDENTITY(1,1) CONSTRAINT pk_AirplaneCountries PRIMARY KEY,
	[AirplaneID] INT NOT NULL CONSTRAINT fk_AirplaneCountries_AirplaneID FOREIGN KEY REFERENCES Airplanes(ID),
	[CountryID] INT NOT NULL CONSTRAINT fk_AirplaneCountries_CountryID FOREIGN KEY REFERENCES Countries(ID)
)
