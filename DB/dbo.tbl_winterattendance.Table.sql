/****** Object:  Table [dbo].[tbl_winterattendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_winterattendance](
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
	[totalbays] [decimal](9, 2) NULL,
	[note] [nvarchar](80) NULL,
	[recon_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[winterid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_winterattendance]  WITH CHECK ADD FOREIGN KEY([rosterid])
REFERENCES [dbo].[tbl_Attendance] ([RosterID])
GO
ALTER TABLE [dbo].[tbl_winterattendance]  WITH CHECK ADD FOREIGN KEY([rosterid])
REFERENCES [dbo].[tbl_Attendance] ([RosterID])
GO
