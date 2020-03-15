#1
#В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
#Используйте транзакции.

CREATE TABLE sample.users (
	id bigint(20) unsigned auto_increment NOT NULL PRIMARY KEY,
	name varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL COMMENT 'Имя покупателя',
	birthday_at date NULL COMMENT 'Дата рождения',
	created_at datetime DEFAULT CURRENT_TIMESTAMP  NULL,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP  NULL);

START TRANSACTION;
SELECT * INTO @id, @name, @birthday_at, @created_at, @updated_at FROM shop.users  WHERE id = 1;
SAVEPOINT getInfo;
INSERT INTO sample.users VALUES(@id, @name, @birthday_at, @created_at, @updated_at);
DELETE FROM shop.users WHERE id = 1;

ROLLBACK;
COMMIT;

#2
#Создайте представление, которое выводит название name товарной позиции из таблицы products
# и соответствующее название каталога name из таблицы catalogs.

USE shop;

CREATE VIEW name_and_catalog AS 
SELECT p.name AS name, c.name AS `catalog` FROM shop.products AS P JOIN shop.catalogs AS c ON p.catalog_id = c.id;

SELECT * FROM name_and_catalog;

#3
#Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи 
#за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, 
#выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

CREATE TEMPORARY TABLE august (
`data` DATETIME,
is_created_at  BIT(1) );

SET @cur_day = '2020-08-01';

PREPARE insert_date FROM 'INSERT INTO august
VALUES(?, ?);
';

CREATE VIEW august_users AS 
SELECT created_at FROM users WHERE DATE_FORMAT(created_at, '%c') = 8;

SELECT DATE_FORMAT( @cur_day, '%e, %b');

SELECT created_at INTO @date_exsist FROM august_users WHERE DATE_FORMAT(created_at, '%e, %b') = @cur_day;


EXECUTE insert_date USING @cur_day, @is_created_at;

 SET @cur_day = '2020-08-01' + INTERVAL 1 DAY ;




#4
#(по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, 
#оставляя только 5 самых свежих записей.
