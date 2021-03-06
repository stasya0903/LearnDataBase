#Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
# 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

USE vk;
UPDATE users SET created_at = NOW(),
				updated_at = NOW();
# 2 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
# и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу 
#DATETIME, сохранив введеные ранее значения.

			
ALTER TABLE users MODIFY created_at VARCHAR(255), MODIFY updated_at VARCHAR(255);
UPDATE users SET created_at='20.10.2017 8:10', updated_at='20.10.2017 8:10';

UPDATE users SET created_at = DATE_FORMAT(STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'), '%Y-%m-%d %T'), 
					updated_at = DATE_FORMAT(STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i'), '%Y-%m-%d %T');
ALTER TABLE users MODIFY created_at DATETIME, MODIFY updated_at DATETIME;


#3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля,
 #если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 #Однако, нулевые запасы должны выводиться в конце, после всех записей.
CREATE DATABASE shop;

USE shop;

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO `storehouses_products` VALUES ('1',NULL,NULL,'3','2019-07-11 01:46:33','2007-07-22 23:08:57'),
('2',NULL,NULL,'9','1975-10-11 06:18:23','1988-02-21 23:06:20'),
('3',NULL,NULL,'4','2012-11-28 17:50:13','1996-02-21 19:43:17'),
('4',NULL,NULL,'5','2014-02-24 05:02:45','1999-01-25 10:47:53'),
('5',NULL,NULL,'2','1999-04-15 12:55:38','1980-12-15 04:17:07'),
('6',NULL,NULL,'1','1973-03-15 14:15:48','2009-03-25 13:56:56'),
('7',NULL,NULL,'7','2011-07-23 06:44:34','1983-01-24 02:41:09'),
('8',NULL,NULL,'5','2012-09-16 20:05:06','1985-04-19 00:17:42'),
('9',NULL,NULL,'5','2006-09-20 16:33:11','2013-06-29 10:43:53'),
('10',NULL,NULL,'0','1983-09-14 03:48:46','1970-09-20 00:03:32'),
('11',NULL,NULL,'7','1981-06-24 06:04:44','2007-07-23 18:35:45'),
('12',NULL,NULL,'2','1977-12-02 17:53:10','1988-08-25 09:00:34'),
('13',NULL,NULL,'8','1990-01-29 15:04:36','1984-08-04 06:29:22'),
('14',NULL,NULL,'4','2019-12-01 16:17:36','1984-03-01 04:53:45'),
('15',NULL,NULL,'8','2006-12-16 06:16:17','2015-11-13 15:20:36'),
('16',NULL,NULL,'0','1994-02-10 20:57:59','2007-06-13 10:05:57'),
('17',NULL,NULL,'1','1982-03-28 09:10:46','1997-10-13 21:57:47'),
('18',NULL,NULL,'5','1989-01-18 14:51:53','2006-09-26 21:58:12'),
('19',NULL,NULL,'6','1970-06-14 03:49:29','1992-09-05 03:46:34'),
('20',NULL,NULL,'4','1977-09-29 03:23:39','1995-01-06 02:22:16'),
('21',NULL,NULL,'9','2007-08-08 06:11:01','2001-12-30 22:59:55'),
('22',NULL,NULL,'5','1974-07-10 10:35:46','1990-11-03 01:33:18'),
('23',NULL,NULL,'4','1991-07-30 03:34:00','1978-06-05 15:57:15'),
('24',NULL,NULL,'7','2017-03-01 19:26:49','2017-01-22 13:44:47'),
('25',NULL,NULL,'3','1987-06-04 11:34:58','1989-06-23 09:25:47'),
('26',NULL,NULL,'8','1976-04-01 00:05:56','2018-07-26 10:05:19'),
('27',NULL,NULL,'3','1990-08-25 13:58:46','2001-11-05 06:34:35'),
('28',NULL,NULL,'6','1983-07-17 14:43:56','1981-11-22 01:11:45'),
('29',NULL,NULL,'8','2004-05-07 05:38:10','2000-05-04 02:06:16'),
('30',NULL,NULL,'6','2009-08-04 07:22:16','1986-07-12 22:55:26'),
('31',NULL,NULL,'5','1973-05-06 10:17:25','2017-07-18 09:50:34'),
('32',NULL,NULL,'6','1973-12-09 01:44:18','1987-12-20 16:18:37'),
('33',NULL,NULL,'0','1980-10-12 02:24:28','1982-04-29 11:05:49'),
('34',NULL,NULL,'7','2002-12-14 09:46:49','1993-10-25 01:08:49'),
('35',NULL,NULL,'3','2014-07-27 04:04:32','1977-12-02 07:40:32'),
('36',NULL,NULL,'7','1974-11-25 19:13:01','1996-08-30 16:52:04'),
('37',NULL,NULL,'5','2014-07-12 16:27:27','1986-07-01 16:16:59'),
('38',NULL,NULL,'0','1975-12-03 00:52:13','2006-04-13 12:40:20'),
('39',NULL,NULL,'1','2005-06-16 15:11:00','1994-03-24 12:58:22'),
('40',NULL,NULL,'6','1980-12-02 20:06:44','2007-10-30 04:29:25'),
('41',NULL,NULL,'3','1990-06-30 18:39:28','2004-01-31 02:57:04'),
('42',NULL,NULL,'5','1998-07-16 00:00:25','1988-04-06 23:34:04'),
('43',NULL,NULL,'6','1980-05-16 08:48:49','1973-09-11 05:17:53'),
('44',NULL,NULL,'1','1990-10-09 12:41:44','1972-02-28 17:23:42'),
('45',NULL,NULL,'3','2000-03-19 13:48:00','1971-05-30 17:50:40'),
('46',NULL,NULL,'3','2005-03-16 17:16:25','1975-10-01 05:16:20'),
('47',NULL,NULL,'9','1986-11-01 03:37:52','2017-04-08 22:33:52'),
('48',NULL,NULL,'8','2009-04-15 16:34:00','2015-07-20 18:34:42'),
('49',NULL,NULL,'1','2010-10-15 01:11:28','2002-01-14 00:00:58'),
('50',NULL,NULL,'3','2012-12-30 18:34:23','2014-12-29 21:29:59'),
('51',NULL,NULL,'7','1971-11-20 09:14:49','1985-05-31 20:00:54'),
('52',NULL,NULL,'5','2009-11-26 05:23:47','1990-11-30 15:50:52'),
('53',NULL,NULL,'8','1992-06-06 16:56:23','1995-08-29 03:52:03'),
('54',NULL,NULL,'7','2008-11-17 00:37:24','2006-09-19 21:31:32'),
('55',NULL,NULL,'9','1970-05-08 10:04:10','1978-11-20 00:11:15'),
('56',NULL,NULL,'4','2016-01-07 08:42:21','1970-07-13 10:53:26'),
('57',NULL,NULL,'3','1992-02-24 22:04:35','2000-02-28 18:52:23'),
('58',NULL,NULL,'7','2009-09-30 21:57:21','1980-06-01 04:27:53'),
('59',NULL,NULL,'4','2010-12-10 21:21:23','2005-06-01 03:19:03'),
('60',NULL,NULL,'2','2001-06-05 13:06:17','1978-05-02 23:09:08'),
('61',NULL,NULL,'9','2001-10-23 14:26:55','2019-12-23 23:47:13'),
('62',NULL,NULL,'8','1974-11-20 04:22:59','1985-02-18 03:24:34'),
('63',NULL,NULL,'9','1971-12-23 03:19:40','1987-06-02 10:22:52'),
('64',NULL,NULL,'4','2003-08-13 05:01:59','2016-10-03 17:31:30'),
('65',NULL,NULL,'3','2005-01-30 13:42:47','1976-07-11 14:51:40'),
('66',NULL,NULL,'3','1999-06-18 03:36:01','2002-08-28 07:29:29'),
('67',NULL,NULL,'4','2014-12-22 12:16:28','2003-09-05 08:38:29'),
('68',NULL,NULL,'2','1973-11-05 21:54:55','2008-10-30 10:55:02'),
('69',NULL,NULL,'6','1998-03-19 12:51:14','1973-10-03 17:22:43'),
('70',NULL,NULL,'2','1971-03-12 03:26:26','1973-11-01 17:02:23'),
('71',NULL,NULL,'5','1983-03-04 23:11:58','2001-12-04 00:27:42'),
('72',NULL,NULL,'2','1979-03-28 15:13:08','1994-04-17 05:21:28'),
('73',NULL,NULL,'4','2005-09-10 01:27:44','1976-02-04 20:19:18'),
('74',NULL,NULL,'2','2019-11-19 20:04:09','1979-12-26 07:57:47'),
('75',NULL,NULL,'9','1988-11-07 06:56:35','1971-03-19 09:42:24'),
('76',NULL,NULL,'2','1992-02-17 02:11:49','2017-03-06 16:38:51'),
('77',NULL,NULL,'7','2011-01-09 16:33:10','1976-06-26 14:15:31'),
('78',NULL,NULL,'7','2015-09-13 02:50:54','1991-06-08 12:50:23'),
('79',NULL,NULL,'5','1977-02-12 21:12:19','2004-11-10 08:14:49'),
('80',NULL,NULL,'0','2008-09-26 09:02:09','1973-10-10 07:29:53'),
('81',NULL,NULL,'8','1996-03-27 20:03:55','1980-10-20 08:03:00'),
('82',NULL,NULL,'3','1970-10-17 09:11:45','1971-06-01 07:44:18'),
('83',NULL,NULL,'1','1983-11-16 01:05:24','1978-06-24 15:26:40'),
('84',NULL,NULL,'0','2006-07-23 13:33:11','2005-04-20 04:38:20'),
('85',NULL,NULL,'9','1992-02-03 19:54:44','2018-12-05 06:47:32'),
('86',NULL,NULL,'7','2017-03-27 05:06:23','1985-06-26 14:13:52'),
('87',NULL,NULL,'1','1970-12-04 03:08:38','2016-10-09 07:04:41'),
('88',NULL,NULL,'4','2011-10-14 18:03:40','2007-11-28 09:15:55'),
('89',NULL,NULL,'5','1974-02-08 06:43:03','1995-02-20 19:13:16'),
('90',NULL,NULL,'2','2018-09-19 22:11:30','1971-11-30 21:36:29'),
('91',NULL,NULL,'6','2006-07-29 16:31:10','2008-06-28 09:13:50'),
('92',NULL,NULL,'1','1979-01-02 02:45:43','2004-07-13 07:04:54'),
('93',NULL,NULL,'6','1985-01-30 01:00:16','2006-03-11 01:47:29'),
('94',NULL,NULL,'3','1998-01-18 14:07:52','1972-07-26 21:50:34'),
('95',NULL,NULL,'1','2014-07-10 12:58:47','2012-10-24 10:18:45'),
('96',NULL,NULL,'7','1977-09-09 16:46:26','2004-08-19 13:05:17'),
('97',NULL,NULL,'3','2013-12-05 18:45:07','2017-11-22 06:04:38'),
('98',NULL,NULL,'3','1979-06-30 22:27:45','2002-09-23 02:48:28'),
('99',NULL,NULL,'3','1971-12-26 04:54:19','1991-11-01 10:31:20'),
('100',NULL,NULL,'9','1993-06-22 12:53:43','1982-12-17 21:06:29'); 


SELECT * FROM storehouses_products ORDER BY CASE  WHEN value = 0 then 101  else value end;


#4(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
#Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT *  
 FROM vk.profiles WHERE  CASE 
	WHEN DATE_FORMAT(birthday, '%b') = 'Aug' THEN  'august'
	WHEN DATE_FORMAT(birthday, '%b') = 'May' THEN  'may'
	ELSE 'month'
  END  IN('may', 'august');
 
#5(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
# Отсортируйте записи в порядке, заданном в списке IN.

 SELECT * FROM users WHERE id IN (5, 1, 2)  ORDER BY FIELD(id, 5, 1, 2);

 




