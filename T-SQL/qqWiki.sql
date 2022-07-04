INSERT INTO `wikidb`.`qq_user_groups`(ug_user, ug_group)
SELECT user_id, 'autoconfirmed'
FROM `wikidb`.`qq_user`
WHERE user_email_authenticated is NULL;

UPDATE `wikidb`.`qq_user`
SET user_email_authenticated = '20120402163438'
WHERE user_email_authenticated is NULL;