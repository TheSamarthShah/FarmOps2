/****** Object:  Table [dbo].[tbl_GetNextNo]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_GetNextNo](
	[ColumnId] [int] IDENTITY(1,1) NOT NULL,
	[ColumnName] [nvarchar](255) NOT NULL,
	[TotalLength] [int] NOT NULL,
	[Prefix] [nvarchar](50) NULL,
	[NextNo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColumnId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
