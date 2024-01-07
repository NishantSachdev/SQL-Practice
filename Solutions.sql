-- query 1 - List all the columns of the Salespeople table.
select COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Salespeople';

-- query 2 - List all customers with a rating of 100.
select * 
from Customers
where RATING=100;

-- query 3 - Find all records in the Customer table with NULL values in the city column.
select *
from Customers
where CITY='NULL';

-- query 4 - Find the largest order taken by each salesperson on each date (*)
select Orders.SNUM, ODATE, MAX(AMT) as 'Largest order taken for the day', Salespeople.SNAME
from Orders
inner join Salespeople
on Salespeople.SNUM=Orders.SNUM
group by Orders.SNUM, ODATE, Salespeople.SNAME

select * from orders

-- query 5 - Arrange the Orders table by descending customer number.
select * 
from Orders
order by CNUM desc;

-- query 6 - Find which salespeople currently have orders in the Orders table.
select DISTINCT Salespeople.SNUM, Salespeople.SNAME, Salespeople.CITY
from Salespeople
INNER JOIN Orders
ON Salespeople.SNUM = Orders.SNUM;

-- query 7 - List names of all customers matched with the salespeople serving them.
select Customers.CNAME, Salespeople.SNAME
from Salespeople
INNER JOIN Customers
ON Salespeople.SNUM = Customers.SNUM;

-- query 8 - Find the names and numbers of all salespeople who had more than one customer (*)
select Customers.SNUM, Salespeople.SNAME, Count(Customers.SNUM) as 'Number of Customers'
from Salespeople
inner join Customers
on Salespeople.SNUM = Customers.SNUM
group by Customers.SNUM, Salespeople.SNAME
having Count(Customers.SNUM)>1

-- query 9 - Count the orders of each of the salespeople and output the results in descending order.
select Salespeople.SNUM, Salespeople.SNAME, COUNT(Salespeople.SNUM) as 'Orders of salesperson'
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Salespeople.SNUM, Salespeople.SNAME
order by COUNT(Salespeople.SNUM) desc;

select * from Orders

-- query 10 - List the Customer table if and only if one or more of the customers in the Customer table are located in San Jose. 
select * from Customers
where (select count(CITY) from Customers where CITY='San Jose') >=1


-- query 11 - Match salespeople to customers according to what city they lived in.
select Salespeople.SNUM, Salespeople.SNAME, Customers.CNUM, Customers.CNAME, Salespeople.CITY
from Salespeople
inner join Customers
on Salespeople.CITY=Customers.CITY;

-- query 12 - Find the largest order taken by each salesperson.
select Salespeople.SNAME, Orders.SNUM, Max(AMT) as 'Largest order by Salesperson' 
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME

-- query 13 - Find customers in San Jose who have a rating above 200.
select * from Customers
where CITY='San Jose' and RATING>200;

-- query 14 - List the names and commissions of all salespeople in London.
select SNAME, COMM, CITY
from Salespeople
where CITY='London';

-- query 15 - List all the orders of salesperson Motika from the Orders table.
select * 
from Orders
where SNUM in (select SNUM from Salespeople where SNAME='Motika');

-- query 16 - Find all customers with orders on October 3.
select * from Customers
where CNUM in (select CNUM from Orders where ODATE='10/03/96');

/* query 17 - Give the sums of the amounts from the Orders table, grouped by date, eliminating all those dates 
where the SUM was not at least 2000.00 above the MAX amount. */

-- query for max amount of all dates
select SUM(AMT) as 'Sum of amount for particular date', ODATE
from Orders
group by ODATE
having SUM(AMT) > ((select MAX(AMT) from Orders)+2000);

-- query for max amount of each date
select SUM(AMT) as 'Sum of amount for particular date', ODATE
from Orders
group by ODATE
having ODATE in (select ODATE from Orders group by ODATE having SUM(AMT)>(MAX(AMT)+2000));

-- query 18 -  Select all orders that had amounts that were greater than at least one of the orders from October 6.
select * from Orders
where AMT > (select MIN(AMT) from Orders where ODATE='10/06/96');

-- query 19 - Write a query that uses the EXISTS operator to extract all salespeople who have customers with a rating of 300. 
select * 
from Salespeople
where exists(select CNAME from Customers where Salespeople.SNUM = Customers.SNUM and RATING=300);

-- query 20 - Find all pairs of customers having the same rating.
select A.CNUM as 'Person 1 CNUM', A.CNAME as 'Person 1 NAME', B.CNUM as 'Person 2 CNUM', B.CNAME as 'Person 2 NAME'
from Customers A, Customers B
where A.RATING = B.RATING and A.CNUM < B.CNUM;

-- query 21 - Find all customers whose CNUM is 1000 above the SNUM of Serres.
select * from Customers
where (CNUM-1000)>=(select SNUM from Salespeople where SNAME='Serres');

-- query 22 - Give the salespeople’s commissions as percentages instead of decimal numbers.
select CONCAT(CAST(CAST(COMM*100 as int) as varchar),'%') as '% commission'
from Salespeople;

-- query 23 - Find the largest order taken by each salesperson on each date, eliminating those MAX orders which are less than $3000.00 in value.
select Salespeople.SNAME, Orders.SNUM, MAX(AMT) as 'largest order taken by salesperson on each date', ODATE
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, ODATE, Salespeople.SNAME
having MAX(AMT)>3000;

-- query 24 - List the largest orders for October 3, for each salesperson.
select MAX(AMT) as 'largest order for October 3 for each salesperson', Orders.SNUM, Salespeople.SNAME, ODATE
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, ODATE, Salespeople.SNAME
having ODATE='10/03/96';

-- query 25 - Find all customers located in cities where Serres (SNUM 1002) has customers.
select * from Customers 
where CITY in (select CITY from Customers where SNUM=1002)

-- query 26 - Select all customers with a rating above 200.00
select * from Customers
where CAST(RATING as decimal)>200.00

-- query 27 - Count the number of salespeople currently listing orders in the Orders table
select COUNT(DISTINCT(SNUM)) as 'number of salespeople currently listing orders in the Orders table'
from Orders

/* query 28 - Write a query that produces all customers serviced by salespeople with a commission above 12%. 
Output the customer’s name and the salesperson’s rate of commission.*/

select Salespeople.SNAME, Customers.CNAME, CONCAT(CAST(CAST(Salespeople.COMM*100 as int) as varchar),'%') as 'COMMISSION'
from Customers
inner join Salespeople
on Customers.SNUM=Salespeople.SNUM
where Salespeople.COMM>0.12

-- query 29 - Find salespeople who have multiple customers.
select * from Salespeople
where SNUM in (select SNUM from Customers group by SNUM having COUNT(SNUM)>1)

-- query 30 - Find salespeople with customers located in their city
select DISTINCT Salespeople.SNUM, Salespeople.SNAME, Customers.CNAME, Salespeople.CITY from Salespeople
inner join Customers
on Salespeople.CITY=Customers.CITY

-- query 31 - Find all salespeople whose name starts with ‘P’ and the fourth character is ‘l’
select * from Salespeople 
where SNAME LIKE 'P__l%'

-- query 32 - Write a query that uses a subquery to obtain all orders for the customer named Cisneros. Assume you do not know his customer number.

-- using subquery
select * from Orders 
where CNUM = (select CNUM from Customers where CNAME='Cisneros')

-- using join
select Orders.ODATE, Orders.AMT, Orders.ONUM, Orders.CNUM, Customers.CNAME from Orders
inner join Customers
on Orders.CNUM = Customers.CNUM
where Customers.CNAME = 'Cisneros'

-- query 33 - Find the largest orders for Serres and Rifkin
select MAX(AMT) as 'largest orders', Orders.SNUM, Salespeople.SNAME
from Orders 
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME
having Salespeople.SNAME in ('Serres','Rifkin')

-- query 34 - Extract the Salespeople table in the following order : SNUM, SNAME, COMMISSION, CITY
select SNUM, SNAME, COMM, CITY
from Salespeople

-- query 35 - Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.
select * from Customers
where CNAME LIKE '[a-g]%'

-- query 36 - Select all the possible combinations of customers that you can assign.
select A.CNAME, B.CNAME
from Customers A, Customers B
where A.CNAME < B.CNAME 

-- query 37 - Select all orders that are greater than the average for October 4.
select * from orders 
where AMT>(select AVG(AMT) from Orders where ODATE='10/04/96')

-- query 38 - Write a select command using a corelated subquery that selects the names and numbers of 
-- all customers with ratings equal to the maximum for their city. 
select CNAME, CNUM, CITY
from Customers
where CONCAT(CAST(RATING as varchar), CITY) in (select CONCAT(CAST(MAX(RATING) as varchar), CITY) from Customers group by CITY)

-- query 39 - Write a query that totals the orders for each day and places the results in descending order
select COUNT(ODATE) as 'Number of Orders', ODATE
from Orders
group by ODATE
order by COUNT(ODATE) desc

-- query 40 - Write a select command that produces the rating followed by the name of each customer in San Jose.
select RATING, CNAME, CITY
from Customers 
where CITY='San Jose'

-- query 41 - Find all orders with amounts smaller than any amount for a customer in San Jose.
select * from Orders 
where AMT < (select max(amt) from Orders where CNUM in(select CNUM from Customers where CITY='San Jose'))

-- query 42 - Find all orders with above average amounts for their customers.
select * from Orders
where AMT>(select AVG(AMT) from Orders)

-- query 43 - Write a query that selects the highest rating in each city.
select MAX(RATING) as 'Highest Rating in City', CITY 
from Customers 
group by CITY

-- query 44 - Write a query that calculates the amount of the salesperson’s commission on each order by a customer with a rating above 100.00
select Orders.ONUM, Orders.AMT*Salespeople.COMM as 'Amount of Commission', Salespeople.SNUM from Salespeople
inner join Orders
on Salespeople.SNUM = Orders.SNUM 

-- query 45 - Count the customers with ratings above San Jose’s average.
select * from Customers
where RATING > (select AVG(RATING) from Customers where CITY='San Jose')

-- query 46 - Write a query that produces all pairs of salespeople with themselves as well as duplicate rows with the order reversed
select A.SNAME, B.SNAME 
from Salespeople A, Salespeople B
where A.SNAME = B.SNAME

-- query 47 - Find all salespeople that are located in either Barcelona or London
select * from Salespeople
where CITY in ('Barcelona','London')

-- query 48 - Find all salespeople with only one customer.
select * from Salespeople 
where SNUM in (select SNUM from Customers group by SNUM having COUNT(SNUM)=1)

-- query 49 - Write a query that joins the Customer table to itself to find all pairs of customers served by a single salesperson. (duplicate rows with the order reversed)
select A.CNAME as 'Customer 1 Name', A.CNUM as 'Customer 1 Number', B.CNAME as 'Customer 2 Name', B.CNUM as 'Customer 2 Number' 
from Customers A, Customers B
where A.SNUM = B.SNUM and  A.CNUM <> B.CNUM

-- query 50 - Write a query that will give you all orders for more than $1000.00.
select * from Orders
where AMT > 1000.00

-- query 51 - Write a query that lists each order number followed by the name of the customer who made that order.
select Orders.ONUM, Customers.CNAME
from Orders
inner join Customers
on Orders.CNUM = Customers.CNUM

-- query 52 - Write 2 queries that select all salespeople (by name and number) who have customers in their cities who they do not service, 
-- one using a join and one a corelated subquery. Which solution is more elegant?

-- join query
select distinct Salespeople.SNAME, Salespeople.SNUM
from Salespeople
inner join Customers
on Salespeople.CITY=Customers.CITY
where Salespeople.SNUM <> Customers.SNUM

-- subquery

-- ** Incomplete ** 

-- query 53 - Write a query that selects all customers whose ratings are equal to or greater than ANY (in the SQL sense) of Serres’?
select * from Customers 
where RATING >= (select MIN(RATING) from Customers where SNUM = (select SNUM from Salespeople where SNAME='Serres'))

-- query 54 - Write 2 queries that will produce all orders taken on October 3 or October 4.
select * from Orders
where ODATE = '10/03/96' or ODATE = '10/04/96'

select * from Orders
where ODATE in ('10/03/96','10/04/96')

-- query 55 - Write a query that produces all pairs of orders by a given customer. Name that customer and eliminate duplicates.
select distinct A.CNUM, Customers.CNAME, A.ONUM, B.ONUM
from Orders A, Orders B 
inner join Customers
on Customers.CNUM = B.CNUM
where A.CNUM = B.CNUM and A.ONUM < B.ONUM

-- query 56 - Find only those customers whose ratings are higher than every customer in Rome
select * from Customers
where RATING>(select MAX(RATING) from Customers where CITY='Rome')

-- query 57 - Write a query on the Customers table whose output will exclude all customers with a rating <= 100.00, unless they are located in Rome.
select * from Customers 
where RATING>100 or CITY='Rome'

-- query 58 - Find all rows from the Customers table for which the salesperson number is 1001.
select * from Customers
where SNUM=1001

-- query 59 - Find the total amount in Orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
select Salespeople.SNAME, Orders.SNUM, SUM(AMT) as 'Total Amount in Orders for each salesperson'  
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME
having SUM(AMT)>(select MAX(AMT) from Orders)

-- query 60 - Write a query that selects all orders save those with zeroes or NULLs in the amount field.
select * from Orders 
where CAST(AMT as varchar) not in ('NULL','0.00')

-- query 61 - Produce all combinations of salespeople and customer names such that the former precedes the latter alphabetically, 
-- and the latter has a rating of less than 200.
select Salespeople.SNAME as 'Salesperson', Customers.CNAME as 'Customer'
from Salespeople 
cross join Customers
where Customers.RATING<200 and Salespeople.SNAME > Customers.CNAME

-- query 62 - List all Salespeople’s names and the Commission they have earned.
select Salespeople.SNAME as 'Salesperson Name', Salespeople.COMM*Sum(AMT) as 'Commission earned'
from Salespeople
inner join Orders
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME, Salespeople.COMM

-- query 63 - Write a query that produces the names and cities of all customers with the same rating as Hoffman. 
-- Write the query using Hoffman’s CNUM rather than his rating, so that it would still be usable if his rating changed.
select CNAME, CITY from Customers
where RATING = (select RATING from Customers where CNUM = (select CNUM from Customers where CNAME='Hoffman'))

-- query 64 - Find all salespeople for whom there are customers that follow them in alphabetical order. 
select distinct Salespeople.SNAME as 'Salespeople for whom there are customers that follow them in alphabetical order' from Salespeople
cross join Customers
where Salespeople.SNAME > Customers.CNAME

-- query 65 - Write a query that produces the names and ratings of all customers of all who have above average orders.
select distinct Customers.CNAME as 'Customer Name', Customers.RATING 
from Customers
inner join Orders 
on Customers.CNUM = Orders.CNUM
where AMT>(select AVG(AMT) from Orders)

-- query 66 - Find the SUM of all purchases from the Orders table.
select SUM(AMT) as 'SUM of all purchases'
from Orders

-- query 67 - Write a SELECT command that produces the order number, amount and date for all rows in the order table.
select ONUM as 'Order Number', AMT as 'Amount', ODATE as 'Date'
from Orders

-- query 68 - Count the number of nonNULL rating fields in the Customers table (including repeats)
select COUNT(RATING) as 'Number of nonNULL rating fields'
from Customers
where CAST(RATING as varchar) <> 'NULL' 

-- query 69 - Write a query that gives the names of both the salesperson and the customer for each order after the order number. 
select Orders.ONUM as 'Order Number', Salespeople.SNAME as 'Salesperson Name', Customers.CNAME as 'Customer Name'
from Orders inner join Salespeople
on Orders.SNUM = Salespeople.SNUM
inner join Customers
on Customers.CNUM = Orders.CNUM

-- query 70 - List the commissions of all salespeople servicing customers in London
select  distinct Salespeople.SNAME as 'Salesperson Name', Salespeople.SNUM as 'Salesperson Number', 
Salespeople.COMM as 'Commission', Customers.CITY as 'Customer City'
from Salespeople
inner join Customers
on Salespeople.SNUM = Customers.SNUM 
where Customers.CITY = 'London'

-- query 71 - Write a query using ANY or ALL that will find all salespeople who have no customers located in their city.
select SNUM as 'Salesperson Number', SNAME as 'Salesperson Name', CITY as' Salesperson City'
from Salespeople
where CITY <> ALL(select distinct CITY from Customers) 

-- query 72 - Write a query using the EXISTS operator that selects all salespeople with customers 
-- located in their cities who are not assigned to them. (* Could not use exists *)
select distinct Salespeople.SNAME, Salespeople.SNUM, Salespeople.CITY from Salespeople
inner join Customers
on Salespeople.CITY = Customers.CITY 
where Salespeople.SNUM <> Customers.SNUM

-- query 73 - Write a query that selects all customers serviced by Peel or Motika. (Hint : The SNUM field relates the two tables to one another.)
select Customers.CNAME, Customers.CNUM, Customers.CITY, Customers.RATING, Salespeople.SNAME from Customers
inner join Salespeople
on Salespeople.SNUM = Customers.SNUM
where Salespeople.SNAME = 'Peel' or Salespeople.SNAME = 'Motika'

-- query 74 - Count the number of salespeople registering orders for each day. (If a salesperson has more than one order 
-- on a given day, he or she should be counted only once)
select ODATE as 'Order Date', Count(distinct SNUM) as 'Number of salespeople registering orders for each day'
from Orders 
group by ODATE

-- query 75 - Find all orders attributed to salespeople in London.
select Orders.ODATE, Orders.AMT, Orders.CNUM, Orders.SNUM as 'Salesperson Number', Salespeople.SNAME as 'Salesperson Name', Salespeople.CITY
from Orders 
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
where Salespeople.CITY='London'

-- query 76 - Find all orders by customers not located in the same cities as their salespeople
select Orders.ODATE, Orders.ONUM, Orders.AMT, Orders.CNUM, Customers.CNAME, Orders.SNUM, Salespeople.SNAME
from Orders inner join Customers
on Orders.CNUM = Customers.CNUM
inner join Salespeople
on Salespeople.SNUM = Customers.SNUM
where Salespeople.CITY <> Customers.CITY

-- query 77 - Find all salespeople who have customers with more than one current order.
select Salespeople.SNAME, Salespeople.SNUM, Orders.CNUM, Count(Orders.CNUM) as 'Number of Orders'
from Salespeople 
inner join Orders
on Salespeople.SNUM = Orders.SNUM
group by Orders.CNUM, Salespeople.SNAME, Salespeople.SNUM, Orders.CNUM
having count(Orders.CNUM)>1

-- query 78 - Write a query that extracts from the Customers table every customer assigned to a salesperson who currently 
-- has at least one other customer (besides the customer being selected) with orders in the Orders table.
select * from Customers
where SNUM in (select SNUM from Orders group by SNUM having COUNT(distinct CNUM)>1)

-- query 79 - Write a query that selects all customers whose names begin with ‘C’.
select * from Customers
where CNAME LIKE 'C%'

-- query 80 - Write a query on the Customers table that will find the highest rating in each city. 
-- Put the output in this form : for the city (city) the highest rating is : (rating)
select CONCAT('for the city ', CITY, ' the highest rating is : ', MAX(RATING)) as 'City and its Max Rating' from Customers
group by CITY

-- query 81 - Write a query that will produce the SNUM values of all salespeople with orders currently in the 
-- Orders table (without any repeats).
select distinct SNUM as 'Salesperson Number SNUM'
from Orders

-- query 82 - Write a query that lists customers in descending order of rating. Output the rating field first, 
-- followed by the customer’s names and numbers.
select RATING, CNAME as 'CUSTOMER NAME', CNUM as 'CUSTOMER NUMBER'
from Customers
order by RATING desc

-- query 83 - Find the average commission for salespeople in London.
select AVG(COMM) as 'Average commission for salespeople in London'
from Salespeople
where CITY = 'London'

-- query 84 - Find all orders credited to the same salesperson who services Hoffman (CNUM 2001)
select ONUM, AMT, ODATE, CNUM, Salespeople.SNUM, Salespeople.SNAME from Orders
inner join Salespeople
on Orders.SNUM = Salespeople.SNUM
where Orders.SNUM = (select SNUM from Customers where CNUM = 2001)

-- query 85 - Find all salespeople whose commission is in between 0.10 and 0.12 (both inclusive).
select * from Salespeople
where COMM >= 0.10 and COMM<=0.12 

-- query 86 - Write a query that will give you the names and cities of all salespeople in London with a commission above 0.10.
select SNAME, CITY from Salespeople
where CITY='London' and COMM>0.10

-- query 87 - What will be the output from the following query?
select * from Orders
where (AMT < 1000 OR NOT (ODATE = '10/03/1996' AND CNUM > 2003));

-- Select all orders excluding order for CNUM > 2003 on 3rd October except orders that have amt < 1000 

-- query 88 - Write a query that selects each customer’s smallest order.
select Orders.CNUM, Customers.CNAME, MIN(AMT) as 'Smallest order of Customer'
from Customers
inner join Orders
on Customers.CNUM = Orders.CNUM
group by Orders.CNUM, Customers.CNAME

-- query 89 - Write a query that selects the first customer in alphabetical order whose name begins with G.
select MIN(CNAME)
from Customers
where CNAME LIKE 'G%'

-- query 90 - Write a query that counts the number of different nonNULL city values in the Customers table.
select COUNT(distinct CITY) as 'Number of different nonNULL city values in the Customers table'
from Customers
where CITY <> 'NULL'

-- query 91 - Find the average amount from the Orders table.
select AVG(AMT) as 'Average amount'
from Orders

-- query 92 - What would be the output from the following query?
SELECT * FROM ORDERS 
WHERE NOT (odate = '10/03/96' OR snum > 1006) AND amt >= 1500;

-- This query gives the order details for 3rd October and all order details for Salespeople who have SNUM > 1006 excluding the details for any amount less than 1500

-- query 93 - Find all customers who are not located in San Jose and whose rating is above 200.
select * from Customers
where CITY<>'San Jose' and RATING>200

-- query 94 - Give a simpler way to write this query :
-- SELECT snum, sname city, comm FROM salespeople
-- WHERE (comm > + 0.12 OR comm < 0.14);

select SNUM, SNAME, CITY, COMM from Salespeople

-- query 95 - Evaluate the following query : (** NOT COMPLETED **)
SELECT * FROM orders 
WHERE NOT ((odate = '10/03/96' AND snum > 1002) OR amt > 2000.00);

-- query 96 - Which salespersons attend to customers not in the city they have been assigned to?
select distinct Salespeople.SNUM, Salespeople.SNAME 
from Salespeople
inner join Customers
on Salespeople.SNUM = Customers.SNUM
where Salespeople.CITY <> Customers.CITY

-- query 97 - Which salespeople get commission greater than 0.11 are serving customers rated less than 250?
select distinct Salespeople.SNUM, Salespeople.SNAME, Salespeople.COMM
from Salespeople
inner join Customers
on Salespeople.SNUM = Customers.SNUM
where Customers.RATING < 250 and Salespeople.COMM>0.11

-- query 98 - Which salespeople have been assigned to the same city but get different commission percentages?
select distinct A.SNUM, A.SNAME, A.CITY
from Salespeople A, Salespeople B
where A.CITY = B.CITY and A.COMM<>B.COMM

-- query 99 - Which salesperson has earned the most by way of commission?
select TOP 1 SUM(Salespeople.COMM * Orders.AMT) as 'Commission earning', Salespeople.SNUM, Salespeople.SNAME 
from Salespeople 
inner join Orders 
on Salespeople.SNUM = Orders.SNUM 
group by Salespeople.SNUM, Salespeople.SNAME 
order by 'Commission earning' desc

-- query 100 - Does the customer who has placed the maximum number of orders have the maximum rating?
-- (*** NOT COMPLETED ***)

-- query 101 - 

-- query 102 - List all customers in descending order of customer rating.
select * from Customers 
order by RATING desc

-- query 103 - On which days has Hoffman placed orders?
select ODATE from Orders
inner join Customers
on Customers.CNUM = Orders.CNUM
where Customers.CNAME = 'Hoffman'

-- query 104 - Do all salespeople have different commissions?
if (select count(distinct COMM) from Salespeople) = (select count(COMM) from Salespeople)
BEGIN
select 'YES' as 'Do all salespeople have different commissions?'
END
else 
BEGIN
select 'NO' as 'Do all salespeople have different commissions?'
END

-- query 105 - Which salespeople have no orders between 10/03/1996 and 10/05/1996?
select * from Salespeople
where SNUM not in (select distinct SNUM from Orders where ODATE='10/03/1996' or ODATE ='10/03/1996' or ODATE='10/03/1996')

-- query 106 - How many salespersons have succeeded in getting orders?
select count(distinct SNUM) as 'Number of salespersons who succeeded in getting orders'
from Orders 

-- query 107 - How many customers have placed orders?
select count(distinct CNUM) as 'Number of customers that have placed orders'
from Orders

-- query 108 - On which date has each salesperson booked an order of maximum value?
select Salespeople.SNUM, Salespeople.SNAME, ODATE
from Orders 
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
where AMT in (select MAX(AMT) from Orders group by SNUM)
order by SNUM

-- query 109 - Who is the most successful salesperson?
select TOP 1 SUM(Salespeople.COMM * AMT) as 'Commission earned', Orders.SNUM, Salespeople.SNAME
from Salespeople
inner join Orders
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME
order by [Commission earned] desc

-- query 110 - Who is the worst customer with respect to the company?
select TOP 1 SUM(AMT) as 'Total AMT in orders', Customers.CNUM, Customers.CNAME, Customers.RATING from Orders
inner join Customers
on Customers.CNUM = Orders.CNUM
group by Customers.CNUM, Customers.CNAME, Customers.RATING
having Customers.CNUM in(select CNUM from Customers where RATING=(select MIN(Rating) from Customers))
order by [Total AMT in orders]

-- query 111 - Are all customers not having placed orders greater than 200 totally been serviced by salespersons Peel or Serres?
-- (*** NOT COMPLETED ***)
if (select distinct CNUM from Orders where AMT<200) = (select distinct CNUM from Customers where SNUM in (select SNUM from Salespeople where SNAME = 'Peel' or SNAME ='Serres'))
BEGIN
select 'YES'
END
else
BEGIN
select 'NO'
END

-- query 112 - Which customers have the same rating?
select CNUM, CNAME, RATING 
from Customers
order by RATING

-- query 113 - Find all orders greater than the average for October 4th
select * from Orders
where AMT > (select AVG(AMT) from Orders where ODATE='10/04/1996') 

-- query 114 - Which customers have above average orders?
select Customers.CNUM, Customers.CNAME, Customers.RATING, Customers.CITY, Orders.AMT from Orders 
inner join Customers
on Customers.CNUM = Orders.CNUM
where AMT > (select AVG(AMT) from Orders)

-- query 115 - List all customers with ratings above San Jose’s average.
select * from Customers
where RATING>(select AVG(RATING) from Customers where CITY = 'San Jose')

-- query 116 - Select the total amount in orders for each salesperson for whom the total is greater than the amount of the largest order in the table.
select Salespeople.SNAME, Orders.SNUM, SUM(AMT) as 'Total Amount in Orders for each salesperson'  
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME
having SUM(AMT)>(select MAX(AMT) from Orders)

-- query 117 - Give names and numbers of all salespersons who have more than one customer.
select Salespeople.SNUM, Salespeople.SNAME from Salespeople
inner join Customers
on Customers.SNUM = Salespeople.SNUM
group by Salespeople.SNUM, Salespeople.SNAME
having count(Salespeople.SNUM)>1

-- query 118 - Select all salespersons by name and number who have customers in their city whom they don’t service
select distinct Salespeople.SNAME, Salespeople.SNUM
from Salespeople
inner join Customers
on Salespeople.CITY = Customers.CITY
where Salespeople.SNUM <> Customers.SNUM

-- query 119 - Which customers rating should be lowered?
-- (** NOT COMPLETED **)

-- query 120 - Is there a case for assigning a salesperson to Berlin?
if (select COUNT(SNUM) as 'Number of Customers in Berlin' from Customers where CITY = 'Berlin')>=1
BEGIN
select 'YES' as 'Is there a case for assigning a salesperson to Berlin?'
END
else
BEGIN 
select 'NO' as 'Is there a case for assigning a salesperson to Berlin?'
END

-- query 121 - Is there any evidence linking the performance of a salesperson to the commission that he or she is being paid?
select Salespeople.SNUM, SUM(AMT) as 'Sum of AMT of Orders taken by each Salesperson', Salespeople.COMM
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Salespeople.SNUM, Salespeople.COMM

--query 122 - Does the total amount in orders by customer in Rome and London exceed the commission paid to salespersons 
-- in London and New York by more than 5 times?
if (select SUM(AMT) from Orders inner join Customers on Customers.CNUM = Orders.CNUM where CITY = 'Rome' or CITY = 'London') > 5*(select SUM(COMM * AMT) from Orders inner join Salespeople on Salespeople.SNUM = Orders.SNUM where CITY = 'London' or CITY = 'New York')
BEGIN
select 'YES' as 'Does total amt in orders by customer in Rome,London exceed commission of salespersons in London,New York by more than 5 times?'
END
else 
BEGIN
select 'NO' as 'Does total amt in orders by customer in Rome,London exceed commission of salespersons in London,New York by more than 5 times?'
END

-- query 123 - Which is the date, order number, amt and city for each salesperson (by name) for the maximum order he has obtained? (INCOMPLETE)
select MAX(AMT)as 'Maximum amt in Orders', Orders.SNUM from Salespeople
inner join Orders 
on Orders.SNUM = Salespeople.SNUM
group by Orders.SNUM

-- query 124 - Which salesperson(s) should be fired?
select SNUM, SNAME from Salespeople
where SNUM not in (select distinct SNUM from Orders)

-- query 125 - What is the total income for the company
select SUM(AMT) - SUM(COMM * AMT) as 'Total income for the company' from Salespeople
inner join Orders
on Salespeople.SNUM = Orders.SNUM
