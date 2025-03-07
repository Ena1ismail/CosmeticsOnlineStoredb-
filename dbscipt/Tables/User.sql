USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[User]    Script Date: 3/7/2025 10:55:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](150) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[Password] [varchar](150) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[ProfileImage] [varchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User] CHECK  (([PhoneNumber] like '07%' AND len([PhoneNumber])=(10)))
GO

ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User]
GO

ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User_1] CHECK  ((len([Password])>=(8)))
GO

ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User_1]
GO

ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User_2] CHECK  (([Email] like '_%@_%._%'))
GO

ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User_2]
GO

