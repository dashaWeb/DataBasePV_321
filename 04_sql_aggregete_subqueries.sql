-- Aggregete function
/*
	-- COUNT() - обчислює кількість записів (символьними та числовими типами)
	-- SUM() - обчислює суму всіх записів (числовими типами)
	-- AVG() - обчислює середнє зачення записів (числовими типами)
	-- MIN() - обчислює мінімальне значення записів
	-- MAX() - обчислює максимальне значення записів
*/


select * from Students

-- COUNT
-- кількість студентів
select COUNT(Id) as 'Number of Students' from Students 

-- Null у функціях агрегації ігнорується
select COUNT(Email) as 'Number of Students' from Students 

insert into Students
values ('Ivan','Bondar',null, '2000-02-02',11.9,200,25,4)

--SUM
select SUM(Fails)
from Students

-- MIN
-- MAX
select MAX(AverageMark) as 'Max mark'
from Students

select  MIN(AverageMark) as 'Min mark'
from Students

select AVG(AverageMark) as 'Average Mark'
from Students, Groups as g

/*
	ROUND(number,n) - округлює, n - кількість знаків після коми 
	FLOOR() -  округлює до нижньої межі
	Ceiling() - округлює до верхньої межі межі
*/
select ROUND(AVG(AverageMark),3) as 'Round Mark'
from Students, Groups as g
select FLOOR(AVG(AverageMark)) as 'FLOOR Mark'
from Students, Groups as g
select CEILING(AVG(AverageMark)) as 'CEILING Mark'
from Students, Groups as g

select g.Name as 'Group', Count(s.Id) as 'Count of students', Max(s.AverageMark) as 'Max mark', ROUND(AVG(s.AverageMark),2) as 'Average Mark' 
from Groups as g join Students as s on g.Id = s.GroupId
group by g.Name -- вказуємо ключ групування
having COUNT(s.Id) >= 10 -- фільтр для груп


/*
Subqueries operators

-- [NOT]EXISTS - повертає true якщо запит повернув хоча б один запис
-- [> < >= <= <> =] ANY/SOME - повертає true якщо  хоча б один запис відповідає умов
-- [> < >= <= <> =] ALL - повертає true якщо  всі записи відповідає умов

*/

select* from Students
where AverageMark = ANY(
	select MAX(AverageMark) from Students
)


-- показати групи які мають хоча б одного студента з оцінкую > 11

select Name, Id
from Groups
where EXISTS(
	select AverageMark
	from Students
	where AverageMark >= 11 and Groups.Id = Students.GroupId
)

select* from TeachersGroups
select * from Teachers
insert into Teachers
values ('Ivan','Melnuck','2007-05-24', null)

-- показати викладачів які мають хоча б одну групу
select Id, Name, Phone
from Teachers  as t
where exists(
	select* from TeachersGroups as tg
	where tg.TeacherId = t.Id
)

-- показати викладачів, які мають хоча б одного студента Ivan
select Name, Phone
from Teachers
where exists(
	select s.Id
	from Students as s join Groups as g on s.GroupId = g.Id
	join TeachersGroups as tg on tg.GroupId = g.Id
	where tg.TeacherId = Teachers.Id and s.Name = 'Ivan'
)

select * from Students

-- показати групи в яких є хоча б одни студент старше 20-ти
select Name
from Groups
where exists(
	select Id from Students
	where DATEDIFF(YEAR,Birthday,GETDATE()) >= 20 and GroupId = Groups.Id
)

-- показати студентів, в яких імя співпадає з іменем викладача
select Name, Email, AverageMark
from Students
where Name = Some(
	select Name from Teachers
)

-- показати студентів, в яких дата народження більша за дату прийняття на роботу будь-якого викладача
select Name, Email, AverageMark
from Students
where Birthday > Any(
	select HireDate from Teachers
)

-- показати студентів в яких оцінка більша за оцінку всіх студентів групи Audi
select s.Name, s.Email,s.AverageMark,g.Name
from Groups as g join Students as s on s.GroupId = g.Id
where AverageMark > All(
	select AverageMark
	from Students as s join Groups as g on s.GroupId = g.Id
	where g.Name = 'Audi' and AverageMark is not null
)