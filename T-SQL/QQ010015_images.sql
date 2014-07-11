INSERT INTO dbo.Images
	(Policy_ID, Client_ID, Old_Policy_ID,
	Old_Client_ID, Old_Images_ID, FileName,
	Description, DateEntered, TimeEntered,
	CSR_Images, Directory)
SELECT dbo.POLMAS.POLICY_ID, dbo.POLMAS.CLIENT_ID, dbo.POLMAS.Old_Policy_ID,
	dbo.POLMAS.Old_Client_ID, dbo.Images_new.Images_ID, dbo.Images_new.FileName,
	dbo.Images_new.Description, dbo.Images_new.DateEntered, dbo.Images_new.TimeEntered,
	dbo.Images_new.CSR_Images, 'QQ010015\Converted\mExt' as Directory
FROM         dbo.Images_new INNER JOIN
	dbo.POLMAS ON dbo.Images_new.Policy_ID = dbo.POLMAS.Old_Policy_ID