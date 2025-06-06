/****** Object:  Table [dbo].[tbl_nelson_winterattendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_nelson_winterattendance](
	[winterid] [bigint] NOT NULL,
	[rosterid] [bigint] NULL,
	[starttime] [time](7) NULL,
	[endtime] [time](7) NULL,
	[mode] [bit] NULL,
	[pay] [money] NULL,
	[blockid] [smallint] NULL,
	[lineid] [smallint] NULL,
	[rate] [decimal](6, 2) NULL,
	[starttimestamp] [nchar](10) NULL,
	[endtimestamp] [nchar](10) NULL,
	[cat] [int] NULL,
	[scat] [int] NULL,
	[total_hours] [int] NULL,
	[total_trees] [decimal](9, 2) NULL,
	[note] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[winterid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
