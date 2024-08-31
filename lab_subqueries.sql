USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS number_of_copies
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

-- 2- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor AS fa
    JOIN film AS f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);

