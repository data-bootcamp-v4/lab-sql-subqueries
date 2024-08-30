USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title, COUNT(i.inventory_id) AS number_of_copies
FROM sakila.film AS f
JOIN sakila.inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT f.title, f.length
FROM sakila.film AS f
WHERE f.length > (SELECT AVG(length) FROM sakila.film)
ORDER BY f.length DESC;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.first_name, a.last_name
FROM sakila.actor AS a
JOIN sakila.film_actor AS fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT f.film_id FROM sakila.film AS f WHERE f.title = 'Alone Trip');

