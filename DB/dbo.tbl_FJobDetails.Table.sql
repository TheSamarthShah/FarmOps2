/****** Object:  Table [dbo].[tbl_FJobDetails]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FJobDetails](
	[jobId] [int] NOT NULL,
	[jobCat] [int] NOT NULL,
	[growerId] [int] NOT NULL,
	[jobTitle] [varchar](255) NOT NULL,
	[jobDescription] [text] NULL,
	[jobPostedDate] [datetime] NULL,
	[jobStatus] [varchar](50) NULL,
	[jobPay] [decimal](10, 2) NOT NULL,
	[jobDuration] [int] NOT NULL,
	[numWorkers] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[jobId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_FJobDetails] ADD  DEFAULT (getdate()) FOR [jobPostedDate]
GO
ALTER TABLE [dbo].[tbl_FJobDetails] ADD  DEFAULT ('Open') FOR [jobStatus]
GO
