/****** Object:  Table [dbo].[tbl_workEvidence]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_workEvidence](
	[WorkEvId] [int] IDENTITY(0,1) NOT NULL,
	[title] [nchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkEvId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
