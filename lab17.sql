use Lab4


--1--
select TEACHER_NAME, GENDER, PULPIT
from TEACHER 
where PULPIT = '����' for xml RAW, root('Teachers'), elements;


--2--
select AUDITORIUM_NAME, AUDITORIUM_TYPENAME, AUDITORIUM_CAPACITY 
from AUDITORIUM join AUDITORIUM_TYPE 
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = '��'
order by AUDITORIUM_TYPENAME for xml AUTO,
root('AUDITORIUMS'), elements; 


--3--
declare @k int = 0,
@x varchar(2000)= '<?xml version="1.0" encoding="windows-1251" ?> 
<SUBJECT>
<SUBJECT="DESIGNE" SUBJECT_NAME= "DESIGNEDODDA" PULPIT="����"/>
<SUBJECT="OLESHKA" SUBJECT_NAME= "RANDOMNOIE" PULPIT="����"/>
<SUBJECT="DE" SUBJECT_NAME= "DEDAVSHINAEST" PULPIT="����"/>
</SUBJECT>';
exec sp_xml_preparedocument @k output, @x;
select * from openxml(@k, '/SSUBJECT/SUBJECT',0)
with([subject] char(10), [subject_name] varchar(100), [pulpit] char(20))

/*insert SUBJECT select [subject], [subject_name], [pulpit]
from openxml(@k, '/SUBJECT/SUBJECT', 0)
with ([subject] char(10), [subject_name] varchar(100), [pulpit] char(20))*/
exec sp_xml_removedocument @k;


--4--
create table Student_xml
 (
 Name nvarchar(100),
 PASSPORT xml
 );


 insert into Student_xml(Name, PASSPORT)
values('���� �������� �����', '<pass><Ser>MP</Ser><Num>8867477</Num>
<dv>26.05.12</dv><adr>Minsk, Lobanka 64</adr></pass>');

 insert into Student_xml(Name, PASSPORT)
values('��� ����� ����', '<pass><Ser>��</Ser><Num>8442477</Num>
<dv>12.12.16</dv><adr>Minsk, Td 2</adr></pass>');

update Student_xml set PASSPORT = '<pass><Ser>��</Ser><Num>9999999</Num>
<dv>12.12.16</dv><adr>Minsk, Td 2</adr></pass>'	
where PASSPORT.value('(/pass/Num)[1]', 'varchar(10)')=8442477;


select Name [���], 
PASSPORT.value('(/pass/Ser)[1]', 'varchar(2)') [�����],
PASSPORT.value('(/pass/Num)[1]', 'varchar(7)') [�����],
PASSPORT.query('/pass') [�������]
from Student_xml;

--5--
create xml schema collection STUDENT2 as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="�������">
<xs:complexType><xs:sequence>
<xs:element name="�������" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="�����" type="xs:string" use="required" />
    <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="����"  use="required"  >
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
<xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';





create table STUDENTishka 
( IDSTUDENT integer  identity(1000,1) 
		  primary key,
   IDGROUP integer,       
  NAME nvarchar(100), 
  BDAY  date,
  STAMP timestamp,
  INFO     xml(STUDENT2),    -- �������������� ������� XML-����
  FOTO   varbinary
  );
  SET IDENTITY_INSERT STUDENTishka ON

  insert into STUDENTishka(IDSTUDENT, IDGROUP, NAME, BDAY, INFO)
  values ('1001', '4', 'Just A Random Name', '22.12.2012', 
  '<�������><������� �����="��" �����="2877362" ����="12.12.2012"/>
  <�������>3212213</�������><�����><������>��������</������><�����>�����</�����>
  <�����>�������������</�����><���>45</���>
  <��������>112</��������></�����></�������>')


  select*from STUDENTishka