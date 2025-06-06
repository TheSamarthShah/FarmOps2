/****** Object:  Table [dbo].[tbl_AttendanceDetail]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AttendanceDetail](
	[attendanceId] [bigint] NOT NULL,
	[approvedStatus] [char](1) NOT NULL,
	[approvedBy] [nvarchar](20) NULL,
	[attendanceSheetPhoto] [nvarchar](255) NULL,
	[rejectedRosterIds] [nvarchar](max) NULL,
	[approvedDt] [datetime] NULL,
	[appliedBy] [nvarchar](20) NULL,
	[remarks] [nvarchar](255) NULL,
	[attendanceDate] [date] NOT NULL,
 CONSTRAINT [PK_tbl_AttendanceDetail] PRIMARY KEY CLUSTERED 
(
	[attendanceId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
