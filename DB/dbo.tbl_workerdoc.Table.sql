/****** Object:  Table [dbo].[tbl_workerdoc]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_workerdoc](
	[workerid] [nvarchar](20) NOT NULL,
	[visa] [nvarchar](50) NULL,
	[passport] [nvarchar](50) NULL,
	[dl] [nvarchar](50) NULL,
	[healthnsafety] [nvarchar](50) NULL,
	[other] [varchar](200) NULL,
	[name] [nvarchar](50) NULL,
	[growerid] [nvarchar](20) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_workerdoc]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_workerdoc] ON [dbo].[tbl_workerdoc]
(
	[workerid] ASC,
	[growerid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_workerdoc]  WITH CHECK ADD  CONSTRAINT [FK_tbl_workerdoc_growerid] FOREIGN KEY([growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_workerdoc] CHECK CONSTRAINT [FK_tbl_workerdoc_growerid]
GO
ALTER TABLE [dbo].[tbl_workerdoc]  WITH CHECK ADD  CONSTRAINT [FK_tbl_workerdoc_workerid] FOREIGN KEY([workerid])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_workerdoc] CHECK CONSTRAINT [FK_tbl_workerdoc_workerid]
GO
