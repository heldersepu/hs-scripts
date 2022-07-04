--Import MDB table
SELECT * INTO QFWinData_QQ010900.dbo.CLNMAS_NEW
FROM OPENROWSET(
	'Microsoft.Jet.OLEDB.4.0',
	'\\external.prod.qq\hasp_temp\Conversion\import\QFWinData.mdb';
	'admin';'',
	'SELECT * FROM CLNMAS'
) AS [AccessTable]

