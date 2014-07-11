SELECT     sys.sysobjects.name + '.' + sys.syscolumns.name AS 'Table.Field'
FROM         sys.sysobjects INNER JOIN
                      sys.syscolumns ON sys.sysobjects.id = sys.syscolumns.id
WHERE     (sys.sysobjects.xtype = 'U')
ORDER BY sys.sysobjects.name