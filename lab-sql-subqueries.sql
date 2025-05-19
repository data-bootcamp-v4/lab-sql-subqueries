SELECT
COUNT(*) as total
FROM inventory
WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');


SELECT
title
FROM film
WHERE length > (SELECT AVG(length) FROM film);


SELECT
CONCAT(first_name, ' ', last_name) actors
FROM actor
WHERE actor_id IN (
	SELECT actor_id
    FROM film_actor
    WHERE film_id
    IN (SELECT film_id from film WHERE title = "Alone Trip"));



