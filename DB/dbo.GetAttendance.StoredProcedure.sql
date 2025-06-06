/****** Object:  StoredProcedure [dbo].[GetAttendance]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAttendance]
(
    @wday varchar,
	@wid varchar
)
AS
BEGIN
SELECT  tbl_Duty.RosterID, [tbl_worker].[FirstName], [tbl_worker].[LastName], tbl_Shift.Shiftstarttime, tbl_Shift.TotalTime FROM  tbl_Shift INNER JOIN tbl_Duty
ON tbl_Shift.ShiftID=tbl_Duty.ShiftID
INNER JOIN [dbo].[tbl_worker] on [tbl_worker].[WorkersId]=[tbl_Duty].[WorkerID]

 WHERE tbl_Duty.Day = @wday AND tbl_Duty.GrowerID = @wid


END
GO
