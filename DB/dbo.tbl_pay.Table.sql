/****** Object:  Table [dbo].[tbl_pay]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pay](
	[payID] [int] IDENTITY(1,1) NOT NULL,
	[pay] [money] NULL,
	[lastUpdate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [KEY_tbl_pay_payID]    Script Date: 01-04-2025 23:02:31 ******/
CREATE UNIQUE NONCLUSTERED INDEX [KEY_tbl_pay_payID] ON [dbo].[tbl_pay]
(
	[payID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
