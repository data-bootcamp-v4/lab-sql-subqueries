SELECT COUNT(*) 
FROM inventory 
JOIN film ON inventory.film_id = film.film_id 
WHERE film.title = 'Hunchback Impossible';

SELECT title 
FROM film 
WHERE length > (SELECT AVG(length) FROM film);

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

