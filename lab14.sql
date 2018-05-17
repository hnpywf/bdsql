use Lab4


--1--
//*go
CREATE PROCEDURE PSUBJECT --sozdanie proceduri
as begin 
declare @c int = (select COUNT(*) from SUBJECT);
select*from SUBJECT;
return @c;
end;

declare @c int = 0;
EXEC @c=PSUBJECT; -- vizov proceduri
print 'SC= '+cast(@c as varchar(3)); *//


--2--
declare @c int = 0, @r int = 0, @p varchar(20);
exec @c = PSUBJECT @p = 'ИСиТ', @cc = @r output;
print 'Full c= '+cast(@c as varchar(3));
print 'c of '+cast(@p as varchar(3))+' = '+cast(@r as varchar(3));


--3--
create table #subject
 ( SUBJECT char primary key, 
   SUBJECT_NAME varchar(100),
   PULPIT char(20)
 )

alter procedure PSUBJECT
@p varchar(20) 
as begin 
declare @c int = (select COUNT(*)from SUBJECT);
select * from SUBJECT where PULPIT=@p;
end;

insert #subject exec dbo.PSUBJECT @p='ИСиТ';
insert #subject exec dbo.PSUBJECT @p='ТЛ';

select*from #subject;

--4--
create procedure PAUDITORIUM_INSERT
@a char(20), @n varchar(50),@c int, @t char(10)
as declare @id int = 1;
set @c = 0;
begin 
try 
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
values (@a, @t, @c, @n)
return @id; 
end try
begin catch              
  print 'номер ошибки  : ' + cast(error_number() as varchar(6));
  print 'сообщение     : ' + error_message();
  print 'уровень       : ' + cast(error_severity()  as varchar(6));
  print 'метка         : ' + cast(error_state()     as varchar(8));
  print 'номер строки  : ' + cast(error_line()      as varchar(8));
  if error_procedure() is not  null   
  print 'имя процедуры : ' + error_procedure();
return -1;
end  catch; 


declare @id int;
exec @id = dbo.PAUDITORIUM_INSERT @a='421-3', @t = 'ЛК', @c = 90, @n = '421-3';
print 'код ошибки: '+cast(@id as varchar(3));


--5--
create procedure SUBJECT_REPORT @p char(10)
as 
declare @id	int = 0;
begin try
declare @o char(20), @t char(300)='';
declare cur cursor for 
select SUBJECT from SUBJECT where PULPIT = @p;
if not exists(select SUBJECT from SUBJECT where PULPIT = @p)
raiserror('error',11 ,1);
else open cur;
fetch cur into @o;
print 'Предметы';
while @@FETCH_STATUS=0
begin 
set @t=RTRIM(@o)+', '+@t;
set @id = @id+1;
fetch cur into @o;
end; 
print @t;
close cur; return @id;
end try
begin catch 
print 'here an error'
if error_procedure() is not null
print 'name of procedure: '+error_procedure();
return @id;
end catch;


declare @id int;
exec @id=dbo.SUBJECT_REPORT @p='ИСиТ';
print 'count of subjects '+cast(@id as varchar(3));

declare @id int;
exec @id=dbo.SUBJECT_REPORT @p='ЕСИТ';
print 'count of subjects '+cast(@id as varchar(3));



--6--
create procedure PAUDTORIUM_INSERTX
@a char(20), @n varchar(50),@c int, @t char(10), @tn varchar(50)
as declare @id int =1;
begin try 
set transaction isolation level SERIALIZABLE;
begin tran
insert into  AUDITORIUM_TYPE(AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
values (@t, @tn)
exec @id=dbo.PAUDITORIUM_INSERT @a, @n, @c, @t;
commit tran;
return @id;
end try 
 begin catch 
print 'номер ошибки  : ' + cast(error_number() as varchar(6));
print 'сообщение     : ' + error_message();
print 'уровень       : ' + cast(error_severity()  as varchar(6));
print 'метка         : ' + cast(error_state()   as varchar(8));
print 'номер строки  : ' + cast(error_line()  as varchar(8));
if error_procedure() is not  null   
 print 'имя процедуры : ' + error_procedure();
 if @@trancount > 0 rollback tran ; 
 return -1;	  
     end catch;


declare @id int;
exec @id=dbo.PAUDTORIUM_INSERTX @a='422-3', @t = 'ЛБ-Н', @c = 45, @n = '422-3', @tn='ЛАБАРАТОРНАЯНА';
print 'error code: '+cast(@id as varchar(3));


