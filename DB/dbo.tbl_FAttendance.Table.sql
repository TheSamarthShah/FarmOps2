/****** Object:  Table [dbo].[tbl_FAttendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FAttendance](
	[rosterId] [bigint] NOT NULL,
	[attendanceDate] [date] NOT NULL,
	[startTime] [time](7) NOT NULL,
	[endTime] [time](7) NOT NULL,
	[totalHours] [decimal](4, 2) NULL,
	[breakTime] [decimal](4, 2) NULL,
	[blockId] [int] NULL,
	[pay] [decimal](6, 2) NULL,
	[attendanceType] [nchar](10) NULL,
	[jobId] [int] NULL,
	[paidBreak] [int] NULL,
	[attendanceSignPic] [nvarchar](200) NULL,
	[lineId] [int] NULL,
	[jobPaid] [nvarchar](5) NULL,
	[remarks] [nvarchar](500) NULL,
	[appliedBy] [nvarchar](100) NULL,
	[approvedStatus] [nvarchar](5) NULL,
	[approvedBy] [nvarchar](100) NULL,
	[approvedDt] [datetime] NULL,
 CONSTRAINT [PK_tbl_FAttendance] PRIMARY KEY CLUSTERED 
(
	[rosterId] ASC,
	[attendanceDate] ASC,
	[startTime] ASC,
	[endTime] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
