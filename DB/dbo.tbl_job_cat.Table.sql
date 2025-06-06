/****** Object:  Table [dbo].[tbl_job_cat]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_job_cat](
	[JobCatID] [smallint] IDENTITY(1,1) NOT NULL,
	[CatName] [nchar](100) NULL,
	[McatID] [smallint] NULL,
 CONSTRAINT [PK_tbl_job_cat_JobCatID] PRIMARY KEY CLUSTERED 
(
	[JobCatID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_job_cat]  WITH CHECK ADD  CONSTRAINT [FK_tbl_job_cat_McatID] FOREIGN KEY([McatID])
REFERENCES [dbo].[tbl_job_mcat] ([JobmCatID])
GO
ALTER TABLE [dbo].[tbl_job_cat] CHECK CONSTRAINT [FK_tbl_job_cat_McatID]
GO
