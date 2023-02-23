DROP TABLE IF EXISTS customer cascade;
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY, 
	first_name VARCHAR(45),
	last_name VARCHAR(45),
	address VARCHAR(255),
	billing_info VARCHAR(255) NOT NULL
);

INSERT INTO customer(
	customer_id, 
	first_name,
	last_name,
	address,
	billing_info
)VALUES(
	100,
	'Dylan',
	'Smith',
	'123 Main St',
	'1232-4564-7897'
);

INSERT INTO customer(
	first_name,
	last_name,
	address,
	billing_info
)VALUES(
	'Lucas',
	'Lanh',
	'53 Main St',
	'4242-4242-4242'
);


DROP TABLE IF EXISTS cart;
CREATE TABLE cart(
	cart_id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

INSERT INTO cart(
	customer_id
)VALUES(
	100
),(
	1
);

SELECT *
FROM cart;

DROP TABLE IF EXISTS product;
CREATE TABLE product(
	product_id SERIAL PRIMARY KEY,
	"name" VARCHAR(255),
	description TEXT,
	price FLOAT
);

INSERT INTO product(
	"name",
	description,
	price
)VALUES(
	'feta cheese',
	'one of the best, healty option',
	6.50
),(
	'goat cheese',
	'the very best, and is sweet',
	7.00
);

SELECT *
FROM product;

DROP TABLE IF EXISTS cart_product;
CREATE TABLE cart_product(
	cart_product_id SERIAL PRIMARY KEY,
	cart_id INTEGER NOT NULL, 
	product_id INTEGER NOT NULL,
	quantity INT,
	FOREIGN KEY(cart_id) REFERENCES cart(cart_id),
	FOREIGN KEY(product_id) REFERENCES product(product_id)
);

INSERT INTO cart_product(
	cart_id,
	product_id,
	quantity
)VALUES(
	2,
	1,
	10
),(
	2,
	2,
	15
);

SELECT *
FROM cart_product

CREATE TABLE "order"(
	order_id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL,
	cart_id INT NOT NULL, 
	FOREIGN KEY(cart_id) REFERENCES cart(cart_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

INSERT INTO "order"(
	customer_id,
	cart_id
)VALUES(
	1,
	2
);

SELECT *
FROM "order"


CREATE TABLE seller(
	seller_id SERIAL PRIMARY KEY,
	"name" VARCHAR(255),
	address VARCHAR(255)
);

INSERT INTO seller(
	"name",
	address
)VALUES(
	'Jimmy',
	'50 South St'
),(
	'Johnny',
	'100 North St'
);

SELECT *
FROM seller

CREATE TABLE inventory_item(
	inventory_id SERIAL PRIMARY KEY,
	product_id INT NOT NULL,
	seller_id INT NOT NULL,
	quantity INT,
	FOREIGN KEY(product_id) REFERENCES product(product_id),
	FOREIGN KEY(seller_id) REFERENCES seller(seller_id)
);

INSERT INTO inventory_item(
	product_id,
	seller_id,
	quantity
)VALUES(
	1,
	2,
	500
);


SELECT *
FROM inventory_item;






