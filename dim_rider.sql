IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
  DROP EXTERNAL TABLE [dbo].[dim_rider];
END

CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION    = 'dim_rider',
    DATA_SOURCE = [udacityazure_udacityazure_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT 
    r.[rider_id], r.[first], r.[last], r.[address], 
    TRY_CONVERT(DATE, LEFT(r.[birthday], 10)) as birthday, 
    TRY_CONVERT(DATE, LEFT(r.[account_start_date], 10)) AS account_start_date, 
    TRY_CONVERT(DATE, LEFT(r.[account_end_date], 10)) AS account_end_date, 
    TRY_CAST(r.[is_member] AS BIT) AS is_member
FROM [dbo].[staging_rider] r;
GO

SELECT TOP 100 * FROM dbo.dim_rider
GO