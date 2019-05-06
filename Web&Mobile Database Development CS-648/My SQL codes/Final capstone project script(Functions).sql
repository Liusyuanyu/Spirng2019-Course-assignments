/*
Hsuan Yu Liu
823327369
CS 648
Final Capstone Project script functions
*/

USE rfid_store_db;

/********************************************************
* b. Two parameterized stored procedures
*********************************************************/
DROP PROCEDURE IF EXISTS insert_customers;

DELIMITER //
CREATE PROCEDURE insert_customers
(
    rfid_id_param VARCHAR(45) ,
    password_param VARCHAR(255) ,
    e_mail_param VARCHAR(128) ,
	phone_number_param VARCHAR(45)
)
BEGIN
	IF rfid_id_param IS NULL THEN
		SIGNAL SQLSTATE '22004'
			SET MESSAGE_TEXT=
				'The rfid_id column doesn’t accept null value',
                MYSQL_ERRNO = 1048;
    END IF;
    IF password_param IS NULL THEN
		SIGNAL SQLSTATE '22004'
			SET MESSAGE_TEXT=
				'The password column doesn’t accept null value',
                MYSQL_ERRNO = 1048;
    END IF;

	INSERT INTO Customers (
					RFID_ID ,
                    password ,
                    e_mail ,
                    phone_number
                    )
    VALUES (
		rfid_id_param, 
		AES_ENCRYPT(password_param, 'rfid_keysting'),
		e_mail_param, 
		phone_number_param
    )
    ;
    
END//

DELIMITER ;

CALL insert_customers('1234567890','000012','test@yahoo.com','6191234567');

-- ======================Products
DROP PROCEDURE IF EXISTS insert_products;

DELIMITER //
CREATE PROCEDURE insert_products
(
    product_name_param VARCHAR(128) ,
    price_param DECIMAL(9,2) ,
    ingredient_param VARCHAR(1024) ,
	category_id_param INT,
    nf_param INT
)
BEGIN
	IF product_name_param IS NULL THEN
		SIGNAL SQLSTATE '22004'
			SET MESSAGE_TEXT=
				'The product name column doesn’t accept null value',
                MYSQL_ERRNO = 1048;
    END IF;
    IF price_param IS NULL THEN
		SET price_param =0;
    END IF;
    IF category_id_param IS NULL THEN
		SET category_id_param =3;
    END IF;
    

	INSERT INTO Products (
	                product_name ,
                    price ,
                    ingredients ,
                    category_Id ,
                    NutritionFacts_Id
                    )
    VALUES (
		product_name_param, 
		price_param,
		ingredient_param,
		category_id_param, 
		nf_param
    )
    ;
    
END//

DELIMITER ;

CALL insert_products('Formula 409 Stone and Steel Cleaner(2 pack)',7.32,'Lauramine Oxide, Ethanolamine and Tetrapotassium EDTA',2,NULL);

/********************************************************
* c.	Two views
*********************************************************/
DROP VIEW IF EXISTS customer_receipts;

CREATE VIEW customer_receipts AS
SELECT c.Customer_Id ,
	c.e_mail,
	c.RFID_ID ,
	re.sum_of_price AS 'sum' ,
    re.payment_way_Id AS 'Paeyment way',
	re.date AS 'DATE'
FROM customers c ,
    receipts re,
    Customers_to_Receipts ctr
WHERE c.Customer_Id= ctr.Customer_Id 
	AND ctr.Receipt_Id = re.Receipt_Id
ORDER BY c.Customer_Id
;

SELECT * FROM customer_receipts;

-- ========================================Second View
DROP VIEW IF EXISTS product_nfacts;

CREATE VIEW product_nfacts AS
SELECT p.Product_Id AS ID ,
	p.product_name AS NAME,
	nf.serving_size ,
	nf.serving_per_container ,
	nf.calories ,
	nf.saturated_fat ,
	nf.trans_fat ,
	nf.sodium ,
	nf.potassium ,
	nf.cholesterol ,
	nf.dietary_fiber ,
	nf.sugars 
FROM products p ,
	nutritionfacts nf
WHERE p.NutritionFacts_Id= nf.NutritionFacts_Id
ORDER BY p.Product_Id
;

SELECT * FROM product_nfacts;

/********************************************************
* d.	Two functions
*********************************************************/
SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS receipt_sum;

DELIMITER //
CREATE FUNCTION receipt_sum
(
	receipt_id_param INT
)
RETURNS DECIMAL(9,2)
BEGIN
	DECLARE price_sum DECIMAL(9,2);
	
	SELECT SUM(price*quantity) AS 'receipt total'
			INTO price_sum
    FROM receipts_to_products rtp
		JOIN products p
			ON rtp.Product_Id = p.Product_Id
    WHERE receipt_id_param = rtp.receipt_id   
    ;
	RETURN price_sum;
END//
DELIMITER ;

-- Test the function
SELECT receipt_sum(5);

-- ========================================Second Function
DROP FUNCTION IF EXISTS password_check;
DELIMITER //
CREATE FUNCTION password_check
(
	pws VARBINARY(255),
    customer_id_param INT
)
RETURNS BOOLEAN
BEGIN
	DECLARE correct BOOLEAN;
	
	SELECT (AES_ENCRYPT(pws, 'rfid_keysting') = password)
			INTO correct
    FROM customers
    WHERE Customer_Id = customer_id_param
    ;
	RETURN correct;
END//
DELIMITER ;

-- Test the function
SELECT password_check('000011',2);