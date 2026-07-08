USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT * FROM inventory;
SELECT * FROM film;

-- step 1
SELECT film_id
FROM film
WHERE title = "Hunchback Impossible";

-- step 2
SELECT COUNT(*)
FROM inventory
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = "Hunchback Impossible");

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database
-- step 1
SELECT AVG(length) AS avg_duration
FROM film;
-- step 2
SELECT title 
FROM film
WHERE length > (
SELECT AVG(length)
FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip"
-- step 1
SELECT film_id
FROM film
WHERE title = "Alone Trip";
-- step 2
SELECT actor_id
FROM film_actor
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = "Alone Trip");
-- step 3
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
SELECT actor_id
FROM film_actor
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = "Alone Trip"));





