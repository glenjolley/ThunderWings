﻿CREATE TABLE [dbo].[Orders]
(
	[ID] INT NOT NULL IDENTITY(1,1) CONSTRAINT pk_Orders PRIMARY KEY,
	[BasketID] INT NOT NULL CONSTRAINT fk_Orders_BasketID FOREIGN KEY REFERENCES Baskets(ID),
	[CustomerName] NVARCHAR(255) NOT NULL,
	[DeliveryAddress] NVARCHAR(512) NOT NULL,
	[CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT df_Orders_CreatedAt DEFAULT GETDATE()
)