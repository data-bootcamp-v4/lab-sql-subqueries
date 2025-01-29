use sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select title, count(inventory_id) as nr_copies
from inventory
inner join film
on film.film_id = inventory.film_id
where title = "Hunchback Impossible";

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.
select avg(length) as avg_len
from film;

select film.title, film.length 
from film
inner join inventory
on film.film_id = inventory.film_id
where film.length > (select avg(length) from film)
GROUP BY film.film_id;

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".\
select first_name, last_name
from actor
inner join film_actor
on actor.actor_id = film_actor.actor_id
inner join film
on film_actor.film_id = film.film_id
where film.title = "Alone Trip";

-- Bonus:

-- 4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select distinct rating
from film;

select f.title, f.rating
from film as f
inner join inventory as i
on f.film_id = i.film_id
where rating in ('PG', 'PG-13')
group by f.title, f.rating;

-- 5 Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
-- 6 Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- 7 Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
-- 8 Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
