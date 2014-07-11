SELECT TOP 2 * FROM DBC13BLNK.QFWinData_QQ011007.dbo.ClnMas
SELECT TOP 2 * FROM DBC13ALNK.QFWinData_QQ003475.dbo.ClnMas
SELECT TOP 2 * FROM  SITE2LNK.QFWinData_QQ002354.dbo.ClnMas
SELECT TOP 10 * FROM SITE02.QFWinData_QQ007224.dbo.Letters

-- Check for duplicate dates in the images table
SELECT FileDate, COUNT(FileDate) AS FileDateCount
FROM DBC13BLNK.QFWinData_QQ010522.dbo.Images
GROUP BY FileDate
ORDER BY FileDateCount DESC

-- Check for duplicated names in CLNMAS
SELECT DateMigrated, Client_ID, Old_Client_ID, CStatus, CompanyName,
	LName, FName, ADDRESS1, CITY, STATE, ZIP, HPHONE, CELL
FROM DBC13BLNK.QFWinData_QQ002215.dbo.ClnMas
WHERE CompanyName in (
	SELECT TOP 10 CompanyName
	FROM DBC13BLNK.QFWinData_QQ002215.dbo.ClnMas
	GROUP BY companyName
	ORDER BY COUNT(CompanyName) DESC
)
ORDER BY CompanyName, DateMigrated, Client_ID
