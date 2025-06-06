/****** Object:  Table [dbo].[tbl_job_mcat]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_job_mcat](
	[JobmCatID] [smallint] IDENTITY(1,1) NOT NULL,
	[CatName] [nchar](100) NULL,
	[industry_id] [int] NULL,
 CONSTRAINT [PK_tbl_job_mcat_JobmCatID] PRIMARY KEY CLUSTERED 
(
	[JobmCatID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_job_mcat]  WITH CHECK ADD  CONSTRAINT [FK_tbl_job_mcat_industry_id] FOREIGN KEY([industry_id])
REFERENCES [dbo].[tbl_industry] ([id])
GO
ALTER TABLE [dbo].[tbl_job_mcat] CHECK CONSTRAINT [FK_tbl_job_mcat_industry_id]
GO
