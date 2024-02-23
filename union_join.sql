-- union - об'єднує декілька запитів в одну результуючу таблицю, при цьому видаляючи дублікати
-- union all - об'єднує декілька запитів в одну результуючу таблицю, при цьому дублікати не видаляючи 

 select 'Count Student', COUNT(Id) from Students
 union
 select 'Avg Student', AVG(AverageMark) from Students

 select* from Students
 select* from Groups

 select* from TeachersGroups
 select* from Teachers

 select Name from Students
 union
 select Name from Teachers

 select Name from Students
 union all
 select Name from Teachers


 insert into Students
 values('Maria','Bondar',null,'2000-03-05',10.8,200,25,null),
 ('Petro','Melnuk',null,'2002-03-05',10.8,200,25,null)


 insert into Groups
 values ('PR_322'),('PV_321'),('PD_322')

 -- JOIN operator - використовується для отримання звязаних записів з різних таблиць
 -- [INNER] JOIN - повертати всі записи таблиці А, які звязані з записами таблиці В
-- показати всіх студентів та їх групи
 select A.Name, A.Email, A.AverageMark, B.Name
 from Students as A join Groups as B on A.GroupId = B.Id

 --Left join - повертає всі записи таблиці А, які звязані або не мають звязку з таблице В
 -- показати всіх студентів т а їх групи, які мають або не мають групу
 select A.Name, A.Email, A.AverageMark, B.Name
 from Students as A left join Groups as B on A.GroupId = B.Id

 -- показати всіх викладачів та к-ть їхніх груп, а також тих в кого немає груп
select t.Name, COUNT(g.Id) as 'Count Groups'
from Teachers as t LEFT JOIN TeachersGroups as tg on t.Id = tg.TeacherId
				   LEFT JOIN Groups as g on tg.GroupId = g.Id	
group by t.Name, t.Id

-- LEFt JOIN with NULL FOREIGN KEY - повертає лише записи таблиці А, які не звязані з жодним записом таблиці В
 -- показати всіх студентів, які не мають групу
 select A.Name, A.Email, A.AverageMark, B.Name
 from Students as A left join Groups as B on A.GroupId = B.Id
 where A.GroupId is null

  --Right join - повертає всі записи таблиці B, які звязані або не мають звязку з таблице A
-- показати всіх студентів та їх групи, а також групи, які не мають жодного студента
 select A.Name, A.Email, A.AverageMark, B.Name
 from Students as A right join Groups as B on A.GroupId = B.Id

 -- RIGHT JOIN with NULL FOREIGN KEY - повертає лише записи таблиці B, які не звязані з жодним записом таблиці A
 -- показати всіх , які не мають жодного студента
 select A.Name, A.Email, A.AverageMark, B.Name
 from Students as A right join Groups as B on A.GroupId = B.Id
 where A.GroupId is null

 -- FULL [OUTER] JOIN - повертає записи таблиці А та В, які звязані або не мають звязку між собою
-- показати всіх студентів , які мають групу або не мають її, а також показати групи, які мають або не мають жодного студента
 select A.Name, A.Email, A.AverageMark, B.Name
 from Students as A full outer join Groups as B on A.GroupId = B.Id


 -- FULL [OUTER] JOIN with NULL FOREIGN KEY - повертає лише записи таблиці А та В, які не мають звязку між собою
-- показати студентів, які не мають груп і групи, які не мають студентів
 select A.Name, A.Email, A.AverageMark, B.Name
 from Students as A full outer join Groups as B on A.GroupId = B.Id
 where A.GroupId is null