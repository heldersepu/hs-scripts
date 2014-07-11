USE QFWinData_QQ010047
-- Update all clients where the names that start with * to inactive
UPDATE CLNMAS SET CSTATUS = 'I' where CompanyName like '*%'

-- Update the Endorsement_policy_id
UPDATE POLMAS
SET Endorsement_policy_id = [FirstOfPOLICY_ID]
FROM POLMAS JOIN
 (
	SELECT Max(POLICY_ID) AS FirstOfPOLICY_ID, CLIENT_ID, Policy_Num FROM POLMAS
	WHERE PERIOD<>'Endorsement' GROUP BY  CLIENT_ID, Policy_Num
  ) P
 ON (POLMAS.CLIENT_ID = P.CLIENT_ID) AND (POLMAS.Policy_Num = P.Policy_Num)
WHERE (PERIOD='Endorsement') and (Endorsement_policy_id = 0);

