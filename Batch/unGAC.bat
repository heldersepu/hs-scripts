@PROMPT $S
@CLS
@COLOR 0C
@ECHO.
@ECHO.
@ECHO  THIS SCRIPT WILL UNGAC DLL AND COPY DLL TO LOCAL BIN!
@ECHO     Are you sure you want to proceed?
@ECHO.
@PAUSE
@COLOR 0B
@CLS


@IISRESET /STOP
@ECHO.
@SET GACUTIL="C:\Program Files\Microsoft SDKs\Windows\v6.0A\bin\gacutil.exe"

:: START UNGAC

%GACUTIL% /U ApiProfile
%GACUTIL% /U App_Licenses
%GACUTIL% /U ATLibVB
%GACUTIL% /U DataExchange
%GACUTIL% /U eNActionAlerts
%GACUTIL% /U eNAddressParser
%GACUTIL% /U eNAjax
%GACUTIL% /U eNAuthentication
%GACUTIL% /U eNCacheExtension
%GACUTIL% /U eNCommonEntities
%GACUTIL% /U eNCommonInterfaces
%GACUTIL% /U eNContact
%GACUTIL% /U eNControls
%GACUTIL% /U eNCore
%GACUTIL% /U enCRMAccess
%GACUTIL% /U eNCRMData
%GACUTIL% /U eNCryptography
%GACUTIL% /U enEntities
%GACUTIL% /U eNGeoAware
%GACUTIL% /U eNGeServices
%GACUTIL% /U eNHomeSales
%GACUTIL% /U eNListingData
%GACUTIL% /U eNListings
%GACUTIL% /U eNMemberShip
%GACUTIL% /U eNMobile
%GACUTIL% /U eNMonitors
%GACUTIL% /U eNMSMQManager
%GACUTIL% /U eNNDXControls
%GACUTIL% /U enNDXDataServices
%GACUTIL% /U eNNeighborhoodServices
%GACUTIL% /U eNPassThroughIntegrations
%GACUTIL% /U eNPointsOfInterestData
%GACUTIL% /U enProfile
%GACUTIL% /U eNSocialNetwork
%GACUTIL% /U enTrendsService
%GACUTIL% /U eNWebserviceActivityLog
%GACUTIL% /U Gadgets
%GACUTIL% /U HMSClientTemplates
%GACUTIL% /U HmsREST
%GACUTIL% /U HUSPortal
%GACUTIL% /U HUSRegional
%GACUTIL% /U MasterSite
%GACUTIL% /U NETrci2WebDBUtils
%GACUTIL% /U NETrci2WebUserUtils
%GACUTIL% /U NETrci2XMLContentMgr
%GACUTIL% /U NETrciCustomerContext
%GACUTIL% /U NETrciDBUtils
%GACUTIL% /U NETrciFileWorks
%GACUTIL% /U NETrciHTMLForm
%GACUTIL% /U NETrciHTMLTable
%GACUTIL% /U NETrciImageMgr
%GACUTIL% /U NETrciMaps
%GACUTIL% /U NETrciMenu
%GACUTIL% /U NETrciNETHTMLForm
%GACUTIL% /U NETrciREMActivities
%GACUTIL% /U Newtonsoft.Json
%GACUTIL% /U Nustache.Core
%GACUTIL% /U rciNETREMSControls
%GACUTIL% /U rciWidgets
%GACUTIL% /U REMSP3
%GACUTIL% /U UIAccountAccess
%GACUTIL% /U UIActivities
%GACUTIL% /U UIAdmin
%GACUTIL% /U UIAdminSettings
%GACUTIL% /U UIAdminSharedControls
%GACUTIL% /U UIAgentTools
%GACUTIL% /U UIArticles
%GACUTIL% /U UIAutoProcessing
%GACUTIL% /U UIBusinessIntelligence
%GACUTIL% /U UICampaigns
%GACUTIL% /U UIContactProfile
%GACUTIL% /U UIContactProfileMobile
%GACUTIL% /U UIContentManager
%GACUTIL% /U UIDashboard
%GACUTIL% /U UIenContactProfile
%GACUTIL% /U UIeNCRM
%GACUTIL% /U UIeNDirect
%GACUTIL% /U UIEngage
%GACUTIL% /U UIeNPropertySearch
%GACUTIL% /U UIenSharedControls
%GACUTIL% /U UIeNSyndicationWidgets
%GACUTIL% /U UIHelpDesk
%GACUTIL% /U UIInfoCenter
%GACUTIL% /U UILeads
%GACUTIL% /U UIListingData
%GACUTIL% /U UIListings
%GACUTIL% /U UIListingWidgets
%GACUTIL% /U UINDXControls
%GACUTIL% /U UINewsLetterWidgets
%GACUTIL% /U UIPropertySearch
%GACUTIL% /U UIPropertySearchMobile
%GACUTIL% /U UIProxy
%GACUTIL% /U UIReports
%GACUTIL% /U UISettings
%GACUTIL% /U UISetup
%GACUTIL% /U UISharedControls
%GACUTIL% /U UISharedControlsMobile
%GACUTIL% /U UISharedControlsRMX
%GACUTIL% /U UISitemanager
%GACUTIL% /U UISocialNetwork
%GACUTIL% /U UISystem
%GACUTIL% /U UITemplateSites
%GACUTIL% /U UITrack
%GACUTIL% /U UIVirtualPages
%GACUTIL% /U UIWebsiteSetup
%GACUTIL% /U W2PLibrary
%GACUTIL% /U WSREMS
%GACUTIL% /U XMPAPI
%GACUTIL% /U eNSyndication
%GACUTIL% /U 404PhotoSync
%GACUTIL% /U ActionlessForm
%GACUTIL% /U AdminMenu
%GACUTIL% /U RemaxForm
%GACUTIL% /U eNSEOManager
%GACUTIL% /U eNPersistentData
%GACUTIL% /U eNSMSMessaging
%GACUTIL% /U eNDeliveryMessage
%GACUTIL% /U eNDataServices
%GACUTIL% /U eNDeliveryMessageUtils
%GACUTIL% /U eNMaintenanceDirector
%GACUTIL% /U eNViewStateExtension
%GACUTIL% /U enCustomersDB
%GACUTIL% /U eNEncryption
%GACUTIL% /U eNPersistenData
%GACUTIL% /U eNRealogyLeadDeliveryXML
%GACUTIL% /U NETrciPop3
%GACUTIL% /U NETrci2WebDBUtils.resources
%GACUTIL% /U NETrci2WebUserUtils.resources
%GACUTIL% /U NETrci2XMLContentMgr.resources
%GACUTIL% /U NETrciDBUtils.resources
%GACUTIL% /U NETrciHTMLForm.resources
%GACUTIL% /U NETrciHTMLTable.resources
%GACUTIL% /U NETrciImageMgr.resources
%GACUTIL% /U NETrciMenu.resources
%GACUTIL% /U NETrciBatch
%GACUTIL% /U NETrciContextAccess
%GACUTIL% /U NETrciEmail
%GACUTIL% /U NETrciENBilling
%GACUTIL% /U WcfServiceMaster

%GACUTIL% /U eNEmailCampaign
%GACUTIL% /U eNEmailSender
%GACUTIL% /U eNHomeValues
%GACUTIL% /U eNLogServices
%GACUTIL% /U eNNDXControls.XmlSerializers
%GACUTIL% /U eNRFGLeadDeliveryXML
%GACUTIL% /U eNSearchHandler
%GACUTIL% /U eNSearchHandler.XmlSerializers
%GACUTIL% /U eNSite
%GACUTIL% /U enSystemEvent
%GACUTIL% /U eNTemplate
%GACUTIL% /U eNUtilities
%GACUTIL% /U eNVirtualPages
%GACUTIL% /U enVOWListings
%GACUTIL% /U eNWebServiceClasses
%GACUTIL% /U eNWebServiceClasses.XmlSerializers
%GACUTIL% /U GadgetDashboard
%GACUTIL% /U HMSCRMData
%GACUTIL% /U HMSDemographics
%GACUTIL% /U LeadDeliveryXML
%GACUTIL% /U LeadEater
%GACUTIL% /U Phone
%GACUTIL% /U SEOUrlInfo
%GACUTIL% /U UIAgentTools.XmlSerializers
%GACUTIL% /U UIAutoProcessing.XmlSerializers
%GACUTIL% /U UIeNQATests
%GACUTIL% /U UIForeclosureSearch
%GACUTIL% /U rciWinGeneralClasses
%GACUTIL% /U UITest
%GACUTIL% /U eNAutoSuggest


@ECHO   Copying the files
::COPY \\enqa01\c$\WINDOWS\Microsoft.NET\Framework\v2.0.50727\CONFIG\web.config C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\CONFIG\web.config
::DEL C:\SecretAgent\wwwroot\common\bin\GadgetDashboard.dll

MD C:\SecretAgent\wwwroot\BlueHomes360\bin
MD C:\SecretAgent\wwwroot\ERABroker\bin
MD C:\SecretAgent\wwwroot\ERACorporate\bin
XCOPY C:\SecretAgent\wwwroot\common\bin\*.dll C:\SecretAgent\wwwroot\BlueHomes360\bin /Y /R /K /D
XCOPY C:\SecretAgent\wwwroot\common\bin\*.dll C:\SecretAgent\wwwroot\ERABroker\bin /Y /R /K /D
XCOPY C:\SecretAgent\wwwroot\common\bin\*.dll C:\SecretAgent\wwwroot\ERACorporate\bin /Y /R /K /D

@IISRESET

@COLOR 0A
@ECHO.
@ECHO.
@ECHO ALL DONE!
@ECHO.
@PAUSE
