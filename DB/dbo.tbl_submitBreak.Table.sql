/****** Object:  Table [dbo].[tbl_submitBreak]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_submitBreak](
	[breakID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [nvarchar](255) NULL,
	[RosterID] [bigint] NULL,
	[startTime] [time](7) NULL,
	[endTime] [time](7) NULL,
	[paid_break] [binary](1) NULL,
	[breakin] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_submitBreak_breakID] PRIMARY KEY CLUSTERED 
(
	[breakID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_submitBreak]  WITH CHECK ADD  CONSTRAINT [FK_tbl_submitBreak_RosterID] FOREIGN KEY([RosterID])
REFERENCES [dbo].[tbl_Duty] ([RosterID])
GO
ALTER TABLE [dbo].[tbl_submitBreak] CHECK CONSTRAINT [FK_tbl_submitBreak_RosterID]
GO
