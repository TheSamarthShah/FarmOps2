/****** Object:  Table [dbo].[tbl_supercontractor]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_supercontractor](
	[id] [bigint] NULL,
	[contractorid] [nvarchar](20) NULL,
	[scontractorid] [nvarchar](20) NULL,
	[monitorid] [nvarchar](20) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_supercontractor]  WITH CHECK ADD  CONSTRAINT [FK_tbl_supercontractor_contractorid] FOREIGN KEY([contractorid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_supercontractor] CHECK CONSTRAINT [FK_tbl_supercontractor_contractorid]
GO
ALTER TABLE [dbo].[tbl_supercontractor]  WITH CHECK ADD  CONSTRAINT [FK_tbl_supercontractor_monitorid] FOREIGN KEY([monitorid])
REFERENCES [dbo].[tbl_monitor] ([MonitorsId])
GO
ALTER TABLE [dbo].[tbl_supercontractor] CHECK CONSTRAINT [FK_tbl_supercontractor_monitorid]
GO
ALTER TABLE [dbo].[tbl_supercontractor]  WITH CHECK ADD  CONSTRAINT [FK_tbl_supercontractor_scontractorid] FOREIGN KEY([scontractorid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_supercontractor] CHECK CONSTRAINT [FK_tbl_supercontractor_scontractorid]
GO
