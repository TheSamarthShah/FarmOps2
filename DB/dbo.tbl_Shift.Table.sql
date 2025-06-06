/****** Object:  Table [dbo].[tbl_Shift]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Shift](
	[ShiftID] [bigint] NOT NULL,
	[Shiftstarttime] [time](7) NULL,
	[ShiftendTime] [time](7) NULL,
	[TotalTime] [time](7) NULL,
	[farmId] [nvarchar](20) NULL,
	[farmid2] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_Shift_ShiftID] PRIMARY KEY NONCLUSTERED 
(
	[ShiftID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_Shift]    Script Date: 01-04-2025 23:02:30 ******/
CREATE CLUSTERED INDEX [IDX_tbl_Shift] ON [dbo].[tbl_Shift]
(
	[farmId] ASC,
	[farmid2] ASC,
	[ShiftID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Shift]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Shift_farmid2] FOREIGN KEY([farmid2])
REFERENCES [dbo].[tbl_farms] ([FarmId])
GO
ALTER TABLE [dbo].[tbl_Shift] CHECK CONSTRAINT [FK_tbl_Shift_farmid2]
GO
