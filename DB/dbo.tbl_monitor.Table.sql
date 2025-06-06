/****** Object:  Table [dbo].[tbl_monitor]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_monitor](
	[MonitorsId] [nvarchar](20) NOT NULL,
	[FirstName] [nchar](50) NULL,
	[LastName] [nchar](50) NULL,
	[MiddleName] [nchar](50) NULL,
	[Picture] [nvarchar](200) NULL,
	[DOB] [date] NULL,
	[Passport Number] [nvarchar](20) NULL,
	[phone] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MonitorsId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_monitor]  WITH CHECK ADD  CONSTRAINT [FK_tbl_monitor_MonitorsId] FOREIGN KEY([MonitorsId])
REFERENCES [dbo].[tbl_login] ([Id])
GO
ALTER TABLE [dbo].[tbl_monitor] CHECK CONSTRAINT [FK_tbl_monitor_MonitorsId]
GO
