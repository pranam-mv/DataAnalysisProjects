
## SQL Revision Session - DAY 2 

## Subquery and Window Functions :::::--------------------


# Subquery
# Sub Query / Inner Query
# Sub Query / Inner Query
# Sub query is a query which is nested in another query
# In MySQL it is called inner query
# It can be used along with the FROM and WHERE clause

-- Q1 -- select first_name,last_name whose department_name is accounting;
select first_name,last_name,department_name 
from employees e join departments d 
on e.department_id=d.department_id
where department_name = 'accounting';                                                                           ## JOINS APPROACH

select first_name,last_name from employees where
department_id=(select department_id from departments where department_name='accounting');                       ## SUBQUERY APPROACH 
## (subquery in where clause we can select only one column )
-- when are we only going to filter out the data from another table not display we can use subquery (uses less memeory)
-- when are we want to filter and also display the data from another table we use join;


-- Q2 -- display the names of the employees who work in the department where neena works;
select first_name,last_name from employees where
department_id=(select department_id from employees where first_name='neena');
																											   -- (like this subquery is called as independent subquery)
-- Q3 -- display the name of the employees working in accounts and finance departments;
select first_name,last_name from employees where
department_id in (select department_id from departments where department_name in ('accounts','finance'));     --- USING ##### IN 

-- Q4 -- to display the names of the employees whose salary is less than the salaries of all the people working in department 60.
select first_name,last_name,salary from employees where
salary < all (select salary from employees where department_id = 60);      

-- Q5 to list the names of the employees working in seattle. 
select * from locations;
select * from employees;
select * from departments;

select first_name,last_name from employees where 
department_id in (select department_id from departments where location_id=(select location_id from locations where city='seattle'));      -- NESTED SUBQUEIERS::_

-- Q6 to display the names of the employees who work in same department as 'gerald' and have the same designation as him:
select first_name,last_name from employees where
department_id=(select department_id from employees where first_name='gerald') and
job_id=(select job_id from employees where first_name='gerald');     


-- Q7 scenario:
-- A ecommerce site is planning for a campaign to convert its prospect customers to customers. hence, the team needs the list of such prospect customers
-- who have registered to the site but not placed an order. generate such list.
select * from customers;
select * from orders;
select customernumber,customername from customers where customernumber not in (select ordernumber from orders);



# Windows functions - Over(), along with "partition by", "order by" and from clause ----------------------

-- Write a query to fetch the number of orders placed by each customer.
select *, count(orderNumber) as "Order Count" from orders group by customerNumber order by customerNumber;  -- group by {based on customernumber, it will be show the customer groups} 
select *, count(orderNumber) OVER(partition by customerNumber) as "Order Count" from orders; -- window function {based on customernumber, it will just return the count for that customer group}

-- Write a query to fetch the order details for each customer
/*
such as, 
	i. The total number of orders made by each customer.
	ii. The total bill amount for each order.
	iii. The total number of items in each order.
	iv. The total value of all orders for each customer.
	v. The minimum order value for each customer.
	vi. The maximum order value for each customer.
*/
select
	 o.*, 
    count(o.orderNumber) OVER(partition by o.customerNumber) as "Order Count", 
    sum(od.quantityOrdered * od.priceEach) as Bill_Amount, 
	count(od.orderNumber) as Items, 
    sum(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Total_Orders_Value",
	min(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Min_Order_value",
	max(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Max_Order_value"
from orders o, orderdetails od
Where o.orderNumber = od.OrderNumber
group by orderNumber
order by customerNumber, OrderNumber; 

-- Write a query to fetch the creditlimit for each customer
/*
such as
	i. The customer number
	ii. The customer name
    iii. The credit limit for each customer with a credit limit greater than 0
    iv. The credit limits of the next and previous customers in the list ordered by credit limit
    v. The credit limits of the first and last customers in the ordered list

# Value functions lead(), lag(), first_value(), last_value()
*/ 
select 
	customerNumber, 
	CustomerName, 
    creditlimit, 
	lead(creditlimit) Over() as CL_Lead, 
	lag(creditlimit) Over() as CL_Lag, 
	first_value(creditlimit) over() as CL_First_value,
	last_value(creditlimit) over() as CL_Last_value
from customers 
where creditlimit > 0 
order by creditlimit;

-- Write a query to illustrate the statistics for each order
/*
such as, 
	i. The total number of orders made by each customer.
	ii. The total bill amount for each order.
	iii. The total number of items in each order.
	iv. The total value of all orders for each customer.
	v. The minimum order value for each customer.
	vi. The maximum order value for each customer.
	vii. The row number for each order within its customer partition.
	viii. The rank of each order based on the total bill amount.
	ix. The dense rank of each order based on the total bill amount.
	x. The percent rank of each order based on the total bill amount.
	xi. The cumulative distribution of each order based on the total bill amount.
	xii. The order percentile (dividing the orders into 20 equal percentiles).
    
# Ranking function Rank(), dense_rank(), percent_rank(), cume_dist() and ntile()
*/
select 
	o.*, 
	count(o.orderNumber) OVER(partition by o.customerNumber) as "Order Count", 
    sum(od.quantityOrdered * od.priceEach) as Bill_Amount, 
	count(od.orderNumber) as Items, 
    sum(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Total_Orders_Value",
	min(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Min_Order_value",
	max(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Max_Order_value", 
	row_number() over(partition by CustomerNumber) as "Row_Count",
	rank() over(order by sum(od.quantityOrdered * od.priceEach)) as Order_Rank,
	dense_rank() over(order by sum(od.quantityOrdered * od.priceEach)) as Order_Dense_Rank,
	percent_rank() over(order by sum(od.quantityOrdered * od.priceEach)) as Order_Precent_Rank,
	cume_dist() over(order by sum(od.quantityOrdered * od.priceEach)) as Cumulative_distance,
	ntile(20) over(order by sum(od.quantityOrdered * od.priceEach)) as Order_Percentile
from orders o, orderdetails od
Where o.orderNumber = od.OrderNumber
group by orderNumber
order by customerNumber, OrderDate; 

-- Write a query to retrieve order and order detail information, 
-- along with various aggregated metrics such as order count, bill amount, total order value, minimum and maximum order values, row count, 
-- and various ranking measures (order rank, dense rank, percent rank, cumulative distance, and percentile) 
-- for each customer and order, sorted by customer number and order date?
/*
such as 
	i. "Order Count": The number of orders for each customer.
	ii. "Bill_Amount": The total bill amount for each order.
	iii. "Items": The number of items in each order.
	iv. "Total_Orders_Value": The sum of bill amounts for all orders of each customer.
	v. "Min_Order_value": The minimum bill amount for each customer's orders.
	vi. "Max_Order_value": The maximum bill amount for each customer's orders.
	vii. "Row_Count": A unique row number within each customer's orders.
	viii. "Order_Rank": The rank of each order based on the bill amount.
	ix. "Order_Dense_Rank": The dense rank of each order based on the bill amount.
	x. "Order_Precent_Rank": The percent rank of each order based on the bill amount, relative to the customer number.
	xi. "Cumulative_distance": The cumulative distribution of the bill amount for each order.
	xii. "Order_Percentile": The order percentile using the NTILE function, with a single group in this case.
*/
select 
	o.*, 
    count(o.orderNumber) OVER(partition by o.customerNumber) as "Order Count", 
    sum(od.quantityOrdered * od.priceEach) as Bill_Amount, 
	count(od.orderNumber) as Items, sum(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Total_Orders_Value",
	min(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Min_Order_value",
	max(od.quantityOrdered * od.priceEach) Over(partition by CustomerNumber) as "Max_Order_value", 
	row_number() over(partition by CustomerNumber) as "Row_Count",
	rank() over(order by sum(od.quantityOrdered * od.priceEach)) as Order_Rank,
	dense_rank() over(order by sum(od.quantityOrdered * od.priceEach)) as Order_Dense_Rank,
	percent_rank() over(order by customerNumber, sum(od.quantityOrdered * od.priceEach)) as Order_Precent_Rank,
	cume_dist() over(order by sum(od.quantityOrdered * od.priceEach)) as Cumulative_distance,
	ntile(1) over(order by sum(od.quantityOrdered * od.priceEach)) as Order_Percentile
from orders o, orderdetails od
Where o.orderNumber = od.OrderNumber
group by customerNumber, orderNumber
order by customerNumber, OrderDate;

-- Write a query to fetch a list of customers with their credit limits, 
-- along with their respective rank, dense rank, percent rank, and cumulative distribution, 
-- for customers with a credit limit greater than zero, ordered by credit limit?
select 
	customerNumber, 
    CustomerName, 
    creditlimit, 
	rank() over(order by creditLimit) as CL_Rank,
	dense_rank() over(order by creditLimit) as CL_Dense_Rank,
	percent_rank() over(order by creditLimit) as CL_Precent_Rank,
	cume_dist() over(order by creditLimit) as Cumulative_distance
from customers c 
Where creditLimit > 0 
order by creditLimit;




