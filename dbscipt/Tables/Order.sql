USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[Order]    Script Date: 3/7/2025 10:55:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NOT NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[StatusID] [int] NOT NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_lookupItem] FOREIGN KEY([StatusID])
REFERENCES [dbo].[lookupItem] ([lookupitemID])
GO

ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_lookupItem]
GO

ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO

ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Order]
GO

ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([Userid])
REFERENCES [dbo].[User] ([UserID])
GO

ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO

ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [CK_Order] CHECK  (([TotalAmount]>(0)))
GO

ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [CK_Order]
GO

