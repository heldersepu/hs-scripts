USE dbReplObject

SELECT t.*
FROM (
	SELECT listingSourceId,
		COUNT(listingSourceId) AS dcount
	FROM (
		SELECT listingSourceId
		FROM tblListingCore
		WHERE SiteID < 60980000
		) t
	GROUP BY listingSourceId
	) t
INNER JOIN (
	SELECT DISTINCT ls.[ListingSourceID]
	FROM [ListingSources] ls
	INNER JOIN [listingsourcesitelinks] lsk
		ON ls.ListingSourceID = lsk.ListingSourceID
	INNER JOIN [sites] s
		ON lsk.siteID = s.siteID
	WHERE s.corporateID = 60000000
		AND lsk.active = 1
		AND s.SiteStatusID IN (200,300,400)
	UNION SELECT 79965
	UNION SELECT 79964
	UNION SELECT 0
	) B
	ON t.[ListingSourceID] = B.[ListingSourceID]
ORDER BY dcount DESC
