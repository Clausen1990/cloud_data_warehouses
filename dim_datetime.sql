IF OBJECT_ID('dbo.dim_datetime') IS NOT NULL
BEGIN
  DROP EXTERNAL TABLE [dbo].[dim_datetime];
END

CREATE EXTERNAL TABLE dbo.dim_datetime
WITH (
    LOCATION    = 'dim_datetime',
    DATA_SOURCE = [udacityazure_udacityazure_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT DISTINCT *
FROM 
	(SELECT
	    t.[start_at] as date_id,
		YEAR(t.[start_at]) as year,
		DATEPART(Quarter, t.[start_at]) as quarter,
		MONTH(t.[start_at]) as month,
		DAY(t.[start_at]) as day,
		DATEPART(weekday, t.[start_at]) weekday,
		DATEPART(hour, t.[start_at]) hour,
		DATEPART(minute, t.[start_at]) minute,
		DATEPART(second, t.[start_at]) second
	FROM [dbo].[staging_trip] t
	UNION ALL
	SELECT 
	    t.[ended_at] as date_id,
		YEAR(t.[ended_at]) as year,
		DATEPART(Quarter, t.[ended_at]) as quarter,
		MONTH(t.[ended_at]) as month,
		DAY(t.[ended_at]) as day,
		DATEPART(weekday, t.[ended_at]) weekday,
		DATEPART(hour, t.[ended_at]) hour,
		DATEPART(minute, t.[ended_at]) minute,
		DATEPART(second, t.[ended_at]) second
	FROM [dbo].[staging_trip] t
	UNION ALL
	SELECT 
	    p.[date] as date_id,
		YEAR(p.[date]) as year,
		DATEPART(Quarter, p.[date]) as quarter,
		MONTH(p.[date]) as month,
		DAY(p.[date]) as day,
		DATEPART(weekday, p.[date]) weekday,
		00 as hour,
		00 as minute,
		00 as second
	FROM [dbo].[staging_payment] p) as all_datetimes
	ORDER BY date_id;
GO

SELECT TOP 100 * FROM dbo.dim_datetime
GO