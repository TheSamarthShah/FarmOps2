/****** Object:  Table [dbo].[tbl_jobapply]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_jobapply](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[jobid] [nvarchar](20) NULL,
	[workerid] [nvarchar](20) NULL,
	[resume] [nvarchar](max) NULL,
	[Detils] [nvarchar](max) NULL,
	[experience] [int] NULL,
	[sorted] [bit] NULL,
	[ishire] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
