-- Create the database and tables

create database zoo; -- create the overall zoo database

use zoo; -- use this database to create tables

-- animal table
CREATE TABLE ANIMALS
(
    animal_id INT NOT NULL PRIMARY KEY,
    animal_name VARCHAR(50) NOT NULL,
    species_name VARCHAR(50) NOT NULL,
    animal_DOB DATE,
    arrival_date DATE NOT NULL
);

-- zookeeper table
CREATE TABLE zookeeper
(
	employee_id INT NOT NULL,
    full_name VARCHAR(55) NOT NULL,
    job_title VARCHAR(55),
    hire_date DATE NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    allocated_enclosure VARCHAR(55),
    contact_number VARCHAR(55),
    CONSTRAINT employee_id_pk PRIMARY KEY(employee_id)
	 -- CONSTRAINT employee_id_fk FOREIGN KEY(full_name) REFERENCES people(full_name)
    );

-- enclosure table
create table enclosure(

enclosure_id int not null,
enclosure_name varchar(20),
allocated_zookeeper int,
animal_id int,
opening_hours varchar(10),

constraint 
enclosure_pk 
primary key
(enclosure_id),

CONSTRAINT animal_fk FOREIGN KEY (animal_id)
REFERENCES animals(animal_id),

CONSTRAINT zookeeper_fk FOREIGN KEY (allocated_zookeeper)
REFERENCES zookeeper(employee_id));

-- feeding table
CREATE TABLE feeding (
	FoodType_ID INT,
	FoodType VARCHAR(50),
    Animal_id INT,
	Amount_eats FLOAT(2),
	CONSTRAINT feeding_PK PRIMARY KEY (FoodType_ID));

ALTER TABLE feeding
ADD CONSTRAINT fk_Animal_id FOREIGN KEY (Animal_id) REFERENCES ANIMALS (animal_id);

-- stock table
CREATE TABLE stock (
	FoodType_ID INT,
    Amount_available Float(2),
    CONSTRAINT fk_FoodType_ID FOREIGN KEY (FoodType_ID) REFERENCES feeding (FoodType_ID)
    );
					   
					   -- people table
CREATE TABLE people
(
	person_id INT NOT NULL,
    full_name VARCHAR(55) NOT NULL,
    address VARCHAR (100),
    email_address VARCHAR(55),
    contact_number VARCHAR(55),
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    CONSTRAINT person_id_pk PRIMARY KEY(person_id),
	CONSTRAINT person_id_fk FOREIGN KEY(full_name) REFERENCES zookeeper(full_name)
    );

					   -- visitor ticket table
CREATE TABLE visitor_ticket
(
	ticket_number_id INT NOT NULL,
	ticket_number INT NOT NULL,
    ticket_type VARCHAR(25),
    date_valid DATE,
    full_name VARCHAR(55) NOT NULL,
    CONSTRAINT visitor_ticket_pk PRIMARY KEY(ticket_number_id),
	CONSTRAINT visitor_ticket_fk FOREIGN KEY(ticket_number) REFERENCES visitors(ticket_number)
    );

					   -- visitors table
CREATE TABLE visitors
(
	visitor_id INT NOT NULL,
	ticket_number INT NOT NULL,
    full_name VARCHAR(55) NOT NULL,
    returner BOOLEAN NOT NULL,
    address VARCHAR(100),
    contact_number VARCHAR(55),
    email_address VARCHAR(55),
    date_of_birth DATE,
    CONSTRAINT visitors_pk PRIMARY KEY(visitor_id),
    CONSTRAINT visitors_fk FOREIGN KEY(full_name) REFERENCES people(full_name)
    );
