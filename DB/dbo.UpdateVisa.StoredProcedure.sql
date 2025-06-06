/****** Object:  StoredProcedure [dbo].[UpdateVisa]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateVisa](

@WorkersId [nvarchar] (MAX),
@FirstName [nvarchar] (MAX),
@LastName [nvarchar] (MAX),
@Email [nvarchar] (MAX),
@Password [nvarchar] (MAX),
@Picture [nvarchar] (MAX),
@Visanumber [nvarchar](MAX),
@Startdate [nvarchar](MAX),
@passportnumber [nvarchar](MAX),
@ExpireDate [nvarchar](MAX),
@Validity [bit],
@register_date [nvarchar](MAX),
@Type [nvarchar] (MAX)


) AS

BEGIN
Update [dbo].[tbl_login]

SET

email=@Email,
password=@Password

Where [Id]=@WorkersId

Update [dbo].[tbl_worker]

SET

[FirstName]=@FirstName,
[LastName]=@LastName,
[Picture]=@Picture,
[passport number]=@passportnumber

Where [WorkersId]=@WorkersId

UPDATE [dbo].[tbl_visa]

SET 
[Visanumber]=@Visanumber,
[StartDate]=@StartDate,
[ExpireDate]=@ExpireDate,
[Type]=@Type,
[Validity]=@Validity
Where VisaId=@WorkersId

END
GO
