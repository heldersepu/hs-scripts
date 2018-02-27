
-- Update Rolodex table
UPDATE    dbo.Rolodex_Main
SET  Line1 = dbo.Rolodex_Main.COMPANY,

	 Line3 = Left(isnull(dbo.Rolodex_Main.Address, '') + ' ' +  isnull(dbo.Rolodex_Main.Suite, ''), 50) ,
	 Line4 = Left(isnull(dbo.Rolodex_Main.City, '') + ', ' + isnull(dbo.Rolodex_Main.State, '')  + ' ' + isnull(dbo.Rolodex_Main.Zip, ''), 50)  ,
	 Line5 = dbo.Rolodex_Main.TollFree
FROM  dbo.Rolodex_Main


