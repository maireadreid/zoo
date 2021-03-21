-- Views, stored functions and stored procedures need to be run before the queries
-- As some queries require them

-- Example query 

SELECT employee_id, full_name, job_title, year(hire_date) as hire_year
FROM zookeeper
WHERE hire_date < '2011/03/19';

-- Example query using group by and having
-- Find out which job roles have more than 1 employee

SELECT job_title, COUNT(employee_id) as number_of_staff
FROM zookeeper
GROUP BY job_title
HAVING COUNT(employee_id) > 1;

-- Example select queries using subqueries
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
    
-- C) Find the names of animals for which there is not enough food stock

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

-- Join

SELECT f.FoodType_ID, f.FoodType, f.Amount_eats,
s.Amount_available
FROM feeding f
INNER JOIN stock s
ON
f.FoodType_ID = s.FoodType_ID;
		 
-- Views
-- Creates a view table that combines animal infomration and which enclosure they reside in and what type of food they eat

CREATE VIEW v
AS SELECT 
a.animal_id, a.animal_name, a.species_name, e.enclosure_name, f.foodtype
FROM animals a, enclosure e, feeding f
WHERE a.animal_id = e.animal_id AND e.animal_id = f.animal_id;

-- Example query using view 
-- Select carnivorous animals at the zoo

SELECT animal_id, animal_name, species_name, foodtype
FROM v 
WHERE foodtype = "beef" OR foodtype = "fish"
ORDER BY foodtype;
		 
-- View using joins 
-- Creates a view table that shows information about food and stock

CREATE VIEW joinv 
AS 
SELECT f.foodtype_id, f.foodtype, f.animal_id, f.amount_eats, s.amount_available
FROM feeding f
INNER JOIN stock s 
ON f.foodtype_ID = s.foodtype_ID;

-- Stored function
-- Check if there is enough stock 

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

-- Stored procedure
-- Select young animals 

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
									      
-- Trigger									      									      
-- When a Zookeeper retires, their information is placed in a retired zookeeper table

 CREATE TRIGGER zookeeper_retired  -- trigger name
 BEFORE DELETE -- {INSERT | UPDATE | DELETE}
 ON zookeeper FOR EACH ROW -- OLD table 
 INSERT INTO retired_zookeeper
 SET 
 employee_id = old.employee_id,
 full_name =  old.full_name,
 retired_on =  current_timestamp() -- in-built function
 ;
 
DELETE FROM zookeeper   
WHERE employee_id = '004';

-- Event
-- When stock amount available is below or equal to 10, this information is added to the new food order needed table, from which staff can know which food items need to be ordered									      

SET GLOBAL event_scheduler = ON;									      
									      
DELIMITER $$
CREATE EVENT recurring_stock_need_check
ON SCHEDULE EVERY 1 DAY 
STARTS '2021-03-01 00:00:00'

DO

BEGIN	
	INSERT INTO new_food_order_needed
    SELECT foodtype_id, amount_available
    FROM stock
	WHERE amount_available <= 10;
END$$

DELIMITER ;									      
									      
