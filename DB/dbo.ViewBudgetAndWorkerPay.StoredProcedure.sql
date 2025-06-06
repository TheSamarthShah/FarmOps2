/****** Object:  StoredProcedure [dbo].[ViewBudgetAndWorkerPay]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ViewBudgetAndWorkerPay]
(
    @loops int,
	@growerId VARCHAR(MAX),
	@startDate VARCHAR(MAX),
	 @endDate VARCHAR(MAX),
	 @monitor varchar(max)
)
AS
BEGIN


	 if @monitor is not null
	 begin
	 set @monitor = ' = ''' + @monitor + ''''
	 end else begin
	 set @monitor = ' is null'
	 end


DECLARE @count INT = 0
DECLARE @countb INT = (@loops * -1) + 1
DECLARE @command VARCHAR(MAX) = ''

WHILE @count < @loops
BEGIN


SET @command = @command + '

SELECT * FROM (SELECT ' + CAST(@count AS VARCHAR(7)) + ' as ''Order'') S5 inner join
 (
SELECT isnull(SUM(Amount),0) AS ''Budget Recieved'' FROM tbl_budget WHERE GrowerID = ''' + @growerId + ''' and monitorid' + @monitor+' AND TimeStamp >= (SELECT DATEADD(month, ' + CAST(@countb AS VARCHAR(7)) + ', ''' + @startDate + ''')) AND TimeStamp < (SELECT DATEADD(month, ' + CAST(@countb AS VARCHAR(7)) + ', ''' + @endDate + '''))) S1  ON 0=0 INNER JOIN
(SELECT
			isnull(sum(pay),0)  AS ''Workers Paid'' from tbl_attendance INNER JOIN tbl_Duty ON tbl_attendance.rosterID = tbl_Duty.rosterID
	WHERE tbl_Duty.Day >= (SELECT DATEADD(month, ' + CAST(@countb AS VARCHAR(7)) + ', ''' + @startDate + ''')) AND
	tbl_Duty.Day < (SELECT DATEADD(month, ' + CAST(@countb AS VARCHAR(7)) + ', ''' + @endDate + ''')) AND
	tbl_Duty.GrowerID = ''' + @growerId + '''  and monitorid'+@monitor +'

) S2 ON 0=0 inner join

(SELECT DATENAME(MONTH, (SELECT DATEADD(month, ' + CAST(@countb AS VARCHAR(7)) + ', ''' + @startDate + '''))) AS ''month'') S3 ON 0=0

UNION'

SET @count = @count + 1
SET @countb = @countb + 1
END

SET @command = LEFT(@command, LEN(@command) - 5) 

EXEC(@command)



END
GO
