/****** Object:  Table [dbo].[tbl_FJobCat]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FJobCat](
	[jobCatId] [int] NOT NULL,
	[jobCatName] [nvarchar](255) NULL,
	[growerId] [int] NULL,
	[details] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[jobCatId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
