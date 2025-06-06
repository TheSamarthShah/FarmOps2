/****** Object:  Table [dbo].[temp_attendance]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_attendance](
	[RosterID] [bigint] NOT NULL,
	[Start_time] [time](7) NULL,
	[End_time] [time](7) NULL,
	[note] [nvarchar](max) NULL,
	[Total_hours] [decimal](5, 2) NULL,
	[breaktime] [decimal](5, 2) NULL,
	[blockid] [nvarchar](max) NULL,
	[startsignature] [nvarchar](max) NULL,
	[endsignature] [nvarchar](max) NULL,
	[pay] [decimal](6, 2) NULL,
	[job_cat] [int] NULL,
	[paid_break] [int] NULL,
	[Phase] [int] NULL,
	[shift_date] [date] NULL,
	[phaseBool] [bit] NULL,
	[binCount] [int] NULL,
	[binPay] [decimal](5, 2) NULL,
	[binCounts] [decimal](5, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[temp_attendance] ADD  DEFAULT ((0)) FOR [Phase]
GO
ALTER TABLE [dbo].[temp_attendance] ADD  DEFAULT ((0)) FOR [binCount]
GO
ALTER TABLE [dbo].[temp_attendance] ADD  DEFAULT ((0)) FOR [binPay]
GO
