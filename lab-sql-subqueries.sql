USE sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT title, film_id from film
WHERE title = 'Hunchback Impossible';

SELECT count(film_id) from inventory
where film_id in (
SELECT film_id from film
WHERE title = 'Hunchback Impossible');

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT (round(avg(length),2)) as 'Average' from film;

SELECT * FROM film
WHERE length > (SELECT (round(avg(length),2)) as 'Average' from film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name from actor
JOIN film_actor 
on actor.actor_id = film_actor.actor_id
join film
on film_actor.film_id = film.film_id 
where film.title = "Alone Trip";

-- BONUS
-- Sales have been lagging among young families, and you want to target family movies for a promotion.
-- Identify all movies categorized as family films.

SELECT film.film_id, film.title, category.name from film
join film_category
on film.film_id = film_category.film_id 
join category
on film_category.category_id = category.category_id
where category.name = 'family';

-- Retrieve the name and email of customers from Canada using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys

select customer.first_name, customer.last_name, customer.email, country.country
from customer 
join address
on customer.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id
where country.country = 'Canada';

-- Determine which films were starred by the most prolific actor in the Sakila database.
-- A prolific actor is defined as the actor who has acted in the most number of films.
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

-- the most prolific actor

select film.film_id, film.title, film_actor.actor_id from film
join film_actor
on film.film_id = film_actor.film_id
where film_actor.actor_id = (select actor.actor_id from actor
join film_actor
on actor.actor_id = film_actor.actor_id 
group by actor.actor_id 
order by count(film_actor.film_id) desc
limit 1);

-- Find the films rented by the most profitable customer in the Sakila database.
-- You can use the customer and payment tables to find the most profitable customer, i.e., 
-- the customer who has made the largest sum of payments.

select film.film_id, film.title, rental.customer_id from film
join inventory
on film.film_id = inventory.film_id
join rental
on inventory.inventory_id = rental.inventory_id
where rental.customer_id = (
	select customer.customer_id 
    from customer
		join payment
		on customer.customer_id = payment.customer_id 
		join rental 
		on payment.rental_id = rental.rental_id
		group by customer.customer_id 
		order by sum(payment.amount) desc
		limit 1
);


-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
-- You can use subqueries to accomplish this.

SELECT customer.customer_id, round(sum(payment.amount),2) AS 'total_amount' FROM customer
join payment
on customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
HAVING total_amount > (SELECT ROUND(AVG(payment.amount),2) FROM customer
join payment
on customer.customer_id = payment.customer_id)
ORDER BY total_amount DESC;

