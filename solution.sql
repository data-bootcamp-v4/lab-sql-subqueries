USE sakila;

-- Ejercicio 1

SELECT
    film_id
   ,title 
    ,description 
FROM film
WHERE TRUE
    AND title = "Hunchback Impossible"
    AND film_id ="439";

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

-- Ejercicio 3

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
    )
);

-- Ejercicio 4

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = "Family"
    )
);

-- Ejercicio 5

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
            WHERE country = "Canada"
        )
    )
);

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = "Canada";

-- Ejercicio 6


SELECT actor_id, COUNT(film_id) AS num_pelis
FROM film_actor
GROUP BY actor_id
ORDER BY num_pelis DESC
LIMIT 1;

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

-- Ejercicio 7

SELECT customer_id, SUM(amount) AS total_pagado
FROM payment
GROUP BY customer_id
ORDER BY total_pagado DESC
LIMIT 1;

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE customer_id = (
            SELECT customer_id
            FROM payment
            GROUP BY customer_id
            ORDER BY SUM(amount) DESC
            LIMIT 1
        )
    )
);

-- Ejercicio 8

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id;

SELECT AVG(total_amount_spent)
FROM (
    SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS totales;

SELECT customer_id AS client_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_amount_spent)
    FROM (
        SELECT customer_id, SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS totales
)
ORDER BY total_amount_spent DESC;