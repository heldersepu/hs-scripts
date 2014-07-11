-- Update CID in the CLNMAS table
UPDATE    dbo.CLNMAS
SET  CID = dbo.CLNMAS_new.CID,
	 WPHONE = dbo.CLNMAS_new.WPHONE,
	 Phone2 = dbo.CLNMAS_new.Phone2,
	 HPHONE = dbo.CLNMAS_new.HPHONE
FROM  dbo.CLNMAS INNER JOIN dbo.CLNMAS_new ON
	dbo.CLNMAS.Old_Client_ID = dbo.CLNMAS_new.CLIENT_ID

-- Update CSR in the POLMAS table
UPDATE    dbo.POLMAS
SET  CSR = dbo.POLMAS_new.CSR
FROM  dbo.POLMAS INNER JOIN dbo.POLMAS_new ON
	dbo.POLMAS.Old_Policy_ID = dbo.POLMAS_new.POLICY_ID

-- Update Fax number
UPDATE    dbo.CLNMAS
SET  Phone2 = WPHONE
FROM  dbo.CLNMAS
WHERE isCOMMERCIAL = 1

-- Update Work Phone
UPDATE    dbo.CLNMAS
SET  WPHONE = HPHONE
FROM  dbo.CLNMAS
WHERE isCOMMERCIAL = 1

-- Update Home Phone
UPDATE    dbo.CLNMAS
SET  HPHONE = Null
FROM  dbo.CLNMAS
WHERE isCOMMERCIAL = 1

-- Update Rolodex table
UPDATE    dbo.Rolodex_Main
SET  Line1 = dbo.Rolodex_Main.COMPANY,
	 Line2 = dbo.Rolodex_Main.ContactName,
	 Line3 = Left(isnull(dbo.Rolodex_Main.Address, '') + ' ' +  isnull(dbo.Rolodex_Main.Suite, ''), 50) ,
	 Line4 = Left(isnull(dbo.Rolodex_Main.City, '') + ', ' + isnull(dbo.Rolodex_Main.State, '')  + ' ' + isnull(dbo.Rolodex_Main.Zip, ''), 50)  ,
	 Line5 = dbo.Rolodex_Main.TollFree
FROM  dbo.Rolodex_Main


