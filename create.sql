-- Create the database and tables

-- Create zoo database
CREATE DATABASE zoo; 

-- Use this database to create tables

USE zoo; 

--  Enclosure table

CREATE TABLE enclosure 
(
	enclosure_id INT NOT NULL,
	enclosure_name VARCHAR(55),
	allocated_zookeeper INT,
	animal_id INT,
	opening_hours VARCHAR(10),

	CONSTRAINT
	enclosure_pk 
	PRIMARY KEY
	(enclosure_id)
);

-- Animal table

CREATE TABLE animals
(
        animal_id INT NOT NULL,
        animal_name VARCHAR(55) NOT NULL,
        species_name VARCHAR(55) NOT NULL,
        animal_DOB DATE,
        arrival_date DATE NOT NULL,
        CONSTRAINT animal_id_pk PRIMARY KEY(animal_id)
);

-- Zookeeper table

CREATE TABLE zookeeper
(
	employee_id INT NOT NULL,
    person_id INT NOT NULL,
    full_name VARCHAR(55) NOT NULL,
    job_title VARCHAR(55),
    hire_date DATE NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    allocated_enclosure VARCHAR(55),
    contact_number VARCHAR(55)
);

ALTER TABLE zookeeper
ADD CONSTRAINT zookeeper_pk
PRIMARY KEY (employee_id); 

-- Feeding table

CREATE TABLE feeding 
(
	foodtype_ID INT,
	foodtype VARCHAR(50),
   	animal_id INT,
	amount_eats FLOAT(2),
	CONSTRAINT feeding_pk PRIMARY KEY (foodtype_ID),
   	CONSTRAINT fk_animal_id FOREIGN KEY (animal_id) REFERENCES animals (animal_id)
);

-- Stock table

CREATE TABLE stock 
(
	foodtype_ID INT,
        amount_available Float(2),
        CONSTRAINT fk_foodtype_ID FOREIGN KEY (foodtype_ID) REFERENCES feeding (foodtype_ID)
);

-- New food order needed table

create table new_food_order_needed
(
	food_order_id INT NOT NULL AUTO_INCREMENT,
    foodtype_id INT NOT NULL,
    amount_available FLOAT(2),
    CONSTRAINT pk_food_order PRIMARY KEY (food_order_id)
);

-- People table

CREATE TABLE people
(
	person_id INT NOT NULL,
    full_name VARCHAR(55) NOT NULL,
    address VARCHAR (100),
    email_address VARCHAR(55),
    contact_number VARCHAR(55),
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10)
);

ALTER TABLE people
ADD CONSTRAINT person_pk 
PRIMARY KEY (person_id); 

-- Visitors table

CREATE TABLE visitors
(
	visitor_id INT NOT NULL,
    person_id INT NOT NULL,
	ticket_number INT NOT NULL,
    full_name VARCHAR(55) NOT NULL,
    returner BOOLEAN NOT NULL,
    address VARCHAR(100),
    contact_number VARCHAR(55),
    email_address VARCHAR(55),
    date_of_birth DATE
);

ALTER TABLE visitors
ADD CONSTRAINT visitors_pk
PRIMARY KEY (visitor_id);

-- Visitor ticket table

CREATE TABLE visitor_ticket
(
	ticket_number INT NOT NULL,
    ticket_type VARCHAR(25),
    date_valid DATE,
    visitor_id INT NOT NULL
);

    
ALTER TABLE visitor_ticket
ADD CONSTRAINT visitor_ticket_pk
PRIMARY KEY (ticket_number);

    
-- enclosure foreign keys
ALTER TABLE enclosure
ADD CONSTRAINT animal_fk
FOREIGN KEY (animal_id) REFERENCES animals(animal_id);

ALTER TABLE enclosure
ADD CONSTRAINT allocated_zookeeper_fk FOREIGN KEY (allocated_zookeeper)
REFERENCES zookeeper(employee_id); 

-- zookeeper foreign key   

ALTER TABLE zookeeper
ADD CONSTRAINT zookeeper_fk
FOREIGN KEY (person_id) REFERENCES people(person_id);

-- ticket foreign key
ALTER TABLE visitor_ticket
ADD CONSTRAINT visitor_ticket_fk
FOREIGN KEY (visitor_id) REFERENCES visitors(visitor_id);


