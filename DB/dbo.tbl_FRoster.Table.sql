/****** Object:  Table [dbo].[tbl_FRoster]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FRoster](
	[RosterID] [bigint] NOT NULL,
	[WorkerID] [nvarchar](20) NOT NULL,
	[SupervisorId] [nvarchar](20) NOT NULL,
	[GrowerID] [nvarchar](20) NOT NULL,
	[MonitorID] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkerID] ASC,
	[GrowerID] ASC,
	[SupervisorId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
