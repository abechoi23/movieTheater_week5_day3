-- FUNCTIONS

CREATE OR REPLACE FUNCTION doubleNum(a_num INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql AS $$
BEGIN
	RETURN a_num * 2;
END;
$$

SELECT doubleNum(5);

-- Function uses return values 
CREATE OR REPLACE FUNCTION adjustPrice(
	productId INTEGER,
	newPrice FLOAT
)
RETURNS INTEGER
LANGUAGE plpgsql AS $$
BEGIN
	UPDATE product -- UPDATE TABLE 
	SET price = newPrice -- UPDATE COLUMN IN TABLE 
	WHERE product_id = productId; 
	RETURN productId;
END;
$$

SELECT adjustPrice(1, 10.00); -- adjustPrice(productId, newPrice)

SELECT *
FROM product
WHERE product_id = (SELECT adjustPrice(1, 5.00));



-- procedure uses commit 
CREATE OR REPLACE PROCEDURE insertCustomer(
	fName VARCHAR,
	lName VARCHAR,
	address_ VARCHAR,
	billingInfo VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
	INSERT INTO customer(
		first_name,
		last_name,
		address,
		billing_info
	)VALUES(
		fName,
		lName,
		address_,
		billingInfo
	);
	COMMIT;
END;
$$


SELECT *
FROM customer;

CALL insertCustomer('Mike', 'Los', '20 South St', '2134-2134-2134');
-- 					fName	lName	address_		billingInfo


CREATE OR REPLACE PROCEDURE insertSeller(
	sellerName VARCHAR,
	addressInfo VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN 
	INSERT INTO seller(
		"name",
		address
	)VALUES(
		sellerName,
		addressInfo
	);
	COMMIT;
END;
$$

SELECT *
FROM seller;

CALL insertSeller('Chocolatte', '414 Chocolate St')


CREATE OR REPLACE FUNCTION adjustQuantity(
	productId INT,
	quantities INT
)
RETURNS INT
LANGUAGE plpgsql AS $$
BEGIN
	UPDATE inventory_item
	SET quantity = quantities
	WHERE product_id = productId;
	RETURN productId;
END;
$$

SELECT *
FROM inventory_item ii 
WHERE product_id = (SELECT adjustQuantity(1, 200))

SELECT adjustQuantity(1, 1000)


