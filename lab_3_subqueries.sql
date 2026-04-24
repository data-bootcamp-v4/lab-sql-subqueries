-- SQL Subqueries
-- Dataset: Sakila database
-- Author: Bryan Calderon

USE sakila;
-- 1. Number of copies of "Hunchback Impossible" in inventory
SELECT * FROM inventory;
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film
    WHERE title = 'Hunchback Impossible');

-- 2. Films longer than the average film length
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- 3. Actors who appear in "Alone Trip"
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor
    WHERE film_id = (SELECT film_id FROM film
        WHERE title = 'Alone Trip'));

-- BONUS 1. Task 4 Sales have been lagging among young families.
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'))
ORDER BY title;

## THe other Bonus for the next time haha! 