-- LAB | SQL Subqueries
USE sakila;

-- Challenge - Joining on multiple tables

-- 1
SELECT COUNT(inventory_id) AS number_of_copies  FROM sakila.inventory
WHERE film_id = (SELECT film_id FROM sakila.film WHERE title ="Hunchback Impossible");

-- 2
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) as average FROM film);

-- 3
SELECT first_name, last_name FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = "Alone Trip"));