select ordnum, totalUSD
from Orders;

select name, city
from Agents
where name = 'Smith';

select pid, name, priceUSD
from Products
where quantity > 201000;

select  name, city
from Customers
where city = 'Duluth';

select name
from Agents
where (city != 'New York')
  AND (city != 'Duluth');
    
select *
from Orders
where (mon = 'feb')
   OR (totalUSD >= 600);

select *
from Orders
where (mon = 'feb')
OR (mon = 'mar');

select *
from Products
where (city != 'Dallas' AND city != 'Duluth')
  AND (priceUSD >= 1);
  
select *
from Orders
where cid = 'c005';