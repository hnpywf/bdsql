use master
use Lab4


--1--
select FACULTY.FACULTY, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME FROM 
FACULTY, PULPIT, PROFESSION
Where  FACULTY.FACULTY = PULPIT.FACULTY and 
PROFESSION.PROFESSION_NAME in (select PROFESSION_NAME from PROFESSION 
where (PROFESSION_NAME  like '%технология%') or (PROFESSION_NAME like '%технологии%'))

--2,3--
select FACULTY.FACULTY, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME FROM 
FACULTY inner join PULPIT on  FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION 
on PROFESSION.FACULTY = PULPIT.FACULTY  
where (PROFESSION_NAME  like '%технология%') or (PROFESSION_NAME like '%технологии%')

--4--
select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY  from AUDITORIUM one
where one.AUDITORIUM_TYPE = (select top(1) AUDITORIUM_TYPE from AUDITORIUM two
where two.AUDITORIUM_TYPE = one.AUDITORIUM_TYPE 
order by AUDITORIUM_CAPACITY desc)

--5--
select FACULTY_NAME from FACULTY, PULPIT
where not exists (select*from FACULTY 
where FACULTY.FACULTY = PULPIT.FACULTY)

--6--
select top 1
(select avg(NOTE) from PROGRESS
where SUBJECT like 'ОАиП') [Прога],
(select avg(NOTE) from PROGRESS
where SUBJECT like 'БД') [Базы данных],
(select avg(NOTE) from PROGRESS
where SUBJECT like 'СУБД') [СУБД]

--7--
select SUBJECT, NOTE from PROGRESS
where NOTE >=all(select NOTE from PROGRESS 
where SUBJECT like '%ОАиП%')

--8--
select SUBJECT, NOTE from PROGRESS
where NOTE >any (select NOTE from PROGRESS 
where PROGRESS.SUBJECT like '%ОАиП%')