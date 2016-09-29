--1. Get the cities of agents booking an order for a customer whose cid is 'c006'.

select distinct city
from agents
where aid in (select aid
              from orders
			  where cid = 'c006'
             );

--2. Get the ids of products ordered through any agent who takes at least one order from a customer 
--	 in Kyoto, sorted by pid from highest to lowest. (This is not the same as asking for ids of 
--products ordered by customers in Kyoto.)
                                                      
select pid
from orders 
where aid in (select aid
			  from orders
			  where cid in (select cid
	   						from customers
	   						where city = 'Kyoto'
                           )
              )
order by pid DESC;

--3. Get the ids and names of customers who did not place an order through agent a03.                                                  
 
select cid, name
from customers
where cid in (select cid
			  from orders
			  where aid != 'a03'
             );                                                       

--4. Get the ids of customers who ordered both product p01 and p07.

select cid
from orders
where pid = 'p01'
	intersect
select cid
from orders
where pid = 'p07';

--5. Get the ids of products not ordered by any customers who placed any order through agent 
--a08 in pid order from highest to lowest.

select pid
from orders
where cid not in (select cid
			   from orders
			   where aid = 'a08'
              )
order by pid DESC;

--6. Get the name, discounts, and city for all customers who place orders through agents in 
--Dallas or New York.

select name, discount, city
from customers
where cid in (select cid
			  from orders
			  where aid in (select aid
			  				from agents
			  				where city = 'Dallas' OR city = 'New York'
                           )
             );
             
--7. Get all customers who have the same discount as that of any customers in Dallas or London

select discount
from customers
where city = 'Dallas' or 'London'
	intersect
select *
from customers

--8. Check constraints specifies a requirement that must be met by each row in a datbase table. Check constraints 
--are expressed through predicates. It can refer to a single column or mutiple columns. The result of the 
--predicates can be true, false, and unknown if the value is null. One such applications of check constraints
--is to avoid negative values in columns that contextually do not use negatives. A bad such example of using
--check constraints include setting a maximum on price or having restraints that rely on incmplete data or other 
--tables. Check constraints are usally used to ensure the validity of data in a database and provide data 
--integrity. It used with applications that use the database in order to maintain valid data even though the 
--applications allow invalid data.
