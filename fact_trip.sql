IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
BEGIN
  DROP EXTERNAL TABLE [dbo].[fact_trip];
END

CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION    = 'fact_trip',
    DATA_SOURCE = [udacityazure_udacityazure_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT t.[trip_id],
       t.[rideable_type],
       t.[start_at],
       t.[ended_at],
       DATEDIFF(SECOND, TRY_CONVERT(DATETIME2,t.[start_at],20), TRY_CONVERT(DATETIME2, t.[ended_at],20)) AS duration_seconds,
       t.[start_station_id],
       t.[end_station_id],
       t.[rider_id],
       DATEDIFF(YEAR, r.[birthday],TRY_CONVERT(DATE, LEFT(t.[start_at], 10))) AS rider_age,
       r.birthday
FROM [dbo].[staging_trip] t
JOIN [dbo].[dim_rider] r ON r.[rider_id] = t.[rider_id];
GO

SELECT TOP 100 * FROM dbo.fact_trip
GO
