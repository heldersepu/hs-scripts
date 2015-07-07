DECLARE @TempStartDate DATETIME = '01/01/2014'
DECLARE @endDate DATETIME = '01/01/2015'

CREATE TABLE #TempTable (
	ID INT NOT NULL,
	WorkDate DATETIME NULL
	)

DECLARE @dCount INT = 1
WHILE (@dCount <= 500)
BEGIN
	DECLARE @dt DATETIME = @TempStartDate
	WHILE @dt <= @endDate
	BEGIN
		INSERT INTO #TempTable
		VALUES (@dCount, @dt)

		SET @dt = DATEADD(DAY, 1, @dt)
	END
	SET @dCount = @dCount + 1
END

SELECT * FROM #TempTable
DROP TABLE #TempTable
