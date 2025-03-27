-- Welcome to the SQL Subqueries lab!
-- Challenge, Write SQL queries to perform the following tasks using the Sakila database:

use sakila;

-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
    
SELECT COUNT(*) AS total_films
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
    f.title, 
    f.length
FROM 
    film f
WHERE 
    f.length > (SELECT AVG(length) FROM film);
    
-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".    
    
SELECT 
    a.first_name, 
    a.last_name
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
WHERE 
    fa.film_id = (SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip');
    
    
