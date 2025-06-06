/****** Object:  Table [dbo].[tbl_login]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_login](
	[Id] [nvarchar](20) NOT NULL,
	[email] [nvarchar](100) NULL,
	[password] [nvarchar](50) NULL,
	[type] [varchar](50) NULL,
	[password_change_status] [bit] NULL,
	[visaver] [int] NULL,
	[last_ip] [nvarchar](50) NULL,
	[last_login] [nvarchar](50) NULL,
	[issuper] [bit] NULL,
	[prmocode] [nvarchar](50) NULL,
	[register_date] [datetime] NULL,
	[industry_id] [int] NULL,
	[package] [int] NULL,
	[attendace_type] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_login]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_login] ON [dbo].[tbl_login]
(
	[email] ASC,
	[type] ASC,
	[password] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
