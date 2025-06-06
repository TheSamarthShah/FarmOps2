/****** Object:  Table [dbo].[tbl_incident]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incident](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[workerid] [nvarchar](20) NULL,
	[location] [nvarchar](50) NULL,
	[ext_ref] [nvarchar](50) NULL,
	[incident_Details] [nvarchar](200) NULL,
	[actions_to_date] [nvarchar](200) NULL,
	[followuptodate] [nvarchar](200) NULL,
	[incident_type] [nvarchar](50) NULL,
	[con_type] [nvarchar](50) NULL,
	[likehood] [nvarchar](50) NULL,
	[inc_date] [datetime] NULL,
	[addedid] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_incident_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_incident]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_incident] ON [dbo].[tbl_incident]
(
	[workerid] ASC,
	[addedid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_incident]  WITH CHECK ADD  CONSTRAINT [FK_tbl_incident_workerid] FOREIGN KEY([workerid])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_incident] CHECK CONSTRAINT [FK_tbl_incident_workerid]
GO
