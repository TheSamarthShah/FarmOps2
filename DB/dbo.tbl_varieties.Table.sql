/****** Object:  Table [dbo].[tbl_varieties]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_varieties](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[blockid] [int] NULL,
	[rate] [money] NULL,
 CONSTRAINT [PK_tbl_varieties_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IDX_tbl_varieties_blockid]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_varieties_blockid] ON [dbo].[tbl_varieties]
(
	[blockid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_varieties]  WITH CHECK ADD  CONSTRAINT [FK_tbl_varieties_blockid] FOREIGN KEY([blockid])
REFERENCES [dbo].[tbl_blocks] ([BlockId])
GO
ALTER TABLE [dbo].[tbl_varieties] CHECK CONSTRAINT [FK_tbl_varieties_blockid]
GO
