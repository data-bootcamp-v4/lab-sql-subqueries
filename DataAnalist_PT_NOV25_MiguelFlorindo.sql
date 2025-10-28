-- 1

USE sakila;

SELECT COUNT(*) AS number_of_copies
FROM film as f
JOIN inventory as i ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";


-- 2

SELECT film_id, title, length
FROM film
WHERE length > (
	SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;

-- 3


SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
WHERE a.actor_id IN (
	SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
	WHERE f.title = 'Alone Trip'
);