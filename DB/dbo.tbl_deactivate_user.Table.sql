/****** Object:  Table [dbo].[tbl_deactivate_user]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_deactivate_user](
	[growerid] [nvarchar](max) NULL,
	[workerid] [nvarchar](max) NULL,
	[day] [datetime] NULL,
	[admin] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
