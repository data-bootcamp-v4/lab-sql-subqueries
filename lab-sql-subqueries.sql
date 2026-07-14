USE sakila

-- 1 copies un inventory

SELECT
	film_text.title,
	COUNT(inventory.inventory_id) AS film_invetored
FROM film_text
JOIN inventory
	ON film_text.film_id = inventory.film_id
WHERE film_text.title = 'Hunchback Impossible';

-- 2 SELECT FILMS LEGHT HIGHER THAN AVG

SELECT
	title,
    length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip"

SELECT
    CONCAT(first_name, ' ', last_name) AS actor_name
FROM actor
WHERE actor_id IN (
	SELECT
		actor_id
	FROM film_actor
	WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip')
);
