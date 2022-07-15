-- query 1 - List all the columns of the Salespeople table.
select COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Salespeople';

-- query 2 - List all customers with a rating of 100.
select * 
from Customers
where RATING=100;

-- query 3 - Find all records in the Customer table with NULL values in the city column.select *
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

-- query 6 - Find which salespeople currently have orders in the Orders table.select DISTINCT Salespeople.SNUM, Salespeople.SNAME, Salespeople.CITY
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
select SNUM, COUNT(SNUM)
from Orders
group by SNUM
order by COUNT(SNUM) desc;

select * from Orders

-- query 10 - List the Customer table if and only if one or more of the customers in the Customer table are located in San Jose. select * from Customerswhere (select count(CITY) from Customers where CITY='San Jose') >=1-- query 11 - Match salespeople to customers according to what city they lived in.select Salespeople.SNUM, Salespeople.SNAME, Customers.CNUM, Customers.CNAME, Salespeople.CITYfrom Salespeopleinner join Customerson Salespeople.CITY=Customers.CITY;-- query 12 - Find the largest order taken by each salesperson.select Salespeople.SNAME, Orders.SNUM, Max(AMT) as 'Largest order by Salesperson' 
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME-- query 13 - Find customers in San Jose who have a rating above 200.select * from Customerswhere CITY='San Jose' and RATING>200;-- query 14 - List the names and commissions of all salespeople in London.select SNAME, COMM, CITYfrom Salespeoplewhere CITY='London';-- query 15 - List all the orders of salesperson Motika from the Orders table.select * from Orderswhere SNUM in (select SNUM from Salespeople where SNAME='Motika');-- query 16 - Find all customers with orders on October 3.select * from Customerswhere CNUM in (select CNUM from Orders where ODATE='10/03/96');/* query 17 - Give the sums of the amounts from the Orders table, grouped by date, eliminating all those dates where the SUM was not at least 2000.00 above the MAX amount. */-- query for max amount of all datesselect SUM(AMT) as 'Sum of amount for particular date', ODATEfrom Ordersgroup by ODATEhaving SUM(AMT) > ((select MAX(AMT) from Orders)+2000);-- query for max amount of each dateselect SUM(AMT) as 'Sum of amount for particular date', ODATEfrom Ordersgroup by ODATEhaving ODATE in (select ODATE from Orders group by ODATE having SUM(AMT)>(MAX(AMT)+2000));-- query 18 -  Select all orders that had amounts that were greater than at least one of the orders from October 6.select * from Orderswhere AMT > (select MIN(AMT) from Orders where ODATE='10/06/96');-- query 19 - Write a query that uses the EXISTS operator to extract all salespeople who have customers with a rating of 300. select SNUM from Salespeoplewhere exists(select CNAME from Customers where Salespeople.SNUM = Customers.SNUM and RATING=300);
-- query 20 - Find all pairs of customers having the same rating.select A.CNUM as 'Person 1 CNUM', A.CNAME as 'Person 1 NAME', B.CNUM as 'Person 2 CNUM', B.CNAME as 'Person 2 NAME'
from Customers A, Customers B
where A.RATING = B.RATING and A.CNUM < B.CNUM;

-- query 21 - Find all customers whose CNUM is 1000 above the SNUM of Serres.
select * from Customers
where (CNUM-1000)>=(select SNUM from Salespeople where SNAME='Serres');

-- query 22 - Give the salespeople’s commissions as percentages instead of decimal numbers.
select CONCAT(CAST(CAST(COMM*100 as int) as varchar),'%')
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

-- query 29 - Find salespeople who have multiple customers.select * from Salespeoplewhere SNUM in (select SNUM from Customers group by SNUM having COUNT(SNUM)>1)-- query 30 - Find salespeople with customers located in their cityselect DISTINCT Salespeople.SNUM, Salespeople.SNAME, Customers.CNAME, Salespeople.CITY from Salespeopleinner join Customerson Salespeople.CITY=Customers.CITY-- query 31 - Find all salespeople whose name starts with ‘P’ and the fourth character is ‘l’select * from Salespeople where SNAME LIKE 'P__l%'-- query 32 - Write a query that uses a subquery to obtain all orders for the customer named Cisneros. Assume you do not know his customer number.-- using subqueryselect * from Orders where CNUM in (select CNUM from Customers where CNAME='Cisneros')-- using joinselect Orders.ODATE, Orders.AMT, Orders.ONUM, Orders.CNUM, Customers.CNAME from Ordersinner join Customerson Orders.CNUM = Customers.CNUMwhere Customers.CNAME = 'Cisneros'-- query 33 - Find the largest orders for Serres and Rifkinselect MAX(AMT) as 'largest orders', Orders.SNUM, Salespeople.SNAMEfrom Orders inner join Salespeopleon Salespeople.SNUM = Orders.SNUMgroup by Orders.SNUM, Salespeople.SNAMEhaving Salespeople.SNAME in ('Serres','Rifkin')-- query 34 - Extract the Salespeople table in the following order : SNUM, SNAME, COMMISSION, CITYselect SNUM, SNAME, COMM, CITYfrom Salespeople-- query 35 - Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.select * from Customerswhere CNAME LIKE '[a-g]%'-- query 36 - Select all the possible combinations of customers that you can assign.-- ** DID NOT UNDERSTAND THE QUESTION **-- query 37 - Select all orders that are greater than the average for October 4.select * from orders where AMT>(select AVG(AMT) from Orders where ODATE='10/04/96')/* query 38 - Write a select command using a corelated subquery that selects the names and numbers of all customers with ratings equal to the maximum for their city. */select CNAME, CNUM, CITYfrom Customerswhere CONCAT(CAST(RATING as varchar), CITY) in (select CONCAT(CAST(MAX(RATING) as varchar), CITY) from Customers group by CITY)-- query 39 - Write a query that totals the orders for each day and places the results in descending orderselect COUNT(ODATE) as 'Number of Orders', ODATEfrom Ordersgroup by ODATEorder by COUNT(ODATE) desc-- query 40 - Write a select command that produces the rating followed by the name of each customer in San Jose.select RATING, CNAME, CITYfrom Customers where CITY='San Jose'-- query 41 - Find all orders with amounts smaller than any amount for a customer in San Jose.select * from Orders where AMT < (select max(amt) from Orders where CNUM in(select CNUM from Customers where CITY='San Jose'))-- query 42 - Find all orders with above average amounts for their customers.select * from Orderswhere AMT>(select AVG(AMT) from Orders)-- query 43 - Write a query that selects the highest rating in each city.select MAX(RATING) as 'Highest Rating in City', CITY from Customers group by CITY-- query 44 - Write a query that calculates the amount of the salesperson’s commission on each order by a customer with a rating above 100.00select Orders.ONUM, Orders.AMT*Salespeople.COMM, Salespeople.SNUM from Salespeopleinner join Orderson Salespeople.SNUM = Orders.SNUM -- query 45 - Count the customers with ratings above San Jose’s average.select * from Customerswhere RATING > (select AVG(RATING) from Customers where CITY='San Jose')-- query 46 - Write a query that produces all pairs of salespeople with themselves as well as duplicate rows with the order reversedselect A.SNAME, B.SNAME 
from Salespeople A, Salespeople B

-- query 47 - Find all salespeople that are located in either Barcelona or London
select * from Salespeople
where CITY in ('Barcelona','London')

-- query 48 - Find all salespeople with only one customer.
select * from Salespeople 
where SNUM in (select SNUM from Customers group by SNUM having COUNT(SNUM)=1)

-- query 49 - Write a query that joins the Customer table to itself to find all pairs of customers served by a single salesperson. (duplicate rows with the order reversed)
select A.CNUM, B.CNUM 
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
select distinct A.CNUM, A.ONUM, B.ONUM
from Orders A, Orders B 
where A.CNUM = B.CNUM and A.ONUM <> B.ONUM

-- ** Name Part not done **

-- query 56 - Find only those customers whose ratings are higher than every customer in Rome
select * from Customers
where RATING>(select MAX(RATING) from Customers where CITY='Rome')

-- query 57 - Write a query on the Customers table whose output will exclude all customers with a rating <= 100.00, unless they are located in Rome.
select * from Customers 
where RATING>100 or CITY='Rome'

-- query 58 - Find all rows from the Customers table for which the salesperson number is 1001.select * from Customerswhere SNUM=1001-- query 59 - Find the total amount in Orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
select Salespeople.SNAME, Orders.SNUM, SUM(AMT) as 'Total Amount in Orders for each salesperson'  
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME
having SUM(AMT)>(select MAX(AMT) from Orders)

-- query 60 - Write a query that selects all orders save those with zeroes or NULLs in the amount field.
select * from Orders 
where CAST(AMT as varchar) not in ('NULL','0.00')