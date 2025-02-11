USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
/* Option 1:
FROM sakila.inventory AS i
-- JOIN sakila.film AS f
-- ON i.film_id = f.film_id
-- WHERE f.title = 'Hunchback Impossible'
-- GROUP BY f.title;
*/
-- Option 2:
SELECT COUNT(inventory_id) AS copies
FROM sakila.inventory
WHERE film_id = (SELECT film_id FROM sakila.film WHERE title = 'Hunchback Impossible');

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title
FROM sakila.film
WHERE length > (SELECT AVG(length) AS avg_length FROM sakila.film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
-- nested subqueries
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id=(SELECT film_id FROM film WHERE title= "Alone Trip"));
