/****** Object:  StoredProcedure [dbo].[atten2Chart]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[atten2Chart] 


(
    @worker nvarchar(max)
)

AS
	
	
	


select format(day, 'ddd, dd MMM | $') + cast(tbl_attendance.pay as nvarchar(max)) as name, case when mode = 0 then 'Bins: ' + cast(unit as nvarchar(max)) else 'Rate: $' + cast(rate as nvarchar(max)) end as rate, 

format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') as start,

case when tbl_duty.rosterid in (select rosterid from tbl_submitbreak) and starttime < (select top 1 starttime from tbl_submitbreak where tbl_duty.rosterid = rosterid order by endtime desc)
then

case when format(cast((select top 1 starttime from tbl_submitbreak where tbl_duty.rosterid = rosterid order by starttime asc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff')   >= format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') then
format(cast((select top 1 starttime from tbl_submitbreak where tbl_duty.rosterid = rosterid order by starttime asc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
else
format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')
end

else

case when format( cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')    >= format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') then
format( cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
else
format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')
end

end  as [end], day

from tbl_duty 
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid
inner join tbl_binattendance on tbl_binattendance.rosterid = tbl_duty.rosterid
where workerid = @worker and tbl_attendance.pay is not null and cat = 'Picking'

union

select format(day, 'ddd, dd MMM | $') + cast(tbl_attendance.pay as nvarchar(max)) as name,  'Break Rate: $' + cast(

case when tbl_submitbreak.paid_break = 1 then

(select cast(
(select (select sum(pay) from tbl_binattendance 
where  tbl_binattendance.rosterid = tbl_duty.rosterid)
/
--(select cast((select datediff(minute, min(starttime), max(endtime)) from tbl_binattendance where rosterid = tbl_duty.rosterid) - (
--isnull((select sum(datediff(minute, starttime, endtime)) from tbl_submitbreak where rosterid = tbl_duty.rosterid), 0)) as decimal)/60)) as decimal(7,2)))
(select total_hours/60 from tbl_attendance where rosterid = tbl_duty.rosterid)) as decimal(7,2)))


else
0
end

 as nvarchar(max)) as rate, 

format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') as start,

case when format(cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')  >= format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') then
format(cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
else
format(cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')
end
 as [end], day

from tbl_duty 
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid
inner join tbl_submitbreak on tbl_submitbreak.rosterid = tbl_duty.rosterid
where tbl_duty.workerid = @worker and tbl_attendance.pay is not null and cat = 'Picking'



union

select format(day, 'ddd, dd MMM | $') + cast(tbl_attendance.pay as nvarchar(max)) as name,   
case when (select top 1 mode from tbl_binattendance where rosterid = tbl_duty.rosterid order by endtime asc) = 0 then 'Bins Continued' else 'Rate: $' + cast((select top 1 rate from tbl_binattendance where rosterid = tbl_duty.rosterid order by endtime desc) as nvarchar(max)) end as rate, 

format(cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')  as start,


case when  endtime < (select top 1 endtime from tbl_submitbreak where rosterid = tbl_duty.rosterid order by endtime desc)
then


case when format( cast((select top 1 starttime from tbl_submitbreak where rosterid = tbl_duty.rosterid order by endtime desc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff')    >= format(cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') then
format( cast((select top 1 starttime from tbl_submitbreak where rosterid = tbl_duty.rosterid order by endtime desc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
else
format(cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')
end


else


case when format( cast((select top 1 endtime from tbl_binattendance where rosterid = tbl_duty.rosterid order by endtime asc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff')    >= format(cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') then
format( cast((select top 1 endtime from tbl_binattendance where rosterid = tbl_duty.rosterid order by endtime asc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
else
format(cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')
end


end


 as [end], day

from tbl_duty 
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid
inner join tbl_submitbreak on tbl_submitbreak.rosterid = tbl_duty.rosterid
where tbl_duty.workerid = @worker and tbl_attendance.pay is not null and cat = 'Picking'

order by day desc, start
GO
