USE classicmodels;

## Simple select statement ---------------------

SELECT * FROM employees; -- returns all the rows and columns of Employees table
SELECT firstName, lastName, Email FROM employees; -- returns only the named colums of Employees table
SELECT firstName AS 'First Name', LASTNAME AS 'Last Name', Email FROM employees; -- returns only the named colums of Employees table. Created an alias for field name
SELECT T1.firstName, T1.lastName FROM employees AS T1; -- creating an alias "T1" of the table. 

# Q. Display only the unique values from the column reportsto. (7 rows)
SELECT DISTINCT reportsTo  FROM employees; -- shows distinct values of a column

# Q. Display the number of records in the employees table. 
SELECT COUNT(*) FROM employees; -- counts the number of records in a table.

## ORDER BY Clause ------------------------------

# Q. Display all the rows and columns of employees table, sort the records in increasing order based on Firstname. (23 rows)
SELECT * FROM employees ORDER BY firstName; -- returns all the rows and columns of Employees table sorted in ascending order by first name (defalut order)
SELECT * FROM employees ORDER BY firstName DESC; -- returns all the rows and columns of Employees table sorted in descending order by first name 

# Q. Display all the records from employees table, sort the records in decreasing order based on officecode and increasing order based on reportsto (23 rows)
SELECT * FROM employees ORDER BY officeCode DESC, reportsTo; -- sort on more than one column. Desc on officeCode and ascending on reportsTo

## Filtering data -------------------------------

# Q. Display all the records from employees table where officecode is 1. (6 rows)
SELECT * FROM employees WHERE officeCode = 1; -- returns all the rows where officeCode is set to 1. We can also use operators like <> or !=, <, >, <= and >= 

# Q. Display the records where jobtitle belongs to the sales department. (19 rows)
SELECT * FROM employees WHERE jobTitle LIKE 'Sales%'; -- using LIKE operator with wildcard %, means 0 or more characters.

# Q. Display the records where jobtitle starts with letter 's' and ends with 'p' (17 rows)
SELECT * FROM employees WHERE jobTitle LIKE 's%p'; -- using LIKE operator with wildcard %, means 0 or more characters.
SELECT * FROM employees WHERE jobTitle LIKE 'Sale_ R%'; -- using LIKE operator with wildcard _, exactly one character

# Q. Display the records where officeode must be greater than 1 and reportsto as '1102' (6 rows)
SELECT * FROM employees WHERE officeCode > 1 AND reportsTo = 1102; -- multiple conditions. "AND" - both conditions must be true

# Q. Display those records where officecode greater than 1 or reports as '1102' (17 rows)
SELECT * FROM employees WHERE officeCode > 1 OR reportsTo = 1102; -- multiple conditions. "OR" - either one of the condition is TRUE

# Order Table::-
# Q. Display the records from orders table where status is 'shipped' or 'In process' and sort the records in increasing order based on customer number. (309 rows)
SELECT * FROM orders WHERE (status = 'Shipped' OR status = 'In Process') order by customerNumber;

# Q. Display the records where status must be 'shipped' or 'In process' and customernumber as 119. (4 rows)
SELECT * FROM orders WHERE (status = 'Shipped' OR status = 'In Process') AND customerNumber = 119; -- Combining OR and AND in where clause
SELECT * FROM orders WHERE status in('Shipped', 'In Process') AND customerNumber = 119; -- Combining OR and AND in where clause. Along with in()

## Customers table::-
# Q. Display the records from customers table expect the records where the country is like 'France' and 'Norway' and creditlimit is lesser than 1000000 (23 rows)
SELECT * FROM customers WHERE country NOT IN ('France', 'Norway') AND creditLimit > 100000; -- using NOT with IN

# Q. Display the records from employees table where officode is between 1 and 3.
SELECT * FROM employees WHERE officeCode BETWEEN 1 AND 3; -- using a range to filter data 
SELECT * FROM employees WHERE officeCode IN (1, 2, 3); -- same as above

# Q. Display the empolyees records where officecode is missing.
SELECT * FROM employees WHERE officeCode IS NULL; -- Check for NULL value. Note we use IS NULL and not "= NULL"

# Q. Display the customers details where country like 'Spain' and "Australia' sort the records in increasing order and display only 5 rows starting from the second rows.
SELECT * FROM customers WHERE country in ('Spain','Australia') ORDER BY country LIMIT 2, 5; -- Limits the number of rows to return using LIMIT. 2-refers to the starting row. 5-refers to count of rows to display


# Grouping Data ---------------------------
# GROPU BY is used to create summary rows by values of columns or expressions.
# Each group returns one row, thus reduces the number of rows in rowset.
# This is generally used along with aggregate functions list SUM, AVG, MAX, MIN and COUNT.
# This clause appears after the WHERE clause.

SELECT reportsTo FROM employees GROUP BY reportsTo; 

# Q. Display the count of orders against each customer from orders table. (98 rows)
SELECT customerNumber, count(orderNumber) FROM orders GROUP BY customerNumber; -- returns the count of orders against each customer. Note, the column name in the select statement should be mentioned along with the GROUP BY clause
# SELECT customerNumber, status, count(orderNumber) FROM orders GROUP BY customerNumber, status; -- using multiple columns in GROUP BY clause 

# Q. Display the count of orders against each customer and for each status from orders table where status is like 'shipped' and 'In process' (104 rows)
SELECT customerNumber, status, count(orderNumber) FROM orders WHERE status IN('Shipped', 'In Process') GROUP BY customerNumber, status; -- using WHERE clause to limit status

# Q. Display the count of orders against each customer and for each status from orders table where status is like 'shipped' and 'In process', also sort the customernumber in ascending order. (104 rows)
SELECT customerNumber, status, count(orderNumber) FROM orders WHERE status IN('Shipped', 'In Process') GROUP BY customerNumber, status ORDER BY customerNumber, status; -- using everthing we have learnt
#SELECT customerNumber, status, count(orderNumber) FROM orders WHERE status IN('Cancelled', 'On Hold', 'Disputed') GROUP BY customerNumber, status ORDER BY customerNumber, status; -- using everthing we have learnt


# HAVING Clause ----------------
# Generally used along with GROUP BY clause to filter rows retuned by a GROUP BY clause
# Can also use HAVING clause to specify a filter on the SELECT statement when used without a GROUP BY clause

SELECT * FROM employees HAVING officeCode = 1; -- use HAVING just like a WHERE clause

# Q. Display the sum of the amount as 'Total Payout' for each customer where sum of amount should be greater than 125000, also sort the sum of amount in decreasing order. (12 rows)
SELECT customerNumber, sum(amount) AS 'Total Payout' FROM payments GROUP BY customerNumber HAVING sum(amount) > 125000 ORDER BY sum(amount) DESC;


## JOINING Tables. ----------------------------
# In RDBMS data, is stored in multiple related tables
# These tables are related via common keys (foreign keys)
# In order to fetch information from these tables joins are required to pull the data from these tables collectively
# A join a way of linking two tables using the value stored in the common columns of the tables

## INNER Join - It checks each row of first table against all the rows of the second table and returns a result when the common columns of both tables have same value

# Q. Display customername, checknumber, paymentdate, and amount from customers and payments tables. (273 rows)
SELECT c1.customerName, p1.checkNumber, p1.paymentDate, p1.amount FROM customers c1 INNER JOIN payments p1 ON c1.customerNumber = p1.customerNumber;
SELECT c1.customerName, p1.checkNumber, p1.paymentDate, p1.amount FROM customers c1, payments p1 WHERE c1.customerNumber = p1.customerNumber; -- Same as above. WHERE clause causes INNER join

SELECT c1.customerName, p1.checkNumber, p1.paymentDate, p1.amount FROM customers c1 INNER JOIN payments p1 ON c1.customerNumber = p1.customerNumber WHERE p1.customerNumber = 103; -- using both
SELECT c1.customerName, p1.checkNumber, p1.paymentDate, p1.amount FROM customers c1, payments p1 WHERE c1.customerNumber = p1.customerNumber AND p1.customerNumber = 103; -- Same as above.

## LEFT Join - In a left join, table on the left returns all the rows and the table on right returns rows when the common columns of both tables have same value. NULL is returned for unmatching rows

# Q. Perform left join on the tables offices and employees.
SELECT * FROM offices o LEFT JOIN employees e ON o.officeCode = e.officeCode;
SELECT * FROM offices o LEFT JOIN employees e USING (officeCode); -- same as above

SELECT * FROM offices o LEFT JOIN employees e USING (officeCode) WHERE o.officeCode = 1; -- Show data only for the officeCode=1
SELECT * FROM offices o LEFT JOIN employees e ON o.officeCode = e.officeCode WHERE o.officeCode = 1; -- same as above

## Right Join - In a right join, table on the right returns all the rows and the table on left returns rows when the common columns of both tables have same value. NULL is returned for unmatching rows

# Q. Perform right join on the tables customers and employees.
SELECT * FROM customers c RIGHT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;
#The above will return a result set where all the employee records are returned. For employees with no associated customer the resultset will have NULL values
SELECT * FROM customers c RIGHT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber WHERE c.customerName IS NULL;
# The above will return resultset of first query and then apply the WHERE clause on top of this resultset

## CROSS Join - 
# This returns a cartesian product of the two tables. If table#1 has m rows and table#2 has n rows, then the cross join will return m*n rows.
# If we apply a Where clause with cross join, then it works as an INNER join

SELECT count(*) from employees;
SELECT count(*) from customers;
select count(*) from employees, customers;

## SELF Join
# A self join is done to either compare a row with another row or to compare the hierarchal data
# When a self join is done, the table is aliased so as to provide a distinction to the two references of a table
Select * from employees;
SELECT e1.employeeNumber, e1.firstName AS Manager, e2.firstName AS team, e2.employeeNumber FROM employees e1, employees e2 WHERE e2.reportsTo = e1.employeeNumber;
SELECT e1.employeeNumber, e1.firstName AS Manager, e2.firstName AS team, e2.employeeNumber FROM employees e1 LEFT JOIN employees e2 ON e2.reportsTo = e1.employeeNumber; -- How this is differnt from above




































































