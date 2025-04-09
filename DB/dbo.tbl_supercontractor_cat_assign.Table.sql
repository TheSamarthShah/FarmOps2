/****** Object:  Table [dbo].[tbl_supercontractor_cat_assign]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_supercontractor_cat_assign](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GrowerID] [nvarchar](50) NOT NULL,
	[monitorID] [nvarchar](50) NOT NULL,
	[ScontractorID] [nvarchar](50) NOT NULL,
	[McatID] [int] NOT NULL,
	[Day] [datetime] NULL
) ON [PRIMARY]
GO
