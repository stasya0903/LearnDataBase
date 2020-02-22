# 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

use shop;
SELECT *, FROM users as u  JOIN orders as o ON  u.id = o.user_id;

SELECT * FROM users WHERE id IN(SELECT user_id FROM orders );

#2 Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.*, c.name as category FROM products as p  JOIN catalogs as c ON  p.catalog_id = c.id;

SELECT *, 
      (SELECT name FROM catalogs where products.catalog_id = catalogs.id) as catalogs 
     FROM products;



#3 (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
#Поля from, to и label содержат английские названия городов, поле name — русское. 
#Выведите список рейсов flights с русскими названиями городов.

  SELECT `from`.id, `from`.city, `to`.city FROM 
 (SELECT f.id as id, c.name as city FROM flights as f JOIN  cities as c ON `from`=`label`) as `from`
 JOIN 
 (SELECT f.id as id, c.name as city FROM flights as f JOIN  cities as c ON `to`=`label`) as `to`
 ON `from`.id = `to`.id;
    
    
    
use shop;

DROP TABLE IF EXISTS `flights`;
CREATE TABLE `flights` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from` VARCHAR(255),
  `to` VARCHAR(255),
  PRIMARY KEY (`id`)
) ;


DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  label VARCHAR(255),
  name VARCHAR(255),
  PRIMARY KEY (`label`)
) ;

INSERT INTO flights (`from`, `to`) VALUES
('Valencia', 'Washington'),
('Vienna', 'Venice'),
('Guatemala','The Hague'),
('Guiyang',	'Vilnius'),
('Varna',	'Vitebsk'),
('Glasgow',	'The Hague'),
('Gomel',	'Havana'),
('Guiyang',	'Hamburg');


INSERT INTO cities (name, label) VALUES
('Валенсия', 	'Valencia'),
('Варна',	'Varna'),
('Варшава',	'Warsaw'),
('Вашингтон',	'Washington'),
('Веллингтон',	'Wellington'),
('Вена',	'Vienna'),
('Венеция',	'Venice'),
('Вильнюс',	'Vilnius'),
('Витебск',	'Vitebsk'),
('Гаага',	'The Hague'),
('Гавана',	'Havana'),
('Гамбург',	'Hamburg'),
('Гаосюн',	'Kaohsiung'),
('Гвадалахара',	'Guadalajara'),
('Гватемала',	'Guatemala'),
('Гданьск',	'Gdansk'),
('Гент',	'Ghent'),
('Гётеборг',	'Gothenburg'),
('Гирин',	'Jilin'),
('Глазго',	'Glasgow'),
('Гомель',	'Gomel'),
('Гродно',	'Grodno, Hrodna'),
('Гуанчжоу',	'Guangzhou'),
('Гуйян',	'Guiyang'),
('Гуаякиль',	'Guayaquil');



