USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[Ingredients]    Script Date: 3/7/2025 10:51:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Ingredients](
	[ingredientId] [int] IDENTITY(1,1) NOT NULL,
	[ingredientName] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Updatedby] [varchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Ingredients] PRIMARY KEY CLUSTERED 
(
	[ingredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Ingredients]  WITH CHECK ADD  CONSTRAINT [CK_Ingredients] CHECK  (([Quantity]>(0)))
GO

ALTER TABLE [dbo].[Ingredients] CHECK CONSTRAINT [CK_Ingredients]
GO

