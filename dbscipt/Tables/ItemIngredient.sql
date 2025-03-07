USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[ItemIngredient]    Script Date: 3/7/2025 10:53:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ItemIngredient](
	[ItemIngredientID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[IngredientID] [int] NOT NULL,
	[Quantity] [decimal](5, 2) NOT NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_ItemIngredient] PRIMARY KEY CLUSTERED 
(
	[ItemIngredientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ItemIngredient] ADD  CONSTRAINT [DF_ItemIngredient_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ItemIngredient] ADD  CONSTRAINT [DF_ItemIngredient_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[ItemIngredient]  WITH CHECK ADD  CONSTRAINT [FK_ItemIngredient_Item] FOREIGN KEY([IngredientID])
REFERENCES [dbo].[Ingredients] ([ingredientId])
GO

ALTER TABLE [dbo].[ItemIngredient] CHECK CONSTRAINT [FK_ItemIngredient_Item]
GO

ALTER TABLE [dbo].[ItemIngredient]  WITH CHECK ADD  CONSTRAINT [CK_ItemIngredient] CHECK  (([Quantity]>(0)))
GO

ALTER TABLE [dbo].[ItemIngredient] CHECK CONSTRAINT [CK_ItemIngredient]
GO

