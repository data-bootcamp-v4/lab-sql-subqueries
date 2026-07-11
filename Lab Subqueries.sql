USE sakila; 

# Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT * FROM inventory; 
SELECT * FROM film; 

SELECT inv.film_id, f.title, COUNT(inv.inventory_id) number_of_copies 
FROM inventory as inv 
JOIN film as f 
ON inv.film_id = f.film_id 
WHERE f.title IN ("Hunchback Impossible")  
GROUP BY inv.film_id 
; 

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT * FROM inventory; 
SELECT * FROM film; 

SELECT film_id, title, length, (SELECT AVG(length) FROM film) as average_length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
; 

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip". 
SELECT * FROM actor; 
SELECT * FROM film;

SELECT fa.actor_id, CONCAT(a.first_name, " ", a.last_name) as actor, fa.film_id 
FROM film_actor as fa
JOIN actor as a
ON a.actor_id = fa.actor_id
WHERE fa.film_id IN (
	SELECT film_id
    FROM film 
    WHERE title IN ("Alone Trip")
)
; 
