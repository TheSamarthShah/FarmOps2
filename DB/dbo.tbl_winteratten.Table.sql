/****** Object:  Table [dbo].[tbl_winteratten]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_winteratten](
	[rosterid] [bigint] NULL,
	[winterid] [bigint] NULL,
	[areaid] [int] NULL,
	[rate] [decimal](9, 2) NULL,
	[unit] [decimal](9, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_winteratten]  WITH CHECK ADD FOREIGN KEY([areaid])
REFERENCES [dbo].[tbl_arearate] ([areaid])
GO
ALTER TABLE [dbo].[tbl_winteratten]  WITH CHECK ADD FOREIGN KEY([areaid])
REFERENCES [dbo].[tbl_arearate] ([areaid])
GO
ALTER TABLE [dbo].[tbl_winteratten]  WITH CHECK ADD FOREIGN KEY([rosterid])
REFERENCES [dbo].[tbl_Attendance] ([RosterID])
GO
ALTER TABLE [dbo].[tbl_winteratten]  WITH CHECK ADD FOREIGN KEY([rosterid])
REFERENCES [dbo].[tbl_Attendance] ([RosterID])
GO
ALTER TABLE [dbo].[tbl_winteratten]  WITH CHECK ADD FOREIGN KEY([winterid])
REFERENCES [dbo].[tbl_winterattendance] ([winterid])
GO
ALTER TABLE [dbo].[tbl_winteratten]  WITH CHECK ADD FOREIGN KEY([winterid])
REFERENCES [dbo].[tbl_winterattendance] ([winterid])
GO
