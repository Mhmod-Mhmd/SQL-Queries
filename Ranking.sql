
--                         transact sql
-- DDL data defination langauge ( create , alter . drop , select into )
-- DML data manipulation langauge (update , delete, insert, remove)
-- DQL data query langauge ( select and its family)
-- TCL transactionl control langauge(roll back, commit, begin transaction)
-- DCL data control langauge ( deny , grant , Revoke )


use ITI
go

-- top() with ties 

select top(9) with  ties St_id, St_Fname , St_Age from Student
order by St_Age 
 
-- GUID 
select * , newid() 
from Student 

-- take only table strcuture to new table
select * into new_student 
from Student
where 1=2

-- take only data from table to anther table
insert into new_student 
select * from student 

-------------------------- Ranking functionss--------------------
--row_number()
--dense_rank() 
--rank()
--ntile(n) grouping


select * 
from ( select *, ROW_NUMBER() over(partition by dept_id order by st_age desc) as RN
	   from student ) as newtable
where RN = 1

select * 
from ( select *, Rank() over(partition by dept_id order by st_age desc) as R
	   from student ) as newtable
where R = 1

select *, Ntile(4) over(order by st_age desc) as NT
	   from student
select *, rank() over(partition by dept_id order by st_age desc) as R
	   from student
select *, dense_rank() over(partition by dept_id order by st_age desc) as DR
	   from student



-------------------


select * from Student where St_Age is not null

select distinct Ins_Name   from Instructor 

select St_Id , isnull(St_Fname , 'no fname ' )+' '+ isnull(St_Lname, 'no lname ' ) as Full_Name ,
       isnull( convert(varchar(20),dept_id  ), 'noo id' ) as Department_ID
from Student

select ins_name as instructor_name , dept_Name as department_name 
from   Department d right outer join instructor i
on d.Dept_Id = i.Dept_Id

select ST_fname+' '+St_lname as full_name , crs_name as course_name , Grade ,
	 row_number() over(partition by(grade) order by grade ) as new 
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id
join Course c
on sc.Crs_Id = c.Crs_Id

select t.top_name as 'Topic Name' ,  count(c.crs_name) as 'number of courses'
from Course c join Topic t
on t.Top_Id=c.Top_Id
group by t.Top_Name

select convert(int , max(salary)) , cast(min(salary) as int) from Instructor

select Ins_Name  
from Instructor 
where Salary < (select avg(salary) from Instructor)

select sum(salary)
from Instructor
where ins_id > 11 

select * from Department
select * from Instructor

Select d.dept_name , i.Ins_Name , i.Salary
from Department d join Instructor i
on d.Dept_Id = i.Dept_Id
where salary = (select min(salary) from Instructor)

select top(2) with ties salary 
from Instructor
order by salary desc

select ins_name , isnull(salary, 00 ) 
from Instructor

select ins_name , coalesce(salary, 0  , 10 ) salary
from Instructor

select s.St_Fname , sp.* 
from student sp join Student s
on sp.St_Id=s.St_super





use AdventureWorks2019
go 

select [SalesOrderID] , year(ShipDate )
from sales.SalesOrderHeader
where ShipDate between '2010' and '2014'

select * from ( select [SalesOrderID] , convert(date  , ShipDate) as new
                 from sales.SalesOrderHeader) as newtable
where new between '2010-02-05' and '2012/5/5'

select ProductID , Name 
from Production.Product
where Weight is not null

select * from Production.Product
where Color in ( 'red' , 'black' , 'silver')
order by color

select * from Production.Product
where name like 'B%'

select rowguid, Name, SalesPersonID, Demographics into Store_Archive2
from sales.Store
where 1=2

select * from Store_Archive2

select 'The '+ Name + ' is only! ' + ListPrice
from production.product
where ListPrice between 100 and 120










