/****** Object:  UserDefinedTableType [dbo].[LocationTableType]    Script Date: 01-04-2025 23:02:30 ******/
CREATE TYPE [dbo].[LocationTableType] AS TABLE(
	[LocationName] [varchar](50) NULL,
	[CostRate] [int] NULL
)
GO
