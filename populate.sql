use zoo;

insert into
enclosure
(enclosure_id, enclosure_name, habitat, animal, location, hours)
values
(1, 'penguin parade', 'pool', 'penguin', 'hillside view', '0800-1800');

INSERT INTO 
ANIMALS
(animal_id, animal_name, species_name, animal_DOB, arrival_date)
VALUES
(1, 'Alex', 'lion', '2001-02-28', '2000-02-28'),
(2, 'Marty', 'zebra', '2004-05-23', '2006-03-08'),
(3, 'Melman', 'giraffe', '2006-08-19', '2010-04-01'),
(4, 'Gloria', 'hippopotamus', '2020-04-15', '2021-01-09'),
(5, 'Skipper', 'penguin', '2018-09-23', '2020-11-15'),
(6, 'Julien', 'lemur', '2016-12-16', '2016-12-16');

INSERT INTO feeding
(FoodType_ID, FoodType, Animal_id, Amount_eats)
VALUES
(1, 'beef', 1, 10),
(2, 'grass', 2, 15),
(3, 'acacia leaves', 3, 20),
(4, 'alfalfa', 4, 17),
(5, 'fish', 5, 7),
(6, 'fruit', 6, 12);

INSERT INTO stock
(FoodType_ID, Amount_available)
VALUES
(1, 2),
(2, 28),
(3, 20),
(4, 100),
(5, 0),
(6, 12);
