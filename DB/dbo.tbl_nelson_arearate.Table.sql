/****** Object:  Table [dbo].[tbl_nelson_arearate]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_nelson_arearate](
	[areaid] [int] IDENTITY(1,1) NOT NULL,
	[growerid] [nvarchar](20) NULL,
	[name] [nvarchar](max) NULL,
	[rate] [decimal](9, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[areaid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
