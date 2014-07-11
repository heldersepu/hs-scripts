UPDATE dbo.CLNMAS
SET Email = dbo.CLNMAS_NEW.Email
FROM dbo.CLNMAS INNER JOIN
    dbo.CLNMAS_NEW
    ON dbo.CLNMAS.Old_Client_ID = dbo.CLNMAS_NEW.CLIENT_ID
Where DateMigrated = '2011-07-08 15:25:53.563'