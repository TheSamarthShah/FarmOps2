/****** Object:  StoredProcedure [dbo].[ChartQuery]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChartQuery] (
	-- Add the parameters for the stored procedure here
	@now date,
	@id varchar(max),
	@monitor varchar(max)
	)
AS
BEGIN
	

--Setting the end date period
if @now < cast ('4/1/' + cast(datepart(year, @now) as varchar(4)) as date)
begin
set @now = cast ('4/1/' + cast(datepart(year, @now) as varchar(4)) as date)
end else if @now < cast ('7/1/' + cast(datepart(year, @now) as varchar(4)) as date)
begin
set @now = cast ('7/1/' + cast(datepart(year, @now) as varchar(4)) as date)
end else if @now < cast ('10/1/' + cast(datepart(year, @now) as varchar(4)) as date)
begin
set @now = cast ('10/1/' + cast(datepart(year, @now) as varchar(4)) as date)
end else
begin
set @now = cast ('1/1/' + cast(datepart(year, dateadd(year, 1, @now)) as varchar(4)) as date)
end


declare @pay as decimal(30, 2) = 0
--Setting the start date period
declare @count as datetime = dateadd(month, -3, DATEADD(month, DATEDIFF(month, 0, @now), 0))
declare @budget as decimal(30, 2) = 0

declare @gotbudgets as table (budgetid int)
if @monitor is null begin set @monitor = @id end
set @budget = (select isnull(sum(amount),0) from tbl_budget where sdate <= @count and edate >= @count and growerid = @id and monitorid = @monitor)
insert into @gotbudgets values ((select top 1 budgetid from tbl_budget where sdate <= @count and edate >= @count and growerid = @id and monitorid = @monitor order by TimeStamp desc))

declare @table as table (thedate2 datetime, workerpay decimal(30, 2), totalpay decimal(30, 2), budget decimal(30, 2))

if @monitor = @id begin 

set @pay = @pay + (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid is null and day <= @count)

set @budget = @budget - (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid is null and day <= @count)

insert into @table values (@count, (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid is null and day = @count), @pay, @budget)

end
else begin
set @pay = @pay + (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid = @monitor and day <= @count)

set @budget = @budget - (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid = @monitor and day <= @count)

insert into @table values (@count, (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid = @monitor and day = @count), @pay, @budget)

end

set @count = dateadd(day, 1, @count)


while  @count <= dateadd(day, -1, @now)
begin
--If the current date is equal to a start budget date, then that budget can be added
if not exists (select 1 from @gotbudgets where budgetid in (select budgetid from tbl_budget where sdate = @count and growerid = @id and monitorid = @monitor))
begin
set @budget = @budget + (select isnull(sum(amount),0) from tbl_budget where sdate = @count and growerid = @id and monitorid = @monitor)
insert into @gotbudgets values ((select top 1 budgetid from tbl_budget where sdate = @count and growerid = @id and monitorid = @monitor order by TimeStamp desc))
end

--If the current date is equal to an end budget date, then that budget can be removed
if exists (select 1 from @gotbudgets where budgetid in (select budgetid from tbl_budget where edate = @count and growerid = @id and monitorid = @monitor))
begin
set @budget = @budget - (select isnull(sum(amount),0) from tbl_budget where edate = @count and growerid = @id and monitorid = @monitor)
delete from @gotbudgets where budgetid = ((select top 1 budgetid from tbl_budget where edate = @count and growerid = @id and monitorid = @monitor order by TimeStamp desc))
end

if @monitor = @id begin 



set @pay = @pay + (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid is null and day = @count)

set @budget = @budget - (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid is null and day = @count)

insert into @table values (@count, (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid is null and day = @count), @pay, @budget)

end
else begin

set @pay = @pay + (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid = @monitor and day = @count)

set @budget = @budget - (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid = @monitor and day = @count)

insert into @table values (@count, (select isnull(sum(pay), 0) from tbl_attendance 
inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid
where growerid = @id and monitorid = @monitor and day = @count), @pay, @budget)

end



set @count = dateadd(day, 1, @count)
end

select format(thedate2, 'd MMM yyyy') as thedate, workerpay, budget from @table order by thedate2


END
GO
