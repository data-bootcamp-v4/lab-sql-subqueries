-- Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS num_copies FROM inventory
JOIN film 
ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT length, title FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT 
a.first_name, 
a.last_name
FROM sakila.actor AS a
WHERE a.actor_id IN (
SELECT fa.actor_id
FROM sakila.film_actor AS fa
JOIN sakila.film AS f 
ON fa.film_id = f.film_id
WHERE f.title = 'Alone Trip'
);
