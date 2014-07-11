/****** Script to update the [Directory] to a sub directory ******/

DECLARE @QQID varchar(8); SET @QQID = 'QQ008747';

-- Update the TIF first
UPDATE [dbo].[Images]
SET    [Directory] = 'TP001\' + @QQID + '\Converted\' +
	Replace(Replace(Replace(RIGHT([FileName], 4), ' ', '_'), '.', '_'), '\', '_')
WHERE  [Directory] = @QQID + '\Converted'
       AND ([FileName] LIKE '%.tif' OR [FileName] LIKE '%.tiff');

-- Update the Remaining Images
UPDATE [dbo].[Images]
SET    [Directory] = 'SP002\' + @QQID + '\Converted\' +
	Replace(Replace(Replace(RIGHT([FileName], 4), ' ', '_'), '.', '_'), '\', '_')
WHERE  [Directory] = @QQID + '\Converted'

