#Практическое задание по теме “Хранимые процедуры и функции, триггеры"
#1
#Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
#С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
#с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

use shop;


DELIMITER //

DROP FUNCTION IF EXISTS hello //
CREATE FUNCTION hello()
RETURNS TEXT NOT DETERMINISTIC
BEGIN
	DECLARE time_now INT;
	SET time_now = DATE_FORMAT(now(), '%k');
	
		IF (time_now > 6 AND time_now < 12) THEN 
		
		RETURN 'Доброе утро';
	
	ELSEIF (time_now >= 12 AND time_now < 18) THEN 
	
		RETURN 'Добрый день';
	
	ELSEIF(time_now >= 18 AND time_now <= 23) THEN
	
		RETURN 'Добрый вечер';
	
	ELSE 
	
		RETURN 'Доброй ночи';
	
	END IF;
	
END//

DELIMITER ;

SELECT hello();

#2
#В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
#Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
#Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо 
#отменить операцию.

DROP TRIGGER IF EXISTS no_empty_name_or_description;

DELIMITER //

CREATE TRIGGER no_empty_name_or_description BEFORE INSERT ON shop.products
FOR EACH ROW 
BEGIN 
	IF ((NEW.name IS NULL OR NEW.name = '') AND  (NEW.desription IS NULL OR NEW.desription = '' )) THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;
END

CREATE TRIGGER no_empty_name_or_description1 BEFORE UPDATE ON shop.products
FOR EACH ROW 
BEGIN 
	IF ((NEW.name IS NULL OR NEW.name = '') AND  (NEW.desription IS NULL OR NEW.desription = '' )) THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;
END

DELIMITER ;


#3
#(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
#в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

DELIMITER //

DROP FUNCTION IF EXISTS FIBONACCI //
CREATE FUNCTION FIBONACCI(num INT)
RETURNS BIGINT NOT DETERMINISTIC
BEGIN
	DECLARE f1, f2 BIGINT;
	DECLARE total BIGINT;
	
	SET f1 = 1;
	SET f2 = 1;
	SET total = 0;
	cycle: LOOP
	SET num = num - 1;

	IF num < 2 THEN 
		RETURN total;
		LEAVE cycle;
	END IF;
	SET total = f1 + f2;
	
	SET f1 = f2;
	SET f2 = total;
	

	
END LOOP cycle;


END//

DELIMITER ;

SELECT FIBONACCI(9);
