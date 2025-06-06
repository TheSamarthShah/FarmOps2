/****** Object:  Table [dbo].[tbl_AppliedAttendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AppliedAttendance](
	[attendanceId] [bigint] NULL,
	[RosterID] [bigint] NOT NULL,
	[attendDate] [date] NOT NULL,
	[signinTime] [time](7) NULL,
	[signoutTime] [time](7) NULL,
	[totalWorkHours] [decimal](29, 17) NULL,
	[totalBreakHours] [decimal](29, 17) NULL,
	[breakIds] [nvarchar](max) NULL,
	[pay] [decimal](6, 2) NULL,
	[job_cat] [int] NULL,
	[on_paid_leave] [bit] NULL,
	[lineid] [int] NULL,
	[jobnotpaid] [bit] NULL,
	[InsertId] [nvarchar](20) NULL,
	[InsertDt] [datetime] NULL,
	[UpdtId] [nvarchar](20) NULL,
	[UpdtDt] [datetime] NULL,
 CONSTRAINT [PK_tbl_AppliedAttendance_1] PRIMARY KEY CLUSTERED 
(
	[RosterID] ASC,
	[attendDate] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
