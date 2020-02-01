#Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.

 /* MacBook-Air-dns:MySQLWorkbench.app Alena$ ls -la ~| grep .my.cnf
-rw-r--r--@   1 Alena  staff        29 Feb  1 13:58 .my.cnf
MacBook-Air-dns:MySQLWorkbench.app Alena$ mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 27
Server version: 8.0.18 Homebrew

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
 */

#Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

CREATE DATABASE example;
USE example;
CREATE TABLE users (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
NAME VARCHAR(100) NOT NULL);

#Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

CREATE DATABASE sample;

mysqldump example > example.sql
mysql sample < example.sql

/*(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql.
 Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.*/

 mysqldump mysql --where="true limit 100" help_keyword  > help_keyword.sql


