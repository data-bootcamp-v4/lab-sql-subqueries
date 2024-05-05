USE sakila;

#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT * FROM inventory;
SELECT * FROM film;
SELECT *
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title LIKE 'Hunchback%';
#2List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, film_id, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
#3Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));

