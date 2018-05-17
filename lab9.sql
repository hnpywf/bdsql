use master
use Lab4
go


--1--
create view [�������������]
as select TEACHER [���]	,
TEACHER_NAME [��� �������������],
GENDER [���],
PULPIT [��� �������] from TEACHER;

--2--
create view [���������� ������]
as select FACULTY.FACULTY_NAME [���������],
COUNT(PULPIT.PULPIT) [���������� ������]
from FACULTY join PULPIT 
on FACULTY.FACULTY = PULPIT.FACULTY 
group by FACULTY_NAME;

--3--
create view ���������(���, ������������)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like '��%';
go
select * from ���������

insert ���������(���, ������������) values('237-4',  '237-4')

--4--
create view ����������_���������(���, ������������, ���)
as select AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM.AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like '��%' with check option;
go
select * from ����������_���������
insert ����������_���������(���, ������������, ���) values('247-4', '247-4', '��-�')
insert ����������_���������(���, ������������, ���) values('245-4', '245-4', '���')

--5--
create view ����������(���, [������������ ����������],[��� �������])
as select top 10 SUBJECT, SUBJECT_NAME, PULPIT	from SUBJECT
order by SUBJECT;

--6--
alter view [���������� ������] with schemabinding
as select  FACULTY.FACULTY_NAME [���������],
COUNT(PULPIT.PULPIT) [���������� ������]
from dbo.FACULTY join dbo.PULPIT 
on FACULTY.FACULTY = PULPIT.FACULTY 
group by FACULTY_NAME;
