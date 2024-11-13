USE sakila ;
-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(inventory.film_id) AS number_of_copy
FROM inventory
WHERE inventory.film_id IN(SELECT film.film_id FROM film WHERE title = "Hunchback Impossible");

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length ASC;

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor_id, first_name, last_name 
FROM actor
WHERE actor.actor_id IN (
SELECT film_actor.actor_id 
FROM film_actor
JOIN film ON film_actor.film_id = film.film_id 
WHERE film.title = "Alone Trip");




