
-- Create duplicate clients for those that have more than 250 images
INSERT INTO dbo.CLNMAS
      ([UNIQUE], CID, CSTATUS, CompanyName, LNAME, FNAME, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, HPHONE, WPHONE, Cell, Beeper, Phone2, DOB, SALUTATION,
      LANGUAGE, SOURCE, AGENCY, AGENT, BILLTOTAL, LASTBILL, ISQUOTE, ISAPP, ISMEMO, ISHOME, SPOUSE, SPOUSE_DOB, PHONETYPE, POWER10,
      isCOMMERCIAL, X_ADDRESS1, X_ADDRESS2, X_CITY, X_STATE, X_ZIP, LETTER_TO, X_ADD_TYPE, Email, DUMMY1, DUMMY2, DUMMY3, DUMMY4, DUMMY5,
      DUMMY6, DUMMY7, ISDUMMY1, ISDUMMY2, UserName, DateMigrated, rowguid, time_stamp, Fields_Added_3_1, Fields_Started_3_1, MiddleName,
      HyphenatedLast, SpousesMiddleName, SpousesHyphenatedLast, CSR_Clnmas, DBA, Referer, Source2, DateSold, MrMrs, Sex, Email2, Attention, TypeOfBusiness,
      ClientType, Occupation, SpousesOccupation, FEIN, HasLife, HasHome, TimeAdded, DialStyle, CrossReferenceID, SOURCE_DETAIL, DBA_Name,
      strDriverLicenseNamedInsured, strDriverLicenseSpouse, strDrvLicNamedInsuredState, strDrvLicSpouseState, strURL, strPhoneType6, strPhone6, strPhoneType7,
      strPhone7, strPhoneType8, strPhone8, strImage, strImageDirectory, intLastPage, intBusinessType, strEmergencyContact, datXDate, xDate, strXDateComm,
      strImageFileName, strQFversion, Old_Client_ID, LASTUPDATE, LASTFUNC)
SELECT     Client_ID, CID, CSTATUS, CompanyName + '_1' AS Expr2, LNAME, FNAME, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, HPHONE, WPHONE, Cell, Beeper, Phone2,
      DOB, SALUTATION, LANGUAGE, SOURCE, AGENCY, AGENT, BILLTOTAL, LASTBILL, ISQUOTE, ISAPP, ISMEMO, ISHOME, SPOUSE, SPOUSE_DOB, PHONETYPE,
      POWER10, isCOMMERCIAL, X_ADDRESS1, X_ADDRESS2, X_CITY, X_STATE, X_ZIP, LETTER_TO, X_ADD_TYPE, Email, DUMMY1, DUMMY2, DUMMY3, DUMMY4,
      DUMMY5, DUMMY6, DUMMY7, ISDUMMY1, ISDUMMY2, UserName, DateMigrated, rowguid, time_stamp, Fields_Added_3_1, Fields_Started_3_1, MiddleName,
      HyphenatedLast, SpousesMiddleName, SpousesHyphenatedLast, CSR_Clnmas, DBA, Referer, Source2, DateSold, MrMrs, Sex, Email2, Attention, TypeOfBusiness,
      ClientType, Occupation, SpousesOccupation, FEIN, HasLife, HasHome, TimeAdded, DialStyle, CrossReferenceID, SOURCE_DETAIL, DBA_Name,
      strDriverLicenseNamedInsured, strDriverLicenseSpouse, strDrvLicNamedInsuredState, strDrvLicSpouseState, strURL, strPhoneType6, strPhone6, strPhoneType7,
      strPhone7, strPhoneType8, strPhone8, strImage, strImageDirectory, intLastPage, intBusinessType, strEmergencyContact, datXDate, xDate, strXDateComm,
      strImageFileName, strQFversion, Old_Client_ID, LASTUPDATE, LASTFUNC
FROM         dbo.CLNMAS AS CLNMAS_1
WHERE     (Client_ID IN
      (SELECT Client_ID FROM dbo.Images
       GROUP BY Client_ID HAVING (COUNT(Client_ID) > 250)))


-- Cursor to update the ImageID over the 250 limit
DECLARE
  @counter INT,
  @intImages_ID INT,
  @intTempClie_ID INT,
  @intOldClient_ID INT,
  @intNewClient_ID INT
  SET @counter=0

DECLARE @myCursor CURSOR
SET @myCursor = CURSOR For
    SELECT DISTINCT dbo.Images.Client_ID, dbo.CLNMAS.Client_ID
    FROM dbo.Images INNER JOIN
        dbo.CLNMAS ON dbo.Images.Client_ID = dbo.CLNMAS.[UNIQUE]
    WHERE (dbo.Images.Client_ID IN
        (SELECT Client_ID  FROM dbo.Images
         GROUP BY Client_ID HAVING (COUNT(Client_ID) > 250)))
    ORDER BY dbo.Images.Client_ID, dbo.Images.Images_ID

OPEN @myCursor

FETCH NEXT FROM @myCursor
INTO @intImages_ID, @intOldClient_ID, @intNewClient_ID
SET @intTempClie_ID = @intOldClient_ID

WHILE @@FETCH_STATUS=0
BEGIN
    IF @intTempClie_ID = @intOldClient_ID
    BEGIN
        SET @counter=@counter+1
        IF @counter > 250
        BEGIN
            UPDATE dbo.Images SET dbo.Images.Client_ID=@intNewClient_ID
            WHERE dbo.Images.Images_ID=@intImages_ID
        END
    END
    ELSE
        SET @counter=1

    SET @intTempClie_ID = @intOldClient_ID
    FETCH NEXT FROM @myCursor
    INTO @intImages_ID, @intOldClient_ID, @intNewClient_ID
END

CLOSE @myCursor
DEALLOCATE @myCursor