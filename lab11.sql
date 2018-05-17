use Lab4 

--1--
exec SP_HELPINDEX 'AUDITORIUM' 
exec SP_HELPINDEX 'AUDITORIUM_TYPE' 
exec SP_HELPINDEX 'FACULTY' 
exec SP_HELPINDEX 'GROUPS'
exec SP_HELPINDEX 'PROFESSION'  
exec SP_HELPINDEX 'PULPIT'
exec SP_HELPINDEX 'STUDENT' 
exec SP_HELPINDEX 'SUBJECT'  
exec SP_HELPINDEX 'TEACHER' 


--2--
use Lab4
drop table #ROFLe
CREATE table #ROFLe
 (   TIND int,  TFIELD varchar(100) );
SET nocount on; 
DECLARE @i int=0; 
WHILE @i<1000
  begin 
  INSERT #ROFLe(TIND, TFIELD) 
               values(floor(20000*RAND()), REPLICATE('������', 10));
  IF(@i % 100=0) print @i;     --������� ���������
  SET @i=@i+1;
  end;
  go

SELECT * from #ROFLe WHERE TIND between 1500 and 2500 ORDER BY TIND 

checkpoint;
DBCC DROPCLEANBUFFERS;

CREATE clustered index #ROFLe_llel on #ROFLe(TIND asc)


--3--
CREATE table #exex
  ( TKEY int, CC int identity(1,1),TF varchar(100));

  set nocount on;           
  declare @i int = 0;
  while   @i < 15000       
  begin
  INSERT #exex(TKEY, TF) values(floor(30000*RAND()), replicate('��� ', 10));
  set @i = @i+1; 
  end;
  go
  SELECT count(*)[���������� �����] from #exex;
  SELECT * from #exex

  CREATE index #exex_NONCLU on #exex(TKEY, CC) --

  SELECT * from  #exex where  TKEY > 1500 and  CC < 4500; --������� �� �������������������� ������
  SELECT * from  #exex order by  TKEY, CC --����� ������� �� ����������� ��� ���������� ��� ����������

  SELECT * from  #exex where  TKEY = 556 and  CC > 3 --����� ������ ���� ��������, ����� �����������
                                                     --�������� ���������, �������������������� ������

--4--
CREATE  index #exex_TKEY_X on #exex(TKEY) INCLUDE (CC)
SELECT CC from #exex where TKEY>15000

--5--
SELECT TKEY from  #exex where TKEY between 5000 and 19999; --�������� ���� �������, �� �������, �������
SELECT TKEY from  #exex where TKEY > 15000 and  TKEY < 20000  
SELECT TKEY from  #exex where TKEY=17000


CREATE  index #exex_WHERE on #exex(TKEY) where (TKEY>=15000 and TKEY < 20000);  --������, ��� 2, �� �������
                                                                                --�������, �� ���� �������

--6--
CREATE   index #exex_TKEY on #exex(TKEY); 


SELECT name [������], avg_fragmentation_in_percent [������������ (%)]
  FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
  OBJECT_ID(N'#exex'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                 where name is not null;
 INSERT top(10000) #exex(TKEY, TF) select TKEY, TF from #exex;

 ALTER index #exex_TKEY on #exex reorganize;
 ALTER index #exex_TKEY on #exex rebuild with (online = off);

--7--
DROP index #exex_TKEY on #exex;
    CREATE index #exex_TKEY on #exex(TKEY) with (fillfactor = 66);
    INSERT top(50)percent into #exex(TKEY, TF) select TKEY, TF  from #exex;
SELECT name [������], avg_fragmentation_in_percent [������������ (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#exex'), NULL, NULL, NULL) ss
       JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
 where name is not null;


 --9--
 create view [����������������������]
 as select FACULTY.FACULTY_NAME [���������],
 (select COUNT(*)from PULPIT where FACULTY.FACULTY = PULPIT.FACULTY ) [���������� ������]
 from FACULTY join PULPIT 
 on FACULTY.FACULTY = PULPIT.FACULTY

 