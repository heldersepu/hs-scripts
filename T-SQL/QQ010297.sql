-- #1 Update LOB
UPDATE [QFWinData_QQ010297].[dbo].[POLMAS]
SET [LOB] = 'AUTO'
WHERE [LOB] = 'Non-Standard Auto' or
      [LOB] = 'Special Auto' or
      [LOB] = 'Standard Auto' or
      [LOB] = 'Standard Auto MRP'

-- #2 Update the Memo date
UPDATE [QFWinData_QQ010297].[dbo].[MEMOMAS]
SET MEMODATE = MEMOMAS_new.DateEntered
FROM MEMOMAS INNER JOIN
    MEMOMAS_new ON MEMOMAS.Old_Memo_ID = MEMOMAS_new.MEMO_ID
WHERE (MEMOMAS_new.[Unique] is Null) and
	  (MEMOMAS.MEMODATE = '1980-01-01 00:00:00.000')

-- #3 Update the binder date
UPDATE [QFWinData_QQ010297].[dbo].[POLMAS]
SET [BINDER_DAT] = [EFFECTIVE]
WHERE (Old_Policy_ID is not null) and
    ([BINDER_DAT] = '2011-05-13 00:00:00.000')

-- #4 Add memo Reminders
INSERT INTO MEMOMAS
	(CLIENT_ID, Old_Client_ID, Old_Memo_ID,
	[UNIQUE], LASTFUNC, Mpos, MEMODATE, MEMOLINE, REMDATE, CSR, MEMOTYPE, Flag,
	Dummy1, Dummy2, Dummy3, VoidDate, UnvoidDate)
SELECT CLNMAS.Client_ID, CLNMAS.Old_Client_ID, MEMOMAS_new.MEMO_ID,
	MEMOMAS_new.[UNIQUE], MEMOMAS_new.LASTFUNC, MEMOMAS_new.MPOS, MEMOMAS_new.MEMODATE, MEMOMAS_new.MEMOLINE,
	MEMOMAS_new.REMDATE, MEMOMAS_new.CSR, MEMOMAS_new.MemoType, MEMOMAS_new.FLAG, MEMOMAS_new.DUMMY1, MEMOMAS_new.DUMMY2,
	MEMOMAS_new.DUMMY3, MEMOMAS_new.VoidDate, MEMOMAS_new.UnvoidDate
FROM MEMOMAS_new INNER JOIN
	CLNMAS ON MEMOMAS_new.CLIENT_ID = CLNMAS.Old_Client_ID
WHERE (MEMOMAS_new.[Unique] is NOT Null)
