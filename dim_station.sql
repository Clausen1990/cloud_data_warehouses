IF OBJECT_ID('dbo.dim_station') IS NOT NULL
BEGIN
  DROP EXTERNAL TABLE [dbo].[dim_station];
END

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION    = 'dim_station',
    DATA_SOURCE = [udacityazure_udacityazure_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT s.[station_id], s.[name], s.[latitude],  s.[longitude]
FROM [dbo].[staging_station] s;
GO

SELECT TOP 100 * FROM dbo.dim_station
GO