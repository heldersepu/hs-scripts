USE MASTER

DECLARE @dbname VARCHAR(64),
	@logfile VARCHAR(128)

DECLARE c1 CURSOR FOR
SELECT d.NAME, mf.NAME AS logfile
FROM sys.master_files mf
INNER JOIN sys.databases d
	ON mf.database_id = d.database_id
WHERE recovery_model_desc <> 'SIMPLE'
	AND d.NAME NOT IN ('master', 'model', 'msdb', 'tempdb')
	AND mf.type_desc = 'LOG'

OPEN c1
FETCH NEXT FROM c1 INTO @dbname, @logfile

WHILE @@fetch_status <> - 1
BEGIN
	BEGIN TRY
		EXEC('ALTER DATABASE [' + @dbname + '] SET RECOVERY SIMPLE')
		EXEC('USE [' + @dbname + '] checkpoint')
		EXEC('USE [' + @dbname + '] DBCC SHRINKFILE (' + @logfile + ', 1)')
	END TRY
	BEGIN CATCH
		 PRINT 'ERROR W/ DB: ' + @dbname
	END CATCH
	FETCH NEXT FROM c1 INTO @dbname, @logfile
END

CLOSE c1
DEALLOCATE c1
