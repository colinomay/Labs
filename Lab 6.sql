--1. Display the name and city of customers who live in any city that makes the most different 
--kinds of products. (There are two cities that make the most different products. Return the 
--name and city of customers from either one of those.)

select name, city
from customers
where city in (select acity
               from (select a.city as acity, count(a.city)
                   	 from products a, products b
                     where a.pid=b.pid
                     group by a.city
                     having count(a.city) = (select max(maxQuantity)
                                             from (select count(city) as maxQuantity
                                                   from products
                                                   group by city
                                                   ) as maxProductCount
                                             )
                     ) as maxCities
               ); 

--2. Display the names of products whose priceUSD is strictly below the average priceUSD, in 
--reverse-alphabetical order.

select name
from products
where priceUSD < (select avg(priceUSD)
                  from products
                 )
order by name DESC;

--3. Display the customer name, pid ordered, and the total for all orders, sorted by total from low to high.

select c.name, o.pid, o.totalUSD
from customers c inner join orders o on c.cid=o.cid
order by totalUSD;

--4. Display all customer names (in alphabetical order) and their total ordered, and nothing more. 
--Use coalesce to avoid showing NULLs.

select name, coalesce(sum(qty),0) as total
from customers c left outer join orders o on c.cid=o.cid
group by name,city
order by name;

--5. Display the names of all customers who bought products from agents based in New York along with 
--the names of the products they ordered, and the names of the agents who sold it to them.

select c.name, p.name, a.name
from customers c, products p, agents a
where (cid,pid,aid) in (select cid, pid, aid
                        from orders
                        where aid in(select aid
                                     from agents
                                     where city='New York'
                                     )
                        );

--6. Write a query to check the accuracy of the dollars column in the Orders table. This means 
--calculating Orders.totalUSD from data in other tables and comparing those values to the values in 
--Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any.

select (o.qty * p.priceUSD * (1-(c.discount/100))) as calculated_total, o.totalUSD, o.qty, p.priceUSD, c.discount
from orders o inner join customers c on o.cid = c.cid
			  inner join products p on o.pid=p.pid 
              and o.totalUSD != (o.qty * p.priceUSD * (1-(c.discount/100)));

--7. First the point of outer join is to combine all rows from one table and combining it with any matching 
--rows from a second table. One does this by using left outer and right outer join. The syntax of outer join
--is "from 'table1' left/right outer join 'table2' on 'search condition'. Using left outer join specifies
--that 'table1' or the first table mentioned/the left as the one with all the rows and the second table 
--mentioned/the right as the one with matching rows. Oppositely right outer join specifies 'table2' or the 
--second table mentioned/the right as the one with all the rows and the first table mentioned/the left as
--the one with matching rows.

--For Example

select c.cid, c.name, c.city, o.ordnum, o.cid, o.aid, o.pid, o.totalUSD
from customers c left outer join orders o on c.cid=o.cid
order by c.cid
            
--This pairs the customers with their respective orders that correspond with them.By using left outer
--join as well as use customers as the first table it shows all customers even when they do not correspond
--to an order as shown by customer Weyland (cid=c005) not linking to any orders.

select c.cid, c.name, c.city, o.ordnum, o.cid, o.aid, o.pid, o.totalUSD
from customers c right outer join orders o on c.cid=o.cid
order by c.cid

--Using right outer join in this particular example has every order pair with a customer because the orders
--table relies on customers table. You need a customer for an order but you dont need a order for a customer.

--Other examples:

select c.cid, c.name, c.city, a.aid, a.name, a.city
from customers c left outer join agents a on c.city=a.city
order by c.city

select c.cid, c.name, c.city, a.aid, a.name, a.city
from customers c right outer join agents a on c.city=a.city
order by c.city