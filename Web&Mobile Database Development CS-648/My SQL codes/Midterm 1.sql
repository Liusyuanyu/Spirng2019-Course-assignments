/*
Hsuan Yu Liu
823327369
CS 648
Midterm exam 1
*/

USE ap;

SELECT *
FROM vendors
-- WHERE vendor_name in ('ASC Signs', 'City Of Fresno', 'ibm')
WHERE vendor_name < 'D'
;


SELECT *
FROM vendors
WHERE vendor_name in ('ASC Signs', 'City Of Fresno', 'ibm')
ORDER BY vendor_name
;

-- If introduced as follows, the subquery can return which of the values listed below? WHERE (subquery)
SELECT vendor_name,vendor_id
FROM vendors 
WHERE vendor_id  IN (SELECT vendor_id, vendor_name FROM vendors WHERE  vendor_id > 50) 
;

SELECT vendor_name, invoice_number
FROM invoices LEFT JOIN vendors
  ON invoices.vendor_id = vendors.vendor_id
;

SELECT vendor_name,vendor_id
FROM vendors 
UNION
SELECT invoice_number
FROM invoices
;

SELECT vendor_name,vendor_id
FROM vendors 
WHERE vendor_id 
GROUP BY vendor_name
HAVING vendor_id >50
ORDER BY vendor_name
;

-- -- Assuming that all of the table and column names are spelled correctly, what’s wrong with the INSERT statement that follows?
-- INSERT INTO invoices
--     (vendor_id, invoice_number, invoice_total, payment_total, credit_total,
--     terms_id, invoice_date, invoice_due_date)
-- VALUES
--     (97, '456789', 8344.50, 0, 0, 1, '2012-08-31')
-- ;


-- Code example 6-1
SELECT vendor_name, COUNT(*) AS number_of_invoices,
       MAX(invoice_total - payment_total - credit_total) AS balance_due
FROM vendors v 
  JOIN invoices i
  ON v.vendor_id = i.vendor_id  
WHERE invoice_total - payment_total - credit_total >
    (SELECT AVG(invoice_total - payment_total - credit_total)
    FROM invoices)
GROUP BY vendor_name
ORDER BY balance_due DESC
;

SELECT AVG(invoice_total - payment_total - credit_total)
FROM invoices
WHERE payment_tota > 10
;

SELECT vendor_name,vendor_id
FROM vendors 
HAVING vendor_id >50
ORDER BY vendor_name
;


-- INSERT INTO invoices(invoice_total,vendor_id,invoice_number) VALUES(100,10)
-- ;	

SELECT department_name, 
       department_number, 
       last_name 
FROM departments d 
     LEFT JOIN employees e 
          ON d.department_number = e.department_number 
ORDER BY department_name;



SELECT vendor_id,
       SUM(invoice_total - payment_total - credit_total) AS column_2
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
GROUP BY vendor_id
;



SELECT vendor_state, COUNT(*) AS column_2
FROM vendors
GROUP BY vendor_state
HAVING COUNT(*) > 1
;

WHERE vendor_name < 'C'
;