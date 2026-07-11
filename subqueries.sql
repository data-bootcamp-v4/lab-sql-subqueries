USE sakila;

-- 1. Number of copies of "Hunchback Impossible"
SELECT COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f
ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

-- 2. Films longer than the average film length
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- 3. Actors appearing in "Alone Trip"
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

-- Bonus 4 — Family movies
SELECT f.title
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- Bonus 5 — Customers from Canada
SELECT first_name,
       last_name,
       email
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


-- Bonus 6 — Films of the most prolific actor
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
);

-- Bonus 7 — Films rented by the most profitable customer
SELECT DISTINCT f.title
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- Bonus 8 — Customers who spent more than the average customer
SELECT customer_id,
       SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
);



