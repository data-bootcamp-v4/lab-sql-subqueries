-- Week04 Lab05
-- LAB | SQL Subqueries
USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT fi.title AS film, COUNT(inv.film_id) AS inventory_count 
FROM sakila.film AS fi
JOIN sakila.inventory AS inv
ON fi.film_id = inv.film_id
WHERE fi.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title AS film FROM sakila.film AS fi
WHERE fi.length > (SELECT AVG(length) FROM sakila.film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT ac.first_name AS first_name, ac.last_name AS last_name, 
(SELECT fi.title FROM sakila.film AS fi WHERE fi.film_id = fa.film_id AND fi.title = 'Alone Trip') AS film 
FROM sakila.actor AS ac
JOIN sakila.film_actor AS fa
ON ac.actor_id = fa.actor_id
JOIN sakila.film AS fi
ON fa.film_id = fi.film_id
WHERE fi.title = 'Alone Trip';
