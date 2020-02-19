#Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
#пользаватель user_id = 1

USE vk;

SELECT  friend_id,
		(SELECT CONCAT(firstname, " ", lastname )  from users where id = friend_id ) AS name, 
		count(*) as total   
FROM 													
 (SELECT id, from_user_id as friend_id  FROM  vk.messages where to_user_id = 1
 																			
UNION
SELECT id, to_user_id as friend_id  FROM  vk.messages where from_user_id = 1 ) 

AS friend_id 
WHERE 
(SELECT status FROM friend_requests 
		WHERE (initiator_user_id = friend_id and target_user_id = 1) OR (initiator_user_id = 1 and target_user_id = friend_id)) 
= "approved"
GROUP BY friend_id
ORDER BY total DESC 
LIMIT 1;

		
		
#Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

#общее для всех
SELECT 
		count(media_id)
FROM likes WHERE media_id IN 
								(SELECT id FROM media WHERE user_id  IN 
								(SELECT user_id FROM profiles WHERE FLOOR(DATEDIFF(CURRENT_DATE, birthday)/365) < 10));
							

#количество лайков для каждого							
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT 	count(*) as total_likes,
		(SELECT CONCAT(firstname, " ", lastname )  from users where id = user_id ) AS name,
		(SELECT user_id FROM media WHERE id = media_id) as user_id 
FROM likes
	WHERE user_id IN(SELECT user_id FROM profiles WHERE FLOOR(DATEDIFF(CURRENT_DATE, birthday)/365) < 10) GROUP BY user_id ;




#Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
 CASE  WHEN 

(SELECT count(*) as total_likes from likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender='f'))
>
(SELECT count(*) as total_likes from likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender='m'))

THEN "LADIES GOT MORE LIKES"
ELSE "MANS GOT MORE LIKES"
END AS who_got_more_likes;



