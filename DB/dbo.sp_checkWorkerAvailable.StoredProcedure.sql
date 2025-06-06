/****** Object:  StoredProcedure [dbo].[sp_checkWorkerAvailable]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_checkWorkerAvailable]
	-- Add the parameters for the stored procedure here
	  @day AS datetime,
 --@farmid AS nvarchar(MAX),
 @growerid AS varchar(255),
 @workerid AS dbo.tbl_workerid READONLY

AS
BEGIN
	
IF (SELECT count(DISTINCT [dbo].[tbl_Duty].[WorkerID]) FROM [dbo].[tbl_Duty]
INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
INNER JOIN [dbo].[temp_attendance] on [dbo].[tbl_Duty].[RosterID] = [dbo].[temp_attendance].[RosterID]
WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid)) > 0
	IF 'Supervisor' IN (SELECT type FROM [dbo].[tbl_Duty]
	INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
	INNER JOIN [dbo].[temp_attendance] on [dbo].[tbl_Duty].[RosterID] = [dbo].[temp_attendance].[RosterID]
	INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
	WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid))
	AND 'Worker' IN (SELECT type FROM [dbo].[tbl_Duty]
	INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
	INNER JOIN [dbo].[temp_attendance] on [dbo].[tbl_Duty].[RosterID] = [dbo].[temp_attendance].[RosterID]
	INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
	WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid))
		SELECT 'multiple_working'--Supervisor(s) and worker(s) already working
	ELSE IF 'Worker' IN (SELECT type FROM [dbo].[tbl_Duty]
	INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
	INNER JOIN [dbo].[temp_attendance] on [dbo].[tbl_Duty].[RosterID] = [dbo].[temp_attendance].[RosterID]
	INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
	WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid))
		IF (SELECT count(type) FROM [dbo].[tbl_Duty]
		INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
		INNER JOIN [dbo].[temp_attendance] on [dbo].[tbl_Duty].[RosterID] = [dbo].[temp_attendance].[RosterID]
		INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
		WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_login].[type] = 'Worker' AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid)) > 1
			SELECT 'workers_working'--More than 1 worker already working
		ELSE
			SELECT 'worker_working'--1 worker already working
	ELSE
		IF (SELECT count(type) FROM [dbo].[tbl_Duty]
		INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
		INNER JOIN [dbo].[temp_attendance] on [dbo].[tbl_Duty].[RosterID] = [dbo].[temp_attendance].[RosterID]
		INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
		WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_login].[type] = 'Supervisor' AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid)) > 1
			SELECT 'supervisors_working'--More than 1 supervisor already working
		ELSE
			SELECT 'supervisor_working'--1 supervisor already working
ELSE IF (SELECT count(*) FROM [dbo].[tbl_Duty]
INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid)) > 0
	IF 'Supervisor' IN (SELECT type FROM [dbo].[tbl_Duty]
	INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
	INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
	WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid))
	AND 'Worker' IN (SELECT type FROM [dbo].[tbl_Duty]
	INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
	INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
	WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid))
		SELECT 'multiple_assigned'--Supervisor(s) and worker(s) already assigned
	ELSE IF 'Supervisor' IN (SELECT type FROM [dbo].[tbl_Duty]
	INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
	INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
	WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid))
		IF (SELECT count(type) FROM [dbo].[tbl_Duty]
		INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
		INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
		WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_login].[type] = 'Supervisor' AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid)) > 1
			SELECT 'supervisors_assigned'--More than 1 supervisor already assigned
		ELSE
			SELECT 'supervisor_assigned'--1 supervisor already assigned
	ELSE
		IF (SELECT count(type) FROM [dbo].[tbl_Duty]
		INNER JOIN [dbo].[tbl_Shift] on [dbo].[tbl_Duty].[ShiftID] = [dbo].[tbl_Shift].[ShiftID]
		INNER JOIN [dbo].[tbl_login] on [dbo].[tbl_Duty].[WorkerID] = [dbo].[tbl_login].[Id]
		WHERE [dbo].[tbl_Duty].[Day] = @day AND [dbo].[tbl_login].[type] = 'Worker' AND [dbo].[tbl_Duty].[GrowerID] = @growerid AND [dbo].[tbl_Duty].[WorkerID] IN (SELECT * FROM @workerid)) > 1
			SELECT 'workers_assigned'--More than 1 worker already assigned
		ELSE
			SELECT 'worker_assigned'--1 worker already assigned
ELSE
	SELECT 'clear'
END
GO
