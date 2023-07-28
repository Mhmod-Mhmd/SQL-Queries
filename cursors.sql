use iti 
go 

select St_Id , st_fname , St_Age
from Student
where St_Age > 20
order by st_age desc

declare cur1 cursor
for 
	select St_Id , st_fname , St_Age
	from Student
	where St_Age > 20
	order by st_age desc
for read only 
open cur1 
declare @id int , @name varchar(30) , @age int 
fetch cur1 into @id , @name , @age 
while @@FETCH_STATUS=0
	begin 
		select @id , @name , @age 
		fetch cur1 into @id , @name , @age
	end
close cur1
deallocate cur1


select * from Instructor

select Ins_Name , salary 
from Instructor 

declare cur1 cursor 
for
	select salary 
	from Instructor
for update 
open cur1
declare @sal int
fetch cur1 into @sal
while @@fetch_status=0	
	begin 
		if @sal >= 7000 
			begin
				update Instructor
				set Salary = Salary * 1.20
				where current of cur1
			end

		else 
			begin 
				update Instructor
				set Salary = Salary * 1.30
				where current of cur1
			end
		fetch cur1 into @sal
	end
close cur1
deallocate cur1


declare c cursor
for select St_Fname
	from Student
	where St_Fname is not null
for read only

declare @name varchar(20), @fullname varchar(200)
open c
fetch c into @name
while @@FETCH_STATUS = 0
	begin
		set @fullname = concat(@fullname ,',' , @name)
		fetch c into @name 
	end
select @fullname
close c
deallocate c

declare c1 cursor
for
	select St_Fname
	from Student
for read only

declare @name varchar(20) , @flage int = 0 , @counter int=0


open c1
fetch c1 into @name
while @@FETCH_STATUS = 0 
	begin

		if @name = 'Ahmed'
			set @flage = 1
		if @name = 'Amr' and @flage = 1
			begin
				set @counter = @counter + 1
				set @flage = 0
			end
		fetch c1 into @name

	end
select @counter 
close c1
deallocate c1


select * from student

--------------------------------------------------- lec 10 
--defaultly can't change primary key if it's identity cuz it's outo_incremental
--so we can use these two proprities to on or off the identity 
set identity_insert table_name on; -- by default 
set identity_insert table_name off;

-- to get the last id in the last qurery , use 
select @@IDENTITY
-- to get the last id in the specific table , use
select IDENT_CURRENT('person.addres')


---------------------------------------------
--typies of insert
--simple insert
--insert constructor ( insert multiple rows )
--insert based on select
--insert based on execute " in the stored procedure "
--bulk insert ( insert data from file )
--

bulk insert test
from 'E:\text.txt'
with (fieldterminator = ',')


--------------------------------
--      snapshot database : 
-- can't update or delete from snapshot ,  it is read only database
-- point to the data in the database
-- can't run it in differnt server VS. Backup 
-- the physical file end by '.ss' extention 

create database Bikestore_snap on
(
name = 'BikeStore' ,
filename = 'E:\Bike_snap.ss'
)
as snapshot of BikeStore


restore database BikeStore
from database_snapshot = 'Bikestore_snap'


------------








