/*
Hsuan Yu Liu
823327369
CS 648
Assignment 2
*/

use ap;
-- 6
SELECT	vendor_name, 
		vendor_contact_last_name, 
        vendor_contact_first_name
FROM vendors
ORDER BY vendor_contact_last_name,
		 vendor_contact_first_name
;

-- 8
SELECT 	invoice_due_date AS "Due Date",
		invoice_total AS "Invoice Total",
        invoice_total/10 AS "10%",
        invoice_total*1.1 AS "Plus 10%"
FROM invoices
WHERE invoice_total >= 500 && invoice_total <= 1000
ORDER BY invoice_due_date DESC
;

-- 10
SELECT	invoice_number,
		invoice_date,
        invoice_total - payment_total - credit_total AS balance_due,
        payment_date
FROM invoices
WHERE payment_date is NULL
;

-- 12
SELECT 50000 AS starting_principal,
       50000 * .065 AS interest,
       (50000 * 1.065) AS principle_plus_interest
;