/****** Object:  Table [dbo].[tbl_phaseCheck]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_phaseCheck](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[supervisorId] [nvarchar](20) NULL,
	[workingDay] [date] NULL,
	[phase] [bit] NULL,
 CONSTRAINT [PK_tbl_phaseCheck_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_phaseCheck]  WITH CHECK ADD  CONSTRAINT [FK_tbl_phaseCheck_supervisorId] FOREIGN KEY([supervisorId])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_phaseCheck] CHECK CONSTRAINT [FK_tbl_phaseCheck_supervisorId]
GO
