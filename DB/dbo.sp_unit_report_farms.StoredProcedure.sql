/****** Object:  StoredProcedure [dbo].[sp_unit_report_farms]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 CREATE procedure [dbo].[sp_unit_report_farms] (
    @start  nvarchar(max) ,
    @end  nvarchar(max),
 @id  nvarchar(max) ,
 @farm  nvarchar(max),
 @monitor nvarchar(max) 
 )
 as
 
 if @monitor = 'null'
 begin

declare @tbl nvarchar(max) = (SELECT DISTINCT
stuff(
(
    SELECT  DISTINCT ', [Payrate: '+ cast(round(tbl_pay.pay,2) as varchar(max)) +']' FROM
	
	  tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid 
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Hour' and endsignature is not null and monitorid is null and shiftid in (select shiftid from tbl_shift where farmid = @farm)
  FOR XML PATH('')
),1,1,'') 
FROM (SELECT DISTINCT tbl_pay.pay FROM
	
	  tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid 
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Hour' and endsignature is not null and monitorid is null and shiftid in (select shiftid from tbl_shift where farmid = @farm)) t)

declare @tbl2 nvarchar(max)= (SELECT DISTINCT
stuff(
(
    SELECT  DISTINCT ', [' + isnull((select top 1 Code from tbl_pay_cat where Id = Rate_id) +' - ','') + cast(round(tbl_bayattendance.payrate,2) as varchar(max)) +']' from tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid  
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Bay' and endsignature is not null and monitorid is null and shiftid in (select shiftid from tbl_shift where farmid = @farm)
  FOR XML PATH('')
),1,1,'') 
FROM (SELECT DISTINCT tbl_bayattendance.payrate from tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid  
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Bay' and endsignature is not null and monitorid is null and shiftid in (select shiftid from tbl_shift where farmid = @farm)) t)





if exists (select * from sysobjects where name like 'atten1temp')
drop table atten1temp

if exists (select * from sysobjects where name like 'atten2temp')
drop table atten2temp

declare @cmd as varchar(max) = '

   declare @start as nvarchar(max) = ''' + @start + '''
   declare @end as nvarchar(max) = ''' + @end + '''
declare @id as nvarchar(max) = ''' + @id + ''';
declare @farm as nvarchar(max) = ''' + @farm + ''';

WITH atten AS (
 

  SELECT
    distinct rtrim(FirstName) + '' '' + rtrim(LastName) as [Name],convert(decimal(10,2),tbl_attendance.Total_hours/60) as [Hours],
''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) as [Minimum Pay],
''$'' + cast(tbl_attendance.pay as nvarchar(max)) as [Calculated Pay],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),((tbl_attendance.Total_hours/60) * 15.75)-tbl_attendance.pay) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''No''
end as [Additional Pay Required],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''$'' + cast(tbl_attendance.pay as nvarchar(max)) 
end as [Final Pay], ''Payrate: '' + cast(tbl_pay.pay as nvarchar(max)) as pay, 




sum(A.total_hours)/60 as [th]



   FROM
      tbl_bayattendance A

	  inner join tbl_attendance on tbl_attendance.rosterid=A.rosterid
      INNER JOIN tbl_duty D
         ON A.rosterid = D.rosterid
     inner join tbl_worker on tbl_worker.workersid = D.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid where workerid  in(select workerid from tbl_duty where growerid = @id and day >= @start and day <= @end) and D.day >= @start and D.day <= @end and D.growerid=@id and jobtype = ''Per Hour'' and endsignature is not null and monitorid is null and shiftid in (select shiftid from tbl_shift where farmid = @farm)

group by tbl_worker.FirstName,tbl_worker.LastName,tbl_attendance.Total_hours,tbl_attendance.pay,tbl_pay.pay



)
SELECT * into atten1temp
FROM
   atten
   PIVOT ( sum(th) FOR pay IN (' + @tbl + ')) P;'

  exec(@cmd)

   declare @cmd2 as varchar(max) = '

   declare @start as nvarchar(max) = ''' + @start + '''
   declare @end as nvarchar(max) = ''' + @end + '''
declare @id as nvarchar(max) = ''' + @id + ''';
declare @farm as nvarchar(max) = ''' + @farm + ''';

WITH atten AS (
 

  SELECT
    distinct rtrim(FirstName) + '' '' + rtrim(LastName) as [Name],

	convert(decimal(10,2),tbl_attendance.Total_hours/60) as [Hours],
''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) as [Minimum Pay],
''$'' + cast(tbl_attendance.pay as nvarchar(max)) as [Calculated Pay],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),((tbl_attendance.Total_hours/60) * 15.75)-tbl_attendance.pay) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''No''
end as [Additional Pay Required],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''$'' + cast(tbl_attendance.pay as nvarchar(max)) 
end as [Final Pay],

	  isnull((select top 1 Code from tbl_pay_cat where Id = Rate_id) +'' - '','''') + cast(A.payrate as nvarchar(max)) as payrate ,sum(A.no_bay) as [th]
	
	
   FROM
      tbl_bayattendance A

	  inner join tbl_attendance on tbl_attendance.rosterid=A.rosterid
      INNER JOIN tbl_duty D
         ON A.rosterid = D.rosterid
     inner join tbl_worker on tbl_worker.workersid = D.workerid
 where workerid in(select workerid from tbl_duty where growerid = @id and day >= @start and day <= @end) and D.day >= @start and D.day <= @end and D.growerid=@id and jobtype = ''Per Bay'' and endsignature is not null and monitorid is null and shiftid in (select shiftid from tbl_shift where farmid = @farm)

group by tbl_worker.FirstName,tbl_worker.LastName,tbl_attendance.Total_hours,tbl_attendance.pay,A.payrate, A.Rate_id



)
SELECT * into atten2temp
FROM
   atten
   PIVOT (sum(th) FOR payrate IN (' + @tbl2 + ')) P;'

   exec(@cmd2)


declare @sql nvarchar(max)

set @sql = 'select 
case when a.name is not null then a.name else b.name end as Name, 
case when a.hours is not null then a.hours else b.hours end as Hours,
case when a.[Minimum Pay] is not null then a.[Minimum Pay] else b.[Minimum Pay] end as [Minimum Pay],
case when a.[Calculated Pay] is not null then a.[Calculated Pay] else b.[Calculated Pay] end as [Calculated Pay],
case when a.[Additional Pay Required] is not null then a.[Additional Pay Required] else b.[Additional Pay Required] end as [Additional Pay Required],
case when a.[Final Pay] is not null then a.[Final Pay] else b.[Final Pay] end as [Final Pay],
'+ @tbl +','+ @tbl2+' from atten1temp a
 left outer join atten2temp b 
   on a.name = b.name
   union
select 
case when a.name is not null then a.name else b.name end as Name, 
case when a.hours is not null then a.hours else b.hours end as Hours,
case when a.[Minimum Pay] is not null then a.[Minimum Pay] else b.[Minimum Pay] end as [Minimum Pay],
case when a.[Calculated Pay] is not null then a.[Calculated Pay] else b.[Calculated Pay] end as [Calculated Pay],
case when a.[Additional Pay Required] is not null then a.[Additional Pay Required] else b.[Additional Pay Required] end as [Additional Pay Required],
case when a.[Final Pay] is not null then a.[Final Pay] else b.[Final Pay] end as [Final Pay],
'+ @tbl +','+ @tbl2+' from atten1temp a
 right outer join atten2temp b 
   on a.name = b.name'
   exec (@sql)
  

  end

  else begin

  
set @tbl = (SELECT DISTINCT
stuff(
(
    SELECT  DISTINCT ', [Payrate: '+ cast(round(tbl_pay.pay,2) as varchar(max)) +']' FROM
	
	  tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid 
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Hour' and endsignature is not null and monitorid = @monitor and shiftid in (select shiftid from tbl_shift where farmid = @farm)
  FOR XML PATH('')
),1,1,'') 
FROM (SELECT DISTINCT tbl_pay.pay FROM
	
	  tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid 
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Hour' and endsignature is not null and monitorid = @monitor and shiftid in (select shiftid from tbl_shift where farmid = @farm)) t)

set @tbl2 = (SELECT DISTINCT
stuff(
(
    SELECT  DISTINCT ', [' + isnull((select top 1 Code from tbl_pay_cat where Id = Rate_id) +' - ','') + cast(round(tbl_bayattendance.payrate,2) as varchar(max)) +']' from tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid  
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Bay' and endsignature is not null and monitorid = @monitor and shiftid in (select shiftid from tbl_shift where farmid = @farm)
  FOR XML PATH('')
),1,1,'') 
FROM (SELECT DISTINCT tbl_bayattendance.payrate from tbl_duty
inner join tbl_attendance on tbl_duty.rosterid = tbl_attendance.rosterid 
inner join tbl_worker on tbl_worker.workersid = tbl_duty.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid
inner join tbl_bayattendance on tbl_duty.rosterid = tbl_bayattendance.rosterid  
where day >= @start and day <= @end and growerid = @id and jobtype = 'Per Bay' and endsignature is not null and monitorid = @monitor and shiftid in (select shiftid from tbl_shift where farmid = @farm)) t)





if exists (select * from sysobjects where name like 'atten1temp')
drop table atten1temp

if exists (select * from sysobjects where name like 'atten2temp')
drop table atten2temp

set @cmd  = '

   declare @start as nvarchar(max) = ''' + @start + '''
   declare @end as nvarchar(max) = ''' + @end + '''
declare @id as nvarchar(max) = ''' + @id + ''';
declare @monitor as nvarchar(max) = ''' + @monitor + ''';
declare @farm as nvarchar(max) = ''' + @farm + ''';

WITH atten AS (
 

  SELECT
    distinct rtrim(FirstName) + '' '' + rtrim(LastName) as [Name],convert(decimal(10,2),tbl_attendance.Total_hours/60) as [Hours],
''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) as [Minimum Pay],
''$'' + cast(tbl_attendance.pay as nvarchar(max)) as [Calculated Pay],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),((tbl_attendance.Total_hours/60) * 15.75)-tbl_attendance.pay) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''No''
end as [Additional Pay Required],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''$'' + cast(tbl_attendance.pay as nvarchar(max)) 
end as [Final Pay], ''Payrate: '' + cast(tbl_pay.pay as nvarchar(max)) as pay, 




sum(A.total_hours)/60 as [th]



   FROM
      tbl_bayattendance A

	  inner join tbl_attendance on tbl_attendance.rosterid=A.rosterid
      INNER JOIN tbl_duty D
         ON A.rosterid = D.rosterid
     inner join tbl_worker on tbl_worker.workersid = D.workerid
inner join tbl_pay on tbl_worker.payrate = tbl_pay.payid where workerid  in(select workerid from tbl_duty where growerid = @id and day >= @start and day <= @end) and D.day >= @start and D.day <= @end and D.growerid=@id and jobtype = ''Per Hour'' and endsignature is not null and monitorid = @monitor and shiftid in (select shiftid from tbl_shift where farmid = @farm)

group by tbl_worker.FirstName,tbl_worker.LastName,tbl_attendance.Total_hours,tbl_attendance.pay,tbl_pay.pay



)
SELECT * into atten1temp
FROM
   atten
   PIVOT ( sum(th) FOR pay IN (' + @tbl + ')) P;'

  exec(@cmd)

   set @cmd2 = '

   declare @start as nvarchar(max) = ''' + @start + '''
   declare @end as nvarchar(max) = ''' + @end + '''
declare @id as nvarchar(max) = ''' + @id + ''';
declare @monitor as nvarchar(max) = ''' + @monitor + ''';
declare @farm as nvarchar(max) = ''' + @farm + ''';

WITH atten AS (
 

  SELECT
    distinct rtrim(FirstName) + '' '' + rtrim(LastName) as [Name],

	convert(decimal(10,2),tbl_attendance.Total_hours/60) as [Hours],
''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) as [Minimum Pay],
''$'' + cast(tbl_attendance.pay as nvarchar(max)) as [Calculated Pay],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),((tbl_attendance.Total_hours/60) * 15.75)-tbl_attendance.pay) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''No''
end as [Additional Pay Required],
case 
when ((tbl_attendance.Total_hours/60) * 15.75) > tbl_attendance.pay then  ''$'' + cast(convert(decimal(10,2),(tbl_attendance.Total_hours/60) * 15.75) as nvarchar(max)) 
when ((tbl_attendance.Total_hours/60) * 15.75) < tbl_attendance.pay then  ''$'' + cast(tbl_attendance.pay as nvarchar(max)) 
end as [Final Pay],

	  isnull((select top 1 Code from tbl_pay_cat where Id = Rate_id) +'' - '','''') + cast(A.payrate as nvarchar(max)) as payrate ,sum(A.no_bay) as [th]
	
	
   FROM
      tbl_bayattendance A

	  inner join tbl_attendance on tbl_attendance.rosterid=A.rosterid
      INNER JOIN tbl_duty D
         ON A.rosterid = D.rosterid
     inner join tbl_worker on tbl_worker.workersid = D.workerid
 where workerid in(select workerid from tbl_duty where growerid = @id and day >= @start and day <= @end) and D.day >= @start and D.day <= @end and D.growerid=@id and jobtype = ''Per Bay'' and endsignature is not null and monitorid = @monitor and shiftid in (select shiftid from tbl_shift where farmid = @farm)

group by tbl_worker.FirstName,tbl_worker.LastName,tbl_attendance.Total_hours,tbl_attendance.pay,A.payrate, A.Rate_id



)
SELECT * into atten2temp
FROM
   atten
   PIVOT (sum(th) FOR payrate IN (' + @tbl2 + ')) P;'

   exec(@cmd2)



set @sql = 'select 
case when a.name is not null then a.name else b.name end as Name, 
case when a.hours is not null then a.hours else b.hours end as Hours,
case when a.[Minimum Pay] is not null then a.[Minimum Pay] else b.[Minimum Pay] end as [Minimum Pay],
case when a.[Calculated Pay] is not null then a.[Calculated Pay] else b.[Calculated Pay] end as [Calculated Pay],
case when a.[Additional Pay Required] is not null then a.[Additional Pay Required] else b.[Additional Pay Required] end as [Additional Pay Required],
case when a.[Final Pay] is not null then a.[Final Pay] else b.[Final Pay] end as [Final Pay],
'+ @tbl +','+ @tbl2+' from atten1temp a
 left outer join atten2temp b 
   on a.name = b.name
   union
select 
case when a.name is not null then a.name else b.name end as Name, 
case when a.hours is not null then a.hours else b.hours end as Hours,
case when a.[Minimum Pay] is not null then a.[Minimum Pay] else b.[Minimum Pay] end as [Minimum Pay],
case when a.[Calculated Pay] is not null then a.[Calculated Pay] else b.[Calculated Pay] end as [Calculated Pay],
case when a.[Additional Pay Required] is not null then a.[Additional Pay Required] else b.[Additional Pay Required] end as [Additional Pay Required],
case when a.[Final Pay] is not null then a.[Final Pay] else b.[Final Pay] end as [Final Pay],
'+ @tbl +','+ @tbl2+' from atten1temp a
 right outer join atten2temp b 
   on a.name = b.name'
   exec (@sql)
  



  end
GO
