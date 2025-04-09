/****** Object:  Table [dbo].[tbl_supervisor_reconc]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_supervisor_reconc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[lineid] [nvarchar](50) NOT NULL,
	[supervisorid] [nvarchar](50) NOT NULL,
	[last_recon] [datetime] NOT NULL
) ON [PRIMARY]
GO
