-- Exercise 1
CREATE INDEX vendors_vendor_zip_code_ix
	ON ap.vendors (vendor_zip_code);

-- Exercise 2
DROP TABLE IF EXISTS members_committees;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS committees;

CREATE TABLE members
(
	member_id	INT				PRIMARY KEY		AUTO_INCREMENT,
    first_name	VARCHAR(50)		NOT NULL,
    last_name	VARCHAR(50)		NOT NULL,
    address		VARCHAR(50),
    city		VARCHAR(50)		NOT NULL,
    state		CHAR(2)			NOT NULL,
    phone		VARCHAR(50)
);

CREATE TABLE committees
(
	committee_id	INT				PRIMARY KEY		AUTO_INCREMENT,
    committee_name	VARCHAR(50)		NOT NULL
);

CREATE TABLE members_committees
(
	member_id		INT		NOT NULL,
    committee_id	INT		NOT NULL,
    CONSTRAINT members_committees_fk_members
		FOREIGN KEY (member_id)
        REFERENCES members (member_id),
	CONSTRAINT members_committees_fk_committees
		FOREIGN KEY (committee_id)
        REFERENCES committees (committee_id)
);

-- Exercise 3
INSERT INTO members
VALUES (DEFAULT, 'Brandyn', 'Coverdill', '1234 State St.', 'Cedar Rapids', 'IA', DEFAULT);

INSERT INTO members
VALUES (DEFAULT, 'Mari', 'Rivas', DEFAULT, 'Los Angeles', 'CA', '123-456-7890');

INSERT INTO committees
VALUES (DEFAULT, 'Health and Human Services');

INSERT INTO committees
VALUES (DEFAULT, 'Natural Resource & Environment Committee');

INSERT INTO members_committees (member_id, committee_id)
SELECT m.member_id, c.committee_id
FROM members m JOIN committees c
ON (m.member_id = 1 AND c.committee_id = 2);

INSERT INTO members_committees (member_id, committee_id)
SELECT m.member_id, c.committee_id
FROM members m JOIN committees c
ON (m.member_id = 2 AND c.committee_id = 1);

INSERT INTO members_committees (member_id, committee_id)
SELECT m.member_id, c.committee_id
FROM members m JOIN committees c
ON (m.member_id = 2 AND c.committee_id = 2);

SELECT c.committee_name, m.last_name, m.first_name
FROM members m JOIN members_committees mc
	ON m.member_id = mc.member_id
JOIN committees c
	ON mc.committee_id = c.committee_id
ORDER BY c.committee_name, m.last_name, m.first_name;

-- Exercise 4
ALTER TABLE members
ADD annual_dues DECIMAL(5,2) NOT NULL DEFAULT 52.50;

ALTER TABLE members
ADD payment_date DATE;

-- Exercise 5
ALTER TABLE committees
MODIFY committee_name VARCHAR(50) NOT NULL UNIQUE;

INSERT INTO committees
VALUES (DEFAULT, 'Health and Human Services'); -- this will fail







