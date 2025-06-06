/****** Object:  StoredProcedure [dbo].[GetWorker]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetWorker] 


(
    @search nvarchar(max)
)

AS
	SELECT work.FirstName,
	work.WorkersId,
	work.LastName,
	logi.email,
	logi.password,
	work.Picture,
	visa.Visanumber,
	visa.StartDate,
	visa.ExpireDate,
	visa.Validity,
	visa.Type
	



FROM [dbo].[tbl_worker] As work
INNER JOIN [dbo].[tbl_visa]
as visa On work.WorkersId=visa.VisaId
INNER JOIN [dbo].[tbl_login] AS logi on work.WorkersId=logi.Id where
work.FirstName like '%'+@search+'%' or work.LastName like '%'+@search+'%' or logi.email like '%'+@search+'%'
GO
