use Lab4


--1--
create table TR_AUDIT
(
  ID int identity,
  STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(600)
)



create trigger TR_TEACHER_INS
on TEACHER after insert 
as 
declare @one varchar(20), @two varchar(50), @tree varchar(1), @four varchar(10), @in varchar(600);
print 'Insert operation';
set @one = (select [TEACHER] from inserted);
set @two = (select [TEACHER_NAME] from inserted);
set @tree = (select [GENDER] from inserted);
set @four = (select [PULPIT] from inserted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four; 
 insert into TR_AUDIT(STMT, TRNAME, CC)
 values('INS', 'TEACHER_INS', @in);
 return;
 go


insert into TEACHER values(' Œ Œ  ', ' ÓÍÓËÍ —‡Ìˇ »‚‡Ì˚˜', 'Ï', '»—Ë“');

select*from TR_AUDIT


--2--
create trigger TR_TEACHER_DEL
on TEACHER after delete
as 
declare @one varchar(20), @two varchar(50), @tree varchar(1), @four varchar(10), @in varchar(600);
print 'delete operation';
set @one = (select [TEACHER] from deleted);
set @two = (select [TEACHER_NAME] from deleted);
set @tree = (select [GENDER] from deleted);
set @four = (select [PULPIT] from deleted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four; 
 insert into TR_AUDIT(STMT, TRNAME, CC)
  values('DEL', 'TEACHER_DEL', @in);
 return;
 go


 
delete from TEACHER where TEACHER = ' Œ Œ  ';

select*from TR_AUDIT


--3--
create trigger TR_TEACHER_UPD
on TEACHER after update
as 
declare @one varchar(20), @two varchar(50), @tree varchar(1), @four varchar(10), @in varchar(600);
print 'update operation';
set @one = (select [TEACHER] from inserted);
set @two = (select [TEACHER_NAME] from inserted);
set @tree = (select [GENDER] from inserted);
set @four = (select [PULPIT] from inserted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four; 
set @one = (select [TEACHER] from deleted);
set @two = (select [TEACHER_NAME] from deleted);
set @tree = (select [GENDER] from deleted);
set @four = (select [PULPIT] from deleted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four + ', ' + @in; 
 insert into TR_AUDIT(STMT, TRNAME, CC)
  values('UPD', 'TEACHER_UPD', @in);
 return;
 go


update TEACHER set PULPIT = 'À”' where TEACHER = ' Œ Œ  ';

select*from TR_AUDIT

--4--
create trigger TR_TEACHER on TEACHER after insert, delete, update 
as declare @one varchar(20), @two varchar(50), @tree varchar(1), @four varchar(10), @in varchar(600);
declare @ins int = (select COUNT(*) from inserted),
        @del int = (select COUNT(*) from deleted);

	if @ins > 0 and @del = 0 begin print 'INSERT'
	set @one = (select [TEACHER] from inserted);
set @two = (select [TEACHER_NAME] from inserted);
set @tree = (select [GENDER] from inserted);
set @four = (select [PULPIT] from inserted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four; 
 insert into TR_AUDIT(STMT, TRNAME, CC)
 values('INS', 'TEACHER_INS', @in);
 end; else 
 if @ins = 0 and @del > 0 begin print 'DELETE'
 set @one = (select [TEACHER] from deleted);
set @two = (select [TEACHER_NAME] from deleted);
set @tree = (select [GENDER] from deleted);
set @four = (select [PULPIT] from deleted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four; 
 insert into TR_AUDIT(STMT, TRNAME, CC)
  values('DEL', 'TEACHER_DEL', @in);
 end; else 
 if @ins > 0 and @del > 0 begin print 'UPDATE'
 set @one = (select [TEACHER] from inserted);
set @two = (select [TEACHER_NAME] from inserted);
set @tree = (select [GENDER] from inserted);
set @four = (select [PULPIT] from inserted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four; 
set @one = (select [TEACHER] from deleted);
set @two = (select [TEACHER_NAME] from deleted);
set @tree = (select [GENDER] from deleted);
set @four = (select [PULPIT] from deleted);
set @in = @one + ', ' + @two + ', ' + @tree + ', ' + @four + ', ' + @in; 
 insert into TR_AUDIT(STMT, TRNAME, CC)
  values('UPD', 'TEACHER_UPD', @in);
 end; return;


 insert into TEACHER values('√»–ﬂ', '√ÂÏÎËÌ ¬ËÍÚÓ —‡Ì˚˜', 'Ï', '»—Ë“');
 delete from TEACHER where TEACHER = ' Œ Œ  ';
 update TEACHER set PULPIT = 'À”' where TEACHER = '√»–ﬂ';

select*from TR_AUDIT


--5--
update TEACHER set GENDER = '˚‚˚' where TEACHER = '√»–ﬂ';


--6--
create trigger TR_TEACHER_DEL1 on TEACHER after DELETE
as print 'TR_TEACHER_DEL1'
return;
go
create trigger TR_TEACHER_DEL2 on TEACHER after DELETE
as print 'TR_TEACHER_DEL2'
return;
go 
create trigger TR_TEACHER_DEL3 on TEACHER after DELETE
as print 'TR_TEACHER_DEL3' 
return;
go

select a.name, b.type_desc
from sys.triggers a join sys.trigger_events b on a.object_id = b.object_id
where object_name(a.parent_id)='TEACHER' and b.type_desc='DELETE';

exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL3', 
@order = 'First', @stmttype = 'DELETE';
exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL2', 
@order = 'Last', @stmttype = 'DELETE';


--7--
create trigger TRG_GRT
on AUDITORIUM after INSERT, DELETE, UPDATE
as declare @k int = (select sum(AUDITORIUM_CAPACITY) from AUDITORIUM);
if (@k > 600)
begin 
raiserror('CAPACITY CANT BE > 600', 10, 1);
rollback;
end;
return;



update AUDITORIUM set AUDITORIUM_CAPACITY = 760 where AUDITORIUM_NAME = 'À¡- '


--8--
create trigger INSTeADofDelete
on AUDITORIUM instead of delete
as
raiserror(N'u cant delete here anything', 10, 1);
return;

delete from AUDITORIUM where AUDITORIUM_NAME = 'À¡- '


--9--
create trigger ddlele on database 
for DDL_DATABASE_LEVEL_EVENTS
as declare @a varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','varchar(50)');
declare @a1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(50)');
declare @a2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(50)');
if @a1 = 'PULPIT'
begin 
print 'Event name: ' +@a;
print 'Object name: ' +@a1;
print 'Object type: ' +@a2;
raiserror(N'U cant make anything with PULPIT table', 16, 1);
rollback;
end;


alter table PULPIT Drop Column PULPIT_NAME;

