USE SladeSIS
GO

-- beeper
CREATE VIEW dbo.beeper
AS
SELECT     MIN(dbo.RollodexMethod.Value) AS beeper, dbo.RollodexMethod.ProfileID
FROM         dbo.RollodexMethod INNER JOIN
        dbo.RollodexMethodType ON dbo.RollodexMethod.RollodexMethodTypeID = dbo.RollodexMethodType.RollodexMethodTypeID
WHERE     (dbo.RollodexMethodType.RollodexMethodTypeID = 154)
GROUP BY dbo.RollodexMethod.ProfileID;
GO


-- Cell
CREATE VIEW dbo.Cell
AS
SELECT     MIN(dbo.RollodexMethod.Value) AS Cell, dbo.RollodexMethod.ProfileID
FROM         dbo.RollodexMethod INNER JOIN
        dbo.RollodexMethodType ON dbo.RollodexMethod.RollodexMethodTypeID = dbo.RollodexMethodType.RollodexMethodTypeID
WHERE     (dbo.RollodexMethodType.RollodexMethodTypeID = 153)
GROUP BY dbo.RollodexMethod.ProfileID;
GO


-- Company
CREATE VIEW dbo.Company
AS
SELECT     dbo.CompanyNAIC.CompanyNAICID, dbo.Profile.FName AS Company
FROM         dbo.CompanyNAIC INNER JOIN
        dbo.Profile ON dbo.CompanyNAIC.ProfileID = dbo.Profile.ProfileID
GROUP BY dbo.CompanyNAIC.CompanyNAICID, dbo.Profile.FName;
GO


-- CSR
CREATE VIEW dbo.CSR
AS
SELECT     dbo.Profile.FName, dbo.Profile.LName, dbo.Profile.ProfileID
FROM         dbo.Profile INNER JOIN
        dbo.ProfileClassLookup ON dbo.Profile.ProfileID = dbo.ProfileClassLookup.ProfileID INNER JOIN
        dbo.ProfileClass ON dbo.ProfileClassLookup.ProfileClassID = dbo.ProfileClass.ProfileClassID
WHERE     (dbo.ProfileClass.ProfileClassID = 7);
GO


-- Email1
CREATE VIEW dbo.Email1
AS
SELECT     dbo.RollodexMethod.ProfileID, MIN(dbo.RollodexMethod.Value) AS Email1
FROM         dbo.RollodexMethod INNER JOIN
                      dbo.RollodexMethodType ON dbo.RollodexMethod.RollodexMethodTypeID = dbo.RollodexMethodType.RollodexMethodTypeID
WHERE     (dbo.RollodexMethodType.RollodexMethodTypeID = 101)
GROUP BY dbo.RollodexMethod.ProfileID;
GO


-- Email2
CREATE VIEW dbo.Email2
AS
SELECT     dbo.RollodexMethod.ProfileID, MIN(dbo.RollodexMethod.Value) AS Email2
FROM         dbo.RollodexMethod INNER JOIN
        dbo.RollodexMethodType ON dbo.RollodexMethod.RollodexMethodTypeID = dbo.RollodexMethodType.RollodexMethodTypeID
WHERE     (dbo.RollodexMethodType.RollodexMethodTypeID = 102)
GROUP BY dbo.RollodexMethod.ProfileID;
GO


-- Fax
CREATE VIEW dbo.Fax
AS
SELECT     MIN(dbo.RollodexMethod.Value) AS Fax, dbo.RollodexMethod.ProfileID
FROM         dbo.RollodexMethod INNER JOIN
        dbo.RollodexMethodType ON dbo.RollodexMethod.RollodexMethodTypeID = dbo.RollodexMethodType.RollodexMethodTypeID
WHERE     (dbo.RollodexMethodType.RollodexMethodTypeID = 3)
GROUP BY dbo.RollodexMethod.ProfileID;
GO


-- HPhone
CREATE VIEW dbo.HPhone
AS
SELECT     MIN(dbo.RollodexMethod.Value) AS HPhone, dbo.RollodexMethod.ProfileID
FROM         dbo.RollodexMethod INNER JOIN
        dbo.RollodexMethodType ON dbo.RollodexMethod.RollodexMethodTypeID = dbo.RollodexMethodType.RollodexMethodTypeID
WHERE     (dbo.RollodexMethodType.RollodexMethodTypeID = 1)
GROUP BY dbo.RollodexMethod.ProfileID;
GO


-- NameInsured
CREATE VIEW dbo.NameInsured
AS
SELECT  TOP (100) PERCENT  dbo.Profile.ProfileID, dbo.Profile.FName, dbo.Profile.MName, dbo.Profile.LName, dbo.Profile.Title, dbo.Profile.DOB, dbo.Profile.TaxID,
        dbo.Profile.SSN, dbo.Profile.LicenseNo, dbo.Profile.Salutation, dbo.ProfileClassLookup.RelationID, dbo.ClientIndividual.Relation, dbo.Profile.ActiveInd
FROM    dbo.Profile INNER JOIN
        dbo.ProfileClassLookup ON dbo.Profile.ProfileID = dbo.ProfileClassLookup.ProfileID INNER JOIN
        dbo.ClientIndividual ON dbo.Profile.ProfileID = dbo.ClientIndividual.ProfileID
GROUP BY dbo.Profile.ProfileID, dbo.Profile.FName, dbo.Profile.MName, dbo.Profile.LName, dbo.Profile.Title, dbo.Profile.DOB, dbo.Profile.TaxID, dbo.Profile.SSN,
        dbo.Profile.LicenseNo, dbo.ClientIndividual.Relation, dbo.ProfileClassLookup.ProfileClassID, dbo.Profile.Salutation, dbo.ProfileClassLookup.RelationID,
        dbo.Profile.ActiveInd
HAVING      (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation = 'Insured') OR
        (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation IS NULL) OR
        (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation = '')
ORDER BY dbo.Profile.ProfileID;
GO


-- Spouse
CREATE VIEW dbo.Spouse
AS
SELECT  TOP (100) PERCENT  dbo.Profile.ProfileID, dbo.Profile.FName, dbo.Profile.MName, dbo.Profile.LName, dbo.Profile.Title, dbo.Profile.DOB, dbo.Profile.TaxID,
        dbo.Profile.SSN, dbo.Profile.LicenseNo, dbo.ProfileClassLookup.RelationID
FROM    dbo.Profile INNER JOIN
        dbo.ProfileClassLookup ON dbo.Profile.ProfileID = dbo.ProfileClassLookup.ProfileID INNER JOIN
        dbo.ClientIndividual ON dbo.Profile.ProfileID = dbo.ClientIndividual.ProfileID
GROUP BY dbo.Profile.ProfileID, dbo.Profile.FName, dbo.Profile.MName, dbo.Profile.LName, dbo.Profile.Title, dbo.Profile.DOB, dbo.Profile.TaxID, dbo.Profile.SSN,
        dbo.Profile.LicenseNo, dbo.ClientIndividual.Relation, dbo.ProfileClassLookup.ProfileClassID, dbo.ProfileClassLookup.RelationID
HAVING  (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation = 'Spouse') OR
        (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation = 'Wife') OR
        (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation = 'Fiance') OR
        (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation = 'Fiancee') OR
        (dbo.ProfileClassLookup.ProfileClassID = 9) AND (dbo.ClientIndividual.Relation = 'Partner')
ORDER BY dbo.Profile.ProfileID;
GO


-- WPhone
CREATE VIEW dbo.WPhone
AS
SELECT     MIN(dbo.RollodexMethod.Value) AS WPhone, dbo.RollodexMethod.ProfileID
FROM         dbo.RollodexMethod INNER JOIN
        dbo.RollodexMethodType ON dbo.RollodexMethod.RollodexMethodTypeID = dbo.RollodexMethodType.RollodexMethodTypeID
WHERE     (dbo.RollodexMethodType.RollodexMethodTypeID = 2)
GROUP BY dbo.RollodexMethod.ProfileID;
GO



-- myCLNMAS
CREATE VIEW dbo.myCLNMAS
AS
SELECT  TOP (100) PERCENT  dbo.Profile.ProfileID, dbo.Profile.FName AS CompanyName1, dbo.Profile.CompanyName AS CompanyName2, dbo.Profile.SortName,
        dbo.Address.Addr1, dbo.Address.Addr2, dbo.Address.City, dbo.Address.StateCode, dbo.Address.ZipCode, dbo.Address.County, dbo.Profile.Comments,
        dbo.ProfileStatus.Description AS CStatus, dbo.Email1.Email1, dbo.Email2.Email2, dbo.beeper.beeper, dbo.Fax.Fax, dbo.WPhone.WPhone, dbo.HPhone.HPhone,
        dbo.Cell.Cell
FROM dbo.Profile LEFT OUTER JOIN
        dbo.ProfileStatus ON dbo.Profile.ProfileStatusID = dbo.ProfileStatus.ProfileStatusID LEFT OUTER JOIN
        dbo.Cell ON dbo.Profile.ProfileID = dbo.Cell.ProfileID LEFT OUTER JOIN
        dbo.Email2 ON dbo.Profile.ProfileID = dbo.Email2.ProfileID LEFT OUTER JOIN
        dbo.Email1 ON dbo.Profile.ProfileID = dbo.Email1.ProfileID LEFT OUTER JOIN
        dbo.HPhone ON dbo.Profile.ProfileID = dbo.HPhone.ProfileID LEFT OUTER JOIN
        dbo.beeper ON dbo.Profile.ProfileID = dbo.beeper.ProfileID LEFT OUTER JOIN
        dbo.Fax ON dbo.Profile.ProfileID = dbo.Fax.ProfileID LEFT OUTER JOIN
        dbo.WPhone ON dbo.Profile.ProfileID = dbo.WPhone.ProfileID LEFT OUTER JOIN
        dbo.ProfileClassLookup ON dbo.Profile.ProfileID = dbo.ProfileClassLookup.ProfileID LEFT OUTER JOIN
        dbo.Address ON dbo.Profile.ProfileID = dbo.Address.ProfileID
WHERE     (dbo.Address.AddressTypeID = 1) AND (dbo.ProfileClassLookup.ProfileClassID = 1)
ORDER BY dbo.Profile.ProfileID;
GO


-- myIMAGES
CREATE VIEW dbo.myIMAGES
AS
SELECT     dbo.TFItem.TFFolderID, CONVERT(nvarchar(25), dbo.TFItem.TFileIndex) + '-' + dbo.TFDocument.Filename AS dFileName, dbo.TFDocument.TFDocumentID,
        dbo.TFDocument.DocDesc, dbo.TFDocument.Ext, dbo.TFDocument.OwnerID, dbo.TFItem.EmployeeID, dbo.TFFolder.FolderDt, dbo.TFDocument.LastUpdatedDt,
        LEFT(CONVERT(nvarchar(25), dbo.TFFolder.FolderDt, 120), 4) + '\' + SUBSTRING(CONVERT(nvarchar(25), dbo.TFFolder.FolderDt, 120), 6, 2)
        + SUBSTRING(CONVERT(nvarchar(25), dbo.TFFolder.FolderDt, 120), 9, 2) AS dFolder
FROM         dbo.TFDocument INNER JOIN
        dbo.TFItem ON dbo.TFDocument.TFDocumentID = dbo.TFItem.TFDocumentID INNER JOIN
        dbo.TFFolder ON dbo.TFItem.TFFolderID = dbo.TFFolder.TFFolderID;
GO


-- myPOLMAS
CREATE VIEW dbo.myPOLMAS
AS
SELECT  dbo.Policy.Client_ProfileID, dbo.Policy.PolicyID, dbo.Policy.EffDt, dbo.Policy.ExpDt, dbo.Policy.PolicyNo, dbo.PolLOB.Description AS LOB, dbo.PolLOB.LOBCode,
        dbo.Policy.NAIC_ProfileID, dbo.Policy.Status, dbo.POLStatus.Status AS PStatus, dbo.Company.Company, dbo.PolTracking.Premium,
        dbo.PolTracking.Prod_EmployeeID, dbo.PolTracking.CSR_EmployeeID
FROM    dbo.Policy LEFT OUTER JOIN
        dbo.PolTracking ON dbo.Policy.PolicyID = dbo.PolTracking.PolicyID LEFT OUTER JOIN
        dbo.Company ON dbo.Policy.CompanyNAICID = dbo.Company.CompanyNAICID LEFT OUTER JOIN
        dbo.PolLOB ON dbo.Policy.PolLOBID = dbo.PolLOB.PolLOBID LEFT OUTER JOIN
        dbo.POLStatus ON dbo.Policy.Status = dbo.POLStatus.StatusCode;
GO


