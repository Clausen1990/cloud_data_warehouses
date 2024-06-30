IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
BEGIN
  DROP EXTERNAL TABLE [dbo].[fact_payment];
END

CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION    = 'fact_payment',
    DATA_SOURCE = [udacityazure_udacityazure_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT p.[payment_id], p.[date], p.[amount],  p.[rider_id]
FROM [dbo].[staging_payment] p;
GO

SELECT TOP 100 * FROM dbo.fact_payment
GO