use Lab4
go

--1--
create function COUNT_STUDENTS(@faculty varchar(20)) returns int 
as begin declare @c int = 0;
    set @c = (select COUNT(IDSTUDENT)
	from STUDENT join GROUPS 
	on STUDENT.IDGROUP = GROUPS.IDGROUP
	join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
	where FACULTY.FACULTY=@faculty);
return @c;
end;


declare @faculty int = dbo.COUNT_STUDENTS('ИДиП');
print 'Count of students: '+cast(@faculty as varchar(4));


--2--
create FUNCTION FSUBJECTS(@p varchar(20)) returns char(300)
as 
begin
declare @one char(20);
declare @two varchar(300) = 'Students: ';
declare curserer CURSOR LOCAL
for select SUBJECT.PULPIT from SUBJECT
where PULPIT = @p;
open curserer;
fetch curserer into @one;
while @@FETCH_STATUS=0
begin 
set @two=@two+','+RTRIM(@one);
fetch curserer into @one;
end; return @two;
end;

select PULPIT.PULPIT, dbo.FSUBJECTS from PULPIT;


--3--
create function FFACPUL(@cd varchar(10), @cp varchar(10))
returns table 
as return 
select  FACULTY.FACULTY, PULPIT.PULPIT
from FACULTY left outer join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
where FACULTY.FACULTY = isnull(@cd, FACULTY.FACULTY)
and PULPIT.PULPIT = isnull(@cp, PULPIT.PULPIT)

select*from dbo.FFACPUL(NULL,NULL);
select*from dbo.FFACPUL('ИДиП',NULL);
select*from dbo.FFACPUL(NULL,'ИСиТ');
select*from dbo.FFACPUL('ИДиП','ПП');


--4--
create function FCTEACHER(@p varchar(10)) returns int
as 
begin 
declare @c int = (select COUNT(*) from TEACHER
where PULPIT = isnull(@p, PULPIT));
return @c;
end;
go


select PULPIT, dbo.FCTEACHER(PULPIT) [Количество преподавателей] from TEACHER;
select dbo.FCTEACHER(NULL) [Всего преподавателей];