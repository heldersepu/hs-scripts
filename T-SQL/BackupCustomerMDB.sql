USE [DBAWork]
GO

/****** Object:  StoredProcedure [dbo].[BackupCustomerMDB]    Script Date: 02/10/2012 11:29:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  proc [dbo].[BackupCustomerMDB2]( @dbname varchar(100), @ticket varchar(10) )
-- Rafael Sanchez
-- Developed 2009
-- this is for site1
-- PRECONDITIONS:
-- file dbdatablank.mdb should be in C:\temp
-- Example of use: exec DBAWORK.dbo.[BackupCustomerMDB] 'QFWinData_QQ002691_Test','TEST'
as
begin
    declare @sql nvarchar(4000)
    declare @res int, @rc int
    declare @bcpCommand varchar(2000)
    declare @ImgLocation varchar(100)
    declare @FilelistLocation varchar(200)
    declare @File_Exists int
    declare @directory varchar(255)
    declare @filename varchar(100)
    declare @ImgLocation2 varchar(255)
    declare @Img varchar(255)
    declare @ArhiveFileLoc varchar(255)


    SET @ImgLocation = '\\qqstore02.prod.qq\webimages\images\'
    SET @ImgLocation2 = '\\nascfs01.prod.qq\images\ArchiveImages\'
    SET @FilelistLocation = '\\external.prod.qq\uploadshar\TICKETS\ticket'+@ticket+'\Images\Imagelist.txt'
    SET @ArhiveFileLoc = '\\external.prod.qq\uploadshar\TICKETS\ticket'+@ticket+'\Images\ArchiveImages\'

    CREATE TABLE      tmp_imgTbl
                      (directory varchar(255), filename varchar(100), qqstore int, nascfs int)

    --/*print 'NO DATACOPY IS CALLED HERE  ***********************'
    --    */
    exec dbawork.dbo.datacopy @dbname,@res OUTPUT
      if (@res<>0)
        begin
          print 'Error in DataCopy !!!!!!! --->'+convert(varchar,@res)
          return
        end
        /*      */

      set @sql= 'master.dbo.xp_cmdshell ''copy c:\\scripts\\dbdatablank.mdb c:\\temp\'''
        print @sql
        exec @RC=sp_executesql @sql

      if (@RC=0)
         exec dbawork.dbo.InsertAndDropEmptyTables 'dbacopy','c:\temp\dbdatablank.mdb', @res OUTPUT

      if (@res<>0)
        begin
          print 'Error running DTS !!!!!!! --->'+convert(varchar,@res)
          return
        end

        set @sql = 'exec master.dbo.xp_cmdshell '+'''rename c:\\temp\dbdatablank.mdb ' + @dbname+  '.mdb'''
        print @sql
      exec @RC=sp_executesql @sql

      if (@RC<>0)
        begin
          print 'Error Exporting (#1) !!!!!!!'
          return
        end

        --Make Directory for Archive image files
        set @sql = 'exec master.dbo.xp_cmdshell ''mkdir ' + @ArhiveFileLoc + ''''
        print @sql
        exec sp_executesql @sql


        set @sql = 'exec master.dbo.xp_cmdshell ''move c:\\temp\\'+@dbname+'.mdb' +' \\external.prod.qq\uploadshar\TICKETS\ticket'+@ticket+''''
        print @sql
        exec @RC=sp_executesql @sql

      if (@RC<>0)
        begin
          print 'Error Exporting (#2) !!!!!!!'
          return
        end


      PRINT 'data is ready on \\external.prod.qq\uploadshar\TICKETS\ticket'+@ticket

        --Images
       set @sql = 'INSERT INTO tmp_imgTbl (directory, filename, qqstore, nascfs)
                    SELECT directory, filename, 0 qqstore, 0 nascfs
                    FROM '+@dbname+'.dbo.images
                    WHERE directory is not null
                      and isnull([filename],'''') <> ''''
                      and isnull(directory, '''') <> ''''
                   UNION ALL
                    SELECT signaturefilename, convert(varchar(50), signature_id) + [filename], 0, 0
                    FROM '+@dbname+'.dbo.signatures
                    WHERE signaturefilename is not null
                      and isnull(signature_id, '''') <> ''''
                      and isnull(signaturefilename, '''') <> ''''
                   UNION ALL
                    SELECT strimagedirectory, strimage, 0, 0
                    FROM '+@dbname+'.dbo.clnmas
                    WHERE strimagedirectory is not null
                      and isnull(strimage, '''') <> ''''
                      and isnull(strimagedirectory,'''') <> ''''
                   UNION ALL
                    SELECT directory, filename, 0, 0
                    FROM '+@dbname+'.dbo.rolodex_emp_attachments
                    WHERE directory is not null
                      and isnull(filename, '''') <> ''''
                      and isnull(directory, '''') <> ''''
                   UNION ALL
                    SELECT directory, filename, 0, 0
                    FROM '+@dbname+'.dbo.tblClaimImages
                    WHERE directory is not null
                      and isnull(filename, '''') <> ''''
                      and isnull(directory, '''') <> '''' '

        exec sp_executesql @sql
       --print @sql

    declare curImg cursor fast_forward for
    SELECT @ImgLocation + directory + '\' + filename as Img, directory, filename
    FROM tmp_imgTbl

    open curImg
    fetch next FROM curImg into @Img, @directory, @filename
    while @@fetch_status = 0
    begin
        EXEC Master.dbo.xp_fileexist @Img, @File_Exists OUT
        IF @File_Exists = 1
        BEGIN
            UPDATE tmp_imgTbl set qqstore = 1
            WHERE directory = @directory
            and filename = @filename
        END
    fetch next FROM curImg into @Img, @directory, @filename
    end
    close curImg
    deallocate curImg

    SET @bcpCommand = 'bcp "' +
        'select distinct''' + @ImgLocation  + ''' + directory from dbawork.dbo.tmp_imgTbl where qqstore=1 ' +
        'union all ' +
        'select distinct''' + @ImgLocation2 + ''' + directory from dbawork.dbo.tmp_imgTbl where qqstore=0 ' +
        '" queryout "'+ @FilelistLocation + '" -S iprodhost.prod.qq\iprod04,32459 -U soberton -P skipper321! -c'
    EXEC master..Xp_cmdshell @bcpCommand

    PRINT 'data is ready \\external.prod.qq\uploadshar\TICKETS\ticket' + @ticket + ' '
    PRINT 'TeraCopy.exe Copy *' + @FilelistLocation + ' D:\'

    DROP TABLE tmp_imgTbl
end


GO

