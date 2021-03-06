DECLARE @sql NVARCHAR(MAX) = '';

SELECT @SQL = @SQL + 'ALTER TABLE ' + FK.TABLE_SCHEMA + '.[' + FK.TABLE_NAME + '] DROP CONSTRAINT [' + RTRIM(C.CONSTRAINT_NAME) + '];' + CHAR(13) + CHAR(10)
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK
	ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK
	ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU
	ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
INNER JOIN (
	SELECT i1.TABLE_NAME,
		i2.COLUMN_NAME
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS i1
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE i2
		ON i1.CONSTRAINT_NAME = i2.CONSTRAINT_NAME
	WHERE i1.CONSTRAINT_TYPE = 'PRIMARY KEY'
	) PT
	ON PT.TABLE_NAME = PK.TABLE_NAME

IF (@sql <> '') SELECT @sql += CHAR(13) + CHAR(10);

SELECT @sql += ' DROP TABLE ' + TABLE_SCHEMA + '.[' + TABLE_NAME + '];' + CHAR(13) + CHAR(10)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

IF (@sql = '') PRINT 'NO TABLES FOUND'
PRINT @sql

--EXEC Sp_executesql @sql
