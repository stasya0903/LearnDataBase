#Практическое задание по теме “NoSQL”
#1 
#В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
redis-server --daemonize yes
redis-cli
#первое обращение

HMSET visits  192.168.1.0 1
#последующие обращения
hincr visits  192.168.1.0



#2
#При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

HMSET users user1 user1@gmail.com user2 user2@gmail.com user3 user3@gmail.com user4 user4@gmail.com
HMSET emails  user1@gmail.com user1  user2@gmail.com user2  user3@gmail.com user3   user4@gmail.com user4

HMGET users user1
HMGET emails user1@gmail.com




