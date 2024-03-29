USE [REMSP3_CRM4]
GO

ALTER PROCEDURE [dbo].[usp_Contact_UpdateLead] @LeadRouterID VARCHAR(100),
	@first_name VARCHAR(50),
	@last_name VARCHAR(50),
	@address VARCHAR(100),
	@city VARCHAR(100),
	@state VARCHAR(2),
	@zip VARCHAR(12),
	@email VARCHAR(100),
	@UserField10 VARCHAR(250),
	@LeadSource VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [REMSP3_CRM4].[dbo].[Contacts]
	WITH (ROWLOCK)

	SET FirstName = @first_name,
		LastName = @last_name,
		Address1 = @address,
		City = @city,
		State = @state,
		Zip = @zip,
		email = @email,
		UserField10 = @UserField10,
		LeadSource = @LeadSource
	WHERE ContactID IN (
			SELECT EntityID
			FROM [REMSP3_CRM4].[dbo].[tblEntityExtras_Contacts](NOLOCK)
			WHERE EntityTypeID = 1
				AND ExtraKey = 'LeadRouterID'
				AND ExtraValue = @LeadRouterID
			)

	IF @@ROWCOUNT = 0
	BEGIN
		DECLARE @MyTableVar table(ContactID INT)

		INSERT INTO [REMSP3_CRM4].[dbo].[Contacts]
			(FirstName, LastName, Address1,
			City, State, Zip, email,
			UserField10, LeadSource)
		OUTPUT INSERTED.ContactID INTO @MyTableVar
		VALUES
		(
			@first_name, @last_name, @address,
			@city, @state, @zip, @email,
			@UserField10, @LeadSource
		)

		INSERT INTO REMSP3_CRM4.dbo.tblEntityExtras_Contacts (
			EntityTypeID,
			EntityID,
			ExtraKey,
			ExtraValue
			)
		SELECT
			1,
			ContactID,
			'LeadRouterID',
			@LeadRouterID
		FROM @MyTableVar

	END
END
