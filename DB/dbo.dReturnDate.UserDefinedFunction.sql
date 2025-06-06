/****** Object:  UserDefinedFunction [dbo].[dReturnDate]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[dReturnDate]( @dFecha as datetime)
returns DATETIME
as
begin
     DECLARE @D AS datetimeoffset
     SET @D = CONVERT(datetimeoffset, @Dfecha) AT TIME ZONE 'New Zealand Standard Time'
     RETURN CONVERT(datetime, @D);
end
GO
