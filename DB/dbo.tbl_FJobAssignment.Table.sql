/****** Object:  Table [dbo].[tbl_FJobAssignment]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FJobAssignment](
	[jobId] [int] NOT NULL,
	[rosterId] [int] NOT NULL,
	[assignmentDate] [datetime] NULL,
	[assignedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[jobId] ASC,
	[rosterId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_FJobAssignment] ADD  DEFAULT (getdate()) FOR [assignmentDate]
GO
