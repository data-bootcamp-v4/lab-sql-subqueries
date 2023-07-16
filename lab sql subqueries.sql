-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
use sakila;
Select title, count(1) as "number of copies"
from film
inner join inventory i
on film.film_id = i.film_id
where title like "Hunchback Impossible"
group by 1;
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length
from film 
where length > (select avg(length) from film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
Select first_name, last_name
from actor where actor_id in
(select actor_id from film_actor where film_id in (select film_id 
from film where title like "alone trip"));

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. 
select title
from film where film_id in 
(select film_id from film_category
where category_id in (select category_id from category where name like "family"));


-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
Select first_name, last_name, customer_id, email
from customer
where address_id in
(select address_id from address 
inner join city 
on address.city_id = city.city_id
inner join country
on city.country_id = country.country_id where country like "canada");

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
Select first_name, last_name, a.actor_id, count(1)
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
group by 1,2,3
order by 4 desc;

Select title, film_id
from film
where film_id in
(select film_id from film_actor
where actor_id = 107);

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
select first_name, last_name, c.customer_id, sum(amount)
from payment p 
inner join customer c
on p.customer_id = c.customer_id
group by 1, 2, 3
order by sum(amount) desc limit 1;

select title, film_id from film where film_id in
(select film_id from inventory where inventory_id in (select inventory_id
from rental where customer_id = 526)); 

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
select customer_id, sum(amount) as "total amount spent" from payment group by customer_id 
having sum(amount) >
(select sum(amount)/count(distinct c.customer_id)
from customer c
inner join payment p
on c.customer_id = p.customer_id)
order by 2 desc; 
