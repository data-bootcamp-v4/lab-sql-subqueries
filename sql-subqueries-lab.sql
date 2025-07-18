
use sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select
	f.title as Film_Title,
	count(s.store_id) as Number_of_Films  
from store as s
join inventory as i on s.store_id = i.store_id
join film as f on i.film_id = f.film_id
where f.title = "Academy Dinosaur"
group by Film_Title;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
select
	*
from film 
where length > 
(select
	avg(floor(length))
from film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

select
	first_name,
    last_name
from actor
where actor_id in
(select 
	actor_id
from film_actor
where film_id in (select 
    film_id
from film
where title like "%Alone Trip%"));


-- Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.

select
	title
from film
where film_id in    
(select
	film_id
from film_category
where category_id in (select
    category_id
from category
where name like "%Family%"));

-- Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

select
	first_name,
    last_name,
    email
from customer as cu
join address as a on cu.address_id = a.address_id
join city as c on a.city_id = c.city_id
join country as cou on c.country_id = cou.country_id
where cou.country like "%Canada%";


-- Determine which films were starred by the most prolific actor in the Sakila database. 
-- a prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

with top_actor as (select
a.actor_id
from actor as a
join film_actor as f 
on a.actor_id = f.actor_id
group by a.actor_id
order by count(f.film_id) desc 
limit 1)
select
first_name,
last_name
from actor as a
inner join top_actor on a.actor_id = top_actor.actor_id;

-- Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, 
-- i.e., the customer who has made the largest sum of payments.

with top_spender as (
select
customer_id,
SUM(amount) as total_spent
from payment
group by customer_id
order by total_spent desc
limit 1)
select 
first_name,
last_name
from customer as c
join top_spender on c.customer_id = top_spender.customer_id;

-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.

select
customer_id,
SUM(amount) as total_spent
from payment
group by customer_id
having sum(amount) >
(select avg(total_spent)
from 
(select sum(amount) as total_spent from payment
group by customer_id)
as customer_totals)



