
Update polmas
set PSTATUS = 'A'
where Old_Policy_ID is not NULL
      and PSTATUS = 'C'
      and CANCEL_DAT is NULL
