/****** Script for SelectTopNRows command from SSMS  ******/
(SELECT  top 5
      [LastName]
      ,[FirstName]
	  ,[FirmNameCust]
      ,[Addr1]
      ,[City]
      ,[State]
      ,[County]
      ,[ZipCode]
      ,[TypeEntity]
      ,[FormalSalutation]
      ,[InformalSalutation]


  FROM [A1003481D1].[dbo].[AFW_Customer]
  where FirmNameCust like 'mil%' or FirmNameCust like 'min%'  or FirmNameCust like 'mir%' or FirmNameCust like 'dep%'
  )

union

(SELECT    top 5
      [LastName]
      ,[FirstName]
	  ,[FirmNameCust]
      ,[Addr1]
      ,[City]
      ,[State]
      ,[County]
      ,[ZipCode]
      ,[TypeEntity]
      ,[FormalSalutation]
      ,[InformalSalutation]


  FROM [A1003481D1].[dbo].[AFW_Customer]
  where FirmNameCust is null
   )

SELECT
      [LastName]
      ,[FirstName]
	  ,[FirmNameCust]
      ,[Addr1]
      ,[City]
      ,[State]
      ,[County]
      ,[ZipCode]
      ,[TypeEntity]
      ,[FormalSalutation]
      ,[InformalSalutation]


  FROM [A1003481D1].[dbo].[AFW_Customer]
  where FirmNameCust is not null and FormalSalutation is null
