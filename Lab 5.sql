--1. Show the cities of agents booking an order for a customer whose id is 'c006'. Use joins 
--this time; no subqueries. 

select distinct Agents.city
from agents join orders on agents.aid=orders.aid
where orders.cid='c006';

--2. Show the ids of products ordered through any agent who makes at least one order for a 
--customer in Kyoto, sorted by pid from highest to lowest. Use joins; no subqueries.

select distinct b.pid
from orders a full outer join orders b on a.aid = b.aid, customers c
where c.cid = a.cid and c.city = 'Kyoto'
order by b.pid;

--3. Show the names of customers who have never placed an order. Use a subquery.

select distinct name
from customers
where cid not in(select orders.cid
             	 from orders join customers on orders.cid=customers.cid);
             
--4. Show the names of customers who have never placed an order. Use an outer join.

select distinct name
from customers left outer join orders on customers.cid=orders.cid
where orders.cid is null;

--5.Show the names of customers who placed at least one order through an agent in their own city, 
--along with those agent/s names.

select distinct customers.name,agents.name
from customers, agents, orders
where customers.city=agents.city
AND customers.cid=orders.cid
AND orders.aid=agents.aid;

--6.Show the names of customers and agents living in the same city, along with the name of the 
--shared city, regardless of whether or not the customer has ever placed an order with that agent.

select customers.name, customers.city,agents.name
from customers join agents on customers.city=agents.city;

--7. Show the name and city of customers who live in the city that makes the fewest different 
--kinds of products. (Hint: Use count and group by on the Products table.)

select distinct customers.name, customers.city
from customers 
where customers.city in(select city
                        from products
                        group by products.city
                        order by count(quantity)
                       	fetch first 1 row only);
                        