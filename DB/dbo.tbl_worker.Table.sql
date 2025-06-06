/****** Object:  Table [dbo].[tbl_worker]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_worker](
	[WorkersId] [nvarchar](20) NOT NULL,
	[FirstName] [nchar](50) NULL,
	[LastName] [nchar](50) NULL,
	[MiddleName] [nchar](50) NULL,
	[Phone] [nvarchar](20) NULL,
	[Picture] [nvarchar](max) NULL,
	[payrate] [int] NULL,
	[DOB] [date] NULL,
	[Passport Number] [nvarchar](20) NULL,
	[ird] [nvarchar](20) NULL,
	[forkliftCert] [bit] NULL,
	[IR330] [bit] NULL,
	[licence] [nvarchar](10) NULL,
	[workAuth] [bit] NULL,
	[WorkType] [nvarchar](max) NULL,
	[workEvId] [int] NULL,
	[document] [nvarchar](max) NULL,
	[IR330Document] [nvarchar](max) NULL,
	[accNum] [nvarchar](20) NULL,
	[payroll_id] [nvarchar](20) NULL,
	[preEmployment] [nvarchar](200) NULL,
	[signpic] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkersId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [KEY_tbl_worker_payrate]    Script Date: 01-04-2025 23:02:31 ******/
CREATE UNIQUE NONCLUSTERED INDEX [KEY_tbl_worker_payrate] ON [dbo].[tbl_worker]
(
	[payrate] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_worker] ADD  DEFAULT ((0)) FOR [forkliftCert]
GO
ALTER TABLE [dbo].[tbl_worker] ADD  DEFAULT ((0)) FOR [IR330]
GO
ALTER TABLE [dbo].[tbl_worker] ADD  DEFAULT ((0)) FOR [workAuth]
GO
ALTER TABLE [dbo].[tbl_worker]  WITH CHECK ADD  CONSTRAINT [FK_tbl_worker_WorkersId] FOREIGN KEY([WorkersId])
REFERENCES [dbo].[tbl_login] ([Id])
GO
ALTER TABLE [dbo].[tbl_worker] CHECK CONSTRAINT [FK_tbl_worker_WorkersId]
GO
