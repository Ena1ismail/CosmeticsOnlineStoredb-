USE [master]
GO
/****** Object:  Database [CosmeticStoreDb]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE DATABASE [CosmeticStoreDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cosmetics  store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cosmetics  store.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Cosmetics  store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cosmetics  store_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CosmeticStoreDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CosmeticStoreDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CosmeticStoreDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CosmeticStoreDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CosmeticStoreDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CosmeticStoreDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CosmeticStoreDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET RECOVERY FULL 
GO
ALTER DATABASE [CosmeticStoreDb] SET  MULTI_USER 
GO
ALTER DATABASE [CosmeticStoreDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CosmeticStoreDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CosmeticStoreDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CosmeticStoreDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CosmeticStoreDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CosmeticStoreDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CosmeticStoreDb', N'ON'
GO
ALTER DATABASE [CosmeticStoreDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [CosmeticStoreDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CosmeticStoreDb]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  Table [dbo].[lookupItem]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  View [dbo].[ActiveItemsView]    Script Date: 3/7/2025 10:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  VIEW [dbo].[ActiveItemsView] AS
SELECT 
    i.ItemID,
    i.Name AS ItemName,
    liCategory.itemName AS Category,  -- تصحيح العمود ليطابق بياناتك
    liBrand.itemName AS Brand,        -- تصحيح العمود ليطابق بياناتك
    i.Cost AS Price,
    i.DiscountAmount
FROM Item i
INNER JOIN LookupItem liCategory ON i.CategoryID = liCategory.LookupItemID
INNER JOIN LookupItem liBrand ON i.BrandID = liBrand.LookupItemID
WHERE i.Quantity > 0;
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  Table [dbo].[Wishlist]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  View [dbo].[CustomerWishlistView]    Script Date: 3/7/2025 10:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  VIEW [dbo].[CustomerWishlistView] AS
SELECT 
    w.UserID,
    u.FullName AS CustomerName,
    i.ItemID,
    i.Name AS ItemName,
    w.Quantityitems AS Quantity
FROM Wishlist w
INNER JOIN [User] u ON w.UserID = u.UserID
INNER JOIN Item i ON w.ItemID = i.ItemID;
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  View [dbo].[SalesSummaryView]    Script Date: 3/7/2025 10:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[SalesSummaryView] AS
SELECT 
    FORMAT(o.CreateDate, 'yyyy-MM') AS MonthYear,  -- استخراج الشهر والسنة فقط
    COUNT(o.OrderID) AS TotalOrders,  -- حساب عدد الطلبات في الشهر
    SUM(o.TotalAmount) AS TotalRevenue  -- حساب إجمالي الإيرادات
FROM [Order] o
GROUP BY FORMAT(o.CreateDate, 'yyyy-MM');
GO
/****** Object:  Table [dbo].[Ingredients]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  Table [dbo].[ItemIngredient]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  Table [dbo].[ItemRequests]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  Table [dbo].[Lookuptypes]    Script Date: 3/7/2025 10:58:53 PM ******/
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
/****** Object:  Table [dbo].[OrderItem]    Script Date: 3/7/2025 10:58:53 PM ******/
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
SET IDENTITY_INSERT [dbo].[Ingredients] ON 

INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (1, N'Aloe Vera', 100, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (2, N'Vitamin C', 50, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (3, N'Hyaluronic Acid', 70, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (4, N'Retinol', 30, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (5, N'Salicylic Acid', 40, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (6, N'Niacinamide', 60, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (7, N'Collagen', 80, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (8, N'Shea Butter', 90, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (9, N'Caffeine', 55, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
INSERT [dbo].[Ingredients] ([ingredientId], [ingredientName], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (10, N'Zinc Oxide', 45, N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime), N'Admin', CAST(N'2025-03-03T00:50:54.763' AS DateTime))
SET IDENTITY_INSERT [dbo].[Ingredients] OFF
GO
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (1, N'Hydrating Face Cream', N'Moisturizing cream for daily skincare.', CAST(29.99 AS Decimal(10, 2)), CAST(5.00 AS Decimal(10, 2)), 1, 1, 6, N'image1.jpg', 50, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (2, N'Vitamin C Serum', N'Brightening serum with Vitamin C for glowing skin.', CAST(19.99 AS Decimal(10, 2)), CAST(5.00 AS Decimal(10, 2)), 1, 1, 8, N'image2.jpg', 37, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T11:09:55.997' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (3, N'Anti-Aging Night Cream', N'Night cream with retinol for fine lines.', CAST(39.99 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)), 1, 1, 9, N'image3.jpg', 35, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (4, N'Exfoliating Face Scrub', N'Gentle exfoliating scrub for all skin types.', CAST(15.99 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), 0, 1, 7, N'image4.jpg', 60, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (5, N'Sunscreen SPF 50+', N'Broad-spectrum sunscreen with SPF 50+', CAST(24.99 AS Decimal(10, 2)), CAST(2.50 AS Decimal(10, 2)), 1, 1, 10, N'image5.jpg', 80, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (6, N'Aloe Vera Gel', N'Cooling and soothing aloe vera gel.', CAST(12.99 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), 0, 1, 6, N'image6.jpg', 70, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (7, N'Lip Balm Set', N'Hydrating lip balm set with natural oils.', CAST(9.99 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), 1, 2, 7, N'image7.jpg', 100, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (8, N'Charcoal Face Mask', N'Deep cleansing face mask with activated charcoal.', CAST(17.99 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), 1, 1, 8, N'image8.jpg', 45, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (9, N'Collagen Eye Cream', N'Hydrating eye cream with collagen.', CAST(22.99 AS Decimal(10, 2)), CAST(3.50 AS Decimal(10, 2)), 1, 1, 9, N'image9.jpg', 30, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
INSERT [dbo].[Item] ([ItemID], [Name], [Description], [Cost], [DiscountAmount], [HasDiscount], [CategoryID], [BrandID], [Image], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (10, N'Organic Rose Water', N'Natural rose water toner for hydration.', CAST(14.99 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), 0, 1, 11, N'image10.jpg', 55, N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime), N'Admin', CAST(N'2025-03-03T01:17:57.380' AS DateTime))
SET IDENTITY_INSERT [dbo].[Item] OFF
GO
SET IDENTITY_INSERT [dbo].[ItemIngredient] ON 

INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (1, 1, 1, CAST(10.00 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (2, 2, 2, CAST(5.00 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (3, 3, 3, CAST(7.50 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (4, 4, 4, CAST(3.00 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (5, 5, 5, CAST(4.00 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (6, 6, 6, CAST(6.00 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (7, 7, 7, CAST(8.00 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (8, 8, 8, CAST(2.50 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (9, 9, 9, CAST(9.00 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
INSERT [dbo].[ItemIngredient] ([ItemIngredientID], [ItemID], [IngredientID], [Quantity], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (10, 10, 10, CAST(5.50 AS Decimal(5, 2)), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime), N'Admin', CAST(N'2025-03-03T01:36:14.420' AS DateTime))
SET IDENTITY_INSERT [dbo].[ItemIngredient] OFF
GO
SET IDENTITY_INSERT [dbo].[ItemRequests] ON 

INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (1, 1, N'Vitamin C Serum', N'Brightening serum request.', 5, 12, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (2, 2, N'Aloe Vera Gel', N'Requesting bulk purchase.', 10, 12, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (3, 3, N'Charcoal Face Mask', N'Looking for high-quality mask.', 3, 13, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (4, 4, N'Lip Balm Set', N'Need multiple shades.', 7, 12, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (5, 5, N'Hydrating Face Cream', N'Special order request.', 2, 13, CAST(N'2025-03-03T11:35:23.400' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (6, 6, N'Sunscreen SPF 50+', N'Wholesale purchase.', 20, 13, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (7, 7, N'Collagen Eye Cream', N'Urgent request.', 4, 12, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (8, 8, N'Exfoliating Face Scrub', N'Request for skin-care products.', 6, 12, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (9, 9, N'Neutrogena Face Wash', N'Looking for specific brand.', 5, 13, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
INSERT [dbo].[ItemRequests] ([RequestID], [UserID], [ProductName], [ReqDescription], [QuantityRequested], [statuesID], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (10, 10, N'Organic Rose Water', N'Requested for stock refill.', 8, 12, CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin', CAST(N'2025-03-03T02:14:59.240' AS DateTime), N'Admin')
SET IDENTITY_INSERT [dbo].[ItemRequests] OFF
GO
SET IDENTITY_INSERT [dbo].[lookupItem] ON 

INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (1, N'Skincare', 1, CAST(N'2025-03-02T22:45:52.373' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:45:52.373' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (2, N'Makeup', 1, CAST(N'2025-03-02T22:46:14.103' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:46:14.103' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (3, N'Haircare', 1, CAST(N'2025-03-02T22:46:39.943' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:46:39.943' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (4, N'Fragrances', 1, CAST(N'2025-03-02T22:47:21.010' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:47:21.010' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (5, N'Body Care', 1, CAST(N'2025-03-02T22:47:47.340' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:47:47.340' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (6, N'L''Oreal	', 2, CAST(N'2025-03-02T22:48:24.873' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:48:24.873' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (7, N'Nivea', 2, CAST(N'2025-03-02T22:48:50.827' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:48:50.827' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (8, N'Neutrogena', 2, CAST(N'2025-03-02T22:49:08.630' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:49:08.630' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (9, N'The Ordinary	', 2, CAST(N'2025-03-02T22:49:49.443' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:49:49.443' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (10, N'DDOVE', 2, CAST(N'2025-03-03T00:11:15.987' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-03T00:11:15.987' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (11, N'Garnier', 2, CAST(N'2025-03-02T22:50:12.550' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:50:12.550' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (12, N'Pending', 3, CAST(N'2025-03-02T22:50:38.013' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:50:38.013' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (13, N'Approved', 3, CAST(N'2025-03-02T22:51:00.023' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:51:00.023' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (14, N'Shipped', 3, CAST(N'2025-03-02T22:51:22.553' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:51:22.553' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (15, N'Delivered', 3, CAST(N'2025-03-02T22:51:33.510' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:51:33.510' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (16, N'Cancelled	', 3, CAST(N'2025-03-02T22:52:03.303' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-02T22:52:03.303' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (17, N'New Brand Name', 2, CAST(N'2025-03-03T00:01:26.920' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-03T00:01:26.920' AS DateTime))
INSERT [dbo].[lookupItem] ([lookupitemID], [itemName], [lookuptypeid], [CreateDate], [Updatedby], [Createdby], [UpdateDate]) VALUES (18, N'lesoshy', 2, CAST(N'2025-03-03T04:18:15.940' AS DateTime), N'Admin', N'Admin', CAST(N'2025-03-03T04:18:15.940' AS DateTime))
SET IDENTITY_INSERT [dbo].[lookupItem] OFF
GO
SET IDENTITY_INSERT [dbo].[Lookuptypes] ON 

INSERT [dbo].[Lookuptypes] ([LookuptypeID], [LookupName], [Createdby], [CreateDate], [UpdateDate], [Updatedby]) VALUES (1, N'Category', N'Admin', CAST(N'2025-03-02T22:24:47.150' AS DateTime), CAST(N'2025-03-02T22:24:47.150' AS DateTime), N'Admin')
INSERT [dbo].[Lookuptypes] ([LookuptypeID], [LookupName], [Createdby], [CreateDate], [UpdateDate], [Updatedby]) VALUES (2, N'Brand', N'Admin', CAST(N'2025-03-02T22:25:03.183' AS DateTime), CAST(N'2025-03-02T22:25:03.183' AS DateTime), N'Admin')
INSERT [dbo].[Lookuptypes] ([LookuptypeID], [LookupName], [Createdby], [CreateDate], [UpdateDate], [Updatedby]) VALUES (3, N'Status', N'Admin', CAST(N'2025-03-02T22:25:57.653' AS DateTime), CAST(N'2025-03-02T22:25:57.653' AS DateTime), N'Admin')
SET IDENTITY_INSERT [dbo].[Lookuptypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (1, 1, CAST(59.99 AS Decimal(10, 2)), 12, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (2, 2, CAST(89.50 AS Decimal(10, 2)), 13, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (3, 3, CAST(120.00 AS Decimal(10, 2)), 12, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (4, 4, CAST(45.75 AS Decimal(10, 2)), 15, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (5, 5, CAST(67.89 AS Decimal(10, 2)), 14, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (6, 6, CAST(99.99 AS Decimal(10, 2)), 12, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (7, 7, CAST(110.50 AS Decimal(10, 2)), 16, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (8, 8, CAST(75.20 AS Decimal(10, 2)), 13, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (9, 9, CAST(85.00 AS Decimal(10, 2)), 12, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [Userid], [TotalAmount], [StatusID], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (10, 10, CAST(49.99 AS Decimal(10, 2)), 14, N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime), N'Admin', CAST(N'2025-03-03T01:53:26.647' AS DateTime))
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItem] ON 

INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (1, 1, 1, 2, CAST(29.99 AS Decimal(10, 2)), CAST(59.98 AS Decimal(10, 2)), 5, 4, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (2, 2, 3, 1, CAST(39.99 AS Decimal(10, 2)), CAST(39.99 AS Decimal(10, 2)), 7, 5, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (3, 3, 5, 3, CAST(24.99 AS Decimal(10, 2)), CAST(74.97 AS Decimal(10, 2)), 2, 3, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (4, 4, 7, 2, CAST(9.99 AS Decimal(10, 2)), CAST(19.98 AS Decimal(10, 2)), 1, 4, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (5, 5, 9, 1, CAST(22.99 AS Decimal(10, 2)), CAST(22.99 AS Decimal(10, 2)), 3, 5, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (6, 6, 2, 4, CAST(19.99 AS Decimal(10, 2)), CAST(79.96 AS Decimal(10, 2)), 3, 4, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (7, 7, 4, 2, CAST(15.99 AS Decimal(10, 2)), CAST(31.98 AS Decimal(10, 2)), 0, 3, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (8, 8, 6, 1, CAST(12.99 AS Decimal(10, 2)), CAST(12.99 AS Decimal(10, 2)), 1, 5, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (9, 9, 8, 3, CAST(17.99 AS Decimal(10, 2)), CAST(53.97 AS Decimal(10, 2)), 2, 4, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (10, 10, 10, 2, CAST(14.99 AS Decimal(10, 2)), CAST(29.98 AS Decimal(10, 2)), 0, 3, N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime), N'Admin', CAST(N'2025-03-03T01:59:43.390' AS DateTime))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [itemid], [Quantity], [ItemPrice], [subtotal], [DiscountApplied], [Rating], [Createdby], [CreateDate], [Updatedby], [UpdateDate]) VALUES (11, 1, 2, 3, CAST(19.99 AS Decimal(10, 2)), CAST(59.97 AS Decimal(10, 2)), 0, NULL, N'Admin', CAST(N'2025-03-03T10:58:30.773' AS DateTime), N'Admin', CAST(N'2025-03-03T10:58:30.773' AS DateTime))
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (1, N'John Doe', N'johndoe@gmail.com', N'P@ssw0rd1', N'0781234567', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (2, N'Alice Smith', N'alice.smith@email.com', N'Alice@2024', N'0799876543', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (3, N'Robert Johnson', N'robert.j@cosmetic.com', N'R0b3rt!Pass', N'0786543210', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (4, N'Sarah Miller', N'sarah.miller@example.com', N'S@rah2023!', N'0791122334', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (5, N'David Brown', N'davidbrown@mail.net', N'D@v1dBrown', N'0785566778', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (6, N'Michael Lee', N'michael.lee@cosmetic.com', N'M1chaelLee@!', N'0793344556', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (7, N'Jessica White', N'jess.white@email.org', N'J3ssicaW@!', N'0786677889', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (8, N'Daniel Clark', N'danielc@domain.com', N'D@ni3lC123', N'0799988776', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (9, N'Emily Adams', N'emily.adams@beauty.com', N'Em1ly@dams', N'0781122334', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[User] ([UserID], [FullName], [Email], [Password], [PhoneNumber], [ProfileImage], [CreateDate], [UpdateDate], [Createdby], [Updatedby]) VALUES (10, N'William Harris', N'will.harris@email.net', N'W!lliamH22', N'0792211334', NULL, CAST(N'2025-03-01T02:13:02.803' AS DateTime), CAST(N'2025-03-01T02:13:02.803' AS DateTime), N'Admin', N'Admin')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[Wishlist] ON 

INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (1, 1, 3, 1, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (2, 2, 5, 2, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (3, 3, 7, 1, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (4, 4, 2, 3, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (5, 5, 8, 1, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (6, 6, 4, 2, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (7, 7, 9, 1, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (8, 8, 6, 1, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (9, 9, 10, 2, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
INSERT [dbo].[Wishlist] ([WishlistID], [UserID], [ItemID], [Quantityitems], [UpdateDate], [Createdby], [CreateDate], [Updatedby]) VALUES (10, 10, 1, 1, CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin', CAST(N'2025-03-03T02:08:00.810' AS DateTime), N'Admin')
SET IDENTITY_INSERT [dbo].[Wishlist] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Item]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Item] ON [dbo].[Item]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_lookupItem]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_lookupItem] ON [dbo].[lookupItem]
(
	[itemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Lookuptypes]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Lookuptypes] ON [dbo].[Lookuptypes]
(
	[LookupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_User] ON [dbo].[User]
(
	[FullName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_1]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_User_1] ON [dbo].[User]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_2]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_User_2] ON [dbo].[User]
(
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_3]    Script Date: 3/7/2025 10:58:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_User_3] ON [dbo].[User]
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_DiscountAmount]  DEFAULT ((0)) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_HasDiscount]  DEFAULT ((0)) FOR [HasDiscount]
GO
ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [DF_Item_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ItemIngredient] ADD  CONSTRAINT [DF_ItemIngredient_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ItemIngredient] ADD  CONSTRAINT [DF_ItemIngredient_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ItemRequests] ADD  CONSTRAINT [DF_ItemRequests_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ItemRequests] ADD  CONSTRAINT [DF_ItemRequests_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[lookupItem] ADD  CONSTRAINT [DF_lookupItem_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[lookupItem] ADD  CONSTRAINT [DF_lookupItem_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Lookuptypes] ADD  CONSTRAINT [DF_Lookuptypes_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Lookuptypes] ADD  CONSTRAINT [DF_Lookuptypes_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF_OrderItem_DiscountApplied]  DEFAULT ((0)) FOR [DiscountApplied]
GO
ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF_OrderItem_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF_OrderItem_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Wishlist] ADD  CONSTRAINT [DF_Wishlist_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Wishlist] ADD  CONSTRAINT [DF_Wishlist_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
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
ALTER TABLE [dbo].[ItemIngredient]  WITH CHECK ADD  CONSTRAINT [FK_ItemIngredient_Item] FOREIGN KEY([IngredientID])
REFERENCES [dbo].[Ingredients] ([ingredientId])
GO
ALTER TABLE [dbo].[ItemIngredient] CHECK CONSTRAINT [FK_ItemIngredient_Item]
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
ALTER TABLE [dbo].[lookupItem]  WITH CHECK ADD  CONSTRAINT [FK_lookupItem_lookupItem] FOREIGN KEY([lookuptypeid])
REFERENCES [dbo].[Lookuptypes] ([LookuptypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[lookupItem] CHECK CONSTRAINT [FK_lookupItem_lookupItem]
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
ALTER TABLE [dbo].[Ingredients]  WITH CHECK ADD  CONSTRAINT [CK_Ingredients] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Ingredients] CHECK CONSTRAINT [CK_Ingredients]
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
ALTER TABLE [dbo].[ItemIngredient]  WITH CHECK ADD  CONSTRAINT [CK_ItemIngredient] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[ItemIngredient] CHECK CONSTRAINT [CK_ItemIngredient]
GO
ALTER TABLE [dbo].[ItemRequests]  WITH CHECK ADD  CONSTRAINT [CK_ItemRequests] CHECK  (([QuantityRequested]>(0)))
GO
ALTER TABLE [dbo].[ItemRequests] CHECK CONSTRAINT [CK_ItemRequests]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [CK_Order] CHECK  (([TotalAmount]>(0)))
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [CK_Order]
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
/****** Object:  StoredProcedure [dbo].[AddItemToOrder]    Script Date: 3/7/2025 10:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddItemToOrder]
    @OrderID INT,
    @ItemID INT,
    @Quantity INT,
    @CreatedBy NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ItemPrice DECIMAL(10,2);
    DECLARE @StockAvailable INT;
    DECLARE @Subtotal DECIMAL(10,2);

    -- التحقق من توفر المنتج في المخزون
    SELECT @StockAvailable = Quantity, @ItemPrice = Cost
    FROM Item
    WHERE ItemID = @ItemID;

    -- إذا كان المخزون غير كافٍ، لا يمكن تنفيذ الطلب
    IF @StockAvailable < @Quantity
    BEGIN
        PRINT 'Error: Insufficient stock for this item!';
        RETURN;
    END

    -- حساب المجموع الفرعي للعنصر
    SET @Subtotal = @Quantity * @ItemPrice;

    -- إدخال العنصر في الطلب
    INSERT INTO OrderItem (OrderID, ItemID, Quantity, ItemPrice, Subtotal, CreatedBy, CreateDate, UpdatedBy, UpdateDate)
    VALUES (@OrderID, @ItemID, @Quantity, @ItemPrice, @Subtotal, @CreatedBy, GETDATE(), @CreatedBy, GETDATE());

    -- تحديث كمية المنتج في المخزون
    UPDATE Item
    SET Quantity = Quantity - @Quantity
    WHERE ItemID = @ItemID;

    PRINT 'Item successfully added to order!';
END;
GO
/****** Object:  StoredProcedure [dbo].[GenerateSalesReport]    Script Date: 3/7/2025 10:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateSalesReport]
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        i.ItemID,
        i.Name AS ItemName,
        SUM(oi.Quantity) AS TotalQuantitySold,
        SUM(oi.Subtotal) AS TotalRevenue,
        MIN(o.CreateDate) AS FirstSaleDate,
        MAX(o.CreateDate) AS LastSaleDate
    FROM OrderItem oi
    INNER JOIN Item i ON oi.ItemID = i.ItemID
    INNER JOIN [Order] o ON oi.OrderID = o.OrderID
    WHERE o.CreateDate BETWEEN @StartDate AND @EndDate
    GROUP BY i.ItemID, i.Name
    ORDER BY TotalRevenue DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[ManageDiscounts]    Script Date: 3/7/2025 10:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[ManageDiscounts]
    @ItemID INT = NULL,
    @CategoryID INT = NULL,
    @DiscountAmount DECIMAL(10,2),
    @UpdatedBy NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- التحقق من أن هناك قيمة صحيحة إما لـ ItemID أو CategoryID
    IF @ItemID IS NULL AND @CategoryID IS NULL
    BEGIN
        PRINT 'Error: You must provide either an ItemID or a CategoryID.';
        RETURN;
    END

    -- التحقق من أن الخصم غير سلبي
    IF @DiscountAmount < 0
    BEGIN
        PRINT 'Error: Discount amount must be a positive value.';
        RETURN;
    END

    -- تحديث الخصم لمنتج معين
    IF @ItemID IS NOT NULL
    BEGIN
        -- التأكد من أن الخصم لا يتجاوز سعر المنتج
        IF EXISTS (SELECT 1 FROM Item WHERE ItemID = @ItemID AND Cost < @DiscountAmount)
        BEGIN
            PRINT 'Error: Discount amount cannot exceed the product cost.';
            RETURN;
        END

        UPDATE Item
        SET DiscountAmount = @DiscountAmount,
            HasDiscount = CASE WHEN @DiscountAmount > 0 THEN 1 ELSE 0 END,
            UpdatedBy = @UpdatedBy,
            UpdateDate = GETDATE()
        WHERE ItemID = @ItemID;

        PRINT 'Discount successfully updated for the item.';
    END

    -- تحديث الخصم لجميع المنتجات في فئة معينة
    IF @CategoryID IS NOT NULL
    BEGIN
        -- التأكد من أن الخصم لا يتجاوز سعر أي منتج في هذه الفئة
        IF EXISTS (SELECT 1 FROM Item WHERE CategoryID = @CategoryID AND Cost < @DiscountAmount)
        BEGIN
            PRINT 'Error: Discount amount cannot exceed the cost of any product in this category.';
            RETURN;
        END

        UPDATE Item
        SET DiscountAmount = @DiscountAmount,
            HasDiscount = CASE WHEN @DiscountAmount > 0 THEN 1 ELSE 0 END,
            UpdatedBy = @UpdatedBy,
            UpdateDate = GETDATE()
        WHERE CategoryID = @CategoryID;

        PRINT 'Discount successfully updated for all items in the category.';
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcessItemRequest]    Script Date: 3/7/2025 10:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ProcessItemRequest]
    @RequestID INT,         
    @Action NVARCHAR(10),    
    @AdminUser NVARCHAR(50)  
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusApproved INT = 13; -- معرف الحالة 'Approved' في LookupItem
    DECLARE @StatusRejected INT = 14; -- معرف الحالة 'Rejected' في LookupItem

    -- التحقق من وجود الطلب في الجدول
    IF NOT EXISTS (SELECT 1 FROM ItemRequests WHERE RequestID = @RequestID)
    BEGIN
        PRINT 'Error: Request ID not found!';
        RETURN;
    END

    -- الموافقة على الطلب بدون إضافة المنتج إلى `Item`
    IF @Action = 'Approve'
    BEGIN
        -- تحديث حالة الطلب إلى "Approved"
        UPDATE ItemRequests
        SET statuesID = @StatusApproved, UpdatedBy = @AdminUser, UpdateDate = GETDATE()
        WHERE RequestID = @RequestID;

        PRINT 'Request approved successfully!';
    END
    ELSE IF @Action = 'Reject'
    BEGIN
        -- تحديث حالة الطلب إلى "Rejected"
        UPDATE ItemRequests
        SET statuesID = @StatusRejected, UpdatedBy = @AdminUser, UpdateDate = GETDATE()
        WHERE RequestID = @RequestID;

        PRINT 'Request rejected successfully!';
    END
    ELSE
    BEGIN
        PRINT 'Error: Invalid action. Use "Approve" or "Reject".';
        RETURN;
    END
END;
GO
USE [master]
GO
ALTER DATABASE [CosmeticStoreDb] SET  READ_WRITE 
GO
