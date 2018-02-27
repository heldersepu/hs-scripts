-- Restore from bkp created from the EC-CSR tool
RESTORE VERIFYONLY
  from disk = '\\external.prod.qq\SQLBackupDATA\IPRODHOST_QFWinData_QQ999999_Temp_full_2011-01-05.bkp'
  WITH PASSWORD = 'fReCAsWunuQAZuY?3@traBreye&eVu2t'

RESTORE DATABASE QFWinData_QQ004756
  from disk = '\\external.prod.qq\SQLBackupDATA\IPRODHOST_QFWinData_QQ999999_full_2011-01-05.bkp'
  WITH PASSWORD = 'fReCAsWunuQAZuY?3@traBreye&eVu2t'


-- Generic restore uses
RESTORE VERIFYONLY
  from disk = 'E:\Conversion\Conversion\EasyAppsPro\QQ006229\Database.accdb.bak'

RESTORE FILELISTONLY
  from disk = 'E:\Conversion\Conversion\EasyAppsPro\QQ006229\Database.accdb.bak'


RESTORE DATABASE Antrim_easyfile
  from disk = 'E:\Conversion\Conversion\Custom Conversions\QQ10434\Antrim-easyfile.bak'
  with replace,
  move 'EasyFile_Data' to 'E:\MSSQL\DATA\Antrim_easyfile_Data.mdf',
  move 'EASYFILE_Log' to 'E:\MSSQL\DATA\Antrim_easyfile_Log.ldf'

GO

RESTORE DATABASE Antrim_071911
  from disk = 'E:\Conversion\Conversion\Custom Conversions\QQ10434\071911-Antrim.bak'
  with replace,
  move 'EasyFile_Data' to 'E:\MSSQL\DATA\Antrim_071911_Data.mdf',
  move 'EASYFILE_Log' to 'E:\MSSQL\DATA\Antrim_071911_Log.ldf'

GO

RESTORE DATABASE Nationwide_Antrim
  from disk = 'E:\Conversion\Conversion\Custom Conversions\QQ10434\Nationwide-Antrim.bak'
  with replace,
  move 'EasyFile_Data' to 'E:\MSSQL\DATA\Nationwide_Antrim_Data.mdf',
  move 'EASYFILE_Log' to 'E:\MSSQL\DATA\Nationwide_Antrim_Log.ldf'

GO
