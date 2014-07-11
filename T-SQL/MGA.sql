USE QFWinData_QQ009458

-- Remove duplicates from table [Company]
	SELECT DISTINCT [Company].[Company], [Company].[Agency] INTO temp_comp FROM [Company]
	DELETE FROM [Company]
	INSERT INTO [Company] ( [Company],  [Agency]) SELECT temp_comp.[Company], temp_comp.[Agency] FROM temp_comp
	DROP TABLE temp_comp

-- Insert all the MGA to tblMGA
	DELETE FROM tblMGA
	INSERT INTO dbo.tblMGA (strMGA)
	SELECT DISTINCT Name
	FROM dbo.AFW_Company
	WHERE [Type] = 'B'

-- Create the relations between companies and MGA
	DELETE FROM tblMGACompany
	INSERT INTO dbo.tblMGACompany (intMGA, intCompany)
	Select MGA.intMGA, COMPA.intCompany from
	(SELECT distinct dbo.AFW_Company.CoCode, dbo.tblMGA.intMGA
	 FROM dbo.AFW_Company INNER JOIN
		dbo.tblMGA ON dbo.AFW_Company.Name = dbo.tblMGA.strMGA
	 where dbo.AFW_Company.[type]= 'B') MGA inner join

	(SELECT distinct dbo.AFW_Company.CoCode, dbo.AFW_Company.[ParentCoCode], dbo.[Company].Random as intCompany
	 FROM dbo.AFW_Company INNER JOIN
		dbo.[Company] ON dbo.AFW_Company.Name = dbo.[Company].[Company]
	 where dbo.AFW_Company.[type]<> 'B') COMPA
	 ON MGA.CoCode = COMPA.[ParentCoCode]

-- Add MGA to table POLMAS
	UPDATE dbo.POLMAS
	SET intMGA = dbo.tblMGA.intMGA
	FROM dbo.tblMGA INNER JOIN
		dbo.[MGA-POLMAS] ON dbo.tblMGA.strMGA = dbo.[MGA-POLMAS].strMGA INNER JOIN
		dbo.POLMAS ON dbo.[MGA-POLMAS].PolNo = dbo.POLMAS.POLICY_NUM AND dbo.[MGA-POLMAS].CustNo = dbo.POLMAS.Old_Client_ID

	UPDATE dbo.POLMAS
	SET Company = Left(dbo.[MGA-POLMAS].Company, 50)
	FROM dbo.[MGA-POLMAS] INNER JOIN
		dbo.POLMAS ON dbo.[MGA-POLMAS].PolNo = dbo.POLMAS.POLICY_NUM AND dbo.[MGA-POLMAS].CustNo = dbo.POLMAS.Old_Client_ID
