-- Lab SQL Subqueries

USE sakila;

-- 1. Number of copies of the film "Hunchback Impossible" in the inventory
SELECT COUNT(*)
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

-- 2. Films longer than the average length of all films
SELECT title, length
FROM film
WHERE length > 115;

-- 3. Actors who appear in the film "Alone Trip"
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');
