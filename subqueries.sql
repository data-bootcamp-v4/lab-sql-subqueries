-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) FROM sakila.film AS film
LEFT JOIN sakila.inventory AS inventory ON film.film_id = inventory.film_id
LEFT JOIN sakila.rental AS rental ON rental.inventory_id = inventory.inventory_id
WHERE film.title = 'Hunchback Impossible';

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT  film.title AS film
FROM sakila.film AS film
WHERE length > (
SELECT  AVG(film.length)
FROM sakila.film);

-- Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT  first_name
       ,last_name
FROM
(
	SELECT  actor.first_name
	       ,actor.last_name
	       ,film.title
	FROM sakila.actor AS actor
	JOIN sakila.film_actor AS fa
	ON fa.actor_id = actor.actor_id
	JOIN sakila.film AS film
	ON film.film_id = fa.film_id
) AS t
WHERE title = 'Alone Trip';

-- Bonus 4
SELECT title
FROM (
	SELECT film.title, category.name
	FROM sakila.film AS film
	JOIN sakila.film_category AS fc ON fc.film_id = film.film_id
	JOIN sakila.category AS category ON category.category_id = fc.category_id
    ) AS t
WHERE t.name = 'Family';

