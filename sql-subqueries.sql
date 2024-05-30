-- Determine the number of copies of the film 
-- "Hunchback Impossible" that exist in the inventory system.
use sakila;
select f.title, 
from film as f;


select distinct inventory_id
from inventory;

SELECT count(i.inventory_id) AS avaliable
FROM inventory as i
where i.film_id = 'Hunchback Impossible';

SELECT count(*) AS avaliable
from (select i.inventory_id 
from inventory i 
join film f on i.film_id = f.film_id
    where f.title = 'Hunchback Impossible'
) as sub;

-- List all films whose length is longer than 
-- the average length of all the films in the Sakila database.
select title
from film 
where length > (select avg(length)
from film );


-- Use a subquery to display all actors who appear in the
-- film "Alone Trip".

SELECT concat(first_name,' ',last_name) as names
from actor as a
join film_actor as fa
on a.actor_id =fa.actor_id
WHERE fa.film_id = (SELECT f.film_id FROM  
film f WHERE f.title = 'Alone Trip');

-- Sales have been lagging among young families, and you 
-- want to target family movies for a promotion. Identify 
-- all movies categorized as family films. 
select f.title
from film f
where f.film_id in (select fc.film_id
from film_category as fc
join category as c
on fc.category_id = c.category_id
where c.name = 'Family') ;

-- Retrieve the name and email of customers from Canada 
-- using both subqueries and joins. To use joins, you will 
-- need to identify the relevant tables and their primary 
-- and foreign keys.
select concat(cu.first_name, ' ', cu.last_name) as name, cu.email
from customer as cu
where cu.address_id in (select a.address_id from address as a
join city as c
on a.city_id = c.city_id
join country as co
on c.country_id = co.country_id
where co.country = 'Canada');

-- Determine which films were starred by the most prolific 
-- actor in the Sakila database. A prolific actor is defined 
-- as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and 
-- then use that actor_id to find the different films that 
-- he or she starred in.
select f.title, concat(a.first_name, ' ', a.last_name) as name
from film as f
join film_actor as fa
on f.film_id = fa.film_id
join actor as a
on fa.actor_id= a.actor_id
where fa.actor_id = (select actor_id 
from film_actor 
group by actor_id
order by count(*) desc
limit 1);

-- Find the films rented by the most profitable customer 
-- in the Sakila database. You can use the customer and 
-- payment tables to find the most profitable customer, i.e., 
-- the customer who has made the largest sum of payments.
select f.title
from film as f
join inventory as i
on f.film_id = i.film_id
join rental as r
on r.inventory_id = i.inventory_id
where r.customer_id = (select customer_id 
from payment 
group by customer_id
order by sum(amount) desc
limit 1);

 -- Retrieve the client_id and the total_amount_spent of 
 -- those clients who spent more than the average of the 
 -- total_amount spent by each client. You can use subqueries 
 -- to accomplish this.
 
 select customer_id, t_spent
 from 
