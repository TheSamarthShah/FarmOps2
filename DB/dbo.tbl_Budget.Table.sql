/****** Object:  Table [dbo].[tbl_Budget]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Budget](
	[BudgetID] [int] IDENTITY(1,1) NOT NULL,
	[MonitorID] [nvarchar](20) NULL,
	[FarmID] [nvarchar](20) NULL,
	[McatID] [nvarchar](20) NULL,
	[ScatID] [nvarchar](20) NULL,
	[GrowerID] [nvarchar](20) NULL,
	[Note] [nvarchar](200) NULL,
	[Amount] [float] NULL,
	[TimeStamp] [datetime] NULL,
	[sdate] [date] NULL,
	[edate] [date] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_Budget]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_Budget] ON [dbo].[tbl_Budget]
(
	[MonitorID] ASC,
	[FarmID] ASC,
	[GrowerID] ASC,
	[sdate] ASC,
	[edate] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
