/****** Object:  Table [dbo].[tbl_history]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_history](
	[payID] [int] NOT NULL,
	[lastUpdate] [datetime] NULL,
	[pay] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_tbl_history_payID]    Script Date: 01-04-2025 23:02:30 ******/
CREATE CLUSTERED INDEX [IDX_tbl_history_payID] ON [dbo].[tbl_history]
(
	[payID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_history]  WITH CHECK ADD  CONSTRAINT [FK_tbl_history_payID] FOREIGN KEY([payID])
REFERENCES [dbo].[tbl_pay] ([payID])
GO
ALTER TABLE [dbo].[tbl_history] CHECK CONSTRAINT [FK_tbl_history_payID]
GO
