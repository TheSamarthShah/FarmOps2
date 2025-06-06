/****** Object:  Table [dbo].[tbl_FUserDetails]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FUserDetails](
	[userId] [nvarchar](20) NOT NULL,
	[firstName] [nchar](50) NULL,
	[lastName] [nchar](50) NULL,
	[middleName] [nchar](50) NULL,
	[picture] [nvarchar](max) NULL,
	[dob] [date] NULL,
	[passportNumber] [nchar](50) NULL,
	[phone] [nvarchar](max) NULL,
	[payRate] [int] NULL,
	[ird] [nvarchar](20) NULL,
	[forkliftCert] [bit] NULL,
	[ir330] [nvarchar](20) NULL,
	[licence] [nvarchar](10) NULL,
	[workAuth] [bit] NULL,
	[workType] [nvarchar](max) NULL,
	[workEvId] [int] NULL,
	[document] [nvarchar](max) NULL,
	[ir330Document] [nvarchar](max) NULL,
	[accNum] [nvarchar](20) NULL,
	[payrollId] [nvarchar](20) NULL,
	[preEmployment] [nvarchar](200) NULL,
	[signPic] [nvarchar](max) NULL,
 CONSTRAINT [PK__tbl_FUse__CB9A1CFF8AAFD0CC] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
