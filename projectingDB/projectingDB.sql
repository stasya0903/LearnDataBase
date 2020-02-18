/*Написать крипт, добавляющий в БД vk, которую создали на занятии, 
3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)*/

DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

USE vk;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id SERIAL PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    
    INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS audio;

CREATE TABLE  audio(
id SERIAL PRIMARY KEY,
added_user_id BIGINT UNSIGNED NOT NULL,
added_at DATETIME DEFAULT NOW(),

INDEX (added_user_id),
FOREIGN KEY (added_user_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS singers;

CREATE TABLE  singers (
id SERIAL PRIMARY KEY,
first_name VARCHAR(255),
last_name VARCHAR(255),
country VARCHAR(255),

INDEX singers_first_name_last_name(firstname, lastname)

);

DROP TABLE IF EXISTS songs;

CREATE TABLE  songs (

id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
name VARCHAR(255),
singer_id BIGINT UNSIGNED NOT NULL,
duration TIME(0) NOT NULL,
gender VARCHAR(255),

INDEX (id),
INDEX (singer_id),

FOREIGN KEY (id) REFERENCES audio(id),
FOREIGN KEY (singer_id) REFERENCES singers(id)
);


DROP TABLE IF EXISTS user_audio;

CREATE TABLE  user_audio(
audio_id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED NOT NULL,

INDEX (audio_id),
INDEX (user_id),

FOREIGN KEY (audio_id) REFERENCES audio(id),
FOREIGN KEY (user_id) REFERENCES users(id)

);
