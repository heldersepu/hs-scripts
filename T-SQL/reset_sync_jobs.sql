/******  Cleanup the table [Sync_Jobs]  ******/

DECLARE @myCOUNT INT = 100

SELECT @myCOUNT = COUNT(*)
FROM [dbSOLR].[dbo].[Sync_Jobs]
WHERE Active = 1

IF @myCOUNT < 10
BEGIN
	CREATE TABLE #tmpTable (
		[CoreID] [int] NOT NULL,
		[SourceID] [int] NOT NULL,
		[SyncTypeID] [int] NOT NULL,
		[SyncVariable] [varchar](500) NULL,
		[Active] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[LastRun] [datetime] NULL,
		[Duration] [int] NULL,
		[Thread] [int] NULL,
		[Frequency] [int] NOT NULL,
		[Note] [varchar](500) NULL
		)

	INSERT INTO #tmpTable
	SELECT CoreID, SourceID, SyncTypeID,
		SyncVariable, Active, CreateDate,
		LastRun, Duration, Thread,
		Frequency, Note
	FROM [dbSOLR].[dbo].[Sync_Jobs]
	WHERE Active = 1

	TRUNCATE TABLE [dbSOLR].[dbo].[Sync_Jobs]

	INSERT INTO [dbSOLR].[dbo].[Sync_Jobs]
	SELECT * FROM #tmpTable

	DROP TABLE #tmpTable
END
