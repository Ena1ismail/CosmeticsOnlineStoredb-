USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[lookupItem]    Script Date: 3/7/2025 10:54:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[lookupItem](
	[lookupitemID] [int] IDENTITY(1,1) NOT NULL,
	[itemName] [nvarchar](50) NOT NULL,
	[lookuptypeid] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_lookupItem] PRIMARY KEY CLUSTERED 
(
	[lookupitemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[lookupItem] ADD  CONSTRAINT [DF_lookupItem_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[lookupItem] ADD  CONSTRAINT [DF_lookupItem_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[lookupItem]  WITH CHECK ADD  CONSTRAINT [FK_lookupItem_lookupItem] FOREIGN KEY([lookuptypeid])
REFERENCES [dbo].[Lookuptypes] ([LookuptypeID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[lookupItem] CHECK CONSTRAINT [FK_lookupItem_lookupItem]
GO

