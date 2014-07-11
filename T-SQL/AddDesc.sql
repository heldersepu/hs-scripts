--Add descriptions to the field names from table DESC
DECLARE @table varchar(50)
DECLARE @field varchar(50)
DECLARE @descr varchar(50)

DECLARE desc_cursor CURSOR FOR

SELECT [table], field_name, [desc]
FROM [desc]

OPEN desc_cursor
FETCH NEXT FROM desc_cursor INTO @table, @field, @descr

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_addextendedproperty 
		@name = N'MS_Description', @value = @descr,
		@level0type = N'User', @level0name = 'dbo',
		@level1type = N'Table',  @level1name = @table,
		@level2type = N'Column', @level2name = @field;

	FETCH NEXT FROM desc_cursor INTO @table, @field, @descr
END

CLOSE desc_cursor
DEALLOCATE desc_cursor
