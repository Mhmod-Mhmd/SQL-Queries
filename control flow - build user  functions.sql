create table exam
(
id int, 
ques varchar(30)
)

--Local tables --session table 
create table #exam
(
id int, 
ques varchar(30)
)

insert into #exam values(1 , 'tttt')
select * from #exam

--global tables 
create table ##exam
(
id int, 
ques varchar(30)
)
insert into ##exam values(1 , 'tttt')
select * from ##exam
use iti
go 
select * from ##exam
 
 select * from sys.

-----Order by

select s.St_Id , s.St_Fname , s.St_Lname
from Student s
order by 3

------Top 
select top(3) Salary
from Instructor
order by Salary desc

--
select top 10 percent s.St_Age
from Student s
order by s.St_Age desc

----------
declare @t int = 50
select @t =50000
select @t

declare @d date
select @d ='11/2/1998'
select @d

declare @d date = '11/2/1998'
select @d = GETDATE()
select @d

declare @t int = 50
set @t =88
select @t

declare @age int = (select AVG(s.St_Age) from Student s)
select @age

declare @age int 
select @age = (select max(s.St_Age) from Student s)
-- or set @age = (select max(s.St_Age) from Student s)
select @age


declare @age int = (select s.St_Age from Student s where St_id =4)

select @age as 'jjjjj'

select s.St_Age from Student s where St_Address ='alex'


decLARE @id int =( select s.St_Id from Student s where s.St_Id =2) , 
        @name varchar(20) =( select s.St_Fname from Student s where s.St_Id =2)
select @id , @name


decLARE @id int ,@name varchar(20)
select @id= s.St_Id , @name =s.St_Fname
from Student s
where s.St_Id =2
select @id , @name 


declare @name varchar(20) ='Mohamed', @id int =7  , @dept int
update Student
set St_Fname = @name , @dept = Dept_id
where St_Id = @id
select @dept as 'Dept'


---table var
declare @t table (col1 int , col2 varchar(20))

insert into @t
select s.St_Id , s.St_Fname
from Student s

select * from @t

declare @T int = 6
select top(@T) *
from Instructor 
order by Salary desc 

------------dynamic Query

declare @x varchar(30) ='[Ins_Degree]' , @y varchar(50) = '[dbo].[Instructor]'
execute ('select '+@x+' from '+@y+' where [Ins_Id] = 1' )



-----------------------------Globle var----------------------
select @@SERVERNAME
select @@VERSION

update Student 
set St_Age+=1
select @@ROWCOUNT


select * from rtjgi
go
select @@ERROR 

create table t444
(
id int identity (1 , 4),
name varchar(10)
)
insert into t444 values('DDDD')
select * from t444
select @@IDENTITY

-------------------------------Contarl flow ---------------------------
--if , else 
--begin end
--if exists , if not exists
--while , continue , break 
--case
--iif
--waitfor delay time
--add delay ( delay in the time of excution )
select getdate() ' before delay'
waitfor delay '00:00:15.000'
select getdate() ' After Delay '

--add a specific time for excuation based on the server time 
select getdate() ' before delay'
waitfor time '21:22:00.000'
select getdate() ' After Delay '
 
--Choose 
--function return an item from the list based on the index of list 
use AdventureWorks2019
go 
select SalesOrderID , month(orderdate) as month, 
choose(month(orderdate) , 
       'winter' ,'winter' , 
	   'spring' ,'spring' ,'spring' ,
	   'summer' ,'summer' ,'summer' , 
	   'Autumn' ,'Autumn' ,'Autumn' ,
	   'winter') as Season
from Sales.SalesOrderHeader
order by orderdate
------------------------IF , else-----------------------------
declare @r varchar(20) 
update Student
set St_Age+=1
where St_Address ='alex'

select @r= @@ROWCOUNT

if @r > 0 
     print @r+' rows affected'

else
    begin 
	  print ' No rows affected'
	end 
-------------------------------------------------------------
if exists (select * from sys.tables where name = 'rdgxrtg')
    select 'Table exicted'
else
 create table rdgxrtg(id int)
 
 if not exists (select dept_id from student where dept_id =30) 
	and not exists (select dept_id from Instructor where dept_id = 30)
	delete from department where dept_id = 30
else 
	select 'this table has a relation'

 begin try
	delete  from department where dept_id = 30
end try
begin catch
	select 'this table has a relationship'
end catch

 -----While 

 declare @x int = 10 
 while @x <20 
     begin
	      set @x+=1 
		  if(@x =14)
		    continue
          if(@x = 16)
		    break
		  select @x  --11 , 12 , 13 , 15
	 end 

----Case--
case
   when con1 then Res
   when con2 then 
   else  res
end


declare @id int = 2 , @age int

select @age=s.St_Age 
from Student s
where St_Id = @id

select case 
           when @age >20 and @age <=28 then 'you can apply'
		   when @age >20 then 'Sorry you can not apply'
           else 'not allowed'
       end


----iif(condition , value if condition true , 'value id cond false)

select s.St_Id , s.St_Fname,s.St_Age , iif(s.St_Age >=30 , 'not allowed' , 'allowed') as allowness
from Student s 
-----------------------
select s.St_Fname , isnull(s.St_Lname , s.St_Address)
from Student s

select s.St_Fname , Coalesce(s.St_Lname , s.St_Address , 'No Data')
from Student s

select nullif('v' , 'tjhvjh')

select len(s.St_Fname )
from Student s

select top(1) st_fname 
from student 
order by len(St_Fname) desc

select power(Salary, 2)
from Instructor


select convert( varchar(20) , getdate() , 108)

select format(getdate() , 'dddd/MMMM:yyyy')

---------------------------------------Functionssssssssssss------------
--scalar function ---> return one single value
--inline table function ---> simple Query and return table
--multi statment table function ---> multiple statments/ complex qurery and return table

----------------------Scalar-----------------
--String GetStudentName (int id){} ----> c#

create function GetStudentName (@id int )
returns varchar(50)
	begin 
		declare @name varchar(50)
		select @name =s.St_Fname
		from Student s
		where s.St_Id = @id
		return @name
	end

select dbo.GetStudentName(5) as student_name


create function getstudentaddress (@st_name varchar(20))
returns varchar(20)
begin 
	declare @add varchar(20) 

	select @add = St_Address 
	from student
	where st_fname = @st_name

	return @add
End

select dbo.getstudentaddress('Ahmed') as Student_Address

------------------------------inline Function----------
--function take dept_id retrun ins_name , annualSalary

create function GetInsInf (@did int)
returns table  
as
return 
		( select i.Ins_Name , i.Salary * 12 as annSalary
		   from Instructor i
		   where i.Dept_Id = @did
		)

select * from GetInsInf(10)
select ins_name from GetInsInf(10)
select sum(annSalary) from GetInsInf(10)


-----------------Multistatment-----------
--table GetStudentData (@fromat varchar(20))

create function GetStudentsData(@format varchar(20))
returns @tab table (id int , ename varchar(50))
as
  begin
       if(@format='first')
			insert into @tab
			select s.St_Id , s.St_Fname
			from Student s
       else if (@format='last')
	        insert into @tab
			select s.St_Id , s.St_Lname
			from Student s
       else if (@format='full')
	        insert into @tab
			select s.St_Id ,s.St_Fname+' '+s.St_Lname
			from Student s
	
   return 
  end

select * from dbo.GetStudentsData('last')


create function newfunc(@format varchar(20))
returns @tab table (id int , ename varchar(50))
as
  begin
       if(@format='first')
			insert into @tab
			select s.St_Id , s.St_Fname
			from Student s
       else if (@format='last')
	        insert into @tab
			select s.St_Id , s.St_Lname
			from Student s
       else if (@format='full')
	        insert into @tab
			select s.St_Id ,s.St_Fname+' '+s.St_Lname
			from Student s
	   else insert into @tab
			select 1 , 'no data'
   return 
  end

select * from dbo.newfunc('good')




------------------------lab ------------------

-------> 1

create function getmonth(@date date)
returns int 
begin 
		declare @month int
		select @month= month(@date) 

		return @month
end

select dbo.getmonth('2022-10-11')
select dbo.getmonth( getdate())

--------> 2

--create function getvalue(@num1 int , @num2 int ) 
--returns @t table ( num int )
--as 
--begin
--	 while (@num1<@num2) 
--		begin   
--		    @num1 = @num1+1
--			if (@num1=@num2)
--				break
--			insert int @t 
--			select  @num1
--		end 
--end	

----> 3

create function getstudent(@St_id int )
returns @tab table ( fullname varchar(20), department_id int ) 
as 
begin
	insert into @tab 
	select st_fname+' '+st_lname , dept_id 
	from student
	where st_id = @St_id 
	return
end 

select * from getstudent(9)

drop function getstudent

------>4 

create function checkstudent(@id int)
returns varchar(50)
begin 
	 declare @mess varchar(50)
	    if exists ( select s.st_fname from student s 
					where s.st_id = @id and s.st_fname is null and s.st_lname is null)
		            select @mess = 'First name & Last name are null'
		else if exists( select s.st_fname from student s 
					where s.st_id = @id and s.st_fname is null )
		            select @mess = 'First name is null'
		else if exists( select s.st_fname from student s 
					where s.st_id = @id and s.st_lname is null )
					select @mess = 'last name is null'
		else
					select @mess = 'First and Last name are not null'
		
	return @mess
end   

select dbo.checkstudent(11)

drop function checkstudent
    
-------> 5
create function getmanager(@format int)
returns @t table ( department_name varchar(20), manager_name varchar(20), hire_date date)
as 
begin
	insert into @t
	select dept_name , dept_manager , manager_hiredate
	from department
	where manager_hiredate = convert (date, (convert(datetime , @format)))
	return
end
 drop function getmanager
select * from dbo.getmanager(37529)
select convert (date, (convert(datetime , 36524)))
 select convert( int , convert(datetime , manager_hiredate)) new from Department

 ----> 6 

create function getname(@n varchar(20))
returns @t table ( Name varchar(50) )
as 
begin
     if @n = 'fullname'
		insert into @t 
		select isnull(st_fname+' '+st_lname , ' ' )
		from student
	else if @n = 'firstname'
		insert into @t 
		select isnull(st_fname , 'no first name')
		from student 
	else if @n = 'lastname'
		insert into @t 
		select isnull(st_lname , 'no last name')
		from student
	else insert into @t 
		 select 'enter right option'
	return

end

select * from getname('firstname')

drop function getname

------>7 

select st_id as student_no , substring(st_fname, 1 , len(st_fname)-1) as firstname 
from student 

-------8 
--Msg 4104, Level 16, State 1, Line 498
--The multi-part identifier "sys.all_columns" could not be bound.
