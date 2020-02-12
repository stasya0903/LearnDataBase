#i. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице) in file "insertData"

#ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

USE vk;
SELECT firstname FROM users GROUP BY firstname ORDER BY firstname; 


#iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных 
#(поле is_active = false). Предварительно добавить такое поле в таблицу profiles 
#со значением по умолчанию = true (или 1)


ALTER TABLE vk.profiles ADD is_active BOOL DEFAULT FALSE;
UPDATE vk.profiles SET is_active = TRUE WHERE FLOOR(DATEDIFF(CURRENT_DATE, birthday)/365) < 18;

#iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)

DELETE FROM vk.messages WHERE FLOOR(DATEDIFF(CURRENT_DATE, created_at)) < 0;




