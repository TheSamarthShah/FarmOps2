/****** Object:  Table [dbo].[tbl_employees]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_employees](
	[workersid] [nvarchar](20) NULL,
	[growersid] [nvarchar](20) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_employees]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_employees] ON [dbo].[tbl_employees]
(
	[workersid] ASC,
	[growersid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
