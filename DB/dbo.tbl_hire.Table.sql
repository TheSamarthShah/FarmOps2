/****** Object:  Table [dbo].[tbl_hire]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_hire](
	[HireID] [int] IDENTITY(1,1) NOT NULL,
	[jobid] [nvarchar](20) NULL,
	[payrate] [decimal](18, 2) NULL,
	[hiredate] [nchar](10) NULL,
	[monday] [bit] NULL,
	[tuesday] [bit] NULL,
	[wednesday] [bit] NULL,
	[thursday] [bit] NULL,
	[friday] [bit] NULL,
	[saturday] [bit] NULL,
	[sunday] [bit] NULL,
	[worker_approve] [bit] NULL,
	[grower_sign] [datetime] NULL,
	[worker_sign] [datetime] NULL,
	[grower_sign_path] [nvarchar](200) NULL,
	[worker_sign_path] [nvarchar](200) NULL,
	[grower_contract_path] [nvarchar](200) NULL,
	[worker_contract_path] [nvarchar](200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_tbl_hire]    Script Date: 01-04-2025 23:02:30 ******/
CREATE UNIQUE CLUSTERED INDEX [UK_tbl_hire] ON [dbo].[tbl_hire]
(
	[HireID] ASC,
	[jobid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
