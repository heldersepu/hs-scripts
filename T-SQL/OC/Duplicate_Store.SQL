DELIMITER //
CREATE FUNCTION CopyStore(from_name varchar(64), new_name varchar(64), new_url varchar(255))
  RETURNS VARCHAR(20)

BEGIN
	DECLARE s VARCHAR(20);
	CREATE TEMPORARY TABLE tmpStore (store_id INT);

	INSERT INTO tmpStore
		SELECT `store_id` 
		FROM `oc_store` 
		WHERE `name` = from_name;

	IF ((SELECT COUNT(*) FROM tmpStore) > 0) THEN
		INSERT INTO `oc_store` (`name`, `url`, `ssl`) VALUES
		(new_name, new_url, '')
		DECLARE storeid INT = 0;

		SELECT storeid:= S.dcount FROM (SELECT MAX(`store_id`) AS dcount FROM `oc_store`) AS S;
		SET s = storeid
	ELSE
		SET s = 'STORE NOT FOUND';
	END IF;

    RETURN s;
END //

DELIMITER ;


SELECT CopyStore('Test','New Store','http://www.test1.pizzamenus.menu/')
