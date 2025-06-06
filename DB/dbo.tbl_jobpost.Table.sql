/****** Object:  Table [dbo].[tbl_jobpost]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_jobpost](
	[JobId] [nvarchar](20) NOT NULL,
	[Job_Title] [nvarchar](100) NULL,
	[Job_Location] [nvarchar](50) NULL,
	[Job_region] [nvarchar](50) NULL,
	[Job_experience] [nvarchar](max) NULL,
	[Job_added] [datetime] NULL,
	[job_des] [nvarchar](max) NULL,
	[employee_id] [nvarchar](20) NULL,
	[job_cat] [int] NULL,
	[Job_pay] [money] NULL,
	[job_duration] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[JobId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_jobpost_employee_id]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_jobpost_employee_id] ON [dbo].[tbl_jobpost]
(
	[employee_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
