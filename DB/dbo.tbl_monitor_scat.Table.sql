/****** Object:  Table [dbo].[tbl_monitor_scat]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_monitor_scat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Mid] [int] NOT NULL,
	[JOB_CODE] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_monitor_scat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
