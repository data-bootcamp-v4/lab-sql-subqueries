-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory_id) AS number_of_copies
FROM sakila.inventory
WHERE film_id IN (
    SELECT film_id
    FROM sakila.film
    WHERE title = 'Hunchback Impossible');

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film)
ORDER BY length DESC;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
-- actor -> film_actor -> film
SELECT first_name, last_name 
FROM sakila.actor
WHERE actor_id IN (
SELECT a.actor_id FROM sakila.film AS f
JOIN sakila.film_actor AS a
ON f.film_id = a.film_id
WHERE f.title = 'Alone Trip');


-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT title 
FROM sakila.film
WHERE film_id IN (
SELECT film_id FROM sakila.film_category AS fc
JOIN sakila.category AS c
ON fc.category_id = c.category_id
WHERE c.name = 'Family');

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT first_name, last_name, email FROM sakila.customer
WHERE address_id IN(
SELECT address_id FROM sakila.address AS a
JOIN sakila.city AS ci
ON a.city_id = ci.city_id
JOIN sakila.country AS co
ON ci.country_id = co.country_id
WHERE country = 'Canada');

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT title FROM sakila.film
WHERE film_id = (

SELECT a.first_name AS first_name, 
		a.last_name AS last_name, 
        COUNT(fa.film_id) AS number_of_films
FROM sakila.actor AS a
JOIN sakila.film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name
HAVING COUNT(number_of_films) = (
SELECT MAX(film_count) FROM (
        SELECT COUNT(film_id) AS film_count
        FROM sakila.film_actor
        GROUP BY actor_id
    ) AS subquery

WHERE fa.film_id = (
	SELECT film_id FROM sakila.film 
    WHERE MAX(COUNT(film_id))
WHERE MAX(number_of_films);



-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.


-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
