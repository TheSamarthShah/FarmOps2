/****** Object:  Table [dbo].[tbl_bioauth]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_bioauth](
	[rosterid] [bigint] NOT NULL,
	[fingerprint] [bit] NULL,
	[face] [bit] NULL,
	[start_sign] [nvarchar](200) NULL,
	[end_sign] [nvarchar](200) NULL,
	[end_pic] [nvarchar](200) NULL,
	[start_pic] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbl_bioauth_rosterid] PRIMARY KEY NONCLUSTERED 
(
	[rosterid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [UK_tbl_bioauth_rosterid]    Script Date: 01-04-2025 23:02:30 ******/
CREATE UNIQUE CLUSTERED INDEX [UK_tbl_bioauth_rosterid] ON [dbo].[tbl_bioauth]
(
	[rosterid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
