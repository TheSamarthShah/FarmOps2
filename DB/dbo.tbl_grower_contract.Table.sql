/****** Object:  Table [dbo].[tbl_grower_contract]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_grower_contract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[growerid] [nvarchar](20) NULL,
	[path] [nvarchar](max) NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_grower_contract_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_grower_contract_growerid]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_grower_contract_growerid] ON [dbo].[tbl_grower_contract]
(
	[growerid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_grower_contract]  WITH CHECK ADD  CONSTRAINT [FK_tbl_grower_contract_growerid] FOREIGN KEY([growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_grower_contract] CHECK CONSTRAINT [FK_tbl_grower_contract_growerid]
GO
