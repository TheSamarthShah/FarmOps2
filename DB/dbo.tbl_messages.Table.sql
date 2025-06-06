/****** Object:  Table [dbo].[tbl_messages]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_messages](
	[MessageId] [int] IDENTITY(2,2) NOT NULL,
	[Efrom] [varchar](100) NULL,
	[Subjects] [nchar](100) NULL,
	[Eto] [nchar](100) NULL,
	[SentDate] [datetime] NULL,
	[Content] [nvarchar](max) NULL,
	[isread] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nci_wi_tbl_messages_154905C52649FC284F6F625249361EF5]    Script Date: 01-04-2025 23:02:31 ******/
CREATE NONCLUSTERED INDEX [nci_wi_tbl_messages_154905C52649FC284F6F625249361EF5] ON [dbo].[tbl_messages]
(
	[isread] ASC,
	[Eto] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_messages] ADD  DEFAULT (NULL) FOR [isread]
GO
