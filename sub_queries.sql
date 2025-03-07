-- Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;

-- 1. numero de copias del film "Hunchback Impossible" en el inventario. 

SELECT f.title, COUNT(i.inventory_id) AS number_of_copies
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
GROUP BY f.title
HAVING title LIKE 'Hunchback Impossible';

-- 2. Lista de todos los fil que duran mas que el promedio de los films de la base de datos

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Subquery:todos los actores de "Alone Trip".

SELECT a.first_name, a.last_name, f.title
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN film AS f
ON fa.film_id = f.film_id
WHERE f.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');


