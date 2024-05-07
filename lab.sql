USE sakila;

SELECT COUNT(inventory_id) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible');

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film);
    
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip');

