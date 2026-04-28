use sakila;

SELECT * FROM inventory;
SELECT * FROM film;

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = 'Hunchback Impossible');

-- Films longer than average length
SELECT title, length
FROM film
where length >(
SELECT round(AVG(length), 2)
FROM film);

-- Actors in the film "Alone Trip"
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
SELECT actor_id
FROM film_actor
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = 'Alone Trip')
);