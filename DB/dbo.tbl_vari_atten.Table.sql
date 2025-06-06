/****** Object:  Table [dbo].[tbl_vari_atten]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_vari_atten](
	[rosterid] [nvarchar](max) NULL,
	[varietiesid] [nchar](10) NULL,
	[rate] [decimal](9, 2) NULL,
	[unit] [decimal](9, 2) NULL,
	[unit_id] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_vari_atten]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_vari_atten] ON [dbo].[tbl_vari_atten]
(
	[unit_id] ASC,
	[varietiesid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_vari_atten]  WITH CHECK ADD  CONSTRAINT [FK_tbl_vari_atten_unit_id] FOREIGN KEY([unit_id])
REFERENCES [dbo].[tbl_Unitattendance] ([unitid])
GO
ALTER TABLE [dbo].[tbl_vari_atten] CHECK CONSTRAINT [FK_tbl_vari_atten_unit_id]
GO
