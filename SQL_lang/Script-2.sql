/*Пусть в таблице catalogs базы данных shop в строке name могут находиться пустые строки и 
 поля принимающие значение NULL. 
 Напишите запрос, который заменяет все такие поля на строку ‘empty. 
 Помните, что на уроке мы установили уникальность на поле name.
  Возможно ли оставить это условие? Почему?*/
 
/*USE shop;
ALTER catalogs DROP index unique_name;

UPDATE catalogs
SET name = "empty"
WHERE name IS NULL;*/

/*Спроектируйте базу данных, которая позволяла бы организовать хранение медиа-файлов, 
загружаемых пользователем (фото, аудио, видео). Сами файлы будут храниться в файловой системе,
а база данных будет хранить только пути к файлам, названия, описания, 
ключевых слов и принадлежности пользователю.*/

DROP DATABASE IF EXISTS media;

CREATE DATABASE media;

USE media_files;

DROP TABLE IF EXISTS users  ;

CREATE TABLE users(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
UNIQUE unique_name (name(10)));

DROP TABLE IF EXISTS files  ;

CREATE TABLE files (
file_id SERIAL  PRIMARY KEY,
file_name VARCHAR(255),
file_size BIGINT,
file_description TEXT,
key_words TEXT,
user_id BIGINT UNSIGNED NOT NULL,
INDEX user_id_indx(user_id),
FOREIGN KEY (user_id) REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE CASCADE
)

/*В учебной базе данных shop присутствует таблица catalogs. Пусть в базе данных sample имеется таблица cat, 
 * в которой могут присутствовать строки с такими же первичными ключами. Напишите запрос, который копирует данныe
  из таблицы catalogs в таблицу cat, при этом для записей с конфликтующими первичными ключами в таблице cat 
 должна производиться замена значениями из таблицы catalogs.*/

INSERT INTO sample.cat SELECT * FROM shop.catalogs 
ON DUPLICATE KEY UPDATE name = VALUES(name);






