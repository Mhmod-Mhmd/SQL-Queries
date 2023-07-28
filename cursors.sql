use iti 
go 

select St_Id , st_fname , St_Age
from Student
where St_Age > 20
order by st_age desc
-- Exmp 1
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

-- Exmp 2
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

-- Exmp 3
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

--Exmp 4
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
