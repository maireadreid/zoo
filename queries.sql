-- selects

-- joins

-- subquery 

-- A) Find the name of the animal that eats alfalfa

SELECT a.animal_id, a.species_name
FROM animals a
WHERE animal_id =  
	(SELECT f.FoodType_ID
	FROM feeding f
	WHERE FoodType = 'alfalfa')
;

-- B) Find the name of the animals species where food stock is 0 

SELECT a.animal_id, a.species_name
FROM animals a
WHERE animal_id = 
	(SELECT f.Animal_id
	FROM feeding f
	WHERE f.FoodType_ID = 
		(SELECT fs.FoodType_ID
		FROM food_stock fs
		WHERE fs.Amount_available = 0)
	);
    
-- C) returns names of animals for which there is not enough food stock

SELECT a.animal_id, a.species_name
FROM animals a
WHERE animal_id IN 
    (SELECT f.Animal_id
	FROM feeding f
	WHERE f.FoodType_ID IN 	
		(SELECT vwf.FoodType_ID
		FROM vw_FoodStock vwf
		WHERE enough_FoodStock(Amount_available, Amount_eats) = 'NO'
		OR enough_FoodStock(Amount_available, Amount_eats) = 'JUST ENOUGH'))
		;

-- function
USE ZOO;

-- CREATE VIEW TABLE THAT COMBINES FOOD TYPE AND AMOUNT

CREATE VIEW vw_FoodStock 
AS SELECT f.FoodType_ID, f.FoodType, f.Amount_eats,
s.Amount_available
FROM feeding f, stock s
WHERE f.FoodType_ID = s.FoodType_ID;

SELECT * from vw_FoodStock;

-- FUNCTION TO SEE IF HAVE ENOUGH STOCK

DELIMITER //
CREATE FUNCTION enough_FoodStock(Amount_available FLOAT(2), Amount_eats FLOAT(2))
RETURNS VARCHAR(20) -- 'YES' 'JUST ENOUGH' 'NO'
DETERMINISTIC

BEGIN	
DECLARE enough_stock VARCHAR(20);

IF Amount_available > Amount_eats THEN
SET enough_stock = 'YES';

ELSEIF (Amount_available = Amount_eats) THEN
SET enough_stock = 'JUST ENOUGH';

ELSEIF Amount_available < Amount_eats THEN
SET enough_stock = 'NO';

END IF ;

RETURN(enough_stock);

END//
DELIMITER ;
									      
SELECT FoodType_ID, FoodType, Amount_eats, Amount_available, enough_FoodStock(Amount_available, Amount_eats)
FROM vw_FoodStock;

-- Stored procedure to select young animals 

DELIMITER //
CREATE PROCEDURE YoungAnimals() 
BEGIN

	SELECT animal_name, species_name, animal_DOB
    FROM 
    ANIMALS
    WHERE 
    animal_DOB 
    BETWEEN 
    '2018-01-01' AND '2021-03-11';
    
END// 
DELIMITER ;

CALL YoungAnimals();
									      
-- TRIGGER WHEN ZOOKEEPER RETIRED

CREATE TRIGGER zookeeper_retired  -- trigger name
 BEFORE DELETE -- {INSERT | UPDATE | DELETE}
 ON zookeeper FOR EACH ROW -- OLD table 
 INSERT INTO retired_zookeeper
 SET 
 employee_id = OLD.employee_id,
 full_name =  old.full_name,
 retired_on =  current_timestamp() -- in-built function
 ;
 
DELETE FROM zookeeper   
WHERE employee_id = '004';

-- Creates a view 

CREATE VIEW v
AS SELECT 
a.animal_id, a.animal_name, a.species_name, e.enclosure_name, f.foodtype
FROM animals a, enclosure e, feeding f
WHERE a.animal_id = e.animal_id AND e.animal_id = f.animal_id;

-- Query using view that selects carnivorous animals

SELECT animal_id, animal_name, species_name, foodtype
FROM v 
WHERE foodtype = "beef" OR foodtype = "fish"
ORDER BY foodtype;

-- Example query using group by and having

-- Find out which job roles have more than 1 employee

SELECT job_title, COUNT(employee_id) as number_of_staff
FROM zookeeper
GROUP BY job_title
HAVING COUNT(employee_id) > 1;

-- Example query 

SELECT employee_id, full_name, job_title, year(hire_date) as hire_year
FROM zookeeper
WHERE hire_date < '2011/03/19';

-- View with joins 

CREATE VIEW joinv 
AS 
SELECT f.foodtype_id, f.foodtype, f.animal_id, f.amount_eats, s.amount_available
FROM feeding f
INNER JOIN stock s 
ON f.foodtype_ID = s.foodtype_ID;

SELECT * FROM joinv;
