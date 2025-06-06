/****** Object:  Table [dbo].[tmp_devart_tbl_blocks]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_devart_tbl_blocks](
	[BlockId] [int] IDENTITY(1,1) NOT NULL,
	[Block_Name] [nvarchar](50) NULL,
	[FarmId] [nvarchar](20) NULL,
	[bayrate] [money] NULL,
	[Rate_id] [bigint] NULL,
 CONSTRAINT [tmp_devart_PK_tbl_blocks_BlockId] PRIMARY KEY CLUSTERED 
(
	[BlockId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [KEY_tbl_blocks_BlockId]    Script Date: 01-04-2025 23:02:31 ******/
CREATE UNIQUE NONCLUSTERED INDEX [KEY_tbl_blocks_BlockId] ON [dbo].[tmp_devart_tbl_blocks]
(
	[BlockId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmp_devart_tbl_blocks] ADD  DEFAULT (NULL) FOR [Rate_id]
GO
