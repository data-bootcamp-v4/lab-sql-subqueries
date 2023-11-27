## Challenge

-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select
	COUNT(*) as copy_count
from film 
inner join inventory on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

select 
	film_id, title, length
from film
where length > (select avg(length) from film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

select
	actor.actor_id, actor.first_name, actor.last_name
from actor where actor.actor_id in (select film_actor.actor_id from film_actor join film on film_actor.film_id = film.film_id
where film.title = 'Alone Trip');

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. 

select 
	film_id, title
from film where film_id in (select film_id from film_category where category_id in (select category_id from category where name = 'Family'));

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

select
	first_name, last_name, email
from customer
where address_id in (select address_id from address where city_id in 
(select city_id from city where country_id in (select country_id from country where country = 'Canada')));

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

select
	film.film_id, film.title
from film join film_actor on film.film_id = film_actor.film_id join actor on film_actor.actor_id = actor.actor_id
where actor.actor_id = (select actor_id from film_actor group by actor_id order by count(*) DESC limit 1);


-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

select
	film.film_id, film.title
from film join inventory on film.film_id = inventory.film_id join rental on inventory.inventory_id = rental.inventory_id
where rental.customer_id = (select payment.customer_id from payment group by payment.customer_id order by SUM(payment.amount) desc limit 1);

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.

select 
	c.customer_id, p.total_amount_spent from customer c join (select customer_id, SUM(amount) as total_amount_spent from payment
group by customer_id) p on c.customer_id = p.customer_id
where p.total_amount_spent > (select avg(total_amount_spent)
from(select customer_id, SUM(amount) as total_amount_spent from payment group by customer_id) avg_amount_spent)

	
	
