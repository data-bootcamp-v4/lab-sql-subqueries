use sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select * from film;

-- inventory has invemtory_id and film id
-- film has film_id and title
SELECT COUNT(inventory_id) AS "No. of Copies"
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT CONCAT(first_name, ' ', last_name) AS actor_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));
