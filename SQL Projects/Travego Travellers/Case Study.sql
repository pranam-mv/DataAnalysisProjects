-- How many female passengers traveled a minimum distance of 600 KMs?  
select count(Passenger_name) from passenger where gender ="F" and distance >= 600;

-- Write a query to display the passenger details whose travel distance is greater than 500 and who are traveling in a sleeper bus
select * from passenger where Distance > 500 and Bus_Type="sleeper";

-- Select passenger names whose names start with the character 'S'
select Passenger_name from passenger where Passenger_name like "S%";

-- Calculate the price charged for each passenger,displaying the Passengername,BoardingCity,DestinationCity,Bustype,and Price in the output.
select passenger.Passenger_name,
passenger.Boarding_City,
passenger.Destination_City,
passenger.Bus_type,
price.Price 
from passenger
join price
on passenger.Passenger_id=price.id;

-- What are the passenger name(s)and the ticket price for those who traveled 1000 KMs Sitting in a bus?
select passenger.Passenger_name,price.price from passenger
join price
on passenger.Passenger_id=price.id
where price.distance>=1000 and price.Bus_type="sitting";
-- 
select * from price where distance >=1000 and bus_type="sitting";

-- What will be the Sitting and Sleeperbus charge for Pallavi to travel from Bangalore to Panaji
select passenger.Passenger_name,
passenger.Boarding_City,
passenger.Destination_city,
price.price
from passenger
join price
on passenger.Passenger_id=price.id
where passenger.Passenger_name="pallavi" and 
passenger.Boarding_City="panaji" and 
passenger.Destination_city="Bengaluru";


-- Alter the column category with the value "Non-AC" where the Bus_Type is sleeper
update passenger 
set category="NAC"
where bus_type="sleeper";

-- Delete an entry from the table where the passenger name is Piyush and commit this change in the database.
SET autocommit = 0;

delete from passenger
where Passenger_name="piyush";

commit;

-- Truncate the table passenger and comment on the number of rows in the table
truncate table passenger;

-- Delete the table passenger from the database
drop table passenger;


