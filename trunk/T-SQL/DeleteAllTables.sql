-- Delete all tables on the current DB
EXEC sp_MSforeachtable @command1 = "DROP TABLE ?"