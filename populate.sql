use zoo;

INSERT INTO people
(person_id, full_name, address, email_address, contact_number, date_of_birth, gender)
VALUES
(001, 'Michael Scott', '45 Kellum Court', 'manager@dundermifflin.com', '07287476472', '1980-08-10', 'Male'),
(002, 'Dwight Schrute', '1725 Slough Avenue', 'schrute.attrm@hotmail.com', '07485484372', '1984-10-05', 'Male'),
(003, 'Pam Beesly', '13821 Calvert Street', 'pam_beesly@gmail.com', '07289287937', '1992-04-16', 'Female'),
(004, 'Jim Halpert', '13821 Calvert Street', 'jimhalpert@gmail.com','07108918872', '1990-07-19', 'Male'),
(005, 'Creed Bratton', null, null, null, '1960-12-12', 'Male'),
(006, 'Toby Flenderson', '5752 Calhoun Avenue', 'hr@dundermifflin.com', '07465399100', '1976-02-27', 'Male'),
(007, 'Kelly Kapoor', '100 Barclay Hill', 'kellykapoor@hotmail.com', '07773645232', '1995-05-21', 'Female'),
(008, 'Blair Waldorf', '1136 Fifth Avenue', 'blair.waldorf@gmail.com', '07158375382', '1991-11-15', 'Female'),
(009, 'Dan Humphrey', '455 Water Street', 'danhumphrey@aol.com', '07826105639', '1991-04-20', 'Male'),
(010, 'Serena Van Der Woodsen', '455 Madison Avenue', 'serenavdw@hotmail.com', '07483105271', '1991-07-14', 'Female');

INSERT INTO visitors
(visitor_id, person_id, ticket_number, full_name, returner, address, contact_number, email_address, date_of_birth)
VALUES
(008, 008, 100277, 'Blair Waldorf', false, '1136 Fifth Avenue', '07158375382', 'blair.waldorf@gmail.com', '1991-11-15'),
(009, 009, 100278, 'Dan Humphrey', true, '455 Water Street', '07826105639', 'danhumphrey@aol.com', '1991-04-20'),
(010, 010, 100279, 'Serena Van Der Woodsen', false, '455 Madison Avenue', '07483105271', 'serenavdw@hotmail.com', '1991-07-14'); 
 
INSERT INTO visitor_ticket
(ticket_number, ticket_type, date_valid, visitor_id)
VALUES
(100277, 'full-access', '2021-06-21', 008), 
(100278, 'full-access', '2021-06-21', 009),
(100279, 'partial-access-only', '2021-06-21', 010); 

INSERT INTO 
animals
(animal_id, animal_name, species_name, animal_DOB, arrival_date)
VALUES
(1, 'Alex', 'lion', '2001-02-28', '2000-02-28'),
(2, 'Marty', 'zebra', '2004-05-23', '2006-03-08'),
(3, 'Melman', 'giraffe', '2006-08-19', '2010-04-01'),
(4, 'Gloria', 'hippopotamus', '2020-04-15', '2021-01-09'),
(5, 'Skipper', 'penguin', '2018-09-23', '2020-11-15'),
(6, 'Julien', 'lemur', '2016-12-16', '2016-12-16');

INSERT INTO feeding
(foodtype_ID, foodtype, animal_id, amount_eats)
VALUES
(1, 'beef', 1, 10),
(2, 'grass', 2, 15),
(3, 'acacia leaves', 3, 20),
(4, 'alfalfa', 4, 17),
(5, 'fish', 5, 7),
(6, 'fruit', 6, 12);

INSERT INTO stock
(foodtype_ID, amount_available)
VALUES
(1, 2),
(2, 28),
(3, 20),
(4, 100),
(5, 0),
(6, 12);

INSERT INTO zookeeper
(employee_id, person_id, full_name, job_title, hire_date, date_of_birth, gender, allocated_enclosure, contact_number)
VALUES
(001, 001, 'Michael Scott', 'Manager', '2007-04-05', '1980-08-10', 'Male', null, '07287476472'),
(002, 002, 'Dwight Schrute', 'Assistant Manager', '2010-03-29', '1984-10-05', 'Male', null, '07485484372'),
(003, 003, 'Pam Beesly', 'Zookeeper', '2009-06-29', '1992-04-16', 'Female', 'monkey kingdom', '07289287937'),
(004, 004, 'Jim Halpert', 'Lead Zookeeper', '2013-09-03', '1990-07-19', 'Male', 'monkey kingdom', '07108918872'),
(005, 005, 'Creed Bratton', 'Zookeeper', '2000-01-01', '1960-12-12', 'Male', 'rhino reserve', null),
(006, 006, 'Toby Flenderson', 'Zookeeper', '2011-02-19', '1976-02-27', 'Male', 'penguin parade', '07465399100'),
(007, 007, 'Kelly Kapoor', 'Zookeeper', '2015-03-10', '1995-05-21', 'Female', 'penguin parade', '07773645232');

insert into
enclosure
(enclosure_id, enclosure_name, allocated_zookeeper, animal_id, opening_hours)
values
(001, 'land of the lion', 002, 1 , '0800-1800'),
(002, 'zone of the zebra', 003, 2 , '0800-1800'),
(003, 'grounds of the giraffe', 004, 3 , '0800-1800'),
(004, 'home of the hippos', 005, 4 , '0800-1800'),
(005, 'parade of the penguins', 006, 5 , '0800-1800'),
(006, 'locale of the lemur', 007, 6 , '0800-1800')
;
