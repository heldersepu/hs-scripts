USE QFWinData_QQ010047

-- Remove all clients from the data with CSR = BJR, from the agency filter Assure South
DELETE  FROM CLNMAS
WHERE CSR_Clnmas = 'BJR' and Agency = 'Assure South'


