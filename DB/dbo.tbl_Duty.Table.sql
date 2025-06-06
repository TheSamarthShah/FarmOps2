/****** Object:  Table [dbo].[tbl_Duty]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Duty](
	[RosterID] [bigint] IDENTITY(2,2) NOT NULL,
	[ShiftID] [bigint] NULL,
	[Day] [datetime] NULL,
	[WorkerID] [nvarchar](20) NULL,
	[GrowerID] [nvarchar](20) NULL,
	[supervisorId] [nvarchar](20) NULL,
	[MonitorID] [nvarchar](20) NULL,
	[cat] [nvarchar](50) NULL,
	[team] [int] NULL,
	[mcatid] [int] NULL,
 CONSTRAINT [PK_tbl_Duty_RosterID] PRIMARY KEY CLUSTERED 
(
	[RosterID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nci_wi_tbl_Duty_AB140D24A8F54BB26252A082D7157E74]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [nci_wi_tbl_Duty_AB140D24A8F54BB26252A082D7157E74] ON [dbo].[tbl_Duty]
(
	[Day] ASC,
	[WorkerID] ASC,
	[ShiftID] ASC
)
INCLUDE([GrowerID],[MonitorID],[supervisorId]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Duty]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Duty_GrowerID] FOREIGN KEY([GrowerID])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_Duty] CHECK CONSTRAINT [FK_tbl_Duty_GrowerID]
GO
ALTER TABLE [dbo].[tbl_Duty]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Duty_ShiftID] FOREIGN KEY([ShiftID])
REFERENCES [dbo].[tbl_Shift] ([ShiftID])
GO
ALTER TABLE [dbo].[tbl_Duty] CHECK CONSTRAINT [FK_tbl_Duty_ShiftID]
GO
ALTER TABLE [dbo].[tbl_Duty]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Duty_WorkerID] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_Duty] CHECK CONSTRAINT [FK_tbl_Duty_WorkerID]
GO
