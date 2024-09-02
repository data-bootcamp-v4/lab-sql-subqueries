USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS number_of_copies
FROM sakila.inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

 -- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
 SELECT title, length
 FROM sakila.film
 WHERE length > (SELECT AVG(length) FROM film)
 ORDER BY length;
 
 -- Use a subquery to display all actors who appear in the film "Alone Trip".
 SELECT a.first_name, a.last_name
 FROM sakila.actor a
 WHERE a.actor_id IN (
 SELECT 
            fa.actor_id 
        FROM 
            film_actor fa
        JOIN 
            film f ON fa.film_id = f.film_id
        WHERE 
            f.title = 'Alone Trip' )
ORDER BY
a.last_name, a.first_name;