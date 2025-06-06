/****** Object:  StoredProcedure [dbo].[sp_organiserv2]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


-- PARAMETERS
-- @id					- The grower's ID that is using the system.
-- @mid					- The monitor's ID for assigning workers to a monitor
-- @start				- the start date selected for the day range of the organiser
-- @end					- The end date selected for the day range of the organiser
-- @today				- The current date as of executing this procedure
-- @Smon				- The start time entered for monday
-- @Emon				- The end time entered for monday
-- @Fmon				- The farmID of the selected farm for monday
-- @Stue				- The start time entered for tuesday
-- @Etue				- The end time entered for tuesday
-- @Ftue				- The farmID of the selected farm for tuesday
-- @Swed				- The start time entered for wednesday
-- @Ewed				- The end time entered for wednesday
-- @Fwed				- The farmID of the selected farm for wednesday
-- @Sthu				- The start time entered for thursday
-- @Ethu				- The end time entered for thursday
-- @Fthu				- The farmID of the selected farm for thursday
-- @Sfri				- The start time entered for friday
-- @Efri				- The end time entered for friday
-- @Ffri				- The farmID of the selected farm for friday
-- @Ssat				- The start time entered for saturday
-- @Esat				- The end time entered for saturday
-- @Fsat				- The farmID of the selected farm for saturday
-- @Ssun				- The start time entered for sunday
-- @Esun				- The end time entered for sunday
-- @Fsun				- The farmID of the selected farm for sunday
-- @workers				- A table containing a list of selected worker IDs for asignment
-- @time				- The current time as of executing this procedure
-- @days				- A table containing the dates that are between the user-selected date range and have valid start times, end times and farm IDs for each day of the week.
-- @count				- The number of days between the user selected start date and end date (@start and @end)
-- @count2				- A counter that increases in value with each runthrough of a while loop
-- @insertDaysMax		- Contains a number that represents the number of entries in @days
-- @insertDaysCount		- A counter that ticks up from 0 to the value of @insertDaysMax. For populating the shift table with each date in the @days table, this value will be the value of the index to target in @days
-- @checkDay0			- This variable will hold the date that has been pulled from @days with each cycle of the loop for populating the shift table
-- @checkDay			- This will hold the numerical vaue for the day of the week for @checkDay0
-- @shiftid				- This will hold the maximum shiftID found in tbl_shift plus 1
-- @countdays			- Counter that starts at 0 and increases with each check of every day in @days that has a planned start time which takes place after the highest value end_time for that day
-- @countdays2			- Counter that starts at 0 and increases with each cycle of the same loop @countdays is running through
-- @insertWorkersMax	- Contains a number that represents the number of entries in @workers
-- @insertWorkersCount	- A counter that ticks up from 0 to the value of @insertWorkersMax. For populating the duty table with each worker in the @workers table, this value will be the value of the index to target in @workers
-- @checkWorker			- This variable will hold the workerID that has been pulled from @workers with ecah cycle of the loop for populating the duty table



CREATE PROCEDURE [dbo].[sp_organiserv2]
(
    @id AS nvarchar(255),
	@mid AS nvarchar(255),
	@start as datetime,
	@end as datetime,
	@today as datetime,
	@Smon as time(7),
	@Emon as time(7),
	@Fmon as nvarchar(max),
	@Stue as time(7),
	@Etue as time(7),
	@Ftue as nvarchar(max),
	@Swed as time(7),
	@Ewed as time(7),
	@Fwed as nvarchar(max),
	@Sthu as time(7),
	@Ethu as time(7),
	@Fthu as nvarchar(max),
	@Sfri as time(7),
	@Efri as time(7),
	@Ffri as nvarchar(max),
	@Ssat as time(7),
	@Esat as time(7),
	@Fsat as nvarchar(max),
	@Ssun as time(7),
	@Esun as time(7),
	@Fsun as nvarchar(max),
	@workers as tbl_workers readonly,
	@time as time(7)
)
AS
BEGIN

set xact_abort on
begin tran

declare @days table(day datetime)
declare @count int = datediff(day, @start, @end)
declare @count2 int = 0
declare @insertDaysMax int
declare @insertDaysCount int = 0;
declare @checkDay0 datetime
declare @checkDay int
declare @shiftid int

while @count >= 0 begin
if  datepart(weekday, (dateadd(day, @count, @start))) = 1 and @Ssun != '' and @Esun != '' and @Fsun != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 2 and @Smon != '' and @Emon != '' and @Fmon != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 3 and @Stue != '' and @Etue != '' and @Ftue != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 4 and @Swed != '' and @Ewed != '' and @Fwed != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 5 and @Sthu != '' and @Ethu != '' and @Fthu != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 6 and @Sfri != '' and @Efri != '' and @Ffri != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
if  datepart(weekday, (dateadd(day, @count, @start))) = 7 and @Ssat != '' and @Esat != '' and @Fsat != '' begin
insert into @days (day) values (dateadd(day, @count, @start))
set @count2 = @count2 + 1
end
set @count = @count - 1
end
--
if @today in (select * from @days) begin
if datepart(weekday, @today) = 1 begin
if @Ssun < @time begin
select 'E9'
commit tran
rollback tran 
end end
else if datepart(weekday, @today) = 2 begin
if @Smon < @time begin
select 'E9'
commit tran
rollback tran  
 end end
else if datepart(weekday, @today) = 3 begin
if @Stue < @time begin
select 'E9'
commit tran
rollback tran 
end end
else if datepart(weekday, @today) = 4 begin
if @Swed < @time begin
select 'E9'
commit tran
rollback tran 
end end
else if datepart(weekday, @today) = 5 begin
if @Sthu < @time begin
select 'E9'
commit tran
rollback tran 
end end
else if datepart(weekday, @today) = 6 begin
if @Sfri < @time begin
select 'E9'
commit tran
rollback tran 
end end
else if datepart(weekday, @today) = 7 begin
if @Ssat < @time begin
select 'E9'
commit tran
rollback tran 
end end
end
--
if (select count(*) from @workers) = 0 begin select 'E10' end else
if (@count2 != 0) and ((select count(day) from @days where day >= @today) > 0)
--if @count2 != 0
begin

if (select count(*) from [dbo].[tbl_Attendance] where end_time is null and rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))) > 0 begin
--There is a null in an end time. Abort
	select 'E1'
end else if (select count(*) from [dbo].[tbl_Attendance] where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))) > 0 begin

declare @countdays as int = 0
declare @countdays2 as int = 0

if 1 in (select datepart(weekday, day) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))
begin
set @countdays2 = @countdays2 + 1
if @Ssun > (select top 1 end_time from tbl_attendance where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) order by end_time desc)
begin set @countdays = @countdays + 1
end end
if 2 in (select datepart(weekday, day) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))
begin
set @countdays2 = @countdays2 + 1
if @Smon > (select top 1 end_time from tbl_attendance where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) order by end_time desc)
begin set @countdays = @countdays + 1
end end
if 3 in (select datepart(weekday, day) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))
begin
set @countdays2 = @countdays2 + 1
if @Stue > (select top 1 end_time from tbl_attendance where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) order by end_time desc)
begin set @countdays = @countdays + 1
end end
if 4 in (select datepart(weekday, day) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))
begin
set @countdays2 = @countdays2 + 1
if @Swed > (select top 1 end_time from tbl_attendance where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) order by end_time desc)
begin set @countdays = @countdays + 1
end end
if 5 in (select datepart(weekday, day) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))
begin
set @countdays2 = @countdays2 + 1
if @Sthu > (select top 1 end_time from tbl_attendance where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) order by end_time desc)
begin set @countdays = @countdays + 1
end end
if 6 in (select datepart(weekday, day) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))
begin
set @countdays2 = @countdays2 + 1
if @Sfri > (select top 1 end_time from tbl_attendance where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) order by end_time desc)
begin set @countdays = @countdays + 1
end end
if 7 in (select datepart(weekday, day) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers))
begin
set @countdays2 = @countdays2 + 1
if @Ssat > (select top 1 end_time from tbl_attendance where rosterid in 
(select rosterid from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) order by end_time desc)
begin set @countdays = @countdays + 1
end end

if @countdays =  @countdays2
begin
--workers have finished today
if (select count(*) from tbl_duty where rosterid not in (select rosterid from tbl_attendance) and day in (select * from @days) and workerid in (select * from @workers)) > 0
begin
--selected days occur outside of current working days, delete records that dont exist in tbl_attendnance within the selected range. Insert them all.
select 'E7' 

end
else begin 
--Days are all ended, create new.
select 'E2' 
end

--EXECUTE COMMAND--

set @insertDaysMax = (select count(*) from @days)
set @insertDaysCount = 0;

delete from tbl_duty where rosterid not in (select rosterid from tbl_attendance) and day in (select * from @days) and workerid in (select * from @workers)

while @insertDaysCount < @insertDaysMax
begin

set @checkDay0 = (select (select day from (select (row_number() over (order by (select null))) [index], day from @days) R order by R.[index] offset @insertDaysCount rows fetch next 1 rows only))
set @checkDay  = (select datepart(weekday, @checkDay0))

set @shiftid  = (select isnull(max(shiftid),0) from tbl_shift) + 1

if @checkDay = 7 begin 
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Ssat,@Esat, (select dateadd(ss, datediff(Second, @Ssat, @Esat), cast('00:00' as time(7)))),@Fsat)
end else if @checkDay = 1 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Ssun,@Esun, (select dateadd(ss, datediff(Second, @Ssun, @Esun), cast('00:00' as time(7)))),@Fsun)
end else if @checkDay = 2 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Smon,@Emon, (select dateadd(ss, datediff(Second, @Smon, @Emon), cast('00:00' as time(7)))),@Fmon)
end else if @checkDay = 3 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Stue,@Etue, (select dateadd(ss, datediff(Second, @Stue, @Etue), cast('00:00' as time(7)))),@Ftue)
end else if @checkDay = 4 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Swed,@Ewed, (select dateadd(ss, datediff(Second, @Swed, @Ewed), cast('00:00' as time(7)))),@Fwed)
end else if @checkDay = 5 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Sthu,@Ethu, (select dateadd(ss, datediff(Second, @Sthu, @Ethu), cast('00:00' as time(7)))),@Fthu)
end else if @checkDay = 6 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Sfri,@Efri, (select dateadd(ss, datediff(Second, @Sfri, @Efri), cast('00:00' as time(7)))),@Ffri)
end

declare @insertWorkersMax int = (select count(*) from @workers)
declare @insertWorkersCount int = 0;
while @insertWorkersCount < @insertWorkersMax
begin
declare @checkWorker nvarchar(max) = (select (select workerid from (select (row_number() over (order by (select null))) [index], workerid from @workers) R order by R.[index] offset @insertWorkersCount rows fetch next 1 rows only))

 if @checkWorker in (select workerid from tbl_duty where day = @checkDay0 and growerid = @id and monitorid = @mid and rosterid not in (select rosterid from tbl_attendance)) begin
 -- vv Inserting new code vv
	
 if @checkDay = 7 begin 
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Ssat begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 1 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Ssun begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 2 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Smon begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 3 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Stue begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 4 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Swed begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 5 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Sthu begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 6 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Sfri begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end

	--Do we want E-codes for the 4 (4 billion?) possible update commands above?

 end else begin
 
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)

end

-- ^^ Inserting new code ^^

set @insertWorkersCount = @insertWorkersCount + 1
end

set @insertDaysCount = @insertDaysCount + 1
end

--END EXECUTION--







end else begin
--worker start time before an end time. Abort
 select 'E5' end


end else if(select count(*) from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)) > 0 begin
--delete from duty table (if exists), recreate new data for duty table (for all)
select 'E3'

--EXECUTE COMMAND--

set @insertDaysMax = (select count(*) from @days)
set @insertDaysCount = 0;

delete from tbl_duty where day in (select * from @days) and workerid in (select * from @workers)

while @insertDaysCount < @insertDaysMax
begin

set @checkDay0  = (select (select day from (select (row_number() over (order by (select null))) [index], day from @days) R order by R.[index] offset @insertDaysCount rows fetch next 1 rows only))
set @checkDay  = (select datepart(weekday, @checkDay0))

set @shiftid  = (select isnull(max(shiftid),0) from tbl_shift) + 1

if @checkDay = 7 begin 
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Ssat,@Esat, (select dateadd(ss, datediff(Second, @Ssat, @Esat), cast('00:00' as time(7)))),@Fsat)
end else if @checkDay = 1 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Ssun,@Esun, (select dateadd(ss, datediff(Second, @Ssun, @Esun), cast('00:00' as time(7)))),@Fsun)
end else if @checkDay = 2 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Smon,@Emon, (select dateadd(ss, datediff(Second, @Smon, @Emon), cast('00:00' as time(7)))),@Fmon)
end else if @checkDay = 3 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Stue,@Etue, (select dateadd(ss, datediff(Second, @Stue, @Etue), cast('00:00' as time(7)))),@Ftue)
end else if @checkDay = 4 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Swed,@Ewed, (select dateadd(ss, datediff(Second, @Swed, @Ewed), cast('00:00' as time(7)))),@Fwed)
end else if @checkDay = 5 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Sthu,@Ethu, (select dateadd(ss, datediff(Second, @Sthu, @Ethu), cast('00:00' as time(7)))),@Fthu)
end else if @checkDay = 6 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Sfri,@Efri, (select dateadd(ss, datediff(Second, @Sfri, @Efri), cast('00:00' as time(7)))),@Ffri)
end

set @insertWorkersMax  = (select count(*) from @workers)
set @insertWorkersCount  = 0;
while @insertWorkersCount < @insertWorkersMax
begin
set @checkWorker  = (select (select workerid from (select (row_number() over (order by (select null))) [index], workerid from @workers) R order by R.[index] offset @insertWorkersCount rows fetch next 1 rows only))

 if @checkWorker in (select workerid from tbl_duty where day = @checkDay0 and growerid = @id and monitorid = @mid and rosterid not in (select rosterid from tbl_attendance)) begin
  -- vv Inserting new code vv
	
 if @checkDay = 7 begin 
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Ssat begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 1 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Ssun begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 2 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Smon begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 3 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Stue begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 4 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Swed begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 5 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Sthu begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end else if @checkDay = 6 begin
 if (select top 1 shiftendtime from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where growerid=@id and day = @checkDay0 and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc) >= @Sfri begin

if (select top 1 supervisorid from tbl_duty where shiftid in (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = @checkWorker
	begin
	--supervisor shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end else begin
	--worker shift move
		if (select farmid from tbl_shift where shiftid = (select top 1 shiftid from tbl_duty where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftid desc)) = (select farmid from tbl_shift where shiftid = @shiftid)
		begin
		--old farm matches new farm
		update tbl_duty set shiftid = @shiftid where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end else begin
		--old farm does not match new farm
		update tbl_duty set shiftid = @shiftid, supervisorid = null where workerid = @checkWorker and shiftid in (
select top 0.0001 percent tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid 
where day = @checkDay0 and growerid = @id and workerid = @checkWorker and monitorid = @mid order by shiftendtime desc)
		end
	end

end else begin
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
end

end

	--Do we want E-codes for the 4 (4 billion?) possible update commands above?

 end else begin
 
insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)

end

-- ^^ Inserting new code ^^
set @insertWorkersCount = @insertWorkersCount + 1
end

set @insertDaysCount = @insertDaysCount + 1
end

--END EXECUTION--



end else begin
--no entry found in duty table, create new
select 'E4'


--EXECUTE COMMAND--

set @insertDaysMax  = (select count(*) from @days)
set @insertDaysCount  = 0;


while @insertDaysCount < @insertDaysMax
begin

set @checkDay0  = (select (select day from (select (row_number() over (order by (select null))) [index], day from @days) R order by R.[index] offset @insertDaysCount rows fetch next 1 rows only))
set @checkDay  = (select datepart(weekday, @checkDay0))

set @shiftid  = (select isnull(max(shiftid),0) from tbl_shift) + 1

if @checkDay = 7 begin 
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Ssat,@Esat, (select dateadd(ss, datediff(Second, @Ssat, @Esat), cast('00:00' as time(7)))),@Fsat)
end else if @checkDay = 1 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Ssun,@Esun, (select dateadd(ss, datediff(Second, @Ssun, @Esun), cast('00:00' as time(7)))),@Fsun)
end else if @checkDay = 2 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Smon,@Emon, (select dateadd(ss, datediff(Second, @Smon, @Emon), cast('00:00' as time(7)))),@Fmon)
end else if @checkDay = 3 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Stue,@Etue, (select dateadd(ss, datediff(Second, @Stue, @Etue), cast('00:00' as time(7)))),@Ftue)
end else if @checkDay = 4 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Swed,@Ewed, (select dateadd(ss, datediff(Second, @Swed, @Ewed), cast('00:00' as time(7)))),@Fwed)
end else if @checkDay = 5 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Sthu,@Ethu, (select dateadd(ss, datediff(Second, @Sthu, @Ethu), cast('00:00' as time(7)))),@Fthu)
end else if @checkDay = 6 begin
insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid) values(@shiftid,@Sfri,@Efri, (select dateadd(ss, datediff(Second, @Sfri, @Efri), cast('00:00' as time(7)))),@Ffri)
end

set @insertWorkersMax  = (select count(*) from @workers)
set @insertWorkersCount  = 0;
while @insertWorkersCount < @insertWorkersMax
begin
set @checkWorker  = (select (select workerid from (select (row_number() over (order by (select null))) [index], workerid from @workers) R order by R.[index] offset @insertWorkersCount rows fetch next 1 rows only))

insert into tbl_duty (shiftid, day, workerid, growerid, monitorid) values (@shiftid, @checkDay0, @checkWorker, @id, @mid)
set @insertWorkersCount = @insertWorkersCount + 1
end

set @insertDaysCount = @insertDaysCount + 1
end

--END EXECUTION--



end

end
else begin
--invalid data input
if((select count(day) from @days where day < @today) > 0)
begin
select 'E8'
end else begin
select 'E6'
end
end

commit tran


Skipper:



END
GO
