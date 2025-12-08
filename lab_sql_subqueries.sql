USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT 
    f.title,
    COUNT(i.inventory_id) AS number_of_copies
FROM sakila.film f
JOIN sakila.inventory i 
    ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM sakila.film
WHERE length > (
    SELECT AVG(length)
    FROM sakila.film
)
ORDER BY length DESC;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM sakila.actor
WHERE actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT f.title AS movie_title
FROM sakila.film f
JOIN sakila.film_category fc 
    ON f.film_id = fc.film_id
JOIN sakila.category c 
    ON fc.category_id = c.category_id
WHERE c.name = 'Family'
ORDER BY f.title;

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
-- USING JOINS
SELECT c.first_name, c.last_name, c.email
FROM sakila.customer c
JOIN sakila.address a 
    ON c.address_id = a.address_id
JOIN sakila.city ci 
    ON a.city_id = ci.city_id
JOIN sakila.country co 
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- USING SUBQUERIES
SELECT first_name, last_name, email
FROM sakila.customer
WHERE address_id IN (
    SELECT address_id
    FROM sakila.address
    WHERE city_id IN (
        SELECT city_id
        FROM sakila.city
        WHERE country_id = (
            SELECT country_id
            FROM sakila.country
            WHERE country = 'Canada'
        )
    )
);

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT a.actor_id, a.first_name, a.last_name, f.title AS film_title
FROM sakila.actor a
JOIN film_actor fa 
    ON a.actor_id = fa.actor_id
JOIN film f 
    ON fa.film_id = f.film_id
WHERE a.actor_id = (
    SELECT fa2.actor_id
    FROM sakila.film_actor fa2
    GROUP BY fa2.actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.title;

-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., 
-- the customer who has made the largest sum of payments.
SELECT c.customer_id, c.first_name, c.last_name, f.title AS film_title
FROM sakila.customer c
JOIN rental r 
    ON c.customer_id = r.customer_id
JOIN inventory i 
    ON r.inventory_id = i.inventory_id
JOIN film f 
    ON i.film_id = f.film_id
WHERE c.customer_id = (
    SELECT customer_id
    FROM sakila.payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.
SELECT customer_id,
    SUM(amount) AS total_amount_spent
FROM sakila.payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM sakila.payment
        GROUP BY customer_id
    ) AS customer_totals
);