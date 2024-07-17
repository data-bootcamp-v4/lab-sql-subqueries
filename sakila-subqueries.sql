USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory.film_id) FROM inventory JOIN film ON inventory.film_id = film.film_id WHERE film.title = "Hunchback Impossible";

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT  AVG(rental_duration)  AS avg_len FROM film ;

SELECT title, rental_duration FROM film WHERE rental_duration > (SELECT AVG(rental_duration) AS avg_len FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT actor.* 
FROM actor
JOIN film_actor ON film_actor.actor_id = actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = "Alone Trip";
