USE sakila;


-- Ejercicio1.
SELECT 
COUNT(inventory_id)
FROM inventory
WHERE film_id IN (SELECT film_id
FROM film
WHERE title = 'Hunchback Impossible');


-- Ejercicio 2
SELECT 
title,
length
FROM film
WHERE length > ( SELECT AVG(length) FROM film);

-- Ejercicio 3
SELECT 
first_name,
last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor
WHERE film_id IN (SELECT film_id FROM film
WHERE title = 'Alone Trip'));

-- Ejercico 4
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id IN (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
);

-- Ejercicio 5
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id
FROM address
WHERE city_id IN (SELECT city_id
FROM city
WHERE country_id IN (SELECT country_id
FROM country
WHERE country = 'Canada')));