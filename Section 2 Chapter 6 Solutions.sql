-- Not including the exercises that utitlize the aggregate window functions (for more advanced SQL developers)

-- Exercise 1
SELECT
	vendor_id,
    SUM(invoice_total) AS grand_invoice_total
FROM invoices
GROUP BY vendor_id;

-- Exercise 2
SELECT
	vendor_name,
    SUM(payment_total) AS grand_payment_total
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY SUM(payment_total) DESC;

-- Exercise 3
SELECT
	vendor_name,
    COUNT(invoice_number) AS number_of_invoices,
    SUM(invoice_total) AS grand_invoice_total
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY number_of_invoices DESC;

-- Exercise 4
SELECT
	account_description,
    COUNT(invoice_id) AS number_of_items,
    SUM(line_item_amount) AS grand_line_item_amount
FROM general_ledger_accounts gl JOIN invoice_line_items li
	ON gl.account_number = li.account_number
GROUP BY account_description
HAVING COUNT(invoice_id) > 1
ORDER BY grand_line_item_amount DESC;

-- Exercise 5
SELECT
	account_description,
    COUNT(li.invoice_id) AS number_of_items,
    SUM(line_item_amount) AS grand_line_item_amount
FROM general_ledger_accounts gl 
	JOIN invoice_line_items li
		ON gl.account_number = li.account_number
	JOIN invoices i
		ON li.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2022-04-01' AND '2022-06-30'
GROUP BY account_description
HAVING COUNT(li.invoice_id) > 1
ORDER BY grand_line_item_amount DESC;

-- Exercise 6
SELECT
	account_number,
    SUM(line_item_amount) AS sum_line_items
FROM invoice_line_items
GROUP BY account_number;

-- Exercise 7
SELECT
	vendor_name,
    COUNT(DISTINCT gl.account_number) AS number_of_accounts
FROM vendors v
	JOIN invoices i
		ON v.vendor_id = i.vendor_id
	JOIN invoice_line_items li
		ON i.invoice_id = li.invoice_id
	JOIN general_ledger_accounts gl
		ON li.account_number = gl.account_number
GROUP BY vendor_name
HAVING number_of_accounts > 1
ORDER BY vendor_name;

-- Exercise 8
SELECT
	IF(GROUPING(terms_id) = 1, 'Grand Total', terms_id) AS terms_id,
	IF(GROUPING(vendor_id) = 1, 'Terms ID Total', vendor_id) AS vendor_id,
	MAX(payment_date) AS last_payment_made,
	SUM(invoice_total - payment_total - credit_total) AS balance_due
FROM invoices
GROUP BY terms_id, vendor_id WITH ROLLUP;






