

DECLARE @FilePath VARCHAR(250) = '\\serverSolr01\solr\OpenHouse.csv'

--DROP TABLE [dbo].[tmpOpenHouseListings]
CREATE TABLE [dbo].[tmpOpenHouseListings] (ListingID BIGINT)

DECLARE @strSQL VARCHAR(500)
SET @strSQL = 'BULK INSERT tmpOpenHouseListings FROM ''' + @FilePath + ''' WITH (FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n'')'
EXEC (@strSQL)

CREATE CLUSTERED INDEX ix_tmpListings_ListingID ON [dbo].[tmpOpenHouseListings] (ListingID)
