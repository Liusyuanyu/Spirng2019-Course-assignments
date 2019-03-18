/*
Hsuan Yu Liu
823327369
CS 648
Assignment 5
*/

USE my_guitar_shop; 

-- Chapter 5: 1 ~ 4, 7
-- Exercises 5-1
SELECT COUNT(*)
		, SUM(tax_amount)
FROM orders
;

-- Exercises 5-2.
SELECT category_name
		,COUNT(*) AS 'Count of product'
        ,MAX(list_price) AS 'Most expensive'
FROM categories c 
	JOIN products p
		ON c.category_id = p.category_id
GROUP BY c.category_id
ORDER BY 2 DESC
;

-- Exercises 5-3.
SELECT c1.email_address
		, SUM(item_price *quantity) AS price_sum
        , SUM(discount_amount *quantity) AS discount_sum
FROM  customers c1
	JOIN orders o1
		ON c1.customer_id = o1.customer_id
	JOIN order_items oi1
		ON o1.order_id = oi1.order_id
GROUP BY c1.email_address
ORDER BY price_sum DESC
;

-- Exercises 5-4.
SELECT c1.email_address
		,COUNT(oi1.order_id) AS order_count
		,SUM((item_price - discount_amount)*quantity) AS order_total
FROM  customers c1
	JOIN orders o1
		ON c1.customer_id = o1.customer_id
	JOIN order_items oi1
		ON o1.order_id = oi1.order_id
GROUP BY c1.email_address
HAVING order_count > 1
;

-- Exercises 5-7.
SELECT c1.email_address
		,COUNT(DISTINCT oi1.product_id) AS product_count
FROM  customers c1
	JOIN orders o1
		ON c1.customer_id = o1.customer_id
	JOIN order_items oi1
		ON o1.order_id = oi1.order_id
GROUP BY c1.email_address
HAVING product_count > 1
;

-- Chapter 8: 1 and 2
-- Exercises 8-1.
SELECT FORMAT(list_price, 1) AS format_price
		, CONVERT(list_price ,SIGNED) AS converter_price
        , CAST(list_price AS SIGNED) AS cast_price
FROM products
;

-- Exercises 8-2.
SELECT CAST(date_added AS DATE) AS 'DATE'
        , CAST(date_added AS CHAR(7)) AS 'Year-Month'
        , CAST(date_added AS TIME) AS 'Time'
FROM products
;