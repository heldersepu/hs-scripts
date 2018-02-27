DELETE FROM `oc_product_to_category` 
WHERE `category_id` = 76;

INSERT INTO `oc_product_to_category` 
SELECT `product_id`, 76 FROM `oc_product` 
