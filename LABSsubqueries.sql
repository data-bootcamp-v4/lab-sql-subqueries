USE sakila;

SELECT * FROM inventory;

SELECT f.title, COUNT(i.inventory_id) AS number_of_copies
FROM inventory i
JOIN film f 
	ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

