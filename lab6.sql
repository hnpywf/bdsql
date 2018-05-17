use Lab4
--1--
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME From AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
--2--
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME From AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%Компьютер%'
--3--
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME From AUDITORIUM, AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE

select TB1.AUDITORIUM, TB2.AUDITORIUM_TYPENAME From AUDITORIUM as TB1, AUDITORIUM_TYPE as TB2
where TB1.AUDITORIUM_TYPE=TB2.AUDITORIUM_TYPE and TB2.AUDITORIUM_TYPENAME like '%Компьютер%'
--4--
select PROGRESS.IDSTUDENT, STUDENT.NAME, 
case 
when ( PROGRESS.NOTE = 6) then 'шесть'
when ( PROGRESS.NOTE = 7) then 'семь'
when ( PROGRESS.NOTE = 8) then 'восемь'
else 'o.o'
end [Оценка]
from PROGRESS inner join STUDENT 
ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT 

--10.1--
use lab2
select Кредиты.[Название вида кредита], [Заказанные кредиты].[Название вида кредитов]
From Кредиты full outer join [Заказанные кредиты]
on Кредиты.[Название вида кредита]=[Заказанные кредиты].[Название вида кредитов]
where [Название вида кредита] is not null

--10.2--
use lab2
select Кредиты.[Название вида кредита], [Заказанные кредиты].[Название вида кредитов]
From Кредиты full outer join [Заказанные кредиты]
on Кредиты.[Название вида кредита]=[Заказанные кредиты].[Название вида кредитов]
where [Название вида кредитов] is not null