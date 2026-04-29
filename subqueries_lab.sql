USE sakila;

-- 1.Determine the number of copies of the film "Hunchback Impossible" 
-- that exist in the inventory system.

SELECT COUNT(inventory_id) AS total_films
FROM inventory
WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

-- 2.List all films whose length is longer 
-- than the average length of all the films in the Sakila database.

SELECT title 
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name AS name, last_name AS surname
FROM actor
WHERE actor_id IN 
	(SELECT actor_id 
	FROM film_actor 
    WHERE film_id = 
		(SELECT film_id 
        FROM film 
        WHERE title = 'Alone Trip'));
