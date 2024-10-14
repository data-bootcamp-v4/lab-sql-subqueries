# Challenge 1

SELECT
	COUNT(film.film_id)
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN store ON inventory.store_id = store.store_id
WHERE film.title = "Hunchback Impossible";

# Challenge 2

SELECT
	film.title
FROM film
WHERE film.length > (SELECT AVG(length) FROM film);

# Challenge 3

SELECT
	actor.first_name,
    actor.last_name
FROM actor
WHERE actor.actor_id IN (
	SELECT film_actor.actor_id 
    FROM film 
    JOIN film_actor ON film.film_id = film_actor.film_id
    WHERE film.title = "Alone Trip");