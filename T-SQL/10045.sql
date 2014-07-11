
-- Change Exec1 field to Representative
UPDATE dbo.POLMAS  SET CSR = dbo.POLMAS_NEW.strExecCode
FROM dbo.POLMAS INNER JOIN dbo.POLMAS_NEW
	ON dbo.POLMAS.Old_Policy_ID = dbo.POLMAS_NEW.POLICY_ID

-- Change the Agent in CLNMAS
UPDATE    dbo.CLNMAS  SET AGENT = dbo.POLMAS_NEW.strExecCode
FROM dbo.CLNMAS INNER JOIN dbo.POLMAS_NEW
    ON dbo.CLNMAS.Old_Client_ID = dbo.POLMAS_NEW.CLIENT_ID