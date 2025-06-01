
USE sakila;

SELECT count(inventory.film_id) as number_copies
FROM inventory
WHERE inventory.film_id = (
SELECT film_id
FROM film
WHERE title = "Hunchback Impossible");

SELECT film_id, title
FROM film
WHERE length > (
SELECT avg(length)
FROM film);

-- I tried using a subquery to finish the 3rd exercise, but it gave me an Error Code 1242, so I tried this approach instead:

SELECT CONCAT(actor.first_name, " ", actor.last_name) as actors_AloneTrip
FROM actor, film_actor, film
WHERE actor.actor_id = film_actor.actor_id AND film_actor.film_id = film.film_id AND film.title = "Alone Trip";
