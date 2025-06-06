/****** Object:  Table [dbo].[tbl_global]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_global](
	[ID] [int] NOT NULL,
	[timestamp] [datetime] NULL,
	[com] [nvarchar](50) NULL,
	[string_point] [nvarchar](50) NULL,
	[monitorid] [nvarchar](50) NULL,
	[addr_stat_no] [nvarchar](50) NULL,
	[actAuth] [nvarchar](50) NULL,
	[monitorName] [nvarchar](50) NULL,
	[groupId] [nvarchar](50) NULL,
	[state] [nvarchar](50) NULL,
	[float_point] [nvarchar](50) NULL,
	[templateId] [nvarchar](50) NULL,
	[value] [nvarchar](50) NULL,
	[boxid] [nvarchar](50) NULL,
	[catid] [int] NULL
) ON [PRIMARY]
GO
