#1   Подсчитайте средний возраст пользователей в таблице users

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) FROM vk.profiles
#2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
#Следует учесть, что необходимы дни недели текущего года, а не года рождения.


SELECT COUNT(*) AS total,
DATE_FORMAT(CONCAT(YEAR(NOW()), '-', DATE_FORMAT(birthday, '%c-%d')) , '%a') AS day_of_week 
FROM vk.profiles GROUP BY day_of_week ;


#(по желанию) Подсчитайте произведение чисел в столбце таблицы

CREATE TABLE for_myltiply (
value SERIAL );

INSERT INTO for_myltiply (value) 
VALUES (1),(2),(3),(4),(5);


SELECT exp(sum(ln(value))) FROM for_myltiply;


