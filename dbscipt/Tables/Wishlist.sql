USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[Wishlist]    Script Date: 3/7/2025 10:56:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Wishlist](
	[WishlistID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantityitems] [int] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Wishlist] PRIMARY KEY CLUSTERED 
(
	[WishlistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Wishlist] ADD  CONSTRAINT [DF_Wishlist_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[Wishlist] ADD  CONSTRAINT [DF_Wishlist_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK_Wishlist_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO

ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK_Wishlist_Item]
GO

ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK_Wishlist_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO

ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK_Wishlist_User]
GO

