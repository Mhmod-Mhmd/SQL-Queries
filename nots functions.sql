select * from Student
go 

isnull()
coalesce()
convert()
cast()
concat()
substring()
len()
iif()

select isnull(st_fname, st_lname) as name 
from Student
select coalesce(st_fname, st_lname , 'No Name') as name 
from Student
select convert(varchar(50), St_Fname ) as name 
from Student
select cast( St_Fname as varchar(50)) as name 
from Student

Alter table student alter column st_age varchar(50)

select concat('The name is :' ,st_fname ,' ',St_Lname, '. lives in ',St_Address ) as namee 
from Student


select substring(st_fname, 1 , 3 )  ,len( St_Fname)   as name , st_fname 
from Student order by name desc

select db_name()
select user_name()

select iif(st_age < 25 , 'teenger' , 'dault') as classificaion , st_age
from Student
order by St_Age

select 'this is my name '+ st_fname from student
select * from Student
select SUBSTRING(st_fname , 1 ,1) from Student order by st_fname 



