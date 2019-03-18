/*
Hsuan Yu Liu
823327369
CS 648
Assignment 6
*/

USE my_guitar_shop; 

-- Chapter 8: 1, 2
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

-- Chapter 9: 1 ~ 4
-- Exercises 9.1
SELECT list_price
		,discount_percent
		, ROUND( list_price * (discount_percent/100), 2 ) AS  discount_amount
FROM products
;

-- Exercises 9.2
SELECT  order_date
	, DATE_FORMAT(order_date, '%Y')
	, DATE_FORMAT(order_date, '%b-%d-%Y')
    , DATE_FORMAT(order_date, '%h:%i %p')
    , DATE_FORMAT(order_date, '%m/%d/%y %H:%i')
FROM orders
;

-- Exercises 9.3
-- First 12 + Last 4
SELECT card_number
	, LENGTH(card_number)
	, RIGHT(card_number,4)
    , CONCAT(LEFT(card_number,4),'-',SUBSTR(card_number,5,4),'-',SUBSTR(card_number,9,4),'-',RIGHT(card_number,4)) AS With_Hyphen
FROM orders
;

-- Exercises 9.4
SELECT order_id
	, order_date
    , DATE_ADD(order_date , INTERVAL 2 DAY) AS approx_ship_date
    , ship_date
    , DATEDIFF(ship_date,order_date) AS days_to_ship
FROM orders
WHERE DATE_FORMAT(order_date,'%b %Y') = 'May 2012'
-- WHERE DATE_FORMAT(order_date,'%b %Y') = 'Apr 2012'
;



