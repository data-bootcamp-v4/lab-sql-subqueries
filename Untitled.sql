USE sakila;

-- 1:
SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);
-- 2:
SELECT title AS long_movies, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3:
SELECT f.title, f.film_id, a.first_name, a.last_name
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON fa.actor_id = a.actor_id
WHERE f.title = "Alone Trip";



