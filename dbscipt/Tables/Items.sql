USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[Item]    Script Date: 3/7/2025 10:52:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Item](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [text] NULL,
	[Cost] [decimal](10, 2) NOT NULL,
	[DiscountAmount] [decimal](10, 2) NOT NULL,
	[HasDiscount] [bit] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[BrandID] [int] NOT NULL,
	[Image] [varchar](max) NULL,
	[Quantity] [int] NOT NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_DiscountAmount]  DEFAULT ((0)) FOR [DiscountAmount]
GO

ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_HasDiscount]  DEFAULT ((0)) FOR [HasDiscount]
GO

ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_lookupItem] FOREIGN KEY([BrandID])
REFERENCES [dbo].[lookupItem] ([lookupitemID])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_lookupItem]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_lookupItem1] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[lookupItem] ([lookupitemID])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_lookupItem1]
GO

ALTER TABLE [dbo].[Item]  WITH NOCHECK ADD  CONSTRAINT [CK_Item] CHECK  (([cost]>=(0)))
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [CK_Item]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [CK_Item_1] CHECK  (([DiscountAmount]>=(0)))
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [CK_Item_1]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [CK_Item_2] CHECK  (([Quantity]>=(0)))
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [CK_Item_2]
GO

