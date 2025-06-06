/****** Object:  Table [dbo].[tbl_farms]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_farms](
	[FarmId] [nvarchar](20) NOT NULL,
	[Farm_Name] [nvarchar](50) NULL,
	[GrowerID] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_farms_FarmId] PRIMARY KEY CLUSTERED 
(
	[FarmId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_farms_GrowerID]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_farms_GrowerID] ON [dbo].[tbl_farms]
(
	[GrowerID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
