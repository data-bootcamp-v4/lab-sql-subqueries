USE SAKILA;

-- 1.
SELECT COUNT(inv.inventory_id) as number_of_copies 
FROM inventory as inv
INNER JOIN film 
ON inv.film_id=film.film_id
WHERE inv.film_id = (SELECT film_id from film WHERE title LIKE 'Hunchback Impossible' LIMIT 1);


-- Another Solution for 1.
SELECT COUNT(inv.inventory_id) AS number_of_copies
FROM inventory AS inv
INNER JOIN film
ON inv.film_id = film.film_id
WHERE film.title LIKE 'Hunchback Impossible';

-- 2.
SELECT *
from film
WHERE film.length > (SELECT AVG(length) from film);

-- 3.

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