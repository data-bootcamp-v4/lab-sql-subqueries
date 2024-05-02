USE sakila;

SELECT COUNT(*), film.title
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE film.title = "Hunchback Impossible";

SELECT *
FROM film
WHERE film.length > (SELECT AVG(film.length) FROM film);

SELECT CONCAT(actor.first_name, " ",actor.last_name) 
FROM film_actor
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE film.title = "Alone Trip";