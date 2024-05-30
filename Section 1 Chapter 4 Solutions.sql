/*
Exercise 1
*/
SELECT *
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id;
    
/*
Exercise 2
*/
SELECT vendor_name,
	invoice_number,
    invoice_date,
    invoice_total - payment_total - credit_total AS balance_due
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id
WHERE invoice_total - payment_total - credit_total > 0;

/*
Exercise 3
*/
SELECT DISTINCT vendor_name,
	default_account_number AS default_account,
    account_description AS 'description'
FROM vendors v JOIN general_ledger_accounts gl
	ON v.default_account_number = gl.account_number
ORDER BY account_description, vendor_name;

/*
Exercise 4
*/
SELECT vendor_name,
	invoice_date,
    invoice_number,
    invoice_sequence AS li_sequence,
    line_item_amount AS li_amount
FROM vendors v
	JOIN invoices i
		ON v.vendor_id = i.vendor_id
	JOIN invoice_line_items li
		ON i.invoice_id = li.invoice_id
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence;

/*
Exercise 5
*/
SELECT v1.vendor_id,
	v1.vendor_name,
    CONCAT(v1.vendor_contact_first_name, ' ', v1.vendor_contact_last_name) AS contact_name
FROM vendors v1 JOIN vendors v2
	ON v1.vendor_id != v2.vendor_id
    AND v1.vendor_contact_last_name = v2.vendor_contact_last_name
ORDER BY v1.vendor_contact_last_name;

/*
Exercise 6
*/
SELECT gl.account_number,
	account_description
FROM general_ledger_accounts gl LEFT JOIN invoice_line_items li
	ON gl.account_number = li.account_number
WHERE invoice_id IS NULL
ORDER BY gl.account_number;

/*
Exercise 7
*/
SELECT vendor_name, 'Outside CA' AS vendor_state
FROM vendors
WHERE vendor_state != 'CA'
UNION
SELECT vendor_name, 'CA' AS vendor_state
FROM vendors
WHERE vendor_state = 'CA'
ORDER BY vendor_name;