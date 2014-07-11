INSERT INTO dbo.XMLTable
                      (XMLDataPage1, XMLDataPage2, XMLDataPage3, XMLDataPage4, XMLDataPage5, Form1Name, Client_ID, Policy_ID, Old_Acord_ID, Old_Policy_ID,
                      Old_Client_ID, XMLDataDetail, FormType, Detail_Form1Name, FormID, FormVersion, DateAdded, DateUpdated, txtTodaysDate, Description,
                      Detail_DateAdded, Detail_DateUpdated, Detail_txtTodaysDate, Detail_Description, Group_Number, Group_Name, IsActive, ToBePrinted, WasPrinted,
                      IsAcord, IsDetail, IsInvoice, DatePrinted, TimePrinted, Dummy1, Dummy2, Dummy3, Dummy4, Dummy5, Dummy6, Dummy7, Dummy8, Dummy9,
                      Dummy10, Dummy11, Dummy12, Dummy13, Dummy14, Dummy15, Dummy16, Dummy17, Dummy18, Dummy19, Dummy20, Dummy21, Dummy22,
                      Dummy23, Dummy24)
SELECT     dbo.XMLTable_new.XMLDataPage1, dbo.XMLTable_new.XMLDataPage2, dbo.XMLTable_new.XMLDataPage3, dbo.XMLTable_new.XMLDataPage4,
                      dbo.XMLTable_new.XMLDataPage5, dbo.XMLTable_new.Form1Name, dbo.POLMAS.CLIENT_ID, dbo.POLMAS.POLICY_ID,
                      dbo.XMLTable_new.Acord_ID, dbo.POLMAS.Old_Policy_ID, dbo.POLMAS.Old_Client_ID, dbo.XMLTable_new.XMLDataDetail,
                      dbo.XMLTable_new.FormType, dbo.XMLTable_new.Detail_Form1Name, dbo.XMLTable_new.FormID, dbo.XMLTable_new.FormVersion,
                      dbo.XMLTable_new.DateAdded, dbo.XMLTable_new.DateUpdated, dbo.XMLTable_new.txtTodaysDate, dbo.XMLTable_new.Description,
                      dbo.XMLTable_new.Detail_DateAdded, dbo.XMLTable_new.Detail_DateUpdated, dbo.XMLTable_new.Detail_txtTodaysDate,
                      dbo.XMLTable_new.Detail_Description, dbo.XMLTable_new.Group_Number, dbo.XMLTable_new.Group_Name, dbo.XMLTable_new.IsActive,
                      dbo.XMLTable_new.ToBePrinted, dbo.XMLTable_new.WasPrinted, dbo.XMLTable_new.IsAcord, dbo.XMLTable_new.IsDetail,
                      dbo.XMLTable_new.IsInvoice, dbo.XMLTable_new.DatePrinted, dbo.XMLTable_new.TimePrinted, dbo.XMLTable_new.Dummy1,
                      dbo.XMLTable_new.Dummy2, dbo.XMLTable_new.Dummy3, dbo.XMLTable_new.Dummy4, dbo.XMLTable_new.Dummy5, dbo.XMLTable_new.Dummy6,
                       dbo.XMLTable_new.Dummy7, dbo.XMLTable_new.Dummy8, dbo.XMLTable_new.Dummy9, dbo.XMLTable_new.Dummy10,
                      dbo.XMLTable_new.Dummy11, dbo.XMLTable_new.Dummy12, dbo.XMLTable_new.Dummy13, dbo.XMLTable_new.Dummy14,
                      dbo.XMLTable_new.Dummy15, dbo.XMLTable_new.Dummy16, dbo.XMLTable_new.Dummy17, dbo.XMLTable_new.Dummy18,
                      dbo.XMLTable_new.Dummy19, dbo.XMLTable_new.Dummy20, dbo.XMLTable_new.Dummy21, dbo.XMLTable_new.Dummy22,
                      dbo.XMLTable_new.Dummy23, dbo.XMLTable_new.Dummy24
FROM         dbo.POLMAS_new INNER JOIN
                      dbo.XMLTable_new ON dbo.POLMAS_new.POLICY_ID = dbo.XMLTable_new.Policy_ID INNER JOIN
                      dbo.POLMAS ON dbo.POLMAS_new.[UNIQUE] = dbo.POLMAS.[UNIQUE]