/*
Exercise 8
*/
SELECT vendor_name, vendor_contact_last_name, vendor_contact_first_name
FROM vendors
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

/*
Exercise 9
*/
SELECT CONCAT(vendor_contact_last_name, ', ', vendor_contact_first_name) AS full_name
FROM vendors
WHERE vendor_contact_last_name REGEXP '^[A|B|C|E]'
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

/*
Exercise 10
*/
SELECT invoice_due_date AS 'Due Date', invoice_total AS 'Invoice Total',
	   invoice_total * .10 AS '10%',
       invoice_total * .10 + invoice_total AS 'Plus 10%'
FROM invoices
WHERE invoice_total >= 500 AND invoice_total <= 1000
ORDER BY invoice_due_date DESC;

/*
Exercise 11
*/
SELECT invoice_number, invoice_total,
	   (payment_total + credit_total) AS payment_credit_total,
       (invoice_total - payment_total - credit_total) AS balance_due
FROM invoices
WHERE (invoice_total - payment_total - credit_total > 50)
ORDER BY balance_due DESC
LIMIT 5;

/*
Exercise 12
*/
SELECT invoice_number, invoice_date,
	   invoice_total - payment_total - credit_total AS balance_due,
       payment_date
FROM invoices
WHERE payment_date IS NULL;

/*
Exercise 13
*/













