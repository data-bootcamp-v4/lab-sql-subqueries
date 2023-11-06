USE sakila;

/* 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system. */


SELECT title, count(*) AS copies
FROM inventory
INNER JOIN(
			SELECT film_id, title
			FROM film
			WHERE title like '%Hunchback Impossible%') t
ON inventory.film_id = t.film_id
GROUP BY title;


/* 2. List all films whose length is longer than the average length of all the films in the Sakila database. */
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

/* 3. Use a subquery to display all actors who appear in the film "Alone Trip". */

SELECT concat(first_name, " ", last_name) as fullname, title
FROM actor
INNER JOIN (
			SELECT actor_id, title
			FROM film_actor
			INNER JOIN (
			SELECT film_id, title
			FROM film
			WHERE title like '%Alone Trip%') t
			ON film_actor.film_id = t.film_id) a
ON actor.actor_id = a.actor_id







