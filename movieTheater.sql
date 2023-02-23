CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(45),
	last_name VARCHAR(45),
	address VARCHAR(255),
	billing_info VARCHAR(255) NOT NULL
);

CREATE TABLE theaters(
	theaters_id SERIAL PRIMARY KEY,
	theater_name VARCHAR(45),
	address VARCHAR(255)
);

CREATE TABLE movies(
	movies_id SERIAL PRIMARY KEY,
	theaters_id INT NOT NULL,
	movie_name VARCHAR(45),
	movie_rating VARCHAR(45),
	description TEXT,
	FOREIGN KEY(theaters_id) REFERENCES theaters(theaters_id)
);


CREATE TABLE tickets(
	tickets_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	movies_id INT NOT NULL,
	quantity INT,
	prices FLOAT,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(movies_id) REFERENCES movies(movies_id)
);

CREATE TABLE concession_purchases(
	concession_purchases_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	theaters_id INT NOT NULL,
	quantity INT,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(theaters_id) REFERENCES theaters(theaters_id)
);

CREATE TABLE concession_products(
	concession_products_id SERIAL PRIMARY KEY,
	concession_purchases_id INT NOT NULL,
	snacks VARCHAR(45),
	price FLOAT,
	description TEXT,
	FOREIGN KEY(concession_purchases_id) REFERENCES concession_purchases(concession_purchases_id)
);

INSERT INTO customer (first_name, last_name, address, billing_info)
VALUES ('John', 'Doe', '123 Main St, Anytown USA', '1234-5678-9012-3456');

INSERT INTO theaters (theater_name, address)
VALUES ('AMC Anytown', '456 Oak St, Anytown USA');

INSERT INTO movies (theaters_id, movie_name, movie_rating, description)
VALUES (1, 'Avengers: Endgame', 'PG-13', 'The Avengers must stop Thanos from destroying the universe.');

INSERT INTO tickets (customer_id, movies_id, quantity, prices)
VALUES (1, 5, 2, 25.00),(2, 7, 5, 85.00);

INSERT INTO concession_purchases (customer_id, theaters_id, quantity)
VALUES (1, 1, 1),(2, 2, 3);

INSERT INTO concession_products (concession_purchases_id, snacks, price, description)
VALUES (1, 'Large Popcorn', 8.00, 'Freshly popped popcorn with butter and salt.');

-- Inserting Customer Information 
CREATE OR REPLACE PROCEDURE insertCustomer(
	fName VARCHAR,
	lName VARCHAR,
	addressInfo VARCHAR,
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
		addressInfo,
		billingInfo
	);
	COMMIT;
END;
$$

CALL insertCustomer('Billy', 'Bob', '213 Main St', '1234-1234-1234-1234')
CALL insertCustomer('Mike', 'Tyson', '1234 Knockout Lane', '4321-4321-4321-4321')

SELECT *
FROM customer;



-- Inserting Theater Information
CREATE OR REPLACE PROCEDURE insertTheater(
	theaterName VARCHAR,
	addressInfo VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN 
	INSERT INTO theaters(
		theater_name,
		address
	)VALUES(
		theaterName,
		addressInfo
	);
	COMMIT;
END;
$$


CALL insertTheater('AMC', '909 Movie Lane')
CALL insertTheater('Regal', '111 Watch St')

SELECT *
FROM theaters;


-- Inserting Movie Information
CREATE OR REPLACE PROCEDURE insertMovies(
	theaterId INT,
	movieName VARCHAR,
	movieRating VARCHAR,
	movieInfo TEXT
)
LANGUAGE plpgsql AS $$
BEGIN 
	INSERT INTO movies(
		theaters_id,
		movie_name,
		movie_rating,
		description
	)VALUES(
		theaterId,
		movieName,
		movieRating,
		movieInfo
	);
	COMMIT;
END;
$$

CALL insertMovies('1', 'ANT-MAN AND THE WASP: QUANTUMANIA', 'PG-13', 'Super Heroes adventures as Ant-Man and The Wasp.')
CALL insertMovies('1', 'PUSS IN BOOTS: THE LAST WISH', 'PG', 'Puss in Boots discovers that his passion for peril and disregard for safety have taken their toll.')
CALL insertMovies('2', 'PUSS IN BOOTS: THE LAST WISH', 'PG', 'Puss in Boots discovers that his passion for peril and disregard for safety have taken their toll.')


SELECT *
FROM movies;


-- Adjusting Tickets Quantity 
CREATE OR REPLACE FUNCTION adjustQuantity(
	ticketId INT,
	newQuantity INT
)
RETURNS INT
LANGUAGE plpgsql AS $$
BEGIN 
	UPDATE tickets 
	SET quantity = newQuantity 
	WHERE tickets_id = ticketId;
	RETURN ticketId;
END;
$$

SELECT adjustQuantity(5, 1);

SELECT *
FROM tickets;


