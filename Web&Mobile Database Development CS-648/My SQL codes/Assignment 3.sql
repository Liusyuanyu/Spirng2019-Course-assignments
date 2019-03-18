/*
Hsuan Yu Liu
823327369
CS 648
Assignment 3
*/

use ap;

-- Question 1.
SELECT * 
FROM vendors v 
	INNER JOIN invoices i
		ON v.vendor_id = i.vendor_id
;

-- Question 2.
SELECT vendor_name,
		invoice_number,
        invoice_date,
        invoice_total - payment_total - credit_total AS balance_due   
FROM vendors v 
	JOIN invoices i
		ON v.vendor_id = i.vendor_id
WHERE invoice_total - payment_total - credit_total != 0
ORDER BY vendor_name
;

-- Question 3
SELECT vendor_name,
		default_account_number AS default_account,
        account_description
FROM vendors v
	JOIN general_ledger_accounts g
		ON v.default_account_number = g.account_number
ORDER BY account_description, vendor_name
;

-- Question 4
SELECT vendor_name,
		invoice_date,
        invoice_number,
        invoice_sequence AS li_sequence,
        line_item_amount AS li_amount
FROM vendors v
	JOIN invoices i
		ON v.vendor_id = i.vendor_id
	JOIN invoice_line_items ili
		ON i.invoice_id = ili.invoice_id
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence
;

-- Question 5
SELECT v1.vendor_id,
		v1.vendor_name,
		CONCAT(v1.vendor_contact_first_name,' ', v1.vendor_contact_last_name) AS contact_name
FROM vendors v1
	JOIN vendors v2
		ON v1.vendor_contact_last_name = v2.vendor_contact_last_name
			AND v1.vendor_id <> v2.vendor_id
ORDER BY v1.vendor_contact_last_name
;

-- Question 6
SELECT g.account_number,
		account_description
        -- ,invoice_id
FROM general_ledger_accounts g
	LEFT OUTER JOIN invoice_line_items ili
		ON g.account_number = ili.account_number
WHERE ili.invoice_id IS NULL
ORDER BY account_number
;

-- Question 7
SELECT vendor_name,
		vendor_state
FROM vendors
WHERE vendor_state = 'CA'
UNION
	SELECT vendor_name,
			'Outside CA'
	FROM vendors
	WHERE vendor_state <> 'CA'
ORDER BY vendor_name
;