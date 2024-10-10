Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

USE sakila
SHOW FULL TABLES

SELECT * FROM inventory
SELECT * FROM film

SELECT f.title, f.film_id, COUNT(i.film_id) AS number_of_copies
FROM film f
JOIN inventory i ON i.film_id = f.film_id
WHERE LOWER(f.title) = 'Hunchback Impossible'
GROUP BY f.film_id;

List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

Use a subquery to display all actors who appear in the film "Alone Trip".

SHOW FULL TABLES

SELECT * FROM film
SELECT * FROM film_actor
SELECT * FROM actor

SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip');