/****** Object:  Table [dbo].[tbl_import_payroll]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_import_payroll](
	[growerid] [nvarchar](20) NULL,
	[payrolldate] [date] NULL,
	[path] [nvarchar](200) NULL,
	[Name] [nvarchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_import_payroll_growerid]    Script Date: 01-04-2025 23:02:30 ******/
CREATE CLUSTERED INDEX [IDX_tbl_import_payroll_growerid] ON [dbo].[tbl_import_payroll]
(
	[growerid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_import_payroll]  WITH CHECK ADD  CONSTRAINT [FK_tbl_import_payroll_growerid] FOREIGN KEY([growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_import_payroll] CHECK CONSTRAINT [FK_tbl_import_payroll_growerid]
GO
