/****** Object:  Table [dbo].[tbl_bayattendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_bayattendance](
	[rosterid] [bigint] NOT NULL,
	[start_time] [time](7) NULL,
	[end_time] [time](7) NULL,
	[Blockid] [nchar](10) NULL,
	[lineid] [nchar](10) NULL,
	[jobtype] [nvarchar](50) NULL,
	[payrate] [nchar](10) NULL,
	[no_bay] [decimal](6, 2) NULL,
	[starttimestamp] [nchar](10) NULL,
	[endtimestamp] [nchar](10) NULL,
	[pay] [decimal](6, 2) NULL,
	[Total_hours] [decimal](29, 17) NULL,
	[Rate_id] [bigint] NULL,
	[cat] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_tbl_bayattendance_rosterid]    Script Date: 01-04-2025 23:02:30 ******/
CREATE CLUSTERED INDEX [IDX_tbl_bayattendance_rosterid] ON [dbo].[tbl_bayattendance]
(
	[rosterid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_tbl_bayattendance]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_bayattendance] ON [dbo].[tbl_bayattendance]
(
	[start_time] ASC,
	[end_time] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_bayattendance] ADD  DEFAULT (NULL) FOR [Rate_id]
GO
ALTER TABLE [dbo].[tbl_bayattendance] ADD  DEFAULT (NULL) FOR [cat]
GO
ALTER TABLE [dbo].[tbl_bayattendance]  WITH CHECK ADD  CONSTRAINT [FK_tbl_bayattendance_rosterid] FOREIGN KEY([rosterid])
REFERENCES [dbo].[tbl_Attendance] ([RosterID])
GO
ALTER TABLE [dbo].[tbl_bayattendance] CHECK CONSTRAINT [FK_tbl_bayattendance_rosterid]
GO
