/****** Object:  StoredProcedure [dbo].[attenChart]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[attenChart] 


(
    @day nvarchar(max),
    @grower nvarchar(max)
)

AS
	

--select rtrim(firstname) + ' ' + rtrim(lastname), case when mode = 0 then 'Bins: ' + cast(unit as nvarchar(max)) else 'Rate: ' + cast(rate as nvarchar(max)) end, 

--format(cast(day as datetime) + cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff'), format(cast(day as datetime) + cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') from tbl_duty 

--inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
--inner join tbl_binattendance on tbl_binattendance.rosterid = tbl_duty.rosterid
--where day = @day and growerid = @grower and cat = 'Picking' order by workerid


select rtrim(firstname) + ' ' + rtrim(lastname) as name, case when mode = 0 then 'Bins: ' + cast(unit as nvarchar(max)) else 'Rate: $' + cast(rate as nvarchar(max)) end as rate, 

format(cast(day as datetime) + cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') as start,

case when tbl_duty.rosterid in (select rosterid from tbl_submitbreak) and starttime < (select top 1 starttime from tbl_submitbreak where tbl_duty.rosterid = rosterid order by endtime desc)
then
format(cast(day as datetime) + cast((select top 1 starttime from tbl_submitbreak where tbl_duty.rosterid = rosterid order by starttime asc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
else
format(cast(day as datetime) + cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
end  as [end]

from tbl_duty 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_binattendance on tbl_binattendance.rosterid = tbl_duty.rosterid
where day = @day and growerid = @grower and cat = 'Picking'

union

select rtrim(firstname) + ' ' + rtrim(lastname) as name,  'Break Rate: $' + cast(

case when paid_break = 1 then

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

format(cast(day as datetime) + cast(starttime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') as start,


format(cast(day as datetime) + cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
 as [end]

from tbl_duty 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_submitbreak on tbl_submitbreak.rosterid = tbl_duty.rosterid
where day = @day and growerid = @grower and cat = 'Picking'



union

select rtrim(firstname) + ' ' + rtrim(lastname) as name,   
case when (select top 1 mode from tbl_binattendance where rosterid = tbl_duty.rosterid order by endtime asc) = 0 then 'Bins Continued' else 'Rate: $' + cast((select top 1 rate from tbl_binattendance where rosterid = tbl_duty.rosterid order by endtime desc) as nvarchar(max)) end as rate, 

format(cast(day as datetime) + cast(endtime as datetime), 'MM/dd/yyyy HH:mm:ss.fff')  as start,


case when  endtime < (select top 1 endtime from tbl_submitbreak where rosterid = tbl_duty.rosterid order by endtime desc)
then
format(cast(day as datetime) + cast((select top 1 starttime from tbl_submitbreak where rosterid = tbl_duty.rosterid order by endtime desc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 

else
format(cast(day as datetime) + cast((select top 1 endtime from tbl_binattendance where rosterid = tbl_duty.rosterid order by endtime asc) as datetime), 'MM/dd/yyyy HH:mm:ss.fff') 
end


 as [end]

from tbl_duty 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_submitbreak on tbl_submitbreak.rosterid = tbl_duty.rosterid
where day = @day and growerid = @grower and cat = 'Picking'

order by name, start
GO
