﻿CREATE TABLE [dbo].[OrderItems]
(
	[ID] INT NOT NULL IDENTITY(1,1) CONSTRAINT pk_OrderItems PRIMARY KEY,
	[OrderID] INT NOT NULL CONSTRAINT fk_OrderItems_OrderID FOREIGN KEY	REFERENCES Orders(ID),
	[AirplaneID] INT NOT NULL CONSTRAINT fk_OrderItems_AirplaneID FOREIGN KEY REFERENCES Airplanes(ID),
	[OrderPrice] MONEY NOT NULL
)