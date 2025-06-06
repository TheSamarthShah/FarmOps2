/****** Object:  Table [dbo].[tbl_binattendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_binattendance](
	[rosterid] [bigint] NULL,
	[starttime] [time](7) NULL,
	[endtime] [time](7) NULL,
	[mode] [bit] NULL,
	[rate] [decimal](6, 2) NULL,
	[team] [int] NULL,
	[bin_name] [nvarchar](50) NULL,
	[pay] [money] NULL,
	[unit] [money] NULL,
	[bonus] [money] NULL,
	[penalty] [money] NULL,
	[rateid] [int] NULL,
	[blockid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_tbl_binattendance_rosterid]    Script Date: 01-04-2025 23:02:30 ******/
CREATE CLUSTERED INDEX [IDX_tbl_binattendance_rosterid] ON [dbo].[tbl_binattendance]
(
	[rosterid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
