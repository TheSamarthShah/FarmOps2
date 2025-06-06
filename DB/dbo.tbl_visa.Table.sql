/****** Object:  Table [dbo].[tbl_visa]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_visa](
	[VisaId] [nvarchar](20) NOT NULL,
	[Visanumber] [nchar](50) NULL,
	[StartDate] [date] NULL,
	[ExpireDate] [date] NULL,
	[Type] [nchar](50) NULL,
	[Validity] [bit] NOT NULL,
	[passporturl] [nvarchar](200) NULL,
	[visaStatus] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[VisaId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_visa] ADD  DEFAULT ((0)) FOR [Validity]
GO
ALTER TABLE [dbo].[tbl_visa]  WITH CHECK ADD  CONSTRAINT [FK_tbl_visa_VisaId] FOREIGN KEY([VisaId])
REFERENCES [dbo].[tbl_worker] ([WorkersId])
GO
ALTER TABLE [dbo].[tbl_visa] CHECK CONSTRAINT [FK_tbl_visa_VisaId]
GO
