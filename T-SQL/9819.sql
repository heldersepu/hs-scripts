--Update the Suspect to Prospects
UPDATE    dbo.CLNMAS
SET              CSTATUS = 'P'
FROM         dbo.CLN INNER JOIN
     dbo.CLNMAS ON dbo.CLN.CustNo = dbo.CLNMAS.Old_Client_ID
WHERE     (dbo.CLN.TypeCust = 'S')

--Update the Inactive to Inactive
UPDATE    dbo.CLNMAS
SET              CSTATUS = 'I'
FROM         dbo.CLN INNER JOIN
     dbo.CLNMAS ON dbo.CLN.CustNo = dbo.CLNMAS.Old_Client_ID
WHERE     (dbo.CLN.Active = 'N')
