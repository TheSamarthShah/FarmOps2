/****** Object:  Table [dbo].[tbl_worker_tranning]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_worker_tranning](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[workerid] [nvarchar](20) NULL,
	[catid] [nchar](10) NULL,
	[1] [bit] NULL,
	[2] [bit] NULL,
	[3] [bit] NULL,
	[4] [bit] NULL,
	[5] [bit] NULL,
	[6] [bit] NULL,
	[7] [bit] NULL,
	[8] [bit] NULL,
	[9] [bit] NULL,
	[10] [bit] NULL,
	[11] [bit] NULL,
	[12] [bit] NULL,
	[13] [bit] NULL,
	[14] [bit] NULL,
	[15] [bit] NULL,
	[16] [bit] NULL,
	[t_id] [nvarchar](20) NULL,
	[t_date] [date] NULL,
	[doc] [nvarchar](max) NULL,
	[growerid] [nvarchar](20) NULL,
	[doc_name] [nvarchar](200) NULL,
	[conducted_by] [nvarchar](50) NULL,
	[17] [bit] NULL,
	[18] [bit] NULL,
	[19] [bit] NULL,
	[20] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_worker_tranning_workerid]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_worker_tranning_workerid] ON [dbo].[tbl_worker_tranning]
(
	[workerid] ASC,
	[growerid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_worker_tranning]  WITH CHECK ADD  CONSTRAINT [FK_tbl_worker_tranning_growerid] FOREIGN KEY([growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_worker_tranning] CHECK CONSTRAINT [FK_tbl_worker_tranning_growerid]
GO
ALTER TABLE [dbo].[tbl_worker_tranning]  WITH CHECK ADD  CONSTRAINT [FK_tbl_worker_tranning_t_id] FOREIGN KEY([t_id])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_worker_tranning] CHECK CONSTRAINT [FK_tbl_worker_tranning_t_id]
GO
ALTER TABLE [dbo].[tbl_worker_tranning]  WITH CHECK ADD  CONSTRAINT [FK_tbl_worker_tranning_workerid] FOREIGN KEY([workerid])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_worker_tranning] CHECK CONSTRAINT [FK_tbl_worker_tranning_workerid]
GO
