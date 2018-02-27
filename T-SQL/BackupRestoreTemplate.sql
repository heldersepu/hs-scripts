--# This script will backup the template from production 13b
--# and then restore it in iProd04

-- The File name for the backup. It must be in a common location.
DECLARE @strFileName nvarchar(256)
SET @strFileName = '\\external.prod.qq\SQLBackupDATA\Template\QFWinData_Template_OLAM_' +
	REPLACE(REPLACE(CONVERT(VARCHAR(19), GETDATE(), 120), ':','.'), ' ','_') + '.bak'

-- Make backup of the template database in 13B
DECLARE @strBackup nvarchar(512)
SET @strBackup = 'BACKUP DATABASE QFWinData_Template_OLAM ' + 
	'TO DISK = '''+ @strFileName + ''' WITH FORMAT;' 
EXEC DBC13BLNK.master.dbo.sp_executesql @strBackup
PRINT ' - - - '

-- Drop the current template and restore the backup
DROP DATABASE QFWinData_Template_OLAM

DECLARE @DataDirectory nvarchar(256)
SET	@DataDirectory = dbo.SQLServerDefault('Data')
IF RIGHT(@DataDirectory, 1) <> '\'
	SET		@DataDirectory = @DataDirectory + '\'
SET	@DataDirectory = @DataDirectory + 'QFWinData_Template_OLAM_Data.mdf'

DECLARE @LogDirectory nvarchar(256)
SET	@LogDirectory = dbo.SQLServerDefault('Log')
IF RIGHT(@LogDirectory, 1) <> '\'
	SET		@LogDirectory = @LogDirectory + '\'
SET	@LogDirectory = @LogDirectory + 'QFWinData_Template_OLAM_Log.ldf'	

RESTORE DATABASE QFWinData_Template_OLAM
  FROM DISK = @strFileName
  WITH REPLACE,
  MOVE 'QFWinData_Template_Data' TO @DataDirectory ,
  MOVE 'QFWinData_Template_Log' TO @LogDirectory
