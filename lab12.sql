use Lab4
--1--
declare @a1 char(20), @t char(300)='';
declare Zad1 cursor for select SUBJECT from SUBJECT where PULPIT like 'ИСиТ';
open Zad1;
fetch Zad1 into @a1;
print 'субжектs';
while @@FETCH_STATUS = 0
begin 
set @t = rtrim(@a1)+', '+@t;
fetch Zad1 into @a1;
end;
print @t; 
close Zad1;

--2--
   --local-- 
    DECLARE Notes CURSOR LOCAL                            
	for select SUBJECT, NOTE from PROGRESS;
    DECLARE @nt char(20), @note real;      
	OPEN Notes;	  
	fetch  Notes into @nt, @note; 	
      print '1. '+@nt+cast(@note as varchar(6));   
      go


	  --test-- (cursor yje ne sushestvuet)
	  DECLARE @nt char(20), @note real;     	
	  fetch  Notes into @nt, @note; 	
      print '2. '+@nt+cast(@note as varchar(6));  
      go    

   --global--
    DECLARE Notes CURSOR GLOBAL                            
	for select SUBJECT, NOTE from PROGRESS;
    DECLARE @nt char(20), @note real;      
	OPEN Notes;	  
	fetch  Notes into @nt, @note; 	
      print '1. '+@nt+cast(@note as varchar(6));   
      go


	  --test--
	  DECLARE @nt char(20), @note real;     	
	  fetch Notes into @nt, @note; 	
      print '2. '+@nt+cast(@note as varchar(6));  
      close Notes;
          deallocate Notes;


--3--
--static--
declare @tid char(10), @tnm char(40), @tgn char(1);  
	declare LS CURSOR LOCAL STATIC                              
		 for select SUBJECT, SUBJECT_NAME, PULPIT 
		 from SUBJECT where PULPIT = 'ИСиТ';				   
	open LS;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 



          --changes--
		  insert SUBJECT(SUBJECT, SUBJECT_NAME, PULPIT) 
	           values ('j4f','just for fun', 'ИСиТ'); 

		--check--
		fetch  LS into @tid, @tnm, @tgn;     
	while @@fetch_status = 0                                    
    begin 
       print @tid + ' '+ @tnm + ' '+ @tgn;      
       fetch LS into @tid, @tnm, @tgn; 
    end;          
    close  LS;

--dynamic--
declare @tid1 char(10), @tnm1 char(40), @tgn1 char(1);  
	declare LS CURSOR LOCAL DYNAMIC                              
		 for select SUBJECT, SUBJECT_NAME, PULPIT 
		 from SUBJECT where PULPIT = 'ИСиТ';				   
	open LS;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); --vsegda -1 dlya dynamic cursora



          --changes--
		  insert SUBJECT(SUBJECT, SUBJECT_NAME, PULPIT) 
	           values ('imho','in my horible opinion', 'ИСиТ'); 

		--check--
		fetch  LS into @tid1, @tnm1, @tgn1;     
	while @@fetch_status = 0                                    
    begin 
       print @tid1 + ' '+ @tnm1 + ' '+ @tgn1;      
       fetch LS into @tid1, @tnm1, @tgn1; 
    end;          
    close  LS;



--4--
declare  @tc int, @rn char(50);  
         declare kyky cursor local dynamic SCROLL                               
               for select row_number() over (order by SUBJECT) N,
	     SUBJECT from SUBJECT where PULPIT = 'ИСиТ' 
	open kyky;
	fetch ABSolUTE 5 from kyky into  @tc, @rn;                 
	print 'пятая строка        : ' + cast(@tc as varchar(3))+ rtrim(@rn);      
	fetch  LAST from  kyky into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+ rtrim(@rn);      
      close kyky;


--5--
declare @tn char(20), @tc1 real, @tk int;   
    declare keke cursor local dynamic  
	for select SUBJECT,IDSTUDENT, NOTE
	     from PROGRESS FOR UPDATE; 
     open keke;  
     fetch  keke into @tn, @tc1, @tk;  
     delete PROGRESS where NOTE < 5;	
     fetch  keke into @tn, @tc1, @tk; 
     update PROGRESS set NOTE = NOTE+1 where CURRENT OF keke;
     close keke;
