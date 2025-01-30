USE sakila;
-- Challenge: Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT title, film_id, COUNT(inventory_id) AS nr_copies FROM inventory INNER JOIN film USING (film_id)
WHERE film_id=(SELECT film_id FROM film WHERE title="HUNCHBACK IMPOSSIBLE") GROUP BY film_id;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length, 
	(SELECT ROUND(AVG(length), 2) FROM film AS avg_length)
FROM film WHERE length > (SELECT AVG(length) FROM film) ORDER BY title;
-- OR:
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT film_id, title, concat(first_name, " ", last_name) AS name FROM actor
INNER JOIN film_actor USING (actor_id) INNER JOIN film USING (film_id)
WHERE film_id IN (SELECT film_id FROM film WHERE title="ALONE TRIP") ORDER BY name;

-- Bonus:
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films. 
SELECT title, name AS category_name FROM film INNER JOIN film_category USING (film_id) INNER JOIN category USING (category_id)
WHERE name = (SELECT name FROM category WHERE name="Family") ORDER BY name;

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT country, concat(first_name, " ", last_name) AS name, email FROM customer
INNER JOIN address USING (address_id) INNER JOIN city USING (city_id) INNER JOIN country USING (country_id)
WHERE country= (SELECT country from country WHERE country = "CANADA") ORDER BY name;
 
-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, 
-- i.e., the customer who has made the largest sum of payments.
SELECT DISTINCT title FROM film WHERE film_id IN 
					(SELECT film_id FROM inventory WHERE inventory_id IN 
						(SELECT inventory_id FROM rental WHERE customer_id = 
							(SELECT customer_id FROM payment 
								GROUP BY customer_id ORDER BY SUM(amount) LIMIT 1)));

-- 8. Retrieve the client_id and the total_amount_spent of those clients
-- who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.
SELECT customer_id, sum(amount) AS total_amount FROM payment GROUP BY customer_id ORDER BY total_amount;
SELECT avg(total_spent) AS avg_total_spent
FROM (SELECT customer_id, sum(amount) AS total_spent FROM payment GROUP BY customer_id) AS total_spent;
SELECT customer_id, sum(amount) AS total_spent FROM payment GROUP BY customer_id
HAVING total_spent > (SELECT avg(total_spent) AS avg_total_spent
	FROM (SELECT customer_id, sum(amount) AS total_spent FROM payment GROUP BY customer_id) AS total_spent) ORDER BY total_spent;

