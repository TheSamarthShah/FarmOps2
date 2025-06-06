/****** Object:  StoredProcedure [dbo].[sp_sup_addworker]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[sp_sup_addworker] (@today as nvarchar(max),@supervisor as nvarchar(max))
	-- Add the parameters for the stored procedure here
AS
BEGIN
	if (select count(*) from tbl_duty where day = @today and workerid = @supervisor and (supervisorid = @supervisor or supervisorid is null)) > 0 begin

select tbl_employees.workersid, firstname, lastname from tbl_employees
inner join tbl_worker on tbl_employees.workersid = tbl_worker.workersid
 where growersid = (select growerid from tbl_duty where day = @today and workerid = @supervisor)
and tbl_employees.workersid not in (select workerid from tbl_duty where day = @today)
union

select tbl_employees.workersid, firstname, lastname from tbl_employees
inner join tbl_worker on tbl_employees.workersid = tbl_worker.workersid where growersid = (select growerid from tbl_duty where day = @today and workerid = @supervisor) 

and tbl_employees.workersid in (select workerid
from tbl_attendance
inner join tbl_duty on tbl_attendance.rosterid = tbl_duty.rosterid
 where tbl_attendance.rosterid in (select rosterid from tbl_duty where day = @today)
)
end
END
GO
