/****** Object:  StoredProcedure [dbo].[GetSearchWorker]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetSearchWorker]
(
    @search nvarchar(max)
)
AS
BEGIN
SELECT work.FirstName,
	work.WorkersId,
	work.LastName,
	logi.email,

	convert (datetime2(0),[register_date]) register_date,
	logi.password,
	[passport number] as passportnumber,
	work.Picture,
	visa.Visanumber,
	visa.StartDate,
	visa.ExpireDate,
	visa.Validity,
	visa.Type,
	(case when work.workersid in
	 (select workerid from tbl_deactivate_user)
	  then (select 'Activate')
	   else (select 'Deactivate' )
	   end) as 'adminact'



FROM [dbo].[tbl_worker] As work
INNER JOIN [dbo].[tbl_visa]
as visa On work.WorkersId=visa.VisaId
INNER JOIN [dbo].[tbl_login] AS logi on work.WorkersId=logi.Id 
inner join tbl_employees on tbl_employees.workersid=work.WorkersId

Where ( work.FirstName like '%'+@search+'%' 
or work.LastName 
like '%'+@search+'%' or logi.email 

like '%'+@search+'%' ) and tbl_employees.growersid in ('grower40','grower43') order by work.FirstName

end
GO
