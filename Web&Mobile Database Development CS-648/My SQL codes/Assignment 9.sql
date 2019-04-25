/*
Hsuan Yu Liu
823327369
CS 648
Assignment 9
*/

USE my_guitar_shop; 
SET GLOBAL log_bin_trust_function_creators = 1;

-- -----------------------------------------------------
-- Chapter 15 Q2
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS discount_price;

DELIMITER //
CREATE FUNCTION discount_price
(
	item_id_param INT
)
RETURNS DECIMAL(9,2)
BEGIN
	DECLARE discount_price DECIMAL(9,2);
	
    SELECT oi.item_price - oi.discount_amount
    INTO discount_price
    FROM order_items oi
    WHERE oi.item_id = item_id_param
    ;
	RETURN discount_price;
END//
DELIMITER ;

-- Test the function
SELECT discount_price(7);

-- -----------------------------------------------------
-- Chapter 15 Q4
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS insert_products;

DELIMITER //
CREATE PROCEDURE insert_products
(
	category_id_param INT ,
    product_code_param VARCHAR(10) ,
    product_name_param VARCHAR(255) ,
    list_price_param DECIMAL(10,2) ,
	discount_percent_param DECIMAL(10,2)
)
BEGIN
	IF list_price_param < 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT=
				'The list_price column doesn’t accept negative numbers',
                MYSQL_ERRNO = 1264;
	ELSEIF discount_percent_param < 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT=
				'The discount_percent column doesn’t accept negative numbers',
                MYSQL_ERRNO = 1264;
    END IF;
    IF category_id_param IS NULL THEN
		SET category_id_param =1;
    END IF;
	IF product_code_param IS NULL THEN
		SET product_code_param ="Default";
    END IF;
    IF product_name_param IS NULL THEN
		SET product_name_param ="Default";
    END IF;
	IF list_price_param IS NULL THEN
		SET list_price_param =0;
    END IF;
	IF discount_percent_param IS NULL THEN
		SET discount_percent_param =0;
    END IF;
    
    INSERT INTO products ( 
					category_id ,
                    product_code, 
                    product_name,
                    products.description, 
                    list_price,
                    discount_percent, 
                    date_added
                    )
    VALUES (
		category_id_param ,
		product_code_param, 
		product_name_param,
		"", 
		list_price_param,
		discount_percent_param, 
		NOW()
    )
    ;
    
END//

DELIMITER ;

-- Negative num
CALL insert_products(1,"1","Test",NULL,0.5);
CALL insert_products(1,"1","Test",10,-0.5);
-- Add
CALL insert_products(1,"test_code","Test_name",100,20);
CALL insert_products(1,"sp","guitar sp",1000,120);

