/****** Object:  StoredProcedure [dbo].[sp_getAvailableWorkers]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getAvailableWorkers]
(
    @0 varchar,
	@day as DateTable readonly
)
AS
BEGIN


(select firstname, lastname, id, type, pay, 'true' as available from tbl_login
inner join tbl_employees on tbl_login.id = tbl_employees.workersid
inner join tbl_worker on tbl_worker.workersid = tbl_login.id
Inner Join[dbo].[tbl_pay]     on[dbo].[tbl_pay].[payID]=[dbo].[tbl_worker].[payrate]
where tbl_employees.growersid = @0 and tbl_worker.workersid not in (

select workerid from tbl_duty where day in (select * from  @day) and growerid = @0) )

union
(
select firstname, lastname, id, type, pay, 'false' as available from tbl_login
inner join tbl_employees on tbl_login.id = tbl_employees.workersid
inner join tbl_worker on tbl_worker.workersid = tbl_login.id
Inner Join[dbo].[tbl_pay]     on[dbo].[tbl_pay].[payID]=[dbo].[tbl_worker].[payrate]
where tbl_employees.growersid = @0 and tbl_worker.workersid in (

select workerid from tbl_duty where day in  (select * from  @day) and growerid = @0) )order by available desc, type, firstname, lastname





END
GO
