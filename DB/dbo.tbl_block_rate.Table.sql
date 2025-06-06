/****** Object:  Table [dbo].[tbl_block_rate]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_block_rate](
	[blockid] [int] NULL,
	[Growerid] [nvarchar](20) NULL,
	[pay_code] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_tbl_block_rate]    Script Date: 01-04-2025 23:02:30 ******/
CREATE UNIQUE CLUSTERED INDEX [UK_tbl_block_rate] ON [dbo].[tbl_block_rate]
(
	[blockid] ASC,
	[Growerid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_block_rate]  WITH CHECK ADD  CONSTRAINT [FK_tbl_block_rate_blockid] FOREIGN KEY([blockid])
REFERENCES [dbo].[tmp_devart_tbl_blocks] ([BlockId])
GO
ALTER TABLE [dbo].[tbl_block_rate] CHECK CONSTRAINT [FK_tbl_block_rate_blockid]
GO
ALTER TABLE [dbo].[tbl_block_rate]  WITH CHECK ADD  CONSTRAINT [FK_tbl_block_rate_Growerid] FOREIGN KEY([Growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_block_rate] CHECK CONSTRAINT [FK_tbl_block_rate_Growerid]
GO
