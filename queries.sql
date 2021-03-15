-- selects

-- joins

-- subquery 

-- function

-- stored procedure

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