/****** Object:  Table [dbo].[tbl_promoted]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_promoted](
	[GrowerId] [nvarchar](20) NULL,
	[WorkerId] [nvarchar](20) NULL,
	[DesignationFrom] [nvarchar](50) NULL,
	[DesignationTo] [nvarchar](50) NULL,
	[Timestamp] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_promoted]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_promoted] ON [dbo].[tbl_promoted]
(
	[GrowerId] ASC,
	[WorkerId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_promoted]  WITH CHECK ADD  CONSTRAINT [FK_tbl_promoted_GrowerId] FOREIGN KEY([GrowerId])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_promoted] CHECK CONSTRAINT [FK_tbl_promoted_GrowerId]
GO
