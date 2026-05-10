USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" 
-- that exist in the inventory system.
SELECT
	f.title,
    COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- 2. List all films whose length is longer than the average length of 
-- all the films in the Sakila database.
SELECT
	f.title,
    f.length
FROM film f
WHERE f.length > (
SELECT AVG(f.length)
FROM film f
);

-- 3. Use a subquery to display all actors who appear 
-- in the film "Alone Trip".
SELECT
	a.first_name,
    a.last_name
FROM actor a
WHERE actor_id IN(
	SELECT fa.actor_id
    FROM film_actor fa
    WHERE film_id IN(
		SELECT f.film_id
        FROM film f
        WHERE f.title = 'Alone Trip'
    )
);

-- BONUS 4. Sales have been lagging among young families,
-- and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT
	f.title
FROM film f
WHERE film_id IN (
	SELECT fc.film_id
    FROM film_category fc
    WHERE category_id = (
		SELECT c.category_id
		FROM category c
		WHERE c.name = 'Family')
);

-- BONUS 5. Retrieve the name and email of customers from Canada
-- using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables
-- and their primary and foreign keys.

-- SUBQUERIES
SELECT
	cu.first_name,
    cu.last_name,
    cu.email
FROM customer cu
WHERE address_id IN(
	SELECT a.address_id
    FROM address a
    WHERE city_id IN(
		SELECT ci.city_id
        FROM city ci
        WHERE country_id IN(
			SELECT co.country_id
            FROM country co
            WHERE co.country = 'Canada'
        )
    )
)
;

-- JOINS
SELECT
	cu.first_name,
    cu.last_name,
    cu.email
FROM customer cu
JOIN address a
	ON	cu.address_id = a.address_id
JOIN city ci
	ON a.city_id = ci.city_id
JOIN country c
	ON ci.country_id = c.country_id
WHERE c.country = 'Canada';

-- BONUS 6. Determine which films were starred by the most prolific actor
-- in the Sakila database. A prolific actor is defined as the actor who
-- has acted in the most number of films.
-- First, you will need to find the most prolific actor and then
-- use that actor_id to find the different films that he or she starred in.
SELECT
	f.title
FROM film f
WHERE film_id IN(
	SELECT fa.film_id
    FROM film_actor fa
    WHERE actor_id = (
		SELECT fa.actor_id
        FROM film_actor fa
        GROUP BY fa.actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
);    

-- BONUS 7. Find the films rented by the most profitable customer
-- in the Sakila database. You can use the customer and payment
-- tables to find the most profitable customer, i.e., 
-- the customer who has made the largest sum of payments.
SELECT DISTINCT
	f.title
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
JOIN rental r
	ON i.inventory_id = r.inventory_id
WHERE r.customer_id =(
	SELECT customer_id
	FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- BONUS 8. Retrieve the client_id and the total_amount_spent
-- of those clients who spent more than the average of the 
-- total_amount spent by each client.
-- You can use subqueries to accomplish this.
SELECT 
	customer_id AS client_id,
    SUM(amount) AS total_amount_spent
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > (
	SELECT AVG(total_spent)
    FROM (
		SELECT
			customer_id,
            SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
);

