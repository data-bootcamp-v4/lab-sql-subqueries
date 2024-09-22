USE sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT COUNT(*) AS total_copies
FROM inventory i
WHERE i.film_id = (SELECT f.film_id FROM film f WHERE f.title = 'Hunchback Impossible');


-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT COUNT(actor_id)
FROM film_actor
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');
