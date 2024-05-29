USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT count(a.film_id) AS 'COPIES of Hunchback Impossible' FROM film AS a
JOIN inventory AS b ON a.film_id = b.film_id
WHERE a.title = 'Hunchback Impossible';

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title,length FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.first_name, a.last_name FROM actor AS a
JOIN film_actor AS b ON a.actor_id = b.actor_id
WHERE b.film_id = (SELECT c.film_id FROM film AS c WHERE c.title = 'Alone Trip');