USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[OrderItem]    Script Date: 3/7/2025 10:55:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OrderItem](
	[OrderItemID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[itemid] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ItemPrice] [decimal](10, 2) NOT NULL,
	[subtotal] [decimal](10, 2) NOT NULL,
	[DiscountApplied] [int] NOT NULL,
	[Rating] [int] NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF_OrderItem_DiscountApplied]  DEFAULT ((0)) FOR [DiscountApplied]
GO

ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF_OrderItem_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF_OrderItem_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Item] FOREIGN KEY([itemid])
REFERENCES [dbo].[Item] ([ItemID])
GO

ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Item]
GO

ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_OrderItem] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO

ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_OrderItem]
GO

ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [CK_OrderItem] CHECK  (([ItemPrice]>(0)))
GO

ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [CK_OrderItem]
GO

ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [CK_OrderItem_1] CHECK  (([Quantity]>(0)))
GO

ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [CK_OrderItem_1]
GO

ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [CK_OrderItem_2] CHECK  (([subtotal]>(0)))
GO

ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [CK_OrderItem_2]
GO

ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [CK_OrderItem_3] CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO

ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [CK_OrderItem_3]
GO

