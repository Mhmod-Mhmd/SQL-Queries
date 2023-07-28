use iti 
go 
 

------- indexs
-- non clustered index ----> in any column in the table 
-- clustered index ----> in primary key column by default
--				   ----> only one clustered index in the table
				   ----> if the table without primary key and clusterd index so 
--							we can create clustered index at any column
-- uniqe index ---> the column should be uniqe constrain also 
-- primary key constrain ---> clustered index
-- unique constrain ---> unique index ( non clustered index)

select * from student

-- non clustered index
create index fnx on student(ST_fname)
create nonclustered index lnx on student(ST_lname)

-- clustered index
create clustered index agex on student(st_age) -- Error cuz st_age not primary key 
 
-- unique index
create table testt(
id int primary key,
name nvarchar(20) unique 
)

create unique index newinx on testt(name)

drop index fnx on student

--- sql server profiler
--- sql server tuning advisor 




-------- temperaly columns at temp DB
-- how we can use temperaly tablessssssssssss
-- local table 'session' -- can exsit many local tables 
--    by same name cuz every name take a differt id

create table #exam
( exam_id int ,
  exam_name nvarchar(20),
  exam_time int 
)
-- globle table  'shared table'

create table ##meet
( exam_id int ,
  exam_name nvarchar(20),
  exam_time int 
)


----------- roll up , cube , pivot , group set--------------------

use iti 
go 

create table test 
(
  product_id int,
  emp_name varchar(50) ,
  quentity int   
)

insert into test values
(1,'ahmed',250) , (1,'ali',20) , (1,'omer',60) , 
(2,'ahmed',100) , (2,'ali',40) , (2,'omer',90) , 
(3,'ahmed',20) , (3,'ali',80) , (3,'omer',80) ,
(4,'ahmed',60) , (4,'ali',90) , (4,'omer',30) 

select product_id  , sum(quentity)
from test
group by product_id 
union all 
select 0 , sum(quentity) 
from test 

select product_id  , emp_name, sum(quentity) 
from test
group by  product_id, emp_name

select product_id  , emp_name, sum(quentity) 
from test
group by rollup( product_id, emp_name)

select  emp_name,product_id  , sum(quentity) 
from test
group by cube( product_id ,emp_name )

select  emp_name,product_id  , sum(quentity) 
from test
group by grouping sets( emp_name, product_id )


--------------pivot table and unpivot table

select * 
from test
pivot (sum(quentity) for emp_name in ([ahmed], [omer] , [ali])) as pvt


------------- viewwwww
-- more secure -- hide data base objects and structrue of it 
-- has no paramater 
-- no DML in view
-- can do insert or update or delet but by a specific conditions 
-- in partitioned view we can't insert or delete cuz exsit two tables
-- standard view is a vitual table
create view fistview 
as 
	select * from student 

select *from fistview 

create view vcairo 
as
	select st_fname , st_lname , st_address 
	from student 
	where st_address = 'cairo'
	with check

	select * from vcairo

-- partitoined view 
--   view catch data from multible tables 

create view vjoin1
as
	select st_fname , st_age , dept_name ,d.dept_id
	from Student s inner join Department d
	on  d.dept_id = s.dept_id

select * from vjoin1

Alter view vjoin 
as 
	select st_fname, St_Address from student 
	where St_Address = 'cairo'
	union all
	select st_fname, St_Address from student 
	where St_Address = 'alex'

select * from vjoin

---- index view 
-- this type only improve performance 
-- has a pysical data 
-- use scema name befor database 
-- write 'with shemabinding' after create statement 

--- this stored procedure bring code of the creation
sp_helptext 'vjoin'
-- to encyrpt the code we can add ' with encyrption '
Alter view vjoin 
with encryption 
as 
	select st_fname, St_Address from student 
	where St_Address = 'cairo'
	union all
	select st_fname, St_Address from student 
	where St_Address = 'alex'





	----------------------- labb 2222222222
--1 
alter view vstud 
as 
	select st_fname+' '+st_lname as fullname  , crs_name , sc.Grade
	from student s inner join Stud_Course sc
	on s.st_id = sc.St_Id 
	inner join Course c
	on c.Crs_Id = sc.Crs_Id
	where sc.grade > 50 
	-- order by crs_name , sc.Grade -- is invalid in view 
go
select * from vstud

------- 2

Alter view managercourse 
with encryption
as 
	select distinct dept_manager , Crs_Name
	from department d inner join Instructor i
	on i.Ins_Id = d.Dept_Manager
	inner join Ins_Course 
	on i.Ins_Id=Ins_Course.Ins_Id
	inner join Course
	on course.Crs_Id = Ins_Course.Crs_Id

go 
select * from managercourse 

------------3 
create view deptcourse
with schemabinding 
as 
	select ins_name , dept_name 
	from dbo.Instructor i inner join dbo.department d 
	on i.Ins_Id=d.Dept_Manager
	where dept_name in ('SD' , 'java')

select * from deptcourse
Alter table instructor alter column ins_name varchar(30) 
-- can't alter column and exist in view but we can alter any table not exist in view
Alter view deptcourse alter column ins_name varchar(30) 
--the above sql statment is wrong cuz inside view only select query

------ 4 
alter view v1
as	
	select st_id, St_Address from student
	where St_Address = 'cairo' or St_Address='alex'
	with check option

select * from v1
update v1 set St_Address = 'cairo' where st_id = 4 

insert into v1(st_id ,St_Address) values (16, 'tanta') 
-- we can't add any value differnt 'cairo or alex' cuz we use check 


-------- 5
create table #test2 
(
	emp_name varchar(50),
	task varchar(100)
)

------------------------------- 
----------1 
use Company_SD
go
create view v1 
as 
	select pname as project_name , count(ssn) as num_employees
	from Project p inner join Departments d
	on p.Dnum = d.Dnum 
	inner join Employee e
	on d.Dnum = e.Dno 
	group by Pname

select * from v1

----------- 2
alter view v_count 
as 
	select pname as project_name , sum(wf.Hours) as project_hours
	from project p inner join works_for wf
	on p.Pnumber = wf.Pno
	group by pname
go
select * from v_count

-------- 3 
alter view V_D3
as 
	select pnumber , Dname , sum(hours) as houres																										
	from Works_for inner join Project
	on Works_for.Pno=Project.Pnumber
	inner join Departments d
	on Project.Dnum=d.Dnum
	group by d.Dname ,Pnumber
	
	go
	select * from V_D3
	