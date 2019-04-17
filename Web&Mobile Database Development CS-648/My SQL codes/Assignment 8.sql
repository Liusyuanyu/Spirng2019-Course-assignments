/*
Hsuan Yu Liu
823327369
CS 648
Assignment 8
*/

USE my_guitar_shop; 


-- Exercises 12-1
DROP VIEW IF EXISTS customer_addresses;

CREATE VIEW customer_addresses AS
SELECT c.customer_id ,
 c.email_address,
 c.last_name ,
 c.first_name ,
 bill_addr.line1 AS BillLine1 ,
 bill_addr.line2 AS BillLine2 ,
 bill_addr.city AS BillCity ,
 bill_addr.state AS BillState ,
 bill_addr.zip_code AS BillZip ,
 ship_addr.line1 AS ShipLine1 ,
 ship_addr.line2 AS ShipLine2 ,
 ship_addr.city AS ShipCity ,
 ship_addr.state AS ShipSate ,
 ship_addr.zip_code AS ShipZip
FROM customers c , addresses bill_addr, addresses ship_addr
WHERE c.billing_address_id	= bill_addr.address_id and c.shipping_address_id = ship_addr.address_id
ORDER BY c.last_name, c.first_name
;

SELECT * FROM customer_addresses;