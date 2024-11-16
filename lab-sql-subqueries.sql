USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory_id) FROM sakila.inventory
WHERE film_id IN (
SELECT film_id FROM sakila.film
WHERE title = "Hunchback Impossible"
);

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM sakila.film
WHERE length > (
    SELECT AVG(length)
    FROM sakila.film);


-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM sakila.actor
WHERE actor_id IN (
    SELECT actor_id
    FROM sakila.film_actor AS fa
    JOIN sakila.film AS f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);


