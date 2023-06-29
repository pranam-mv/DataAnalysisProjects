create database travellers;
use travellers;
CREATE TABLE passenger (
  Passenger_id INT PRIMARY KEY,
  Passenger_name VARCHAR(20),
  Category VARCHAR(20),
  Gender VARCHAR(20),
  Boarding_City VARCHAR(20),
  Destination_city VARCHAR(20),
  Distance INT,
  Bus_Type VARCHAR(20)
);

CREATE TABLE price (
  id INT,
  Bus_Type VARCHAR(20),
  Distance INT,
  Price INT
);

INSERT INTO passenger values
(1, 'Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');

INSERT INTO passenger values
 (2, 'Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
 
INSERT INTO passenger values
(3, 'Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');

INSERT INTO passenger values
(4, 'Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');

INSERT INTO passenger values
(5, 'Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper');

INSERT INTO passenger values
(6, 'Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');

INSERT INTO passenger values
(7, 'Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper');

INSERT INTO passenger values
(8, 'Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');

INSERT INTO passenger values
(9, 'Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

INSERT INTO price
VALUES (1, 'Sleeper', 350, 770);

INSERT INTO price 
VALUES (2, 'Sleeper', 500, 1100);

INSERT INTO price 
VALUES (3, 'Sleeper', 600, 1320);

INSERT INTO price 
VALUES (4, 'Sleeper', 700, 1540);

INSERT INTO price 
VALUES (5, 'Sleeper', 1000, 2200);

INSERT INTO price 
VALUES (6, 'Sleeper', 1200, 2640);

INSERT INTO price 
VALUES (7, 'Sleeper', 1500, 2700);

INSERT INTO price 
VALUES (8, 'Sitting', 500, 620);

INSERT INTO price 
VALUES (9, 'Sitting', 601, 744);

INSERT INTO price 
VALUES (10, 'Sitting', 700, 868);

INSERT INTO price 
VALUES (11, 'Sitting', 1000, 1240);

INSERT INTO price 
VALUES (12, 'Sitting', 1200, 1488);

INSERT INTO price 
VALUES (13, 'Sitting', 1500, 1860);

select * from price;
select * from passenger;



