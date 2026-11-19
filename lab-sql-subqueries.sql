USE sakila;

-- Ejercicio 1º

SELECT 
film_id,
title,
description
FROM film
WHERE TRUE
AND title = "Hunchback Impossible"
AND film_id = "439";

SELECT
COUNT(*) AS number_of_copies 
FROM inventory
WHERE film_id in (
SELECT film_id 
FROM film
WHERE title = "Hunchback Impossible"
)
;

-- Ejercicio 2º

SELECT AVG(length)
FROM film;

SELECT title
FROM film
WHERE length > (SELECT AVG(length)
FROM film);

-- Ejercicio 3º

SELECT
    first_name,
    last_name
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

-- Ejercicio 4º (Bonus)

SELECT
    title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
);

-- Ejercicio 5º

SELECT
    c.first_name,
    c.last_name,
    c.email
FROM customer c
JOIN address a
    ON c.address_id = a.address_id
WHERE a.city_id IN (
    SELECT city_id
    FROM city
    WHERE country_id = (
        SELECT country_id
        FROM country
        WHERE country = 'Canada'
    )
);

-- Ejercicio 6º

SELECT
    f.title
FROM film f
JOIN film_actor fa
    ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);

-- Ejercicio 7º

SELECT DISTINCT
    f.title
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

-- Ejercicio 8º

SELECT
    customer_id,
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