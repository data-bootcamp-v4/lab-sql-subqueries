USE sakila;

-- SQL Subqueries
SELECT 
    COUNT(i.inventory_id) AS number_of_copies
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Hunchback Impossible';
    
-- 2 
SELECT 
    f.title, 
    f.length
FROM 
    film f
WHERE 
    f.length > (SELECT AVG(f2.length) FROM film f2);

-- 3
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    INNER JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);

    
