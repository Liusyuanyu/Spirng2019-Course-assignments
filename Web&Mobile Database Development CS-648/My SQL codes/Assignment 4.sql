/*
Hsuan Yu Liu
823327369
CS 648
Assignment 4
*/

USE my_guitar_shop;

-- Chapter 7: 1 to 6
-- Exercises 7-1.
INSERT INTO categories(category_name) VALUES('Brass')
;	

-- Exercises 7-2.
UPDATE categories
SET category_name = 'Woodwinds'
WHERE category_id = 5
;

-- Exercises 7-3.
DELETE FROM categories
WHERE category_id = 5
;

-- Exercises 7-4.
INSERT INTO products
	(product_id,category_id,product_code,product_name,description,list_price,discount_percent,date_added)
VALUES
	(DEFAULT, 4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', 799.99, 0, NOW())
;

-- Exercises 7-5.
UPDATE products
SET discount_percent = 35
WHERE category_id = 4
;

-- Exercises 7-6.
-- Ignore!!

USE my_guitar_shop;
-- Chapter 6: 1 to 6
-- Exercises 6-1.
SELECT DISTINCT category_name 
FROM categories
WHERE category_id IN (SELECT category_id
			FROM products)
ORDER BY category_name 
;

-- Exercises 6-2.
SELECT  product_name, 
		 list_price 
FROM products
WHERE  list_price > 
	(SELECT AVG(list_price)
    FROM products)
ORDER BY list_price DESC
;

-- Exercises 6-3.
SELECT category_name
FROM categories c
WHERE NOT EXISTS
		( SELECT *
		  FROM products
          WHERE c.category_id = category_id)
;

-- Exercises 6-4.
SELECT so.email_address, MAX(order_total) AS 'largest order'
FROM ( 	SELECT c1.email_address,oi1.order_id, SUM((item_price - discount_amount)*quantity) AS order_total
		FROM  customers c1
				JOIN orders o1
					ON c1.customer_id = o1.customer_id
				JOIN order_items oi1
					ON o1.order_id = oi1.order_id
		GROUP BY c1.email_address, oi1.order_id ) so
GROUP BY so.email_address
;

-- Exercises 6-5.
SELECT p1.product_name, p1.discount_percent
FROM products p1
WHERE p1.discount_percent NOT IN (
									SELECT DISTINCT p2.discount_percent
									FROM products p2
                                    WHERE p1.product_name <> p2.product_name )
ORDER BY product_name
;

-- Exercises 6-6.
SELECT email_address,
		order_id, 
        MIN(order_date)
FROM (	SELECT c.email_address,
				o.order_id, 
                o.order_date
		FROM customers c
			JOIN orders o
				ON c.customer_id = o.customer_id ) co
GROUP BY email_address
;
