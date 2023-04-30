USE mydb;
 -- 1.Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS f_date;
DELIMITER $$	
CREATE FUNCTION f_date
(
num INT
)
RETURNS VARCHAR(100) 
DETERMINISTIC
BEGIN 
	DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    DECLARE date_ VARCHAR (100) DEFAULT "";   
	WHILE num > 0 DO		
			IF num >= 86400 THEN
				SET days = FLOOR(num / (24 * 60 * 60));
				SET num = num - days * 24 * 60 * 60;
			END IF;
            IF num >= 3600 THEN
				SET hours = FLOOR(num / (60 * 60));
				SET num = num - hours * 60 * 60;
			END IF;
            IF num >= 60 THEN
				SET minutes = FLOOR(num / 60);
				SET num = num - minutes * 60;
			END IF;
            IF num <= 60 THEN
				SET seconds = num;	
                SET num = num - seconds;
			END IF;
		END WHILE;     
		SET date_ = concat(date_, concat(days, " days"), " ", 
								  concat(hours, " hours"), " ",
								  concat(minutes, " minutes"), " ", 
								  concat(seconds, " seconds" ));
        RETURN date_;
END$$	
SELECT f_date(123456);

-- 2.Выведите только четные числа от 1 до 10.
-- Пример: 2,4,6,8,10 
DROP PROCEDURE IF EXISTS print_numb;
DELIMITER $$	
CREATE PROCEDURE print_numb
(
 IN num INT
)
BEGIN
	DECLARE n INT;
	DECLARE result VARCHAR(45) DEFAULT "";
    SET n = 1;
    WHILE n <= num DO
		IF n = num AND n MOD 2 = 0 THEN
				SET result = CONCAT(result, n); 
		END IF;
		IF n MOD 2 = 0 AND n != num  THEN			
			SET result = CONCAT(result, n, ", ");           
		END IF;
        SET n = n + 1;
    END WHILE;
    SELECT  result;
END$$

CALL print_numb(10);
        
            
	
