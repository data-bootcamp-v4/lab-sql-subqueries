SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);
-- BONUS 2: Customers from Canada (Subquery)
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);
-- BONUS 2: Customers from Canada (JOIN)
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
-- BONUS 3: Films starred by the most prolific actor

-- Step 1: Find the most prolific actor (by number of films)
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

-- Step 2: Use the result (actor_id) to find the film titles they appeared in
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);
-- BONUS 4: Films rented by the most profitable customer

-- Step 1: Get the customer_id with the highest total payment
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Step 2: Get the titles of films rented by that customer
SELECT DISTINCT f.title
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE p.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);
-- BONUS 5: Clients who spent more than the average total amount

SELECT customer_id, 
       ROUND(SUM(amount), 2) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS subquery
);
