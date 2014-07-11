-- Update the DateSaved in the Quotes table

UPDATE dbo.QQQ_FL_Quotes
SET DateSaved = GETDATE()
WHERE (DateSaved IS NULL)

GO

UPDATE dbo.QQ_FL_Quotes
SET DateSaved = GETDATE()
WHERE (DateSaved IS NULL)