DECLARE @TempStartDate DATETIME = '01/01/2014'
DECLARE @endDate DATETIME = '01/01/2015'

CREATE TABLE #TempTable (
	ID INT NOT NULL,
	WorkDate DATETIME NULL
	)

CREATE TABLE #dates (d DATETIME)

;WITH
L0 AS (SELECT 1 AS c UNION ALL SELECT 1),
L1 AS (SELECT 1 AS c FROM L0 A CROSS JOIN L0 B),
L2 AS (SELECT 1 AS c FROM L1 A CROSS JOIN L1 B),
L3 AS (SELECT 1 AS c FROM L2 A CROSS JOIN L2 B),
L4 AS (SELECT 1 AS c FROM L3 A CROSS JOIN L3 B),
Nums AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS i FROM L4)
INSERT INTO #dates
SELECT DATEADD(day,i-1, @TempStartDate)
FROM Nums WHERE i <= 1+DATEDIFF(day, @TempStartDate, @endDate)

DECLARE @dCount INT = 1
WHILE (@dCount <= 500)
BEGIN
	INSERT INTO #TempTable
	SELECT @dCount, d
	FROM #dates
	SET @dCount = @dCount + 1
END

SELECT * FROM #TempTable
DROP TABLE #TempTable
DROP TABLE #dates
