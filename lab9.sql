use master
use Lab4
go


--1--
create view [Преподаватели]
as select TEACHER [код]	,
TEACHER_NAME [имя преподавателя],
GENDER [пол],
PULPIT [код кафедры] from TEACHER;

--2--
create view [Количество кафедр]
as select FACULTY.FACULTY_NAME [факультет],
COUNT(PULPIT.PULPIT) [количество кафедр]
from FACULTY join PULPIT 
on FACULTY.FACULTY = PULPIT.FACULTY 
group by FACULTY_NAME;

--3--
create view Аудитории(Код, Наименование)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%';
go
select * from Аудитории

insert Аудитории(Код, Наименование) values('237-4',  '237-4')

--4--
create view Лекционные_аудитории(Код, Наименование, Тип)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM.AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%' with check option;
go
select * from Лекционные_аудитории
insert Лекционные_аудитории(Код, Наименование, Тип) values('247-4', '247-4', 'ЛК-К')
insert Лекционные_аудитории(Код, Наименование, Тип) values('245-4', '245-4', 'ЛБК')

--5--
create view Дисциплины(Код, [Наименование дисциплины],[Код кафедры])
as select top 10 SUBJECT, SUBJECT_NAME, PULPIT	from SUBJECT
order by SUBJECT;

--6--
alter view [Количество кафедр] with schemabinding
as select  FACULTY.FACULTY_NAME [факультет],
COUNT(PULPIT.PULPIT) [количество кафедр]
from dbo.FACULTY join dbo.PULPIT 
on FACULTY.FACULTY = PULPIT.FACULTY 
group by FACULTY_NAME;
