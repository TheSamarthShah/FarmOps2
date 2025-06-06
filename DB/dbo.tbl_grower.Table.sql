/****** Object:  Table [dbo].[tbl_grower]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_grower](
	[GrowersId] [nvarchar](20) NOT NULL,
	[FirstName] [nchar](50) NULL,
	[LastName] [nchar](50) NULL,
	[MiddleName] [nchar](50) NULL,
	[Picture] [nvarchar](max) NULL,
	[DOB] [date] NULL,
	[Passport Number] [nchar](50) NULL,
	[phone] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_grower_GrowersId] PRIMARY KEY CLUSTERED 
(
	[GrowersId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_grower]  WITH CHECK ADD  CONSTRAINT [FK_tbl_grower_GrowersId] FOREIGN KEY([GrowersId])
REFERENCES [dbo].[tbl_login] ([Id])
GO
ALTER TABLE [dbo].[tbl_grower] CHECK CONSTRAINT [FK_tbl_grower_GrowersId]
GO
ALTER TABLE [dbo].[tbl_grower]  WITH CHECK ADD  CONSTRAINT [FK_tbl_grower_GrowersId2] FOREIGN KEY([GrowersId])
REFERENCES [dbo].[tbl_login] ([Id])
GO
ALTER TABLE [dbo].[tbl_grower] CHECK CONSTRAINT [FK_tbl_grower_GrowersId2]
GO
