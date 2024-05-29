USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT * FROM sakila.film
WHERE title = "Hunchback Impossible";

SELECT film_id FROM (
SELECT * FROM sakila.film
WHERE title = "Hunchback Impossible") AS f;

SELECT COUNT(inventory_id) AS Number_of_copies FROM sakila.inventory 
WHERE film_id IN (SELECT film_id FROM (
SELECT * FROM sakila.film
WHERE title = "Hunchback Impossible") AS f);

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT ROUND(AVG(length),2) as Average_length FROM sakila.film;

SELECT title, length FROM sakila.film
WHERE length >  (SELECT AVG(length) as Average_length FROM sakila.film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT * FROM sakila.film
WHERE title = "Alone Trip";

SELECT film_id FROM (
SELECT * FROM sakila.film
WHERE title = "Alone Trip") as f;

SELECT actor_id FROM sakila.film_actor
WHERE film_id IN (SELECT film_id FROM (
SELECT * FROM sakila.film
WHERE title = "Alone Trip") as f);

SELECT CONCAT(first_name, " ", last_name) as Actor_names FROM sakila.actor
WHERE actor_id IN (SELECT actor_id FROM sakila.film_actor
WHERE film_id IN (SELECT film_id FROM (
SELECT * FROM sakila.film
WHERE title = "Alone Trip") as f));