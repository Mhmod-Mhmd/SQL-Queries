--Reduce network traffic 
--improve security -- hide DB objects, metadata and 
--   sql query (hide what is the query doing like insert ,update, delete)
--improve engine of database and networkk
--Take parameter or no 
--handle Error in DML queries by ( try , catch) or (if exist or not )
--Hide Bussiness Rules
--call only by the name 

------------------------------Types SP 
--1- Built in sp 

sp_bindrule 
sp_unbindrule 
sp_bindefault
sp_unbindefault
sp_adduser
sp_helpconstraint   'Student'
sp_helptext 

--2 user defined sp
create procedure GetStd
as
    select * from Student

getstd
execute GetStd

--take paramater
create proc GetstdByAddress @add varchar(20)
as
  select s.St_Id , s.St_Fname , s.St_Address
  from Student s
  where s.St_Address = @add


  GetstdByAddress 'cairo'

  ------------Stored DML
  alter proc InsertStd @id int , @name varchar(30)
  as 
     begin try 

	    insert into Student (St_Id , St_Fname ) values (@id , @name)

	 end try
	 begin catch
	   select 'Dublicat id' as Error_masseage
	 end catch

InsertStd 66 ,'Ahmed'



----
ALter proc SumXY @x int =200 , @y int =100
as
  select @x+@y

SumXY 3 , 7  -- calling by parameter position

SumXY @y =9 , @x=8 -- calling by parameter name 

SumXY 6    -- assingn to the first parameter 



-----
create proc GetStdAges @age1 int , @age2 int 
as
   select St_Id , St_Fname
   from Student
   where St_Age between @age1 and @age2


execute GetStdAges 20 , 25



declare @t table (Id int , Sname varchar(30))
insert into @t
execute GetStdAges 20 , 25
select * from @t



----------Stored with return

create proc GetStdAge @id int 
as 
   declare @age int 

   select @age=s.St_Age
   from Student s
   where s.St_Id = @id 

return @age -- return inside the proceduere return only intgersssss


declare @age int 
execute @age = GetStdAge 5
select @age




create proc GetStdName @id int 
as 
   declare @name varchar(30) 

   select @name=s.St_Fname
   from Student s
   where s.St_Id = @id 

return @name -- error 
go
GetStdName 5

-- if we want to return a values to varubles form S_P we should use output 
alter proc GetStdName @id int , @name varchar(20) output , @age int output 
with encryption
as 
   select @name=s.St_Fname , @age = s.St_Age 
   from Student s
   where s.St_Id = @id 


declare @n varchar(20) , @a int 
execute GetStdName 6 ,  @n output , @a output 
select @n , @a



sp_helptext 'GetStdName'

Alter proc Test1 @SupId int , @id int 
as 
  execute('update Student set [St_super]='+ @SupId +'where st_id ='+ @id)

Test1 1,1



-------------------------------Tigger 
--Can't call
--Can't send paramater
--trigger in tables , and in databaseeeee
-- can write DML queriessss inside it
-- tiggers take the schema name of the table inside it 
-- we can disable or enable rather then drop the trriger


create trigger t1
on student
after insert -- instead of , for ==after
as  
   select 'New student Added'

--test
insert into student (St_Id , St_Fname) values (16 , 'Ali')


--------------------------------------------
create trigger t2
on student
after update
as 
  select getdate()

--test
update Student set St_Age+=1 


-------------------------------
create trigger t3
on student
instead of delete
as 
  select 'Not allowed for user = '+SUSER_NAME()

delete from Student  where St_Id=16

select * from Student


create schema HR1 
Alter schema HR1 transfer department
----------------
ALter trigger Hr.t4
on Hr.[Department]
instead of insert , update
as
	    select 'insert  only allowd'

 update Hr.Department 
    set Dept_Name='Cloud' 
	where Dept_Id = 70

create schema HR 
go 
alter schema HR transfer Department


alter trigger HR.t5
on HR.[Department]
for insert
as
  select 'Hola'

  insert into HR.department values (80 , 'orcal' , 'Data Base', 'benisuaf' )

  select * from HR.department

create trigger t6
on Student 
after update
 as 
   if UPDATE(St_fname)
      select 'hi'

update Student set St_Fname ='test' where St_Id=16

Alter table student disable trigger t6
Alter table student enable trigger t6


----------------------------------------------------------------------------------

-- inserted table -- restore new added values 
-- deleted table -- restore last deleted values

delete -->table deleted contains deleted date 
       --> table inserted empty

insert --> table inserted contains insered data 
       --> deleted Empty

update -->inserted contian Updated data
       --> deleted contains data befor update



create trigger t7
on course
after insert 
as 
  select [Crs_Name] from inserted
  select * from deleted


  insert into Course( [Crs_Id],[Crs_Name]) values (1250 , 'Test')



  ---------------------------------------------------------------------------
select * from course
go
alter trigger t8
on course
after delete
as 
	if (format(getdate() , 'dddd')='wednesday')
		begin 
			select 'not allowed to delete today'
			insert into Course
			select * from deleted
		end 
go
delete from Course where Crs_Id =1200
go
select * from Course




alter trigger tt8
on course
after delete
as 
	while(format(getdate() , 'dddd')='sunday')
		begin 
			select 'not allowed to delete today'
			rollback
		end 
---------------------------------------Audit Tables----------------
create table history
(
name varchar(50) ,
date date ,
OldId int ,
_NewId int
)

Alter trigger t9
on Topic
after update 
as 
   if update(Top_id)
      begin
	        declare @old int , @new int
			select @new =Top_id from inserted
			select @old =Top_id from deleted
		    insert into history 
			values( SUSER_NAME() , getdate() ,@old , @new)

	  end

update Topic set Top_Id =446 where Top_Id=7

select * from history


----Runtime trigger 



delete from [Departments]
output getdate() , deleted.Dname 
where Dnum =40


update Departments
set Dname = 'Dtest'
output SUSER_NAME() , inserted.Dname , deleted.Dname
where Dnum=50


insert into Departments(Dnum , Dname) 
output 'welcome'
values(60 , 'jhdgcjhcb')

-------
drop trigger t2





create trigger t15
on database 
after drop_table
as
 select 'not allowed'
 rollback


 create table e (id int)

 drop table e



 ------------------- lab 4 
 select * from Department
 ---- 1 
 create proc studentcount 
 as 
	select d.dept_name , count(st_id)
	from Department d inner join Student s
	on d.dept_id = s.Dept_Id
	group by d.dept_name

studentcount

----- 3
alter trigger tt1
on department 
instead of insert 
as 
	select ' this ' +SUSER_NAME()+'  cant insert into this table '

--test 
insert into Department (dept_id , dept_name) 
values ( 80 , 'BI')

------4
use Company_SD
go
create proc proemp --@pro_id int
as
     if (select count(ssn) 
		from Employee e inner join Works_for d
		on d.ESSn = e.SSN
		inner join Project p
		on d.Pno = p.Pnumber
		where Pnumber = 100 ) >= 1
		select 'The Employees r working in this project is equal or more than three '
	else 
		select e.fname , e.lname 'The following Employees work for poject 100 ' 
		from Employee e

ALter proc proemp @pro_id int
as
		declare @co int , @pnum int = @pro_id
        select @co = count(ESSn)  
		from Works_for 
		where Pno = @pnum
		if @co > = 3
		select 'The Employees r working in the project is equal or more than three '
	else 
		select e.fname +' ' +e.lname as full_name , 'The following Employees work for poject '
		from Employee e	inner join Works_for w
		on w.ESSn = e.SSN
		where w.Pno = @pnum

proemp 200
proemp 300

select * from Project
select * from Employee 

--- 6 

Alter proc newemp @old_ssn int, @new_ssn int, @pro_name int
as
	insert into Employee (SSN) values (@new_ssn)
	if exists ( select * from Works_for where ESSn = @old_ssn ) 
	      update Works_for set ESSn=@new_ssn , Pno=@pro_name 
		  where ESSn = @old_ssn
	else 
		select 'This employee not exist'

newemp 223344, 877451 , 100 -- error
go
select * from Works_for

------7 

create trigger th1
on 





---------8 

Alter trigger t8
on employee
instead of insert
as
	if(format(getdate(),'MMMM') = 'october')
		begin
			select ' The insertion is stopped thid month'
		end

insert into Employee(SSN) values (555888)

select format(getdate(),'MMMM')
----------
Alter trigger t8
on employee
instead of delete
as
	if(format(getdate(),'MMMM') = 'october')
		begin
			select ' The insertion is stopped thid month'
			insert into Employee
			select * from deleted
		
		end
go
delete from employee where SSN = 555882
----------
Alter trigger t8
on employee
for update
as
	if(format(getdate(),'MMMM') = 'october')
		begin
			select ' The insertion is stopped thid month' 
		
			
		end

update Employee set ssn = 555882 where SSN =555888
