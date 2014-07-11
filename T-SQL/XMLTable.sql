USE QFWinData_QQ009835

DELETE FROM dbo.XMLTable
WHERE Old_Acord_ID is not null

INSERT INTO dbo.XMLTable
  (Client_ID, Policy_ID, Old_Policy_ID, Old_Client_ID, Old_Acord_ID, XMLDataPage1, XMLDataPage2, XMLDataPage3, XMLDataPage4, XMLDataPage5, XMLDataDetail,
  FormType, Form1Name, Detail_Form1Name, FormID, FormVersion, DateAdded, DateUpdated, txtTodaysDate, Description, Detail_DateAdded, Detail_DateUpdated,
  Detail_txtTodaysDate, Detail_Description, Group_Number, Group_Name, IsActive, ToBePrinted, WasPrinted, IsAcord, IsDetail, IsInvoice, DatePrinted, TimePrinted,
  Dummy1, Dummy2, Dummy3, Dummy4, Dummy5, Dummy6, Dummy7, Dummy8, Dummy9, Dummy10, Dummy11, Dummy12, Dummy13, Dummy14, Dummy15,
  Dummy16, Dummy17, Dummy18, Dummy19, Dummy20, Dummy21, Dummy22, Dummy23, Dummy24, TimeEntered, CurrentCertHolder, CSR_XmlTable)
SELECT dbo.POLMAS.CLIENT_ID, dbo.POLMAS.POLICY_ID, dbo.POLMAS.Old_Policy_ID, dbo.POLMAS.Old_Client_ID, dbo.XMLTable_new2.Acord_ID,
  dbo.XMLTable_new2.XMLDataPage1, dbo.XMLTable_new2.XMLDataPage2, dbo.XMLTable_new2.XMLDataPage3, dbo.XMLTable_new2.XMLDataPage4,
  dbo.XMLTable_new2.XMLDataPage5, dbo.XMLTable_new2.XMLDataDetail, dbo.XMLTable_new2.FormType, dbo.XMLTable_new2.Form1Name,
  dbo.XMLTable_new2.Detail_Form1Name, dbo.XMLTable_new2.FormID, dbo.XMLTable_new2.FormVersion, dbo.XMLTable_new2.DateAdded,
  dbo.XMLTable_new2.DateUpdated, dbo.XMLTable_new2.txtTodaysDate, dbo.XMLTable_new2.Description, dbo.XMLTable_new2.Detail_DateAdded,
  dbo.XMLTable_new2.Detail_DateUpdated, dbo.XMLTable_new2.Detail_txtTodaysDate, dbo.XMLTable_new2.Detail_Description, dbo.XMLTable_new2.Group_Number,
  dbo.XMLTable_new2.Group_Name, dbo.XMLTable_new2.IsActive, dbo.XMLTable_new2.ToBePrinted, dbo.XMLTable_new2.WasPrinted, dbo.XMLTable_new2.IsAcord,
  dbo.XMLTable_new2.IsDetail, dbo.XMLTable_new2.IsInvoice, dbo.XMLTable_new2.DatePrinted, dbo.XMLTable_new2.TimePrinted, dbo.XMLTable_new2.Dummy1,
  dbo.XMLTable_new2.Dummy2, dbo.XMLTable_new2.Dummy3, dbo.XMLTable_new2.Dummy4, dbo.XMLTable_new2.Dummy5, dbo.XMLTable_new2.Dummy6,
  dbo.XMLTable_new2.Dummy7, dbo.XMLTable_new2.Dummy8, dbo.XMLTable_new2.Dummy9, dbo.XMLTable_new2.Dummy10, dbo.XMLTable_new2.Dummy11,
  dbo.XMLTable_new2.Dummy12, dbo.XMLTable_new2.Dummy13, dbo.XMLTable_new2.Dummy14, dbo.XMLTable_new2.Dummy15, dbo.XMLTable_new2.Dummy16,
  dbo.XMLTable_new2.Dummy17, dbo.XMLTable_new2.Dummy18, dbo.XMLTable_new2.Dummy19, dbo.XMLTable_new2.Dummy20, dbo.XMLTable_new2.Dummy21,
  dbo.XMLTable_new2.Dummy22, dbo.XMLTable_new2.Dummy23, dbo.XMLTable_new2.Dummy24, dbo.XMLTable_new2.TimeEntered,
  dbo.XMLTable_new2.CurrentCertHolder, dbo.XMLTable_new2.CSR_XmlTable
FROM dbo.XMLTable_new2 INNER JOIN
  dbo.POLMAS ON dbo.XMLTable_new2.Policy_ID = dbo.POLMAS.Old_Policy_ID