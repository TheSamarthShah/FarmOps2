/****** Object:  Table [dbo].[tbl_FLogin]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FLogin](
	[userId] [nvarchar](20) NOT NULL,
	[emailAddress] [nvarchar](100) NOT NULL,
	[userPassword] [nvarchar](50) NOT NULL,
	[userType] [varchar](10) NOT NULL,
	[isPasswordChanged] [bit] NULL,
	[visaVerification] [int] NULL,
	[lastIpAddress] [nvarchar](50) NULL,
	[lastLoginTime] [nvarchar](50) NULL,
	[isSuperuser] [bit] NULL,
	[promoCode] [nvarchar](50) NULL,
	[registrationDate] [datetime] NULL,
	[industryId] [int] NULL,
	[package] [int] NULL,
 CONSTRAINT [PK__tbl_FLog__CB9A1CFF024B6D8C] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_EmailAddress] UNIQUE NONCLUSTERED 
(
	[emailAddress] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
