USE [CosmeticStoreDb]
GO

/****** Object:  Table [dbo].[Lookuptypes]    Script Date: 3/7/2025 10:54:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Lookuptypes](
	[LookuptypeID] [int] IDENTITY(1,1) NOT NULL,
	[LookupName] [nvarchar](100) NOT NULL,
	[Createdby] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Updatedby] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Lookuptypes] PRIMARY KEY CLUSTERED 
(
	[LookuptypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Lookuptypes] ADD  CONSTRAINT [DF_Lookuptypes_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Lookuptypes] ADD  CONSTRAINT [DF_Lookuptypes_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

