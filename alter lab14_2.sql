USE [Lab4]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 16.05.2018 16:52:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PSUBJECT] --sozdanie proceduri
@p varchar(20),
@cc int output
as begin 
declare @c int = (select COUNT(*) from SUBJECT);
print 'Parametres: p='+@p+', c= '+cast(@cc as varchar(3));
select*from SUBJECT where PULPIT=@p;
set @cc = @@ROWCOUNT;  
return @c;
end;
GO


