/****** Object:  Table [dbo].[tbl_pickingEmail]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pickingEmail](
	[workerid] [nvarchar](20) NULL,
	[growerid] [nvarchar](20) NULL,
	[date] [datetime] NULL,
	[id] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_tbl_pickingEmail_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_pickingEmail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pickingEmail_growerid] FOREIGN KEY([growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_pickingEmail] CHECK CONSTRAINT [FK_tbl_pickingEmail_growerid]
GO
ALTER TABLE [dbo].[tbl_pickingEmail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pickingEmail_workerid] FOREIGN KEY([workerid])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_pickingEmail] CHECK CONSTRAINT [FK_tbl_pickingEmail_workerid]
GO
