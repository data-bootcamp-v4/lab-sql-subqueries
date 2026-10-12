SELECT title, film_id
FROM film
WHERE title = "Hunchback Impossible";

SELECT COUNT(*) AS total_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film
WHERE title = "Hunchback Impossible");

SELECT AVG(length) AS avg_length FROM film HAVING length > avg_length;