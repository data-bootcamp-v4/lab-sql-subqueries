
USE sakila;

-- 1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.


SELECT COUNT(film_id) FROM sakila.inventory
WHERE film_id IN (SELECT film_id FROM sakila.film
WHERE title = 'Hunchback Impossible');

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.


SELECT title, length FROM sakila.film
WHERE length > (SELECT ROUND(AVG(length)) FROM sakila.film)
ORDER BY length ASC;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".


SELECT first_name, last_name FROM sakila.actor
WHERE actor_id IN (
SELECT actor_id 
FROM sakila.film_actor
WHERE film_id IN (
SELECT film_id 
FROM sakila.film WHERE title = 'Alone Trip'));












