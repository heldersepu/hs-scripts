USE dbENDX
GO

SET IDENTITY_INSERT tblPOITypesLookup ON
GO

INSERT INTO tblPOITypesLookup
	( POITypeID, POIType, Active )
VALUES
	( 2001, 'Police', 1 ),
	( 2002, 'Fire Dept', 1 ),
	( 2003, 'Churches', 1 ),
	( 2004, 'Gym', 1 ),
	( 2005, 'Banks', 1 ),
	( 2006, 'Post Offices', 1 ),
	( 2007, 'Schools', 1 )

SET IDENTITY_INSERT tblPOITypesLookup OFF

SELECT *
FROM dbENDX.dbo.tblPOITypesLookup
WHERE Active = 1
ORDER BY 1 DESC
