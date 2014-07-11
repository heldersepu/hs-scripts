
-- Update the Accord form
Update [QFWinData_QQ010062].[dbo].[XMLTable]
SET Form1Name = 'Acord_PersAutoAppKY_2006_04_1'
where Old_Acord_ID is not null and
	Form1Name = 'Acord_PersAutoAppSC_2002_10_1'
