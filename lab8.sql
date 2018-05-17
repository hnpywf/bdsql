use master
use Lab4


--1--
select min(AUDITORIUM_CAPACITY) [����������� �����������],
 max(AUDITORIUM_CAPACITY) [������������ �����������],
 avg(AUDITORIUM_CAPACITY) [������� �����������],
 sum(AUDITORIUM_CAPACITY) [��������� �����������],
 COUNT(*) [���������� ���������]
from AUDITORIUM

--2--
select AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,
min(AUDITORIUM_CAPACITY) [����������� �����������],
 max(AUDITORIUM_CAPACITY) [������������ �����������],
 avg(AUDITORIUM_CAPACITY) [������� �����������],
 sum(AUDITORIUM_CAPACITY) [��������� �����������],
 COUNT(*) [���������� ���������]
from AUDITORIUM join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME

--3--
select *
from(select case 
when NOTE between 4 and 5 then '4-5'
when NOTE between 6 and 7 then '6-7'
when NOTE between 8 and 9 then '8-9'
when NOTE = '10' then '10'
else 'unbelieveble'
end [������], COUNT(*) [����������]
from PROGRESS Group by Case
when NOTE between 4 and 5 then '4-5'
when NOTE between 6 and 7 then '6-7'
when NOTE between 8 and 9 then '8-9'
when NOTE = '10' then '10'
else 'unbelieveble'
end) as tablet
ORDeR by case [������]	
when '4-5' then 4
when '6-7' then 3
when '8-9' then 2
when '10' then 1
when 'unbelieveble' then 0
else -1
end

--4--
	select FACULTY.FACULTY, GROUPS.PROFESSION,
	round(avg(cast(PROGRESS.NOTE as float(4))), 2) [������� ������]
	from FACULTY join PROFESSION
	on FACULTY.FACULTY = PROFESSION.FACULTY
	join GROUPS
	on PROFESSION.PROFESSION = GROUPS.PROFESSION
	join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
	join PROGRESS
	on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	group by 
	FACULTY.FACULTY, GROUPS.PROFESSION 
	order by [������� ������] desc

	--5--
		select FACULTY.FACULTY, GROUPS.PROFESSION,
	round(avg(cast(PROGRESS.NOTE as float(4))), 2) [������� ������]
	from FACULTY join PROFESSION
	on FACULTY.FACULTY = PROFESSION.FACULTY
	join GROUPS
	on PROFESSION.PROFESSION = GROUPS.PROFESSION
	join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
	join PROGRESS
	on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	where PROGRESS.SUBJECT like '&����&' or PROGRESS.SUBJECT like '%��%'
	group by 
	FACULTY.FACULTY, GROUPS.PROFESSION 
	order by [������� ������] desc

	--6--
	select FACULTY.FACULTY, PROFESSION, PROGRESS.SUBJECT
	from FACULTY join GROUPS	
	on FACULTY.FACULTY =  GROUPS.FACULTY
	join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
	join PROGRESS
	on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	where GROUPS.FACULTY in ('���')
	group by rollup (FACULTY.FACULTY, PROFESSION, PROGRESS.SUBJECT);

	--7--
	select FACULTY.FACULTY, PROFESSION, PROGRESS.SUBJECT
	from FACULTY join GROUPS	
	on FACULTY.FACULTY =  GROUPS.FACULTY
	join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
	join PROGRESS
	on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	where GROUPS.FACULTY in ('���')
	group by cube (FACULTY.FACULTY, PROFESSION, PROGRESS.SUBJECT);
