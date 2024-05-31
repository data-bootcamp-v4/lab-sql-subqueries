USE sakila;

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);


SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'
);