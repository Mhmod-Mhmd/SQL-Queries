
--------------- solved queries in haker rank

-- to retreive difference from rows and distinct 
select  count(city) - count(distinct city)from station 

-- to retreive even or odd id 
select id from station where id % 2 = 0 -- even
select id from station where id % 2 != 0 -- odd


--Query to retrive max city that have long wedth and select only one if exist two with same wedth

SELECT TOP 1 CITY, len(CITY) FROM STATION ORDER BY LEN(CITY) DESC, CITY DESC
SELECT TOP 1 CITY, len(CITY) FROM STATION ORDER BY LEN(CITY) ASC, CITY ASC

--select city name with first and start vowls letter(aeiou) 
select distinct city from station where city like '[aeiou]%' and city like '%[aeiou]'

-- query students name to retrive names and order by last three letters on the names 
select name from students 
where marks > 75 
order by substring(name, len(name)-2, len(name))  ,id  -- in order by default ( asc )

-- round function -- round dicimal numbers to the nearest intger 
select country.continent , round(avg(city.population),0) 
from country inner join city
on country.code = city.countrycode 
group by country.continent 

------- case can write in the select caluse
SELECT
CASE WHEN grade>=8 THEN Name
ELSE NULL END AS name,
Grade, Marks
FROM Students s, Grades g
WHERE s.Marks Between g.Min_Mark AND g.Max_Mark
ORDER BY Grade DESC, name, Marks ASC;


-------- concat and order by 
select Concat('There are a total of ',count(occupation),' ',lower(occupation),'s.') 
from Occupations 
group by occupation 
order by count(occupation), occupation


select cast(sqrt(power(min(lat_n) - max(lat_n), 2) + power(min(long_w) - max(long_w), 2))  as decimal (10,4))
from station
SELECT CAST(SQRT(SQUARE(MIN(LAT_N)-MAX(LAT_N)) + SQUARE(MIN(LONG_W)-MAX(LONG_W))) as decimal(10,4))
FROM STATION;


select max
from Student











