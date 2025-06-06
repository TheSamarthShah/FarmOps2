/****** Object:  Table [dbo].[tbl_blocks]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_blocks](
	[BlockId] [int] NULL,
	[Block_Name] [nvarchar](50) NULL,
	[FarmId] [nvarchar](20) NOT NULL,
	[bayrate] [money] NULL,
	[Rate_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [KEY_tbl_blocks_BlockId]    Script Date: 01-04-2025 23:02:30 ******/
CREATE UNIQUE NONCLUSTERED INDEX [KEY_tbl_blocks_BlockId] ON [dbo].[tbl_blocks]
(
	[BlockId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
