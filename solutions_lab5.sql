USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" in the inventory
SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (
    SELECT film_id FROM film WHERE title = 'Hunchback Impossible'
);

-- 2. List all films longer than the average length of all films
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) FROM film
);

-- 3. Display all actors who appear in the film "Alone Trip"
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor
    WHERE film_id = (
        SELECT film_id FROM film WHERE title = 'Alone Trip'
    )
);
-- 4. Identify all movies categorized as family films
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id FROM category WHERE name = 'Family'
    )
);

-- 5. Retrieve the name and email of customers from Canada
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id FROM country WHERE country = 'Canada'
        )
    )
);

-- 6. Find films starred by the most prolific actor
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
);

-- 7. Find the films rented by the most profitable customer
SELECT f.title
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

-- 8. Find customers who spent more than the average total amount spent by clients
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total) 
    FROM (
        SELECT SUM(amount) AS total
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
);

