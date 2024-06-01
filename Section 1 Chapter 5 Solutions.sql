/*
Exercise 1
*/
INSERT INTO terms
	(terms_description, terms_due_days)
VALUES
	('Net due 120 days', 120);

SELECT *
FROM terms;

/*
Exercise 2
*/
UPDATE terms
SET terms_description = 'Net due 125 days'
WHERE terms_id = 6;

SELECT *
FROM terms;

/*
Exercise 3
*/
DELETE FROM terms
WHERE terms_id = 6;

SELECT *
FROM terms;

/*
Exercise 4
*/
CREATE TABLE invoice_update AS
SELECT *
FROM invoices;

SELECT *
FROM invoice_update;

INSERT INTO invoice_update VALUES
	(DEFAULT, 32, 'AX-014-027', '2022-08-01', 434.58, 0.00, 0.00, 2, '2022-08-31', NULL);
    
SELECT *
FROM invoice_update
WHERE vendor_id = 32;

DROP TABLE invoice_update;

INSERT INTO invoices VALUES
	(DEFAULT, 32, 'AX-014-027', '2022-08-01', 434.58, 0.00, 0.00, 2, '2022-08-31', NULL);

SELECT *
FROM invoices
ORDER BY invoice_id DESC;

/*
Exercise 5
*/

CREATE TABLE invoice_line_items_update AS
SELECT *
FROM invoice_line_items;

SELECT *
FROM invoice_line_items_update
ORDER BY invoice_id DESC;

INSERT INTO invoice_line_items_update
	(invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description)
SELECT invoice_id, 1, 160, 180.23, 'Hard drive'
FROM invoices
WHERE invoice_id = 115;

INSERT INTO invoice_line_items_update
	(invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description)
SELECT invoice_id, 2, 527, 254.35, 'Exchange Server update'
FROM invoices
WHERE invoice_id = 115;

SELECT *
FROM invoice_line_items_update
ORDER BY invoice_id DESC;

DROP TABLE invoice_line_items_update;

INSERT INTO invoice_line_items
	(invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description)
SELECT invoice_id, 1, 160, 180.23, 'Hard drive'
FROM invoices
WHERE invoice_id = 115;

INSERT INTO invoice_line_items
	(invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description)
SELECT invoice_id, 2, 527, 254.35, 'Exchange Server update'
FROM invoices
WHERE invoice_id = 115;

SELECT *
FROM invoice_line_items
WHERE invoice_id = 115;

/*
Exercise 6
*/
CREATE TABLE invoice_update AS
SELECT *
FROM invoices;

SELECT *
FROM invoice_update
WHERE invoice_id = 115;

UPDATE invoice_update
SET credit_total = .10 * invoice_total,
	payment_total = invoice_total - credit_total
WHERE invoice_id = 115;

SELECT *
FROM invoice_update
WHERE invoice_id = 115;

DROP TABLE invoice_update;

UPDATE invoices
SET credit_total = .10 * invoice_total,
	payment_total = invoice_total - credit_total
WHERE invoice_id = 115;

SELECT *
FROM invoices
WHERE invoice_id = 115;

/*
Exercise 7
*/
SELECT *
FROM vendors
WHERE vendor_id = 44;

UPDATE vendors
SET default_account_number = 403
WHERE vendor_id = 44;

SELECT *
FROM vendors
WHERE vendor_id = 44;

/*
Exercise 8
*/
SELECT vendor_id, terms_id
FROM invoices
ORDER BY vendor_id, terms_id;

UPDATE invoices
SET terms_id = 2
WHERE vendor_id IN
	(SELECT vendor_id
    FROM vendors
    WHERE default_terms_id = 2);

SELECT vendor_id, terms_id
FROM invoices
ORDER BY vendor_id, terms_id;

/*
Exercise 9
*/
-- This will produce an error because you cannot delete a parent row.
DELETE FROM invoices
WHERE invoice_id = 115;

SELECT *
FROM invoice_line_items
ORDER BY invoice_id DESC;

DELETE FROM invoice_line_items
WHERE invoice_id = 115;

DELETE FROM invoices
WHERE invoice_id = 115;

SELECT *
FROM invoices
ORDER BY invoice_id DESC;