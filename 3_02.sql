use sakila;
-- Write SQL queries to perform the following tasks using the Sakila database:
	-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT (SELECT title FROM film WHERE film_id = i.film_id) AS title, COUNT(inventory_id) FROM inventory AS i
WHERE i.film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible')
GROUP BY i.film_id;

    -- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film);

	-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name FROM actor AS a
WHERE a.actor_id IN (SELECT fa.actor_id FROM film_actor AS fa
    WHERE fa.film_id = (SELECT f.film_id FROM film AS f
        WHERE f.title = 'Alone Trip'));
