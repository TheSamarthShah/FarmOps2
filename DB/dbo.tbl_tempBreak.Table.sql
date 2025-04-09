/****** Object:  Table [dbo].[tbl_tempBreak]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tempBreak](
	[breakID] [bigint] IDENTITY(1,1) NOT NULL,
	[WorkerID] [nvarchar](20) NULL,
	[RosterID] [bigint] NULL,
	[startTime] [time](7) NULL,
	[endTime] [time](7) NULL
) ON [PRIMARY]
GO
