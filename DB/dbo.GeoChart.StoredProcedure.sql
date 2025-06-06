/****** Object:  StoredProcedure [dbo].[GeoChart]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GeoChart] 


(
    @day nvarchar(max)
)

AS
	

	 select case when city like '                    ' then 'Te Puke' else city end as city, count(distinct workerid) as count from tbl_duty 
 inner join tbl_shift on tbl_shift.shiftid = tbl_duty.shiftid
 inner join tbl_farms on tbl_farms.farmid = tbl_shift.farmid
 inner join tbl_address on addressid = tbl_shift.farmid
 where day = @day group by  city
GO
