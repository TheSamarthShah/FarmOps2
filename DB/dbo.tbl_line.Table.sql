/****** Object:  Table [dbo].[tbl_line]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_line](
	[blockid] [int] NOT NULL,
	[lineid] [int] IDENTITY(2,2) NOT NULL,
	[linr_name] [nvarchar](50) NULL,
	[bays] [decimal](5, 2) NULL,
	[bay_area] [decimal](7, 2) NULL,
 CONSTRAINT [PK_tbl_line_lineid] PRIMARY KEY CLUSTERED 
(
	[lineid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
