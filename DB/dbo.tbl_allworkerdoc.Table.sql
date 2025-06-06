/****** Object:  Table [dbo].[tbl_allworkerdoc]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_allworkerdoc](
	[workerid] [nvarchar](20) NULL,
	[visa] [nvarchar](30) NULL,
	[passport] [nvarchar](20) NULL,
	[dl] [nvarchar](20) NULL,
	[healthnsafety] [nvarchar](20) NULL,
	[other] [nvarchar](200) NULL,
	[name] [nvarchar](30) NULL,
	[growerid] [nvarchar](20) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_allworkerdoc_growerid]    Script Date: 01-04-2025 23:02:30 ******/
CREATE CLUSTERED INDEX [IDX_tbl_allworkerdoc_growerid] ON [dbo].[tbl_allworkerdoc]
(
	[growerid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_allworkerdoc]  WITH CHECK ADD  CONSTRAINT [FK_tbl_allworkerdoc_growerid] FOREIGN KEY([growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_allworkerdoc] CHECK CONSTRAINT [FK_tbl_allworkerdoc_growerid]
GO
ALTER TABLE [dbo].[tbl_allworkerdoc]  WITH CHECK ADD  CONSTRAINT [FK_tbl_allworkerdoc_workerid] FOREIGN KEY([workerid])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_allworkerdoc] CHECK CONSTRAINT [FK_tbl_allworkerdoc_workerid]
GO
