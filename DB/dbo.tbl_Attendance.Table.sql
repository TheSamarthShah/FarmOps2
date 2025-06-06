/****** Object:  Table [dbo].[tbl_Attendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Attendance](
	[RosterID] [bigint] NOT NULL,
	[Start_time] [time](7) NULL,
	[End_time] [time](7) NULL,
	[note] [nvarchar](max) NULL,
	[Total_hours] [decimal](29, 17) NULL,
	[breaktime] [bigint] NULL,
	[blockid] [int] NULL,
	[startsignature] [nvarchar](200) NULL,
	[endsignature] [nvarchar](200) NULL,
	[pay] [decimal](6, 2) NULL,
	[job_cat] [int] NULL,
	[paid_break] [int] NULL,
	[startTimestamp] [datetime] NULL,
	[endTimestamp] [datetime] NULL,
	[startphoto] [nvarchar](200) NULL,
	[endohoto] [nvarchar](200) NULL,
	[endphoto] [nvarchar](200) NULL,
	[startsignpic] [nvarchar](200) NULL,
	[endsignpic] [nvarchar](200) NULL,
	[lineid] [int] NULL,
	[jobnotpaid] [binary](1) NULL,
 CONSTRAINT [PK_tbl_Attendance_RosterID] PRIMARY KEY CLUSTERED 
(
	[RosterID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [nci_wi_tbl_Attendance_79B558D3EED1623D38290110BA899051]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [nci_wi_tbl_Attendance_79B558D3EED1623D38290110BA899051] ON [dbo].[tbl_Attendance]
(
	[End_time] ASC,
	[Start_time] ASC
)
INCLUDE([paid_break],[RosterID],[Total_hours]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [nci_wi_tbl_Attendance_F0F075C665A73A02CF5A2A6245CB3D46]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [nci_wi_tbl_Attendance_F0F075C665A73A02CF5A2A6245CB3D46] ON [dbo].[tbl_Attendance]
(
	[RosterID] ASC,
	[End_time] ASC,
	[Start_time] ASC
)
INCLUDE([breaktime],[endohoto],[endsignature],[endsignpic],[endTimestamp],[job_cat],[note],[paid_break],[pay],[startphoto],[startsignature],[startsignpic],[startTimestamp],[Total_hours]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
