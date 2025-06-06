/****** Object:  Table [dbo].[tbl_company_contract]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_company_contract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[growerID] [nvarchar](20) NULL,
	[path] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbl_company_contract_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_tbl_company_contract_growerID]    Script Date: 01-04-2025 23:02:30 ******/
CREATE NONCLUSTERED INDEX [IDX_tbl_company_contract_growerID] ON [dbo].[tbl_company_contract]
(
	[growerID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_company_contract]  WITH CHECK ADD  CONSTRAINT [FK_tbl_company_contract_growerID] FOREIGN KEY([growerID])
REFERENCES [dbo].[tbl_grower] ([GrowersId])
GO
ALTER TABLE [dbo].[tbl_company_contract] CHECK CONSTRAINT [FK_tbl_company_contract_growerID]
GO
