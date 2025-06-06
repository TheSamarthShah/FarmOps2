/****** Object:  StoredProcedure [dbo].[sp_breakCheck]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_breakCheck]
(
	@start time,
	@end time,
	@id int
)
AS
BEGIN



if (select count(*) from tbl_submitbreak where rosterid = @id 
and ((starttime < @start and endtime >= @start) or (starttime <= @end and endtime > @end) or (starttime >= @start and endtime <= @end))) > 0
begin
	select 0
end
else
begin
	if exists(select top 1 endtime from tbl_binattendance 
	where rosterid = @id 
	order by endtime desc)
	begin
		if (select count(*) from tbl_binattendance where rosterid = @id
		and  ((@start < starttime and @end > starttime) or (@start < endtime and @end > endtime))) > 0
		begin
			select 0
		end
		else
		begin
			select 1
		end
	end
	else
	begin
		if (select top 1 start_time from tbl_attendance 
		where rosterid = @id 
		order by start_time desc ) > @start
		begin
		select 0
	end
	else
	begin
		select 1
	end
end
end

end
GO
