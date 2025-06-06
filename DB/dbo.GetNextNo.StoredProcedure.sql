/****** Object:  StoredProcedure [dbo].[GetNextNo]    Script Date: 01-04-2025 23:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNextNo]
    @ColumnName NVARCHAR(100),
    @NextValue NVARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @Prefix NVARCHAR(50),
            @TotalLength INT,
            @NextNo INT,
            @FormattedNextNo NVARCHAR(50);

    -- Fetch the column details from tbl_GetNextNo
    SELECT @Prefix = Prefix, 
           @TotalLength = TotalLength, 
           @NextNo = NextNo
    FROM tbl_GetNextNo
    WHERE ColumnName = @ColumnName;

    -- If the column is not found, raise an error
    IF @Prefix IS NULL
    BEGIN
        RAISERROR('Column name not found in tbl_GetNextNo', 16, 1);
        RETURN;
    END

    -- Format the NextNo by padding with leading zeros to fit the TotalLength
    SET @FormattedNextNo = @Prefix + RIGHT('0000000000' + CAST(@NextNo AS NVARCHAR(50)), @TotalLength - LEN(@Prefix));

    -- Set the output parameter
    SET @NextValue = @FormattedNextNo;

    -- Update the NextNo value in the table
    UPDATE tbl_GetNextNo
    SET NextNo = @NextNo + 1
    WHERE ColumnName = @ColumnName;

END;
GO
