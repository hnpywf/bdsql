use Lab4



--1--
      set nocount on
	if  exists (select * from  SYS.OBJECTS       
	            where OBJECT_ID= object_id(N'DBO.test') ) --�������� �� ������� �������	            
	drop table test;           
	declare @c int, @flag char = 'c';   --��� �������� ������ ����� �������� � ���������       
	SET IMPLICIT_TRANSACTIONS  ON  --��������� ������� ����������
	    create table test(K int );  --�������� ������� test                       
		insert test values (1),(2),(3);
		set @c = (select count(*) from test);
		print '���������� ����� � ������� test: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                    
	          else      rollback;                                
      SET IMPLICIT_TRANSACTIONS  OFF   
	if  exists (select * from  SYS.OBJECTS       
	            where OBJECT_ID= object_id(N'DBO.test') )
	print 'table test exists';  else print 'table test not exists'


	--2--
begin try
	 begin tran                 -- ������  ����� ����������
	   delete PROGRESS where IDSTUDENT='1059'; 
	   insert PROGRESS values ('��', 1067,  '2013-01-01', 5);
	   insert PROGRESS values ('��', 1059,  '2014-01-01', 7);
	   commit tran;               -- ��������
	end try
	begin catch
	    print 'Error: '+ case 
          when error_number() = 2627 and patindex('%PK_PROGRESS%', error_message()) > 0
          then '����� ������� ��� ����������!' 
          else 'Unknown error: '+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
	 if @@trancount > 0 rollback tran ; 	  
     end catch;
		

--3--
declare @point varchar(32);    -- ����. ����� ����� 32
begin try
  begin tran                                                             
	delete PROGRESS where IDSTUDENT='1059';  
	set @point = 'p1'; save tran @point;             -- ����������� ����� p1
	 insert PROGRESS values ('��', 1067,  '2013-01-01', 5);
	set @point = 'p2'; save tran @point;             -- ����������� ����� p2
     insert PROGRESS values ('��', 1059,  '2014-01-01', 7);
	commit tran;                                                   
   end try
   begin catch
	print 'Error: '+ case 
          when error_number() = 2627 and patindex('%PK_PROGRESS%', error_message()) > 0
          then '����� ������� ��� ����������!' 
          else 'Unknown error: '+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
   if @@trancount > 0 
	begin
	   print 'Checkpoint: '+ @point;
	   rollback tran @point;                                   -- ����� � ����������� �����
	   commit tran;                  -- �������� ���������, ����������� �� ����������� ����� 
	end;     
   end catch;


--4--

-- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	  select @@SPID [spid], 'insert PROGRESS' 'result', * from PROGRESS 
	  where IDSTUDENT = '1059';
	  select @@SPID [spid], 'update STUDENT'  'result', 
      IDSTUDENT, NAME from STUDENT  
	  where IDSTUDENT = '1059';
	  commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID [spid]
	insert PROGRESS values ('����', 1108, '2015-12-01', 8); 
	update PROGRESS set IDSTUDENT = '1107' 
                           where IDSTUDENT = '1108' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;




	--5--
	-- A ---
      set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from PROGRESS 
	where IDSTUDENT = '1059';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update PROGRESS'  'result', count(*)
	from PROGRESS  where IDSTUDENT = '1059';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update PROGRESS set IDSTUDENT	 = '1108' 
                                       where IDSTUDENT = '1059' 
          commit; 
	-------------------------- t2 --------------------

	
--6--
-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select NOTE from PROGRESS where IDSTUDENT = '1067';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when NOTE = '5' then 'insert  PROGRESS'  else ' ' 
end 'result', NOTE from PROGRESS  where IDSTUDENT = '1067';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert PROGRESS values ('����', 1107,  '01.12.2014',  8);
          commit; 
	-------------------------- t2 --------------------


--7--
use master
go
alter database Lab4 set allow_snapshot_isolation on
use Lab4
-- A ---
      set transaction isolation level SNAPSHOT 
	begin transaction 
	select NOTE from PROGRESS where IDSTUDENT = '1067';
	-------------------------- t1 ------------------ 
delete PROGRESS where IDSTUDENT = '1059';  
          insert PROGRESS values ('��', 1059, '01.12.2014', 6);
          update PROGRESS set NOTE = '9' where IDSTUDENT = '1059';
	-------------------------- t2 -----------------
	select NOTE from PROGRESS  where IDSTUDENT = '1059';
	commit; 
	--- B ---
	waitfor delay '00:00:05';	
	begin transaction 	  
	-------------------------- t1 --------------------
delete PROGRESS where IDSTUDENT = '1059';  
          insert PROGRESS values ('��', 1059, '01.12.2014', 6);
          update PROGRESS set NOTE = '9' where IDSTUDENT = '1059';
          commit; 
	-------------------------- t2 --------------------


--8--
-- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
		delete PROGRESS where IDSTUDENT = '1067';  
          insert PROGRESS values ('����', 1065, '01.12.2014', 5);
          update PROGRESS set NOTE = '6' where IDSTUDENT = '1065';
          select  NOTE from PROGRESS  where IDSTUDENT = '1065';
	-------------------------- t1 -----------------
	select NOTE from PROGRESS where IDSTUDENT = '1065';
	-------------------------- t2 ------------------ 
	commit;
	--- B ---	
	begin transaction 	  
	delete PROGRESS where IDSTUDENT = '1065';  
          insert PROGRESS values ('����', 1075, '08.06.2014', 8);
          update PROGRESS set NOTE = '6' where IDSTUDENT = '1075';
           select  NOTE from PROGRESS  where IDSTUDENT = '1075';
          -------------------------- t1 --------------------
          commit; 
          select  NOTE from PROGRESS  where IDSTUDENT = '1075';


--9--
begin tran                                           --  ������� ����������   
insert PROGRESS values ('����', 1095, '08.06.2014', 8);
begin tran                                          --  ���������� ����������  
update PROGRESS set NOTE = '7' where IDSTUDENT = '1095';
commit;                                             --  ���������� ����������  
if @@trancount > 0  rollback;        -- ������� ���������� 
select   (select count(*) from PROGRESS where NOTE = '7') 'NOTES = 7', 
(select count(*) from PROGRESS  where SUBJECT = '����') 'SUBJECT = ����'; 
