/****** Object:  UserDefinedFunction [dbo].[MinutesToDuration]    Script Date: 01-04-2025 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MinutesToDuration]
(
    @minutes int 
)
RETURNS nvarchar(30)

AS
BEGIN
declare @hours  nvarchar(20)

SET @hours = 
    CASE WHEN @minutes >= 0 THEN
        (SELECT CAST((@minutes / 60) AS VARCHAR(10)) + ':' +  
                CASE WHEN (@minutes % 60) > 0 THEN
					CASE WHEN (@minutes % 60) < 10 THEN
						'0' + CAST((@minutes % 60) AS VARCHAR(2)) 
					ELSE
						CAST((@minutes % 60) AS VARCHAR(2)) 
					END
                ELSE
                    '00'
                END)
    ELSE 
        (SELECT CAST((@minutes / 60) AS VARCHAR(10)) + ':' +  
                CASE WHEN (@minutes % 60) < 0 THEN
                    CAST((@minutes % 60)*(-1) AS VARCHAR(2)) 
                ELSE
                    '00'
                END)
    END

return @hours
END
GO
