/****** Object:  StoredProcedure [dbo].[SetNewShiftv2]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SetNewShiftv2] ( @today varchar(max),
 @supervisor varchar(max),
 @worker varchar(max),
 @time time)
as 

declare @id int
declare @monitor varchar(max)
declare @category varchar(max)
declare @grower varchar(max)

declare @flag bit 
set 
@flag=1
BEGIN
	if(select count(*) from tbl_duty where day = @today and workerid = @worker) > 0 begin
if(select count(*) from tbl_attendance where rosterid in (select rosterid from tbl_duty where day = @today and workerid = @worker ) and end_time is not null ) = (select count(*) from tbl_duty where day = @today and workerid = @worker) begin
set @flag = 0
end
end else begin
set @flag = 0
end 


if @flag = 0 begin
if (select count(*) from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime) > 0 begin
set @id = (select top 1 tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
set @monitor = (select top 1 monitorid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
set @category = (select top 1 cat from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
set @grower = (select top 1 growerid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))

insert into tbl_duty (shiftid, day, workerid, growerid, supervisorid, monitorid, cat) values (@id, @today, @worker, @grower, @supervisor, @monitor, @category)
select 'i'
end
END
end
GO
