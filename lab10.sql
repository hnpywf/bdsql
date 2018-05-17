use Lab4

--1--
declare 
@c char = 'char',
@a varchar(7) = 'varchar',
@d datetime,
@t time,
@i int,
@si smallint,
@ti tinyint,
@n numeric(12, 5);
set @d = getdate()
set @t = current_timestamp
set @si = (select NOTE from PROGRESS where IDSTUDENT = '1000')
set @ti = (select NOTE from PROGRESS where IDSTUDENT = '1001')
print 'today is a ' +cast(@d as varchar(11));
print 'and current time is a ' +cast(@t as varchar(8));
print '1selected note is a ' +cast(@si as varchar(1));
print '2selected note is a ' +cast(@ti as varchar(1));
select @c
select @a



--2--
declare @one int = (select cast(sum(AUDITORIUM_CAPACITY) 
as int) from AUDITORIUM), @two real, @tre real, @four real, @five real
if @one > 200 
begin 
select @two = (select cast(count(*) as int) from AUDITORIUM),
@tre = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM)
set @four = (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @tre)
set @five = (select 100.0*@four/@two)
select @one 'Общая вместимость', @two 'Количество аудиторий', @tre 'Ср. вместимость', 
@four 'Кол-во аудиторий < avg', @five '%, аудиторий < avg'  
end
else 
print 'Обащая вместимость меньше 200 и равна ' + cast(@one as varchar(10))


--3--
print 'Количество обработанных строк: ' + cast(@@ROWCOUNT as varchar(12))
print 'Версия: ' + cast(@@VERSION as varchar(790))
print 'Системный идентификатор: ' + cast(@@SPID as varchar(12))
print 'Код последней ошибки: ' + cast(@@ERROR as varchar(12))
print 'Имя сервера: ' + cast(@@SERVERNAME as varchar(25))
print 'Уровень вложенности транзакции: ' + cast(@@TRANCOUNT as varchar(12))
print 'Считывание строк результирующего набора: ' + cast(@@FETCH_STATUS as varchar(12))
print 'Уровень вложенности текущей процедуры: ' + cast(@@NESTLEVEL as varchar(12))

--4--
   
   --schet--
   declare @z float, @tt int = 2, @x int
   --set @x = 3
   --set @x = 1
   set @x = 2
   if (@tt>@x) set @z=power((sin(@tt)), 2)
   if (@tt<@x) set @z=4*(@tt+@x)
   if (@tt=@x) set @z=1-exp(@x-2)
   print @z 


   --fio--
   use Lab4
   declare @name nvarchar(128)
   set @name = 'Кривонос Антон Генадьевич'
   select PARSENAME(replace(@name, ' ','.'), 3)+' '+
   left(parsename(replace(@name,' ','.'),2),1)+'. '+
   left(parsename(replace(@name,' ','.'),1),1)+'.' 

--5--
defoltniy if...else, net smisla chto-to pisat

--6--
toje samoe chto i v 5, tolko case

--7--
drop table #EXPLRE
CREATE table  #EXPLRE
 (   TIND int,  
  TFIELD varchar(100) );


  SET nocount on;      
DECLARE @ii int=0; 
WHILE @ii<45
  begin 
  INSERT #EXPLRE(TIND, TFIELD) 
               values(floor(365*rand()), replicate('строка', 10));
  IF(@ii % 5=0) 
  print @ii;    
  SET @ii=@ii+1;
  end;

  --8--
  declare @mda int = 5 
  print @mda + 2 
  print @mda - 8
  RETURN
  print @mda + 'AHAHH'

  --9--
  begin TRY
update dbo.PROGRESS set NOTE = '5' where NOTE = '1'
end try
begin CATCH
print ERROR_NUMBER()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch

--10--
drop table #Timed
declare @point int = 5
create table #Timed (point int, date datetime)
while @point < 25
begin 
waitfor delay '00:00:00.500'
set @point= @point+5;
insert #Timed(point, date) values (@point, SYSDATETIME())
end;
select * from #Timed

--11--
drop table ##Timed
declare @point2 int = 5
create table ##Timed (point int, date datetime)
while @point2 < 25
begin 
waitfor delay '00:00:00.500'
set @point2= @point2+5;
insert ##Timed(point, date) values (@point2, SYSDATETIME())
end;
select * from ##Timed
