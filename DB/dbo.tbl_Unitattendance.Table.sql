/****** Object:  Table [dbo].[tbl_Unitattendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Unitattendance](
	[unitid] [bigint] NOT NULL,
	[rosterid] [bigint] NOT NULL,
	[start_time] [time](7) NULL,
	[end_time] [time](7) NULL,
	[Blockid] [nchar](10) NULL,
	[lineid] [nchar](10) NULL,
	[jobtype] [nvarchar](20) NULL,
	[payrate] [nchar](10) NULL,
	[no_bay] [decimal](6, 2) NULL,
	[starttimestamp] [nchar](10) NULL,
	[endtimestamp] [nchar](10) NULL,
	[pay] [decimal](6, 2) NULL,
	[Total_hours] [decimal](29, 17) NULL,
	[Rate_id] [bigint] NULL,
	[cat] [int] NULL,
 CONSTRAINT [PK_tbl_Unitattendance_unitid] PRIMARY KEY CLUSTERED 
(
	[unitid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_tbl_Unitattendance]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_Unitattendance] ON [dbo].[tbl_Unitattendance]
(
	[rosterid] ASC
)
INCLUDE([jobtype]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Unitattendance] ADD  DEFAULT (NULL) FOR [Rate_id]
GO
ALTER TABLE [dbo].[tbl_Unitattendance] ADD  DEFAULT (NULL) FOR [cat]
GO
