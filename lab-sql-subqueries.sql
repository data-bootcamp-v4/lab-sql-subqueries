-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT 
    COUNT(i.inventory_id) AS num_copias
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';
  
-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT
CONCAT(first_name, ' ', last_name) AS name
FROM actor a
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor fa
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

-- Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT f.title
FROM film f
JOIN film_category fc 
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT 
    CONCAT(cu.first_name, ' ', cu.last_name) AS name,
    cu.email
FROM customer cu
WHERE cu.address_id IN (
    SELECT ad.address_id
    FROM address ad
    WHERE ad.city_id IN (
        SELECT ci.city_id
        FROM city ci
        WHERE ci.country_id = (
            SELECT co.country_id
            FROM country co
            WHERE co.country = 'Canada'
        )
    )
);

SELECT 
CONCAT(first_name, ' ', last_name) AS name,
cu.email 
FROM customer cu
JOIN address ad 
    ON cu.address_id = ad.address_id
JOIN city ci
	ON ci.city_id = ad.city_id
JOIN country co
	 ON ci.country_id = co.country_id
WHERE co.country = 'Canada';






-- Determine which films were starred by the most prolific actor in the Sakila database.
--  A prolific actor is defined as the actor who has acted in the most number of films.
-- First, you will need to find the most prolific actor and then use that actor_id 
-- to find the different films that he or she starred in.
SELECT 
	DISTINCT f.title
FROM film f
JOIN film_actor fa 
	ON f.film_id = fa.film_id
WHERE fa.actor_id = (
	SELECT 	actor_id
	FROM film_actor
	GROUP BY actor_id
	ORDER BY COUNT(film_id) DESC
	LIMIT 1
);



-- Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e.,
--  the customer who has made the largest sum of payments.

SELECT 
	DISTINCT title
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
WHERE i.inventory_id IN (
SELECT r.inventory_id
FROM rental r
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1));

-- Retrieve the client_id and the total_amount_spent of those clients 
-- who spent more than the average of the total_amount spent by each client.
-- You can use subqueries to accomplish this.
WITH totals AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_amount
    FROM payment
    GROUP BY customer_id
)
SELECT customer_id, total_amount
FROM totals
WHERE total_amount > (SELECT AVG(total_amount) FROM totals)
ORDER BY total_amount DESC	