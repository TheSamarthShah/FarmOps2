/****** Object:  StoredProcedure [dbo].[sp_checkWorkers]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_checkWorkers]
	-- Add the parameters for the stored procedure here
 @id AS nvarchar(255),
 @start as datetime,
 @end as datetime,
 @today as datetime,
 @Smon as varchar(7),
 @Emon as varchar(7),
 @Stue as varchar(7),
 @Etue as varchar(7),
 @Swed as varchar(7),
 @Ewed as varchar(7),
 @Sthu as varchar(7),
 @Ethu as varchar(7),
 @Sfri as varchar(7),
 @Efri as varchar(7),
 @Ssat as varchar(7),
 @Esat as varchar(7),
 @Ssun as varchar(7),
 @Esun as varchar(7)

AS
BEGIN

declare @days table(day datetime)
declare @count int = datediff(day, @start, @end)
declare @count2 int = 0

while @count >= 0 begin
if  datepart(weekday, (dateadd(day, @count, @start))) = 1 and @Ssun != '' and @Esun != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 2 and @Smon != '' and @Emon != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 3 and @Stue != '' and @Etue != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 4 and @Swed != '' and @Ewed != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 5 and @Sthu != '' and @Ethu != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 6 and @Sfri != '' and @Efri != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 7 and @Ssat != '' and @Esat != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
set @count = @count - 1
end

--if (@count2 = 0) or ((select count(day) from @days where day < @today) > 0)
if @count2 = 0
begin
select firstname, lastname, id, type, 'false' as available from tbl_login
inner join tbl_employees on tbl_login.id = tbl_employees.workersid
inner join tbl_worker on tbl_worker.workersid = tbl_login.id
where tbl_employees.growersid = @id order by available desc, type, firstname, lastname
end else begin

(select firstname, lastname, id, type, 'true' as available from tbl_login
inner join tbl_employees on tbl_login.id = tbl_employees.workersid
inner join tbl_worker on tbl_worker.workersid = tbl_login.id
where tbl_employees.growersid = @id and tbl_worker.workersid not in 
(select workerid from tbl_duty where (day in (SELECT day from @days) and growerid = @id)) 
or tbl_worker.workersid  in (

select workerid from tbl_duty where (day in (SELECT day from @days) and growerid = @id) and rosterid in (

select rosterid from tbl_attendance where datepart(weekday, @today) = 1 and day = @today and tbl_attendance.end_time < @Ssun
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 2 and day = @today and tbl_attendance.end_time < @Smon 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 3 and day = @today and tbl_attendance.end_time < @Stue 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 4 and day = @today and tbl_attendance.end_time < @Swed 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 5 and day = @today and tbl_attendance.end_time < @Sthu 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 6 and day = @today and tbl_attendance.end_time < @Sfri 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 7 and day = @today and tbl_attendance.end_time < @Ssat 
)) )

union
(
select firstname, lastname, id, type, 'false' as available from tbl_login
inner join tbl_employees on tbl_login.id = tbl_employees.workersid
inner join tbl_worker on tbl_worker.workersid = tbl_login.id
where tbl_employees.growersid = @id and tbl_worker.workersid in 
(select workerid from tbl_duty where (day in (SELECT day from @days) and growerid = @id)) and tbl_worker.workersid not in (select workerid from tbl_duty where (day in (SELECT day from @days) and growerid = @id) and rosterid in (

select rosterid from tbl_attendance where datepart(weekday, @today) = 1 and day = @today and tbl_attendance.end_time < @Ssun
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 2 and day = @today and tbl_attendance.end_time < @Smon 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 3 and day = @today and tbl_attendance.end_time < @Stue 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 4 and day = @today and tbl_attendance.end_time < @Swed 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 5 and day = @today and tbl_attendance.end_time < @Sthu 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 6 and day = @today and tbl_attendance.end_time < @Sfri 
union
select rosterid from tbl_attendance where datepart(weekday, @today) = 7 and day = @today and tbl_attendance.end_time < @Ssat 
)) 
 )order by available desc, type, firstname, lastname

end




end
GO
