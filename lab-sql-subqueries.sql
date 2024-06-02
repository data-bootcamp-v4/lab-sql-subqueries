-- Write SQL queries to perform the following tasks using the Sakila database:

USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';
-- There are 6 copies of that film

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.first_name, a.last_name, f.title
FROM actor as a
JOIN film_actor as fa ON a.actor_id = fa.actor_id
JOIN film as f ON f.film_id = fa.film_id
WHERE title = "Alone Trip";

SELECT a.first_name, a.last_name
FROM actor as a
JOIN film_actor as fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip');

