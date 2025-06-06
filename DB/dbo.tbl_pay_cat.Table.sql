/****** Object:  Table [dbo].[tbl_pay_cat]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_pay_cat](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Rate] [money] NOT NULL,
	[growerid] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_pay_cat_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_pay_cat]  WITH CHECK ADD  CONSTRAINT [FK_tbl_pay_cat_growerid] FOREIGN KEY([growerid])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_pay_cat] CHECK CONSTRAINT [FK_tbl_pay_cat_growerid]
GO
