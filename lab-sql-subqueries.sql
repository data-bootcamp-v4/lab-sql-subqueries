-- ===============================================================================================================
-- SOLVED CHALLENGE
-- ===============================================================================================================
USE sakila;
-- ===============================================================================================================
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- using join ----------------------------------------------------------------------------------
SELECT 
    film.film_id, -- film_id from film table
    film.title, -- title from film table
    COUNT(*) AS nbr_copies
FROM inventory
JOIN film ON inventory.film_id = film.film_id -- film and inventory tables share film_id column
WHERE film.title = 'Hunchback Impossible' -- condition title = 'Hunchback Impossible'
GROUP BY film.film_id, film.title;
-- using a subquery -------------------------------------------------------------------
SELECT 
    film.film_id,
    film.title,
    COUNT(*) AS nbr_copies
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.film_id = ( -- subquery
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
)
GROUP BY film.film_id, film.title;
-- ===============================================================================================================
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT
    film_id,
    title,
    length
FROM film
WHERE length > ( -- subquery
    SELECT AVG(length) 
    FROM film
) 
ORDER BY length DESC;
-- ===============================================================================================================
-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
    first_name,
    last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = ( -- subquery
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
)
ORDER BY last_name, first_name;
-- ===============================================================================================================
-- ===============================================================================================================
-- SOLVED BONUS
-- ===============================================================================================================
-- ===============================================================================================================
-- 


