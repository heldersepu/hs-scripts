use QFWinData_Template_OLAM
go

SELECT  [Table Name] = i_s.TABLE_NAME,  [Column Name] = i_s.COLUMN_NAME,  [Description] = s.value
FROM  INFORMATION_SCHEMA.COLUMNS i_s
    LEFT OUTER JOIN   sys.extended_properties  s
    ON  s.major_id  = OBJECT_ID(i_s.TABLE_SCHEMA+'.'+i_s.TABLE_NAME)
    AND s.minor_id  = i_s.ORDINAL_POSITION
    AND s.name = 'MS_Description'
WHERE  OBJECTPROPERTY(OBJECT_ID(i_s.TABLE_SCHEMA+'.'+i_s.TABLE_NAME),    'IsMsShipped')=0
    AND i_s.TABLE_NAME = 'clnmas'
ORDER BY  i_s.TABLE_NAME, i_s.ORDINAL_POSITION

