-- Exercise 1
CREATE OR REPLACE VIEW open_items AS
	SELECT vendor_name, invoice_number, invoice_total,
		invoice_total - payment_total - credit_total AS balance_due
	FROM vendors v JOIN invoices i
		ON v.vendor_id = i.vendor_id
	WHERE invoice_total - payment_total - credit_total > 0
    ORDER BY vendor_name;
    
-- Exercise 2
SELECT *
FROM open_items
WHERE balance_due >= 1000;

-- Exercise 3
CREATE OR REPLACE VIEW open_items_summary AS
	SELECT vendor_name,
		COUNT(invoice_number) AS open_item_count,
        SUM(invoice_total - payment_total - credit_total) AS open_item_total
	FROM vendors v JOIN invoices i
		ON v.vendor_id = i.vendor_id
    WHERE invoice_total - payment_total - credit_total > 0
	GROUP BY vendor_name
	ORDER BY SUM(invoice_total) DESC;

-- Exercise 4
SELECT *
FROM open_items_summary
LIMIT 5;

-- Exercise 5
CREATE OR REPLACE VIEW vendor_address AS
	SELECT vendor_id, vendor_address1, vendor_address2
    FROM vendors;

-- Exercise 6
UPDATE vendor_address
SET vendor_address1 = '1990 Westwood Blvd',
	vendor_address2 = 'Ste 260'
WHERE vendor_id = 4;
