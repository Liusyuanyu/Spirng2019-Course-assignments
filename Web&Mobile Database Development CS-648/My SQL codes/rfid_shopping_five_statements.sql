/*
Hsuan Yu Liu
823327369
CS 648
Final Capstone Project: Five SQL statements
*/

/********************************************************
* 3.	Five SQL statements*
*********************************************************/
-- a.	One query to summarize the data using aggregate functions.
SELECT AVG(sum_of_price) average_sum,
		SUM(sum_of_price) AS amount,
        COUNT(*) AS count_receipt
FROM receipts
;

-- b.	One query to display the data. Note: the resulting output should be easy to read by an end user, 
-- so codes should be replaced with descriptive text as appropriate and column headings should reflect 
-- the content of the column. This query should display data from two or more tables.
SELECT c.Customer_Id AS 'Customer ID',
	c.e_mail AS 'E-mail',
	ctr.Receipt_Id AS 'Receipt ID',
    rec.sum_of_price AS 'Sum of price',
    rec.payment_way_Id AS 'Payment',
    rec.date AS 'Date'
FROM customers c
	JOIN customers_to_receipts ctr	
		ON c.Customer_Id = ctr.Customer_Id 
	JOIN receipts rec 
		ON (rec.Receipt_Id = ctr.Receipt_Id) 
			AND rec.date BETWEEN '2019-04-14' AND '2019-04-16'
;

-- c.	One to insert data.
-- Use insert_products procedure to insert a product.
CALL insert_products('Formula 409 Stone and Steel Cleaner(2 pack)'
	,7.32
    ,'Lauramine Oxide, Ethanolamine and Tetrapotassium EDTA'
    ,2
    ,NULL);


-- d.	One to delete data.
DELETE FROM products
WHERE Product_Id = 13
;

-- e.	One to update data.
UPDATE customers
SET phone_number = '1234567890'
WHERE Customer_Id = 3
;