-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
use sakila;

SELECT film_id, title FROM film
WHERE title = 'Hunchback Impossible';

SELECT * 
FROM inventory 
WHERE film_id = 439;

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT AVG(length) FROM film;

SELECT film_id, title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor f
    WHERE fa.film_id = (
        SELECT f.film_id
        FROM film f
        WHERE f.title = 'Alone Trip'
    )
)
ORDER BY a.last_name, a.first_name;

