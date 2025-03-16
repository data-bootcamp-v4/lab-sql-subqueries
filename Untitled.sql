USE sakila;

-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

 SELECT f.title, COUNT(*) as available_copies
 FROM film f
 INNER JOIN inventory i
 ON f.film_id = i.film_id
 WHERE title = 'Hunchback Impossible'
 GROUP BY f.title;
 
SELECT title,
	(SELECT COUNT(*)
    FROM inventory
    WHERE film_id = f.film_id) as available_copies
FROM film f
WHERE title = 'Hunchback Impossible';

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length, (SELECT AVG(length) FROM film) as avg_length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT * FROM film_actor; 
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id FROM film_actor
    WHERE film_id = (
        SELECT film_id FROM film WHERE title = 'Alone Trip'
    )
);