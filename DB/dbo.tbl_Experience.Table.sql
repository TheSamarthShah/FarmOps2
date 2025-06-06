/****** Object:  Table [dbo].[tbl_Experience]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Experience](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[WorkerId] [nvarchar](20) NULL,
	[Job_Title] [nchar](50) NULL,
	[Company_Name] [nchar](50) NULL,
	[Start_Date] [date] NULL,
	[End_Date] [date] NULL,
	[Duration] [nvarchar](50) NULL,
	[Duty] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbl_Experience_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_Experience_WorkerId]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_Experience_WorkerId] ON [dbo].[tbl_Experience]
(
	[WorkerId] ASC,
	[Company_Name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Experience]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Experience_WorkerId] FOREIGN KEY([WorkerId])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_Experience] CHECK CONSTRAINT [FK_tbl_Experience_WorkerId]
GO
