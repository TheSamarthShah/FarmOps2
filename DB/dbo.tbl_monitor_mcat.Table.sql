/****** Object:  Table [dbo].[tbl_monitor_mcat]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_monitor_mcat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[AttendanceID] [int] NOT NULL,
	[MonitorID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_monitor_mcat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_monitor_mcat]  WITH CHECK ADD  CONSTRAINT [FK_tbl_monitor_mcat_tbl_monitor_mcat] FOREIGN KEY([ID])
REFERENCES [dbo].[tbl_monitor_mcat] ([ID])
GO
ALTER TABLE [dbo].[tbl_monitor_mcat] CHECK CONSTRAINT [FK_tbl_monitor_mcat_tbl_monitor_mcat]
GO
