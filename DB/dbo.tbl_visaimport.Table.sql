/****** Object:  Table [dbo].[tbl_visaimport]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_visaimport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[First Name] [nchar](30) NULL,
	[Last Name] [nchar](30) NULL,
	[DOB] [date] NULL,
	[Passport Number] [nchar](20) NULL,
	[Visa Status] [nchar](40) NULL,
	[Visa Expiry Date] [date] NULL,
	[ird] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
