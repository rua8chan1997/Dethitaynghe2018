USE [master]
GO
/****** Object:  Database [session1]    Script Date: 1/4/2021 6:32:08 PM ******/
CREATE DATABASE [session1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'session1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\session1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'session1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\session1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [session1] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [session1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [session1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [session1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [session1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [session1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [session1] SET ARITHABORT OFF 
GO
ALTER DATABASE [session1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [session1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [session1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [session1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [session1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [session1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [session1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [session1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [session1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [session1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [session1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [session1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [session1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [session1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [session1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [session1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [session1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [session1] SET RECOVERY FULL 
GO
ALTER DATABASE [session1] SET  MULTI_USER 
GO
ALTER DATABASE [session1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [session1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [session1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [session1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [session1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'session1', N'ON'
GO
ALTER DATABASE [session1] SET QUERY_STORE = OFF
GO
USE [session1]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 1/4/2021 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Crash]    Script Date: 1/4/2021 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Crash](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[LogoutTime] [datetime] NOT NULL,
	[Mota] [nvarchar](250) NULL,
	[TypeError] [int] NULL,
	[Crasher] [bit] NOT NULL,
 CONSTRAINT [PK_Crash] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Offices]    Script Date: 1/4/2021 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offices](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Contact] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Office] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 1/4/2021 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/4/2021 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[OfficeID] [int] NULL,
	[Birthdate] [date] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([ID], [Name]) VALUES (1, N'Afghanistan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (2, N'Albania')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (3, N'Algeria')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (4, N'Andorra')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (5, N'Angola')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (6, N'Antigua & Deps')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (7, N'Argentina')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (8, N'Armenia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (9, N'Australia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (10, N'Austria')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (11, N'Azerbaijan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (12, N'Bahamas')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (13, N'Bahrain')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (14, N'Bangladesh')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (15, N'Barbados')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (16, N'Belarus')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (17, N'Belgium')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (18, N'Belize')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (19, N'Benin')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (20, N'Bhutan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (21, N'Bolivia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (22, N'Bosnia Herzegovina')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (23, N'Botswana')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (24, N'Brazil')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (25, N'Brunei')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (26, N'Bulgaria')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (27, N'Burkina')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (28, N'Burundi')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (29, N'Cambodia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (30, N'Cameroon')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (31, N'Canada')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (32, N'Cape Verde')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (33, N'Central African Rep')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (34, N'Chad')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (35, N'Chile')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (36, N'China')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (37, N'Colombia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (38, N'Comoros')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (39, N'Congo')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (40, N'Congo {Democratic Rep}')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (41, N'Costa Rica')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (42, N'Croatia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (43, N'Cuba')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (44, N'Cyprus')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (45, N'Czech Republic')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (46, N'Denmark')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (47, N'Djibouti')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (48, N'Dominica')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (49, N'Dominican Republic')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (50, N'East Timor')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (51, N'Ecuador')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (52, N'Egypt')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (53, N'El Salvador')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (54, N'Equatorial Guinea')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (55, N'Eritrea')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (56, N'Estonia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (57, N'Ethiopia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (58, N'Fiji')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (59, N'Finland')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (60, N'France')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (61, N'Gabon')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (62, N'Gambia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (63, N'Georgia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (64, N'Germany')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (65, N'Ghana')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (66, N'Greece')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (67, N'Grenada')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (68, N'Guatemala')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (69, N'Guinea')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (70, N'Guinea-Bissau')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (71, N'Guyana')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (72, N'Haiti')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (73, N'Honduras')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (74, N'Hungary')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (75, N'Iceland')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (76, N'India')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (77, N'Indonesia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (78, N'Iran')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (79, N'Iraq')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (80, N'Ireland {Republic}')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (81, N'Israel')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (82, N'Italy')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (83, N'Ivory Coast')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (84, N'Jamaica')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (85, N'Japan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (86, N'Jordan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (87, N'Kazakhstan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (88, N'Kenya')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (89, N'Kiribati')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (90, N'Korea North')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (91, N'Korea South')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (92, N'Kosovo')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (93, N'Kuwait')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (94, N'Kyrgyzstan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (95, N'Laos')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (96, N'Latvia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (97, N'Lebanon')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (98, N'Lesotho')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (99, N'Liberia')
GO
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (100, N'Libya')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (101, N'Liechtenstein')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (102, N'Lithuania')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (103, N'Luxembourg')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (104, N'Macedonia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (105, N'Madagascar')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (106, N'Malawi')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (107, N'Malaysia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (108, N'Maldives')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (109, N'Mali')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (110, N'Malta')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (111, N'Marshall Islands')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (112, N'Mauritania')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (113, N'Mauritius')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (114, N'Mexico')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (115, N'Micronesia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (116, N'Moldova')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (117, N'Monaco')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (118, N'Mongolia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (119, N'Montenegro')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (120, N'Morocco')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (121, N'Mozambique')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (122, N'Myanmar, {Burma}')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (123, N'Namibia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (124, N'Nauru')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (125, N'Nepal')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (126, N'Netherlands')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (127, N'New Zealand')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (128, N'Nicaragua')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (129, N'Niger')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (130, N'Nigeria')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (131, N'Norway')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (132, N'Oman')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (133, N'Pakistan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (134, N'Palau')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (135, N'Panama')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (136, N'Papua New Guinea')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (137, N'Paraguay')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (138, N'Peru')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (139, N'Philippines')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (140, N'Poland')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (141, N'Portugal')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (142, N'Qatar')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (143, N'Romania')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (144, N'Russian Federation')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (145, N'Rwanda')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (146, N'St Kitts & Nevis')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (147, N'St Lucia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (148, N'Saint Vincent & the Grenadines')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (149, N'Samoa')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (150, N'San Marino')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (151, N'Sao Tome & Principe')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (152, N'Saudi Arabia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (153, N'Senegal')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (154, N'Serbia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (155, N'Seychelles')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (156, N'Sierra Leone')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (157, N'Singapore')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (158, N'Slovakia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (159, N'Slovenia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (160, N'Solomon Islands')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (161, N'Somalia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (162, N'South Africa')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (163, N'South Sudan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (164, N'Spain')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (165, N'Sri Lanka')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (166, N'Sudan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (167, N'Suriname')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (168, N'Swaziland')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (169, N'Sweden')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (170, N'Switzerland')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (171, N'Syria')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (172, N'Taiwan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (173, N'Tajikistan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (174, N'Tanzania')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (175, N'Thailand')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (176, N'Togo')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (177, N'Tonga')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (178, N'Trinidad & Tobago')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (179, N'Tunisia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (180, N'Turkey')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (181, N'Turkmenistan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (182, N'Tuvalu')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (183, N'Uganda')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (184, N'Ukraine')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (185, N'United Arab Emirates')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (186, N'United Kingdom')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (187, N'United States')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (188, N'Uruguay')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (189, N'Uzbekistan')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (190, N'Vanuatu')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (191, N'Vatican City')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (192, N'Venezuela')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (193, N'Vietnam')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (194, N'Yemen')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (195, N'Zambia')
INSERT [dbo].[Countries] ([ID], [Name]) VALUES (196, N'Zimbabwe')
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[Crash] ON 

INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (1, 1, CAST(N'2020-12-13T23:17:15.250' AS DateTime), CAST(N'2020-12-13T23:19:18.450' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (2, 1, CAST(N'2020-12-13T23:19:46.520' AS DateTime), CAST(N'2020-12-13T23:20:52.843' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (3, 2, CAST(N'2020-12-13T23:22:09.367' AS DateTime), CAST(N'2020-12-13T23:22:22.790' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (4, 3, CAST(N'2020-12-13T23:22:31.430' AS DateTime), CAST(N'2020-12-13T23:22:31.430' AS DateTime), N'chiu', 2, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (5, 3, CAST(N'2020-12-13T23:23:32.660' AS DateTime), CAST(N'2020-12-13T23:23:53.213' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (6, 3, CAST(N'2020-12-13T23:24:00.747' AS DateTime), CAST(N'2020-12-13T23:24:16.863' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (7, 2, CAST(N'2020-12-13T23:25:51.370' AS DateTime), CAST(N'2020-12-13T23:26:02.300' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (8, 3, CAST(N'2020-12-13T23:26:10.810' AS DateTime), CAST(N'2020-12-13T23:27:14.997' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (9, 2, CAST(N'2020-12-13T23:27:45.523' AS DateTime), CAST(N'2020-12-13T23:27:45.523' AS DateTime), N'check gridview', 1, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (10, 2, CAST(N'2020-12-13T23:29:18.497' AS DateTime), CAST(N'2020-12-13T23:29:50.463' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (11, 2, CAST(N'2020-12-13T23:41:55.473' AS DateTime), CAST(N'2020-12-13T23:41:55.473' AS DateTime), N'chắc tại quên', 2, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (12, 2, CAST(N'2020-12-14T00:12:13.257' AS DateTime), CAST(N'2020-12-14T00:13:38.617' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (13, 3, CAST(N'2020-12-14T00:13:47.687' AS DateTime), CAST(N'2020-12-14T00:14:00.103' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (14, 2, CAST(N'2020-12-14T00:19:52.193' AS DateTime), CAST(N'2020-12-14T00:21:03.327' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (15, 2, CAST(N'2020-12-14T00:23:15.167' AS DateTime), CAST(N'2020-12-14T00:24:03.927' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (16, 2, CAST(N'2020-12-14T00:26:21.547' AS DateTime), CAST(N'2020-12-14T00:26:36.307' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (17, 2, CAST(N'2020-12-14T00:32:32.857' AS DateTime), CAST(N'2020-12-14T00:34:13.360' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (18, 2, CAST(N'2020-12-14T00:36:28.090' AS DateTime), CAST(N'2020-12-14T00:37:12.803' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (19, 2, CAST(N'2020-12-14T00:45:20.970' AS DateTime), CAST(N'2020-12-14T00:49:29.987' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (20, 2, CAST(N'2020-12-14T00:52:54.627' AS DateTime), CAST(N'2020-12-14T00:53:42.633' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (21, 2, CAST(N'2020-12-14T00:54:43.697' AS DateTime), CAST(N'2020-12-14T00:56:28.593' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (22, 6, CAST(N'2020-12-14T00:56:41.223' AS DateTime), CAST(N'2020-12-14T00:57:07.407' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (23, 3, CAST(N'2020-12-14T01:03:46.380' AS DateTime), CAST(N'2020-12-14T01:04:38.930' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (24, 3, CAST(N'2020-12-14T01:04:50.610' AS DateTime), CAST(N'2020-12-14T01:05:05.490' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (25, 2, CAST(N'2020-12-14T04:01:26.127' AS DateTime), CAST(N'2020-12-14T04:01:36.813' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (26, 2, CAST(N'2020-12-14T04:44:56.033' AS DateTime), CAST(N'2020-12-14T04:45:44.420' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (27, 2, CAST(N'2020-12-14T05:03:46.077' AS DateTime), CAST(N'2020-12-14T05:04:11.047' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (28, 2, CAST(N'2020-12-14T08:47:25.520' AS DateTime), CAST(N'2020-12-14T08:47:25.520' AS DateTime), N'abc', 2, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (29, 2, CAST(N'2020-12-14T08:49:10.883' AS DateTime), CAST(N'2020-12-14T08:51:27.913' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (30, 2, CAST(N'2020-12-14T08:54:38.933' AS DateTime), CAST(N'2020-12-14T08:55:41.330' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (31, 2, CAST(N'2020-12-14T13:31:58.050' AS DateTime), CAST(N'2020-12-14T13:31:58.050' AS DateTime), N'adadasd', 2, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (32, 2, CAST(N'2020-12-14T13:35:03.983' AS DateTime), CAST(N'2020-12-14T13:35:03.983' AS DateTime), N'quên', 1, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (33, 5, CAST(N'2020-12-15T18:11:52.570' AS DateTime), CAST(N'2020-12-15T18:11:58.273' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (34, 3, CAST(N'2020-12-15T18:12:12.030' AS DateTime), CAST(N'2020-12-15T18:12:40.460' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (35, 2, CAST(N'2020-12-25T23:17:50.927' AS DateTime), CAST(N'2020-12-25T23:18:00.573' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (36, 3, CAST(N'2020-12-25T23:18:08.033' AS DateTime), CAST(N'2020-12-25T23:18:30.113' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (37, 2, CAST(N'2021-01-03T10:39:59.860' AS DateTime), CAST(N'2021-01-03T10:40:51.517' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (38, 3, CAST(N'2021-01-03T10:41:02.950' AS DateTime), CAST(N'2021-01-03T10:41:29.920' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (39, 2, CAST(N'2021-01-04T13:37:52.507' AS DateTime), CAST(N'2021-01-04T13:37:56.940' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Crash] ([ID], [UserID], [LoginTime], [LogoutTime], [Mota], [TypeError], [Crasher]) VALUES (40, 3, CAST(N'2021-01-04T13:38:07.300' AS DateTime), CAST(N'2021-01-04T13:38:18.693' AS DateTime), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Crash] OFF
GO
SET IDENTITY_INSERT [dbo].[Offices] ON 

INSERT [dbo].[Offices] ([ID], [CountryID], [Title], [Phone], [Contact]) VALUES (1, 185, N'Abu dhabi', N'638-757-8582
', N'MIchael Malki')
INSERT [dbo].[Offices] ([ID], [CountryID], [Title], [Phone], [Contact]) VALUES (3, 52, N'Cairo', N'252-224-8525', N'David Johns')
INSERT [dbo].[Offices] ([ID], [CountryID], [Title], [Phone], [Contact]) VALUES (4, 13, N'Bahrain', N'542-227-5825', N'Katie Ballmer')
INSERT [dbo].[Offices] ([ID], [CountryID], [Title], [Phone], [Contact]) VALUES (5, 142, N'Doha', N'758-278-9597', N'Ariel Levy')
INSERT [dbo].[Offices] ([ID], [CountryID], [Title], [Phone], [Contact]) VALUES (6, 152, N'Riyadh', N'285-285-1474', N'Andrew Hobart')
SET IDENTITY_INSERT [dbo].[Offices] OFF
GO
INSERT [dbo].[Roles] ([ID], [Title]) VALUES (1, N'Administrator')
INSERT [dbo].[Roles] ([ID], [Title]) VALUES (2, N'User')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [RoleID], [Email], [Password], [FirstName], [LastName], [OfficeID], [Birthdate], [Active]) VALUES (1, 1, N'abcd', N'123', N'Trang', N'Thu', 3, CAST(N'2000-12-10' AS Date), 0)
INSERT [dbo].[Users] ([ID], [RoleID], [Email], [Password], [FirstName], [LastName], [OfficeID], [Birthdate], [Active]) VALUES (2, 1, N'user2', N'202CB962AC59075B964B07152D234B70', N'Luc', N'Ngo', 1, CAST(N'2015-01-01' AS Date), 1)
INSERT [dbo].[Users] ([ID], [RoleID], [Email], [Password], [FirstName], [LastName], [OfficeID], [Birthdate], [Active]) VALUES (3, 2, N'user3', N'202CB962AC59075B964B07152D234B70', N'Da', N'Duong', 1, CAST(N'2020-12-13' AS Date), 1)
INSERT [dbo].[Users] ([ID], [RoleID], [Email], [Password], [FirstName], [LastName], [OfficeID], [Birthdate], [Active]) VALUES (4, 2, N'user4', N'202CB962AC59075B964B07152D234B70', N'A', N'Nguyen', 6, CAST(N'2010-12-14' AS Date), 1)
INSERT [dbo].[Users] ([ID], [RoleID], [Email], [Password], [FirstName], [LastName], [OfficeID], [Birthdate], [Active]) VALUES (5, 2, N'user5', N'202CB962AC59075B964B07152D234B70', N'B', N'Nguyen', 5, CAST(N'2019-12-14' AS Date), 1)
INSERT [dbo].[Users] ([ID], [RoleID], [Email], [Password], [FirstName], [LastName], [OfficeID], [Birthdate], [Active]) VALUES (6, 1, N'user6', N'202CB962AC59075B964B07152D234B70', N'C', N'Nguyen', 5, CAST(N'2010-12-14' AS Date), 0)
INSERT [dbo].[Users] ([ID], [RoleID], [Email], [Password], [FirstName], [LastName], [OfficeID], [Birthdate], [Active]) VALUES (7, 2, N'user7', N'202CB962AC59075B964B07152D234B70', N'E', N'Nguyen', 1, CAST(N'2014-01-14' AS Date), 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Crash]  WITH CHECK ADD  CONSTRAINT [FK_Crash_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Crash] CHECK CONSTRAINT [FK_Crash_User]
GO
ALTER TABLE [dbo].[Offices]  WITH CHECK ADD  CONSTRAINT [FK_Office_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([ID])
GO
ALTER TABLE [dbo].[Offices] CHECK CONSTRAINT [FK_Office_Country]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Offices] FOREIGN KEY([OfficeID])
REFERENCES [dbo].[Offices] ([ID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Offices]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
USE [master]
GO
ALTER DATABASE [session1] SET  READ_WRITE 
GO
