USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id
					FROM film
					WHERE title = 'Hunchback Impossible');

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
					FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (SELECT film_actor.actor_id
							FROM film_actor
							WHERE film_actor.film_id = (SELECT film_id
															FROM film
															WHERE title = 'Alone Trip'));