use IBANK
go
-- Basic SQL Commands
-- Select all the records (rows and columns) from database
select * from AMASTER;
select * from [dbo].[TMASTER];

-- Select few columns and all rows
select ACID, Name, cbal
from AMASTER;

--Select all columns & few rows with 'where' clause
select * 
from AMASTER
WHERE BRID = 'BR1';

-- 'where' & 'and' clause
select * 
from AMASTER
WHERE BRID = 'BR1' and PID = 'RD' and UBAL > 1000;

-- prints 100 As column NUM
select 100 AS Num


select ACID, Name, cbal, 'INR' AS Currency, 18 AS Tax
from AMASTER;

-- Sorting the rows
Select * 
from AMASTER
Order by NAME asc -- asc is default

Select * 
from AMASTER
Order by NAME desc

Select *
from AMASTER
order by ACID;

Select *
from AMASTER
order by ACID desc;

-- List ACID and Name only for productID SB accounts and list the names in desc order

select ACID, NAME, PID
from AMASTER
where PID = 'SB'
order by name desc; 

/***************************
-- 2 Types of CAST functions
 CAST ( ColName AS datatype) - Is used to convert data types.
 CONVERT ( Datatype, ColName , StyleNumber) - Is used to convert date and time styles.
Style No -- 1 to 21 -- YY
Style No -- 101 to 121 -- YYYY
**************************/

select acid, NAME, 'Savings Account' AS COURSE
from AMASTER

select acid, NAME, 'MSBI & Data Engineering' AS COURSE
from AMASTER


select acid, 'Dr.' + NAME AS 'Full Name', 'MSBI & Data Engineering' AS COURSE
from AMASTER

-- Below query will throw an error
-- Cannot convert a char value to money. The char value has incorrect syntax.
-- Character string cannot be converted to money data type
select ACID, NAME, CBAL + 'INR' AS Currency 
FROM AMASTER

--Fixing above query with CAST function

select ACID, NAME, CAST(CBAL AS varchar) + ' INR' AS Currency 
FROM AMASTER

select ACID, NAME, Convert(varchar, CBAL) + ' INR' AS Currency 
FROM AMASTER

-- Output DOO format 2011-01-01 00:00:00.000
select ACID, NAME, cbal, DOO AS AccountOpenDate
FROM AMASTER

--DOO format Jan  1 2011 12:00AM
select ACID, NAME, cbal, Convert(varchar, DOO) AS AccountOpenDate
FROM AMASTER

--DOO format 01/01/11
select ACID, NAME, cbal, Convert(varchar, DOO, 1) AS AccountOpenDate
FROM AMASTER

--DOO format 11.01.01
select ACID, NAME, cbal, Convert(varchar, DOO, 2) AS AccountOpenDate
FROM AMASTER

--DOO format 01.01.11
select ACID, NAME, cbal, Convert(varchar, DOO, 4) AS AccountOpenDate
FROM AMASTER


-- DOO column format 01/01/2011
select ACID, NAME, cbal, Convert(varchar, DOO, 101) AS AccountOpenDate
FROM AMASTER

-- 2011.01.01
select ACID, NAME, Cbal, CONVERT(varchar, DOO, 102) AS AccountOpenDate
FROM AMASTER

--Aggregate functions
--COUNT, MIN, MAX, SUM, AVG

-- Count function gets no. of rows in the table. 
select Count(*) AS 'No of Customers'
from AMASTER

select Count(*) AS [No of Customers]
from AMASTER

-- Find out no of customers in BR1 branch 1
select count(*) AS 'No fo Customers'
from AMASTER
where BRID = 'BR1'

-- Find out no of customers in BR2 branch 2
select count(*) AS [No of Customers]
from AMASTER
where BRID = 'BR2'

-- Find out no of customers in BR1 and BR2
select count(*) AS [No of Customers]
from AMASTER
where BRID = 'BR1' or BRID = 'BR2'

-- Find out no of customers in BR1, BR2 (Another way to write above query)
select count(*) AS [No of Customers]
from AMASTER
where BRID in ('BR1', 'BR2')

-- SUM function - gets total value
select SUM(CBAL) AS TOTAL
from AMASTER

-- Total sum in BR1

select SUM(CBAL) AS TOTAL
from AMASTER
where BRID = 'BR1'

-- Max, Min, Avg
select MAX(CBAL) AS MaxValue,
	   MIN(CBAL) AS MinValue,
	   AVG(CBAL) AS AvgValue
from AMASTER


-- Example using all aggregate functions in one query

select count(*) AS 'Total No. of Customers',
       SUM(CBAL) AS TotalValue,
       MAX(CBAL) AS MaxValue,
	   MIN(CBAL) AS MinValue,
	   AVG(CBAL) AS AvgValue
from AMASTER

-- 62 values 
select count(*) from AMASTER;

-- COUNT(COLNAME) -- we got ds because COUNT(COLNAME) exclude NULL Values
select count(UBAL) from AMASTER;

--Aggregate more examples
-- No of accounts in the bank
select count(*) as [Total No of Accounts]
from AMASTER

-- Branch wise no. of customers
select BRID, count(*) AS [No. of Customers]
from AMASTER
GROUP BY BRID

-- Where and Group By Example
select * from AMASTER

-- Find no of customer having Product ID 'SB' branch wise
select BRID, PID, count(*) AS [Total Accounts]
FROM AMASTER
WHERE PID = 'SB'
GROUP BY BRID, PID


-- Branch wise, product wise no of customers
select BRID, PID, count(*)
FROM AMASTER
group by BRID, PID
order by BRID asc

-- DISTINCT function
-- below query has duplicates
select BRID 
from AMASTER

-- to select distinct values
SELECT DISTINCT BRID
FROM AMASTER

-- find out no. of branches
SELECT COUNT(DISTINCT BRID) AS [No. of BRANCHES]
FROM AMASTER