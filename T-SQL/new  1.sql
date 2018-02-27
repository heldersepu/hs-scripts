DECLARE
  @counter INT,
  @id INT
  SET @counter=0

DECLARE @myCursor CURSOR

FOR SELECT qf_POL_ID FROM AFW_BasicPolInfo
FOR UPDATE OF qf_POL_ID
OPEN @myCursor
FETCH NEXT FROM @myCursor INTO @id

WHILE @@FETCH_STATUS=0
BEGIN
    SET @counter=@counter+1
    IF @counter > 250
    BEGIN
        UPDATE AFW_BasicPolInfo SET qf_POL_ID=@counter
        WHERE CURRENT OF @myCursor
    END

    FETCH NEXT FROM @myCursor INTO @id
END

CLOSE @myCursor
DEALLOCATE @myCursor