USE [DB_SRC]
GO

-- RECALCULATE ACCRUALS FOR A LIST OF EMPLOYEES

CREATE TABLE #EMPLOYEES (ID INT, Buckets VARCHAR(100))
INSERT INTO #EMPLOYEES
VALUES
	(22, '3,4,5,'),
	(81, '3,5,'),
	(91, '4,5,6,')

DECLARE @EmployeeId INT
DECLARE @Buckets VARCHAR(100)
DECLARE @Bucket INT, @pos INT
DECLARE bCursor CURSOR FOR
SELECT * FROM #EMPLOYEES

OPEN bCursor
FETCH NEXT FROM bCursor INTO @EmployeeId, @Buckets
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @EmployeeId

	WHILE CHARINDEX(',', @Buckets) > 0
	BEGIN
		SET @pos = CHARINDEX(',', @Buckets)
		SET @Bucket = CAST(SUBSTRING(@Buckets, 1, @pos-1) AS INT)
		SET @Buckets = SUBSTRING(@Buckets, @pos+1, LEN(@Buckets)-@pos)

		EXEC [dbo].[AddAccruals] @EmployeeId, @Bucket
	END
	FETCH NEXT FROM bCursor INTO @EmployeeId
END

CLOSE bCursor
DEALLOCATE bCursor
DROP TABLE #EMPLOYEES

GO
