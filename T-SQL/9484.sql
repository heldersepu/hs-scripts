USE QFWinData_QQ009484

-- Remove old records from XMLTable
DELETE FROM dbo.XMLTable
WHERE Old_Acord_ID is not null

-- Insert the new records into XMLTable
INSERT INTO dbo.XMLTable
  (Client_ID, Policy_ID, Old_Policy_ID, Old_Client_ID, Old_Acord_ID, XMLDataPage1, XMLDataPage2, XMLDataPage3, XMLDataPage4, XMLDataPage5, XMLDataDetail,
  FormType, Form1Name, Detail_Form1Name, FormID, FormVersion, DateAdded, DateUpdated, txtTodaysDate, Description, Detail_DateAdded, Detail_DateUpdated,
  Detail_txtTodaysDate, Detail_Description, Group_Number, Group_Name, IsActive, ToBePrinted, WasPrinted, IsAcord, IsDetail, IsInvoice, DatePrinted, TimePrinted,
  Dummy1, Dummy2, Dummy3, Dummy4, Dummy5, Dummy6, Dummy7, Dummy8, Dummy9, Dummy10, Dummy11, Dummy12, Dummy13, Dummy14, Dummy15,
  Dummy16, Dummy17, Dummy18, Dummy19, Dummy20, Dummy21, Dummy22, Dummy23, Dummy24, TimeEntered, CurrentCertHolder, CSR_XmlTable)
SELECT dbo.POLMAS.CLIENT_ID, dbo.POLMAS.POLICY_ID, dbo.POLMAS.Old_Policy_ID, dbo.POLMAS.Old_Client_ID, dbo.XMLTable_new3.Acord_ID,
  dbo.XMLTable_new3.XMLDataPage1, dbo.XMLTable_new3.XMLDataPage2, dbo.XMLTable_new3.XMLDataPage3, dbo.XMLTable_new3.XMLDataPage4,
  dbo.XMLTable_new3.XMLDataPage5, dbo.XMLTable_new3.XMLDataDetail, dbo.XMLTable_new3.FormType, dbo.XMLTable_new3.Form1Name,
  dbo.XMLTable_new3.Detail_Form1Name, dbo.XMLTable_new3.FormID, dbo.XMLTable_new3.FormVersion, dbo.XMLTable_new3.DateAdded,
  dbo.XMLTable_new3.DateUpdated, dbo.XMLTable_new3.txtTodaysDate, dbo.XMLTable_new3.Description, dbo.XMLTable_new3.Detail_DateAdded,
  dbo.XMLTable_new3.Detail_DateUpdated, dbo.XMLTable_new3.Detail_txtTodaysDate, dbo.XMLTable_new3.Detail_Description, dbo.XMLTable_new3.Group_Number,
  dbo.XMLTable_new3.Group_Name, dbo.XMLTable_new3.IsActive, dbo.XMLTable_new3.ToBePrinted, dbo.XMLTable_new3.WasPrinted, dbo.XMLTable_new3.IsAcord,
  dbo.XMLTable_new3.IsDetail, dbo.XMLTable_new3.IsInvoice, dbo.XMLTable_new3.DatePrinted, dbo.XMLTable_new3.TimePrinted, dbo.XMLTable_new3.Dummy1,
  dbo.XMLTable_new3.Dummy2, dbo.XMLTable_new3.Dummy3, dbo.XMLTable_new3.Dummy4, dbo.XMLTable_new3.Dummy5, dbo.XMLTable_new3.Dummy6,
  dbo.XMLTable_new3.Dummy7, dbo.XMLTable_new3.Dummy8, dbo.XMLTable_new3.Dummy9, dbo.XMLTable_new3.Dummy10, dbo.XMLTable_new3.Dummy11,
  dbo.XMLTable_new3.Dummy12, dbo.XMLTable_new3.Dummy13, dbo.XMLTable_new3.Dummy14, dbo.XMLTable_new3.Dummy15, dbo.XMLTable_new3.Dummy16,
  dbo.XMLTable_new3.Dummy17, dbo.XMLTable_new3.Dummy18, dbo.XMLTable_new3.Dummy19, dbo.XMLTable_new3.Dummy20, dbo.XMLTable_new3.Dummy21,
  dbo.XMLTable_new3.Dummy22, dbo.XMLTable_new3.Dummy23, dbo.XMLTable_new3.Dummy24, dbo.XMLTable_new3.TimeEntered,
  dbo.XMLTable_new3.CurrentCertHolder, dbo.XMLTable_new3.CSR_XmlTable
FROM dbo.XMLTable_new3 INNER JOIN
  dbo.POLMAS ON dbo.XMLTable_new3.Policy_ID = dbo.POLMAS.Old_Policy_ID

-- Set binderDate = Effective
UPDATE dbo.POLMAS
SET BINDER_DAT = EFFECTIVE
