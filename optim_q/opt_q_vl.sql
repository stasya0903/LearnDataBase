#Практическое задание по теме “Оптимизация запросов”
#1
#Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и 
#дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
table_name VARCHAR(255),
key_id BIGINT UNSIGNED NOT NULL ,
name VARCHAR(255)) ENGINE=Archive;



DROP TRIGGER IF EXISTS add_log_users;
DELIMITER //	
CREATE TRIGGER add_log_users AFTER INSERT ON users 
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (table_name, key_id, name)
			VALUES ('users', last_insert_id(), NEW.name);
END//

DROP TRIGGER IF EXISTS add_log_catalog//	
CREATE TRIGGER add_log_catalog AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (table_name, key_id, name)
			VALUES ('catalog', last_insert_id(), NEW.name);
END//

DROP TRIGGER IF EXISTS add_log_products//	
CREATE TRIGGER add_log_products AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (table_name, key_id, name)
			VALUES ('products', last_insert_id(), NEW.name);
END//

DELIMITER ;

INSERT INTO shop.users
(name, birthday_at, created_at, updated_at)
VALUES('name', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO shop.catalogs
(name)
VALUES('newCategory');

INSERT INTO shop.products
(name, desription, price, catalog_id, created_at, updated_at)
VALUES('name3', 'hsdfsldjf', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);



SELECT * FROM logs;
#2
#(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

