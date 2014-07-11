@C:
@MD C:\TEMP
@CD C:\TEMP

@SET token=SecurityToken^=IbbJ%%20M3J3937PcUFlW7xCPeI3JqX2tP7yFTgrc1n%%20UtVG47RCV5o4tTKKzG6DkO9
@SET wCOMMAND="firefox"
@SET winmerge="C:\Program Files (x86)\WinMerge\WinMergeU.exe" /e
@SET site1=http://webservices2.eneighborhoods.com/PointOfInterestServices/POIService.svc

echo %token%

start %wCOMMAND%  "%site1%/GetPrivateSchools?%token%&Latitude=37.540778&Longitude=-77.433928&Radius=50"
start %wCOMMAND%  "%site1%/GetPrivateSchools_AllColumns?%token%&Latitude=37.540778&Longitude=-77.433928&Radius=50"
start %wCOMMAND%  "%site1%/GetPublicSchoolsByAgencyId?%token%&Latitude=37.540778&Longitude=-77.433928&AgencyId=5103240&Radius=50&RecordsToReturn=10"
start %wCOMMAND%  "%site1%/GetPublicSchoolsByAgencyId_AllColumns?%token%&Latitude=37.540778&Longitude=-77.433928&AgencyId=5103240&Radius=50&RecordsToReturn=10"
start %wCOMMAND%  "%site1%/GetPublicSchoolsByAgencyId_AllColumns_Inclusive?%token%&Latitude=37.540778&Longitude=-77.433928&AgencyId=5103240&Radius=50&RecordsToReturn=10"
start %wCOMMAND%  "%site1%/GetPublicSchoolsByAgencyId?%token%&Latitude=37.82046&Longitude=-77.433928&AgencyId=0628050&Radius=50"
start %wCOMMAND%  "%site1%/GetPublicSchools?%token%&Latitude=37.540778&Longitude=-77.433928&Radius=50&RecordsToReturn=10"
start %wCOMMAND%  "%site1%/GetHouseOfWorshipTypes?%token%"
start %wCOMMAND%  "%site1%/GetHouseOfWorshipByTpye?%token%&Latitude=37.540778&Longitude=-77.433928&AgencyId=5103240&HouseOfWorshipType=6&Radius=50"
start %wCOMMAND%  "%site1%/GetHouseOfWorship?%token%&Latitude=37.540778&Longitude=-77.433928&AgencyId=5103240&HouseOfWorshipType=6&Radius=50&NumberOfRecordsToReturn=10"
start %wCOMMAND%  "%site1%/GetPointsOfInterestTypes?%token%"
start %wCOMMAND%  "%site1%/GetPointsOfInterestByType?%token%&Latitude=37.540778&Longitude=-77.433928&PointsOfInterestTypeID=100&Radius=50"
start %wCOMMAND%  "%site1%/GetPointsOfInterestByType?%token%&Latitude=37.540778&Longitude=-77.433928&PointsOfInterestTypeID=200&Radius=50"
start %wCOMMAND%  "%site1%/GetPointsOfInterestByType?%token%&Latitude=37.540778&Longitude=-77.433928&PointsOfInterestTypeID=300&Radius=50"
start %wCOMMAND%  "%site1%/GetSchoolDistrictByState?%token%&State=AL"
start %wCOMMAND%  "%site1%/GetPointsOfInterestByLatLon?%token%&Latitude=37.540778&Longitude=-77.433928&Radius=50"
start %wCOMMAND%  "%site1%/GetPointsOfInterest?%token%&POITypeID=300&Latitude=33811217&Longitude=-84119360&Radius=20&NumberOfRecordsToReturn=10"
start %wCOMMAND%  "%site1%/WeatherStationsLookup?%token%&Latitude=26.367481&Longitude=-80.114723&StateFIPS=12&CountyFips=99&Radius=20&NumberOfRecordsToReturn=10"

@COLOR A1
@echo.
@echo.
@echo ALL DONE
@pause

