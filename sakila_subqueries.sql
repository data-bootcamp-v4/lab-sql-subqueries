-- Display all available tables in the Sakila database.

USE sakila;
SHOW tables;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT f.title, COUNT(sub.inventory_id) AS number_of_copies
FROM (
    SELECT i.inventory_id, i.film_id
    FROM sakila.inventory i
) AS sub
LEFT JOIN sakila.film f ON sub.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

SELECT title, length
FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film);

SELECT first_name, last_name 
FROM sakila.actor
WHERE actor_id IN (
    SELECT fa.actor_id
    FROM sakila.film_actor fa
    WHERE fa.film_id = (
        SELECT film_id FROM sakila.film WHERE title = 'Alone Trip'
    )
);



