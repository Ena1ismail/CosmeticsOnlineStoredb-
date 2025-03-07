USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[ItemRequests]    Script Date: 3/7/2025 10:54:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ItemRequests](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[ReqDescription] [text] NULL,
	[QuantityRequested] [int] NOT NULL,
	[statuesID] [int] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ItemRequests] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ItemRequests] ADD  CONSTRAINT [DF_ItemRequests_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[ItemRequests] ADD  CONSTRAINT [DF_ItemRequests_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ItemRequests]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequests_User] FOREIGN KEY([statuesID])
REFERENCES [dbo].[lookupItem] ([lookupitemID])
GO

ALTER TABLE [dbo].[ItemRequests] CHECK CONSTRAINT [FK_ItemRequests_User]
GO

ALTER TABLE [dbo].[ItemRequests]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequests_User1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO

ALTER TABLE [dbo].[ItemRequests] CHECK CONSTRAINT [FK_ItemRequests_User1]
GO

ALTER TABLE [dbo].[ItemRequests]  WITH CHECK ADD  CONSTRAINT [CK_ItemRequests] CHECK  (([QuantityRequested]>(0)))
GO

ALTER TABLE [dbo].[ItemRequests] CHECK CONSTRAINT [CK_ItemRequests]
GO

