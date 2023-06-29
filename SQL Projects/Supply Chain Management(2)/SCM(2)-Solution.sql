-- ///////////////////////////////////////////////////////////////////// --

### PART C::: 


-- 1.	Fetch the records to display the customer details who ordered more than 10 products in the single order
select c.firstname,c.lastname,sum(oi.Quantity) 
from customer c
join orders o
on c.id = o.CustomerId
join orderitem oi
on o.id = oi.OrderId
group by orderid having sum(oi.Quantity)>10;

-- 2.	Display all the product details with the ordered quantity size as 1.
select p.id,p.productname,o.quantity 
from product p
join orderitem o on p.id=o.ProductId
where o.Quantity=1;


-- 3.	Display the compan(y)ies which supplies products whose cost is above 100.
select s.companyname,p.productname,p.unitprice
from supplier s
join product p
on s.id = p.SupplierId
where p.UnitPrice>100;


-- 4.	Create a combined list to display customers and supplier list as per the below format.
 select 'customer' as type,concat(firstname,lastname) as name,city,country,phone from customer c
 union
 select 'supplier' as type,concat(companyname,contactname) as name,city,country,phone from supplier s;

-- 5.	Display the customer list who belongs to same city and country arrange in country wise.
select * from customer a join customer b where a.Country=b.Country and a.City=b.City order by a.country;


### PART D:::

-- 1.	Company sells the product at different discounted rates. Refer actual product price in product table and selling price in the order item table.
--  Write a query to find out total amount saved in each order then display the orders from highest to lowest amount saved. 
select oi.orderid,(p.unitprice-oi.unitprice) as discount_rate 
from orderitem oi 
join product p
on oi.ProductId = p.Id
group by ProductId
order by OrderId;

select oi.orderid,(p.unitprice-oi.unitprice) as discount_rate 
from orderitem oi 
join product p
on oi.ProductId = p.Id
group by orderid
order by discount_rate desc;


-- 2.	Mr. Kavin want to become a supplier. He got the database of "Richard's Supply" for reference. Help him to pick: 
-- a. List few products that he should choose based on demand.
-- b. Who will be the competitors for him for the products suggested in above questions.
select p.id,p.productname,sum(oi.quantity) 
from product p
join orderitem oi
on p.id = oi.ProductId 
group by ProductId
order by sum(oi.Quantity) desc limit 3;

## B)
select s.id,s.companyname, p.id,p.ProductName, sum(oi.quantity)
from supplier s join product p on s.id=p.supplierid join orderitem oi on p.id=oi.productid
group by productid order by sum(oi.Quantity) desc limit 3;



-- 3.	Create a combined list to display customers and suppliers details considering the following criteria 
-- •	Both customer and supplier belong to the same country
-- •	Customer who does not have supplier in their country
-- •	Supplier who does not have customer in their country

select c.country,concat(firstname,lastname),c.city,c.phone,companyname,contactname,s.city,s.phone,s.country
from customer c join supplier s using(country)
union 
select c.country,concat(firstname,lastname),c.city,c.phone,companyname,contactname,s.city,s.phone,s.country
from supplier s right outer join customer c using(country)

-- 4.	Every supplier supplies specific products to the customers. 
-- Create a view of suppliers and total sales made by their products and write a query on this view to find out top 2 suppliers 
-- (using windows function RANK() in each country by total sales done by the products.
create view suppliers
as
select s.companyname,p.id,sum(oi.unitprice*oi.quantity) as total_sales,city,country
from supplier s
join product p
on s.id = p.supplierid
join orderitem oi
on p.id = oi.productid 
group by s.companyname 
order by total_sales desc;

select * from suppliers;
select * from (select companyname,country,
                    dense_rank() over (partition by country order by total_sales ) as rank_a
                    from suppliers)a where rank_a<3;


