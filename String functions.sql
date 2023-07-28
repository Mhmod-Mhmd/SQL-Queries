
----------------------String Functionssssssssssssss
-- ASCII return the asci code of the characters
select ASCII('+')
SELECT UNICODE('Atlanta');
-- return character based on ascii code 
SELECT CHAR(65) AS CodeToCharacter;
SELECT NCHAR(43) AS NumberCodeToUnicode;

-- Charindex return the Position of the first argument in the second argument and
-- third argument is optional it's the starting position
select charindex('b','Hello DataBase h')
select charindex('b','Hello DataBase h', 4) -- third argument

-- Concat return merge two strings
select concat('one ','then ','two')
-- use operator +
select 'one ' + 'then ' + 'two'
-- concat with operator
select concat_ws('.','www','Facebook','com')

-- converts the first character of the code into the upper case 
-- A, O, U, E, I, Y, H, W , ignored if they are not in the first character so return 0 
-- use to compare between two strings, see the difference function
select soundex('mahmoud'),soundex('alm')
SELECT SOUNDEX('mhamoud'), SOUNDEX('nufmoud') 

-- return the similtry character between two character
select DIFFERENCE('mhamoud' , 'nufmoud') , DIFFERENCE('ma', 'mohmoud')

--datalenght--> return the lenght of the characher and counts both leading and trailing spaces 
select DATALENGTH(' mahmoud ')
-- with len function its count only leading trailing 
select len(' mahmoud')

-- upper , lower 
select upper('mahmoud') , lower('MOHMed')

-- left , right 
select left('DELL Laptop', 4), right('DELL Laptop',3)

-- ltrim , ltrim , remove additional spaces besides string from left or right side
select ltrim('    Hello'), rtrim('Hello   ')
SELECT TRIM('     SQL Tutorial!     ') AS TrimmedString;
select count(*)

-- quotename - converting the input string into a valid delimited identifier  [] 
DECLARE @QUTO1 nvarchar(MAX);    
DECLARE @QUTO2 nvarchar(MAX);     
SET @QUTO1='JAVAT';    
SET @QUTO2='JAVATPOINT';     
SELECT QUOTENAME(@QUTO1) QUTONMAE UNION ALL    
SELECT QUOTENAME(@QUTO2) QUTONMAE

-- repeat string with specified number of times
select replicate('mahmoud ' , 5)


-- format function format date/time values and number values 
DECLARE @d DATETIME = '12/01/2018';
SELECT FORMAT (@d, 't', 'en-US') AS 'US English Result',
               FORMAT (@d, 'd', 'no') AS 'Norwegian Result',
               FORMAT (@d, 'd', 'zu') AS 'Zulu Result';

SELECT FORMAT(123456789, '##-##-#####');

-- return the postion of the string 
-- the search is case-insensitive and the first position in string is 1
select PATINDEX('%mo%','mahmoud')
select PATINDEX('%[mo]%','mahmoud') -- any place
select PATINDEX('%[a]%','mahmoud')

-- reverse function -- reverse string 
SELECT reverse('SQL Tutorial');

select space(22) as f

SELECT STR(185.476)

-- delete part from string and add part to string 
-- 13 is the starting position to delete it  1 is the number of character we want to delete 
SELECT STUFF('SQL Tutorial!', 13, 1, ' is fun!');

-- return column 
SELECT value
FROM STRING_SPLIT('An example sentence.', ' ');

--substring function
SELECT SUBSTRING('SQL Tutorial', 1, 3)

-- Return the string from the first argument AFTER the characters specified in 
-- the second argument are translated into the characters specified in the third argument
SELECT TRANSLATE('3*[2+1]/{8-4}', '[]{}', '()()'); -- Results in 3*(2+1)/(8-4)






