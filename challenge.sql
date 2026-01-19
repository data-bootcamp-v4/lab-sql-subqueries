USE Sakila;

-- Challenges:


-- 1. number of copies of the film "Hunchback Impossible" that exist in the inventory system

SELECT film_id, title 
FROM film 
WHERE title = 'Hunchback Impossible';

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

SELECT f.title, COUNT(i.inventory_id) AS number_of_copies
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database

SELECT AVG(length) AS avg_length FROM film;


SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;



-- 3. Use a subquery to display all actors who appear in the film "Alone Trip"

SELECT film_id FROM film WHERE title = 'Alone Trip';

-- STEP 2: Find actors using film_actor table
SELECT actor_id 
FROM film_actor 
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');

-- STEP 3 (FINAL): Get actor names from actor table
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (SELECT fa.actor_id 
    FROM film_actor fa 
    WHERE fa.film_id = (SELECT film_id 
        FROM film 
        WHERE title = 'Alone Trip'))
ORDER BY a.last_name, a.first_name;

