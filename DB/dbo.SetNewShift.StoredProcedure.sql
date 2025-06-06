/****** Object:  StoredProcedure [dbo].[SetNewShift]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SetNewShift] ( @today varchar(max),
 @supervisor varchar(max),
 @worker varchar(max))
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
if(select count(*) from tbl_attendance where rosterid in (select rosterid from tbl_duty where day = @today and workerid = @worker ) and end_time is not null ) > 0 begin
set @flag = 0
end
end else begin
set @flag = 0
end 


if @flag = 0 begin

set @id = (select shiftid from tbl_duty where day = @today and workerid = @supervisor)
set @monitor = (select monitorid from tbl_duty where day = @today and workerid = @supervisor)
set @category = (select cat from tbl_duty where day = @today and workerid = @supervisor)
set @grower = (select growerid from tbl_duty where day = @today and workerid = @supervisor)

insert into tbl_duty (shiftid, day, workerid, growerid, supervisorid, monitorid, cat) values (@id, @today, @worker, @grower, @supervisor, @monitor, @category)
END
end
GO
