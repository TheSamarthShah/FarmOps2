/****** Object:  StoredProcedure [dbo].[SetNewShiftv3]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SetNewShiftv3] ( @today varchar(max),
 @supervisor varchar(max),
 @worker varchar(max),
 @time time)
as 

declare @id int
declare @monitor varchar(max)
declare @category varchar(max)
declare @grower varchar(max)
declare @id2 int
declare @id3 int

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
	--begin if supervisor is assigned to themself: do something, else do nothing
		if (select count(*) from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime) > 0 begin
			--If there is at least 1 supervisor set end time less than or equal to the current time: do something, else do nothing

			
			set @id = (select top 1 tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
			--select the earliest valid assigned end time for the supervisor before or equal to the current time
			set @id3 = (select top 1 tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
			--select the earliest valid assigned end time for any worker today before or equal to the current time
			set @monitor = (select top 1 monitorid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
			set @category = (select top 1 cat from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
			set @grower = (select top 1 growerid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))

			declare @compTime as time = '00:00:00'

			if exists(
				select top 1 shiftendtime from tbl_shift 
				inner join tbl_duty on tbl_shift.shiftid = tbl_duty.shiftid
				where workerid = @worker and day = @today order by abs(datediff(minute, @time, shiftendtime))) 
			begin 
				set @compTime = (
					select top 1 shiftendtime 
					from tbl_shift 
					inner join tbl_duty on tbl_shift.shiftid = tbl_duty.shiftid
					where workerid = @worker 
					and day = @today 
					order by abs(datediff(minute, @time, shiftendtime))) 
			end

			if ((select top 1 shiftstarttime from tbl_shift where shiftid = @id) >
			@compTime) or (select count(*) from tbl_duty 
inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid
where workerid = @supervisor and day = @today and tbl_duty.shiftid not in (select tbl_duty.shiftid from tbl_duty 
inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid
where workerid = @worker and day = @today)
) > 0 begin  
			
			if @id in (select shiftid from tbl_duty where workerid = @worker) begin
			set @id = (select top 1 tbl_duty.shiftid from tbl_duty 
inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid
where workerid = @supervisor and day = @today and tbl_duty.shiftid not in (select tbl_duty.shiftid from tbl_duty 
inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid
where workerid = @worker and day = @today)
order by abs(datediff(minute, @time, shiftendtime)))
			end



			if (select farmid from tbl_shift where shiftid = @id) in (select farmid from tbl_farms where farm_name = 'Office') begin
				set @id2 = @id
				set @id = (select top 1 (shiftid+1) from tbl_shift order by shiftid desc)
				insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid, farmid2) values (@id,(select shiftstarttime from tbl_shift where shiftid = @id2),
				(select shiftendtime from tbl_shift where shiftid = @id3),(select totaltime from tbl_shift where shiftid = @id2),
				(select farmid2 from tbl_shift where shiftid = @id2), null)
			end
			insert into tbl_duty (shiftid, day, workerid, growerid, supervisorid, monitorid, cat) values (@id, @today, @worker, @grower, @supervisor, @monitor, @category)
			select 'i'

			end else begin
			--else
	
			set @id = (select top 1 tbl_duty.shiftid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
			set @monitor = (select top 1 monitorid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
			set @category = (select top 1 cat from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))
			set @grower = (select top 1 growerid from tbl_duty inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid where day = @today and workerid = @supervisor and @time <= shiftendtime order by abs(datediff(minute, @time, shiftendtime)))

			
declare @workertime as time =  (select max(end_time) from tbl_attendance inner join tbl_duty on tbl_duty.rosterid = tbl_attendance.rosterid where workerid = @worker and day = @today)

declare @supervisortime as time = (select max(shiftendtime) from tbl_shift inner join tbl_duty on tbl_duty.shiftid = tbl_shift.shiftid where workerid = @supervisor and day = @today)
declare @end as time = '00:00:00'


if @workertime < @supervisortime begin set @end = @workertime --end else begin  set @end = @supervisortime end


			if (select farmid from tbl_shift where shiftid = @id) in (select farmid from tbl_farms where farm_name = 'Office') begin
				set @id2 = @id
				set @id = (select top 1 (shiftid+1) from tbl_shift order by shiftid desc)
				insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid, farmid2) values (@id,
				(select dateadd(minute, 1, @end)),
				
				(select top 1 shiftendtime from tbl_shift inner join tbl_duty on tbl_duty.shiftid = tbl_shift.shiftid where day = @today and workerid = @supervisor order by abs(datediff(minute, @time, shiftendtime))),
				(select totaltime from tbl_shift where shiftid = @id2),
				(select farmid2 from tbl_shift where shiftid = @id2), null)
			end
			else begin
				set @id2 = @id
				set @id = (select top 1 (shiftid+1) from tbl_shift order by shiftid desc)
				insert into tbl_shift (shiftid, shiftstarttime, shiftendtime, totaltime, farmid, farmid2) values (@id,
				(select dateadd(minute, 1, @end)),
				
				(select top 1 shiftendtime from tbl_shift inner join tbl_duty on tbl_duty.shiftid = tbl_shift.shiftid where day = @today and workerid = @supervisor order by abs(datediff(minute, @time, shiftendtime))),
				(select totaltime from tbl_shift where shiftid = @id2),
				(select farmid from tbl_shift where shiftid = @id2), null)
			end
			insert into tbl_duty (shiftid, day, workerid, growerid, supervisorid, monitorid, cat) values (@id, @today, @worker, @grower, @supervisor, @monitor, @category)
			select 'i'

			end
			end
		end
	END
end
GO
