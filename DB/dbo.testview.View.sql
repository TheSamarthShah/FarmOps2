/****** Object:  View [dbo].[testview]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE VIEW [dbo].[testview] AS


SELECT ( tbl_worker.firstname), tbl_worker.lastname, tbl_attendance.total_hours FROM tbl_attendance INNER JOIN tbl_duty on tbl_attendance.rosterid = tbl_duty.rosterid INNER JOIN tbl_worker on tbl_worker.workersid = tbl_duty.workerid INNER JOIN tbl_shift on tbl_duty.shiftid = tbl_shift.shiftid where tbl_duty.day BETWEEN '12/5/2016' AND '12/12/2016' and tbl_duty.growerid ='grower4' and farmid = 'farmid1' and tbl_attendance.end_time is not null
GO
